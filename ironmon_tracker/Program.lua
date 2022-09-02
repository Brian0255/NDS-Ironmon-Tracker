local function Program(initialTracker, initialMemoryAddresses, initialGameInfo, initialSettings)
	local self = {}
	local FrameCounter = dofile("ironmon_tracker/FrameCounter.lua")
	local UIRoot = "ironmon_tracker/ui/"
	local MainScreen = dofile("ironmon_tracker/ui/MainScreen.lua")
	local MainOptionsScreen = dofile(UIRoot .. "MainOptionsScreen.lua")
	local BattleOptionsScreen = dofile(UIRoot .. "BattleOptionsScreen.lua")
	local AppearanceOptionsScreen = dofile(UIRoot .. "AppearanceOptionsScreen.lua")
	local BadgesAppearanceScreen = dofile(UIRoot .. "BadgesAppearanceScreen.lua")
	local PokemonDataReader = dofile("ironmon_tracker/PokemonDataReader.lua")
	local JoypadEventListener = dofile("ironmon_tracker/ui/UIBaseClasses/JoypadEventListener.lua")
	self.SELECTED_PLAYERS = {
		PLAYER = 0,
		ENEMY = 1
	}
	self.BATTLE_STATUS_TYPES = {
		[0x2100] = true,
		[0x2101] = true,
		[0x2800] = false
	}

	local battleDataFetched = false
	local inBattle = false
	local selectedPlayer = self.SELECTED_PLAYERS.PLAYER
	local healingItems = nil
	local playerPokemon = nil
	local enemyPokemon = nil
	local tracker = initialTracker
	local memoryAddresses = initialMemoryAddresses
	local pokemonDataReader
	local gameInfo = initialGameInfo
	local settings = initialSettings
	local playerBattleTeamPIDs = {}
	local enemyBattleTeamPIDs = {}
	local playerMonIndex = 0
	local enemyMonIndex = 0
	local lastValidPlayerBattlePID = -1
	local lastValidEnemyBattlePID = -1
	local GEN5_activePlayerMonPID = 0
	local GEN5_activeEnemyMonPID = 0
	local firstBattleComplete = false

		
	function self.getGameInfo()
		return gameInfo
	end

	function self.getAddresses()
		return memoryAddresses
	end

	self.UI_SCREENS = {
		MAIN_SCREEN = 0,
		MAIN_OPTIONS_SCREEN = 1,
		BATTLE_OPTIONS_SCREEN = 2,
		APPEARANCE_OPTIONS_SCREEN = 3,
		BADGES_APPEARANCE_SCREEN = 4,
	}
	self.UI_SCREEN_OBJECTS = {
		[self.UI_SCREENS.MAIN_SCREEN] = MainScreen(settings, tracker, self),
		[self.UI_SCREENS.MAIN_OPTIONS_SCREEN] = MainOptionsScreen(settings, tracker, self),
		[self.UI_SCREENS.BATTLE_OPTIONS_SCREEN] = BattleOptionsScreen(settings, tracker, self),
		[self.UI_SCREENS.APPEARANCE_OPTIONS_SCREEN] = AppearanceOptionsScreen(settings, tracker, self),
		[self.UI_SCREENS.BADGES_APPEARANCE_SCREEN] = BadgesAppearanceScreen(settings, tracker, self),
	}

	local currentScreens = { [self.UI_SCREENS.MAIN_SCREEN] = self.UI_SCREEN_OBJECTS[self.UI_SCREENS.MAIN_SCREEN] }

	local function tryToFetchBattleData()
		local firstPlayerPID = Memory.read_u32_le(memoryAddresses.playerBattleBase)
		local firstEnemyPID = Memory.read_u32_le(memoryAddresses.enemyBase)
		if firstPlayerPID == 0 or firstEnemyPID == 0 then
			return false
		end

		local currentBase = memoryAddresses.playerBattleBase

		for i = 0, 5, 1 do
			local pid = Memory.read_u32_le(currentBase)
			if pid ~= 0 then
				playerBattleTeamPIDs[pid] = i
			end
			currentBase = currentBase + gameInfo.ENCRYPTED_POKEMON_SIZE
		end

		currentBase = memoryAddresses.enemyBase
		for i = 0, 5, 1 do
			local pid = Memory.read_u32_le(currentBase)
			if pid ~= 0 then
				enemyBattleTeamPIDs[pid] = i
			end
			currentBase = currentBase + gameInfo.ENCRYPTED_POKEMON_SIZE
		end

		return true
	end

	local function addAddtitionalDataToPokemon(pokemon)
		local constData = PokemonData.POKEMON[pokemon.pokemonID + 1]
		for key, data in pairs(constData) do
			if key == "movelvls" then
				pokemon[key] = data[gameInfo.VERSION_GROUP]
			else
				pokemon[key] = data
			end
		end
	end

	local function scanItemsForHeals()
		healingItems = {}

		local itemStart = MiscUtils.inlineIf(inBattle, memoryAddresses.itemStartBattle, memoryAddresses.itemStartNoBattle)

		--battle can be set a few frames before item bag for battle gets updated, need to check this value as well
		local idAndQuantity = Memory.read_u32_le(memoryAddresses.itemStartBattle)
		local id = bit.band(idAndQuantity, 0xFFFF)
		local quantity = bit.band(bit.rshift(idAndQuantity, 16), 0xFFFF)
		if quantity > 1000 or id > 600 then
			itemStart = memoryAddresses.itemStartNoBattle
		end
		local addressesToScan = { itemStart, memoryAddresses.berryBagStart }
		for _, address in pairs(addressesToScan) do
			local currentAddress = address
			local keepScanning = true
			while keepScanning do
				--read 4 bytes at once, should be less expensive than reading 2 sets of 2 bytes..
				idAndQuantity = Memory.read_u32_le(currentAddress)
				id = bit.band(idAndQuantity, 0xFFFF)
				if id ~= 0 then
					quantity = bit.band(bit.rshift(idAndQuantity, 16), 0xFFFF)
					healingItems[id] = quantity
					currentAddress = currentAddress + 4
				else
					keepScanning = false
				end
			end
		end
		return healingItems
	end

	local function calculateHealPercent(totals, maxHP)
		for id, quantity in pairs(healingItems) do
			local item = ItemData.HEALING_ITEMS[id]
			if item ~= nil then
				local healing = 0
				if item.type == ItemData.HEALING_TYPE.CONSTANT then
					local percentage = item.amount / maxHP * 100
					if percentage > 100 then
						percentage = 100
					end
					healing = percentage * quantity
				elseif item.type == ItemData.HEALING_TYPE.PERCENTAGE then
					healing = item.amount * quantity
				end
				-- Healing is in a percentage compared to the mon's max HP
				totals.healing = totals.healing + healing
				totals.numHeals = totals.numHeals + quantity
			end
		end
		totals.healing = math.floor(totals.healing + 0.5)
		return totals
	end

	local function getHealingItems()
		if selectedPlayer == self.SELECTED_PLAYERS.PLAYER then
			local totals = {
				healing = 0,
				numHeals = 0
			}
			-- Need a null check before getting maxHP
			if playerPokemon == nil then
				return totals
			end

			local maxHP = playerPokemon["HP"]
			if maxHP == 0 then
				return totals
			end

			healingItems = scanItemsForHeals()

			if healingItems ~= nil then
				totals = calculateHealPercent(totals, maxHP)
			end

			return totals
		end
		return nil
	end

	local function updateBagHealingItems()
		return getHealingItems()
	end

	local function updateStatStages()
		if inBattle and battleDataFetched then
			if gameInfo.gen == 5 then
				pokemonDataReader.setCurrentBase(memoryAddresses.statStagesStart)
			else
				if selectedPlayer == self.SELECTED_PLAYERS.ENEMY then
					pokemonDataReader.setCurrentBase(memoryAddresses.statStagesEnemy)
				else
					pokemonDataReader.setCurrentBase(memoryAddresses.statStagesPlayer)
				end
			end
			if enemyPokemon ~= nil and playerPokemon ~= nil then
				enemyPokemon.statStages = pokemonDataReader.readBattleStatStages(true, enemyMonIndex)
				playerPokemon.statStages = pokemonDataReader.readBattleStatStages(false, playerMonIndex)
			end
		end
	end

	local function getPlayerBattleMonPID()
		local activePID = Memory.read_u32_le(memoryAddresses.playerBattleMonPID)
		if gameInfo.gen == 5 then
			activePID = GEN5_activePlayerMonPID
		end
		if activePID == 0 then
			return Memory.read_u32_le(memoryAddresses.playerBattleBase)
		else
			return activePID
		end
	end

	local function getEnemyBattleMonPID()
		local activePID = Memory.read_u32_le(memoryAddresses.enemyBattleMonPID)
		if gameInfo.gen == 5 then
			activePID = GEN5_activeEnemyMonPID
		end
		if activePID == 0 then
			return Memory.read_u32_le(memoryAddresses.enemyBase)
		else
			return activePID
		end
	end

	local function checkForPlayerTransform()
		local activePID = getPlayerBattleMonPID()
		if enemyBattleTeamPIDs[activePID] ~= nil then
			return true
		end
		return false
	end

	local function checkForEnemyTransform()
		local activePID = getEnemyBattleMonPID()
		if playerBattleTeamPIDs[activePID] ~= nil then
			return true
		end
		return false
	end

	local function getPokemonDataPlayer()
		if inBattle and battleDataFetched then
			local currentBase = memoryAddresses.playerBattleBase
			local activePID
			local transformed = checkForPlayerTransform()
			if transformed then
				activePID = lastValidPlayerBattlePID
			else
				activePID = getPlayerBattleMonPID()
				lastValidPlayerBattlePID = activePID
			end
			local monIndex = playerBattleTeamPIDs[activePID]
			if monIndex ~= nil then
				playerMonIndex = monIndex
				pokemonDataReader.setCurrentBase(currentBase + monIndex * gameInfo.ENCRYPTED_POKEMON_SIZE)
				return pokemonDataReader.decryptPokemonInfo(false, monIndex, false)
			end
		else
			pokemonDataReader.setCurrentBase(memoryAddresses.playerBase)
			local data = pokemonDataReader.decryptPokemonInfo(true, 0, false)
			return data
		end
	end

	local function getPokemonDataEnemy()
		if inBattle then
			local activePID
			local transformed = checkForEnemyTransform()
			if transformed then
				activePID = lastValidEnemyBattlePID
			else
				activePID = getEnemyBattleMonPID()
				lastValidEnemyBattlePID = activePID
			end
			local currentPID
			local lastMatchedAddress = 0
			local lastMatchedIndex = 0
			local currentBase = memoryAddresses.enemyBase
			for i = 0, 5, 1 do
				pokemonDataReader.setCurrentBase(currentBase)
				currentPID = Memory.read_u32_le(currentBase)
				if currentPID == activePID then
					--trainers can have multiple pokes with same PID, need to find first one that is alive
					lastMatchedAddress = currentBase
					lastMatchedIndex = i
					enemyMonIndex = i
					local data = pokemonDataReader.decryptPokemonInfo(false, i, true)

					if data ~= nil then
						if next(data) ~= nil then
							if data.curHP > 0 then
								return data
							end
						end
					else
						return nil
					end
				end
				currentBase = currentBase + gameInfo.ENCRYPTED_POKEMON_SIZE
			end
			if lastMatchedAddress ~= 0 then
				--We found a match but all the enemy's pokemon have fainted, so just use the last match.
				enemyMonIndex = 0
				pokemonDataReader.setCurrentBase(lastMatchedAddress)
				return pokemonDataReader.decryptPokemonInfo(false, lastMatchedIndex, true)
			else
				return nil
			end
		end
	end

	local function validPokemonData(pokemonData)
		if pokemonData == nil or next(pokemonData) == nil then
			return false
		end
		--Sometimes the player's pokemon stats are just wildly out of bounds, need a sanity check.
		local STAT_LIMIT = 2000
		local statsToCheck = {
			pokemonData.curHP,
			pokemonData.maxHP,
			pokemonData.atk,
			pokemonData.spe,
			pokemonData.def,
			pokemonData.spd,
			pokemonData.spa
		}
		for _, stat in pairs(statsToCheck) do
			if stat > STAT_LIMIT or pokemonData.level > 100 then
				return false
			end
		end
		local id = tonumber(pokemonData.pokemonID)
		local heldItem = tonumber(pokemonData.heldItem)
		if id ~= nil then
			if id < 0 or id > PokemonData.TOTAL_POKEMON + 1 or heldItem < 0 or heldItem > 650 then
				return false
			end
			for _, move in pairs(pokemonData.moveIDs) do
				if move < 0 or move > MoveData.TOTAL_MOVES + 1 then
					return false
				end
			end
			return true
		end
	end

	local function checkForAlternateForm(pokemon)
		pokemon.alternateForm = bit.band(pokemon.alternateForm, 0xF8)
		local form = pokemon.alternateForm
		if form ~= 0x00 then
			local alternateFormindex = form / 0x08
			local data = PokemonData[pokemon.pokemonID + 1]
			pokemon["baseFormName"] = data.name
			if PokemonData.ALTERNATE_FORMS[data.name] then
				local formStartIndex = PokemonData.ALTERNATE_FORMS[data.name].index
				pokemon.pokemonID = formStartIndex + (alternateFormindex - 2)
			end
		end
	end

	local function GEN5_checkLastSwitchin()
		--In gen 5, there is no active battler PID.
		--Instead, a memory address is updated with the next active mon's PID on switch-in
		--This is for both player/enemy pokemon, they share the same address.
		--So what we do is check this address. If the PID belongs to player/enemy, update accordingly.

		local lastSwitchAddr = memoryAddresses.playerBattleMonPID

		local lastSwitchPID = Memory.read_u32_le(lastSwitchAddr)
		if lastSwitchPID == 0 then
			for PID, index in pairs(playerBattleTeamPIDs) do
				if index == 0 then
					GEN5_activePlayerMonPID = PID
					break
				end
			end
			for PID, index in pairs(enemyBattleTeamPIDs) do
				if index == 0 then
					GEN5_activeEnemyMonPID = PID
					break
				end
			end
		else
			if playerBattleTeamPIDs[lastSwitchPID] then
				GEN5_activePlayerMonPID = lastSwitchPID
			elseif enemyBattleTeamPIDs[lastSwitchPID] then
				GEN5_activeEnemyMonPID = lastSwitchPID
			end
		end
	end

	local function checkEnemyPP()
		if inBattle and selectedPlayer == self.SELECTED_PLAYERS.ENEMY then
			if enemyPokemon ~= nil then
				for i, moveID in pairs(enemyPokemon.moveIDs) do
					local data = MoveData.MOVES[moveID + 1]
					local currentPP = enemyPokemon.movePPs[i]
					local maxPP = data.pp
					if data.id ~= "---" then
						if currentPP < tonumber(maxPP) then
							tracker.trackMove(enemyPokemon.pokemonID, moveID, enemyPokemon.level)
						end
					end
				end
			end
		end
	end

	local function getPokemonData()
		if gameInfo.gen == 5 then
			GEN5_checkLastSwitchin()
		end
		if selectedPlayer == self.SELECTED_PLAYERS.PLAYER then
			return getPokemonDataPlayer()
		else
			return getPokemonDataEnemy()
		end
	end

	local function updateEnemyPokemonData()
		if inBattle then
			local pokemontarget = getPokemonData()
			if validPokemonData(pokemontarget) then
				enemyPokemon = pokemontarget
				checkForAlternateForm(enemyPokemon)
			else
				enemyPokemon = nil
			end
			if enemyPokemon ~= nil then
				if enemyPokemon.pokemonID ~= nil then
					enemyPokemon.moves = tracker.getMoves(enemyPokemon.pokemonID)
					enemyPokemon.abilities = tracker.getAbilities(enemyPokemon.pokemonID)
				end
			end
		else
			enemyPokemon = nil
		end
	end

	local function updatePlayerPokemonData()
		local pokemonToCheck = getPokemonData()
		if validPokemonData(pokemonToCheck) then
			playerPokemon = pokemonToCheck
			checkForAlternateForm(playerPokemon)
		end
	end

	local function readMemory()
		if currentScreens[self.UI_SCREENS.MAIN_SCREEN] then
			self.readBadgeMemory()
			local battleStatus = Memory.read_u16_le(memoryAddresses.battleStatus)
			if self.BATTLE_STATUS_TYPES[battleStatus] ~= nil then
				if self.BATTLE_STATUS_TYPES[battleStatus] == true then
					if not inBattle then
						--Just started battle.
						inBattle = true
						battleDataFetched = false
						playerBattleTeamPIDs = {}
						enemyBattleTeamPIDs = {}
						battleDataFetched = tryToFetchBattleData()
					else
						if not battleDataFetched then
							battleDataFetched = tryToFetchBattleData()
						end
					end
				else
					if inBattle then
						firstBattleComplete = true
					end
					inBattle = false
					selectedPlayer = self.SELECTED_PLAYERS.PLAYER
				end
				local canUpdate =
				not (settings.battle.SHOW_1ST_FIGHT_STATS_IN_PLATINUM and firstBattleComplete == false and
					gameInfo.NAME == "Pokemon Platinum")
				local healingTotals = nil
				if canUpdate then
					updatePlayerPokemonData()
					updateEnemyPokemonData()
					healingTotals = updateBagHealingItems()
					checkEnemyPP()
					updateStatStages()
				end
				local pokemonToDraw = playerPokemon
				local opposingPokemon = enemyPokemon
				if selectedPlayer == self.SELECTED_PLAYERS.ENEMY then
					pokemonToDraw = enemyPokemon
					opposingPokemon = playerPokemon
				end
				if pokemonToDraw ~= nil then
					addAddtitionalDataToPokemon(pokemonToDraw)
					pokemonToDraw.owner = selectedPlayer
					currentScreens[self.UI_SCREENS.MAIN_SCREEN].setPokemon(pokemonToDraw, opposingPokemon, healingTotals)
					self.drawCurrentScreens()
				end
			end
		end
	end

	local function switchPokemonView()
		if inBattle and battleDataFetched then
			if selectedPlayer == self.SELECTED_PLAYERS.PLAYER then
				selectedPlayer = self.SELECTED_PLAYERS.ENEMY
			else
				selectedPlayer = self.SELECTED_PLAYERS.PLAYER
			end
			readMemory()
			self.drawCurrentScreens()
		end
	end

	local function refreshPointers()
		local info = GameConfigurator.initializeMemoryAddresses()
		gameInfo = info.gameInfo
		memoryAddresses = info.memoryAddresses
	end

	local eventListeners = {
		JoypadEventListener(settings.controls, "CHANGE_VIEW", switchPokemonView)
	}

	function self.setCurrentScreens(newScreens)
		currentScreens = {}
		for _, screen in pairs(newScreens) do
			currentScreens[screen] = self.UI_SCREEN_OBJECTS[screen]
		end
	end

	function self.drawCurrentScreens()
		for _, screen in pairs(currentScreens) do
			screen.show()
		end
	end

	function self.isInBattle()
		return inBattle
	end

	local function readBadgeByte(address)
		local badgeByte = Memory.read_u8(address)
		local badges = {0,0,0,0,0,0,0,0}
		for i = 1,8,1 do
			badges[i] = BitUtils.getBits(badgeByte, i - 1, 1)
		end
		return badges
	end

	function self.readBadgeMemory()
		local badges = tracker.getBadges()
		if gameInfo.GEN == 4 then
			badges.firstSet = readBadgeByte(memoryAddresses.johtoBadges)
			badges.secondSet = readBadgeByte(memoryAddresses.kantoBadges)
		else
			badges.firstSet = readBadgeByte(memoryAddresses.badges)
		end
		currentScreens[self.UI_SCREENS.MAIN_SCREEN].updateBadges(badges)
	end

	local function flushSaveRAM()
		client.saveram()
	end

	local function saveSettings()
		local INI = dofile(Paths.FOLDERS.DATA_FOLDER .. "/Inifile.lua")
		INI.save("Settings.ini",settings)
	end

	local frameCounters = {
		settingsSaving = FrameCounter(60, saveSettings, nil),
		memoryReading = FrameCounter(30, readMemory, nil),
		trackerSaving = FrameCounter(600, tracker.save, nil),
		pointerRefreshing = FrameCounter(300, refreshPointers, nil),
		SaveRAMFlushing = FrameCounter(600, flushSaveRAM, nil),
	}

	function self.main()
		for _, eventListener in pairs(eventListeners) do
			eventListener.listen()
		end
		for _, frameCounter in pairs(frameCounters) do
			frameCounter.decrement()
		end
		for _, screen in pairs(currentScreens) do
			screen.runEventListeners()
		end
	end

	function self.onProgramExit()
		DrawingUtils.clearGUI()
		forms.destroyall()
	end

	pokemonDataReader = PokemonDataReader(self)

	self.drawCurrentScreens()

	return self
end

return Program

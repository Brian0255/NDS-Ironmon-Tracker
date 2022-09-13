local function Program(initialTracker, initialMemoryAddresses, initialGameInfo, initialSettings)
	local self = {}
	local FrameCounter = dofile(Paths.FOLDERS.DATA_FOLDER .. "/FrameCounter.lua")
	local MainScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/MainScreen.lua")
	local MainOptionsScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/MainOptionsScreen.lua")
	local BattleOptionsScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/BattleOptionsScreen.lua")
	local AppearanceOptionsScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/AppearanceOptionsScreen.lua")
	local BadgesAppearanceScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/BadgesAppearanceScreen.lua")
	local ColorSchemeScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/ColorSchemeScreen.lua")
	local TrackedPokemonScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/TrackedPokemonScreen.lua")
	local QuickLoadScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/QuickLoadScreen.lua")
	local EditControlsScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/EditControlsScreen.lua")
	local PokemonDataReader = dofile(Paths.FOLDERS.DATA_FOLDER .. "/PokemonDataReader.lua")
	local JoypadEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/JoypadEventListener.lua")
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
	local badges = {
		firstSet = {0, 0, 0, 0, 0, 0, 0, 0},
		secondSet = {0, 0, 0, 0, 0, 0, 0, 0}
	}
	local runEvents = true
	local inBattle = false
	local locked = false
	local lockedPokemonCopy = nil
	local selectedPlayer = self.SELECTED_PLAYERS.PLAYER
	local healingItems = nil
	local inTrackedPokemonView = false
	local statusItems = nil
	local playerPokemon = nil
	local enemyPokemon = nil
	local activeColorPicker = nil
	local tracker = initialTracker
	local memoryAddresses = initialMemoryAddresses
	local pokemonDataReader
	local gameInfo = initialGameInfo
	local settings = initialSettings
	local playerBattleTeamPIDs = {list = {}}
	local enemyBattleTeamPIDs = {list = {}}
	local playerMonIndex = 0
	local enemyMonIndex = 0
	local lastValidPlayerBattlePID = -1
	local lastValidEnemyBattlePID = -1
	local lastValidEnemyPokemon = nil
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
		COLOR_SCHEME_SCREEN = 5,
		TRACKED_POKEMON_SCREEN = 6,
		EDIT_CONTROLS_SCREEN = 7,
		QUICK_LOAD_SCREEN = 8
	}
	self.UI_SCREEN_OBJECTS = {
		[self.UI_SCREENS.MAIN_SCREEN] = MainScreen(settings, tracker, self),
		[self.UI_SCREENS.MAIN_OPTIONS_SCREEN] = MainOptionsScreen(settings, tracker, self),
		[self.UI_SCREENS.BATTLE_OPTIONS_SCREEN] = BattleOptionsScreen(settings, tracker, self),
		[self.UI_SCREENS.APPEARANCE_OPTIONS_SCREEN] = AppearanceOptionsScreen(settings, tracker, self),
		[self.UI_SCREENS.BADGES_APPEARANCE_SCREEN] = BadgesAppearanceScreen(settings, tracker, self),
		[self.UI_SCREENS.COLOR_SCHEME_SCREEN] = ColorSchemeScreen(settings, tracker, self),
		[self.UI_SCREENS.TRACKED_POKEMON_SCREEN] = TrackedPokemonScreen(settings, tracker, self),
		[self.UI_SCREENS.EDIT_CONTROLS_SCREEN] = EditControlsScreen(settings, tracker, self),
		[self.UI_SCREENS.QUICK_LOAD_SCREEN] = QuickLoadScreen(settings, tracker, self)
	}

	local currentScreens = {[self.UI_SCREENS.MAIN_SCREEN] = self.UI_SCREEN_OBJECTS[self.UI_SCREENS.MAIN_SCREEN]}

	local function tryToFetchBattleData()
		local firstPlayerPartyPID = Memory.read_u32_le(memoryAddresses.playerBase)
		local firstPlayerPID = Memory.read_u32_le(memoryAddresses.playerBattleBase)
		local firstEnemyPID = Memory.read_u32_le(memoryAddresses.enemyBase)
		if firstPlayerPID == 0 or firstEnemyPID == 0 or firstPlayerPID ~= firstPlayerPartyPID then
			return false
		end

		local currentBase = memoryAddresses.playerBattleBase

		for i = 0, 5, 1 do
			local pid = Memory.read_u32_le(currentBase)
			if pid ~= 0 then
				--table.insert(playerBattleTeamPIDs.list,pid)
				playerBattleTeamPIDs[pid] = i
			else
				break
			end
			currentBase = currentBase + gameInfo.ENCRYPTED_POKEMON_SIZE
		end

		currentBase = memoryAddresses.enemyBase
		for i = 0, 5, 1 do
			local pid = Memory.read_u32_le(currentBase)
			if pid ~= 0 then
				if enemyBattleTeamPIDs[pid] ~= nil and gameInfo.GEN == 4 then
					--annoying case to handle when trainer has 2 with the same PID, no fix for gen 5 yet (battle data structures different)
					if type(enemyBattleTeamPIDs[pid]) == "table" then
						table.insert(enemyBattleTeamPIDs[pid], i)
					else
						enemyBattleTeamPIDs[pid] = {enemyBattleTeamPIDs[pid], i}
					end
				else
					enemyBattleTeamPIDs[pid] = i
				end
			else
				break
			end
			currentBase = currentBase + gameInfo.ENCRYPTED_POKEMON_SIZE
		end

		return true
	end

	local function addAdditionalDataToPokemon(pokemon)
		local constData = PokemonData.POKEMON[pokemon.pokemonID + 1]
		for key, data in pairs(constData) do
			if key == "movelvls" then
				pokemon[key] = data[gameInfo.VERSION_GROUP]
			else
				pokemon[key] = data
			end
		end
	end

	local function scanForHealingItems()
		healingItems = {}
		statusItems = {}
		local itemStart = MiscUtils.inlineIf(inBattle, memoryAddresses.itemStartBattle, memoryAddresses.itemStartNoBattle)
		local berryStart = MiscUtils.inlineIf(inBattle, memoryAddresses.berryBagStartBattle, memoryAddresses.berryBagStart)

		--battle can be set a few frames before item bag for battle gets updated, need to check this value as well
		local idAndQuantity = Memory.read_u32_le(memoryAddresses.itemStartBattle)
		local id = bit.band(idAndQuantity, 0xFFFF)
		local quantity = bit.band(bit.rshift(idAndQuantity, 16), 0xFFFF)
		if quantity > 1000 or id > 600 then
			itemStart = memoryAddresses.itemStartNoBattle
			berryStart = memoryAddresses.berryBagStart
		end
		local addressesToScan = {itemStart, berryStart}
		for _, address in pairs(addressesToScan) do
			local currentAddress = address
			local keepScanning = true
			while keepScanning do
				--read 4 bytes at once, should be less expensive than reading 2 sets of 2 bytes..
				idAndQuantity = Memory.read_u32_le(currentAddress)
				id = bit.band(idAndQuantity, 0xFFFF)
				if id ~= 0 then
					quantity = bit.band(bit.rshift(idAndQuantity, 16), 0xFFFF)
					--memory.write_u16_le(currentAddress+0x02,10)
					if ItemData.HEALING_ITEMS[id] ~= nil then
						healingItems[id] = quantity
					end
					if ItemData.STATUS_ITEMS[id] ~= nil then
						statusItems[id] = quantity
					end
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

	local function updateStatStages()
		if inBattle and battleDataFetched then
			if gameInfo.GEN == 5 then
				pokemonDataReader.setCurrentBase(memoryAddresses.statStagesStart)
			else
				if selectedPlayer == self.SELECTED_PLAYERS.ENEMY then
					pokemonDataReader.setCurrentBase(memoryAddresses.statStagesEnemy)
				else
					pokemonDataReader.setCurrentBase(memoryAddresses.statStagesPlayer)
				end
			end
			if enemyPokemon ~= nil and playerPokemon ~= nil then
				playerPokemon.statStages = pokemonDataReader.readBattleStatStages(false, playerMonIndex)
				enemyPokemon.statStages = pokemonDataReader.readBattleStatStages(true, enemyMonIndex)
			end
		end
	end

	local function getPlayerBattleMonPID()
		local activePID = Memory.read_u32_le(memoryAddresses.playerBattleMonPID)
		if gameInfo.GEN == 5 then
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
		if gameInfo.GEN == 5 then
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

	local function checkForAlternateForm(pokemon)
		pokemon.alternateForm = bit.band(pokemon.alternateForm, 0xF8)
		local form = pokemon.alternateForm
		if form ~= 0x00 then
			local alternateFormindex = form / 0x08
			local data = PokemonData.POKEMON[pokemon.pokemonID + 1]
			if data ~= nil then
				if PokemonData.ALTERNATE_FORMS[data.name] then
					local formTable = PokemonData.ALTERNATE_FORMS[data.name]
					pokemon["baseForm"] = {
						name = data.name,
						cosmetic = formTable.cosmetic
					}
					local formStartIndex = formTable.index
					local alternateFormID = formStartIndex + (alternateFormindex - 2)
					if not formTable.cosmetic then
						pokemon.pokemonID = alternateFormID
					end
					if selectedPlayer == self.SELECTED_PLAYERS.ENEMY then
						tracker.logPokemonAsAlternateForm(pokemon.pokemonID, pokemon.baseForm, pokemon.alternateForm)
					end
				end
			end
		end
	end

	local function validPokemonData(pokemonData)
		if pokemonData == nil or next(pokemonData) == nil or pokemonData.ability > 164 then
			return false
		end
		--Sometimes the player's pokemon stats are just wildly out of bounds, need a sanity check.
		local STAT_LIMIT = 2000
		local statsToCheck = {
			pokemonData.curHP,
			pokemonData.maxHP,
			pokemonData.ATK,
			pokemonData.SPE,
			pokemonData.DEF,
			pokemonData.SPD,
			pokemonData.SPA
		}
		for _, stat in pairs(statsToCheck) do
			if stat > STAT_LIMIT or pokemonData.level > 100 then
				return false
			end
		end
		local id = tonumber(pokemonData.pokemonID)
		local heldItem = tonumber(pokemonData.heldItem)
		if id ~= nil then
			if id < 0 or id > PokemonData.TOTAL_POKEMON + 200 or heldItem < 0 or heldItem > 650 then
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

	local function getPokemonDataEnemy()
		if inBattle then
			local currentBase = memoryAddresses.enemyBase
			local activePID
			local transformed = checkForEnemyTransform()
			if transformed then
				activePID = lastValidEnemyBattlePID
			else
				activePID = getEnemyBattleMonPID()
				if activePID ~= lastValidEnemyBattlePID and enemyPokemon ~= nil then
					tracker.updateLastLevelSeen(enemyPokemon.pokemonID, enemyPokemon.level)
				end
			end
			local pokemonData
			local monIndex = enemyBattleTeamPIDs[activePID]
			if type(monIndex) == "table" then
				for _, indexToCheck in pairs(monIndex) do
					pokemonDataReader.setCurrentBase(currentBase + indexToCheck * gameInfo.ENCRYPTED_POKEMON_SIZE)
					local testForID = pokemonDataReader.decryptPokemonInfo(false, monIndex, true)
					if validPokemonData(testForID) then
						if testForID.pokemonID == memory.read_u16_le(memoryAddresses.enemyPokemonID) then
							pokemonData = testForID
						end
					end
				end
			end
			if type(monIndex) == "table" then
				--failure grabbing ID somehow, failsafe
				monIndex = monIndex[1]
			end
			if monIndex ~= nil and pokemonData == nil then
				enemyMonIndex = monIndex
				pokemonDataReader.setCurrentBase(currentBase + monIndex * gameInfo.ENCRYPTED_POKEMON_SIZE)
				pokemonData = pokemonDataReader.decryptPokemonInfo(false, monIndex, true)
			end
			if validPokemonData(pokemonData) then
				checkForAlternateForm(pokemonData)
				lastValidEnemyPokemon = pokemonData
				if activePID ~= lastValidEnemyBattlePID then
					tracker.logNewEnemyPokemonInBattle(pokemonData.pokemonID)
					tracker.updateCurrentLevel(pokemonData.pokemonID, pokemonData.level)
				end
				lastValidEnemyBattlePID = activePID
				return pokemonData
			else
				return nil
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
		if inBattle and enemyPokemon ~= nil then
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

	local function getPokemonData(selected)
		if gameInfo.GEN == 5 then
			GEN5_checkLastSwitchin()
		end
		if selected == self.SELECTED_PLAYERS.PLAYER then
			return getPokemonDataPlayer()
		else
			return getPokemonDataEnemy()
		end
	end

	local function updateEnemyPokemonData()
		if inBattle then
			enemyPokemon = getPokemonData(self.SELECTED_PLAYERS.ENEMY)
			if enemyPokemon ~= nil then
				if enemyPokemon.pokemonID ~= nil then
					enemyPokemon.moves = tracker.getMoves(enemyPokemon.pokemonID)
				end
			end
		else
			enemyPokemon = nil
		end
	end

	local function updatePlayerPokemonData()
		local pokemonToCheck = getPokemonData(self.SELECTED_PLAYERS.PLAYER)
		if validPokemonData(pokemonToCheck) then
			playerPokemon = pokemonToCheck
			checkForAlternateForm(playerPokemon)
		end
	end

	local function getPokemonToDraw()
		local pokemonToDraw = playerPokemon
		local opposingPokemon = enemyPokemon
		if locked then
			opposingPokemon = lockedPokemonCopy
		end
		if selectedPlayer == self.SELECTED_PLAYERS.ENEMY then
			local temp = pokemonToDraw
			pokemonToDraw = opposingPokemon
			opposingPokemon = temp
		end
		return {["pokemonToDraw"] = pokemonToDraw, ["opposingPokemon"] = opposingPokemon}
	end

	local function setPokemonForMainScreen()
		local pokemonForDrawing = getPokemonToDraw()
		local pokemonToDraw = pokemonForDrawing.pokemonToDraw
		local opposingPokemon = pokemonForDrawing.opposingPokemon
		if pokemonToDraw ~= nil then
			addAdditionalDataToPokemon(pokemonToDraw)
			if opposingPokemon ~= nil then
				addAdditionalDataToPokemon(opposingPokemon)
			end
			pokemonToDraw.owner = selectedPlayer
			currentScreens[self.UI_SCREENS.MAIN_SCREEN].setPokemonToDraw(pokemonToDraw, opposingPokemon)
		end
	end

	local function refreshPointers()
		local info = GameConfigurator.initializeMemoryAddresses()
		gameInfo = info.gameInfo
		memoryAddresses = info.memoryAddresses
	end

	local function HGSS_checkLeagueDefeated()
		if gameInfo.NAME == "Pokemon HeartGold" or gameInfo.NAME == "Pokemon SoulSilver" then
			local leagueEvent = Memory.read_u8(memoryAddresses.leagueBeaten)
			--print(leagueEvent)
			currentScreens[self.UI_SCREENS.MAIN_SCREEN].setLanceDefeated(leagueEvent >= 3)
		end
	end

	local function readMemory()
		if currentScreens[self.UI_SCREENS.MAIN_SCREEN] then
			HGSS_checkLeagueDefeated()
			scanForHealingItems()
			self.readBadgeMemory()
			local battleStatus = Memory.read_u16_le(memoryAddresses.battleStatus)
			if self.BATTLE_STATUS_TYPES[battleStatus] == true then
				if not inBattle then
					--Just started battle.
					refreshPointers()
					lastValidEnemyBattlePID = -1
					lastValidPlayerBattlePID = -1
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
					if lastValidEnemyPokemon ~= nil then
						tracker.updateLastLevelSeen(lastValidEnemyPokemon.pokemonID, lastValidEnemyPokemon.level)
					end
				end
				inBattle = false
				if not locked then
					selectedPlayer = self.SELECTED_PLAYERS.PLAYER
				end
			end
			local canUpdate =
				not (settings.battle.SHOW_1ST_FIGHT_STATS_IN_PLATINUM and firstBattleComplete == false and
				gameInfo.NAME == "Pokemon Platinum")
			if canUpdate then
				updatePlayerPokemonData()
				updateEnemyPokemonData()
				checkEnemyPP()
				updateStatStages()
			end
			if not inTrackedPokemonView then
				setPokemonForMainScreen()
			end
		end
	end

	function self.putTrackedPokemonIntoView(id)
		selectedPlayer = self.SELECTED_PLAYERS.ENEMY
		local template = tracker.convertTrackedIDToPokemonTemplate(id)
		enemyPokemon = template
		setPokemonForMainScreen()
	end

	function self.getStatusItems()
		return statusItems
	end

	function self.getHealingItems()
		return healingItems
	end

	function self.getStatusTotals()
		local total = 0
		if statusItems ~= nil then
			for id, quantity in pairs(statusItems) do
				total = total + quantity
			end
		end
		return total
	end

	function self.getHealingTotals()
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

			if healingItems ~= nil then
				totals = calculateHealPercent(totals, maxHP)
			end

			return totals
		end
		return nil
	end

	function self.isLocked()
		return locked
	end

	local function switchPokemonView()
		if not inTrackedPokemonView then
			if (inBattle and battleDataFetched) or locked and lockedPokemonCopy ~= nil then
				if selectedPlayer == self.SELECTED_PLAYERS.PLAYER then
					selectedPlayer = self.SELECTED_PLAYERS.ENEMY
				else
					selectedPlayer = self.SELECTED_PLAYERS.PLAYER
				end
				if self.UI_SCREEN_OBJECTS[self.UI_SCREENS.MAIN_SCREEN] then
					self.UI_SCREEN_OBJECTS[self.UI_SCREENS.MAIN_SCREEN].resetHoverFrame()
					readMemory()
					self.drawCurrentScreens()
				end
			end
		end
	end

	local function lockEnemy()
		if inBattle and battleDataFetched and enemyPokemon ~= nil and next(enemyPokemon) ~= nil then
			locked = true
			lockedPokemonCopy = MiscUtils.deepCopy(enemyPokemon)
		end
	end

	local function unlockEnemy()
		locked = false
		lockedPokemonCopy = nil
		enemyPokemon = nil
		readMemory()
		self.drawCurrentScreens()
	end

	local function onLockButtonPress()
		if not locked then
			lockEnemy()
		else
			unlockEnemy()
		end
	end

	local eventListeners = {
		JoypadEventListener(settings.controls, "CHANGE_VIEW", switchPokemonView),
		JoypadEventListener(settings.controls, "LOCK_ENEMY", onLockButtonPress)
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
		local badgeSet = {0, 0, 0, 0, 0, 0, 0, 0}
		for i = 1, 8, 1 do
			badgeSet[i] = BitUtils.getBits(badgeByte, i - 1, 1)
		end
		return badgeSet
	end

	function self.readBadgeMemory()
		if gameInfo.NAME == "Pokemon HeartGold" or gameInfo.NAME == "Pokemon SoulSilver" then
			badges.firstSet = readBadgeByte(memoryAddresses.johtoBadges)
			badges.secondSet = readBadgeByte(memoryAddresses.kantoBadges)
		else
			badges.firstSet = readBadgeByte(memoryAddresses.badges)
		end
		currentScreens[self.UI_SCREENS.MAIN_SCREEN].updateBadges(badges)
	end

	local function saveSettings()
		local INI = dofile(Paths.FOLDERS.DATA_FOLDER .. "/Inifile.lua")
		INI.save("Settings.ini", settings)
	end

	local frameCounters = {
		settingsSaving = FrameCounter(120, saveSettings, nil, true),
		screenDrawing = FrameCounter(30, self.drawCurrentScreens, nil, true),
		memoryReading = FrameCounter(30, readMemory, nil, true),
		trackerSaving = FrameCounter(18000, function() tracker.save() client.saveram() end, nil, true),
		pointerRefreshing = FrameCounter(300, refreshPointers, nil, true)
	}

	function self.pauseEventListeners()
		runEvents = false
	end

	function self.setColorPicker(newColorPicker)
		activeColorPicker = newColorPicker
		if activeColorPicker ~= nil then
			frameCounters["updateColorPickerInput"] = FrameCounter(3, activeColorPicker.handleInput, nil)
		else
			frameCounters["updateColorPickerInput"] = nil
		end
	end

	function self.setUpForTrackedPokemonView()
		locked = false
		inTrackedPokemonView = true
		currentScreens[self.UI_SCREENS.MAIN_SCREEN].setUpForTrackedPokemonView()
		currentScreens[self.UI_SCREENS.TRACKED_POKEMON_SCREEN].initialize()
	end

	function self.moveMainScreen(newPosition)
		currentScreens[self.UI_SCREENS.MAIN_SCREEN].moveMainScreen(newPosition)
	end

	function self.undoTrackedPokemonView()
		self.setCurrentScreens({self.UI_SCREENS.MAIN_SCREEN})
		inTrackedPokemonView = false
		selectedPlayer = self.SELECTED_PLAYERS.PLAYER
		currentScreens[self.UI_SCREENS.MAIN_SCREEN].undoTrackedPokemonView()
		readMemory()
	end

	function self.main()
		Input.updateMouse()
		Input.updateJoypad()
		if runEvents then
			for _, eventListener in pairs(eventListeners) do
				eventListener.listen()
			end

			for _, screen in pairs(currentScreens) do
				screen.runEventListeners()
			end
		end
		for _, frameCounter in pairs(frameCounters) do
			frameCounter.decrement()
		end
	end

	function self.onProgramExit()
		tracker.save()
		client.saveram()
		DrawingUtils.clearGUI()
		forms.destroyall()
	end

	pokemonDataReader = PokemonDataReader(self)
	playerPokemon = pokemonDataReader.getDefaultPokemon()
	setPokemonForMainScreen()
	self.drawCurrentScreens()

	return self
end

return Program

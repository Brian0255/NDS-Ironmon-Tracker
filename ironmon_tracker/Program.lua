local function Program(initialTracker, initialMemoryAddresses, initialGameInfo, initialSettings)
	local self = {}
	local FrameCounter = dofile("ironmon_tracker/FrameCounter.lua")
	local UIRoot = "ironmon_tracker/ui/"
	local MainScreen = dofile(UIRoot .. "MainScreen.lua")
	local PokemonDataReader = dofile("ironmon_tracker/PokemonDataReader.lua")
	self.SELECTED_PLAYERS = {
		PLAYER = 0,
		ENEMY = 1
	}
	self.BATTLE_STATUS_TYPES = {
		[0x2100] = true,
		[0x2101] = true,
		[0x2800] = false
	}
	self.UI_SCREENS = {
		MAIN_SCREEN = MainScreen
		--MAIN_OPTIONS = MainOptionsScreen,
		--COLOR_EDITING = ColorEditScreen,
	}
	self.UI_SCREEN_TO_NAME = {
		[self.UI_SCREENS.MAIN_SCREEN] = "Main screen"
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
	local currentScreen = self.UI_SCREENS.MAIN_SCREEN(settings,tracker)
	local currentScreenName = "Main screen"

	local function tryToFetchBattleData()
		local firstPlayerPID = memory.read_u32_le(memoryAddresses.playerBattleBase)
		local firstEnemyPID = memory.read_u32_le(memoryAddresses.enemyBase)
		if firstPlayerPID == 0 or firstEnemyPID == 0 then
			return false
		end

		local currentBase = memoryAddresses.playerBattleBase

		for i = 0, 5, 1 do
			local pid = memory.read_u32_le(currentBase)
			if pid ~= 0 then
				playerBattleTeamPIDs[pid] = i
			end
			currentBase = currentBase + gameInfo.pokemonDataSize
		end

		currentBase = memoryAddresses.enemyBase
		for i = 0, 5, 1 do
			local pid = memory.read_u32_le(currentBase)
			if pid ~= 0 then
				enemyBattleTeamPIDs[pid] = i
			end
			currentBase = currentBase + gameInfo.pokemonDataSize
		end

		return true
	end

	local function scanItemsForHeals()
		healingItems = {}

		local itemStart = MiscUtils.inlineIf(inBattle, memoryAddresses.itemStartBattle, memoryAddresses.itemStartNoBattle)

		--battle can be set a few frames before item bag for battle gets updated, need to check this value as well
		local idAndQuantity = memory.read_u32_le(memoryAddresses.itemStartBattle)
		local id = bit.band(idAndQuantity, 0xFFFF)
		local quantity = bit.band(bit.rshift(idAndQuantity, 16), 0xFFFF)
		if quantity > 1000 or id > 600 then
			itemStart = memoryAddresses.itemStartNoBattle
		end
		local addressesToScan = {itemStart,memoryAddresses.berryBagStart}
		for _, address in pairs(addressesToScan) do
			local currentAddress = address
			local keepScanning = true
			while keepScanning do
				--read 4 bytes at once, should be less expensive than reading 2 sets of 2 bytes..
				idAndQuantity = memory.read_u32_le(currentAddress)
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
					local percentage = ((item.amount / maxHP) * 100)
					if percentage > 100 then
						percentage = 100
					end
					healing = percentage * quantity
				elseif item.type == ItemData.HEALING_TYPE.CONSTANT then
					healing = item.amount * quantity
				end
				-- Healing is in a percentage compared to the mon's max HP
				totals.healing = totals.healing + healing
				totals.numHeals = totals.numHeals + quantity
			end
		end
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
	end

	local function updateBagHealingItems()
		healingItems = getHealingItems()
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
		local activePID = memory.read_u32_le(memoryAddresses.playerBattleMonPID)
		if gameInfo.gen == 5 then
			activePID = GEN5_activePlayerMonPID
		end
		if activePID == 0 then
			return memory.read_u32_le(memoryAddresses.playerBattleBase)
		else
			return activePID
		end
	end

	local function getEnemyBattleMonPID()
		local activePID = memory.read_u32_le(memoryAddresses.enemyBattleMonPID)
		if gameInfo.gen == 5 then
			activePID = GEN5_activeEnemyMonPID
		end
		if activePID == 0 then
			return memory.read_u32_le(memoryAddresses.enemyBase)
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
		if inBattle == 1 and battleDataFetched then
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
				pokemonDataReader.setCurrentBase(currentBase + monIndex * gameInfo.POKEMON_DATA_SIZE)
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
				currentPID = memory.read_u32_le(currentBase)
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
				currentBase = currentBase + gameInfo.pokemonDataSize
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
		if next(pokemonData) == nil then
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
			for _, move in pairs(pokemonData.moves) do
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

		local lastSwitchPID = memory.read_u32_le(lastSwitchAddr)
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
				for i, moveValue in pairs(enemyPokemon.actualMoves) do
					local data = MoveData[moveValue + 1]
					local currentPP = enemyPokemon.movePPs[i]
					local maxPP = data.pp
					if data.id ~= "---" then
						if currentPP < tonumber(maxPP) then
							tracker.trackMove(enemyPokemon.pokemonID, moveValue, enemyPokemon.level)
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
		if currentScreenName == "Main screen" then
			local battleStatus = memory.read_u16_le(memoryAddresses.battleStatus)
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
					not (settings.tracker.SHOW_1ST_FIGHT_STATS_IN_PLATINUM and firstBattleComplete == false and
					gameInfo.NAME == "Pokemon Platinum")
				if canUpdate then
					updatePlayerPokemonData()
					updateEnemyPokemonData()
					updateBagHealingItems()
					checkEnemyPP()
					updateStatStages()
				end
				currentScreen.setPokemon(playerPokemon)
				self.drawCurrentScreen()
			end
		end
	end

	local frameCounters = {
		FrameCounter(30, readMemory, nil),
		FrameCounter(300, tracker.save, nil)
	}

	function self.getGameInfo()
		return gameInfo
	end

	function self.getAddresses()
		return memoryAddresses
	end

	function self.changeScreen(newScreen)
		currentScreen = newScreen(settings,tracker)
	end

	function self.drawCurrentScreen()
		currentScreen.show()
	end

	function self.isInBattle()
		return inBattle
	end

	function self.main()
		for _, frameCounter in pairs(frameCounters) do
			frameCounter.decrement()
		end
		currentScreen.runEventListeners()
	end

	function self.onProgramExit()
		DrawingUtils.clearGUI()
		forms.destroyall()
	end
	
	pokemonDataReader = PokemonDataReader(self)

	return self
end

return Program

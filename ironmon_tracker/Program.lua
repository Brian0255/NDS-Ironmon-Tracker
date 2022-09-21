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
	local PokemonIconsScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/PokemonIconsScreen.lua")
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
	local enemyBattlers = {}
	local playerMonIndex = 0
	local enemyMonIndex = 0
	local enemySlotIndex = 1
	local lastValidPlayerBattlePID = -1
	local GEN5_activePlayerMonPIDAddr = nil
	local GEN5_PIDSwitchData = {}
	local firstBattleComplete = false
	local frameCounters

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
		QUICK_LOAD_SCREEN = 8,
		POKEMON_ICONS_SCREEN = 9
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
		[self.UI_SCREENS.QUICK_LOAD_SCREEN] = QuickLoadScreen(settings, tracker, self),
		[self.UI_SCREENS.POKEMON_ICONS_SCREEN] = PokemonIconsScreen(settings, tracker, self)
	}

	local currentScreens = {[self.UI_SCREENS.MAIN_SCREEN] = self.UI_SCREEN_OBJECTS[self.UI_SCREENS.MAIN_SCREEN]}

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

	local function isGen5AlternateDoubleBattle()
		if gameInfo.GEN ~= 5 then
			return false
		end
		--Basically checking for the types of double battles with 2 friendly trainers vs. 2 enemy trainers
		--compared to just you vs. 2 other enemy trainers
		return Memory.read_u16_le(memoryAddresses.playerBattleMonPID) == 0 and
			Memory.read_u16_le(memoryAddresses.enemyBattleMonPID) == 0
	end

	local function fetchEnemyData()
		local currentBase = memoryAddresses.enemyBase
		local currentEnemyIndex = 1
		local gen5AlternateDouble = isGen5AlternateDoubleBattle()
		local totalPlayerMons = Memory.read_u32_le(memoryAddresses.totalMonsParty)
		local doublesOffset = 0
		if gen5AlternateDouble then
			doublesOffset = 0x224 * totalPlayerMons
		end
		enemyBattlers[currentEnemyIndex] = {
			teamPIDs = {},
			addressBase = currentBase,
			activePIDAddress = currentBase,
			startIndex = 0,
			lastValidPID = -1,
			lastValidPokemon = nil,
			extraOffset = doublesOffset,
			transformed = false
		}
		if gameInfo.GEN == 4 then
			enemyBattlers[currentEnemyIndex].activePIDAddress = memoryAddresses.enemyBattleMonPID
		end
		local lookFor = memoryAddresses.enemyBattleMonPID + gameInfo.ACTIVE_PID_DIFFERENCE
		if gen5AlternateDouble then
			lookFor = lookFor + gameInfo.ACTIVE_PID_DIFFERENCE
		end
		for i = 0, 11, 1 do
			if i == 6 then
				if currentEnemyIndex ~= 2 or (gameInfo.GEN == 5 and currentEnemyIndex == 2) then
					currentBase = memoryAddresses.enemyBase + gameInfo.ENEMY_PARTY_OFFSET
					if gen5AlternateDouble then
						currentBase = currentBase + gameInfo.ENEMY_PARTY_OFFSET
					end
				else
					break
				end
			end
			local pid = Memory.read_u32_le(currentBase)
			if pid ~= 0 then
				pokemonDataReader.setCurrentBase(currentBase)
				local pokemonData = pokemonDataReader.decryptPokemonInfo(false, i, true)
				if validPokemonData(pokemonData) then
					if pid == Memory.read_u32_le(lookFor) then
						currentEnemyIndex = currentEnemyIndex + 1
						lookFor = lookFor + gameInfo.ACTIVE_PID_DIFFERENCE
						local previousTeam = enemyBattlers[currentEnemyIndex - 1]
						local total = 0
						total = total + #enemyBattlers
						if isGen5AlternateDoubleBattle() then
							total = total + Memory.read_u32_le(memoryAddresses.enemyBase + gameInfo.ENEMY_PARTY_OFFSET - 0x04)
							total = total * 2
							total = total + totalPlayerMons
						end
						local activePID = memoryAddresses.enemyBattleMonPID + (currentEnemyIndex - 1) * 0x180
						if gameInfo.GEN == 5 then
							activePID = currentBase
						end
						enemyBattlers[currentEnemyIndex] = {
							teamPIDs = {},
							addressBase = currentBase,
							activePIDAddress = activePID,
							startIndex = i,
							lastValidPID = nil,
							lastValidPokemon = nil,
							secondMon = true,
							extraOffset = 0x224 * total
						}
					end
					local indexToInsert = i - enemyBattlers[currentEnemyIndex].startIndex

					local enemyBattler = enemyBattlers[currentEnemyIndex]
					if enemyBattler.teamPIDs[pid] ~= nil and gameInfo.GEN == 4 then
						--annoying case to handle when trainer has 2 with the same PID, no fix for gen 5 yet (battle data structures different)
						if type(enemyBattler.teamPIDs[pid]) == "table" then
							table.insert(enemyBattler.teamPIDs[pid], indexToInsert)
						else
							enemyBattler.teamPIDs[pid] = {enemyBattler.teamPIDs[pid], indexToInsert}
						end
					else
						enemyBattler.teamPIDs[pid] = indexToInsert
					end
				end
			end
			currentBase = currentBase + gameInfo.ENCRYPTED_POKEMON_SIZE
		end
	end

	local function tryToFetchBattleData()
		local firstPlayerPartyPID = Memory.read_u32_le(memoryAddresses.playerBase)
		local firstPlayerPID = Memory.read_u32_le(memoryAddresses.playerBattleBase)
		local firstEnemyPID = Memory.read_u32_le(memoryAddresses.enemyBase)
		if firstPlayerPID == 0 or firstEnemyPID == 0 or firstPlayerPID ~= firstPlayerPartyPID then
			return false
		end

		if gameInfo.GEN == 5 then
			local gen5SwitchInPIDs = {
				memoryAddresses.enemyBattleMonPID,
				memoryAddresses.enemyBattleMonPID + 0x5C,
				memoryAddresses.enemyBattleMonPID + 2 * 0x5C
			}
			local valid = false
			for _, addr in pairs(gen5SwitchInPIDs) do
				if Memory.read_u32_le(addr) ~= 0 then
					valid = true
				end
			end
			if not valid then
				return false
			end
		end

		local currentBase = memoryAddresses.playerBattleBase

		for i = 0, 5, 1 do
			local pid = Memory.read_u32_le(currentBase)
			if pid ~= 0 then
				playerBattleTeamPIDs[pid] = i
			else
				break
			end
			currentBase = currentBase + gameInfo.ENCRYPTED_POKEMON_SIZE
		end
		fetchEnemyData()
		return true
	end

	local function addAdditionalDataToPokemon(pokemon)
		local constData = PokemonData.POKEMON[pokemon.pokemonID + 1]
		for key, data in pairs(constData) do
			--when tracker makes a template it does the name because alternate forms are complex, so don't overwrite it
			if key == "name" then
				if not pokemon.name then
					pokemon[key] = data
				end
			elseif key == "movelvls" then
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
		if inBattle and battleDataFetched and enemyPokemon ~= nil and playerPokemon ~= nil then
			if gameInfo.GEN == 5 then
				pokemonDataReader.setCurrentBase(memoryAddresses.statStagesStart)
				playerPokemon.statStages = pokemonDataReader.readBattleStatStages(false, playerMonIndex)
				enemyPokemon.statStages = pokemonDataReader.readBattleStatStages(true, enemyMonIndex)
			else
				pokemonDataReader.setCurrentBase(memoryAddresses.statStagesEnemy)
				enemyPokemon.statStages = pokemonDataReader.readBattleStatStages(true, enemyMonIndex)
				pokemonDataReader.setCurrentBase(memoryAddresses.statStagesPlayer)
				playerPokemon.statStages = pokemonDataReader.readBattleStatStages(false, playerMonIndex)
			end
		end
	end

	local function getPlayerBattleMonPID()
		local activePID = Memory.read_u32_le(memoryAddresses.playerBattleMonPID)
		if gameInfo.GEN == 5 then
			activePID = Memory.read_u32_le(GEN5_activePlayerMonPIDAddr)
		end
		if activePID == 0 then
			return Memory.read_u32_le(memoryAddresses.playerBattleBase)
		else
			return activePID
		end
	end

	local function getEnemyBattleMonPID(enemyBattler)
		local activePID = Memory.read_u32_le(enemyBattler.activePIDAddress)
		if activePID == 0 then
			return Memory.read_u32_le(enemyBattler.addressBase)
		else
			return activePID
		end
	end

	local function checkForPlayerTransform()
		local activePID = getPlayerBattleMonPID()
		return not playerBattleTeamPIDs[activePID]
	end

	local function checkForEnemyTransform(enemyBattler)
		local activePID = getEnemyBattleMonPID(enemyBattler)
		return not enemyBattler.teamPIDs[activePID]
	end

	local function GEN5_checkPlayerTransform(compare)
		local previous = playerPokemon
		if compare.PID == previous.PID and compare.level == previous.level then
			for statName, value in pairs(compare.stats) do
				if previous[statName] ~= value then
					return true
				end
			end
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
				local data =  pokemonDataReader.decryptPokemonInfo(false, monIndex, false)
				if playerPokemon ~= nil and gameInfo.GEN==5 then
					if GEN5_checkPlayerTransform(data) == true then
						return nil
					end
					return data
				end
			end
		else
			pokemonDataReader.setCurrentBase(memoryAddresses.playerBase)
			local data = pokemonDataReader.decryptPokemonInfo(true, 0, false)
			return data
		end
	end

	local function checkForAlternateForm(pokemon)
		local data = PokemonData.POKEMON[pokemon.pokemonID + 1]
		local genderForms = {["Unfezant M"] = true, ["Frillish M"] = true, ["Jellicent M"] = true}
		if genderForms[data.name] then
			pokemon.alternateForm = 0x00
			if pokemon.isFemale == 1 then
				pokemon.alternateForm = 0x08
			end
		end
		pokemon.alternateForm = bit.band(pokemon.alternateForm, 0xF8)
		local form = pokemon.alternateForm
		if form ~= 0x00 then
			local alternateFormindex = form / 0x08
			if data ~= nil then
				if PokemonData.ALTERNATE_FORMS[data.name] then
					local formTable = PokemonData.ALTERNATE_FORMS[data.name]
					pokemon["baseForm"] = {
						name = data.name,
						cosmetic = formTable.cosmetic
					}
					local formStartIndex = formTable.index
					local alternateFormID = formStartIndex + (alternateFormindex - 2)
					pokemon.alternateFormID = alternateFormID
					pokemon.name = PokemonData.POKEMON[alternateFormID+1].name
					if not formTable.cosmetic then
						pokemon.pokemonID = alternateFormID
						tracker.logPokemonAsAlternateForm(pokemon.pokemonID, pokemon.baseForm, pokemon.alternateForm)
					end
				end
			end
		end
	end

	local function onBattleDelayFinished()
		self.UI_SCREEN_OBJECTS[self.UI_SCREENS.MAIN_SCREEN].setMoveEffectiveness(true)
		frameCounters["disableMoveEffectiveness"] = nil
	end

	local function disableMoveEffectiveness()
		self.UI_SCREEN_OBJECTS[self.UI_SCREENS.MAIN_SCREEN].setMoveEffectiveness(false)
	end

	local function getPokemonDataEnemy(slot)
		if inBattle and battleDataFetched then
			local enemyBattler = enemyBattlers[slot]
			local currentBase = enemyBattler.addressBase
			local activePID
			local transformed = checkForEnemyTransform(enemyBattler)
			if transformed then
				activePID = enemyBattler.lastValidPID
			else
				activePID = getEnemyBattleMonPID(enemyBattler)
				local activePokemon = enemyBattler.activeEnemyPokemon
				if activePID ~= enemyBattler.lastValidPID and enemyBattler.activeEnemyPokemon ~= nil then
					tracker.updateLastLevelSeen(activePokemon.pokemonID, activePokemon.level)
				end
			end
			local pokemonData
			local monIndex = enemyBattler.teamPIDs[activePID]
			if type(monIndex) == "table" then
				for _, indexToCheck in pairs(monIndex) do
					pokemonDataReader.setCurrentBase(currentBase + indexToCheck * gameInfo.ENCRYPTED_POKEMON_SIZE)
					local testForID = pokemonDataReader.decryptPokemonInfo(false, monIndex, true)
					if validPokemonData(testForID) then
						if testForID.pokemonID == memory.read_u16_le(memoryAddresses.enemyPokemonID + 180 * (slot - 1)) then
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
				pokemonData = pokemonDataReader.decryptPokemonInfo(false, monIndex, true, enemyBattler.extraOffset)
			end
			if validPokemonData(pokemonData) then
				checkForAlternateForm(pokemonData)
				enemyBattler.lastValidPokemon = pokemonData
				enemyBattler.activeEnemyPokemon = pokemonData
				if activePID ~= enemyBattler.lastValidPID then
					local delay = 150
					if gameInfo.GEN == 5 then
						delay = 90
					end
					if enemyBattler.lastValidPID == -1 then
						delay = 300
						if gameInfo.GEN == 5 and battleDataFetched then
							delay = 0
						end
					end
					tracker.logNewEnemyPokemonInBattle(pokemonData.pokemonID)
					disableMoveEffectiveness()
					frameCounters["disableMoveEffectiveness"] = FrameCounter(delay, onBattleDelayFinished)
					tracker.updateCurrentLevel(pokemonData.pokemonID, pokemonData.level)
				end
				enemyBattler.lastValidPID = activePID
				return pokemonData
			else
				return nil
			end
		end
	end

	local function GEN5_checkLastSwitchin()
		--In gen 5, there is no active battler PID.
		--Instead, several memory addresses seemingly get updated when switch-ins occur.
		--So what we do is check these addresses. If the PID belongs to player or enemy, update accordingly.
		if next(GEN5_PIDSwitchData) ~= nil then
			local start = memoryAddresses.playerBattleMonPID
			for i = 0, 5, 1 do
				local switchAddr = start + i * gameInfo.ACTIVE_PID_DIFFERENCE
				local data = GEN5_PIDSwitchData.switchSlots[switchAddr]
				local currentValue = Memory.read_u32_le(switchAddr)
				if currentValue == 0 then
					return 
				end
				if not data.active and currentValue ~= data.initialValue and not GEN5_PIDSwitchData.initialPIDs[currentValue] then
					data.active = true
					if playerBattleTeamPIDs[currentValue] and GEN5_activePlayerMonPIDAddr == memoryAddresses.playerBattleBase then
						GEN5_activePlayerMonPIDAddr = switchAddr
					else
						for _, battler in pairs(enemyBattlers) do
							if battler.teamPIDs[currentValue] and battler.activePIDAddress == battler.addressBase then
								battler.activePIDAddress = switchAddr
							end
						end
					end
				end
			end
		end
	end

	local function checkEnemyPP(enemy)
		if inBattle and enemy ~= nil then
			for i, moveID in pairs(enemy.moveIDs) do
				local data = MoveData.MOVES[moveID + 1]
				local currentPP = enemy.movePPs[i]
				local maxPP = data.pp
				if data.id ~= "---" then
					if currentPP < tonumber(maxPP) then
						tracker.trackMove(enemy.pokemonID, moveID, enemy.level)
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
			local enemies = {}
			for i = 1, #enemyBattlers, 1 do
				local enemy = getPokemonDataEnemy(i)
				checkEnemyPP(enemy)
				enemies[i] = enemy
			end
			return enemies[enemySlotIndex]
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
			currentScreens[self.UI_SCREENS.MAIN_SCREEN].setLanceDefeated(leagueEvent >= 3)
		end
	end

	local function GEN5_initializePIDSlots()
		local start = memoryAddresses.playerBattleMonPID
		GEN5_PIDSwitchData = {
			initialPIDs = {},
			switchSlots = {}
		}
		for _, battler in pairs(enemyBattlers) do
			GEN5_PIDSwitchData.initialPIDs[Memory.read_u32_le(battler.addressBase)] = true
		end
		GEN5_activePlayerMonPIDAddr = memoryAddresses.playerBattleBase
		GEN5_PIDSwitchData.initialPIDs[Memory.read_u32_le(memoryAddresses.playerBattleBase)] = true
		for i = 0, 5, 1 do
			local addr = start + i * gameInfo.ACTIVE_PID_DIFFERENCE
			local initialValue = Memory.read_u32_le(addr)
			GEN5_PIDSwitchData.switchSlots[addr] = {
				["initialValue"] = initialValue
			}
		end
	end

	local function onBattleFetchFrameCounter()
		battleDataFetched = tryToFetchBattleData()
		if battleDataFetched then
			GEN5_initializePIDSlots()
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
					--lastValidEnemyBattlePID = -1
					lastValidPlayerBattlePID = -1
					inBattle = true
					battleDataFetched = false
					playerBattleTeamPIDs = {}
					enemyBattlers = {}
					GEN5_PIDSwitchData = {}
					frameCounters["fetchBattleData"] = FrameCounter(60, onBattleFetchFrameCounter)
				else
					if battleDataFetched then
						frameCounters["fetchBattleData"] = nil
					end
				end
			else
				if inBattle then
					firstBattleComplete = true
					for _, battler in pairs(enemyBattlers) do
						if battler.lastValidPokemon ~= nil then
							tracker.updateLastLevelSeen(battler.lastValidPokemon.pokemonID, battler.lastValidPokemon.level)
						end
					end
				end
				inBattle = false
				if not locked then
					selectedPlayer = self.SELECTED_PLAYERS.PLAYER
				end
			end
			local canUpdate = true
			if
				not settings.battle.SHOW_1ST_FIGHT_STATS_PLATINUM and firstBattleComplete == false and
					gameInfo.NAME == "Pokemon Platinum"
			 then
				canUpdate = false
			end
			if canUpdate then
				updatePlayerPokemonData()
				updateEnemyPokemonData()
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

	function self.initializePokemonIconsScreen()
		if currentScreens[self.UI_SCREENS.POKEMON_ICONS_SCREEN] then
			currentScreens[self.UI_SCREENS.POKEMON_ICONS_SCREEN].initialize()
		end
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
			if (inBattle and battleDataFetched) or (locked and lockedPokemonCopy ~= nil) then
				if selectedPlayer == self.SELECTED_PLAYERS.PLAYER then
					selectedPlayer = self.SELECTED_PLAYERS.ENEMY
				else
					if locked then
						selectedPlayer = self.SELECTED_PLAYERS.PLAYER
					else
						if enemySlotIndex == #enemyBattlers then
							selectedPlayer = self.SELECTED_PLAYERS.PLAYER
							enemySlotIndex = 1
						else
							enemySlotIndex = enemySlotIndex + 1
						end
					end
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
		if inBattle and battleDataFetched and enemyPokemon ~= nil and settings.battle.ENABLE_ENEMY_LOCKING then
			locked = true
			lockedPokemonCopy = MiscUtils.deepCopy(enemyPokemon)
			self.drawCurrentScreens()
		end
	end

	function self.unlockEnemy()
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
			self.unlockEnemy()
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
		Graphics.SIZES.MAIN_SCREEN_PADDING = 199
		if settings.appearance.DISPLAY_HOVERS_TO_THE_RIGHT then
			Graphics.SIZES.MAIN_SCREEN_PADDING = 199 + 130
		end
		local total = 0
		for _, screen in pairs(currentScreens) do
			total = total + 1
		end
		if currentScreens[self.UI_SCREENS.MAIN_SCREEN] and #currentScreens == 1 then
			client.SetGameExtraPadding(0, 0, Graphics.SIZES.MAIN_SCREEN_PADDING, 0)
		end
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

	frameCounters = {
		settingsSaving = FrameCounter(120, saveSettings, nil, true),
		screenDrawing = FrameCounter(30, self.drawCurrentScreens, nil, true),
		memoryReading = FrameCounter(30, readMemory, nil, true),
		trackerSaving = FrameCounter(
			18000,
			function()
				tracker.save()
				client.saveram()
			end,
			nil,
			true
		),
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

	function self.isInControlsMenu()
		return currentScreens[self.UI_SCREENS.EDIT_CONTROLS_SCREEN] ~= nil
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

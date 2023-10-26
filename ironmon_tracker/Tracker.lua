local function Tracker()
	local self = {}

	local currentAreaName = ""
	local trackedData = {
		currentTimerSeconds = 0,
		encounterData = {},
		runOver = false,
		progress = PlaythroughConstants.PROGRESS.NOWHERE,
		firstPokemon = nil,
		trackedPokemon = {},
		bookmarkedIDs = {},
		romHash = gameinfo.getromhash(),
		currentHiddenPowerType = PokemonData.POKEMON_TYPES.BUG,
		currentHiddenPowerIndex = 1,
		pokecenterCount = 10
	}
	local sessionStartTime = os.time()
	local startSeconds = 0
	local totalSeconds = 0

	function self.setTimerSeconds(newSeconds)
		trackedData.currentTimerSeconds = newSeconds
	end

	function self.getTimerSeconds()
		if not trackedData.currentTimerSeconds or trackedData.currentTimerSeconds == nil then
			return 0
		end
		return trackedData.currentTimerSeconds
	end

	function self.setRunOver()
		trackedData.runOver = true
	end

	function self.unmarkID(id)
		trackedData.bookmarkedIDs[id] = nil
	end

	function self.markID(id)
		trackedData.bookmarkedIDs[id] = true
	end

	function self.isMarked(id)
		if trackedData.bookmarkedIDs[id] == nil then
			return false
		end
		return trackedData.bookmarkedIDs[id]
	end

	function self.getMarkedIDs()
		if next(trackedData.bookmarkedIDs) == nil then
			return {}
		end
		local ids = {}
		for id, _ in pairs(trackedData.bookmarkedIDs) do
			table.insert(ids, id)
		end
		MiscUtils.sortPokemonIDsByName(ids)
		return ids
	end

	function self.hasRunEnded()
		return trackedData.runOver
	end

	function self.setFirstPokemon(pokemon)
		if trackedData.firstPokemon == nil then
			trackedData.firstPokemon = MiscUtils.shallowCopy(pokemon)
		end
	end

	function self.getFirstPokemonID()
		if trackedData.firstPokemon == nil then
			return
		end
		return trackedData.firstPokemon.pokemonID
	end

	function self.loadTotalPlaytime(gameName)
		local playtimeFile = "savedData/" .. gameName .. ".pt"
		local seconds = tonumber(MiscUtils.readStringFromFile(playtimeFile) or "", 10)
		if type(seconds) == "number" then
			totalSeconds = seconds
			startSeconds = seconds
		end
	end

	function self.getTotalHoursPlayed()
		local hours = totalSeconds / 3600
		return (string.format("%.1f hours", hours))
	end

	function self.updatePlaytime(gameName)
		local playtimeFile = "savedData/" .. gameName .. ".pt"
		local additionalTime = math.max(os.time() - sessionStartTime, 0)
		totalSeconds = startSeconds + additionalTime
		MiscUtils.writeStringToFile(playtimeFile, tostring(totalSeconds))
	end

	function self.loadExternalTrackerDataFile(filePath)
		local trackerData = MiscUtils.getTableFromFile(filePath)
		if trackerData == nil then
			return
		end
		for key, value in pairs(trackedData) do
			if not trackerData[key] then
				trackerData[key] = value
			end
		end
		trackedData = trackerData
	end

	function self.loadData(gameName)
		local savedData = MiscUtils.getTableFromFile("savedData/" .. gameName .. ".trackerdata")
		if savedData == nil then
			savedData = MiscUtils.getTableFromFile("autosave.trackerdata")
		end
		if savedData == nil then
			return
		end
		local savedRomHash = savedData.romHash
		if savedRomHash == trackedData.romHash then
			print("Matching ROM found. Loading previously tracked data...")
			for key, value in pairs(trackedData) do
				if not savedData[key] then
					savedData[key] = value
				end
			end
			trackedData = savedData
		end
	end

	local function createNewPokemonEntry(pokemonID)
		trackedData.trackedPokemon[pokemonID] = {
			moves = {},
			statPredictions = nil,
			abilities = {},
			note = "",
			amountSeen = 0,
			lastLevelSeen = "---",
			currentLevel = "---",
			baseForm = nil
		}
	end

	function self.updateEncounterData(pokemonID, level)
		local encounterData = trackedData.encounterData
		if not encounterData[currentAreaName] then
			encounterData[currentAreaName] = {
				areaName = currentAreaName,
				encountersSeen = {},
				uniqueSeen = 0
			}
		end
		local areaData = encounterData[currentAreaName]
		local seenEncounters = areaData.encountersSeen
		if not seenEncounters[pokemonID] then
			seenEncounters[pokemonID] = {}
			areaData.uniqueSeen = areaData.uniqueSeen + 1
		end
		if not MiscUtils.tableContains(seenEncounters[pokemonID], level) then
			table.insert(seenEncounters[pokemonID], level)
		end
		table.sort(
			seenEncounters[pokemonID],
			function(a, b)
				return a < b
			end
		)
	end

	function self.getCurrentAreaName()
		return currentAreaName
	end

	function self.getEncounterData()
		return trackedData.encounterData[currentAreaName]
	end

	function self.updateCurrentAreaName(newAreaName)
		currentAreaName = newAreaName
	end

	local function checkIfPokemonUntracked(pokemonID)
		if trackedData.trackedPokemon[pokemonID] == nil then
			createNewPokemonEntry(pokemonID)
		end
	end

	local function updateAmountSeen(pokemonID)
		checkIfPokemonUntracked(pokemonID)
		local data = trackedData.trackedPokemon[pokemonID]
		data.amountSeen = data.amountSeen + 1
	end

	function self.increasePokecenterCount()
		trackedData.pokecenterCount = math.min(99, trackedData.pokecenterCount + 1)
	end

	function self.decreasePokecenterCount()
		trackedData.pokecenterCount = math.max(0, trackedData.pokecenterCount - 1)
	end

	function self.getPokecenterCount()
		return trackedData.pokecenterCount
	end

	function self.getSortedTrackedIDs()
		local ids = {}
		local pokemon = trackedData.trackedPokemon
		for id, _ in pairs(pokemon) do
			if not PokemonData.POKEMON[id + 1] or id == 0 then
				pokemon[id] = nil
			else
				table.insert(ids, id)
			end
		end
		MiscUtils.sortPokemonIDsByName(ids)
		return ids
	end

	function self.logPokemonAsAlternateForm(pokemonID, baseForm, alternateForm)
		checkIfPokemonUntracked(pokemonID)
		local data = trackedData.trackedPokemon[pokemonID]
		data.baseForm = {
			name = baseForm.name,
			cosmetic = baseForm.cosmetic
		}
		data.alternateForm = alternateForm
	end

	function self.convertTrackedIDToPokemonTemplate(id)
		local template = {
			baseForm = nil,
			alternateForm = 0x00,
			isFemale = 0,
			pokemonID = 0,
			heldItem = 0,
			ability = 0,
			status = 0,
			level = 0,
			curHP = 0,
			HP = 0,
			stats = {
				HP = "---",
				ATK = "---",
				DEF = "---",
				SPE = "---",
				SPA = "---",
				SPD = "---"
			},
			nature = 0,
			encounterType = 0,
			moves = {},
			moveIDs = {0, 0, 0, 0},
			movePPs = {
				"---",
				"---",
				"---",
				"---"
			},
			statStages = {
				["HP"] = 6,
				["ATK"] = 6,
				["DEF"] = 6,
				["SPE"] = 6,
				["SPA"] = 6,
				["SPD"] = 6
			}
		}
		if id ~= 0 then
			local constData = PokemonData.POKEMON[id + 1]
			local data = trackedData.trackedPokemon[id]
			local name = constData.name
			if PokemonData.ALTERNATE_FORMS[name] then
				template.name = PokemonData.ALTERNATE_FORMS[name].shortenedName
			end
			template.alternateForm = data.alternateForm
			template.moves = data.moves
			template.level = data.currentLevel
			if data.currentLevel == "---" then
				template.level = data.lastLevelSeen
			end
			template.pokemonID = id
			if data.baseForm ~= nil then
				template.baseForm = {
					name = data.baseForm.name,
					cosmetic = data.baseForm.cosmetic
				}
			end
			for i, move in pairs(data.moves) do
				template.moveIDs[i] = move.move
				template.movePPs[i] = MoveData.MOVES[move.move + 1].pp
			end
		end
		return template
	end

	function self.logNewEnemyPokemonInBattle(pokemonID)
		checkIfPokemonUntracked(pokemonID)
		updateAmountSeen(pokemonID)
	end

	function self.updateCurrentLevel(pokemonID, level)
		checkIfPokemonUntracked(pokemonID)
		local data = trackedData.trackedPokemon[pokemonID]
		data.currentLevel = level
	end

	function self.updateLastLevelSeen(pokemonID, newLevel)
		checkIfPokemonUntracked(pokemonID)
		local data = trackedData.trackedPokemon[pokemonID]
		data.lastLevelSeen = newLevel
	end

	function self.getLastLevelSeen(pokemonID)
		checkIfPokemonUntracked(pokemonID)
		return trackedData.trackedPokemon[pokemonID].lastLevelSeen
	end

	function self.getAmountSeen(pokemonID)
		checkIfPokemonUntracked(pokemonID)
		return trackedData.trackedPokemon[pokemonID].amountSeen
	end

	local function createNewMoveEntry(pokemonID, moveID, level)
		checkIfPokemonUntracked(pokemonID)
		local pokemonData = trackedData.trackedPokemon[pokemonID]
		pokemonData.moves = {}
		pokemonData.moves[1] = {
			move = moveID,
			level = level
		}
		for i = 2, 4, 1 do
			pokemonData.moves[i] = {
				move = 0,
				level = 1
			}
		end
	end

	function self.trackAbility(pokemonID, abilityID)
		local currentAbilities = trackedData.abilities[pokemonID]
		if currentAbilities == nil then
			trackedData.abilities[pokemonID] = {}
			trackedData.abilities[pokemonID][abilityID] = abilityID
		else
			if currentAbilities[abilityID] == nil then
				trackedData.abilities[pokemonID][abilityID] = abilityID
			end
		end
	end

	function self.trackMove(pokemonID, moveID, level)
		checkIfPokemonUntracked(pokemonID)
		local pokemonData = trackedData.trackedPokemon[pokemonID]
		local currentMoves = pokemonData.moves
		if next(currentMoves) == nil then
			createNewMoveEntry(pokemonID, moveID, level)
		else
			local moveSeen = false
			local moveCount = 0
			local whichMove = 0
			for i, moveData in pairs(currentMoves) do
				moveCount = moveCount + 1
				if moveData.move == moveID then
					moveSeen = true
					whichMove = i
				end
			end

			if moveSeen == false then
				if moveCount < 4 then
					pokemonData.moves[moveCount + 1] = {
						move = moveID,
						level = level
					}
				else
					for i = 4, 2, -1 do
						pokemonData.moves[i] = pokemonData.moves[i - 1]
					end
					pokemonData.moves[1] = {
						move = moveID,
						level = level
					}
				end
			else
				pokemonData.moves[whichMove] = {
					move = moveID,
					level = level
				}
			end
		end
	end

	function self.setProgress(newProgress)
		trackedData.progress = newProgress
	end

	function self.getProgress()
		return trackedData.progress
	end

	function self.setStatPredictions(pokemonID, newStats)
		checkIfPokemonUntracked(pokemonID)
		trackedData.trackedPokemon[pokemonID].statPredictions = newStats
	end

	function self.getCurrentHiddenPowerType()
		return trackedData.currentHiddenPowerType
	end

	function self.increaseHiddenPowerType()
		local totalTypes = #PokemonData.TYPE_LIST
		trackedData.currentHiddenPowerIndex = (trackedData.currentHiddenPowerIndex % totalTypes) + 1
		trackedData.currentHiddenPowerType = PokemonData.TYPE_LIST[trackedData.currentHiddenPowerIndex]
	end

	function self.decreaseHiddenPowerType()
		local totalTypes = #PokemonData.TYPE_LIST
		trackedData.currentHiddenPowerIndex = ((trackedData.currentHiddenPowerIndex + totalTypes - 2) % totalTypes) + 1
		trackedData.currentHiddenPowerType = PokemonData.TYPE_LIST[trackedData.currentHiddenPowerIndex]
	end

	function self.setNote(pokemonID, note)
		checkIfPokemonUntracked(pokemonID)
		if note ~= nil then
			trackedData.trackedPokemon[pokemonID].note = note
		end
	end

	function self.getNote(pokemonID)
		if trackedData.trackedPokemon[pokemonID] == nil then
			return ""
		end
		local note = trackedData.trackedPokemon[pokemonID].note
		if note ~= nil then
			return note
		else
			return ""
		end
	end

	function self.getMoves(pokemonID)
		checkIfPokemonUntracked(pokemonID)
		if next(trackedData.trackedPokemon[pokemonID].moves) == nil then
			for _ = 1, 4, 1 do
				table.insert(
					trackedData.trackedPokemon[pokemonID].moves,
					{
						move = 0,
						level = 1
					}
				)
			end
		end
		return trackedData.trackedPokemon[pokemonID].moves
	end

	function self.getAbilities(pokemonID)
		checkIfPokemonUntracked(pokemonID)
		if trackedData.abilities[pokemonID] == nil then
			return {
				1
			}
		else
			return trackedData.abilities[pokemonID]
		end
	end

	function self.getStatPredictions(pokemonID)
		checkIfPokemonUntracked(pokemonID)
		if trackedData.trackedPokemon[pokemonID].statPredictions == nil then
			return {
				HP = 1,
				ATK = 1,
				DEF = 1,
				SPA = 1,
				SPD = 1,
				SPE = 1
			}
		else
			return trackedData.trackedPokemon[pokemonID].statPredictions
		end
	end

	function self.save(gameName)
		if trackedData.firstPokemon ~= nil then
			MiscUtils.saveTableToFile("savedData/" .. gameName .. ".trackerdata", trackedData)
		end
	end

	return self
end

return Tracker

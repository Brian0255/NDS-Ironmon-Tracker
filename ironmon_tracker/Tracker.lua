local function Tracker()
	local self = {}
	local trackedData = {
		moves = {},
		statPredictions = {},
		bilities = {},
		notes = {},
		romHash = nil,
		currentHiddenPowerType = PokemonData.POKEMON_TYPES.NORMAL,
		pokecenterCount = 10,
		badges = {0, 0, 0, 0, 0, 0, 0, 0}
	}
	local function loadData()
		local currentRomHash = gameinfo.getromhash()
		trackedData.romHash = currentRomHash
		local saveFile = io.open("autosave.trackerdata", "w")
		if MiscUtils.fileExists(saveFile) then
			local fileContents = saveFile:read("*a")
			local savedData = Pickle.unpickle(fileContents)
			local savedRomHash = savedData.romHash
			if savedRomHash == currentRomHash then
				trackedData = savedData
			end
		end
	end
	local function createNewMoveEntry(pokemonID, moveID, level)
		trackedData.moves[pokemonID] = {}
		trackedData.moves[pokemonID][1] = {
			move = moveID,
			level = level
		}
		for i = 2, 4, 1 do
			trackedData.moves[pokemonID][i] = {
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
		local currentMoves = trackedData.moves[pokemonID]
		if currentMoves == nil then
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
					trackedData.moves[pokemonID[moveCount + 1]] = {
						move = moveID,
						level = level
					}
				else
					for i = 4, 2, -1 do
						trackedData.moves[pokemonID][i] = trackedData.moves[pokemonID][i - 1]
					end
					trackedData.moves[pokemonID][1] = {
						move = moveID,
						level = level
					}
				end
			else
				trackedData.moves[pokemonID][whichMove] = {
					move = moveID,
					level = level
				}
			end
		end
	end
	function self.trackStatPrediction(pokemonID, newStats)
		trackedData.stats[pokemonID].stats = newStats
	end
	function self.setNote(pokemonID, note)
		if note ~= nil then
			local charMax = 25
			if string.len(note) > charMax then
				print("Note truncated to " .. charMax .. " characters")
			end
			note = string.sub(note, 1, charMax)
			trackedData.notes[pokemonID] = string.sub(note, 1, charMax)
		end
	end
	function self.getNote(pokemonID)
		local notes = trackedData.notes[pokemonID]
		if notes ~= nil then
			return notes
		else
			return ""
		end
	end
	function self.getMoves(pokemonID)
		local returnVal = {}
		if trackedData.moves[pokemonID] == nil then
			for _ = 1, 4, 1 do
				table.insert(
					returnVal,
					{
						move = 0,
						level = 1
					}
				)
			end
			return returnVal
		else
			return trackedData.moves[pokemonID]
		end
	end
	function self.getAbilities(pokemonID)
		if trackedData.abilities[pokemonID] == nil then
			return {
				1
			}
		else
			return trackedData.abilities[pokemonID]
		end
	end
	function self.getStatPrediction(pokemonID)
		if trackedData.stats[pokemonID] == nil then
			return {
				hp = 1,
				att = 1,
				def = 1,
				spa = 1,
				spd = 1,
				spe = 1
			}
		else
			return trackedData.stats[pokemonID].stats
		end
	end
	function self.save()
		local dataString = Pickle.pickle(trackedData)
		local saveFile = io.open("autosave.trackerdata", "w")
		saveFile:write(dataString)
		saveFile:close()
	end
	loadData()
	return self
end

return Tracker

local function Tracker()
	local self = {}
	local trackedData = {
		moves = {},
		statPredictions = {},
		abilities = {},
		notes = {},
		romHash = gameinfo.getromhash(),
		currentHiddenPowerType = PokemonData.POKEMON_TYPES.NORMAL,
		pokecenterCount = 10,
		badges = { firstSet = { 0, 0, 0, 0, 0, 0, 0, 0 },
			secondSet = { 0, 0, 0, 0, 0, 0, 0, 0 } }
	}
	local function loadData()
		local file = io.open("autosave.trackerdata", "r")
		if file ~= nil then
			local fileContents = file:read("*a")
			if fileContents ~= nil and fileContents ~= "" then
				local savedData = Pickle.unpickle(fileContents)
				if savedData ~= nil then
					local savedRomHash = savedData.romHash
					if savedRomHash == trackedData.romHash then
						print("Matching ROM found. Loading previously tracked data...")
						trackedData = savedData
					end
				end
			end
			file:close()
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

	function self.getBadges()
		return trackedData.badges
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
		local file = io.open("autosave.trackerdata", "w")
		if file ~= nil then
			local data = Pickle.pickle(trackedData)
			file:write(data)
			file:close()
		end
	end

	loadData()
	return self
end

return Tracker

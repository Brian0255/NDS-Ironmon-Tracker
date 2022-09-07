local function Tracker()
	local self = {}
	local trackedData = {
		trackedPokemon = {},
		romHash = gameinfo.getromhash(),
		currentHiddenPowerType = PokemonData.POKEMON_TYPES.NORMAL,
		pokecenterCount = 10
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

	local function createNewPokemonEntry(pokemonID)
		trackedData.trackedPokemon[pokemonID] = {
			moves = {},
			statPredictions = nil,
			abilities = {},
			note = "",
			amountSeen = 0,
			lastLevelSeen = "---"
		}
	end

	local function checkIfPokemonUntracked(pokemonID)
		if trackedData.trackedPokemon[pokemonID] == nil then
			createNewPokemonEntry(pokemonID)
		end
	end

	local function updateAmountSeen(pokemonID)
		local data = trackedData.trackedPokemon[pokemonID]
		data.amountSeen = data.amountSeen + 1
	end

	function self.logNewEnemyPokemonInBattle(pokemonID)
		checkIfPokemonUntracked(pokemonID)
		updateAmountSeen(pokemonID)
	end

	function self.updateLastLevelSeen(pokemonID, newLevel)
		checkIfPokemonUntracked(pokemonID)
		local data = trackedData.trackedPokemon[pokemonID]
		data.lastLevelSeen = newLevel
	end

	function self.getLastLevelSeen(pokemonID)
		return trackedData.trackedPokemon[pokemonID].lastLevelSeen
	end

	function self.getAmountSeen(pokemonID)
		return trackedData.trackedPokemon[pokemonID].amountSeen
	end

	local function createNewMoveEntry(pokemonID, moveID, level)
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

	function self.setStatPredictions(pokemonID, newStats)
		trackedData.trackedPokemon[pokemonID].statPredictions = newStats
	end

	function self.setNote(pokemonID, note)
		if note ~= nil then
			local charMax = 40
			if string.len(note) > charMax then
				print("Note truncated to " .. charMax .. " characters")
			end
			note = string.sub(note, 1, charMax)
			trackedData.trackedPokemon[pokemonID].note = string.sub(note, 1, charMax)
		end
	end

	function self.getNote(pokemonID)
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
			print("untracked")
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

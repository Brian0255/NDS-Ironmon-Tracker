Tracker = {}

Tracker.userDataKey = "ironmon_tracker_data"

Tracker.waitFrames = 0

Tracker.controller = {
	statIndex = 1,
	framesSinceInput = 120,
	boxVisibleFrames = 120,
}

Tracker.Data = {}

function Tracker.InitTrackerData()
	local trackerData = {
		playerPokemon = Decrypter.DecryptedDataInit,
		enemyPokemon = {},
		main = {
			ability = 0
		},
		inBattle = 0,
		needCheckSummary = 0,
		selectedPlayer = 1,
		selectedSlot = 1,
		targetPlayer = 2,
		targetSlot = 1,
		selfSlotOne = 1,
		selfSlotTwo = 1,
		enemySlotOne = 1,
		enemySlotTwo = 1,
		moves = {},
		stats = {},
		abilities = {},
		items = {},
		healingItems = {
			healing = 0,
			numHeals = 0,
		},
		notes = {},
		currentHiddenPowerType = PokemonTypes.NORMAL,
		romHash = nil,
		pokecenterCount = 10,
	}
	return trackerData
end

function Tracker.Clear()
	if userdata.containskey(Tracker.userDataKey) then
		userdata.remove(Tracker.userDataKey)
	end
	Tracker.Data = Tracker.InitTrackerData()
end

function Tracker.TrackAbility(pokemonId, abilityId)
	local currentAbilities = Tracker.Data.abilities[pokemonId]
	if currentAbilities == nil then
		Tracker.Data.abilities[pokemonId] = {}
		Tracker.Data.abilities[pokemonId][abilityId] = abilityId
	else
		if currentAbilities[abilityId] == nil then
			Tracker.Data.abilities[pokemonId][abilityId] = abilityId
		end
	end
end

function Tracker.TrackItem(pokemonId, itemId)

end

function Tracker.TrackMove(pokemonId, moveId, level)
	local currentMoves = Tracker.Data.moves[pokemonId]
	if currentMoves == nil then
		Tracker.Data.moves[pokemonId] = {}
		Tracker.Data.moves[pokemonId][1] = {
			move = moveId,
			level = level
		}
		for i = 2,4,1 do
		Tracker.Data.moves[pokemonId][i] = {
			move = 1, level = 1
		}
		end
	else
		local moveSeen = false
		local moveCount = 0
		local whichMove = 0
		for i, moveData in pairs(currentMoves) do
			moveCount = moveCount + 1
			if moveData.move == moveId then
				moveSeen = true
				whichMove = i
			end
		end

		if moveSeen == false then
			if moveCount < 4 then
				Tracker.Data.moves[pokemonId[moveCount+1]] = {
					move = moveId,
					level = level
				}
			else
				for i = 4,2,-1 do
					Tracker.Data.moves[pokemonId][i] = Tracker.Data.moves[pokemonId][i-1]
				end
				Tracker.Data.moves[pokemonId][1] = {
					move = moveId,
					level = level
				}
			end
		else
			Tracker.Data.moves[pokemonId][whichMove] = {
				move = moveId,
				level = level
			}
		end
	end
end

function Tracker.TrackStatPrediction(pokemonId, stats)
	Tracker.Data.stats[pokemonId] = {}
	Tracker.Data.stats[pokemonId].stats = stats
end

function Tracker.SetNote(note)
	if note == nil then
		return
	end
	local charMax = Utils.inlineIf(Settings.tracker.SHOW_POKECENTER_HEALS,18,25)
	if string.len(note) > charMax then
		print("Note truncated to "..charMax.." characters")
	end
	local note = string.sub(note,1,charMax)
	local selected = Utils.inlineIf(Tracker.Data.selectedPlayer == 1, Tracker.Data.playerPokemon,Tracker.Data.enemyPokemon)
	if selected ~= nil then
		Tracker.Data.notes[selected.pokemonID] = string.sub(note, 1, charMax)
	end
end

function Tracker.GetNote()
	local selected = Utils.inlineIf(Tracker.Data.selectedPlayer == 1, Tracker.Data.playerPokemon,Tracker.Data.enemyPokemon)
	if selected ~= nil then
		if Tracker.Data.notes[selected.pokemonID] == nil then
			return ""
		else
			return Tracker.Data.notes[selected.pokemonID]
		end
	end
	return ""
end

function Tracker.getMoves(pokemonId)
	local returnVal = {}
	if Tracker.Data.moves[pokemonId] == nil then
		for i = 1,4,1 do
			table.insert(returnVal,{
				move = 1,
				level = 1
			})
		end
		return returnVal
	else
		return Tracker.Data.moves[pokemonId]
	end
end

function Tracker.getAbilities(pokemonId)
	if Tracker.Data.abilities[pokemonId] == nil then
		return {
			1
		}
	else
		return Tracker.Data.abilities[pokemonId]
	end
end

function Tracker.getButtonState()
	if Tracker.Data.enemyPokemon ~= nil then
		if Tracker.Data.stats[Tracker.Data.enemyPokemon.pokemonID] == nil then
			return {
				hp = 1,
				att = 1,
				def = 1,
				spa = 1,
				spd = 1,
				spe = 1
			}
		else
			return Tracker.Data.stats[Tracker.Data.enemyPokemon.pokemonID].stats
		end
	end
end

function Tracker.saveData()
	local dataString = pickle(Tracker.Data)
	userdata.set(Tracker.userDataKey, dataString)
end

function Tracker.loadData()
	if userdata.containskey(Tracker.userDataKey) then
		local serializedTable = userdata.get(Tracker.userDataKey)
		local trackerData = unpickle(serializedTable)
		Tracker.Data = Tracker.InitTrackerData()
		for k, v in pairs(trackerData) do
			Tracker.Data[k] = v
		end

		if Tracker.Data.romHash then
			if gameinfo.getromhash() == Tracker.Data.romHash then
				print("Loaded tracker data")
			else
				print("New ROM detected, resetting tracker data")
				Tracker.Data = Tracker.InitTrackerData()
			end
		end
	else
		Tracker.Data = Tracker.InitTrackerData()
		if Settings.tracker.MUST_CHECK_SUMMARY == true then
			Tracker.Data.needCheckSummary = 1
		end
	end

	Tracker.Data.romHash = gameinfo.getromhash()
end

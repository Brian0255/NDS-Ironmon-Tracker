Utils = {
	POPUP_DIALOG_TYPES = {
		WARNING = "!",
		INFO = "Info",
	}
}

function Utils.getbits(a, b, d)
	return bit.rshift(a, b) % bit.lshift(1, d)
end

function Utils.addhalves(a)
	local b = Utils.getbits(a, 0, 16)
	local c = Utils.getbits(a, 16, 16)
	return b + c
end

-- If the `condition` is true, the value in `T` is returned, else the value in `F` is returned
function Utils.inlineIf(condition, T, F)
	if condition then return T else return F end
end

function Utils.netEffectiveness(move, pkmnData)
	local effectiveness = 1.0

	-- TODO: Do we want to handle Hidden Power's varied type in this? We could analyze the IV of the Pokémon and determine the type...

	-- If move has no power, check for ineffectiveness by type first, then return 1.0 if ineffective cases not present
	if move.power == NOPOWER then
		if move.category ~= MoveCategories.STATUS then
			if move.type == PokemonTypes.NORMAL and (pkmnData.type[1] == PokemonTypes.GHOST or pkmnData.type[2] == PokemonTypes.GHOST) then
				return 0.0
			elseif move.type == PokemonTypes.FIGHTING and (pkmnData.type[1] == PokemonTypes.GHOST or pkmnData.type[2] == PokemonTypes.GHOST) then
				return 0.0
			elseif move.type == PokemonTypes.PSYCHIC and (pkmnData.type[1] == PokemonTypes.DARK or pkmnData.type[2] == PokemonTypes.DARK) then
				return 0.0
			elseif move.type == PokemonTypes.GROUND and (pkmnData.type[1] == PokemonTypes.FLYING or pkmnData.type[2] == PokemonTypes.FLYING) then
				return 0.0
			elseif move.type == PokemonTypes.GHOST and (pkmnData.type[1] == PokemonTypes.NORMAL or pkmnData.type[2] == PokemonTypes.NORMAL) then
				return 0.0
			end
		end
		return 1.0
	end

	if move["name"] == "Future Sight" or move["name"] == "Doom Desire" then
		return 1.0
	end

	for _, type in ipairs(pkmnData["type"]) do
		local moveType = move["type"]
		if move["name"] == "Hidden Power" and Tracker.Data.selectedPlayer == 1 then
			moveType = Tracker.Data.currentHiddenPowerType
		end
		if moveType ~= "---" then
			if EffectiveData[moveType][type] ~= nil then
				effectiveness = effectiveness * EffectiveData[moveType][type]
			end
		end
	end
	return effectiveness
end

function Utils.isSTAB(move, pkmnData)
	for _, type in ipairs(pkmnData["type"]) do
		local moveType = move.type
		if move.name == "Hidden Power" and Tracker.Data.selectedPlayer == 1 then
			moveType = Tracker.Data.currentHiddenPowerType
		end
		if moveType == type then
			return true
		end
	end
	return false
end

function Utils.calculateWeightBasedDamage(weight)
	if weight < 10.0 then
		return "20"
	elseif weight < 25.0 then
		return "40"
	elseif weight < 50.0 then
		return "60"
	elseif weight < 100.0 then
		return "80"
	elseif weight < 200.0 then
		return "100"
	else
		return "120"
	end
end

-- For Flail & Reversal
function Utils.calculateLowHPBasedDamage(currentHP, maxHP)
	local percentHP = (currentHP / maxHP) * 100
	if percentHP < 4.17 then
		return "200"
	elseif percentHP < 10.42 then
		return "150"
	elseif percentHP < 20.83 then
		return "100"
	elseif percentHP < 35.42 then
		return "80"
	elseif percentHP < 68.75 then
		return "40"
	else
		return "20"
	end
end

-- For Water Spout & Eruption
function Utils.calculateHighHPBasedDamage(currentHP, maxHP)
	local basePower = (150 * currentHP) / maxHP
	if basePower < 1 then 
		basePower = 1 
	end
	local roundedPower = math.floor(basePower + 0.5)
	return tostring(roundedPower)
end

function Utils.playerHasMove(moveName)
	local pokemon = Tracker.Data.playerPokemon 
	if pokemon~= nil then
		local currentMoves = {pokemon["move1"],pokemon["move2"],pokemon["move3"],pokemon["move4"]}
		for index, move in pairs(currentMoves) do
			if MoveData[move+1].name == moveName then
				return true
			end
		end
		return false
	end
	return false
end

function Utils.calculateTrumpCardPower(movePP)
	movePP = tonumber(movePP)
	local ppToPower = {
		[0] = "0",
		[1] = "200",
		[2] = "80",
		[3] = "60",
		[4] = "50",
		[5] = "40"
	}
	if movePP > 5 then movePP = 5 end
	return ppToPower[movePP]
end

function Utils.calculatePunishmentPower(targetMon)
	local totalIncreasedStats = 0
	local statStages = targetMon.statStages
	for i, stat in pairs(statStages) do
		if stat > 6 then
			totalIncreasedStats = totalIncreasedStats + (stat-6)
		end
	end
	local newPower = 60 + (20*totalIncreasedStats)
	if newPower < 60 then newPower = 60 end
	if newPower > 200 then newPower = 200 end
	return newPower
end

function  Utils.calculateWringCrushDamage(currentHP,maxHP)
	local basePower = 120*(currentHP/maxHP)
	local roundedPower = math.floor(basePower + 0.5)
	if GameSettings.gen == 4 then
		roundedPower = roundedPower + 1
	else
		if roundedPower < 1 then roundedPower = 1 end
	end
	return roundedPower
end

function Utils.calculateWeightDifferenceDamage(currentMon,targetMon)
	local currentMonWeight =  PokemonData[currentMon["pokemonID"] + 1].weight
	local targetWeight = PokemonData[targetMon["pokemonID"] + 1].weight
	local ratio = targetWeight / currentMonWeight
	if ratio <= .2 then
		return "120"
	elseif ratio <= .25 then
		return "100"
	elseif ratio <= .3334 then
		return "80"
	elseif ratio <= .50 then
		return "60"
	else return "40"
	end
end

function Utils.popupDialog(info,x,y,width,height,dialogType)
	local infoForm = forms.newform(width,height,dialogType,function() end)
	forms.setlocation(infoForm,x,y)
	local canvas = forms.pictureBox(infoForm,0,0,width,height)
	forms.drawText(canvas,10,10,info,0xFF000000,0x00000000,14,"Arial")
end

function Utils.fileExists(path)
	local file = io.open(path,"r")
	if file ~= nil then io.close(file) return true else return false end
end
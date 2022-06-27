Drawing = {
	pkmnStatOffsetX = 36,
	pkmnStatStartY = 5,
	pkmnStatOffsetY = 10,
	statBoxWidth = 101,
	statBoxHeight = 52,
	statusLevelOffset = 5,
	movesBoxStartY = 94,
	moveStartY = 97,
	distanceBetweenMoves = 10,
	moveTableHeaderHeightDiff = 14,
	moveOffset = 9,
}

function Drawing.clearGUI()
	gui.drawRectangle(GraphicConstants.SCREEN_WIDTH, 0, GraphicConstants.SCREEN_WIDTH + GraphicConstants.RIGHT_GAP, GraphicConstants.SCREEN_HEIGHT, 0xFF000000, 0xFF000000)
end

function Drawing.drawPokemonIcon(id, x, y)
	if id < 0 or id > #PokemonData then
		id = 0
	end
	gui.drawImage(DATA_FOLDER .. "/images/pokemonIcons/" .. id .. ".png", x+1, y-5)
	--gui.drawImage(DATA_FOLDER .. "/images/pokemon/" .. id .. ".gif", x+6, y-6, 32, 32)
	if PokemonData[id + 1].type[1] ~= "" then
		gui.drawImage(DATA_FOLDER .. "/images/types/" .. PokemonData[id + 1].type[1] .. ".png", x + 1, y + 28, 30, 12)
	end
	if PokemonData[id + 1].type[2] ~= "" then
		gui.drawImage(DATA_FOLDER .. "/images/types/" .. PokemonData[id + 1].type[2] .. ".png", x + 1, y + 40, 30, 12)
	end
end

--[[
Draws text for the tracker on screen with a shadow effect. Uses the Franklin Gothic Medium family with a 9 point size.

	x, y: integer -> pixel position for the text

	text: string -> the text to output to the screen

	color: string or integer -> the color for the text; the shadow effect will be black

	style: string -> optional; can be regular, bold, italic, underline, or strikethrough
]]
function Drawing.drawText(x, y, text, color, style, usesTopBoxFill)
	local shadow = nil
	if color == nil then
		color = GraphicConstants.layoutColors["Default text color"]
	end
	if usesTopBoxFill then
		shadow = Drawing.calcShadowColor(GraphicConstants.layoutColors["Top box background color"])
	else
		shadow = Drawing.calcShadowColor(GraphicConstants.layoutColors["Bottom box background color"])
	end

	if style == "Move header" then
		style = nil
		shadow = Drawing.calcShadowColor(GraphicConstants.layoutColors["Main background color"])
	end
	if Settings.ColorSettings.Draw_shadows then
		gui.drawText(x + 1, y + 1, text, shadow, nil, 9, "Franklin Gothic Medium", style)
	end
	gui.drawText(x, y, text, color, nil, 9, "Franklin Gothic Medium", style)
end

function Drawing.calcShadowColor(color)
	local color_hexval = (color-0xFF000000)

	local r = bit.rshift(color_hexval,16)
	local g = bit.rshift(bit.band(color_hexval, 0x00FF00), 8)
	local b = bit.band(color_hexval,0x0000FF)

	local scale = 0x10 -- read as: 6.25%
	local isDarkBG = (1 - (0.299 * r + 0.587 * g + 0.114 * b) / 255) >= 0.5;
	if isDarkBG then
		scale = 0xB0 -- read as: 69%
	end
	
	r = r - r * scale / 0x100
	g = g - g * scale / 0x100
	b = b - b * scale / 0x100

	

	color_hexval = bit.lshift(r,16) + bit.lshift(g,8) + b
	return (0xFF000000 + color_hexval)
end

--[[
Function that will add a space to a number so that the all the hundreds, tens and ones units are aligned if used
with the RIGHT_JUSTIFIED_NUMBERS setting.

	x, y: integer -> pixel position for the text

	number: string | number -> number to draw (stats, move power, pp...)

	spacing: number -> the number of digits the number can hold max; e.g. use 3 for a number that can be up to 3 digits.
		Move power, accuracy, and stats should have a 3 for `spacing`.
		PP should have 2 for `spacing`.
]]
function Drawing.drawNumber(x, y, number, spacing, color, style, usesTopBoxFill)
	local new_spacing
	new_spacing = 0

	if Settings.tracker.RIGHT_JUSTIFIED_NUMBERS then
		new_spacing = (spacing - string.len(tostring(number))) * 5
	end

	local shadow = nil
	if Settings.ColorSettings.Draw_shadows and color ~= nil then
		if usesTopBoxFill then
			shadow = Drawing.calcShadowColor(GraphicConstants.layoutColors["Top box background color"])
		else
			shadow = Drawing.calcShadowColor(GraphicConstants.layoutColors["Bottom box background color"])
		end
	end
	if Settings.ColorSettings.Draw_shadows then
		gui.drawText(x + 1 + new_spacing, y + 1, number, shadow, nil, 9, "Franklin Gothic Medium", style)
	end
	gui.drawText(x + new_spacing, y, number, color, nil, 9, "Franklin Gothic Medium", style)
end

function Drawing.drawTriangleRight(x, y, size, color)
	gui.drawRectangle(x, y, size, size, color)
	gui.drawPolygon({ { 4 + x, 4 + y }, { 4 + x, y + size - 4 }, { x + size - 4, y + size / 2 } }, color, color)
end

function Drawing.drawTriangleLeft(x, y, size, color)
	gui.drawRectangle(x, y, size, size, color)
	gui.drawPolygon({ { x + size - 4, 4 + y }, { x + size - 4, y + size - 4 }, { 4 + x, y + size / 2 } }, color, color)
end

function Drawing.drawChevronUp(x, y, width, height, thickness, color)
	local i = 0
	y = y + height + thickness + 1
	while i < thickness do
		gui.drawLine(x, y - i, x + (width / 2), y - i - height, color)
		gui.drawLine(x + (width / 2), y - i - height, x + width, y - i, color)
		i = i + 1
	end
end

function Drawing.drawChevronDown(x, y, width, height, thickness, color)
	local i = 0
	y = y + thickness + 2
	while i < thickness do
		gui.drawLine(x, y + i, x + (width / 2), y + i + height, color)
		gui.drawLine(x + (width / 2), y + i + height, x + width, y + i, color)
		i = i + 1
	end
end

function Drawing.moveToColor(move)
	return GraphicConstants.TYPECOLORS[move["type"]]
end

function Drawing.getNatureColor(stat, nature)
	local neutral = GraphicConstants.layoutColors["Default text color"]
	local increase = GraphicConstants.layoutColors["Positive text color"]
	local decrease = GraphicConstants.layoutColors["Negative text color"]

	local color = neutral
	if nature % 6 == 0 then
		color = neutral
	elseif stat == "atk" then
		if nature < 5 then
			color = increase
		elseif nature % 5 == 0 then
			color = decrease
		end
	elseif stat == "def" then
		if nature > 4 and nature < 10 then
			color = increase
		elseif nature % 5 == 1 then
			color = decrease
		end
	elseif stat == "spe" then
		if nature > 9 and nature < 15 then
			color = increase
		elseif nature % 5 == 2 then
			color = decrease
		end
	elseif stat == "spa" then
		if nature > 14 and nature < 20 then
			color = increase
		elseif nature % 5 == 3 then
			color = decrease
		end
	elseif stat == "spd" then
		if nature > 19 then
			color = increase
		elseif nature % 5 == 4 then
			color = decrease
		end
	end
	return color
end

function Drawing.drawStatusLevel(x, y, value)
	if value == 0 then
		Drawing.drawChevronDown(x, y, 4, 2, 1, GraphicConstants.layoutColors["Negative text color"])
		Drawing.drawChevronDown(x, y + 2, 4, 2, 1, GraphicConstants.layoutColors["Negative text color"])
		Drawing.drawChevronDown(x, y + 4, 4, 2, 1, GraphicConstants.layoutColors["Negative text color"])
	elseif value == 1 then
		Drawing.drawChevronDown(x, y, 4, 2, 1, GraphicConstants.layoutColors["Negative text color"])
		Drawing.drawChevronDown(x, y + 2, 4, 2, 1, GraphicConstants.layoutColors["Negative text color"])
		Drawing.drawChevronDown(x, y + 4, 4, 2, 1, GraphicConstants.layoutColors["Default text color"])
	elseif value == 2 then
		Drawing.drawChevronDown(x, y, 4, 2, 1, GraphicConstants.layoutColors["Negative text color"])
		Drawing.drawChevronDown(x, y + 2, 4, 2, 1, GraphicConstants.layoutColors["Default text color"])
		Drawing.drawChevronDown(x, y + 4, 4, 2, 1, GraphicConstants.layoutColors["Default text color"])
	elseif value == 3 then
		Drawing.drawChevronDown(x, y, 4, 2, 1, GraphicConstants.layoutColors["Default text color"])
		Drawing.drawChevronDown(x, y + 2, 4, 2, 1, GraphicConstants.layoutColors["Default text color"])
		Drawing.drawChevronDown(x, y + 4, 4, 2, 1, GraphicConstants.layoutColors["Default text color"])
	elseif value == 4 then
		Drawing.drawChevronDown(x, y, 4, 2, 1, GraphicConstants.layoutColors["Default text color"])
		Drawing.drawChevronDown(x, y + 2, 4, 2, 1, GraphicConstants.layoutColors["Default text color"])
	elseif value == 5 then
		Drawing.drawChevronDown(x, y, 4, 2, 1, GraphicConstants.layoutColors["Default text color"])
	elseif value == 7 then
		Drawing.drawChevronUp(x, y + 4, 4, 2, 1, GraphicConstants.layoutColors["Default text color"])
	elseif value == 8 then
		Drawing.drawChevronUp(x, y + 4, 4, 2, 1, GraphicConstants.layoutColors["Default text color"])
		Drawing.drawChevronUp(x, y + 2, 4, 2, 1, GraphicConstants.layoutColors["Default text color"])
	elseif value == 9 then
		Drawing.drawChevronUp(x, y, 4, 2, 1, GraphicConstants.layoutColors["Default text color"])
		Drawing.drawChevronUp(x, y + 2, 4, 2, 1, GraphicConstants.layoutColors["Default text color"])
		Drawing.drawChevronUp(x, y + 4, 4, 2, 1, GraphicConstants.layoutColors["Default text color"])
	elseif value == 10 then
		Drawing.drawChevronUp(x, y, 4, 2, 1, GraphicConstants.layoutColors["Default text color"])
		Drawing.drawChevronUp(x, y + 2, 4, 2, 1, GraphicConstants.layoutColors["Default text color"])
		Drawing.drawChevronUp(x, y + 4, 4, 2, 1, GraphicConstants.layoutColors["Positive text color"])
	elseif value == 11 then
		Drawing.drawChevronUp(x, y, 4, 2, 1, GraphicConstants.layoutColors["Default text color"])
		Drawing.drawChevronUp(x, y + 2, 4, 2, 1, GraphicConstants.layoutColors["Positive text color"])
		Drawing.drawChevronUp(x, y + 4, 4, 2, 1, GraphicConstants.layoutColors["Positive text color"])
	elseif value == 12 then
		Drawing.drawChevronUp(x, y, 4, 2, 1, GraphicConstants.layoutColors["Positive text color"])
		Drawing.drawChevronUp(x, y + 2, 4, 2, 1, GraphicConstants.layoutColors["Positive text color"])
		Drawing.drawChevronUp(x, y + 4, 4, 2, 1, GraphicConstants.layoutColors["Positive text color"])
	end
end

function Drawing.drawMoveEffectiveness(x, y, value)
	if value == 2 then
		Drawing.drawChevronUp(x, y + 4, 4, 2, 1, GraphicConstants.layoutColors["Positive text color"])
	elseif value == 4 then
		Drawing.drawChevronUp(x, y + 4, 4, 2, 1, GraphicConstants.layoutColors["Positive text color"])
		Drawing.drawChevronUp(x, y + 2, 4, 2, 1, GraphicConstants.layoutColors["Positive text color"])
	elseif value == 0.5 then
		Drawing.drawChevronDown(x, y, 4, 2, 1, GraphicConstants.layoutColors["Negative text color"])
	elseif value == 0.25 then
		Drawing.drawChevronDown(x, y, 4, 2, 1, GraphicConstants.layoutColors["Negative text color"])
		Drawing.drawChevronDown(x, y + 2, 4, 2, 1, GraphicConstants.layoutColors["Negative text color"])
	elseif value == 0 then
		Drawing.drawText(x, y, "X", GraphicConstants.layoutColors["Negative text color"],nil,false)
	end
end

function Drawing.drawButtons()
	---@diagnostic disable-next-line: deprecated
	for i = 1, table.getn(Buttons), 1 do
		if Buttons[i].visible() then
			if Buttons[i].type == ButtonType.singleButton then
				if Buttons[i] ~= HiddenPowerButton and Buttons[i].backgroundcolor ~= "" then
					gui.drawRectangle(Buttons[i].box[1], Buttons[i].box[2], Buttons[i].box[3], Buttons[i].box[4], 
						GraphicConstants.layoutColors[Buttons[i].backgroundcolor[1]], GraphicConstants.layoutColors[Buttons[i].backgroundcolor[2]])
				end
				local extraY = 1
				if Buttons[i].text == "--" then extraY = 0 end
				Drawing.drawText(Buttons[i].box[1], Buttons[i].box[2] + (Buttons[i].box[4] - 12) / 2 + extraY, Buttons[i].text,
				GraphicConstants.layoutColors[Buttons[i].textcolor],nil,true)
			end
		end
	end
	local badgePrefix = ButtonManager.BADGE_GAME_PREFIX
	for index, button in pairs(ButtonManager.badgeButtons) do
		if button.visible() then
			local addForOff = ""
			if button.state == 0 then addForOff = "_OFF" end
			local path = DATA_FOLDER .. "/images/icons/" .. badgePrefix .. "_badge"..index..addForOff..".png"
			gui.drawImage(path,button.box[1], button.box[2])
		end
	end
end

function Drawing.drawInputOverlay()
	if (Tracker.controller.framesSinceInput < Tracker.controller.boxVisibleFrames) and (Tracker.Data.selectedPlayer == 2) then
		gui.drawRectangle(Buttons[Tracker.controller.statIndex].box[1], Buttons[Tracker.controller.statIndex].box[2], Buttons[Tracker.controller.statIndex].box[3], Buttons[Tracker.controller.statIndex].box[4], "yellow", 0x000000)
	end
end

function Drawing.drawHPColor(monToDraw)
	local colorbar = GraphicConstants.layoutColors["Default text color"]
	if Tracker.Data.selectedPlayer == 1 then
		if monToDraw["curHP"] / monToDraw["maxHP"] <= 0.2 then
			colorbar = GraphicConstants.layoutColors["Negative text color"]
		elseif monToDraw["curHP"] / monToDraw["maxHP"] <= 0.5 then
			colorbar = "yellow"
		end
	end
	return colorbar
end

function Drawing.drawHeals(monIsEnemy)
	if monIsEnemy == false then
		Drawing.drawText(GraphicConstants.SCREEN_WIDTH + 6, 57, "Heals in Bag:", GraphicConstants.layoutColors["Default text color"],nil,true)
		Drawing.drawText(GraphicConstants.SCREEN_WIDTH + 6, 67, string.format("%.0f%%", Tracker.Data.healingItems.healing) .. " HP (" .. Tracker.Data.healingItems.numHeals .. ")", GraphicConstants.layoutColors["Default text color"],nil,true)
	end
end

function Drawing.drawAccEvasion(monToDraw)
	if Settings.tracker.SHOW_ACCURACY_AND_EVASION then
		Drawing.drawText(GraphicConstants.SCREEN_WIDTH + 75, 58, "ACC", GraphicConstants.layoutColors["Default text color"],nil,true)
		Drawing.drawText(GraphicConstants.SCREEN_WIDTH + 75, 68, "EVA", GraphicConstants.layoutColors["Default text color"],nil,true)
		Drawing.drawStatusLevel(GraphicConstants.SCREEN_WIDTH + 94,58,monToDraw.statStages["ACC"])
		Drawing.drawStatusLevel(GraphicConstants.SCREEN_WIDTH + 94,68,monToDraw.statStages["EVA"])
	end
end

function Drawing.drawAbilityAndHeldItem(monIsEnemy,monToDraw)
	local abilityString = Utils.inlineIf(monIsEnemy, "---", MiscData.ability[monToDraw["ability"] + 1])
	if monIsEnemy then
		for k, v in pairs(Tracker.Data.enemyPokemon.abilities) do
			if v == monToDraw["ability"] then
				local abilityId = monToDraw["ability"] + 1
				abilityString = MiscData.ability[abilityId]
			end
		end
	end
	-- Held item & ability
	if monIsEnemy == false then
		local item = MiscData.item[monToDraw["heldItem"] + 1]
		Drawing.drawText(GraphicConstants.SCREEN_WIDTH + Drawing.pkmnStatOffsetX, Drawing.pkmnStatStartY + (Drawing.pkmnStatOffsetY * 3), item, GraphicConstants.layoutColors["Intermediate text color"],nil,true)
		Drawing.drawText(GraphicConstants.SCREEN_WIDTH + Drawing.pkmnStatOffsetX, Drawing.pkmnStatStartY + (Drawing.pkmnStatOffsetY * 4), abilityString, GraphicConstants.layoutColors["Intermediate text color"],nil,true)
	end
end

function Drawing.drawStatsAndStages(monIsEnemy,monToDraw)
	local statBoxY = 5
	local statOffsetX = Drawing.statBoxWidth + 1
	local statValueOffsetX = Drawing.statBoxWidth + 26
	local statInc = 10
	local margin = 5
	local stats = {
		"hp", "atk", "def", "spa","spd","spe"
	}
	local statStages = {
		"HP","ATK","DEF","SPE","SPA","SPD","ACC","EVA"
	}

	local hpY = 7
	local bstY = 7 + (statInc * 6)

	gui.drawRectangle(GraphicConstants.SCREEN_WIDTH + Drawing.statBoxWidth, statBoxY, GraphicConstants.RIGHT_GAP - Drawing.statBoxWidth - margin, 75, 
	GraphicConstants.layoutColors["Top box border color"], GraphicConstants.layoutColors["Top box background color"])

	for i,stat in pairs(stats) do
		local color = Utils.inlineIf(monIsEnemy, GraphicConstants.layoutColors["Default text color"], Drawing.getNatureColor(stat, monToDraw["nature"]))
		Drawing.drawText(GraphicConstants.SCREEN_WIDTH + statOffsetX-2, hpY+((i-1)*statInc), " "..string.upper(stat), color, "regular",true)
	end

	Drawing.drawText(GraphicConstants.SCREEN_WIDTH + statOffsetX, bstY, "BST", GraphicConstants.layoutColors["Default text color"],nil,true)
	Drawing.drawText(GraphicConstants.SCREEN_WIDTH + statValueOffsetX, bstY, PokemonData[monToDraw["pokemonID"] + 1].bst, GraphicConstants.layoutColors["Default text color"],nil,true)

	if monIsEnemy == false then
		Drawing.drawNumber(GraphicConstants.SCREEN_WIDTH + statValueOffsetX, hpY, monToDraw["maxHP"], 3, Drawing.getNatureColor("hp", monToDraw["nature"]), "regular",true)
		for i, stat in pairs(stats) do
			Drawing.drawNumber(GraphicConstants.SCREEN_WIDTH + statValueOffsetX, hpY+((i-1)*statInc), monToDraw[stat], 3, Drawing.getNatureColor(stat, monToDraw["nature"]), "regular",true)
		end
	end

	-- Stat stages -6 -> +6
	if Tracker.Data.inBattle == 1 and monToDraw["statStages"] then
		Drawing.drawAccEvasion(monToDraw)
		for i,stat in pairs(stats) do
			local statStage = string.upper(stat)
			Drawing.drawStatusLevel(GraphicConstants.SCREEN_WIDTH + statValueOffsetX - Drawing.statusLevelOffset, hpY+((i-1)*statInc), monToDraw.statStages[statStage])
		end
	end
end

function Drawing.DrawTracker(monIsEnemy)
	local monToDraw = Utils.inlineIf(monIsEnemy,Tracker.Data.enemyPokemon,Tracker.Data.playerPokemon)
	if monToDraw == nil then return end

	--Main rectangle
	gui.drawRectangle(GraphicConstants.SCREEN_WIDTH,0,GraphicConstants.RIGHT_GAP,164,
	0x00000000, GraphicConstants.layoutColors["Main background color"])

	local x,y = GraphicConstants.SCREEN_WIDTH + GraphicConstants.BORDER_MARGIN, GraphicConstants.BORDER_MARGIN
	gui.drawRectangle(x,y, Drawing.statBoxWidth - GraphicConstants.BORDER_MARGIN, Drawing.statBoxHeight, 
	GraphicConstants.layoutColors["Top box border color"], GraphicConstants.layoutColors["Top box background color"])

	Images.drawImage(ImageTypes.GEAR,GraphicConstants.SCREEN_WIDTH + Drawing.statBoxWidth - 9, 7)

	Drawing.drawPokemonIcon(monToDraw["pokemonID"], GraphicConstants.SCREEN_WIDTH + 5, 5)
	local colorbar = Drawing.drawHPColor(monToDraw)
	local currentHP = Utils.inlineIf(monIsEnemy, "?", monToDraw["curHP"])
	local maxHP = Utils.inlineIf(monIsEnemy, "?", monToDraw["maxHP"])

	Drawing.drawText(GraphicConstants.SCREEN_WIDTH + Drawing.pkmnStatOffsetX,  Drawing.pkmnStatStartY, PokemonData[monToDraw["pokemonID"] + 1].name,GraphicConstants.layoutColors["Default text color"],nil,true)
	Drawing.drawText(GraphicConstants.SCREEN_WIDTH + Drawing. pkmnStatOffsetX,  Drawing.pkmnStatStartY + ( Drawing.pkmnStatOffsetY * 1), "HP:",GraphicConstants.layoutColors["Default text color"],nil,true)
	Drawing.drawText(GraphicConstants.SCREEN_WIDTH + 52,  Drawing.pkmnStatStartY + ( Drawing.pkmnStatOffsetY * 1), currentHP .. "/" .. maxHP, colorbar,nil,true)
	local levelDetails = "Lv." .. monToDraw.level
	local evolutionDetails = " (" .. PokemonData[monToDraw["pokemonID"] + 1].evolution .. ")"
	Drawing.drawText(GraphicConstants.SCREEN_WIDTH +  Drawing.pkmnStatOffsetX, Drawing. pkmnStatStartY + ( Drawing.pkmnStatOffsetY * 2), levelDetails .. evolutionDetails,
	GraphicConstants.layoutColors["Default text color"],nil,true)

	local infoBoxHeight = 23

	gui.drawRectangle(GraphicConstants.SCREEN_WIDTH + GraphicConstants.BORDER_MARGIN, GraphicConstants.BORDER_MARGIN + Drawing.statBoxHeight, Drawing.statBoxWidth - GraphicConstants.BORDER_MARGIN, infoBoxHeight, 
	GraphicConstants.layoutColors["Top box border color"], GraphicConstants.layoutColors["Top box background color"])

	Drawing.drawHeals(monIsEnemy)
	Drawing.drawPokecenterHeals()
	Drawing.drawAbilityAndHeldItem(monIsEnemy,monToDraw)
	Drawing.drawStatsAndStages(monIsEnemy,monToDraw)
	Drawing.drawMoves(monToDraw,monIsEnemy)
end

function Drawing.drawPokecenterHeals()
	if Settings.tracker.SHOW_POKECENTER_HEALS then
		if Tracker.Data.inBattle == 0 or not Settings.tracker.SHOW_ACCURACY_AND_EVASION then
			local pokecenterIcon = DATA_FOLDER .. "/images/icons/healicon2.png"
			gui.drawImage(pokecenterIcon,GraphicConstants.SCREEN_WIDTH + 69,65)
			Drawing.drawText(GraphicConstants.SCREEN_WIDTH + 78,64,Tracker.Data.pokecenterCount, GraphicConstants.layoutColors["Default text color"],nil,true)
		end
	end
end

function Drawing.drawMoves(monToDraw,monIsEnemy)
	gui.drawRectangle(GraphicConstants.SCREEN_WIDTH + GraphicConstants.BORDER_MARGIN, Drawing.movesBoxStartY, GraphicConstants.RIGHT_GAP - (2 * GraphicConstants.BORDER_MARGIN), 46, 
	GraphicConstants.layoutColors["Bottom box border color"], GraphicConstants.layoutColors["Bottom box background color"])
	local movesLearnedSinceLevel = Drawing.findMovesLearnedSinceLevel(monToDraw)
	local moveAgeRank = Drawing.getAgeRank(monIsEnemy)
	local stars = Drawing.getStars(movesLearnedSinceLevel,monIsEnemy,moveAgeRank)
	local moves = Drawing.setupInitialMovesArray(monIsEnemy)

	local subAmount = Utils.inlineIf(Settings.tracker.SHOW_POKECENTER_HEALS,10,10)
	--Bottom rectangle
	gui.drawRectangle(GraphicConstants.SCREEN_WIDTH + GraphicConstants.BORDER_MARGIN, 140, GraphicConstants.RIGHT_GAP-subAmount, 19, 
	GraphicConstants.layoutColors["Bottom box border color"], GraphicConstants.layoutColors["Bottom box background color"])
	-- Moves Learned
	local moveColors = {}
	for moveIndex = 1, 4, 1 do
		table.insert(moveColors, Drawing.moveToColor(moves[moveIndex]))
	end
	local targetMon = Utils.inlineIf(monIsEnemy,Tracker.Data.playerPokemon,Tracker.Data.enemyPokemon)
	local stabColors = Drawing.setupSTABColors(moves,monToDraw)

	local movesString = Drawing.getMovesString(monToDraw)
	Drawing.drawMoveNames(moves,monIsEnemy,movesString,moveColors,stars)

	local PPs = Drawing.fillMovePPs(moves,monToDraw,monIsEnemy)
	Drawing.drawMoveCategories(moves)
	Drawing.drawMovePPs(moves,monToDraw,monIsEnemy,PPs)
	Drawing.drawMovePowers(moves,monIsEnemy,stabColors,PPs)
	Drawing.drawMoveAccuracies(moves)
	Drawing.drawAllMovesEffectiveness(targetMon,moves)
	Drawing.drawButtons()
	Drawing.drawInputOverlay()
	Drawing.drawNoteBox()
end

function Drawing.getStars(movesLearnedSinceLevel,monIsEnemy,moveAgeRank)
	local stars = {
		"","","",""
	}
	for i,movesLearned in pairs(movesLearnedSinceLevel) do
		if monIsEnemy and Tracker.Data.enemyPokemon.moves[i].level ~= 1 and movesLearned > moveAgeRank[i] then
			stars[i] = "*"
		end
	end
	return stars
end

function Drawing.getAgeRank(monIsEnemy)
	local moveAgeRank = {
		1,
		1,
		1,
		1
	}
	if monIsEnemy and Tracker.Data.enemyPokemon~=nil then
		for i, move in pairs(Tracker.Data.enemyPokemon.moves) do
			for j, move2 in pairs(Tracker.Data.enemyPokemon.moves) do
				if i ~= j then
					if move.level > move2.level then
						moveAgeRank[i] = moveAgeRank[i] + 1
					end
				end
			end
		end
	end
	return moveAgeRank
end

function Drawing.findMovesLearnedSinceLevel(monToDraw)
	local movesLearnedSinceLevel = {
		0,0,0,0
	}
	local monData = PokemonData[monToDraw["pokemonID"] + 1]
	local moveLevels = monData.movelvls[GameSettings.versiongroup]
	local monLevel = monToDraw["level"]
	if Tracker.Data.enemyPokemon~=nil then
		for i, level in pairs(moveLevels) do
			for j, enemyMove in pairs(Tracker.Data.enemyPokemon.moves) do
				if level > enemyMove.level and level <= monLevel then
					movesLearnedSinceLevel[j] = movesLearnedSinceLevel[j]+1
				end
			end
		end
	end
	return movesLearnedSinceLevel
end

function Drawing.setupInitialMovesArray(monIsEnemy)
	local moves = {}
	local playerMon = Tracker.Data.playerPokemon
	local enemyMon = Tracker.Data.enemyPokemon
	for i = 1,4,1 do
		local insertValue = nil
		if not monIsEnemy then
			insertValue = MoveData[playerMon.actualMoves[i]+1]
		else
			insertValue = MoveData[enemyMon.moves[i].move]
		end
		table.insert(moves,insertValue)
	end
	return moves
end

function Drawing.setupSTABColors(moves,monToDraw)
	local stabColors = {}
	for moveIndex = 1, 4, 1 do
		local isSTAB = Utils.isSTAB(moves[moveIndex], PokemonData[monToDraw["pokemonID"] + 1])
		local shouldCheck = Tracker.Data.inBattle == 1 and moves[moveIndex].power ~= NOPOWER
		table.insert(stabColors, Utils.inlineIf(isSTAB and shouldCheck, GraphicConstants.layoutColors["Positive text color"], GraphicConstants.layoutColors["Default text color"]))
	end
	return stabColors
end

function Drawing.drawMoveCategories(moves)
	-- Move category: physical, special, or status effect
	local physicalCatLocation = DATA_FOLDER .. "/images/icons/physical5.png"
	local specialCatLocation =  DATA_FOLDER .. "/images/icons/special3.png"
	local moveCategoryToIcon = {
		[MoveCategories.PHYSICAL] = ImageTypes.PHYSICAL,
		[MoveCategories.SPECIAL] = ImageTypes.SPECIAL,
		[MoveCategories.STATUS] = "",
		[MoveCategories.NONE] = ""
	}
	local categories = {}
	for moveIndex = 1, 4, 1 do
		local category = moves[moveIndex].category
		table.insert(categories, moveCategoryToIcon[category])
	end
	if Settings.tracker.SHOW_MOVE_CATEGORIES then
		for catIndex = 0, 3, 1 do
			local category = categories[catIndex+1]
			if category ~= "" then
				Images.drawImage(category,GraphicConstants.SCREEN_WIDTH + Drawing.moveOffset, Drawing.moveStartY + 3 + (Drawing.distanceBetweenMoves * catIndex))
				--gui.drawImage(categories[catIndex + 1], GraphicConstants.SCREEN_WIDTH + Drawing.moveOffset, Drawing.moveStartY + 3 + (Drawing.distanceBetweenMoves * catIndex))
			end
		end
	end
end

function Drawing.getMovesString(monToDraw)
	local movelevellist = PokemonData[monToDraw["pokemonID"] + 1].movelvls -- pokemonID
	local moveCount = 0
	local movesLearned = 0
	local nextMove = 0
	local foundNextMove = false
	for k, v in pairs(movelevellist[GameSettings.versiongroup]) do 
		moveCount = moveCount + 1
		if v <= monToDraw["level"] then
			movesLearned = movesLearned + 1
		else
			if foundNextMove == false then
				nextMove = v
				foundNextMove = true
			end
		end
	end

	local movesString = "Move ~  "
	movesString = movesString .. movesLearned .. "/" .. moveCount
	if nextMove ~= 0 then
		movesString = movesString .. " (" .. nextMove .. ")"
	end
	return movesString
end

function Drawing.drawMoveNames(moves,monIsEnemy,movesString,moveColors,stars)
	local nameOffset = Utils.inlineIf(Settings.tracker.SHOW_MOVE_CATEGORIES, 17, Drawing.moveOffset - 1)
	Drawing.drawText(GraphicConstants.SCREEN_WIDTH + Drawing.moveOffset - 2, Drawing.moveStartY - Drawing.moveTableHeaderHeightDiff, movesString,
	GraphicConstants.layoutColors["Move header text color"],"Move header",false)
	for moveIndex = 1, 4, 1 do
		if moves[moveIndex].name == "Hidden Power" and not monIsEnemy then
			HiddenPowerButton.box[1] = GraphicConstants.SCREEN_WIDTH + nameOffset
			HiddenPowerButton.box[2] = Drawing.moveStartY + (Drawing.distanceBetweenMoves * (moveIndex - 1))
		else
			local color = GraphicConstants.layoutColors["Default text color"]
			if Settings.ColorSettings.Colored_move_names then
				color = moveColors[moveIndex]
			end
			Drawing.drawText(GraphicConstants.SCREEN_WIDTH + nameOffset, Drawing.moveStartY + (Drawing.distanceBetweenMoves * (moveIndex - 1)), moves[moveIndex].name .. stars[moveIndex], 
			color,nil,false)
		end
	end
end

function Drawing.fillMovePPs(moves, monToDraw, monIsEnemy)
	--The tracked moves are not a 1:1 index to the actual moves the enemy mon has.
	--Match them up with the actual move and map the PP correctly.
	local PPs = {}
	if monIsEnemy then
		for i, move in pairs(moves) do
			local id = move.id
			if id ~= "---" then
				if Settings.tracker.SHOW_ACTUAL_ENEMY_PP then
					for j, actualMove in pairs(monToDraw.actualMoves) do
						if actualMove == tonumber(id) then
							PPs[i] = monToDraw.movePPs[j]
						end
					end
				else
					PPs[i] = MoveData[id+1].pp
				end
			else
				PPs[i] = ""
			end
		end
	end
	return PPs
end

function Drawing.drawMovePPs(moves,monToDraw,monIsEnemy,PPs)
	local ppOffset = 82
	Drawing.drawText(GraphicConstants.SCREEN_WIDTH + ppOffset, Drawing.moveStartY - Drawing.moveTableHeaderHeightDiff, "PP",
	GraphicConstants.layoutColors["Move header text color"],"Move header",false)
	for moveIndex = 1, 4, 1 do
		local pp = Utils.inlineIf(monIsEnemy,PPs[moveIndex],monToDraw.movePPs[moveIndex])
		if moves[moveIndex].id == "---" then pp = "" end
		Drawing.drawNumber(GraphicConstants.SCREEN_WIDTH + ppOffset, Drawing.moveStartY + (Drawing.distanceBetweenMoves * (moveIndex - 1)),pp,2,
		GraphicConstants.layoutColors["Default text color"],nil,false)
	end
end

function Drawing.drawMovePowers(moves,monIsEnemy,stabColors,movePPs)
	local currentMon = Utils.inlineIf(monIsEnemy,Tracker.Data.enemyPokemon,Tracker.Data.playerPokemon)
	local targetMon = Utils.inlineIf(monIsEnemy,Tracker.Data.playerPokemon,Tracker.Data.enemyPokemon)
	local powerOffset = 102
	local currentHP = Utils.inlineIf(monIsEnemy, "?", currentMon["curHP"])
	local maxHP = Utils.inlineIf(monIsEnemy, "?", currentMon["maxHP"])
	Drawing.drawText(GraphicConstants.SCREEN_WIDTH + powerOffset, Drawing.moveStartY - Drawing.moveTableHeaderHeightDiff, "Pow",
	GraphicConstants.layoutColors["Move header text color"],"Move header",false)
	for moveIndex = 1, 4, 1 do
		local pp = Utils.inlineIf(monIsEnemy,movePPs[moveIndex],currentMon.movePPs[moveIndex])
		local movePower = moves[moveIndex].power
		local name = moves[moveIndex].name
		if Settings.tracker.CALCULATE_VARIABLE_DAMAGE == true then
			local newPower = movePower
			if movePower == "WT" and targetMon ~= nil and Tracker.Data.inBattle == 1 then
				local targetWeight = PokemonData[targetMon["pokemonID"] + 1].weight
				newPower = Utils.calculateWeightBasedDamage(targetWeight)
			end
			if not monIsEnemy then
				if name == "Flail" or name == "Reversal" and not monIsEnemy then
					newPower = Utils.calculateLowHPBasedDamage(currentHP, maxHP)
				elseif name == "Eruption" or name == "Water Spout" and not monIsEnemy then
					newPower = Utils.calculateHighHPBasedDamage(currentHP, maxHP)
				end
			end
			if name == "Trump Card" then
				newPower = Utils.calculateTrumpCardPower(pp)
			else
				if targetMon ~= nil  and Tracker.Data.inBattle == 1 then
					if name == "Punishment" and targetMon.statStages ~= nil then
						newPower = Utils.calculatePunishmentPower(targetMon)
					elseif name == "Heat Crash" or name == "Heavy Slam" then
						newPower = Utils.calculateWeightDifferenceDamage(currentMon,targetMon)
					end
				end
			end
			Drawing.drawText(GraphicConstants.SCREEN_WIDTH + powerOffset, Drawing.moveStartY + (Drawing.distanceBetweenMoves * (moveIndex - 1)), newPower, stabColors[moveIndex],nil,false)
		else
			Drawing.drawText(GraphicConstants.SCREEN_WIDTH + powerOffset, Drawing.moveStartY + (Drawing.distanceBetweenMoves * (moveIndex - 1)), movePower, stabColors[moveIndex],nil,false)
		end
	end
end

function Drawing.drawMoveAccuracies(moves)
	local accOffset = 126
	Drawing.drawText(GraphicConstants.SCREEN_WIDTH + accOffset, Drawing.moveStartY - Drawing.moveTableHeaderHeightDiff, "Acc",
	GraphicConstants.layoutColors["Move header text color"],"Move header",false)
	for moveIndex = 1, 4, 1 do
		Drawing.drawNumber(GraphicConstants.SCREEN_WIDTH + accOffset, Drawing.moveStartY + (Drawing.distanceBetweenMoves * (moveIndex - 1)), moves[moveIndex].accuracy, 3,
		GraphicConstants.layoutColors["Default text color"],nil,false)
	end
end

function Drawing.drawAllMovesEffectiveness(targetMon,moves)
	local powerOffset = 102
	if Settings.tracker.SHOW_MOVE_EFFECTIVENESS and Tracker.Data.inBattle == 1 then
		if targetMon ~= nil then
			for moveIndex = 1, 4, 1 do
				local effectiveness = Utils.netEffectiveness(moves[moveIndex], PokemonData[targetMon.pokemonID + 1])
				Drawing.drawMoveEffectiveness(GraphicConstants.SCREEN_WIDTH + powerOffset - Drawing.statusLevelOffset, Drawing.moveStartY + (Drawing.distanceBetweenMoves * (moveIndex - 1)), effectiveness)
			end
		end
	end
end

function Drawing.drawNoteBox()
	if Tracker.Data.inBattle == 1 and Tracker.Data.selectedPlayer == 2 then
		local note = Tracker.GetNote()
		local charMax = Utils.inlineIf(Settings.tracker.SHOW_POKECENTER_HEALS,18,25)
		if string.len(note) > charMax then
			note = string.sub(note,1,charMax) .. ".."
		end
		if note == '' then
			gui.drawImage(DATA_FOLDER .. "/images/icons/editnote.png", GraphicConstants.SCREEN_WIDTH + GraphicConstants.BORDER_MARGIN + 3, Drawing.movesBoxStartY + 50)
		else
			Drawing.drawText(GraphicConstants.SCREEN_WIDTH + GraphicConstants.BORDER_MARGIN+1, Drawing.movesBoxStartY + 53, note,
			GraphicConstants.layoutColors["Default text color"],nil,false)
			--work around limitation of drawText not having width limit: paint over any spillover
			local x = GraphicConstants.SCREEN_WIDTH + GraphicConstants.RIGHT_GAP - 5
			local y = 141
			gui.drawRectangle(x + 1, y, 12, 12, 0xFF000000, 0xFF000000)
		end
	end
end

function Drawing.truncateRomsFolder(folder)
	if folder then
		if string.len(folder) > 10 then
			return "..." .. string.sub(folder, string.len(folder) - 10)
		else
			return folder
		end
	else
		return ""
	end
end

function Drawing.drawSettings()
	--Main rectangle
	gui.drawRectangle(GraphicConstants.SCREEN_WIDTH,0,GraphicConstants.RIGHT_GAP,160,
	0x00000000, GraphicConstants.layoutColors["Main background color"])

	local rightEdge = GraphicConstants.RIGHT_GAP - (2 * GraphicConstants.BORDER_MARGIN)
	local bottomEdge = GraphicConstants.SCREEN_HEIGHT - (2 * GraphicConstants.BORDER_MARGIN)

	-- Settings view box
	gui.drawRectangle(GraphicConstants.SCREEN_WIDTH + GraphicConstants.BORDER_MARGIN, GraphicConstants.BORDER_MARGIN, rightEdge, bottomEdge, 
	GraphicConstants.layoutColors["Top box border color"], GraphicConstants.layoutColors["Top box background color"])

	-- Cancel/close button
	gui.drawRectangle(Options.closeButton.box[1], Options.closeButton.box[2], Options.closeButton.box[3], Options.closeButton.box[4], 
		GraphicConstants.layoutColors[Options.closeButton.backgroundColor[1]], GraphicConstants.layoutColors[Options.closeButton.backgroundColor[2]])

	Drawing.drawText(Options.closeButton.box[1] + 3, Options.closeButton.box[2], Options.closeButton.text, GraphicConstants.layoutColors["Default text color"],nil,true)

	-- Open Color Options button
	local box = Options.openColorOptions.box

	gui.drawRectangle(box[1], box[2], box[3], box[4], 
		GraphicConstants.layoutColors[Options.openColorOptions.backgroundColor[1]], GraphicConstants.layoutColors[Options.openColorOptions.backgroundColor[2]])

	Drawing.drawText(box[1] + 3, box[2], Options.openColorOptions.text, GraphicConstants.layoutColors["Default text color"],nil,true)

	-- Roms folder setting
	local folder = Drawing.truncateRomsFolder(Settings.config.ROMS_FOLDER)
	Drawing.drawText(Options.romsFolderOption.box[1], Options.romsFolderOption.box[2], Options.romsFolderOption.text .. folder, 
		GraphicConstants.layoutColors["Default text color"],nil,true)

	if folder == "" then
		gui.drawImage(DATA_FOLDER .. "/images/icons/editnote.png", GraphicConstants.SCREEN_WIDTH + 60, GraphicConstants.BORDER_MARGIN + 2)
	end

	-- Draw toggleable settings
	for _, button in pairs(Options.optionsButtons) do
		gui.drawRectangle(button.box[1], button.box[2], button.box[3], button.box[4], 
		button.backgroundColor[1], GraphicConstants.layoutColors[button.backgroundColor[2]])
		Drawing.drawText(button.box[1] + button.box[3] + 1, button.box[2] - 1, button.text, GraphicConstants.layoutColors["Default text color"],nil,true)
		-- Draw a mark if the feature is on
		if button.optionState then
			gui.drawLine(button.box[1]+1,button.box[2]+4,button.box[1]+3,button.box[2]+7, GraphicConstants.layoutColors["Positive text color"])
			gui.drawLine(button.box[1]+3,button.box[2]+7,button.box[1]+button.box[3]-1,button.box[2]+1, GraphicConstants.layoutColors["Positive text color"])
		end
	end
end

function Drawing.drawColorOptions()
	local COLOR_OPTION_X_OFFSET = 150
	--Main rectangle
	gui.drawRectangle(GraphicConstants.SCREEN_WIDTH+COLOR_OPTION_X_OFFSET,0,GraphicConstants.RIGHT_GAP,286,
	0x00000000, GraphicConstants.layoutColors["Main background color"])

	local rightEdge = GraphicConstants.RIGHT_GAP - (2 * GraphicConstants.BORDER_MARGIN)
	local bottomEdge = GraphicConstants.SCREEN_HEIGHT - (2 * GraphicConstants.BORDER_MARGIN)

	-- Color options view
	gui.drawRectangle(GraphicConstants.SCREEN_WIDTH + GraphicConstants.BORDER_MARGIN+ COLOR_OPTION_X_OFFSET , GraphicConstants.BORDER_MARGIN, rightEdge, bottomEdge+126, 
	GraphicConstants.layoutColors["Bottom box border color"], GraphicConstants.layoutColors["Bottom box background color"])

	-- Color options top rectangle
	gui.drawRectangle(GraphicConstants.SCREEN_WIDTH + GraphicConstants.BORDER_MARGIN + COLOR_OPTION_X_OFFSET, GraphicConstants.BORDER_MARGIN, rightEdge, 28, 
	GraphicConstants.layoutColors["Bottom box border color"], GraphicConstants.layoutColors["Bottom box background color"])

	-- Color options bottom rectangle
	gui.drawRectangle(GraphicConstants.SCREEN_WIDTH + GraphicConstants.BORDER_MARGIN + COLOR_OPTION_X_OFFSET, GraphicConstants.BORDER_MARGIN + 204, rightEdge, 44, 
	GraphicConstants.layoutColors["Bottom box border color"], GraphicConstants.layoutColors["Bottom box background color"])

	for _, button in pairs(ColorOptions.mainButtons) do
		local box = button.box
		gui.drawRectangle(box[1], box[2], box[3], box[4], GraphicConstants.layoutColors[button.backgroundColor[1]], GraphicConstants.layoutColors[button.backgroundColor[2]])
		Drawing.drawText(box[1] + 3, box[2], button.text, GraphicConstants.layoutColors["Default text color"],nil,false)
	end

	for _, button in pairs(ColorOptions.colorButtons) do
		local box = button.box
		gui.drawEllipse(box[1], box[2], box[3], box[4], 0xFF000000, GraphicConstants.layoutColors[button.backgroundColor[2]])
		Drawing.drawText(box[1] + 12, box[2]-1, button.text, GraphicConstants.layoutColors["Default text color"],nil,false)
	end

	local toggles = {ColorOptions.toggleMoveColorButton,ColorOptions.toggleShadowsButton}

	for _, button in pairs(toggles) do
		gui.drawRectangle(button.box[1], button.box[2], button.box[3], button.box[4], 
		button.backgroundColor[1], GraphicConstants.layoutColors[button.backgroundColor[2]])
		Drawing.drawText(button.box[1] + 11, button.box[2] - 2, button.text, GraphicConstants.layoutColors["Default text color"],nil,false)
		-- Draw a mark if the feature is on
		if button.optionState then
			gui.drawLine(button.box[1]+1,button.box[2]+4,button.box[1]+3,button.box[2]+7, GraphicConstants.layoutColors["Positive text color"])
			gui.drawLine(button.box[1]+3,button.box[2]+7,button.box[1]+button.box[3]-1,button.box[2]+1, GraphicConstants.layoutColors["Positive text color"])
		end
	end
end

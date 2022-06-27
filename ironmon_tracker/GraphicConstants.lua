GraphicConstants = {
	UP_GAP = 0,
	DOWN_GAP = 0,
	RIGHT_GAP = 150,
	SCREEN_HEIGHT = 160,
	SCREEN_WIDTH = 256,
	BORDER_MARGIN = 5,

	TYPECOLORS = {
		normal = 0xFFA7A879,
		fighting = 0xFFB82A23,
		flying = 0xFFA88FEF,
		poison = 0xFF9B3C9E,
		ground = 0xFFDCC06A,
		rock = 0xFFB5A03B,
		bug = 0xFFA8B92A,
		ghost = 0xFF6F5797,
		steel = 0xFFB8B8D0,
		fire = 0xFFE87E2E,
		water = 0xFF708FEF,
		grass = 0xFF80C956,
		electric = 0xFFF3D036,
		psychic = 0xFFEF5285,
		ice = 0xFF9FD9D8,
		dragon = 0xFF7131F6,
		dark = 0xFF6E5848,
		fairy = 0xFFEE99AC,
		unknown = 0xFF68A090, -- For the "Curse" move in Gen 2 - 4
	},
	layoutColors = {
		["Main background color"] = 		0xFF000000,
		["Default text color"] = 			0xFFFFFFFF,
		["Positive text color"] = 			0xFF00FF00,
		["Negative text color"] = 			0xFFFF0000,
		["Intermediate text color"] = 		0xFFFFFF00,
		["Move header text color"] = 		0xFFFFFFFF,
		["Top box border color"] =			0xFFAAAAAA,
		["Top box background color"] = 		0xFF222222,
		["Bottom box border color"] = 		0xFFAAAAAA,
		["Bottom box background color"] = 	0xFF222222,
		["Physical icon color"] = 			0xFFFFC631,
		["Special icon color"] = 			0xFF3E5782,
		["Gear icon color"] = 				0xFFDBDBDB,
	},

	layoutColorKeysOrdered = {
		"Default text color",
		"Positive text color",
		"Negative text color",
		"Intermediate text color",
		"Move header text color",
		"Top box border color",
		"Top box background color",
		"Bottom box border color",
		"Bottom box background color",
		"Main background color",
		"Physical icon color",
		"Special icon color",
		"Gear icon color"
	},

	DEFAULT_LAYOUT_COLORS = {
		["Main background color"] = 		0xFF000000,
		["Default text color"] = 			0xFFFFFFFF,
		["Positive text color"] = 			0xFF00FF00,
		["Negative text color"] = 			0xFFFF0000,
		["Intermediate text color"] = 		0xFFFFFF00,
		["Move header text color"] = 		0xFFFFFFFF,
		["Top box border color"] =			0xFFAAAAAA,
		["Top box background color"] = 		0xFF222222,
		["Bottom box border color"] = 		0xFFAAAAAA,
		["Bottom box background color"] = 	0xFF222222,
		["Physical icon color"] = 			0xFFFFC631,
		["Special icon color"] = 			0xFF3E5782,
		["Gear icon color"] = 				0xFFDBDBDB,
	}
}

function GraphicConstants.readSettingsColors()
	for colorName,color in pairs(Settings.layoutColors) do
		colorName = colorName:gsub("_"," ")
		if color~= nil then
			GraphicConstants.layoutColors[colorName] = tonumber("0xFF"..color)
		end
	end
end

function GraphicConstants.restoreDefaults()
	for colorName,color in pairs(GraphicConstants.DEFAULT_LAYOUT_COLORS) do
		GraphicConstants.layoutColors[colorName] = color
	end
end

function GraphicConstants.saveSettings()
	for colorName,_ in pairs(Settings.layoutColors) do
        local layoutName = colorName:gsub("_"," ")
        Settings.layoutColors[colorName] = string.format("%X",GraphicConstants.layoutColors[layoutName])
    end
	INI.save("Settings.ini", Settings)
end

function GraphicConstants.boolToNumber(value)
	return value and 1 or 0
end

function GraphicConstants.numberToBool(value)
	if value == 1 then
		return true
	end
	return false
end

function GraphicConstants.getThemeString()
	local completeString = ""
	for _, key in pairs(GraphicConstants.layoutColorKeysOrdered) do
		local color = GraphicConstants.layoutColors[key]
		color = string.sub(string.format("%X",color),3)
		completeString = completeString..color.." "
	end
	completeString = completeString..GraphicConstants.boolToNumber(Settings.ColorSettings.Colored_move_names)
	return completeString
end

function GraphicConstants.readThemeString(themeString)
	local i = 1
	for number in string.gmatch(themeString, "[0-9a-fA-F]+") do
		if #number == 1 then
			Settings.ColorSettings.Colored_move_names = GraphicConstants.numberToBool(tonumber(number))
			ColorOptions.toggleMoveColorButton.optionState = Settings.ColorSettings.Colored_move_names
		else
			local key = GraphicConstants.layoutColorKeysOrdered[i]
			GraphicConstants.layoutColors[key] = tonumber("0xFF"..number)
			i = i + 1
		end
	end
	ColorOptions.redraw = true
	GraphicConstants.saveSettings()
end
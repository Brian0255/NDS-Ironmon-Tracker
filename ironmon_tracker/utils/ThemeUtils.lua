function ThemeUtils.readSettingsColors()
    for colorName, color in pairs(Settings.layoutColors) do
        colorName = colorName:gsub("_", " ")
        if color ~= nil then
            --TODO
            --ThemeUtils.layoutColors[colorName] = tonumber("0xFF" .. color)
        end
    end
end

function ThemeUtils.restoreDefaults()
    ThemeUtils.readThemeString(ThemeUtils.DEFAULT_THEME_STRING)
    ColorEditor.redraw = true
    ThemeUtils.saveSettings()
end

function ThemeUtils.saveSettings()
    for colorName, _ in pairs(Settings.layoutColors) do
        local layoutName = colorName:gsub("_", " ")
        Settings.layoutColors[colorName] = string.format("%X", ThemeUtils.layoutColors[layoutName])
    end
    INI.save("Settings.ini", Settings)
end

function ThemeUtils.getThemeString()
    local completeString = ""
    for _, key in pairs(ThemeUtils.layoutColorKeysOrdered) do
        local color = string.sub(string.format("%X", ThemeUtils.layoutColors[key]), 3)
        completeString = completeString .. color .. " "
    end
    for _, key in pairs(ColorEditor.COLOR_SETTINGS_ORDERED_KEYS) do
        completeString = completeString .. ThemeUtils.boolToNumber(Settings.ColorSettings[key]) .. " "
    end
    return completeString
end

function ThemeUtils.readThemeString(themeString)
    local i = 1
    local boolCounter = 1
    for number in string.gmatch(themeString, "[0-9a-fA-F]+") do
        if #number == 1 then
            local setting = ColorEditor.COLOR_SETTINGS_ORDERED_KEYS[boolCounter]
            Settings.ColorSettings[setting] = ThemeUtils.numberToBool(tonumber(number))
            ColorEditor.toggleButtons[boolCounter].optionState = Settings.ColorSettings[setting]
            boolCounter = boolCounter + 1
        else
            local key = ThemeUtils.layoutColorKeysOrdered[i]
            ThemeUtils.layoutColors[key] = tonumber("0xFF" .. number)
            i = i + 1
        end
    end
    ColorEditor.redraw = true
    ThemeUtils.saveSettings()
end

ThemeUtils = {}

function ThemeUtils.restoreDefaults()
    ThemeUtils.readThemeString(ThemeUtils.DEFAULT_THEME_STRING)
end

function ThemeUtils.getThemeString()
    local completeString = ""
    for _, key in pairs(ThemeUtils.layoutColorKeysOrdered) do
        local color = string.sub(string.format("%X", ThemeUtils.layoutColors[key]), 3)
        completeString = completeString .. color .. " "
    end
    for _, key in pairs(ThemeFactory.THEME_COLOR_KEYS_ORDERED) do
        completeString = completeString .. MiscUtils.boolToNumber(settings.colorSettings[key]) .. " "
    end
    return completeString
end

function ThemeUtils.readThemeString(themeString)
    local i = 1
    local boolCounter = 1
    for number in string.gmatch(themeString, "[0-9a-fA-F]+") do
        if #number == 1 then
            local setting = ColorEditor.COLOR_SETTINGS_ORDERED_KEYS[boolCounter]
            settings.colorSettings[setting] = ThemeUtils.numberToBool(tonumber(number))
            ColorEditor.toggleButtons[boolCounter].optionState = settings.colorSettings[setting]
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

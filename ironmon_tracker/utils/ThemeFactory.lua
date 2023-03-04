ThemeFactory = {}

local settings = nil
local saveFunction = nil

function ThemeFactory.setSettings(newSettings)
    settings = newSettings
end

function ThemeFactory.setSaveFunction(newSaveFunction)
    saveFunction = newSaveFunction
end

ThemeFactory.THEME_COLOR_KEYS_ORDERED = {
    "Top box text color",
    "Bottom box text color",
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
}

ThemeFactory.COLOR_SETTINGS_KEYS_ORDERED = {
    "Color move names by type",
    "Draw shadows",
    "Draw move type icons",
    "Color move type icons",
    "Transparent backgrounds",
    "Show phys/spec move icons"
}

local constants = {
    DEFAULT_THEME_STRING = "FFFFFF FFFFFF 00FF00 FF0000 FFFF00 FFFFFF AAAAAA 222222 AAAAAA 222222 000000 FFC631 7DB6FF DBDBDB 1 1 0 0 0 1 ",
    SAVE_THEME_WIDTH = 288,
    SAVE_THEME_HEIGHT = 70,
    EXPORT_THEME_WIDTH = 800,
    EXPORT_THEME_HEIGHT = 70,
    IMPORT_THEME_WIDTH = 880,
    IMPORT_THEME_HEIGHT = 70,
    CENTER_X = client.xpos() + client.screenwidth() / 2,
    CENTER_Y = client.ypos() + client.screenheight() / 2,
    THEMES_PATH = Paths.FOLDERS.DATA_FOLDER .. "/themes"
}

function ThemeFactory.createSaveThemeForm()
    FormsUtils.createSaveForm(Paths.CURRENT_DIRECTORY.."/ironmon_tracker/themes","theme",".colortheme",ThemeFactory.saveFile)
end

function ThemeFactory.onImportThemeClick(text)
    ThemeFactory.readThemeString(text)
end

function ThemeFactory.saveFile(filePath)
    local settingsString = ThemeFactory.getThemeString()
    MiscUtils.writeStringToFile(filePath, settingsString)
    saveFunction()
end

function ThemeFactory.createDefaultConfirmDialog()
    FormsUtils.createConfirmDialog(ThemeFactory.restoreDefaults)
end

function ThemeFactory.createLoadThemeForm()
    local current_dir = Paths.CURRENT_DIRECTORY
    local ending = ".colortheme"
    local themeFile = forms.openfile("*" .. ending, current_dir .. "\\ironmon_tracker\\themes")
    local start = #themeFile - #ending
    if #themeFile > #ending and string.sub(themeFile, start + 1) == ending then
        themeFile = io.open(themeFile, "r")
        if themeFile ~= nil then
            local themeString = themeFile:read "*a"
            ThemeFactory.readThemeString(themeString)
        else
            FormsUtils.popupDialog(
                "Invalid file selection.",
                constants.SAVE_THEME_WIDTH,
                78,
                FormsUtils.POPUP_DIALOG_TYPES.INFO
            )
        end
    end
end

function ThemeFactory.createImportThemeForm(drawFunction)
    forms.destroyall()
    local importForm =
        forms.newform(
        constants.IMPORT_THEME_WIDTH,
        constants.IMPORT_THEME_HEIGHT,
        "Import theme string",
        function()
        end
    )
    forms.setlocation(
        importForm,
        constants.CENTER_X - constants.IMPORT_THEME_WIDTH / 2,
        constants.CENTER_Y - constants.IMPORT_THEME_HEIGHT / 2
    )
    local canvas = forms.pictureBox(importForm, 0, 0, 90, 30)
    local stringBox = forms.textbox(importForm, nil, constants.IMPORT_THEME_WIDTH - 190, 30, nil, 100, 5)

    forms.button(
        importForm,
        "Import",
        function()
            ThemeFactory.onImportThemeClick(forms.gettext(stringBox))
            forms.destroyall()
        end,
        constants.IMPORT_THEME_WIDTH - 84,
        3,
        60,
        24
    )
    forms.drawText(canvas, 6, 7, "Theme string:", 0xFF000000, 0x00000000, 14, "Arial")
end

function ThemeFactory.createExportThemeForm()
    forms.destroyall()
    local exportForm =
        forms.newform(
        constants.EXPORT_THEME_WIDTH,
        constants.EXPORT_THEME_HEIGHT,
        "Exported string (Copy and share!)",
        function()
        end
    )
    forms.setlocation(
        exportForm,
        constants.CENTER_X - constants.EXPORT_THEME_WIDTH / 2,
        constants.CENTER_Y - constants.EXPORT_THEME_HEIGHT / 2
    )
    local themeString = ThemeFactory.getThemeString()
    local canvas = forms.pictureBox(exportForm, 0, 0, 100, 30)
    forms.textbox(exportForm, themeString, constants.EXPORT_THEME_WIDTH - 122, 30, nil, 100, 5)
    forms.drawText(canvas, 6, 7, "Theme string:", 0xFF000000, 0x00000000, 14, "Arial")
end

function ThemeFactory.restoreDefaults()
    ThemeFactory.readThemeString(constants.DEFAULT_THEME_STRING)
end

function ThemeFactory.getThemeString()
    local completeString = ""
    for _, key in pairs(ThemeFactory.THEME_COLOR_KEYS_ORDERED) do
        local color = string.sub(string.format("%X", settings.colorScheme[key]), 3)
        completeString = completeString .. color .. " "
    end
    for _, key in pairs(ThemeFactory.COLOR_SETTINGS_KEYS_ORDERED) do
        completeString = completeString .. MiscUtils.boolToNumber(settings.colorSettings[key]) .. " "
    end
    --completeString = completeString:sub(1,#completeString-1)
    return completeString
end

local function isLegacyNDSString(themeString)
    local colorCounter = 0
    for number in string.gmatch(themeString, "[0-9a-fA-F]+") do
        if #number > 1 then
            colorCounter = colorCounter + 1
        end
    end
    return (colorCounter == #ThemeFactory.THEME_COLOR_KEYS_ORDERED - 1)
end

local function isGen3String(themeString)
    local colorCounter = 0
    for number in string.gmatch(themeString, "[0-9a-fA-F]+") do
        if #number > 1 then
            colorCounter = colorCounter + 1
        end
    end
    return (colorCounter < 11)
end

function ThemeFactory.readThemeString(themeString)
    local legacyNDSString = isLegacyNDSString(themeString)
    local gen3String = isGen3String(themeString)
    local boolCounter = 0
    local colorCounter = 0
    for number in string.gmatch(themeString, "[0-9a-fA-F]+") do
        if #number == 1 then
            boolCounter = boolCounter + 1
            local setting = ThemeFactory.COLOR_SETTINGS_KEYS_ORDERED[boolCounter]
            settings.colorSettings[setting] = MiscUtils.numberToBool(tonumber(number))
        else
            local color = tonumber("0xFF" .. number)
            colorCounter = colorCounter + 1
            if (legacyNDSString or gen3String) and colorCounter == 1 then
                local key = ThemeFactory.THEME_COLOR_KEYS_ORDERED[colorCounter]
                settings.colorScheme[key] = color
                key = ThemeFactory.THEME_COLOR_KEYS_ORDERED[colorCounter + 1]
                settings.colorScheme[key] = color
                colorCounter = colorCounter + 1
                if gen3String then
                    settings.colorScheme["Physical icon color"] = settings.colorScheme["Bottom box text color"]
                    settings.colorScheme["Special icon color"] = settings.colorScheme["Bottom box text color"]
                    settings.colorScheme["Gear icon color"] = settings.colorScheme["Top box text color"]
                end
            else
                local key = ThemeFactory.THEME_COLOR_KEYS_ORDERED[colorCounter]
                settings.colorScheme[key] = color
            end
        end
    end
    saveFunction()
end

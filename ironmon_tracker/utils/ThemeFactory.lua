ThemeFactory = {}

local settings = nil

function ThemeFactory.setSettings(newSettings)
    settings = newSettings
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
    DEFAULT_THEME_STRING = "FFFFFF 00FF00 FF0000 FFFF00 FFFFFF AAAAAA 222222 AAAAAA 222222 000000 FFC631 7DB6FF DBDBDB 1 1 0 0 0 1 ",
    SAVE_THEME_WIDTH = 288,
    SAVE_THEME_HEIGHT = 70,
    EXPORT_THEME_WIDTH = 730,
    EXPORT_THEME_HEIGHT = 70,
    IMPORT_THEME_WIDTH = 780,
    IMPORT_THEME_HEIGHT = 70,
    CENTER_X = client.xpos() + client.screenwidth() / 2,
    CENTER_Y = client.ypos() + client.screenheight() / 2,
    THEMES_PATH = Paths.FOLDERS.DATA_FOLDER .. "/themes"
}

function ThemeFactory.createSaveThemeForm()
    Input.dialogActive = true
    local saveForm =
        forms.newform(
        ThemeFactory.SAVE_THEME_WIDTH,
        ThemeFactory.SAVE_THEME_HEIGHT,
        "Save theme",
        function()
            Input.dialogActive = false
        end
    )
    forms.setlocation(
        saveForm,
        ThemeFactory.CENTER_X - ThemeFactory.SAVE_THEME_WIDTH / 2,
        constants.CENTER_Y - constants.SAVE_THEME_HEIGHT / 2
    )
    local canvas = forms.pictureBox(saveForm, 0, 0, 100, 30)
    local fileName = forms.textbox(saveForm, nil, 100, 30, nil, 100, 5)
    local saveButton =
        forms.button(
        saveForm,
        "Save",
        function()
        end,
        206,
        3,
        60,
        24
    )
    forms.addclick(
        saveButton,
        function()
            ThemeFactory.onSaveThemeClick(fileName)
        end
    )
    forms.drawText(canvas, 6, 7, "Theme name:", 0xFF000000, 0x00000000, 14, "Arial")
end

function ThemeFactory.onImportThemeClick(text)
    ThemeFactory.readThemeString(text)
end

function ThemeFactory.onSaveThemeClick(fileNameTextbox)
    local text = forms.gettext(fileNameTextbox)
    if text ~= "" then
        local savePath = ThemeFactory.THEMES_PATH .. "/" .. text .. ".colortheme"
        if not FormsUtils.fileExists(savePath) then
            local file = io.open(savePath, "w")
            ThemeFactory.saveFile(file)
        else
            local file = io.open(savePath, "w")
            ThemeFactory.createSaveConfirmDialog(
                ThemeFactory.CENTER_X - ThemeFactory.SAVE_THEME_WIDTH / 2,
                ThemeFactory.CENTER_Y - ThemeFactory.SAVE_THEME_HEIGHT / 2,
                ThemeFactory.SAVE_THEME_WIDTH,
                130,
                file
            )
        end
    end
end

function ThemeFactory.saveFile(file)
    io.output(file)
    local settingsString = ThemeFactory.getThemeString()
    io.write(settingsString)
    forms.destroyall()
    Input.dialogActive = false
    FormsUtils.popupDialog(
        "File successfully saved.",
        ThemeFactory.CENTER_X - ThemeFactory.SAVE_THEME_WIDTH / 2,
        ThemeFactory.CENTER_Y - ThemeFactory.SAVE_THEME_HEIGHT / 2,
        ThemeFactory.SAVE_THEME_WIDTH,
        78,
        FormsUtils.POPUP_DIALOG_TYPES.INFO
    )
    io.close(file)
end

function ThemeFactory.createSaveConfirmDialog(x, y, width, height, file)
    local confirmForm = forms.newform(width, height, "Confirm")
    forms.setlocation(confirmForm, x, y)
    local canvas = forms.pictureBox(confirmForm, 0, 0, width, 52)

    forms.drawText(canvas, 16, 10, "A theme with this name already exists.", 0xFF000000, 0x00000000, 14, "Arial")
    forms.drawText(canvas, 50, 32, "Do you want to replace it?", 0xFF000000, 0x00000000, 14, "Arial")

    local confirmButton =
        forms.button(
        confirmForm,
        "Yes",
        function()
        end,
        72,
        height - 74,
        60,
        24
    )
    forms.addclick(
        confirmButton,
        function()
            ThemeFactory.saveFile(file)
        end
    )

    forms.button(
        confirmForm,
        "Cancel",
        function()
            io.close(file)
            Input.dialogActive = false
            forms.destroy(confirmForm)
        end,
        138,
        height - 74,
        60,
        24
    )
end

function ThemeFactory.createDefaultConfirmDialog()
    local x, y =
        ThemeFactory.CENTER_X - ThemeFactory.SAVE_THEME_WIDTH / 2,
        ThemeFactory.CENTER_Y - ThemeFactory.SAVE_THEME_HEIGHT / 2
    local width, height = ThemeFactory.SAVE_THEME_WIDTH, 130
    local confirmForm =
        forms.newform(
        width,
        height,
        "Confirm",
        function()
            Input.dialogActive = false
        end
    )
    forms.setlocation(confirmForm, x, y)
    local canvas = forms.pictureBox(confirmForm, 0, 0, width, 52)

    forms.drawText(canvas, 40, 10, "This action cannot be undone.", 0xFF000000, 0x00000000, 14, "Arial")
    forms.drawText(canvas, 90, 32, "Are you sure?", 0xFF000000, 0x00000000, 14, "Arial")

    local confirmButton =
        forms.button(
        confirmForm,
        "Yes",
        function()
        end,
        72,
        height - 74,
        60,
        24
    )

    forms.addclick(
        confirmButton,
        function()
            forms.destroy(confirmForm)
            Input.dialogActive = false
            ThemeFactory.restoreDefaults()
        end
    )

    forms.button(
        confirmForm,
        "Cancel",
        function()
            Input.dialogActive = false
            forms.destroy(confirmForm)
        end,
        138,
        height - 74,
        60,
        24
    )
end

function ThemeFactory.createLoadThemeForm()
    local current_dir = io.popen "cd":read "*l"
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
                ThemeFactory.CENTER_X - ThemeFactory.SAVE_THEME_WIDTH / 2,
                ThemeFactory.CENTER_Y - ThemeFactory.SAVE_THEME_HEIGHT / 2,
                ThemeFactory.SAVE_THEME_WIDTH,
                78,
                FormsUtils.POPUP_DIALOG_TYPES.INFO
            )
        end
    end
end

function ThemeFactory.createImportThemeForm()
    Input.dialogActive = true
    local importForm =
        forms.newform(
        ThemeFactory.IMPORT_THEME_WIDTH,
        ThemeFactory.IMPORT_THEME_HEIGHT,
        "Import theme string",
        function()
            Input.dialogActive = false
        end
    )
    forms.setlocation(
        importForm,
        ThemeFactory.CENTER_X - ThemeFactory.IMPORT_THEME_WIDTH / 2,
        ThemeFactory.CENTER_Y - ThemeFactory.IMPORT_THEME_HEIGHT / 2
    )
    local canvas = forms.pictureBox(importForm, 0, 0, 90, 30)
    local stringBox = forms.textbox(importForm, nil, ThemeFactory.IMPORT_THEME_WIDTH - 190, 30, nil, 100, 5)

    forms.button(
        importForm,
        "Import",
        function()
            ThemeFactory.onImportThemeClick(forms.gettext(stringBox))
        end,
        ThemeFactory.IMPORT_THEME_WIDTH - 84,
        3,
        60,
        24
    )
    forms.drawText(canvas, 6, 7, "Theme string:", 0xFF000000, 0x00000000, 14, "Arial")
end

function ThemeFactory.createExportThemeForm()
    Input.dialogActive = true
    local exportForm =
        forms.newform(
        ThemeFactory.EXPORT_THEME_WIDTH,
        ThemeFactory.EXPORT_THEME_HEIGHT,
        "Exported string (Copy and share!)",
        function()
            Input.dialogActive = false
        end
    )
    forms.setlocation(
        exportForm,
        ThemeFactory.CENTER_X - ThemeFactory.EXPORT_THEME_WIDTH / 2,
        ThemeFactory.CENTER_Y - ThemeFactory.EXPORT_THEME_HEIGHT / 2
    )
    local themeString = ThemeFactory.getThemeString()
    local canvas = forms.pictureBox(exportForm, 0, 0, 100, 30)
    forms.textbox(exportForm, themeString, ThemeFactory.EXPORT_THEME_WIDTH - 122, 30, nil, 100, 5)
    forms.drawText(canvas, 6, 7, "Theme string:", 0xFF000000, 0x00000000, 14, "Arial")
end

function ThemeFactory.restoreDefaults()
    ThemeFactory.readThemeString(ThemeFactory.DEFAULT_THEME_STRING)
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
    return completeString
end

local function isLegacyString(themeString)
    local boolCounter = 0
    local colorCounter = 0
    for number in string.gmatch(themeString, "[0-9a-fA-F]+") do
        if #number > 1 then
            colorCounter = colorCounter + 1
        end
    end
    return (colorCounter < #ThemeFactory.THEME_COLOR_KEYS_ORDERED)
end

function ThemeFactory.readThemeString(themeString)
    local isLegacy = isLegacyString(themeString)
    print(isLegacy)
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
            if isLegacy and colorCounter == 1 then
                local key = ThemeFactory.THEME_COLOR_KEYS_ORDERED[colorCounter]
                settings.colorScheme[key] = color
                key = ThemeFactory.THEME_COLOR_KEYS_ORDERED[colorCounter+1]
                settings.colorScheme[key] = color
                colorCounter = colorCounter + 1
            else
                local key = ThemeFactory.THEME_COLOR_KEYS_ORDERED[colorCounter]
                settings.colorScheme[key] = color
            end
        end
    end

end

local function ColorSchemeScreen(initialSettings, initialTracker, initialProgram)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/cOMPONENT.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local SettingToggleButton = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/SettingToggleButton.lua")
    local ColorPicker = dofile(Paths.FOLDERS.DATA_FOLDER .. "/ColorPicker.lua")
    local settings = initialSettings
    local tracker = initialTracker
    local program = initialProgram
    local constants = {
        MAIN_FRAME_HEIGHT = 365,
        TOP_FRAME_HEIGHT = 28,
        COLOR_FRAME_HEIGHT = 252,
        IMPORT_EXPORT_FRAME_HEIGHT = 47,
        BOTTOM_FRAME_HEIGHT = 28,
        MAIN_BUTTON_HEIGHT = 14,
        COLOR_EDIT_ROW_HEIGHT = 12,
        COLOR_EDIT_BUTTON_HEIGHT = 9,
        TOGGLE_BUTTON_SIZE = 10
    }
    local ui = {}
    local eventListeners = {}
    local self = {}


    local function onToggleClick(button)
        button.onClick()
        program.drawCurrentScreens()
    end

    local function onSaveThemeClick()
        ThemeFactory.createSaveThemeForm()
    end

    local function onLoadThemeClick()
        ThemeFactory.createLoadThemeForm()
        program.drawCurrentScreens()
    end

    local function onGoBackClick()
        client.SetGameExtraPadding(0, 0, Graphics.SIZES.MAIN_SCREEN_PADDING, 0)
        program.setCurrentScreens({program.UI_SCREENS.APPEARANCE_OPTIONS_SCREEN})
        program.drawCurrentScreens()
    end

    local function onColorPickerEnd()
        program.setColorPicker(nil)
    end

    local function onColorEditClick(colorKey)
        local colorPicker = ColorPicker(settings.colorScheme, colorKey, onColorPickerEnd, nil, program.saveSettings)
        program.setColorPicker(colorPicker)
    end

    local function createColorEditRows(parentFrame)
        local colorKeys = ThemeFactory.THEME_COLOR_KEYS_ORDERED
        for _, colorKey in pairs(colorKeys) do
            local colorEditFrame =
                Frame(
                Box(
                    {x = Graphics.SIZES.BORDER_MARGIN, y = Graphics.SIZES.BORDER_MARGIN},
                    {
                        width = 0,
                        height = constants.COLOR_EDIT_ROW_HEIGHT
                    },
                    nil,
                    nil
                ),
                Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 3),
                parentFrame
            )
            local colorEditButton =
                TextLabel(
                Component(
                    colorEditFrame,
                    Box(
                        {x = 0, y = 0},
                        {width = constants.COLOR_EDIT_BUTTON_HEIGHT, height = constants.COLOR_EDIT_BUTTON_HEIGHT},
                        colorKey,
                        "Black",
                        true,
                        "Top box background color"
                    )
                ),
                TextField(
                    "",
                    {x = 0, y = 0},
                    TextStyle(
                        Graphics.FONT.DEFAULT_FONT_SIZE,
                        Graphics.FONT.DEFAULT_FONT_FAMILY,
                        "Top box text color",
                        "Top box background color"
                    )
                )
            )
            table.insert(eventListeners, MouseClickEventListener(colorEditButton, onColorEditClick, colorKey))
            TextLabel(
                Component(
                    colorEditFrame,
                    Box(
                        {x = 0, y = 0},
                        {width = 0, height = constants.COLOR_EDIT_BUTTON_HEIGHT},
                        settings.colorScheme[colorKey],
                        nil,
                        nil
                    )
                ),
                TextField(
                    colorKey,
                    {x = 0, y = -1},
                    TextStyle(
                        Graphics.FONT.DEFAULT_FONT_SIZE,
                        Graphics.FONT.DEFAULT_FONT_FAMILY,
                        "Top box text color",
                        "Top box background color"
                    )
                )
            )
        end
    end

    local function createColorSettingEditRows(parentFrame)
        local colorSettingsKeys = ThemeFactory.COLOR_SETTINGS_KEYS_ORDERED
        for _, colorSettingsKey in pairs(colorSettingsKeys) do
            local colorEditFrame =
                Frame(
                Box(
                    {x = Graphics.SIZES.BORDER_MARGIN, y = Graphics.SIZES.BORDER_MARGIN},
                    {
                        width = 0,
                        height = constants.COLOR_EDIT_ROW_HEIGHT
                    },
                    nil,
                    nil
                ),
                Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 3),
                parentFrame
            )
            local colorSettingEditButton =
                SettingToggleButton(
                Component(
                    colorEditFrame,
                    Box(
                        {x = 0, y = 0},
                        {width = constants.TOGGLE_BUTTON_SIZE, height = constants.TOGGLE_BUTTON_SIZE},
                        "Top box background color",
                        "Top box border color",
                        true,
                        "Top box background color"
                    )
                ),
                settings.colorSettings,
                colorSettingsKey,
                nil, 
                false,
                true,
                program.saveSettings
            )
            table.insert(
                eventListeners,
                MouseClickEventListener(colorSettingEditButton, onToggleClick, colorSettingEditButton)
            )
            TextLabel(
                Component(
                    colorEditFrame,
                    Box({x = 0, y = 0}, {width = 0, height = constants.COLOR_EDIT_BUTTON_HEIGHT}, nil, nil, nil)
                ),
                TextField(
                    colorSettingsKey,
                    {x = 0, y = -1},
                    TextStyle(
                        Graphics.FONT.DEFAULT_FONT_SIZE,
                        Graphics.FONT.DEFAULT_FONT_FAMILY,
                        "Top box text color",
                        "Top box background color"
                    )
                )
            )
        end
    end

    local function createImportExportButtons()
        ui.frames.importExportFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.BORDER_MARGIN, y = Graphics.SIZES.BORDER_MARGIN},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.IMPORT_EXPORT_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 5, {x = 7, y = 7}),
            ui.frames.mainFrame
        )
        ui.controls.importTheme =
            TextLabel(
            Component(
                ui.frames.importExportFrame,
                Box(
                    {x = 0, y = 0},
                    {width = 65, height = constants.MAIN_BUTTON_HEIGHT},
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            TextField(
                "Import theme",
                {x = 5, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls.exportTheme =
            TextLabel(
            Component(
                ui.frames.importExportFrame,
                Box(
                    {x = 0, y = 0},
                    {width = 65, height = constants.MAIN_BUTTON_HEIGHT},
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            TextField(
                "Export theme",
                {x = 5, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        table.insert(
            eventListeners,
            MouseClickEventListener(ui.controls.importTheme, ThemeFactory.createImportThemeForm)
        )
        table.insert(
            eventListeners,
            MouseClickEventListener(ui.controls.exportTheme, ThemeFactory.createExportThemeForm)
        )
    end

    local function createDefaultCloseButtons()
        ui.frames.bottomFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.BORDER_MARGIN, y = Graphics.SIZES.BORDER_MARGIN},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.BOTTOM_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 7, {x = 7, y = 7}),
            ui.frames.mainFrame
        )
        ui.controls.restoreDefaults =
            TextLabel(
            Component(
                ui.frames.bottomFrame,
                Box(
                    {x = 0, y = 0},
                    {width = 76, height = constants.MAIN_BUTTON_HEIGHT},
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            TextField(
                "Restore defaults",
                {x = 5, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls.goBackButton =
            TextLabel(
            Component(
                ui.frames.bottomFrame,
                Box(
                    {x = 0, y = 0},
                    {width = 40, height = 14},
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            TextField(
                "Go back",
                {x = 3, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        table.insert(eventListeners,MouseClickEventListener(ui.controls.restoreDefaults,ThemeFactory.createDefaultConfirmDialog))
        table.insert(eventListeners,MouseClickEventListener(ui.controls.goBackButton, onGoBackClick))
    end

    local function initUI()
        ui.controls = {}
        ui.frames = {}
        ui.frames.mainFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH + Graphics.SIZES.MAIN_SCREEN_WIDTH + 48, y = 0},
                {width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = constants.MAIN_FRAME_HEIGHT},
                "Main background color",
                nil
            ),
            Layout(
                Graphics.ALIGNMENT_TYPE.VERTICAL,
                0,
                {x = Graphics.SIZES.BORDER_MARGIN, y = Graphics.SIZES.BORDER_MARGIN}
            ),
            nil
        )
        ui.frames.saveLoadThemeFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.BORDER_MARGIN, y = Graphics.SIZES.BORDER_MARGIN},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.TOP_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 7, {x = 7, y = 7}),
            ui.frames.mainFrame
        )

        ui.controls.saveTheme =
            TextLabel(
            Component(
                ui.frames.saveLoadThemeFrame,
                Box(
                    {x = 0, y = 0},
                    {width = 59, height = constants.MAIN_BUTTON_HEIGHT},
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            TextField(
                "Save theme",
                {x = 5, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls.loadTheme =
            TextLabel(
            Component(
                ui.frames.saveLoadThemeFrame,
                Box(
                    {x = 0, y = 0},
                    {width = 59, height = constants.MAIN_BUTTON_HEIGHT},
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            TextField(
                "Load theme",
                {x = 5, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.frames.colorSchemeFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.BORDER_MARGIN, y = Graphics.SIZES.BORDER_MARGIN},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.COLOR_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 7, y = 7}),
            ui.frames.mainFrame
        )
        createColorEditRows(ui.frames.colorSchemeFrame)
        createColorSettingEditRows(ui.frames.colorSchemeFrame)
        createImportExportButtons()
        createDefaultCloseButtons()
        table.insert(eventListeners, MouseClickEventListener(ui.controls.saveTheme, onSaveThemeClick, nil))
        table.insert(eventListeners, MouseClickEventListener(ui.controls.loadTheme, onLoadThemeClick, nil))
    end

    function self.runEventListeners()
        for _, eventListener in pairs(eventListeners) do
            eventListener.listen()
        end
    end

    function self.show()
        ui.frames.mainFrame.show()
    end

    initUI()
    return self
end

return ColorSchemeScreen

local function TrackerSetupScreen(initialSettings, initialTracker, initialProgram)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local SettingToggleButton = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/SettingToggleButton.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local settings = initialSettings
    local tracker = initialTracker
    local program = initialProgram
    local currentButtonWaiting = {
        button = nil,
        settingKey = nil,
        previousText = ""
    }
    local constants = {
        MAIN_FRAME_HEIGHT = 141,
        BOTTOM_FRAME_HEIGHT = 24,
        TEXT_HEADER_HEIGHT = 18,
        FOLDER_LABEL_WIDTH = 96,
        BUTTON_SIZE = 10,
        SET_BUTTON_WIDTH = 34,
        SET_BUTTON_HEIGHT = 14,
        SAVE_LOAD_BUTTON_WIDTH = 62,
        SAVE_LOAD_BUTTON_HEIGHT = 16,
        CHOOSE_TYPE_FRAME_HEIGHT = 89,
        PATH_SETUP_FRAME_HEIGHT = 36,
        TYPE_OPTION_FRAME_HEIGHT = 13,
        BATCH_SETUP_FRAME_HEIGHT = 62,
        GENERATE_ROM_FRAME_HEIGHT = 179
    }
    local ui = {}
    local eventListeners = {}
    local self = {}

    local function onGoBackClick()
        program.setCurrentScreens({program.UI_SCREENS.MAIN_OPTIONS_SCREEN})
        program.drawCurrentScreens()
    end

    local function onSetFolderClick(params)
        local pathLabel = params.pathLabel
        local isFolder = params.isFolder
        local isBatchButton = params.isBatchButton
        local settingData = params.settingData
        local settingKey = settingData.settingKey
        local fileExtension = settingData.fileExtension
        local relativePath = settingData.relativePath
        local batchValid = isBatchButton and settings.quickLoad.LOAD_TYPE == "USE_BATCH"
        local romGenerationValid = (not isBatchButton) and settings.quickLoad.LOAD_TYPE == "GENERATE_ROMS"
        if batchValid or romGenerationValid then
            local current_dir = Paths.CURRENT_DIRECTORY
            local newPath = forms.openfile("*" .. fileExtension, current_dir .. relativePath)
            if newPath ~= nil and newPath ~= "" then
                if isFolder then
                    newPath = newPath:sub(0, newPath:match("^.*()" .. Paths.SLASH) - 1)
                end
                settings.quickLoad[settingKey] = newPath
                pathLabel.setText(FormsUtils.shortenFolderName(newPath))
            end
            program.saveSettings()
            program.drawCurrentScreens()
        end
    end

    function self.initialize()
        ui.controls.quickLoadValue.setText(settings.controls.LOAD_NEXT_SEED:gsub(" ", "   "))
    end

    local function onRadioClick(button)
        button.onClick()
        program.drawCurrentScreens()
    end

    local function calculateMainFrameSize()
        local baseHeight = constants.MAIN_FRAME_HEIGHT
        local framesToCheck = {ui.frames.mainROMGenerateFrame, ui.frames.mainBatchFrame}
        for _, frame in pairs(framesToCheck) do
            if frame.isVisible() then
                baseHeight = baseHeight + frame.getSize().height
            end
        end
        ui.frames.mainFrame.resize({width = ui.frames.mainFrame.getSize().width, height = baseHeight})
    end

    local function createPathSetupFrame(
        parentFrame,
        labelName,
        settingKey,
        fileExtension,
        relativePath,
        isFolder,
        isBatchButton)
        local pathFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.PATH_SETUP_FRAME_HEIGHT
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 5, y = 0}),
            parentFrame
        )
        local pathSettingSetFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {
                    width = 0,
                    height = 20
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL),
            pathFrame
        )
        local settingLabel =
            TextLabel(
            Component(
                pathSettingSetFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = 70,
                        height = 0
                    },
                    nil,
                    nil,
                    false
                )
            ),
            TextField(
                labelName,
                {x = 0, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        local setButton =
            TextLabel(
            Component(
                pathSettingSetFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.SET_BUTTON_WIDTH,
                        height = constants.SET_BUTTON_HEIGHT
                    },
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            TextField(
                "Set",
                {x = 9, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls[settingKey] =
            TextLabel(
            Component(
                pathFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.FOLDER_LABEL_WIDTH,
                        height = 14
                    },
                    nil,
                    nil,
                    false
                )
            ),
            TextField(
                FormsUtils.shortenFolderName(settings.quickLoad[settingKey]),
                {x = 0, y = 0},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )

        local onSetParams = {
            ["isBatchButton"] = isBatchButton,
            ["isFolder"] = isFolder,
            ["pathLabel"] = ui.controls[settingKey],
            settingData = {
                ["settingKey"] = settingKey,
                ["fileExtension"] = fileExtension,
                ["relativePath"] = relativePath
            }
        }
        table.insert(eventListeners, MouseClickEventListener(setButton, onSetFolderClick, onSetParams))
    end

    local function createTypeChooseRadioButtonRow(settingKey, settingValue, labelName)
        local frame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.TYPE_OPTION_FRAME_HEIGHT
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 3),
            ui.frames.chooseTypeFrame
        )
        local radioButton =
            SettingToggleButton(
            Component(
                frame,
                Box(
                    {x = 0, y = 0},
                    {width = constants.BUTTON_SIZE, height = constants.BUTTON_SIZE},
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            settings.quickLoad,
            settingKey,
            settingValue,
            true,
            true,
            program.saveSettings
        )
        local label =
            TextLabel(
            Component(
                frame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = 0,
                        height = 0
                    },
                    nil,
                    nil,
                    false
                )
            ),
            TextField(
                labelName,
                {x = 0, y = 0},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        table.insert(eventListeners, MouseClickEventListener(radioButton, onRadioClick, radioButton))
    end

    local function createQuickLoadComboFrame()
        ui.frames.quickLoadFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = 0
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 2, {x = 0, y = 4}),
            ui.frames.chooseTypeFrame
        )
        local quickLoadLabel =
            TextLabel(
            Component(
                ui.frames.quickLoadFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                        height = 12
                    },
                    nil,
                    nil,
                    false
                )
            ),
            TextField(
                "New Run Combo:",
                {x = 0, y = 0},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls.quickLoadValue =
            TextLabel(
            Component(
                ui.frames.quickLoadFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                        height = constants.TEXT_HEADER_HEIGHT
                    },
                    nil,
                    nil,
                    false
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
    end

    local function createChooseTypeFrame()
        ui.frames.chooseTypeFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.CHOOSE_TYPE_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 2, {x = Graphics.SIZES.BORDER_MARGIN, y = 2}),
            ui.frames.mainFrame
        )
        ui.controls.chooseTypeHeading =
            TextLabel(
            Component(
                ui.frames.chooseTypeFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                        height = constants.TEXT_HEADER_HEIGHT
                    },
                    nil,
                    nil,
                    false
                )
            ),
            TextField(
                "New Run Type",
                {x = -1, y = 0},
                TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        local setting = "LOAD_TYPE"
        local typeSettings = {
            ["USE_BATCH"] = "Use batch of seeds",
            ["GENERATE_ROMS"] = "Generate ROMs"
        }
        local order = {"USE_BATCH", "GENERATE_ROMS"}
        for _, settingValue in pairs(order) do
            createTypeChooseRadioButtonRow(setting, settingValue, typeSettings[settingValue])
        end
        createQuickLoadComboFrame()
    end

    local function createBatchSetupFrame()
        ui.frames.mainBatchFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.BATCH_SETUP_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 5, {x = 0, y = 0}),
            ui.frames.mainFrame
        )
        ui.controls.mainHeading =
            TextLabel(
            Component(
                ui.frames.mainBatchFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                        height = constants.TEXT_HEADER_HEIGHT
                    },
                    "Top box background color",
                    "Top box border color",
                    false
                )
            ),
            TextField(
                "Batch Setup",
                {x = 36, y = 1},
                TextStyle(13, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        createPathSetupFrame(ui.frames.mainBatchFrame, "ROMs Folder", "ROMS_FOLDER_PATH", ".nds", "", true, true)
    end

    local function saveProfile(filePath)
        local completeString = ""
        local settingsNames = {"JAR_PATH", "SETTINGS_PATH", "ROM_PATH"}
        for _, settingName in pairs(settingsNames) do
            completeString = completeString .. settings.quickLoad[settingName] .. "\n"
        end
        MiscUtils.writeStringToFile(filePath, completeString)
        program.saveSettings()
    end

    local function onSaveProfileClick()
        local settingsNames = {"JAR_PATH", "SETTINGS_PATH", "ROM_PATH"}
        for _, settingName in pairs(settingsNames) do
            if settings.quickLoad[settingName] == nil or settings.quickLoad[settingName] == "" then
                forms.destroyall()
                FormsUtils.popupDialog(
                    "Missing files have been detected. Fill these in before saving a profile.",
                    250,
                    120,
                    FormsUtils.POPUP_DIALOG_TYPES.WARNING,
                    true
                )
                return
            end
        end
        FormsUtils.createSaveForm(
            Paths.CURRENT_DIRECTORY .. "/ironmon_tracker/quickloadProfiles",
            "profile",
            ".qlp",
            saveProfile
        )
    end

    local function onLoadProfileClick()
        local settingsNames = {"JAR_PATH", "SETTINGS_PATH", "ROM_PATH"}
        local soundOn = client.GetSoundOn()
        client.SetSoundOn(false)
        local profile =
            forms.openfile(
            "*.qlp",
            Paths.CURRENT_DIRECTORY .. Paths.SLASH .. "ironmon_tracker" .. Paths.SLASH .. "quickloadProfiles" .. Paths.SLASH
        )
        client.SetSoundOn(soundOn)
        if profile == "" then
            return
        end
        local lines = MiscUtils.readLinesFromFile(profile)
        for i, line in pairs(lines) do
            local settingName = settingsNames[i]
            settings.quickLoad[settingName] = line
            ui.controls[settingName].setText(FormsUtils.shortenFolderName(line))
        end
        program.saveSettings()
        program.drawCurrentScreens()
    end

    local function createSaveLoadButtons()
        ui.frames.saveLoadFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = 0,
                    height = 0
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 6, {x = 5, y = 0}),
            ui.frames.mainROMGenerateFrame
        )
        local names = {"Save Profile", "Load Profile"}
        local functions = {onSaveProfileClick, onLoadProfileClick}
        for i = 1, 2, 1 do
            local button =
                TextLabel(
                Component(
                    ui.frames.saveLoadFrame,
                    Box(
                        {x = 0, y = 0},
                        {
                            width = constants.SAVE_LOAD_BUTTON_WIDTH,
                            height = constants.SAVE_LOAD_BUTTON_HEIGHT
                        },
                        "Top box background color",
                        "Top box border color",
                        true,
                        "Top box background color"
                    )
                ),
                TextField(
                    names[i],
                    {x = 7, y = 2},
                    TextStyle(
                        Graphics.FONT.DEFAULT_FONT_SIZE,
                        Graphics.FONT.DEFAULT_FONT_FAMILY,
                        "Top box text color",
                        "Top box background color"
                    )
                )
            )
            table.insert(eventListeners, MouseClickEventListener(button, functions[i]))
        end
    end

    local function createROMCreationFrame()
        ui.frames.mainROMGenerateFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.GENERATE_ROM_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 8, {x = 0, y = 0}),
            ui.frames.mainFrame
        )
        ui.controls.mainHeading =
            TextLabel(
            Component(
                ui.frames.mainROMGenerateFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                        height = constants.TEXT_HEADER_HEIGHT
                    },
                    "Top box background color",
                    "Top box border color",
                    false
                )
            ),
            TextField(
                "ROM Creation",
                {x = 30, y = 1},
                TextStyle(13, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        local settingsData = {
            {
                settingKey = "ROM_PATH",
                labelName = "ROM to patch",
                extension = ".nds",
                relativePath = ""
            },
            {
                settingKey = "JAR_PATH",
                labelName = "Randomizer JAR",
                extension = ".jar",
                relativePath = ""
            },
            {
                settingKey = "SETTINGS_PATH",
                labelName = "Settings file",
                extension = ".rnqs",
                relativePath = Paths.SLASH .. "ironmon_tracker" .. Paths.SLASH .. "settings"
            }
        }
        for _, settingData in pairs(settingsData) do
            createPathSetupFrame(
                ui.frames.mainROMGenerateFrame,
                settingData.labelName,
                settingData.settingKey,
                settingData.extension,
                settingData.relativePath
            )
        end
    end

    local function initUI()
        ui.controls = {}
        ui.frames = {}
        ui.frames.mainFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = constants.MAIN_FRAME_HEIGHT},
                "Main background color",
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = Graphics.SIZES.BORDER_MARGIN, y = Graphics.SIZES.BORDER_MARGIN}),
            nil
        )
        ui.controls.mainHeading =
            TextLabel(
            Component(
                ui.frames.mainFrame,
                Box(
                    {x = 5, y = 5},
                    {
                        width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                        height = constants.TEXT_HEADER_HEIGHT
                    },
                    "Top box background color",
                    "Top box border color",
                    false
                )
            ),
            TextField(
                "New Run Settings",
                {x = 22, y = 1},
                TextStyle(13, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        createChooseTypeFrame()
        createBatchSetupFrame()
        createROMCreationFrame()
        createSaveLoadButtons()
        ui.frames.goBackFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.BOTTOM_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 94, y = Graphics.SIZES.BORDER_MARGIN}),
            ui.frames.mainFrame
        )
        ui.controls.goBackButton =
            TextLabel(
            Component(
                ui.frames.goBackFrame,
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
        table.insert(eventListeners, MouseClickEventListener(ui.controls.goBackButton, onGoBackClick))
        --]]
    end

    function self.runEventListeners()
        for _, eventListener in pairs(eventListeners) do
            eventListener.listen()
        end
    end

    function self.show()
        ui.frames.mainROMGenerateFrame.setVisibility(settings.quickLoad.LOAD_TYPE == "GENERATE_ROMS")
        ui.frames.mainBatchFrame.setVisibility(settings.quickLoad.LOAD_TYPE == "USE_BATCH")
        calculateMainFrameSize()
        ui.frames.mainFrame.show()
    end

    initUI()
    return self
end

return TrackerSetupScreen

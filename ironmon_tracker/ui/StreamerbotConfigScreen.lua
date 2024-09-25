local function StreamerbotConfigScreen(initialSettings, initialTracker, initialProgram)
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
        MAIN_FRAME_HEIGHT = 212,
        BOTTOM_FRAME_HEIGHT = 24,
        TEXT_HEADER_HEIGHT = 18,
        FOLDER_LABEL_WIDTH = 96,
        BUTTON_SIZE = 10,
        SMALL_BUTTON_WIDTH = 34,
        SMALL_BUTTON_HEIGHT = 14,
        STATUS_FOLDER_FRAME_HEIGHT = 104,
        CODE_PERMISSIONS_FRAME_HEIGHT = 56,
        PATH_SETUP_FRAME_HEIGHT = 40
    }
    local ui = {}
    local eventListeners = {}
    local self = {}

    local function onGoBackClick()
        program.setCurrentScreens({ program.UI_SCREENS.EXTRAS_SCREEN })
        program.drawCurrentScreens()
    end

    local function onHelpClick()
        local helpURL = "https://github.com/besteon/Ironmon-Tracker/wiki/Stream-Connect-Guide"
        os.execute(string.format('start "" "%s"', helpURL))
    end

    local function onSetFolderClick()
        local existingPath = tostring(Network.Options["DataFolder"]) or ""
        local filterOptions = "Json File (*.JSON)|*.json|All files (*.*)|*.*"
        local newPath = forms.openfile("SELECT ANY JSON FILE", existingPath, filterOptions)
        if newPath ~= nil and newPath ~= "" then
            newPath = newPath:sub(0, newPath:match("^.*()" .. Paths.SLASH) - 1)
            if not string.find(Network.Options["DataFolder"], newPath) then
                Network.closeConnections()
            end
            if newPath == nil or newPath == "" then
                Network.closeConnections()
            else
                Network.Options["DataFolder"] = newPath
            end
            Network.saveSettings()
            ui.controls.dataFolderPath.setText(FormsUtils.shortenFolderName(newPath))
        end
        program.drawCurrentScreens()
    end

    local function refreshStatus()
        ui.controls.statusText.setText(Network.getConnectionStatusMsg())
        ui.controls.statusText.setTextColorKey(Network.getConnectionStatusColor())
    end

    local function updateConnectButton()
        if Network.isConnected() then
            ui.controls.connectDisconnect.setText("Disconnect")
            ui.controls.connectDisconnect.setTextOffset({x=6,y=1})
        else
            ui.controls.connectDisconnect.setText("Connect")
            ui.controls.connectDisconnect.setTextOffset({x=11,y=1})
        end
        refreshStatus()
    end

    function self.initialize()
        updateConnectButton()
        ui.controls.dataFolderPath.setText(FormsUtils.shortenFolderName(Network.Options["DataFolder"]))
        program.drawCurrentScreens()
    end

    local function connectDisconnect()
        if Network.isConnected() then
            Network.closeConnections()
        else
            Network.tryConnect()
        end
        updateConnectButton()
        program.drawCurrentScreens()
    end

    local function createConnectButton()
        ui.frames.connectFrame =
        Frame(
        Box(
            {x = 0, y = 0},
            {
                width = 0,
                height = 0
            }
        ),
        Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 36, y = 0}),
        ui.frames.statusFolderFrame
    )
        ui.controls.connectDisconnect =
            TextLabel(
            Component(
                ui.frames.connectFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = 56,
                        height = constants.SMALL_BUTTON_HEIGHT
                    },
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            TextField(
                "Connect",
                {x = 6, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        table.insert(eventListeners, MouseClickEventListener(ui.controls.connectDisconnect, connectDisconnect))
    end

    local function createPathSetupFrame(parentFrame, labelName)
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
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = -1, y = 4}),
            parentFrame
        )
        local pathSettingSetFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {
                    width = 0,
                    height = 16
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
                        width = 86,
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
                        width = constants.SMALL_BUTTON_WIDTH,
                        height = constants.SMALL_BUTTON_HEIGHT
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
        ui.controls.dataFolderPath =
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
                Network.Options["DataFolder"],
                {x = 4, y = 0},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        table.insert(eventListeners, MouseClickEventListener(setButton, onSetFolderClick))
    end

    local function createCodePermissionsFrame()
        ui.frames.codePermissionsFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.CODE_PERMISSIONS_FRAME_HEIGHT
                    },
                "Top box background color","Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 4, {x = 15, y = 7}),
            ui.frames.mainFrame
        )
        local buttons = {
            {
                iconName = "UPDATER_ICON",
                offset = {x = 2, y = 2},
                text = "Streamerbot Code",
                onClick = Network.openGetCodeWindow
            },
            {
                iconName = "TRACKED_INFO_ICON",
                offset = {x = 4, y = 3},
                text = "Role Permissions",
                onClick = Network.openCommandRolePermissionsPrompt
            }
        }
        for _, button in pairs(buttons) do
            local frameInfo =
                FrameFactory.createScreenOpeningFrame(
                ui.frames.codePermissionsFrame,
                110,
                19,
                button.iconName,
                button.offset,
                button.text
            )
            table.insert(eventListeners, MouseClickEventListener(frameInfo.button, button.onClick))
        end
    end

    local function createStatusFolderFrame()
        ui.frames.statusFolderFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.STATUS_FOLDER_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 2, {x = Graphics.SIZES.BORDER_MARGIN, y = 7}),
            ui.frames.mainFrame
        )
        ui.controls.statusHeading =
            TextLabel(
            Component(
                ui.frames.statusFolderFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = 86,
                        height = constants.TEXT_HEADER_HEIGHT - 6
                    }
                )
            ),
            TextField(
                "Connection Status:",
                {x = -1, y = -1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls.statusText =
            TextLabel(
            Component(
                ui.frames.statusFolderFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                        height = constants.TEXT_HEADER_HEIGHT - 2
                    },
                    nil,
                    nil,
                    false
                )
            ),
            TextField(
                "Online: Connection Established.",
                {x = 3, y = 0},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )

        createPathSetupFrame(ui.frames.statusFolderFrame, "Connection Folder")
        createConnectButton()
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
                "Stream Connect",
                {x = 24, y = 1},
                TextStyle(13, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        createStatusFolderFrame()
        createCodePermissionsFrame()
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
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 60, {x = 5, y = Graphics.SIZES.BORDER_MARGIN}),
            ui.frames.mainFrame
        )
        ui.controls.helpButton =
        TextLabel(
        Component(
            ui.frames.goBackFrame,
            Box(
                {x = 0, y = 0},
                {width = 30, height = 14},
                "Top box background color",
                "Top box border color",
                true,
                "Top box background color"
            )
        ),
        TextField(
            "Help",
            {x = 5, y = 1},
            TextStyle(
                Graphics.FONT.DEFAULT_FONT_SIZE,
                Graphics.FONT.DEFAULT_FONT_FAMILY,
                "Top box text color",
                "Top box background color"
            )
        )
    )
    table.insert(eventListeners, MouseClickEventListener(ui.controls.helpButton, onHelpClick))
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
        refreshStatus()
        ui.frames.mainFrame.show()
    end

    initUI()
    return self
end

return StreamerbotConfigScreen

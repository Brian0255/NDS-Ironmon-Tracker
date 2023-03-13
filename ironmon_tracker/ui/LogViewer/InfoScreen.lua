local function InfoScreen(initialSettings, initialTracker, initialProgram, initialLogViewerScreen)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local Icon = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Icon.lua")
    local ScrollBar = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ScrollBar.lua")
    local ImageLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageLabel.lua")
    local ImageField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageField.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local HoverEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/HoverEventListener.lua")
    local logInfo
    local miscInfo
    local settings = initialSettings
    local logViewerScreen = initialLogViewerScreen
    local tracker = initialTracker
    local program = initialProgram
    local settingsLabels = {}
    local constants = {
        LEFT_LABEL_WIDTH = 86,
        RIGHT_LABEL_WIDTH = 100,
        BUTTON_WIDTH = 30,
        BUTTON_HEIGHT = 16,
        ROW_HEIGHT = 18
    }

    local ui = {}
    local eventListeners = {}
    local self = {}
    local rows = {}

    local function create2ElementRow(index)
        local rowFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 0,
                    height = constants.ROW_HEIGHT
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL),
            ui.frames.mainFrame
        )
        local leftLabel =
            TextLabel(
            Component(
                rowFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.LEFT_LABEL_WIDTH,
                        height = 0
                    },
                    nil,
                    nil
                )
            ),
            TextField(
                "",
                {x = 1, y = 0},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        local rightLabel =
            TextLabel(
            Component(
                rowFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.RIGHT_LABEL_WIDTH,
                        height = 0
                    },
                    nil,
                    nil
                )
            ),
            TextField(
                "",
                {x = 1, y = 0},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        rows[index] = {
            frame = rowFrame,
            ["leftLabel"] = leftLabel,
            ["rightLabel"] = rightLabel
        }
    end

    local function readRow(index, rowInfo)
        local leftLabelText, rightLabelText = rowInfo[1], rowInfo[2]
        local row = rows[index]
        row.leftLabel.setText(leftLabelText)
        row.rightLabel.setText(rightLabelText)
    end

    local function readSettingsIntoUI()
        local settingsString = miscInfo.settingsString
        local settingsRows = MiscUtils.splitStringByAmount(settingsString, 40)
        for index, text in pairs(settingsRows) do
            settingsLabels[index].setText(text)
        end
    end

    local function readInfoIntoRows()
        --rows are left label, right label
        local infoRows = {
            {"Game Name:", program.getGameInfo().NAME:gsub("Pokemon","Pok"..Chars.accentedE.."mon")},
            {"Randomizer Version:", miscInfo.version},
            {"Random Seed:", miscInfo.seed}
        }
        for index, row in pairs(infoRows) do
            readRow(index, row)
        end
        readSettingsIntoUI()
    end

    function self.initialize(newLogInfo)
        logInfo = newLogInfo
        miscInfo = logInfo.getMiscInfo()
        readInfoIntoRows()
    end

    local function initSettingsStringUI()
        ui.controls.settingsLabel =
            TextLabel(
            Component(
                ui.frames.mainFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.LEFT_LABEL_WIDTH,
                        height = 0
                    },
                    nil,
                    nil
                )
            ),
            TextField(
                "Settings String:",
                {x = 1, y = 0},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        local settingsLabelFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 0,
                    height = constants.ROW_HEIGHT * 3
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 10, y = 14}),
            ui.frames.mainFrame
        )
        for i = 1, 4, 1 do
            settingsLabels[i] =
                TextLabel(
                Component(
                    settingsLabelFrame,
                    Box(
                        {x = 0, y = 0},
                        {
                            width = 0,
                            height = 10
                        },
                        nil,
                        nil
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
    end

    local function onCopyButtonClick()
        forms.destroyall()
        local formWidth, formHeight = 460, 220
        local buttonWidth, buttonHeight = 70, 30
        local copyForm  =
            forms.newform(
            formWidth,
            formHeight,
            "Seed Info"
        )
        local centerPosition = FormsUtils.getCenter(formWidth, formHeight)
        forms.setlocation(copyForm, centerPosition.xPos, centerPosition.yPos)
        local textBoxLines = {
            "Game Name: "..program.getGameInfo().NAME:gsub("Pokemon","Pok"..Chars.accentedE.."mon").." ",
            "Randomizer Version: "..miscInfo.version.." ",
            "Random Seed: " ..miscInfo.seed.. " ",
            "Settings String: "..miscInfo.settingsString.. " "
        }
        local completeLines = table.concat(textBoxLines,"\r\n")
        forms.textbox(copyForm, completeLines, formWidth-36, formHeight-100, nil, 10, 10, true, false)
        forms.button(
            copyForm,
            "Close",
            function()
                forms.destroyall()
            end,
            formWidth/2 - 45,
            formHeight - 80,
            buttonWidth,
            buttonHeight
        )
    end

    local function initCopyButton()
        ui.frames.copyButtonFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 0,
                    height = 0
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 94, y = 0}),
            ui.frames.mainFrame
        )
        ui.controls.copyButton =
            TextLabel(
            Component(
                ui.frames.copyButtonFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = 48,
                        height = 16
                    },
                    "Top box background color",
                    "Top box border color"
                )
            ),
            TextField(
                "Copy info",
                {x = 4, y = 2},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        table.insert(eventListeners, MouseClickEventListener(ui.controls.copyButton, onCopyButtonClick))
    end

    local function initUI()
        ui.controls = {}
        ui.frames = {}
        ui.frames.mainFrame =
            Frame(
            Box(
                {
                    x = Graphics.SIZES.BORDER_MARGIN,
                    y = Graphics.LOG_VIEWER.TAB_HEIGHT + Graphics.SIZES.BORDER_MARGIN + 5
                },
                {
                    width = Graphics.SIZES.SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = Graphics.SIZES.SCREEN_HEIGHT - 2 * Graphics.SIZES.BORDER_MARGIN -
                        Graphics.LOG_VIEWER.TAB_HEIGHT -
                        5
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 3, y = 3}),
            nil
        )
        for i = 1, 3, 1 do
            create2ElementRow(i)
        end
        initSettingsStringUI()
        initCopyButton()
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

return InfoScreen

local function TrainerOverviewScreen(initialSettings, initialTracker, initialProgram, initialLogViewerScreen)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local Icon = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Icon.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local RivalOverviewScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/LogViewer/RivalOverviewScreen.lua")
    local TrainerGroupOverviewScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/LogViewer/TrainerGroupOverviewScreen.lua")
    local ScreenStack = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ScreenStack.lua")
    local logInfo
    local logViewerScreen = initialLogViewerScreen
    local settings = initialSettings
    local tracker = initialTracker
    local program = initialProgram
    local currentScreenIndex
    local currentTrainerGroups = nil
    local mainScreenStack = ScreenStack()
    local constants = {
        TAB_HEIGHT = 14
    }
    local ui = {}
    local eventListeners = {}
    local tabListeners = {}
    local self = {}

    local function onGoBackClick()
    end

    function self.getCurrentScreenIndex()
        return currentScreenIndex
    end

    function self.onTabClick(index)
        currentScreenIndex = index
        logViewerScreen.setTeamInfoTrainerGroup(currentTrainerGroups[currentScreenIndex])
        mainScreenStack.setCurrentIndex(index)
        program.drawCurrentScreens()
    end

    local function createTabsFromTrainerData()
        local totalWidth = 0
        for index, trainerGroup in pairs(currentTrainerGroups) do
            if trainerGroup.trainerType == TrainerData.TRAINER_TYPES.RIVAL then
                local newRivalScreen = RivalOverviewScreen(settings, tracker, program, logViewerScreen)
                newRivalScreen.initialize(logInfo)
                newRivalScreen.setTrainerGroup(trainerGroup)
                mainScreenStack.addScreen(newRivalScreen)
            else
                local newTrainerGroupScreen = TrainerGroupOverviewScreen(settings, tracker, program, logViewerScreen)
                newTrainerGroupScreen.initialize(logInfo)
                newTrainerGroupScreen.setTrainerGroup(trainerGroup)
                mainScreenStack.addScreen(newTrainerGroupScreen)
            end
            local tabName = trainerGroup.groupName
            local nameBoxLength = DrawingUtils.calculateWordPixelLength(tabName) + 6
            local spacerLength = 7
            totalWidth = totalWidth + nameBoxLength
            ui.tabControls[index] =
                TextLabel(
                Component(
                    ui.frames.tabFrame,
                    Box(
                        {x = 0, y = 0},
                        {
                            width = nameBoxLength,
                            height = constants.TAB_HEIGHT
                        },
                        nil,
                        nil
                    )
                ),
                TextField(
                    tabName,
                    {x = 2, y = 1},
                    TextStyle(
                        Graphics.FONT.DEFAULT_FONT_SIZE,
                        Graphics.FONT.DEFAULT_FONT_FAMILY,
                        "Top box text color",
                        "Top box background color"
                    )
                )
            )
            table.insert(tabListeners, MouseClickEventListener(ui.tabControls[index], self.onTabClick, index))
            -- add line inbetween (which is just a blank label)
            if index ~= #currentTrainerGroups then
                ui.tabControls[index .. "spacer"] =
                    TextLabel(
                    Component(
                        ui.frames.tabFrame,
                        Box(
                            {x = 0, y = 0},
                            {
                                width = spacerLength,
                                height = 3
                            },
                            nil,
                            nil
                        )
                    ),
                    TextField(
                        "|",
                        {x = 0, y = 1},
                        TextStyle(9, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
                    )
                )
                totalWidth = totalWidth + spacerLength
            end
        end
        local centeredOffset = (ui.frames.mainFrame.getSize().width - totalWidth) / 2
        ui.frames.tabFrame.setLayoutPadding({x = centeredOffset, y = 1})
    end

    local function underlineActiveTab()
        local activeTabControl = ui.tabControls[currentScreenIndex]
        local position = activeTabControl.getPosition()
        local size = activeTabControl.getSize()
        local x1, y1 = position.x + 3, position.y + size.height - 2
        local x2, y2 = position.x + size.width - 3, y1
        gui.drawLine(x1, y1, x2, y2, DrawingUtils.convertColorKeyToColor("Top box text color"))
    end

    function self.reset()
        currentScreenIndex = 1
        tabListeners = {}
        ui.tabControls = {}
        ui.frames.tabFrame.clearAllChildren()
        createTabsFromTrainerData()
        self.onTabClick(1)
    end

    function self.initialize(newLogInfo)
        mainScreenStack = ScreenStack()
        logInfo = newLogInfo
        local gameInfo = program.getGameInfo()
        currentTrainerGroups = logViewerScreen.getTrainerGroups()
        self.reset()
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
                    height = Graphics.SIZES.SCREEN_HEIGHT - 2 * Graphics.SIZES.BORDER_MARGIN - Graphics.LOG_VIEWER.TAB_HEIGHT -
                        5
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL),
            nil
        )
        ui.frames.tabFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 0,
                    height = constants.TAB_HEIGHT
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL),
            ui.frames.mainFrame
        )
    end

    function self.runEventListeners()
        mainScreenStack.runEventListeners()
        for _, eventListener in pairs(eventListeners) do
            eventListener.listen()
        end
        for _, eventListener in pairs(tabListeners) do
            eventListener.listen()
        end
    end

    function self.show()
        ui.frames.mainFrame.show()
        mainScreenStack.show()
        underlineActiveTab()
    end

    initUI()
    return self
end

return TrainerOverviewScreen

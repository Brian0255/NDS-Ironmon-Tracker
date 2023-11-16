local function StatisticsScreen(initialSettings, initialTracker, initialProgram)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local BarGraph = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/BarGraph.lua")
    local settings = initialSettings
    local tracker = initialTracker
    local program = initialProgram
    local totalRunsPastLab
    local totalRuns
    local currentIndex
    local currentStatistic
    local statisticSet

    local constants = {
        MAIN_FRAME_X = 0,
        MAIN_FRAME_Y = 0,
        MAIN_FRAME_WIDTH = Graphics.SIZES.SCREEN_WIDTH,
        MAIN_FRAME_HEIGHT = Graphics.SIZES.SCREEN_HEIGHT,
        BOTTOM_FRAME_HEIGHT = 22,
        TOTAL_RUN_WIDTH = 80,
        TOTAL_PLAYTIME_WIDTH = 117,
        TOP_FRAME_OFFSET = 10,
        TOP_FRAME_WIDTH = 300,
        TOP_LABEL_FONT_SIZE = 11,
        TOP_LABEL_Y_OFFSET = -3,
        MAIN_FRAME_OFFSET = 46,
        TOP_LABEL_WIDTH = 216,
        TOP_FRAME_HEIGHT = 17,
        BAR_GRAPH_WIDTH = 249,
        BAR_GRAPH_HEIGHT = 151
    }
    local ui = {}
    local eventListeners = {}
    local self = {}

    local function onGoBackClick()
        program.openScreen(program.UI_SCREENS.TRACKED_INFO_SCREEN)
    end

    local function readCurrentStatisticIntoUI()
        currentStatistic = statisticSet[currentIndex]
        local name = currentStatistic[1]
        local dataSet = currentStatistic[2]
        ui.controls.mainBarGraph.setMaxValue(totalRunsPastLab)
        if name == "Overall Progress" then
            if program.getGameInfo().VERSION_GROUP == 4 then
                dataSet[1][1] = "Past N"
            end
            ui.controls.mainBarGraph.setMaxValue(totalRuns)
        end
        local nameLength = DrawingUtils.calculateWordPixelLength(name)
        if constants.TOP_LABEL_FONT_SIZE == 11 then
            nameLength = nameLength + #name
        end
        local offsetX = (constants.TOP_LABEL_WIDTH - nameLength + 2) / 2
        ui.controls.topLabel.setTextOffset({x = offsetX, y = constants.TOP_LABEL_Y_OFFSET})
        ui.controls.topLabel.setText(name)
        local total = #dataSet
        --ui.controls.mainBarGraph.resize({width = constants.BAR_GRAPH_WIDTH, height = constants.BAR_GRAPH_HEIGHT * (total/10) + 10})
        ui.controls.mainBarGraph.setDataSet(dataSet)
        program.drawCurrentScreens()
    end

    local function onForwardStatisticClick()
        currentIndex = MiscUtils.increaseTableIndex(currentIndex, #statisticSet)
        readCurrentStatisticIntoUI()
    end

    local function onBackwardStatisticClick()
        currentIndex = MiscUtils.decreaseTableIndex(currentIndex, #statisticSet)
        readCurrentStatisticIntoUI()
    end

    local function reset()
        currentIndex = 1
        readCurrentStatisticIntoUI()
    end

    local function initBarGraphUI()
        ui.frames.barGraphFrame =
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
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 0, y = -2}),
            ui.frames.mainInnerFrame
        )
        ui.controls.mainBarGraph =
            BarGraph(
            Component(
                ui.frames.barGraphFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.BAR_GRAPH_WIDTH,
                        height = constants.BAR_GRAPH_HEIGHT
                    },
                    "Intermediate text color",
                    "Top box text color"
                )
            ),
            nil,
            "",
            "Top box border color",
            "Top box text color",
            3,
            0,
            Graphics.ALIGNMENT_TYPE.HORIZONTAL,
            70
        )
    end

    local function initTopFrame()
        ui.frames.topFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.MAIN_FRAME_WIDTH - 10,
                    height = constants.TOP_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 3, y = 3}),
            ui.frames.mainInnerFrame
        )
        local arrowFrameWidth = 10
        local verticalOffset = -1
        local arrowFrameInfo =
            FrameFactory.createArrowFrame("LEFT_ARROW_LARGE", ui.frames.topFrame, arrowFrameWidth, verticalOffset)
        ui.frames.statisticLeftArrowFrame, ui.controls.statisticLeftButton = arrowFrameInfo.frame, arrowFrameInfo.button
        eventListeners.statisticLeft = MouseClickEventListener(ui.controls.statisticLeftButton, onBackwardStatisticClick)

        ui.controls.topLabel =
            TextLabel(
            Component(
                ui.frames.topFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.TOP_LABEL_WIDTH,
                        height = 0
                    },
                    nil,
                    nil
                )
            ),
            TextField(
                "",
                {x = 0, y = constants.TOP_LABEL_Y_OFFSET},
                TextStyle(
                    constants.TOP_LABEL_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )

        arrowFrameInfo =
            FrameFactory.createArrowFrame("RIGHT_ARROW_LARGE", ui.frames.topFrame, arrowFrameWidth, verticalOffset)
        ui.frames.statisticRightArrowFrame, ui.controls.statisticRightButton = arrowFrameInfo.frame, arrowFrameInfo.button

        eventListeners.statisticRight = MouseClickEventListener(ui.controls.statisticRightButton, onForwardStatisticClick)
    end

    local function createBottomFrame()
        ui.frames.bottomFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {width = constants.MAIN_FRAME_WIDTH - 10, height = constants.BOTTOM_FRAME_HEIGHT},
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 5, y = 4}),
            ui.frames.mainFrame
        )
        ui.controls.totalRunsLabel =
            TextLabel(
            Component(
                ui.frames.bottomFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.TOTAL_RUN_WIDTH,
                        height = 0
                    },
                    nil,
                    nil
                )
            ),
            TextField(
                "",
                {x = 0, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls.totalPlaytimeLabel =
            TextLabel(
            Component(
                ui.frames.bottomFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.TOTAL_PLAYTIME_WIDTH,
                        height = 0
                    },
                    nil,
                    nil
                )
            ),
            TextField(
                "",
                {x = 0, y = 1},
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
        table.insert(eventListeners, MouseClickEventListener(ui.controls.goBackButton, onGoBackClick))
    end

    local function initUI()
        ui.controls = {}
        ui.frames = {}
        ui.frames.mainFrame =
            Frame(
            Box(
                {
                    x = constants.MAIN_FRAME_X,
                    y = constants.MAIN_FRAME_Y
                },
                {
                    width = constants.MAIN_FRAME_WIDTH,
                    height = constants.MAIN_FRAME_HEIGHT
                },
                "Main background color",
                "Main background color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 5, y = 5}),
            nil
        )
        ui.frames.mainInnerFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.MAIN_FRAME_WIDTH - 10,
                    height = constants.MAIN_FRAME_HEIGHT - 10 - 22
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 0}),
            ui.frames.mainFrame
        )
        initTopFrame()
        initBarGraphUI()
        createBottomFrame()
    end

    function self.initialize(seedLogger)
        statisticSet = seedLogger.getPastRunStatistics()
        totalRuns = seedLogger.getTotalRuns()
        totalRunsPastLab = seedLogger.getTotalRunsPastLab()
        ui.controls.totalRunsLabel.setText("Total runs: " .. totalRuns)
        ui.controls.totalPlaytimeLabel.setText("Playtime: " .. tracker.getTotalHoursPlayed())
        reset()
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

return StatisticsScreen

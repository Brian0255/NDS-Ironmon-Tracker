local function StatsScreen(initialSettings, initialTracker, initialProgram, initialLogViewerScreen)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local ImageLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageLabel.lua")
    local ImageField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageField.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local Icon = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Icon.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local BarGraph = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/BarGraph.lua")
    local ScreenStack = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ScreenStack.lua")
    local logInfo
    local settings = initialSettings
    local tracker = initialTracker
    local program = initialProgram
    local logViewerScreen = initialLogViewerScreen
    local logPokemon
    local currentIDIndex
    local currentID
    local statistics
    local currentData
    local currentStatistic
    local currentStatisticIndex = 1

    local constants = {
        TOP_FRAME_OFFSET = 10,
        TOP_FRAME_WIDTH = 152,
        MAIN_FRAME_OFFSET = 46,
        TOP_LABEL_WIDTH = 116,
        TOP_FRAME_HEIGHT = 24,
        CURRENT_POKEMON_X_OFFSET = 46,
        CURRENT_POKEMON_HEIGHT = 36,
        BAR_GRAPH_WIDTH = 144,
        BAR_GRAPH_HEIGHT = 74
    }
    local ui = {}
    local eventListeners = {}
    local self = {}

    local function onGoBackClick()
    end

    local function readCurrentDataIntoUI()
        currentID = currentData[currentIDIndex]
        local data = PokemonData.POKEMON[currentID + 1]
        local currentIconSet = IconSets.SETS[settings.appearance.ICON_SET_INDEX]
        DrawingUtils.readPokemonIDIntoImageLabel(currentIconSet, currentID, ui.controls.pokemonImage)
        ui.controls.statBarGraph.setDataSet(logViewerScreen.readStats(logPokemon[currentID]))
        local name = data.name
        ui.controls.statBarGraph.setHeadingText("Base Stats (" .. data.bst .. " total)")
        ui.controls.currentPokemonLabel.setText("#" .. currentIDIndex .. ". " .. name)
        program.drawCurrentScreens()
    end

    local function readCurrentStatisticIntoUI()
        local name = currentStatistic[1]
        local nameLength = DrawingUtils.calculateWordPixelLength(name)
        --very jank calculation because the bigger font adds more space between letters
        local offsetX = (constants.TOP_LABEL_WIDTH - nameLength - #name - 2) / 2
        ui.controls.topLabel.setTextOffset({x = offsetX, y = 0})
        ui.controls.topLabel.setText(name)
        local nameToDescription = {
            ["Best Special Attackers"] = "The highest amount of Special Attack and Speed.",
            ["Best Physical Attackers"] = "The highest amount of Attack and Speed.",
            ["Biggest Special Walls"] = "The highest amount of HP and Special Defense.",
            ["Best Defensive Tanks"] = "The highest amount of HP and Defense.",
            ["Bulkiest Overall"] = "The highest amount of HP, Defense, and Special Defense.",
            ["Most Frail"] = "The worst amount of HP, Defense and Special Defense."
        }
        local description = nameToDescription[name]
        local totalWidth = ui.frames.mainFrame.getSize().width - 10
        local base = -30
        local centerX = base + ((totalWidth - DrawingUtils.calculateWordPixelLength(description)) / 2)
        ui.controls.description.setText(description)
        ui.controls.description.setTextOffset({x = centerX, y = 0})
    end

    local function setUpCurrentStatisticIndex()
        currentIDIndex = 1
        currentStatistic = statistics[currentStatisticIndex]
        currentData = currentStatistic[2]
        currentID = currentData[currentIDIndex]
        readCurrentStatisticIntoUI()
        readCurrentDataIntoUI()
    end

    local function onForwardStatisticClick()
        currentStatisticIndex = MiscUtils.increaseTableIndex(currentStatisticIndex, #statistics)
        setUpCurrentStatisticIndex()
    end

    local function onBackwardStatisticClick()
        currentStatisticIndex = MiscUtils.decreaseTableIndex(currentStatisticIndex, #statistics)
        setUpCurrentStatisticIndex()
    end

    local function onForwardPokemonClick()
        currentIDIndex = MiscUtils.increaseTableIndex(currentIDIndex, #currentData)
        readCurrentDataIntoUI()
    end

    local function onBackwardPokemonClick()
        currentIDIndex = MiscUtils.decreaseTableIndex(currentIDIndex, #currentData)
        readCurrentDataIntoUI()
    end

    function self.reset()
        currentStatisticIndex = 1
        setUpCurrentStatisticIndex()
    end

    function self.initialize(newLogInfo)
        logInfo = newLogInfo
        statistics = StatisticsOrganizer.createLogStatistics(logInfo)
        logPokemon = logInfo.getPokemon()
        setUpCurrentStatisticIndex()
    end

    local function onPokemonImageClick()
        logViewerScreen.addGoBackFunction(logViewerScreen.openStatsScreen)
        logViewerScreen.loadPokemonStats(currentID)
    end

    local function initMainStatArea()
        ui.frames.statAreaFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 0,
                    height = 0
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = -10, y = 2}),
            ui.frames.mainFrame
        )
        ui.controls.description =
            TextLabel(
            Component(
                ui.frames.statAreaFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.TOP_LABEL_WIDTH,
                        height = 16
                    },
                    nil,
                    nil
                )
            ),
            TextField(
                "The highest amount of special attack and speed.",
                {x = -30, y = 0},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.frames.currentPokemonFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 0,
                    height = constants.CURRENT_POKEMON_HEIGHT
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = constants.CURRENT_POKEMON_X_OFFSET, y = 0}),
            ui.frames.statAreaFrame
        )
        ui.controls.pokemonImage =
            ImageLabel(
            Component(ui.frames.currentPokemonFrame, Box({x = 0, y = 0}, {width = 30, height = 28}, nil, nil)),
            ImageField("", {x = 0, y = 0}, nil)
        )
        eventListeners.pokemonImage = MouseClickEventListener(ui.controls.pokemonImage, onPokemonImageClick)
        ui.controls.currentPokemonLabel =
            TextLabel(
            Component(
                ui.frames.currentPokemonFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.TOP_LABEL_WIDTH,
                        height = 20
                    },
                    nil,
                    nil
                )
            ),
            TextField(
                "Kyogre",
                {x = 4, y = 10},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.frames.dataFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 0,
                    height = 0
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 0, y = 0}),
            ui.frames.statAreaFrame
        )
        local arrowFrameWidth = 16
        local verticalOffset = 30
        local arrowFrameInfo =
            FrameFactory.createArrowFrame("LEFT_ARROW_LARGE", ui.frames.dataFrame, arrowFrameWidth, verticalOffset)
        ui.frames.dataLeftArrowFrame, ui.controls.dataLeftButton = arrowFrameInfo.frame, arrowFrameInfo.button
        eventListeners.dataLeft = MouseClickEventListener(ui.controls.dataLeftButton, onBackwardPokemonClick)
        ui.controls.statBarGraph =
            BarGraph(
            Component(
                ui.frames.dataFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.BAR_GRAPH_WIDTH,
                        height = constants.BAR_GRAPH_HEIGHT
                    },
                    nil,
                    nil
                )
            ),
            nil,
            nil,
            "Top box border color",
            "Top box text color",
            10,
            255
        )
        arrowFrameInfo =
            FrameFactory.createArrowFrame("RIGHT_ARROW_LARGE", ui.frames.dataFrame, arrowFrameWidth, verticalOffset)
        ui.frames.dataRightArrowFrame, ui.controls.dataRightButton = arrowFrameInfo.frame, arrowFrameInfo.button
        eventListeners.dataRight = MouseClickEventListener(ui.controls.dataRightButton, onForwardPokemonClick)
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
                    width = constants.TOP_FRAME_WIDTH,
                    height = constants.TOP_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 3, y = 3}),
            ui.frames.mainFrame
        )
        local arrowFrameWidth = 14
        local verticalOffset = 2
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
                "Strongest Special Attackers",
                {x = 0, y = 0},
                TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )

        arrowFrameInfo =
            FrameFactory.createArrowFrame("RIGHT_ARROW_LARGE", ui.frames.topFrame, arrowFrameWidth, verticalOffset)
        ui.frames.statisticRightArrowFrame, ui.controls.statisticRightButton = arrowFrameInfo.frame, arrowFrameInfo.button

        eventListeners.statisticRight = MouseClickEventListener(ui.controls.statisticRightButton, onForwardStatisticClick)
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
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = constants.MAIN_FRAME_OFFSET, y = 0}),
            nil
        )
        initTopFrame()
        initMainStatArea()
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

return StatsScreen

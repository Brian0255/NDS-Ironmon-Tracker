local function PokemonOverviewScreen(initialSettings, initialTracker, initialProgram, initialLogViewerScreen)
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
    local SearchKeyboard = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/SearchKeyboard.lua")
    local StatsScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/LogViewer/StatsScreen.lua")
    local ScreenStack = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ScreenStack.lua")
    local statsScreen
    local logViewerScreen = initialLogViewerScreen
    local settings = initialSettings
    local sortedPokemonIDs = {}
    local currentMatchSetIndex = 1
    local viewingMarked = false
    local currentMatchSets = {}
    local pokemonSearchKeyboard
    local program = initialProgram
    local tracker = initialTracker
    local logInfo
    local constants = {
        SEARCH_HEADER_HEIGHT = 21,
        RESULT_FRAME_HEIGHT = 55,
        POKEMON_BUTTON_HEIGHT = 13,
        SEARCH_RESULT_WIDTH = 34,
        RESULT_IMAGE_FRAME_WIDTH = 212,
        SEARCH_RESULT_HEIGHT = 38
    }
    local ui = {}
    local matchFrames = {}
    local matchClickEventListeners = {}
    local eventListeners = {}
    local self = {}
    local screens = {}

    local function setUpPokemonIDs()
        sortedPokemonIDs = {}
        if not viewingMarked then
            for id, _ in pairs(logInfo.getPokemon()) do
                table.insert(sortedPokemonIDs, id)
            end
            MiscUtils.sortPokemonIDsByName(sortedPokemonIDs)
        else
            sortedPokemonIDs = tracker.getMarkedIDs()
        end
        pokemonSearchKeyboard.updateItemSet(sortedPokemonIDs)
        logViewerScreen.updatePokemonStatIDs(sortedPokemonIDs)
    end

    local function updateBookmark()
        local iconName = "BOOKMARK_EMPTY_LARGE"
        if viewingMarked then
            iconName = "BOOKMARK_FILLED_LARGE"
        end
        ui.controls.bookmarkIcon.setIconName(iconName)
    end

    local function onBookmarkClick()
        viewingMarked = not viewingMarked
        updateBookmark()
        setUpPokemonIDs()
        pokemonSearchKeyboard.clearKeyboard()
    end

    function self.initialize(newLogInfo)
        logInfo = newLogInfo
        viewingMarked = false
        updateBookmark()
        setUpPokemonIDs()
        pokemonSearchKeyboard.updateItemSet(sortedPokemonIDs)
        pokemonSearchKeyboard.setDrawFunction(program.drawCurrentScreens)
    end

    local function clearMatchFrame(matchFrame, index)
        matchClickEventListeners[index].setOnClickParams(nil)
        matchFrame.nameLabel.setText("")
        matchFrame.imageLabel.setPath("")
    end

    local function clearMatches()
        currentMatchSets = {}
        for index, matchFrame in pairs(matchFrames) do
            clearMatchFrame(matchFrame, index)
        end
    end

    function self.reset()
        clearMatches()
        pokemonSearchKeyboard.clearKeyboard()
    end

    local function readCurrentMatchSetIntoUI()
        if #currentMatchSets == 0 then
            program.drawCurrentScreens()
            return
        end
        local matchSet = currentMatchSets[currentMatchSetIndex]
        for index = 1, 4, 1 do
            local id = matchSet[index]
            local matchFrame = matchFrames[index]
            if id ~= nil then
                local name = PokemonData.POKEMON[id + 1].name
                local nameLength = DrawingUtils.calculateWordPixelLength(name)
                local xOffset = (constants.SEARCH_RESULT_WIDTH - nameLength - 2) / 2
                matchFrame.nameLabel.setTextOffset({x = xOffset, y = 1})
                matchFrame.nameLabel.setText(name)
                local currentIconSet = IconSets.SETS[settings.appearance.ICON_SET_INDEX]
                DrawingUtils.readPokemonIDIntoImageLabel(currentIconSet, id, matchFrame.imageLabel)
                matchClickEventListeners[index].setOnClickParams(id)
            else
                clearMatchFrame(matchFrame, index)
            end
        end
        program.drawCurrentScreens()
    end

    local function onMatchClick(id)
        if id ~= nil then
            logViewerScreen.addGoBackFunction(logViewerScreen.goBackToOverview)
            logViewerScreen.loadPokemonStats(id)
        end
    end

    local function createMatchFrame()
        local matchFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.SEARCH_RESULT_WIDTH,
                    height = constants.SEARCH_RESULT_HEIGHT
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 1, {x = 0, y = 0}),
            ui.frames.resultImageFrame
        )
        local matchImage =
            ImageLabel(
            Component(matchFrame, Box({x = 0, y = 0}, {width = 30, height = 28}, nil, nil)),
            ImageField("", {x = 0, y = 0}, nil)
        )
        local matchLabel =
            TextLabel(
            Component(
                matchFrame,
                Box(
                    {x = 5, y = 5},
                    {
                        width = 0,
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
        table.insert(
            matchFrames,
            {
                frame = matchFrame,
                nameLabel = matchLabel,
                imageLabel = matchImage
            }
        )
        table.insert(matchClickEventListeners, MouseClickEventListener(matchFrame, onMatchClick))
    end

    local function createMatchFrames()
        for i = 1, 4, 1 do
            createMatchFrame()
        end
    end

    local function createMatchSets(matches)
        currentMatchSets = MiscUtils.splitTableByNumber(matches, 4)
        currentMatchSetIndex = 1
        readCurrentMatchSetIntoUI()
    end

    local function onForwardClick()
        currentMatchSetIndex = MiscUtils.increaseTableIndex(currentMatchSetIndex, #currentMatchSets)
        readCurrentMatchSetIntoUI()
    end

    local function onBackwardClick()
        currentMatchSetIndex = MiscUtils.decreaseTableIndex(currentMatchSetIndex, #currentMatchSets)
        readCurrentMatchSetIntoUI()
    end

    local function initTopUI()
        ui.frames.topFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 0,
                    height = constants.SEARCH_HEADER_HEIGHT
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 32, y = 0}),
            ui.frames.mainFrame
        )
        ui.controls.searchHeading =
            TextLabel(
            Component(
                ui.frames.topFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = 188,
                        height = constants.SEARCH_HEADER_HEIGHT
                    },
                    nil,
                    nil
                )
            ),
            TextField(
                "Click the keys below to search any pokemon:",
                {x = 0, y = 10},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.frames.bookmarkFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 26,
                    height = 26
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 5, y = 5}),
            ui.frames.topFrame
        )

        ui.controls.bookmarkIcon =
            Icon(
            Component(ui.frames.bookmarkFrame, Box({x = 0, y = 0}, {width = 16, height = 16}, nil, nil)),
            "BOOKMARK_EMPTY_LARGE",
            {x = 2, y = 1}
        )
        eventListeners.onBookmarkClick = MouseClickEventListener(ui.controls.bookmarkIcon, onBookmarkClick)
    end

    local function initStatsButton()
        ui.frames.statsFrame =
            Frame(
            Box(
                {
                    x = 214,
                    y = 148
                },
                {
                    width = 31,
                    height = 33
                },
                "Top box background color",
                "Top box border color"
            ),
            nil
        )
        local barHeights = {15, 27, 21}
        local barWidth = 9
        for i, barHeight in pairs(barHeights) do
            local xOffset = 2 + ((barWidth) * (i - 1))
            local yOffset = 4 + (25 - barHeight)
            TextLabel(
                Component(
                    ui.frames.statsFrame,
                    Box(
                        {x = xOffset, y = yOffset},
                        {
                            width = barWidth,
                            height = barHeight
                        },
                        "Top box border color",
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
        local statsLabel =
            TextLabel(
            Component(
                ui.frames.statsFrame,
                Box(
                    {x = 0, y = 21},
                    {
                        width = 31,
                        height = 12
                    },
                    "Top box background color",
                    "Top box border color"
                )
            ),
            TextField(
                "Stats",
                {x = 4, y = 0},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        table.insert(eventListeners, MouseClickEventListener(ui.frames.statsFrame, logViewerScreen.openStatsScreen))
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
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 5),
            nil
        )
        initTopUI()
        ui.frames.resultFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 0,
                    height = constants.RESULT_FRAME_HEIGHT
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 3, y = 10}),
            ui.frames.mainFrame
        )
        local frameInfo = FrameFactory.createArrowFrame("LEFT_ARROW_LARGE", ui.frames.resultFrame, 14, 12)
        ui.frames.leftArrowFrame = frameInfo.frame
        ui.controls.leftButton = frameInfo.button
        ui.frames.resultImageFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.RESULT_IMAGE_FRAME_WIDTH,
                    height = 0
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 21, {x = 6, y = 0}),
            ui.frames.resultFrame
        )
        createMatchFrames()
        frameInfo = FrameFactory.createArrowFrame("RIGHT_ARROW_LARGE", ui.frames.resultFrame, 14, 12)
        ui.frames.rightArrowFrame = frameInfo.frame
        ui.controls.rightButton = frameInfo.button
        ui.frames.searchFrame =
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
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 5, {x = 50, y = 0}),
            ui.frames.mainFrame
        )
        pokemonSearchKeyboard = SearchKeyboard(sortedPokemonIDs, ui.frames.searchFrame, createMatchSets, clearMatches)
        table.insert(eventListeners, MouseClickEventListener(ui.controls.rightButton, onForwardClick))
        table.insert(eventListeners, MouseClickEventListener(ui.controls.leftButton, onBackwardClick))
        initStatsButton()
        statsScreen = StatsScreen(settings, tracker, program, self)
    end

    function self.runEventListeners()
        for _, eventListener in pairs(eventListeners) do
            eventListener.listen()
        end
        for _, eventListener in pairs(matchClickEventListeners) do
            eventListener.listen()
        end
        pokemonSearchKeyboard.runEventListeners()
    end

    function self.show()
        local moreThan4 = #currentMatchSets > 1
        ui.controls.rightButton.setVisibility(moreThan4)
        ui.controls.leftButton.setVisibility(moreThan4)
        ui.frames.mainFrame.show()
        ui.frames.statsFrame.show()
    end

    initUI()

    return self
end

return PokemonOverviewScreen

local function PokemonStatScreen(initialSettings, initialTracker, initialProgram, initialLogViewerScreen)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/cOMPONENT.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local ImageLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageLabel.lua")
    local ImageField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageField.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local Icon = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Icon.lua")
    local BarGraph = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/BarGraph.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local ScrollBar = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ScrollBar.lua")
    local logViewerScreen = initialLogViewerScreen
    local settings = initialSettings
    local movesScrollBar
    local sortedPokemonIDs = {}
    local logPokemon = {}
    local currentIndex = 1
    local program = initialProgram
    local logInfo
    local constants = {
        STATS_FRAME_HEIGHT = Graphics.SIZES.SCREEN_HEIGHT - 2 * Graphics.SIZES.BORDER_MARGIN -
            Graphics.LOG_VIEWER.TAB_HEIGHT -
            40,
        STATS_FRAME_WIDTH = 158,
        NAV_NAME_FRAME_HEIGHT = 36,
        MOVES_FRAME_HEIGHT = 120,
        MOVE_LIST_FRAME_HEIGHT = 96,
        MOVE_ENTRY_HEIGHT = 12,
        MOVES_FRAME_WIDTH = 79,
        MOVES_LABEL_HEIGHT = 16,
        POKEMON_NAME_WIDTH = 66
    }
    local ui = {}
    local eventListeners = {}
    local self = {}

    local function setUpPokemonIDs()
        logPokemon = logInfo.getPokemon()
        sortedPokemonIDs = {}
        for id, _ in pairs(logPokemon) do
            table.insert(sortedPokemonIDs, id)
        end
        MiscUtils.sortPokemonIDsByName(sortedPokemonIDs)
    end

    function self.initialize(newLogInfo)
        logInfo = newLogInfo
        setUpPokemonIDs()
    end

    local function readScrollMovesIntoUI()
        local items = movesScrollBar.getViewedItems()
        for i = 1, 8, 1 do
            local moveString = ""
            local moveInfo = items[i]
            if moveInfo ~= nil then
             moveString = moveInfo.level .. " " .. MoveData.MOVES[moveInfo.move+1].name
            end
            ui.controls.moveLabels[i].setText(moveString)
        end
        program.drawCurrentScreens()
    end

    local function readCurrentIndexIntoUI()
        local currentID = sortedPokemonIDs[currentIndex]
        local name = PokemonData.POKEMON[currentID + 1].name
        local nameLength = DrawingUtils.calculateWordPixelLength(name)
        local xOffset = (constants.POKEMON_NAME_WIDTH - nameLength - 2) / 2
        ui.controls.pokemonNameLabel.setText(name)
        local currentIconSet = IconSets.SETS[settings.appearance.ICON_SET_INDEX]
        DrawingUtils.readPokemonIDIntoImageLabel(currentIconSet, currentID, ui.controls.pokemonImage, {x = 1, y = 0})
        local pokemon = logPokemon[currentID + 1]
        local orderedStats = {"HP", "ATK", "DEF", "SPA", "SPD", "SPE"}
        local dataSet = {}
        for _, stat in pairs(orderedStats) do
            table.insert(dataSet, {stat, pokemon.stats[stat]})
        end
        movesScrollBar.setItems(pokemon.moves)
        local heading = "Base Stats (" .. PokemonData.POKEMON[currentID + 1].bst .. " total)"
        ui.controls.statBarGraph.setDataSet(dataSet)
        ui.controls.statBarGraph.setHeadingText(heading)
        readScrollMovesIntoUI()
    end

    local function onForwardClick()
        currentIndex = MiscUtils.increaseTableIndex(currentIndex, #sortedPokemonIDs)
        readCurrentIndexIntoUI()
    end

    local function onBackwardClick()
        currentIndex = MiscUtils.decreaseTableIndex(currentIndex, #sortedPokemonIDs)
        readCurrentIndexIntoUI()
    end

    local function initMovesUI()
        ui.frames.mainMovesFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 0,
                    height = constants.MOVES_FRAME_HEIGHT
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 0}),
            ui.frames.mainFrame
        )
        ui.controls.movesLabel =
            TextLabel(
            Component(
                ui.frames.mainMovesFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.MOVES_FRAME_WIDTH,
                        height = constants.MOVES_LABEL_HEIGHT
                    },
                    "Top box background color",
                    "Top box border color"
                )
            ),
            TextField(
                "Moves",
                {x = 22, y = 0},
                TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        ui.frames.moveScrollerFrame = Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.MOVES_FRAME_WIDTH,
                    height = constants.MOVE_LIST_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            nil,
            ui.frames.mainMovesFrame
        )
        ui.frames.moveListFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.MOVES_FRAME_WIDTH-10,
                    height = 0
                },
                nil, nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 0}),
            ui.frames.moveScrollerFrame
        )
        ui.controls.moveLabels = {}
        for i = 1, 8, 1 do
            ui.controls.moveLabels[i] =
                TextLabel(
                Component(
                    ui.frames.moveListFrame,
                    Box(
                        {x = 0, y = 0},
                        {
                            width = constants.MOVES_FRAME_WIDTH,
                            height = constants.MOVE_ENTRY_HEIGHT
                        },
                        nil,
                        nil
                    )
                ),
                TextField(
                    "test",
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
        movesScrollBar = ScrollBar(ui.frames.moveScrollerFrame, 8, {})
    end

    local function initNavNameFrame()
        ui.frames.navNameFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 0,
                    height = constants.NAV_NAME_FRAME_HEIGHT
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 3, {x = 8, y = 0}),
            ui.frames.nameStatsFrame
        )
        local arrowFrameInfo = FrameFactory.createArrowFrame("LEFT_ARROW_LARGE", ui.frames.navNameFrame, 20, 9)
        ui.frames.leftArrowFrame, ui.controls.leftArrowButton = arrowFrameInfo.frame, arrowFrameInfo.button

        ui.controls.pokemonImage =
            ImageLabel(
            Component(ui.frames.navNameFrame, Box({x = 0, y = 0}, {width = 30, height = 28}, nil, nil)),
            ImageField("", {x = 0, y = 0}, nil)
        )

        ui.controls.pokemonNameLabel =
            TextLabel(
            Component(
                ui.frames.navNameFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.POKEMON_NAME_WIDTH,
                        height = 0
                    },
                    nil,
                    nil
                )
            ),
            TextField(
                "",
                {x = 0, y = 8},
                TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )

        arrowFrameInfo = FrameFactory.createArrowFrame("RIGHT_ARROW_LARGE", ui.frames.navNameFrame, 0, 9)
        ui.frames.rightArrowFrame, ui.controls.rightArrowButton = arrowFrameInfo.frame, arrowFrameInfo.button

        table.insert(eventListeners, MouseClickEventListener(ui.controls.rightArrowButton, onForwardClick))
        table.insert(eventListeners, MouseClickEventListener(ui.controls.leftArrowButton, onBackwardClick))
    end

    local function initStatGraph()
        ui.controls.statBarGraph =
            BarGraph(
            Component(
                ui.frames.nameStatsFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.STATS_FRAME_WIDTH,
                        height = 82
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
    end

    local function initMainStatsUI()
        ui.frames.nameStatsFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.STATS_FRAME_WIDTH,
                    height = constants.STATS_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL),
            ui.frames.mainFrame
        )
        initNavNameFrame()
        initStatGraph()
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
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 3, {x = 3, y = 3}),
            nil
        )
        initMainStatsUI()
        initMovesUI()
    end

    function self.loadPokemonID(id)
        for index, compare in pairs(sortedPokemonIDs) do
            if compare == id then
                currentIndex = index
            end
        end
        readCurrentIndexIntoUI()
        readScrollMovesIntoUI()
    end

    function self.runEventListeners()
        movesScrollBar.update()
        for _, eventListener in pairs(eventListeners) do
            eventListener.listen()
        end
    end

    function self.show()
        ui.frames.mainFrame.show()
    end

    initUI()
    movesScrollBar.setScrollReadingFunction(readScrollMovesIntoUI)

    return self
end

return PokemonStatScreen

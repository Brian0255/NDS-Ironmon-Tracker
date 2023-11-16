local function PokemonStatScreen(initialSettings, initialTracker, initialProgram, initialLogViewerScreen)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local ImageLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageLabel.lua")
    local ImageField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageField.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local BarGraph = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/BarGraph.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local HoverEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/HoverEventListener.lua")
    local ScrollBar = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ScrollBar.lua")
    local FrameCounter = dofile(Paths.FOLDERS.DATA_FOLDER .. "/FrameCounter.lua")
    local BrowsManager = dofile(Paths.FOLDERS.EXTRAS_FOLDER .. "/BrowsManager.lua")

    local logViewerScreen = initialLogViewerScreen
    local settings = initialSettings
    local movesScrollBar
    local sortedPokemonIDs = {}
    local gymTMCompatibilityTable = {}
    local viewingMoves = true
    local lastViewedItems = {}
    local logPokemon = {}
    local currentIndex = 1
    local currentEvoIndex = 1
    local currentEvoList = {}
    local rankingStatistics = {}
    local program = initialProgram
    local logInfo
    local browsManager
    local constants = {
        STATS_FRAME_HEIGHT = Graphics.SIZES.SCREEN_HEIGHT - 2 * Graphics.SIZES.BORDER_MARGIN - Graphics.LOG_VIEWER.TAB_HEIGHT -
            46,
        STATS_FRAME_WIDTH = 144,
        NAV_NAME_FRAME_HEIGHT = 36,
        MOVES_FRAME_HEIGHT = 112,
        MOVE_LIST_FRAME_HEIGHT = 98,
        MOVE_ENTRY_HEIGHT = 12,
        MOVES_FRAME_WIDTH = 93,
        MOVES_LABEL_HEIGHT = 14,
        POKEMON_NAME_WIDTH = 66,
        ABILITY_FRAME_HEIGHT = 25,
        EVOS_FRAME_HEIGHT = 32
    }
    local activeHoverFrame = nil
    local ui = {}
    local eventListeners = {}
    local abilityHoverListeners = {}
    local moveHoverListeners = {}
    local hoverListeners = {}
    local frameCounters = {}
    local self = {}

    local function onHoverInfoEnd()
        activeHoverFrame = nil
        program.drawCurrentScreens()
    end

    local function onMoveHoverEnd()
        activeHoverFrame = nil
        hoverListeners.moveInfoListener = nil
        program.drawCurrentScreens()
    end

    local function onHoverInfo(params)
        activeHoverFrame = UIUtils.createAndDrawHoverFrame(params, program.drawCurrentScreens, ui.frames.mainFrame)
    end

    local function setUpPokemonIDs()
        logPokemon = logInfo.getPokemon()
        sortedPokemonIDs = {}
        for id, _ in pairs(logPokemon) do
            table.insert(sortedPokemonIDs, id)
        end
        MiscUtils.sortPokemonIDsByName(sortedPokemonIDs)
    end

    function self.getCurrentIndex()
        return currentIndex
    end

    function self.updateIDs(newIDs)
        sortedPokemonIDs = newIDs
    end

    function self.initialize(newLogInfo)
        logInfo = newLogInfo
        setUpPokemonIDs()
        browsManager =
            BrowsManager(initialSettings, ui, frameCounters, initialProgram, initialProgram.UI_SCREENS.LOG_VIEWER_SCREEN)
        browsManager.initialize()
        rankingStatistics =
            StatisticsOrganizer.createLogRankingStatistics(logPokemon, MiscUtils.shallowCopy(sortedPokemonIDs))
        if program.getGameInfo().GEN == 5 then
            --subtract 13
            ui.frames.mainMovesFrame.resize({width = constants.MOVES_FRAME_WIDTH, height = 100})
            ui.frames.moveScrollerFrame.resize({width = constants.MOVES_FRAME_WIDTH, height = 86})
            ui.frames.abilityListFrame.resize({width = constants.MOVES_FRAME_WIDTH, height = 37})
            movesScrollBar.setSpaceAvailable(7)
        end
    end

    local function onPokemonImageHover(params)
        activeHoverFrame = UIUtils.createAndDrawTypeResistancesFrame(params, program.drawCurrentScreens, ui.frames.mainFrame)
    end

    local function onMoveInfoClick(params)
        if activeHoverFrame ~= nil then
            return
        end
        activeHoverFrame = UIUtils.createAndDrawMoveHoverFrame(params, program.drawCurrentScreens, ui.frames.mainFrame)
        hoverListeners.moveInfoListener = HoverEventListener(params.control, nil, nil, onMoveHoverEnd)
    end

    local function readMoveIntoListener(index, move)
        local moveListener = moveHoverListeners[index]
        local params = moveListener.getOnClickParams()
        params.move = move
        moveListener.setOnClickParams(params)
        activeHoverFrame = nil
    end

    local function readScrollMovesIntoUI()
        local items = movesScrollBar.getViewedItems()
        for i = 1, 8, 1 do
            local moveString = ""
            local moveInfo = items[i]
            if moveInfo ~= nil then
                local level = tostring(moveInfo.level)
                if #level == 1 then
                    level = "  " .. level
                end
                moveString = level .. " " .. MoveData.MOVES[moveInfo.move + 1].name
                readMoveIntoListener(i, moveInfo.move)
            else
                moveHoverListeners[i].getOnClickParams().move = -1
            end
            ui.controls.moveLabels[i].setTextColorKey("Top box text color")
            ui.controls.moveLabels[i].setText(moveString)
        end
        ui.controls.movesLabel.setText("Moves")
        ui.controls.movesLabel.setTextOffset({x = 16, y = -1})
        program.drawCurrentScreens()
    end

    local function readTMMovesIntoUI(compatibilityTable)
        local items = movesScrollBar.getViewedItems()
        for i = 1, 8, 1 do
            local label = ui.controls.moveLabels[i]
            local moveString = ""
            local TMInfo = items[i]
            if TMInfo ~= nil then
                local TM, canLearn = TMInfo[1], TMInfo[2]
                local moveID = -1
                if TM ~= -1 then
                    moveID = logInfo.getTMs()[TM]
                    local moveName = MoveData.MOVES[moveID + 1].name
                    moveString = string.format("TM %02d " .. moveName, TM)
                    local textColorKey = "Top box text color"
                    if canLearn then
                        textColorKey = "Positive text color"
                    end
                    label.setTextColorKey(textColorKey)
                else
                    moveHoverListeners[i].getOnClickParams().move = -1
                end
                readMoveIntoListener(i, moveID)
            else
                moveHoverListeners[i].getOnClickParams().move = -1
            end
            label.setText(moveString)
        end
        ui.controls.movesLabel.setText("Gym TMs")
        ui.controls.movesLabel.setTextOffset({x = 9, y = -1})
        program.drawCurrentScreens()
    end

    local function readAbilitiesIntoUI(pokemon)
        local max = 3
        if program.getGameInfo().GEN ~= 5 then
            max = 2
        end
        for i = 1, max, 1 do
            local abilityID = pokemon.abilities[i]
            local hoverListener = abilityHoverListeners[i]
            local params = hoverListener.getOnHoverParams()
            if abilityID == nil then
                ui.controls.abilityLabels[i].setText("")
                params.text = ""
            else
                local abilityInfo = AbilityData.ABILITIES[abilityID + 1]
                params.text = abilityInfo.description
                hoverListener.setOnHoverParams(params)
                local rightText = ""
                if i == 3 then
                    rightText = " (HA)"
                end
                ui.controls.abilityLabels[i].setText(i .. ". " .. abilityInfo.name .. rightText)
            end
        end
    end

    local function readGymTMs(pokemon)
        local gymTMs = program.getGameInfo().GYM_TMS
        gymTMCompatibilityTable = {}
        for i, gymTM in pairs(gymTMs) do
            gymTMCompatibilityTable[i] = {gymTM, pokemon.pokemonTMsLearnable[gymTM]}
        end
    end

    local function readCurrentEvoIntoUI()
        local currentID = sortedPokemonIDs[currentIndex]
        local totalEvos = 0
        if currentEvoList ~= nil then
            totalEvos = #currentEvoList
            local evolution = currentEvoList[currentEvoIndex]
            if evolution ~= nil then
                local currentIconSet = IconSets.SETS[settings.appearance.ICON_SET_INDEX]
                DrawingUtils.readPokemonIDIntoImageLabel(currentIconSet, evolution, ui.controls.evoImage)
                local evoInfo = PokemonData.POKEMON[currentID + 1].evolution
                if PokemonData.EVO_LONGER_NAMES[evoInfo] then
                    evoInfo = PokemonData.EVO_LONGER_NAMES[evoInfo][currentEvoIndex]
                end
                if tonumber(evoInfo) ~= nil then
                    evoInfo = "Level " .. evoInfo
                end
                ui.controls.evoInfoLabel.setText(evoInfo)
                eventListeners.evoImageListener.setOnClickParams(evolution)
            end
        end
        ui.frames.evoLeftArrowFrame.setVisibility(totalEvos > 1)
        ui.frames.evoRightArrowFrame.setVisibility(totalEvos > 1)
        ui.controls.evoRightButton.setVisibility(totalEvos > 1)
        ui.controls.evoLeftButton.setVisibility(totalEvos > 1)
        ui.controls.evoImage.setVisibility(totalEvos ~= 0)
        if totalEvos == 0 then
            ui.controls.evoInfoLabel.setText("None")
        end
    end

    local function readCurrentIndexIntoUI()
        local currentID = sortedPokemonIDs[currentIndex]
        local name = PokemonData.POKEMON[currentID + 1].name
        local nameLength = DrawingUtils.calculateWordPixelLength(name)
        browsManager.setCurrentPokemon(
            {["pokemonID"] = currentID, ["baseFormData"] = PokemonData.POKEMON[currentID + 1].baseFormData}
        )
        ui.controls.pokemonNameLabel.setText(name)
        local currentIconSet = IconSets.SETS[settings.appearance.ICON_SET_INDEX]
        DrawingUtils.readPokemonIDIntoImageLabel(currentIconSet, currentID, ui.controls.pokemonImage)
        local pokemon = logPokemon[currentID]
        movesScrollBar.setItems(pokemon.moves)
        local dataSet = logViewerScreen.readStats(pokemon)
        readGymTMs(pokemon)
        readAbilitiesIntoUI(pokemon)
        local pokemonImageListener = hoverListeners.pokemonImageListener
        local pokemonImageParams = pokemonImageListener.getOnHoverParams()
        pokemonImageParams.pokemon = pokemon
        pokemonImageListener.setOnHoverParams(pokemonImageParams)
        local heading = "Base Stats (" .. pokemon.bst .. " total)"
        ui.controls.statBarGraph.setDataSet(dataSet)
        ui.controls.statBarGraph.setHeadingText(heading)
        currentEvoList = pokemon.evolutions
        currentEvoIndex = 1
        readCurrentEvoIntoUI()
        viewingMoves = true
        movesScrollBar.setScrollReadingFunction(readScrollMovesIntoUI)
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

    local function onRightEvoClick()
        currentEvoIndex = MiscUtils.increaseTableIndex(currentEvoIndex, #currentEvoList)
        readCurrentEvoIntoUI()
        program.drawCurrentScreens()
    end

    local function onLeftEvoClick()
        currentEvoIndex = MiscUtils.decreaseTableIndex(currentEvoIndex, #currentEvoList)
        readCurrentEvoIntoUI()
        program.drawCurrentScreens()
    end

    local function onMoveClick()
        viewingMoves = not viewingMoves
        local currentID = sortedPokemonIDs[currentIndex]
        lastViewedItems = {}
        local items = logPokemon[currentID].moves
        local readingFunction = readScrollMovesIntoUI
        if not viewingMoves then
            items = gymTMCompatibilityTable
            readingFunction = readTMMovesIntoUI
        end
        movesScrollBar.setItems(items)
        movesScrollBar.setScrollReadingFunction(readingFunction)
        readingFunction()
    end

    local function createMoveAbilityEntry(parentFrame)
        local label =
            TextLabel(
            Component(
                parentFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.MOVES_FRAME_WIDTH - 8,
                        height = constants.MOVE_ENTRY_HEIGHT
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
        return label
    end

    local function initAbilitiesUI()
        ui.frames.mainAbilityFrame =
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
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 0}),
            ui.frames.movesAbilityFrame
        )
        ui.controls.abilityLabel =
            TextLabel(
            Component(
                ui.frames.mainAbilityFrame,
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
                "Abilities",
                {x = 25, y = -1},
                TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        ui.frames.abilityListFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.MOVES_FRAME_WIDTH,
                    height = constants.ABILITY_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 1, y = 1}),
            ui.frames.mainAbilityFrame
        )
        ui.controls.abilityLabels = {}
        for i = 1, 3, 1 do
            ui.controls.abilityLabels[i] = createMoveAbilityEntry(ui.frames.abilityListFrame)
            table.insert(
                abilityHoverListeners,
                HoverEventListener(
                    ui.controls.abilityLabels[i],
                    onHoverInfo,
                    {
                        BGColorKey = "Top box background color",
                        BGColorFillKey = "Top box border color",
                        text = "",
                        textColorKey = "Top box text color",
                        width = 120,
                        alignment = Graphics.HOVER_ALIGNMENT_TYPE.ALIGN_ABOVE
                    },
                    onHoverInfoEnd
                )
            )
        end
    end

    local function initMovesUI()
        ui.frames.movesAbilityFrame =
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
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 3, {x = 0, y = 0}),
            ui.frames.mainFrame
        )

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
            ui.frames.movesAbilityFrame
        )
        ui.frames.moveNavFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.MOVES_FRAME_WIDTH,
                    height = constants.MOVES_LABEL_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 2, y = 0}),
            ui.frames.mainMovesFrame
        )
        local arrowWidth = 12
        local arrowFrameInfo = FrameFactory.createArrowFrame("LEFT_ARROW_LARGE", ui.frames.moveNavFrame, arrowWidth, 1)
        ui.frames.leftMoveArrow, ui.controls.leftMoveArrowButton = arrowFrameInfo.frame, arrowFrameInfo.button
        ui.controls.movesLabel =
            TextLabel(
            Component(
                ui.frames.moveNavFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.MOVES_FRAME_WIDTH - 30,
                        height = constants.MOVES_LABEL_HEIGHT
                    },
                    nil,
                    nil
                )
            ),
            TextField(
                "Moves",
                {x = 11, y = -1},
                TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        arrowFrameInfo = FrameFactory.createArrowFrame("RIGHT_ARROW_LARGE", ui.frames.moveNavFrame, arrowWidth, 1)
        ui.frames.rightMoveArrow, ui.controls.rightMoveArrowButton = arrowFrameInfo.frame, arrowFrameInfo.button
        table.insert(eventListeners, MouseClickEventListener(ui.controls.rightMoveArrowButton, onMoveClick))
        table.insert(eventListeners, MouseClickEventListener(ui.controls.leftMoveArrowButton, onMoveClick))
        ui.frames.moveScrollerFrame =
            Frame(
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
                    width = constants.MOVES_FRAME_WIDTH - 10,
                    height = 0
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 1, y = 1}),
            ui.frames.moveScrollerFrame
        )
        ui.controls.moveLabels = {}
        for i = 1, 8, 1 do
            ui.controls.moveLabels[i] = createMoveAbilityEntry(ui.frames.moveListFrame)
            table.insert(
                moveHoverListeners,
                MouseClickEventListener(
                    ui.controls.moveLabels[i],
                    onMoveInfoClick,
                    {
                        BGColorKey = "Top box background color",
                        BGColorFillKey = "Top box border color",
                        move = nil,
                        control = ui.controls.moveLabels[i]
                    }
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
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 3, {x = 6, y = 2}),
            ui.frames.nameStatsFrame
        )
        local arrowFrameInfo = FrameFactory.createArrowFrame("LEFT_ARROW_LARGE", ui.frames.navNameFrame, 12, 8)
        ui.frames.leftArrowFrame, ui.controls.leftArrowButton = arrowFrameInfo.frame, arrowFrameInfo.button

        ui.controls.pokemonImage =
            ImageLabel(
            Component(ui.frames.navNameFrame, Box({x = 0, y = 0}, {width = 30, height = 28}, nil, nil)),
            ImageField("", {x = 0, y = 0}, nil)
        )

        hoverListeners.pokemonImageListener =
            HoverEventListener(
            ui.controls.pokemonImage,
            onPokemonImageHover,
            {pokemon = nil, mainFrame = ui.frames.mainFrame},
            onHoverInfoEnd
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
                {x = 0, y = 7},
                TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )

        arrowFrameInfo = FrameFactory.createArrowFrame("RIGHT_ARROW_LARGE", ui.frames.navNameFrame, 0, 8)
        ui.frames.rightArrowFrame, ui.controls.rightArrowButton = arrowFrameInfo.frame, arrowFrameInfo.button

        table.insert(eventListeners, MouseClickEventListener(ui.controls.rightArrowButton, onForwardClick))
        table.insert(eventListeners, MouseClickEventListener(ui.controls.leftArrowButton, onBackwardClick))
    end

    local function onEvoImageClick(evolution)
        logViewerScreen.addGoBackFunction(self.loadPokemonID, sortedPokemonIDs[currentIndex])
        self.loadPokemonID(evolution)
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
                        height = 74
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
        ui.frames.statsEvosFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.STATS_FRAME_WIDTH,
                    height = 0
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 3),
            ui.frames.mainFrame
        )
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
            ui.frames.statsEvosFrame
        )
        initNavNameFrame()
        initStatGraph()
    end

    local function initEvolutionsUI()
        ui.frames.evosFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.STATS_FRAME_WIDTH,
                    height = constants.EVOS_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0),
            ui.frames.statsEvosFrame
        )
        ui.controls.evosLabel =
            TextLabel(
            Component(
                ui.frames.evosFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = 24,
                        height = 0
                    },
                    nil,
                    nil
                )
            ),
            TextField(
                "Evos:",
                {x = 3, y = 10},
                TextStyle(9, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        ui.frames.evoImageFrame =
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
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 0, y = 2}),
            ui.frames.evosFrame
        )
        local arrowFrameInfo = FrameFactory.createArrowFrame("LEFT_ARROW_LARGE", ui.frames.evoImageFrame, 12, 8)
        ui.frames.evoLeftArrowFrame, ui.controls.evoLeftButton = arrowFrameInfo.frame, arrowFrameInfo.button

        ui.controls.evoImage =
            ImageLabel(
            Component(ui.frames.evoImageFrame, Box({x = 0, y = 0}, {width = 32, height = 28}, nil, nil)),
            ImageField("", {x = 0, y = 0}, nil)
        )

        ui.controls.evoInfoLabel =
            TextLabel(
            Component(
                ui.frames.evoImageFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = 60,
                        height = 0
                    },
                    nil,
                    nil
                )
            ),
            TextField(
                "",
                {x = 1, y = 8},
                TextStyle(9, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )

        arrowFrameInfo = FrameFactory.createArrowFrame("RIGHT_ARROW_LARGE", ui.frames.evoImageFrame, 14, 8)
        ui.frames.evoRightArrowFrame, ui.controls.evoRightButton = arrowFrameInfo.frame, arrowFrameInfo.button

        eventListeners.leftEvoListener = MouseClickEventListener(ui.controls.evoLeftButton, onLeftEvoClick, nil)
        eventListeners.rightEvoListener = MouseClickEventListener(ui.controls.evoRightButton, onRightEvoClick, nil)
        eventListeners.evoImageListener = MouseClickEventListener(ui.controls.evoImage, onEvoImageClick, nil)
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
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 3, {x = 3, y = 3}),
            nil
        )
        initMainStatsUI()
        initEvolutionsUI()
        initMovesUI()
        initAbilitiesUI()
    end

    function self.loadPokemonID(id)
        lastViewedItems = {}
        for index, compare in pairs(sortedPokemonIDs) do
            if compare == id then
                currentIndex = index
            end
        end
        readCurrentIndexIntoUI()
    end

    function self.runEventListeners()
        movesScrollBar.update()
        local listenerGroups = {eventListeners, abilityHoverListeners, hoverListeners, moveHoverListeners}
        for _, group in pairs(listenerGroups) do
            for _, eventListener in pairs(group) do
                eventListener.listen()
            end
        end
        self.runFrameCounters()
    end

    function self.runFrameCounters()
        for _, counter in pairs(frameCounters) do
            counter.decrement()
        end
    end

    function self.show()
        browsManager.show()
        ui.frames.mainFrame.show()
        if activeHoverFrame ~= nil then
            activeHoverFrame.show()
        end
    end

    initUI()

    return self
end

return PokemonStatScreen

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
    local HoverEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/HoverEventListener.lua")
    local ScrollBar = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ScrollBar.lua")
    local logViewerScreen = initialLogViewerScreen
    local settings = initialSettings
    local movesScrollBar
    local sortedPokemonIDs = {}
    local gymTMCompatibilityTable = {}
    local viewingMoves = true
    local logPokemon = {}
    local currentIndex = 1
    local program = initialProgram
    local logInfo
    local constants = {
        STATS_FRAME_HEIGHT = Graphics.SIZES.SCREEN_HEIGHT - 2 * Graphics.SIZES.BORDER_MARGIN -
            Graphics.LOG_VIEWER.TAB_HEIGHT -
            40,
        STATS_FRAME_WIDTH = 150,
        NAV_NAME_FRAME_HEIGHT = 36,
        MOVES_FRAME_HEIGHT = 100,
        MOVE_LIST_FRAME_HEIGHT = 86,
        MOVE_ENTRY_HEIGHT = 12,
        MOVES_FRAME_WIDTH = 87,
        MOVES_LABEL_HEIGHT = 14,
        POKEMON_NAME_WIDTH = 66,
        ABILITY_FRAME_HEIGHT = 37
    }
    local activeHoverFrame = nil
    local ui = {}
    local eventListeners = {}
    local abilityHoverListeners = {}
    local moveHoverListeners = {}
    local hoverListeners = {}
    local self = {}

    local function onHoverInfoEnd()
        activeHoverFrame = nil
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

    function self.initialize(newLogInfo)
        logInfo = newLogInfo
        setUpPokemonIDs()
    end

    local function onPokemonImageHover(params)
        activeHoverFrame =
            UIUtils.createAndDrawTypeResistancesFrame(params, program.drawCurrentScreens, ui.frames.mainFrame)
    end

    local function onMoveInfoHover(params)
        activeHoverFrame = UIUtils.createAndDrawMoveHoverFrame(params, program.drawCurrentScreens, ui.frames.mainFrame)
    end

    local function readScrollMovesIntoUI()
        local items = movesScrollBar.getViewedItems()
        for i = 1, 8, 1 do
            local moveString = ""
            local moveInfo = items[i]
            if moveInfo ~= nil then
                local level = moveInfo.level
                if #level == 1 then
                    level = "  " .. level
                end
                moveString = level .. " " .. MoveData.MOVES[moveInfo.move + 1].name
                local moveListener = moveHoverListeners[i]
                local params = moveListener.getOnHoverParams()
                params.move = moveInfo.move
                moveListener.setOnHoverParams(params)
                activeHoverFrame = nil
                moveListener.setBackToZero()
            end
            ui.controls.moveLabels[i].setTextColorKey("Top box text color")
            ui.controls.moveLabels[i].setText(moveString)
        end
        ui.controls.movesLabel.setText("Moves")
        ui.controls.movesLabel.setTextOffset({x = 12, y = -1})
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
                local moveID = logInfo.getTMs()[TM]
                local moveName = MoveData.MOVES[moveID + 1].name
                moveString = "TM" .. TM .. " " .. moveName
                local textColorKey = "Top box text color"
                if canLearn then
                    textColorKey = "Positive text color"
                end
                label.setTextColorKey(textColorKey)
            end
            label.setText(moveString)
        end
        ui.controls.movesLabel.setText("Gym TMs")
        ui.controls.movesLabel.setTextOffset({x = 6, y = -1})
        program.drawCurrentScreens()
    end

    local function readAbilitiesIntoUI(pokemon)
        for i = 1, 3, 1 do
            local abilityID = pokemon.abilities[i]
            if abilityID == nil then
                ui.controls.abilityLabels[i].setText("")
            else
                local abilityInfo = AbilityData.ABILITIES[abilityID + 1]
                local hoverListener = abilityHoverListeners[i]
                local params = hoverListener.getOnHoverParams()
                params.text = abilityInfo.description
                hoverListener.setOnHoverParams(params)
                ui.controls.abilityLabels[i].setText(i .. ". " .. abilityInfo.name)
            end
        end
    end

    local function readCurrentIndexIntoUI()
        local currentID = sortedPokemonIDs[currentIndex]
        local name = PokemonData.POKEMON[currentID + 1].name
        local nameLength = DrawingUtils.calculateWordPixelLength(name)
        ui.controls.pokemonNameLabel.setText(name)
        local currentIconSet = IconSets.SETS[settings.appearance.ICON_SET_INDEX]
        DrawingUtils.readPokemonIDIntoImageLabel(currentIconSet, currentID, ui.controls.pokemonImage, {x = 1, y = 0})
        local pokemon = logPokemon[currentID]
        local orderedStats = {"HP", "ATK", "DEF", "SPA", "SPD", "SPE"}
        local dataSet = {}
        for _, stat in pairs(orderedStats) do
            table.insert(dataSet, {stat, pokemon.stats[stat]})
        end
        movesScrollBar.setItems(pokemon.moves)
        local gymTMs = program.getGameInfo().GYM_TMS.set1
        gymTMCompatibilityTable = {}
        for i, gymTM in pairs(gymTMs) do
            gymTMCompatibilityTable[i] = {gymTM, pokemon.pokemonTMsLearnable[gymTM]}
        end
        readAbilitiesIntoUI(pokemon)
        local pokemonImageListener = hoverListeners.pokemonImageListener
        local pokemonImageParams = pokemonImageListener.getOnHoverParams()
        pokemonImageParams.pokemon = pokemon
        pokemonImageListener.setOnHoverParams(pokemonImageParams)
        local heading = "Base Stats (" .. pokemon.bst .. " total)"
        ui.controls.statBarGraph.setDataSet(dataSet)
        ui.controls.statBarGraph.setHeadingText(heading)
        readScrollMovesIntoUI()
        movesScrollBar.setScrollReadingFunction(readScrollMovesIntoUI)
    end

    local function onForwardClick()
        currentIndex = MiscUtils.increaseTableIndex(currentIndex, #sortedPokemonIDs)
        readCurrentIndexIntoUI()
    end

    local function onBackwardClick()
        currentIndex = MiscUtils.decreaseTableIndex(currentIndex, #sortedPokemonIDs)
        readCurrentIndexIntoUI()
    end

    local function onMoveClick()
        viewingMoves = not viewingMoves
        local currentID = sortedPokemonIDs[currentIndex]
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
                        width = constants.MOVES_FRAME_WIDTH - 10,
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
        
        table.insert(
            moveHoverListeners,
            HoverEventListener(
                label,
                onMoveInfoHover,
                {
                    BGColorKey = "Top box background color",
                    BGColorFillKey = "Top box border color",
                    move = nil
                },
                onHoverInfoEnd
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
                {x = 23, y = -1},
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
                {x = 12, y = -1},
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
        end
        movesScrollBar = ScrollBar(ui.frames.moveScrollerFrame, 7, {})
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
        local arrowFrameInfo = FrameFactory.createArrowFrame("LEFT_ARROW_LARGE", ui.frames.navNameFrame, 14, 9)
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
        initAbilitiesUI()
    end

    function self.loadPokemonID(id)
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
    end

    function self.show()
        ui.frames.mainFrame.show()
        if activeHoverFrame ~= nil then
            activeHoverFrame.show()
        end
    end

    initUI()

    return self
end

return PokemonStatScreen

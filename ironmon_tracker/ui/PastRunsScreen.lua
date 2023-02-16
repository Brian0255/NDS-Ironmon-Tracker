local function PastRunsScreen(initialSettings, initialTracker, initialProgram)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/cOMPONENT.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local PokemonSearchKeyboard = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/PokemonSearchKeyboard.lua")
    local settings = initialSettings
    local tracker = initialTracker
    local seedLogger
    local program = initialProgram
    local selectedPokemon = nil
    local currentBadgeFilter = 0
    local currentSortMethod = 0
    local currentPastRunHashes = {}
    local currentIndex = 0
    local pastRuns
    local constants = {
        MAIN_FRAME_HEIGHT = 153,
        FRAME_WIDTH = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
        DESCRIPTION_FRAME_HEIGHT = 42,
        DESCRIPTION_LABEL_HEIGHT = 12,
        NAV_FRAME_HEIGHT = 19,
        SORT_FRAME_HEIGHT = 54,
        BADGE_FRAME_HEIGHT = 74,
        BADGE_BUTTON_FRAME_HEIGHT = 32,
        SORT_BUTTONS_FRAME_HEIGHT = 26,
        SWAP_BUTTON_WIDTH = 30,
        SWAP_BUTTON_HEIGHT = 14
    }
    local ui = {}
    local eventListeners = {}
    local self = {}
    local SELECTED_POKEMON = {
        FAINTED = 0,
        ENEMY = 1
    }

    local function highlightCurrentButtons()
        ui.sortButtons[currentSortMethod + 1].setBackgroundFillColorKey("Top box border color")
        ui.sortButtons[currentSortMethod + 1].setTextColorKey("Positive text color")
        ui.badgeButtons[currentBadgeFilter].setBackgroundFillColorKey("Top box border color")
        ui.badgeButtons[currentBadgeFilter].setTextColorKey("Positive text color")
    end

    local function undoCurrentButtons()
        ui.sortButtons[currentSortMethod + 1].setBackgroundFillColorKey("Top box background color")
        ui.sortButtons[currentSortMethod + 1].setTextColorKey("Top box text color")
        ui.badgeButtons[currentBadgeFilter].setBackgroundFillColorKey("Top box background color")
        ui.badgeButtons[currentBadgeFilter].setTextColorKey("Top box text color")
    end

    local function changeSelectedPokemon()
        if currentIndex == 0 then
            return
        end
        local currentHash = currentPastRunHashes[currentIndex]
        local pastRun = pastRuns[currentHash]
        program.loadPastRunIntoMainScreen(pastRun)
        if selectedPokemon == SELECTED_POKEMON.FAINTED then
            selectedPokemon = SELECTED_POKEMON.ENEMY
            program.setSpecificPokemonAsMainScreen(pastRun.getEnemyPokemon())
        else
            selectedPokemon = SELECTED_POKEMON.FAINTED
            program.setSpecificPokemonAsMainScreen(pastRun.getFaintedPokemon())
        end
        program.drawCurrentScreens()
    end

    local function onGoBackClick()
        program.undoPastRunView()
        program.openScreen(program.UI_SCREENS.TRACKED_INFO_SCREEN)
    end

    local function readCurrentIndex()
        highlightCurrentButtons()
        local currentHash = currentPastRunHashes[currentIndex]
        local pastRun = pastRuns[currentHash]
        --[[
        local description = pastRun.getDescription()
        local lines = DrawingUtils.textToWrappedArray(description, constants.FRAME_WIDTH - 10)
        for i = 1, 3, 1 do
            local line = ""
            if lines[i] then
                line = lines[i]
            end
            ui.descriptionLabels[i].setText(line)
        end --]]
        local indexString = tostring(currentIndex)
        local xOffset = 2
        xOffset = xOffset + ((2 - #indexString) * 6)
        ui.currentIndexLabel.setText(currentIndex .. "/" .. #currentPastRunHashes)
        ui.currentIndexLabel.setTextOffset({x = xOffset, y = -1})
        if pastRun == nil then
            pastRun = seedLogger.getDefaultPastRun()
            ui.currentIndexLabel.setText("0/0")
        end
        program.loadPastRunIntoMainScreen(pastRun)
        program.setSpecificPokemonAsMainScreen(pastRun.getFaintedPokemon())
        program.drawCurrentScreens()
    end

    local function reset()
        currentIndex = 0
        if #currentPastRunHashes > 0 then
            currentIndex = 1
        end
        selectedPokemon = SELECTED_POKEMON.FAINTED
        readCurrentIndex()
    end

    local function onForwardRunClick()
        if currentIndex == 0 then
            return
        end
        currentIndex = MiscUtils.increaseTableIndex(currentIndex, #currentPastRunHashes)
        selectedPokemon = SELECTED_POKEMON.FAINTED
        readCurrentIndex()
    end

    local function onBackwardRunClick()
        if currentIndex == 0 then
            return
        end
        currentIndex = MiscUtils.decreaseTableIndex(currentIndex, #currentPastRunHashes)
        selectedPokemon = SELECTED_POKEMON.FAINTED
        readCurrentIndex()
    end

    local function onSortClick(newSortMethod)
        undoCurrentButtons()
        currentSortMethod = newSortMethod
        currentPastRunHashes = seedLogger.getPastRunHashesSorted(currentSortMethod, currentBadgeFilter)
        reset()
    end

    local function setBadgeFilterAmount(newAmount)
        undoCurrentButtons()
        ui.badgeButtons[currentBadgeFilter].setBackgroundFillColorKey("Top box background color")
        currentBadgeFilter = newAmount
        currentPastRunHashes = seedLogger.getPastRunHashesSorted(currentSortMethod, currentBadgeFilter)
        reset()
    end

    local function initSortButtonEvents()
        local methodOrder = {
            seedLogger.SORT_METHODS.NEWEST,
            seedLogger.SORT_METHODS.OLDEST,
            seedLogger.SORT_METHODS.A_TO_Z
        }
        for i, button in pairs(ui.sortButtons) do
            table.insert(eventListeners, MouseClickEventListener(button, onSortClick, methodOrder[i]))
        end
    end

    local function clearHighlights()
        for _, button in pairs(ui.sortButtons) do
            button.setTextColorKey("Top box text color")
        end
        for _, button in pairs(ui.badgeButtons) do
            button.setTextColorKey("Top box text color")
        end
    end

    function self.updateFromMainFrameSize(mainFrameSize)
        local height = mainFrameSize.height
        local width = mainFrameSize.width
        local centerX = (width - (Graphics.SIZES.MAIN_SCREEN_WIDTH)) / 2
        ui.frames.mainFrame.move({x = Graphics.SIZES.SCREEN_WIDTH, y = height - 1})
        ui.frames.mainFrame.setLayoutPadding({x = centerX + 5, y = 0})
        ui.frames.mainFrame.resize({["width"] = width, height = constants.MAIN_FRAME_HEIGHT - 1})
    end

    local function onConfirmRemoveNoBadgeRuns()
        seedLogger.removeNoBadgeRuns()
        self.initialize(seedLogger)
    end

    local function onRemoveNoBadgeRunsClick()
        FormsUtils.createConfirmDialog(onConfirmRemoveNoBadgeRuns)
    end

    function self.initialize(newSeedLogger)
        undoCurrentButtons()
        seedLogger = newSeedLogger
        currentSortMethod = 0
        currentBadgeFilter = 0
        clearHighlights()
        currentPastRunHashes = seedLogger.getPastRunHashesSorted(currentSortMethod, currentBadgeFilter)
        initSortButtonEvents()
        table.insert(eventListeners, MouseClickEventListener(ui.controls.removeNoBadgeRunsButton, onRemoveNoBadgeRunsClick))
        pastRuns = seedLogger.getPastRuns()
        program.changeMainScreenForPastRunView()
        program.setCurrentScreens({program.UI_SCREENS.MAIN_SCREEN, program.UI_SCREENS.PAST_RUNS_SCREEN})
        reset()
    end

    local function initNavigationUI()
        local navigationFrame =
            Frame(
            Box({x = 0, y = 0}, {width = constants.FRAME_WIDTH, height = constants.NAV_FRAME_HEIGHT}),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 34, y = 0}),
            ui.frames.mainFrame
        )
        local arrowWidth = 18
        local verticalOffset = 1
        local arrowFrameInfo = FrameFactory.createArrowFrame("LEFT_ARROW_LARGE", navigationFrame, arrowWidth, verticalOffset)
        local leftArrowFrame, leftArrowButton = arrowFrameInfo.frame, arrowFrameInfo.button
        leftArrowButton.setBackgroundColorKey("Main background color")
        leftArrowButton.setIconColorKey("Move header text color")
        eventListeners.leftRunClick = MouseClickEventListener(leftArrowButton, onBackwardRunClick)

        ui.currentIndexLabel =
            TextLabel(
            Component(navigationFrame, Box({x = 0, y = 0}, {width = 40, height = 0}, nil, nil, false)),
            TextField(
                "",
                {x = 2, y = -1},
                TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Move header text color", "Main background color")
            )
        )

        arrowFrameInfo = FrameFactory.createArrowFrame("RIGHT_ARROW_LARGE", navigationFrame, arrowWidth, verticalOffset)
        local rightArrowFrame, rightArrowButton = arrowFrameInfo.frame, arrowFrameInfo.button
        rightArrowButton.setBackgroundColorKey("Main background color")
        rightArrowButton.setIconColorKey("Move header text color")
        eventListeners.rightRunClick = MouseClickEventListener(rightArrowButton, onForwardRunClick)

        ui.swapButton =
            TextLabel(
            Component(
                navigationFrame,
                Box(
                    {x = 0, y = 0},
                    {width = constants.SWAP_BUTTON_WIDTH, height = constants.SWAP_BUTTON_HEIGHT},
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Main background color"
                )
            ),
            TextField(
                "Swap",
                {x = 3, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        eventListeners.swap = MouseClickEventListener(ui.swapButton, changeSelectedPokemon)
    end

    local function createBadgeButtons()
        ui.badgeButtons = {}
        for i = 0, 8, 1 do
            ui.badgeButtons[i] =
                TextLabel(
                Component(ui.frames.badgeButtonFrame, Box({x = 0, y = 0}, {width = 11, height = 11})),
                TextField(
                    i,
                    {x = 2, y = 0},
                    TextStyle(
                        Graphics.FONT.DEFAULT_FONT_SIZE,
                        Graphics.FONT.DEFAULT_FONT_FAMILY,
                        "Top box text color",
                        "Top box background color"
                    )
                )
            )
            table.insert(eventListeners, MouseClickEventListener(ui.badgeButtons[i], setBadgeFilterAmount, i))
        end
    end

    local function createGoBackButton()
        local goBackFrame =
            Frame(
            Box({x = 0, y = 0}, {width = 0, height = 0}),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 4, {x = 4, y = 4}),
            ui.frames.badgeFrame
        )
        ui.controls.removeNoBadgeRunsButton =
            TextLabel(
            Component(
                goBackFrame,
                Box(
                    {x = 0, y = 0},
                    {width = 88, height = 14},
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            TextField(
                "Delete 0 Badge Runs",
                {x = 2, y = 1},
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
                goBackFrame,
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

    local function initBadgeUI()
        ui.frames.badgeFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {width = constants.FRAME_WIDTH, height = constants.BADGE_FRAME_HEIGHT},
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 0}),
            ui.frames.mainFrame
        )
        ui.controls.badgeHeading =
            TextLabel(
            Component(
                ui.frames.badgeFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.FRAME_WIDTH,
                        height = 20
                    },
                    "Top box background color",
                    "Top box border color",
                    false
                )
            ),
            TextField(
                "Minimum Badges",
                {x = 28, y = 2},
                TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        ui.frames.badgeButtonFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {width = constants.FRAME_WIDTH, height = constants.BADGE_BUTTON_FRAME_HEIGHT},
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 4, {x = 4, y = 5}),
            ui.frames.badgeFrame
        )
        createBadgeButtons()
        createGoBackButton()
    end

    local function initSortUI()
        local sortFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {width = constants.FRAME_WIDTH, height = constants.SORT_FRAME_HEIGHT},
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 0}),
            ui.frames.mainFrame
        )
        ui.controls.sortHeading =
            TextLabel(
            Component(
                sortFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.FRAME_WIDTH,
                        height = 20
                    },
                    "Top box background color",
                    "Top box border color",
                    false
                )
            ),
            TextField(
                "Sort By",
                {x = 54, y = 2},
                TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        local sortButtonFrame =
            Frame(
            Box({x = 0, y = 0}, {width = constants.FRAME_WIDTH, height = constants.SORT_BUTTONS_FRAME_HEIGHT}),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 5, {x = 5, y = 5}),
            sortFrame
        )
        local buttonNames = {
            "Newest",
            "Oldest",
            "A - Z"
        }
        local widths = {
            37,
            33,
            24
        }
        ui.sortButtons = {}
        for i, buttonName in pairs(buttonNames) do
            ui.sortButtons[i] =
                TextLabel(
                Component(sortButtonFrame, Box({x = 0, y = 0}, {width = widths[i], height = 16})),
                TextField(
                    buttonName,
                    {x = 3, y = 2},
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

    --[[
    local function initDescriptionUI()
        local descriptionFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {width = constants.FRAME_WIDTH, height = constants.DESCRIPTION_FRAME_HEIGHT},
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 3}),
            ui.frames.mainFrame
        )
        ui.descriptionLabels = {}
        for i = 1, 3, 1 do
            ui.descriptionLabels[i] =
                TextLabel(
                Component(
                    descriptionFrame,
                    Box({x = 0, y = 0}, {width = 0, height = constants.DESCRIPTION_LABEL_HEIGHT}, nil, nil, false)
                ),
                TextField(
                    "",
                    {x = 5, y = 0},
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
    --]]
    local function initUI()
        ui.controls = {}
        ui.frames = {}
        ui.frames.mainFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = Graphics.SIZES.MAIN_SCREEN_HEIGHT - 1},
                {width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = constants.MAIN_FRAME_HEIGHT},
                "Main background color",
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = Graphics.SIZES.BORDER_MARGIN, y = 1}),
            nil
        )
        initNavigationUI()
        initSortUI()
        initBadgeUI()
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

return PastRunsScreen

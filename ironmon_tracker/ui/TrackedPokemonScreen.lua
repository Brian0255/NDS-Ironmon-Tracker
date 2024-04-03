local function TrackedPokemonScreen(initialSettings, initialTracker, initialProgram)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local SearchKeyboard = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/SearchKeyboard.lua")
    local settings = initialSettings
    local pokemonSearchKeyboard
    local maxSearchResultWidth = 118
    local tracker = initialTracker
    local program = initialProgram
    local matchTextLabels = {}
    local sortedTrackedIDs = {}
    local totalIDs
    local currentIndex = 0
    local constants = {
        TOP_FRAME_HEIGHT = 25,
        BOTTOM_FRAME_HEIGHT = 168,
        NAV_FRAME_HEIGHT = 23,
        SEARCH_FRAME_HEIGHT = 97,
        SEARCH_BAR_HEIGHT = 14,
        MAIN_TEXT_HEADING_HEIGHT = 18,
        DEFAULT_TEXT_HEADING_HEIGHT = 14,
        KEYBOARD_FRAME_HEIGHT = 50,
        KEYBOARD_BUTTON_WIDTH = 13,
        POKEMON_BUTTON_HEIGHT = 13,
        SPACEBAR_WIDTH = 98,
        SEARCH_BAR_WIDTH = 68,
        CLEAR_BUTTON_WIDTH = 30,
        BACKSPACE_BUTTON_WIDTH = 18,
        NAV_BUTTON_WIDTH = 12,
        NAV_HEADING_WIDTH = 70
    }
    local ui = {}
    local eventListeners = {}
    local matchEventListeners = {}
    local self = {}

    local function readCurrentIndexIntoMainScreen()
        local id = sortedTrackedIDs[currentIndex]
        if id == nil then
            id = 0
        end
        local indexString = tostring(currentIndex)
        local text = indexString .. "/" .. #sortedTrackedIDs
        local xOffset = 7
        xOffset = xOffset + ((2 - #indexString) * 6)
        ui.controls.currentIndexLabel.setText(text)
        ui.controls.currentIndexLabel.setTextOffset({x = xOffset, y = -1})
        program.putTrackedPokemonIntoView(id)
    end

    local function setIndexFromID(newID)
        for i, id in pairs(sortedTrackedIDs) do
            if id == newID then
                currentIndex = i
                break
            end
        end
        program.drawCurrentScreens()
    end

    local function clearMatches()
        for _, label in pairs(matchTextLabels) do
            ui.frames.resultFrame.removeControl(label)
        end
        matchTextLabels = {}
    end

    local function createLabelsFromMatches(matches)
        matchEventListeners = {}
        matchTextLabels =
            UIUtils.createKeyboardLabelsFromMatches(
            matches,
            PokemonData.POKEMON,
            ui.frames.resultFrame,
            maxSearchResultWidth,
            constants.POKEMON_BUTTON_HEIGHT
        )
        for index, label in pairs(matchTextLabels) do
            table.insert(matchEventListeners, MouseClickEventListener(label, setIndexFromID, matches[index]))
        end
        program.drawCurrentScreens()
    end

    local function onForwardClick()
        if currentIndex == 0 then
            return
        end
        currentIndex = MiscUtils.increaseTableIndex(currentIndex, #sortedTrackedIDs)
        program.drawCurrentScreens()
    end

    local function onBackwardClick()
        if currentIndex == 0 then
            return
        end
        currentIndex = MiscUtils.decreaseTableIndex(currentIndex, #sortedTrackedIDs)
        program.drawCurrentScreens()
    end

    local function onGoBackClick()
        client.SetGameExtraPadding(0, 0, Graphics.SIZES.MAIN_SCREEN_PADDING, 0)
        program.undoTrackedPokemonView()
        program.openScreen(program.UI_SCREENS.TRACKED_INFO_SCREEN)
    end

    local function initSearchFrame()
        ui.controls.searchHeading =
            TextLabel(
            Component(
                ui.frames.mainBottomFrame,
                Box(
                    {x = 5, y = 5},
                    {
                        width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                        height = constants.MAIN_TEXT_HEADING_HEIGHT
                    },
                    "Top box background color",
                    "Top box border color",
                    false
                )
            ),
            TextField(
                "Search",
                {x = 50, y = 1},
                TextStyle(13, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        ui.frames.searchFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.SEARCH_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 5, {x = 0, y = Graphics.SIZES.BORDER_MARGIN}),
            ui.frames.mainBottomFrame
        )
    end

    local function initNavigationFrame()
        ui.frames.navigationFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = constants.NAV_FRAME_HEIGHT}
                --"Top box background color",
                --"Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 3, {x = 28, y = 5}),
            ui.frames.mainBottomFrame
        )
        local arrowWidth = 16
        local verticalOffset = 1
        local arrowFrameInfo =
            FrameFactory.createArrowFrame("LEFT_ARROW_LARGE", ui.frames.navigationFrame, arrowWidth, verticalOffset)
        local leftArrowFrame, leftArrowButton = arrowFrameInfo.frame, arrowFrameInfo.button
        leftArrowButton.setBackgroundColorKey("Main background color")
        leftArrowButton.setIconColorKey("Move header text color")
        eventListeners.leftRunClick = MouseClickEventListener(leftArrowButton, onBackwardClick)

        ui.controls.currentIndexLabel =
            TextLabel(
            Component(ui.frames.navigationFrame, Box({x = 0, y = 0}, {width = 48, height = 0}, nil, nil, false)),
            TextField(
                "",
                {x = 2, y = -1},
                TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Move header text color", "Main background color")
            )
        )

        arrowFrameInfo =
            FrameFactory.createArrowFrame("RIGHT_ARROW_LARGE", ui.frames.navigationFrame, arrowWidth, verticalOffset)
        local rightArrowFrame, rightArrowButton = arrowFrameInfo.frame, arrowFrameInfo.button
        rightArrowButton.setBackgroundColorKey("Main background color")
        rightArrowButton.setIconColorKey("Move header text color")
        eventListeners.rightRunClick = MouseClickEventListener(rightArrowButton, onForwardClick)
    end

    local function initUI()
        ui.controls = {}
        ui.frames = {}

        ui.frames.mainBottomFrame =
            Frame(
            Box(
                {
                    x = Graphics.SIZES.SCREEN_WIDTH,
                    y = Graphics.SIZES.MAIN_SCREEN_HEIGHT - 6
                },
                {width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = constants.BOTTOM_FRAME_HEIGHT},
                "Main background color",
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = Graphics.SIZES.BORDER_MARGIN, y = 1}),
            nil
        )
        initNavigationFrame()
        initSearchFrame()
        ui.frames.resultFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = 0,
                    height = constants.POKEMON_BUTTON_HEIGHT
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 3, {x = 3, y = 0}),
            ui.frames.searchFrame
        )

        pokemonSearchKeyboard =
            SearchKeyboard(sortedTrackedIDs, ui.frames.searchFrame, createLabelsFromMatches, clearMatches)

        ui.frames.goBackFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = 24
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 96, y = 5}),
            ui.frames.searchFrame
        )
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
        table.insert(eventListeners, MouseClickEventListener(ui.controls.goForwardButton, onForwardClick))
        table.insert(eventListeners, MouseClickEventListener(ui.controls.goBackwardButton, onBackwardClick))
        table.insert(eventListeners, MouseClickEventListener(ui.controls.goBackButton, onGoBackClick))
    end

    function self.runEventListeners()
        pokemonSearchKeyboard.runEventListeners()
        for _, eventListener in pairs(eventListeners) do
            eventListener.listen()
        end
        for _, eventListener in pairs(matchEventListeners) do
            eventListener.listen()
        end
    end

    function self.initialize()
        sortedTrackedIDs = tracker.getSortedTrackedIDs()
        totalIDs = #sortedTrackedIDs
        if totalIDs ~= 0 then
            currentIndex = 1
            readCurrentIndexIntoMainScreen()
        end
        pokemonSearchKeyboard.clearKeyboard()
        pokemonSearchKeyboard.updateItemSet(sortedTrackedIDs)
        pokemonSearchKeyboard.setDrawFunction(program.drawCurrentScreens)
        pokemonSearchKeyboard.updateSearch()
        program.drawCurrentScreens()
    end

    function self.show()
        readCurrentIndexIntoMainScreen()
        ui.frames.mainBottomFrame.show()
    end

    initUI()
    return self
end

return TrackedPokemonScreen

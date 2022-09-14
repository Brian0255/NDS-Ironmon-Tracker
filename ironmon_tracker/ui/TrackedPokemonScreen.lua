local function TrackedPokemonScreen(initialSettings, initialTracker, initialProgram)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/cOMPONENT.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local Icon = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Icon.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local settings = initialSettings
    local max = 18
    local maxSearchResultWidth = 118
    local tracker = initialTracker
    local program = initialProgram
    local currentSearchText = ""
    local matchTextLabels = {}
    local sortedTrackedIDs
    local totalIDs
    local currentIndex = -1
    local constants = {
        TOP_FRAME_HEIGHT = 41,
        BOTTOM_FRAME_HEIGHT = 145,
        NAV_FRAME_HEIGHT = 21,
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

    local function initEventListeners()
        --eventListeners.goBackClickListener = MouseClickEventListener(ui.controls.goBackButton, onGoBackClick)
    end

    local function readCurrentIndexIntoMainScreen()
        local id = sortedTrackedIDs[currentIndex]
        if id == nil then
            id = 0
        end
        program.putTrackedPokemonIntoView(id)
    end

    local function setIndexFromID(newID)
        for i, id in pairs(sortedTrackedIDs) do
            if id == newID then
                currentIndex = i
                break
            end
        end
        readCurrentIndexIntoMainScreen()
        program.drawCurrentScreens()
    end

    local function clearMatches()
        for _, label in pairs(matchTextLabels) do
            ui.frames.resultFrame.removeControl(label)
        end
        matchTextLabels = {}
    end

    local function createMatchTextLabel(matchID)
        local name = PokemonData.POKEMON[matchID + 1].name
        local labelWidth = DrawingUtils.calculateWordPixelLength(name) + 5
        local matchLabel =
            TextLabel(
            Component(
                ui.frames.resultFrame,
                Box(
                    {x = 5, y = 5},
                    {
                        width = labelWidth,
                        height = constants.POKEMON_BUTTON_HEIGHT
                    },
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            TextField(
                name,
                {x = 1, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        table.insert(matchTextLabels, matchLabel)
        return matchLabel
    end

    local function createLabelsFromMatches(matches)
        matchEventListeners = {}
        local currentResultWidth = 0
        for _, match in pairs(matches) do
            local name = PokemonData.POKEMON[match + 1].name
            local labelWidth = DrawingUtils.calculateWordPixelLength(name) + 5
            currentResultWidth = currentResultWidth + labelWidth + 1 --layout spacing
            if currentResultWidth > maxSearchResultWidth then
                table.insert(
                    matchTextLabels,
                    TextLabel(
                        Component(
                            ui.frames.resultFrame,
                            Box(
                                {x = 5, y = 5},
                                {
                                    width = 20,
                                    height = constants.POKEMON_BUTTON_HEIGHT
                                },
                                nil,
                                nil
                            )
                        ),
                        TextField(
                            ". . .",
                            {x = -1, y = 4},
                            TextStyle(
                                Graphics.FONT.DEFAULT_FONT_SIZE,
                                Graphics.FONT.DEFAULT_FONT_FAMILY,
                                "Top box text color",
                                "Top box background color"
                            )
                        )
                    )
                )
                break
            else
                local label = createMatchTextLabel(match)
                table.insert(matchEventListeners, MouseClickEventListener(label, setIndexFromID, match))
            end
        end
    end

    local function onForwardClick()
        currentIndex = (currentIndex % totalIDs) + 1
        readCurrentIndexIntoMainScreen()
        program.drawCurrentScreens()
    end

    local function onBackwardClick()
        currentIndex = ((currentIndex + totalIDs - 2) % totalIDs) + 1
        readCurrentIndexIntoMainScreen()
        program.drawCurrentScreens()
    end

    local function onGoBackClick()
        client.SetGameExtraPadding(0, 0, Graphics.SIZES.MAIN_SCREEN_PADDING, 0)
        program.undoTrackedPokemonView()
        program.setCurrentScreens({program.UI_SCREENS.MAIN_OPTIONS_SCREEN})
        program.drawCurrentScreens()
    end

    local function getPossibleMatches()
        local matches = {}
        for _, id in pairs(sortedTrackedIDs) do
            local name = PokemonData.POKEMON[id + 1].name:lower()
            if name:sub(1, #currentSearchText) == currentSearchText:lower() then
                table.insert(matches, id)
            end
        end
        return matches
    end

    local function updateSearchBar()
        clearMatches()
        ui.controls.searchBarLabel.setText(currentSearchText)
        if currentSearchText ~= "" then
            local matches = getPossibleMatches()
            createLabelsFromMatches(matches)
        end
        program.drawCurrentScreens()
    end

    local function onBackspace()
        if currentSearchText ~= "" then
            currentSearchText = currentSearchText:sub(1, -2)
            updateSearchBar()
        end
    end

    local function onClear()
        currentSearchText = ""
        updateSearchBar()
    end

    local function onLetterPress(letter)
        currentSearchText = currentSearchText .. letter:lower()
        if #currentSearchText > max then
            onBackspace()
        else
            updateSearchBar()
        end
    end

    local function initUI()
        ui.controls = {}
        ui.frames = {}
        ui.frames.mainTopFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = constants.TOP_FRAME_HEIGHT},
                "Main background color",
                nil
            ),
            Layout(
                Graphics.ALIGNMENT_TYPE.VERTICAL,
                0,
                {x = Graphics.SIZES.BORDER_MARGIN, y = Graphics.SIZES.BORDER_MARGIN}
            ),
            nil
        )
        ui.controls.topHeading =
            TextLabel(
            Component(
                ui.frames.mainTopFrame,
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
                "Tracked Pok\233mon",
                {x = 20, y = 1},
                TextStyle(13, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        ui.frames.navigationFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = constants.NAV_FRAME_HEIGHT}
                --"Top box background color",
                --"Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 3, {x = 56, y = 5}),
            ui.frames.mainTopFrame
        )
        ui.controls.goBackwardButton =
            TextLabel(
            Component(
                ui.frames.navigationFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.NAV_BUTTON_WIDTH,
                        height = constants.NAV_BUTTON_WIDTH
                    },
                    "Top box background color",
                    "Top box border color",
                    false
                )
            ),
            TextField(
                "<",
                {x = 1, y = -1},
                TextStyle(10, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        ui.controls.goForwardButton =
            TextLabel(
            Component(
                ui.frames.navigationFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.NAV_BUTTON_WIDTH,
                        height = constants.NAV_BUTTON_WIDTH
                    },
                    "Top box background color",
                    "Top box border color",
                    false
                )
            ),
            TextField(
                ">",
                {x = 2, y = -1},
                TextStyle(10, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        ui.frames.mainBottomFrame =
            Frame(
            Box(
                {
                    x = Graphics.SIZES.SCREEN_WIDTH,
                    y = Graphics.SIZES.MAIN_SCREEN_HEIGHT + constants.TOP_FRAME_HEIGHT - 2
                },
                {width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = constants.BOTTOM_FRAME_HEIGHT},
                "Main background color",
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = Graphics.SIZES.BORDER_MARGIN, y = 1}),
            nil
        )
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
                {x = 48, y = 1},
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
        ui.frames.searchBarClearFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {
                    width = 0,
                    height = constants.SEARCH_BAR_HEIGHT
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 5, {x = 7, y = 0}),
            ui.frames.searchFrame
        )
        ui.controls.searchBarLabel =
            TextLabel(
            Component(
                ui.frames.searchBarClearFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.SEARCH_BAR_WIDTH,
                        height = constants.SEARCH_BAR_HEIGHT
                    },
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            TextField(
                "",
                {x = 2, y = 2},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls.backspaceButton =
            Icon(
            Component(
                ui.frames.searchBarClearFrame,
                Box(
                    {x = 0, y = 0},
                    {width = 18, height = constants.SEARCH_BAR_HEIGHT},
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            "BACKSPACE",
            {x = 5, y = 4}
        )
        ui.controls.clearButton =
            TextLabel(
            Component(
                ui.frames.searchBarClearFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.CLEAR_BUTTON_WIDTH,
                        height = constants.SEARCH_BAR_HEIGHT
                    },
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            TextField(
                "Clear",
                {x = 4, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
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
        ui.frames.keyboardFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = 0,
                    height = constants.KEYBOARD_FRAME_HEIGHT
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 0}),
            ui.frames.searchFrame
        )
        local keyboardRowFrames = {}
        local keyboardRowSpacings = {6, 9, 15, 21}
        for i = 1, 4, 1 do
            ui.frames["keyboardFrame" .. i] =
                Frame(
                Box(
                    {x = 0, y = 0},
                    {
                        width = 0,
                        height = constants.KEYBOARD_BUTTON_WIDTH
                    },
                    nil,
                    nil
                ),
                Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = keyboardRowSpacings[i], y = 0}),
                ui.frames.keyboardFrame
            )
            table.insert(keyboardRowFrames, ui.frames["keyboardFrame" .. i])
        end

        local letterRows = {
            {"Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"},
            {"A", "S", "D", "F", "G", "H", "J", "K", "L"},
            {"Z", "X", "C", "V", "B", "N", "M","-"}
        }
        for i, letterRow in pairs(letterRows) do
            for _, letter in pairs(letterRow) do
                local displayedLetter = letter
                local xOffset = 2
                if letter == "-" then
                    displayedLetter = "--"
                    xOffset = 3
                end
                ui.controls[letter] =
                    TextLabel(
                    Component(
                        keyboardRowFrames[i],
                        Box(
                            {x = 0, y = 0},
                            {
                                width = constants.KEYBOARD_BUTTON_WIDTH,
                                height = constants.KEYBOARD_BUTTON_WIDTH
                            },
                            "Top box background color",
                            "Top box border color",
                            false
                        )
                    ),
                    TextField(
                        displayedLetter,
                        {x = xOffset, y = 1},
                        TextStyle(
                            9,
                            Graphics.FONT.DEFAULT_FONT_FAMILY,
                            "Top box text color",
                            "Top box background color"
                        )
                    )
                )
                table.insert(eventListeners, MouseClickEventListener(ui.controls[letter], onLetterPress, letter))
            end
        end
        ui.controls.spacebarButton =
            TextLabel(
            Component(
                keyboardRowFrames[4],
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.SPACEBAR_WIDTH,
                        height = constants.KEYBOARD_BUTTON_WIDTH - 2
                    },
                    "Top box background color",
                    "Top box border color",
                    false
                )
            ),
            TextField(
                "---",
                {x = 44, y = -3},
                TextStyle(9, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
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
        table.insert(eventListeners, MouseClickEventListener(ui.controls.spacebarButton, onLetterPress, " "))
        table.insert(eventListeners, MouseClickEventListener(ui.controls.backspaceButton, onBackspace))
        table.insert(eventListeners, MouseClickEventListener(ui.controls.goForwardButton, onForwardClick))
        table.insert(eventListeners, MouseClickEventListener(ui.controls.goBackwardButton, onBackwardClick))
        table.insert(eventListeners, MouseClickEventListener(ui.controls.clearButton, onClear))
        table.insert(eventListeners, MouseClickEventListener(ui.controls.goBackButton, onGoBackClick))
    end

    function self.runEventListeners()
        for _, eventListener in pairs(eventListeners) do
            eventListener.listen()
        end
        for _, eventListener in pairs(matchEventListeners) do
            eventListener.listen()
        end
    end

    function self.initialize()
        currentSearchText = ""
        sortedTrackedIDs = tracker.getSortedTrackedIDs()
        totalIDs = #sortedTrackedIDs
        if totalIDs ~= 0 then
            currentIndex = 1
            readCurrentIndexIntoMainScreen()
        end
        updateSearchBar()
    end

    function self.show()
        ui.frames.mainTopFrame.show()
        ui.frames.mainBottomFrame.show()
        readCurrentIndexIntoMainScreen()
    end

    initUI()
    return self
end

return TrackedPokemonScreen

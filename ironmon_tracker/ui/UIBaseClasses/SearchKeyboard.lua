local function SearchKeyboard(
    initialItemSet,
    initialParentFrame,
    initialResultDrawingFunction,
    initialResultClearingFunction,
    initialDataGroup)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local Icon = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Icon.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local self = {}
    local itemSet = initialItemSet
    local parentFrame = initialParentFrame
    local drawFunction
    local resultDrawingFunction = initialResultDrawingFunction
    local resultClearingFunction = initialResultClearingFunction
    local dataGroup = initialDataGroup or PokemonData.POKEMON
    local currentSearchText = ""
    local matches = {}
    local ui = {}
    local eventListeners = {}
    local max = 18
    local constants = {
        BOTTOM_FRAME_HEIGHT = 168,
        NAV_FRAME_HEIGHT = 23,
        SEARCH_FRAME_HEIGHT = 97,
        SEARCH_BAR_HEIGHT = 14,
        MAIN_TEXT_HEADING_HEIGHT = 18,
        KEYBOARD_FRAME_HEIGHT = 50,
        KEYBOARD_BUTTON_WIDTH = 13,
        SPACEBAR_WIDTH = 98,
        SEARCH_BAR_WIDTH = 68,
        CLEAR_BUTTON_WIDTH = 30,
        BACKSPACE_BUTTON_WIDTH = 18
    }

    function self.getMatches()
        return matches
    end

    function self.updateDataGroup(newDataGroup)
        dataGroup = newDataGroup
    end

    function self.updateItemSet(newItemSet)
        itemSet = newItemSet
    end

    function self.setDrawFunction(newDrawFunction)
        drawFunction = newDrawFunction
    end

    local function getPossibleMatches()
        matches = {}
        local currentIndex = 1
        for _, id in pairs(itemSet) do
            if dataGroup[id+1] then
                local name = dataGroup[id + 1].name:lower()
                if name:sub(1, #currentSearchText) == currentSearchText:lower() then
                    matches[currentIndex] = id
                    currentIndex = currentIndex + 1
                end
            end
        end
    end

    function self.updateSearch()
        resultClearingFunction()
        ui.controls.searchBarLabel.setText(currentSearchText)
        getPossibleMatches()
        resultDrawingFunction(matches)
    end

    local function onBackspace()
        if currentSearchText ~= "" then
            currentSearchText = currentSearchText:sub(1, -2)
            self.updateSearch()
        end
    end

    local function onClear()
        currentSearchText = ""
        self.updateSearch()
    end

    function self.clearKeyboard()
        onClear()
    end

    local function onLetterPress(letter)
        currentSearchText = currentSearchText .. letter:lower()
        if #currentSearchText > max then
            onBackspace()
        else
            self.updateSearch()
        end
    end

    local function createKeyboardLetters()
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
            parentFrame
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
            {"Z", "X", "C", "V", "B", "N", "M", "-"}
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
                        TextStyle(9, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
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
        table.insert(eventListeners, MouseClickEventListener(ui.controls.spacebarButton, onLetterPress, " "))
    end

    local function createSearchBarClearFrame()
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
            parentFrame
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
        table.insert(eventListeners, MouseClickEventListener(ui.controls.backspaceButton, onBackspace))
        table.insert(eventListeners, MouseClickEventListener(ui.controls.clearButton, onClear))
    end

    local function initUI()
        ui.frames = {}
        ui.controls = {}
        createSearchBarClearFrame()
        createKeyboardLetters()
    end

    function self.runEventListeners()
        for _, eventListener in pairs(eventListeners) do
            eventListener.listen()
        end
    end

    initUI()
    return self
end

return SearchKeyboard

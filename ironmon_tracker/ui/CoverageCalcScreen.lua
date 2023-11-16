local function CoverageCalcScreen(initialSettings, initialTracker, initialProgram)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local SettingToggleButton = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/SettingToggleButton.lua")
    local ImageLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageLabel.lua")
    local ImageField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageField.lua")
    local ScrollBar = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ScrollBar.lua")
    local settings = initialSettings
    local tracker = initialTracker
    local program = initialProgram
    local constants = {
        MAIN_FRAME_HEIGHT = 341,
        BUTTON_SIZE = 10
    }
    local ui = {}
    local eventListeners = {}
    local self = {}
    local moveSelectors = {}
    local selectedMoves = {}
    local moveTypeToSelector = {}
    local effectivenessTable = {}
    local effectivenessSelectorFrames = {}
    local pokemonListRows = {}
    local pokemonScroller
    local currentEffectivenessKey = nil

    local function onGoBackClick()
        program.openScreen(program.UI_SCREENS.EXTRAS_SCREEN)
    end

    local function clearEffectivenessTable()
        effectivenessTable = {
            [0.0] = {
                ids = {},
                total = 0
            },
            [0.25] = {
                ids = {},
                total = 0
            },
            [0.5] = {
                ids = {},
                total = 0
            },
            [1.0] = {
                ids = {},
                total = 0
            },
            [2.0] = {
                ids = {},
                total = 0
            },
            [4.0] = {
                ids = {},
                total = 0
            }
        }
    end

    local function readTotals()
        for key, data in pairs(effectivenessTable) do
            local matchingFrame = effectivenessSelectorFrames[key]
            local total = data.total
            local text = "---"
            local xOffset = 6
            if total > 0 then
                text = tostring(total)
                local width = matchingFrame.frame.getSize().width
                xOffset = (width - DrawingUtils.calculateWordPixelLength(text)) / 2 - 1
            end
            matchingFrame.numberLabel.setText(text)
            matchingFrame.numberLabel.setTextOffset({x = xOffset, y = 0})
        end
    end

    local function getMoveEffectivenessAgainstPokemon(moveType, pokemonData)
        local effectiveness = 1.0
        for _, defenseType in pairs(pokemonData.type) do
            if defenseType ~= PokemonData.POKEMON_TYPES.EMPTY and MoveData.EFFECTIVE_DATA[moveType][defenseType] then
                effectiveness = effectiveness * MoveData.EFFECTIVE_DATA[moveType][defenseType]
            end
        end
        if pokemonData.name == "Shedinja" and effectiveness < 2.0 then
            return 0.0
        end
        return effectiveness
    end

    local function calculateMovesAgainstPokemon(selectedMoveTypes, pokemonID)
        local max = 0.0
        for _, moveType in pairs(selectedMoveTypes) do
            local pokemonData = PokemonData.POKEMON[pokemonID]
            local effectiveness = getMoveEffectivenessAgainstPokemon(moveType, pokemonData)
            if effectiveness > max then
                max = effectiveness
            end
        end
        table.insert(effectivenessTable[max].ids, pokemonID)
        effectivenessTable[max].total = effectivenessTable[max].total + 1
    end

    local function calculateMovesAgainstAllPokemon(selectedMoveTypes)
        for index, pokemon in pairs(PokemonData.POKEMON) do
            local valid = index > 1
            if settings.coverageCalc.FULLY_EVOLVED_ONLY then
                valid = valid and (pokemon.evolution == PokemonData.EVOLUTION_TYPES.NONE)
            end
            if PokemonData.ALTERNATE_FORMS[pokemon.name] and PokemonData.ALTERNATE_FORMS[pokemon.name].cosmetic == true then
                valid = false
            end
            if valid then
                calculateMovesAgainstPokemon(selectedMoveTypes, index)
            end
        end
        for _, data in pairs(effectivenessTable) do
            table.sort(
                data.ids,
                function(id1, id2)
                    return PokemonData.POKEMON[id1].bst > PokemonData.POKEMON[id2].bst
                end
            )
        end
    end

    local function readCurrentEffectivenessSelection()
        local items = pokemonScroller.getViewedItems()
        for index = 1, 10, 1 do
            local row = pokemonListRows[index]
            local pathPrefix = "ironmon_tracker/images/types/"
            local name = ""
            local type1Path = ""
            local type2Path = ""
            local type1Border = nil
            local type2Border = nil
            if items[index] then
                local id = items[index]
                local data = PokemonData.POKEMON[id]
                name = data.name
                local types = data.type
                if items[index] then
                    if types[2] == PokemonData.POKEMON_TYPES.EMPTY then
                        type2Path = pathPrefix .. types[1] .. ".png"
                        type2Border = "Top box border color"
                    else
                        type1Path = pathPrefix .. types[1] .. ".png"
                        type1Border = "Top box border color"
                        type2Path = pathPrefix .. types[2] .. ".png"
                        type2Border = "Top box border color"
                    end
                end
            end
            row.nameLabel.setText(name)
            row.typeLabels[1].setPath(type1Path)
            row.typeLabels[1].setBackgroundFillColorKey(type1Border)
            row.typeLabels[2].setBackgroundFillColorKey(type2Border)
            row.typeLabels[2].setPath(type2Path)
        end
        program.drawCurrentScreens()
    end

    local function calculateCurrentEffectiveness()
        clearEffectivenessTable()
        local selectedMoveTypes = {}
        for selectedMove, selected in pairs(selectedMoves) do
            if selected then
                table.insert(selectedMoveTypes, selectedMove)
            end
        end
        if #selectedMoveTypes > 0 then
            calculateMovesAgainstAllPokemon(selectedMoveTypes)
        end
        pokemonScroller.setItems(effectivenessTable[currentEffectivenessKey].ids)
        readCurrentEffectivenessSelection()
        readTotals()
        program.drawCurrentScreens()
    end

    local function onFullyEvolvedClick(button)
        button.onClick()
        calculateCurrentEffectiveness()
    end

    local function toggleBrightness(moveSelector, override, calculateNewCoverage)
        if calculateNewCoverage == nil then
            calculateNewCoverage = true
        end
        local moveType = moveSelector.moveType
        local on = selectedMoves[moveType] or false
        on = not on
        if override ~= nil then
            on = override
        end
        local pathEnding = "_empty.png"
        local borderColorKey = nil
        selectedMoves[moveType] = on
        if on then
            pathEnding = ".png"
            borderColorKey = "Top box border color"
        end
        moveSelector.backdrop.setVisibility(not on)
        moveSelector.imageDarkener.setVisibility(not on)
        moveSelector.image.setPath("ironmon_tracker/images/types/" .. moveType .. pathEnding)
        moveSelector.image.setBackgroundFillColorKey(borderColorKey)
        if calculateNewCoverage then
            calculateCurrentEffectiveness()
        end
    end

    local function onMoveSelectorClick(index)
        local moveSelector = moveSelectors[index]
        toggleBrightness(moveSelector)
    end

    local function initMoveSelectors()
        ui.frames.moveSelectorFrame =
            Frame(
            Box({x = 0, y = 0}, {width = 0, height = 86}),
            Layout(Graphics.ALIGNMENT_TYPE.GRID, 3, {x = 0, y = 3}, 4),
            ui.frames.mainInnerFrame
        )
        for index, moveType in pairs(PokemonData.FULL_TYPE_LIST) do
            local frame = Frame(Box({x = 0, y = 0}, {width = 31, height = 13}), nil, ui.frames.moveSelectorFrame)
            moveSelectors[index] = {}
            moveSelectors[index].moveType = moveType
            moveSelectors[index].backdrop =
                TextLabel(
                Component(frame, Box({x = 0, y = 0}, {width = 31, height = 13}, "Black", "Black", nil, nil, nil, nil, 0x20)),
                TextField("", {x = 0, y = 0}, TextStyle(Graphics.FONT.DEFAULT_FONT_SIZE, Graphics.FONT.DEFAULT_FONT_FAMILY))
            )
            moveSelectors[index].image =
                ImageLabel(
                Component(frame, Box({x = 0, y = 0}, {width = 31, height = 13})),
                ImageField("ironmon_tracker/images/types/" .. moveType .. "_empty.png", {x = 1, y = 1}, nil)
            )

            moveSelectors[index].imageDarkener =
                TextLabel(
                Component(frame, Box({x = 0, y = 0}, {width = 31, height = 13}, "Black", nil, nil, nil, nil, nil, 0x08)),
                TextField("", {x = 0, y = 0}, TextStyle(Graphics.FONT.DEFAULT_FONT_SIZE, Graphics.FONT.DEFAULT_FONT_FAMILY))
            )
            table.insert(eventListeners, MouseClickEventListener(moveSelectors[index].image, onMoveSelectorClick, index))
            moveTypeToSelector[moveType] = moveSelectors[index]
        end
        local spacerFrame = Frame(Box({x = 0, y = 0}, {width = 0, height = 2}), nil, ui.frames.mainInnerFrame)
        local spacer =
            TextLabel(
            Component(
                spacerFrame,
                Box(
                    {x = 1, y = 0},
                    {width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 18, height = 0},
                    "Top box border color",
                    "Top box border color"
                )
            ),
            TextField("", {x = 0, y = 0}, TextStyle(Graphics.FONT.DEFAULT_FONT_SIZE, Graphics.FONT.DEFAULT_FONT_FAMILY))
        )
    end

    local function initFullyEvolvedButton()
        local frame =
            Frame(
            Box({x = 0, y = 0}, {width = 0, height = 18}),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 2, {x = 3, y = 5}),
            ui.frames.mainInnerFrame
        )
        local toggle =
            SettingToggleButton(
            Component(
                frame,
                Box(
                    {x = 0, y = 0},
                    {width = constants.BUTTON_SIZE, height = constants.BUTTON_SIZE},
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            settings.coverageCalc,
            "FULLY_EVOLVED_ONLY",
            nil,
            false,
            true,
            program.saveSettings
        )
        TextLabel(
            Component(frame, Box({x = 0, y = 0}, {width = 0, height = 0}, nil, nil, false)),
            TextField(
                "Fully evolved only",
                {x = 2, y = 0},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        table.insert(eventListeners, MouseClickEventListener(toggle, onFullyEvolvedClick, toggle))
    end

    local function turnOffCurrentFrame()
        local currentEffectivenessFrame = effectivenessSelectorFrames[currentEffectivenessKey]
        if currentEffectivenessFrame == nil then
            return
        end
        local frameInfo = currentEffectivenessFrame
        local frame, effectivenessLabel, numberLabel = frameInfo.frame, frameInfo.effectivenessLabel, frameInfo.numberLabel
        frame.setBackgroundFillColorKey()
        effectivenessLabel.setTextColorKey("Top box text color")
        numberLabel.setTextColorKey("Top box text color")
    end

    local function onEffectivenessFrameClick(frameInfo)
        turnOffCurrentFrame()
        local frame, effectivenessLabel, numberLabel = frameInfo.frame, frameInfo.effectivenessLabel, frameInfo.numberLabel
        frame.setBackgroundFillColorKey("Top box border color")
        effectivenessLabel.setTextColorKey("Positive text color")
        numberLabel.setTextColorKey("Positive text color")
        currentEffectivenessKey = frameInfo.tableKey
        pokemonScroller.setItems(effectivenessTable[currentEffectivenessKey].ids)
        readCurrentEffectivenessSelection()
        program.drawCurrentScreens()
    end

    local function createEffectivenessFrame(tableKey, labelText)
        local frameInfo = {
            ["tableKey"] = tableKey
        }
        local frameWidth = 22
        frameInfo.frame =
            Frame(
            Box({x = 0, y = 0}, {width = frameWidth, height = 30}),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 2}),
            ui.frames.effectivenessSelectorFrame
        )
        local textOffset = ((frameWidth - DrawingUtils.calculateWordPixelLength(labelText)) / 2)
        frameInfo.effectivenessLabel =
            TextLabel(
            Component(frameInfo.frame, Box({x = 0, y = 0}, {width = 0, height = 14})),
            TextField(
                labelText,
                {x = textOffset, y = 0},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        frameInfo.numberLabel =
            TextLabel(
            Component(frameInfo.frame, Box({x = 0, y = 0}, {width = 0, height = 20})),
            TextField(
                "---",
                {x = 6, y = 0},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        effectivenessSelectorFrames[tableKey] = frameInfo
        table.insert(eventListeners, MouseClickEventListener(frameInfo.frame, onEffectivenessFrameClick, frameInfo))
    end

    local function initEffectivenessUI()
        local effectivenessKeyToLabel = {
            [0.0] = "0x",
            [0.25] = "1/4x",
            [0.5] = "1/2x",
            [1.0] = "1x",
            [2.0] = "2x",
            [4.0] = "4x"
        }
        local ordered = {0.0, 0.25, 0.5, 1.0, 2.0, 4.0}
        ui.frames.effectivenessSelectorFrame =
            Frame(
            Box({x = 0, y = 0}, {width = 0, height = 36}),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 1, y = 2}),
            ui.frames.mainInnerFrame
        )
        for _, tableKey in pairs(ordered) do
            local labelText = effectivenessKeyToLabel[tableKey]
            createEffectivenessFrame(tableKey, labelText)
        end
    end

    local function initBottomUI()
        ui.frames.bottomFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = 0,
                    height = 0
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 92, y = 7}),
            ui.frames.mainInnerFrame
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
        table.insert(
            eventListeners,
            MouseClickEventListener(ui.controls.goBackButton, program.openScreen, program.UI_SCREENS.EXTRAS_SCREEN)
        )
    end

    local function createRow()
        local row = {
            typeLabels = {}
        }
        row.frame =
            Frame(
            Box({x = 0, y = 0}, {width = 0, height = 16}),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 2, {x = 0, y = 0}),
            ui.frames.pokemonListFrame
        )
        row.nameLabel =
            TextLabel(
            Component(row.frame, Box({x = 0, y = 0}, {width = 56, height = 0})),
            TextField(
                "a",
                {x = 0, y = 0},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        for i = 1, 2, 1 do
            row.typeLabels[i] =
                ImageLabel(
                Component(row.frame, Box({x = 0, y = 0}, {width = 31, height = 13}, nil, "Top box border color")),
                ImageField("", {x = 1, y = 1}, nil)
            )
        end
        table.insert(pokemonListRows, row)
    end

    local function initPokemonListUI()
        ui.frames.pokemonListOuterFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 16, height = 163},
                "Top box background color",
                "Top box border color"
            ),
            nil,
            ui.frames.mainInnerFrame
        )
        ui.frames.pokemonListFrame =
            Frame(
            Box({x = 0, y = 0}, {width = 0, height = 0}),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 3, y = 3}),
            ui.frames.pokemonListOuterFrame
        )
        local items = 10
        for i = 1, items, 1 do
            createRow()
        end
        pokemonScroller = ScrollBar(ui.frames.pokemonListOuterFrame, items, {})
        pokemonScroller.setScrollReadingFunction(readCurrentEffectivenessSelection)
    end

    local function initUI()
        ui.controls = {}
        ui.frames = {}
        ui.frames.mainFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = constants.MAIN_FRAME_HEIGHT},
                "Main background color",
                nil
            )
        )
        ui.frames.mainInnerFrame =
            Frame(
            Box(
                {x = 5, y = 5},
                {width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 10, height = constants.MAIN_FRAME_HEIGHT - 10},
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 3, y = 0}),
            ui.frames.mainFrame
        )
        initFullyEvolvedButton()
        initMoveSelectors()
        initEffectivenessUI()
        initPokemonListUI()
        initBottomUI()
    end

    local function reset()
        clearEffectivenessTable()
        for _, selector in pairs(moveSelectors) do
            toggleBrightness(selector, false, false)
        end
    end

    function self.initialize(playerMoves)
        reset()
        onEffectivenessFrameClick(effectivenessSelectorFrames[0.0])
        if playerMoves == nil or next(playerMoves) == nil then
            return
        end
        for _, moveID in pairs(playerMoves) do
            if moveID ~= 0 then
                local moveData = MoveData.MOVES[moveID + 1]
                local moveType = moveData.type
                if moveData.name == "Hidden Power" then
                    moveType = tracker.getCurrentHiddenPowerType()
                end
                if moveData.category ~= MoveData.MOVE_CATEGORIES.STATUS and moveData.power ~= "---" then
                    toggleBrightness(moveTypeToSelector[moveType], true, false)
                end
            end
        end
        calculateCurrentEffectiveness()
    end

    function self.runEventListeners()
        for _, eventListener in pairs(eventListeners) do
            eventListener.listen()
        end
        pokemonScroller.update()
    end

    function self.show()
        ui.frames.mainFrame.show()
    end

    initUI()
    return self
end

return CoverageCalcScreen

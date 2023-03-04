HoverFrameFactory = {}

local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
local Icon = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Icon.lua")
local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
local ImageLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageLabel.lua")
local ImageField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageField.lua")
local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")

local function createRowFrame(parent)
    return Frame(
        Box({x = 0, y = 0}, {width = 0, height = 15}, nil, nil),
        Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 4, {x = 4, y = 4}),
        parent
    )
end

local function fillTypeDefenseFrame(heading, defenseTable, typeDefenseFrame)
    local typesToCreate = #defenseTable
    local currentTypeIndex = 0
    local currentRowFrame = nil
    local totalSize = 0
    local currentRowControls = 0
    while currentTypeIndex <= typesToCreate do
        if currentRowControls == 0 then
            currentRowFrame = createRowFrame(typeDefenseFrame)
            totalSize = totalSize + 17
        end
        if currentTypeIndex == 0 then
            local headingFrame =
                Frame(
                Box({x = 0, y = 0}, {width = 31, height = 13}, nil, nil),
                Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = -6, y = -6}),
                currentRowFrame
            )
            TextLabel(
                Component(
                    headingFrame,
                    Box(
                        {x = 0, y = 0},
                        {width = 36, height = 18},
                        "Top box background color",
                        "Top box border color",
                        true,
                        "Top box background color",
                        true
                    )
                ),
                TextField(
                    heading,
                    {x = 2, y = 0},
                    TextStyle(10, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
                )
            )
        else
            ImageLabel(
                Component(
                    currentRowFrame,
                    Box(
                        {x = 0, y = 0},
                        {width = 31, height = 13},
                        nil,
                        "Top box border color",
                        true,
                        "Top box background color",
                        true
                    )
                ),
                ImageField(
                    "ironmon_tracker/images/types/" .. PokemonData.POKEMON_TYPES[defenseTable[currentTypeIndex]] .. ".png",
                    {x = 1, y = 1},
                    {width = 30, height = 12}
                )
            )
        end
        currentRowControls = (currentRowControls + 1) % 4
        currentTypeIndex = currentTypeIndex + 1
    end
    local size = typeDefenseFrame.getSize()
    typeDefenseFrame.resize({width = size.width, height = totalSize + 4})
end

local function createTypeDefenseFrame(pokemonHoverFrame, heading, defenseTable)
    local typeDefenseFrame =
        Frame(
        Box({x = 0, y = 0}, {width = 144, height = 5}, "Top box background color", "Top box border color"),
        Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 2),
        pokemonHoverFrame
    )
    fillTypeDefenseFrame(heading, defenseTable, typeDefenseFrame)
    return typeDefenseFrame
end

function HoverFrameFactory.createTypeDefensesFrame(params)
    local pokemon = params.pokemon
    local mainFrame = params.mainFrame
    if pokemon ~= nil then
        local order = {"4x", "2x", "0.5x", "0.25x", "0x"}
        local pokemonHoverFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = 144,
                    height = 140
                },
                "Top box background color",
                "Top box border color",
                nil,
                nil,
                true
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 5, {x = 0, y = 0}),
            nil
        )
        TextLabel(
            Component(
                pokemonHoverFrame,
                Box({x = 0, y = 0}, {width = 144, height = 18}, "Top box background color", "Top box border color")
            ),
            TextField(
                "Type Defenses",
                {x = 28, y = 0},
                TextStyle(13, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        local totalSize = 18
        local typeDefensesTable = MoveUtils.getTypeDefensesTable(pokemon)
        for _, heading in pairs(order) do
            local defenseTable = typeDefensesTable[heading]
            if next(defenseTable) ~= nil then
                local typeDefenseFrame = createTypeDefenseFrame(pokemonHoverFrame, heading, defenseTable)
                totalSize = totalSize + typeDefenseFrame.getSize().height + 5
            end
        end
        pokemonHoverFrame.resize({width = 144, height = totalSize})
        return pokemonHoverFrame
    end
end

function HoverFrameFactory.createHoverTextFrame(BGColorKey, BGColorFillKey, text, textColorKey, width, parentFrame)
    local padding = 5
    --subtract an extra 2 for each side (4) because the text actually gets drawn 2 pixels to the right even with 0 padding
    local textArray = DrawingUtils.textToWrappedArray(text, width - 2 * padding - 4)
    local hoverFrame =
        Frame(
        Box(
            {x = 0, y = 0},
            {
                width = width,
                height = #textArray * 10 + 10
            },
            BGColorKey,
            BGColorFillKey,
            nil,
            nil,
            true
        ),
        Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 5}),
        parentFrame
    )
    for _, textSet in pairs(textArray) do
        local textLabel =
            TextLabel(
            Component(
                hoverFrame,
                Box(
                    {
                        x = 0,
                        y = 0
                    },
                    {width = 0, height = 10},
                    nil,
                    nil
                )
            ),
            TextField(
                textSet,
                {x = padding, y = 0},
                TextStyle(Graphics.FONT.DEFAULT_FONT_SIZE, Graphics.FONT.DEFAULT_FONT_FAMILY, textColorKey, BGColorKey)
            )
        )
    end
    return hoverFrame
end

local function createMoveHeaderHoverRows(totalRows, moveLevelsFrame)
    local moveLabelHeight = 16
    local rowFrames = {}
    for i = 1, totalRows, 1 do
        local rowFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = 0,
                    height = moveLabelHeight
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 0, y = 0}),
            moveLevelsFrame
        )
        table.insert(rowFrames, rowFrame)
    end
    return rowFrames
end

local function fillMoveHeaderHoverRows(movelvls, level, rowFrames)
    local displayedPerRow = 8
    local moveLabelWidth = 16
    local moveLabelHeight = 16
    local movesLearnedMarkings = MoveUtils.getMovesLearned(movelvls, level)
    for i, moveLevel in pairs(movelvls) do
        local textColorKey = "Bottom box text color"
        if movesLearnedMarkings[moveLevel] then
            textColorKey = "Negative text color"
        end
        local spacing = 0
        if tonumber(moveLevel) < 10 then
            spacing = 3
        elseif tonumber(moveLevel) == 100 then
            spacing = -3
        end
        local rowIndex = math.ceil(i / (displayedPerRow))
        TextLabel(
            Component(
                rowFrames[rowIndex],
                Box(
                    {
                        x = 0,
                        y = 0
                    },
                    {width = moveLabelWidth, height = moveLabelHeight},
                    "Bottom box background color",
                    "Bottom box border color",
                    nil,
                    nil,
                    true
                )
            ),
            TextField(
                moveLevel,
                {x = 2 + spacing, y = 2},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    textColorKey,
                    "Bottom box background color"
                )
            )
        )
    end
end
function HoverFrameFactory.createMoveLevelsHoverFrame(pokemon, mainFrame)
    local movelvls = pokemon.movelvls
    local level = pokemon.level
    local totalMoves = #movelvls
    local displayedPerRow = 8
    local moveLabelWidth = 16
    local moveLabelHeight = 16
    local textHeaderHeight = 18
    local frameWidth = displayedPerRow * moveLabelWidth + 10
    local totalRows = math.ceil(totalMoves / displayedPerRow)
    local moveLevelsFrameHeight = totalRows * moveLabelHeight + 10
    local mainFrameHeight = moveLevelsFrameHeight + textHeaderHeight
    local moveLevelsHoverFrame =
        Frame(
        Box(
            {x = 0, y = 0},
            {
                width = frameWidth,
                height = mainFrameHeight
            },
            nil,
            nil
        ),
        Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 0}),
        nil
    )
    local textHeader =
        TextLabel(
        Component(
            moveLevelsHoverFrame,
            Box(
                {
                    x = 0,
                    y = 0
                },
                {width = frameWidth, height = textHeaderHeight},
                "Bottom box background color",
                "Bottom box border color",
                nil,
                nil,
                true
            )
        ),
        TextField(
            "Moves Learned",
            {x = 30, y = 1},
            TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Bottom box text color", "Bottom box background color")
        )
    )
    local moveLevelsFrame =
        Frame(
        Box(
            {x = 0, y = 0},
            {
                width = frameWidth,
                height = moveLevelsFrameHeight
            },
            "Bottom box background color",
            "Bottom box border color",
            nil,
            nil,
            true
        ),
        Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 5, y = 5}),
        moveLevelsHoverFrame
    )
    local rowFrames = createMoveHeaderHoverRows(totalRows, moveLevelsFrame)
    fillMoveHeaderHoverRows(movelvls, level, rowFrames)
    return moveLevelsHoverFrame
end

local function readItemDataIntoFrame(items, itemType, itemHolderFrame)
    local frameWidth = 110
    local itemLabelHeight = 11
    local sortedKeys = ItemData.HEALING_ID_SORT_ORDER
    if itemType == "Status" then
        sortedKeys = ItemData.STATUS_ID_SORT_ORDER
    end
    for _, sortedKey in pairs(sortedKeys) do
        local itemData = ItemData.HEALING_ITEMS[sortedKey]
        if itemType == "Status" then
            itemData = ItemData.STATUS_ITEMS[sortedKey]
        end
        if items[sortedKey] then
            local quantity = items[sortedKey]
            local name = itemData.name
            if quantity > 1 then
                if name:sub(-1) == "y" then
                    name = name:sub(1, #name - 1) .. "ies"
                else
                    name = name .. "s"
                end
            end
            local extra = ""
            if itemType == "Healing" then
                extra = itemData.amount
                if itemData.type == ItemData.HEALING_TYPE.CONSTANT then
                    extra = extra .. " HP"
                else
                    extra = extra .. "%"
                end
            elseif itemType == "Status" then
                extra = itemData.status
            end
            local text = quantity .. " " .. name .. " (" .. extra .. ")"
            TextLabel(
                Component(
                    itemHolderFrame,
                    Box(
                        {
                            x = 0,
                            y = 0
                        },
                        {width = frameWidth, height = itemLabelHeight},
                        nil,
                        nil
                    )
                ),
                TextField(
                    text,
                    {x = 3, y = 0},
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
end

function HoverFrameFactory.createItemBagHoverFrame(items, mainFrame, itemType)
    local total = 0
    for _, _ in pairs(items) do
        total = total + 1
    end
    local textHeaderHeight = 18
    local frameWidth = 122
    local totalLabels = total
    local itemLabelHeight = 11
    local itemHolderFrameHeight = totalLabels * itemLabelHeight + 6
    local itemHoverFrame =
        Frame(
        Box(
            {x = 0, y = 0},
            {
                width = frameWidth,
                height = itemHolderFrameHeight + textHeaderHeight
            },
            nil,
            nil,
            nil,
            nil
        ),
        Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 0}),
        nil
    )
    local xPadding = 27
    if itemType == "Status" then
        xPadding = 29
    end
    local textHeader =
        TextLabel(
        Component(
            itemHoverFrame,
            Box(
                {
                    x = 0,
                    y = 0
                },
                {width = frameWidth, height = textHeaderHeight},
                "Top box background color",
                "Top box border color",
                nil,
                nil,
                true
            )
        ),
        TextField(
            itemType .. " Items",
            {x = xPadding, y = 1},
            TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
        )
    )
    local itemHolderFrame =
        Frame(
        Box(
            {x = 0, y = 0},
            {
                width = frameWidth,
                height = itemHolderFrameHeight
            },
            "Top box background color",
            "Top box border color",
            nil,
            nil,
            true
        ),
        Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 3}),
        itemHoverFrame
    )
    readItemDataIntoFrame(items, itemType, itemHolderFrame)
    return itemHoverFrame
end

local function buildTopInfoFrame(BGColorKey, BGColorFillKey, move, parentFrame)
    local topFrameHeight = 17
    local topInfoFrame =
        Frame(
        Box(
            {x = 0, y = 0},
            {
                width = 0,
                height = topFrameHeight
            }
        ),
        Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 0, y = 0}),
        parentFrame
    )
    local categoryTypeFrame =
        Frame(
        Box(
            {x = 0, y = 0},
            {
                width = 46,
                height = topFrameHeight
            },
            "Top box background color",
            "Top box border color",
            false,
            nil,
            true
        ),
        Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 4, y = 2}),
        topInfoFrame
    )
    local moveInfo = MoveData.MOVES[move + 1]
    local moveType = moveInfo.type
    local movePP = moveInfo.pp
    local moveAcc = moveInfo.accuracy
    local power = moveInfo.power
    local moveCategory = moveInfo.category
    local moveDescription = moveInfo.description
    local categoryIconName = MoveData.MOVE_CATEGORIES[moveCategory]
    local categoryIcon =
        Icon(
        Component(
            categoryTypeFrame,
            Box(
                {
                    x = 0,
                    y = 0
                },
                {width = 9, height = 10},
                nil,
                nil
            )
        ),
        categoryIconName,
        {x = 0, y = 4},
        true,
        "Top box background color"
    )
    local typeLabel =
        ImageLabel(
        Component(categoryTypeFrame, Box({x = 0, y = 0}, {width = 31, height = 13}, nil, "Top box border color")),
        ImageField("ironmon_tracker/images/types/" .. moveType .. ".png", {x = 1, y = 1}, {width = 30, height = 12})
    )
    local PPLabel =
        TextLabel(
        Component(
            topInfoFrame,
            Box(
                {x = 0, y = 0},
                {width = 36, height = topFrameHeight},
                "Top box background color",
                "Top box border color",
                false,
                nil,
                true
            )
        ),
        TextField(
            "PP  " .. movePP,
            {x = 5, y = 3},
            TextStyle(
                Graphics.FONT.DEFAULT_FONT_SIZE,
                Graphics.FONT.DEFAULT_FONT_FAMILY,
                "Top box text color",
                "Top box background color"
            )
        )
    )
    local powLabel =
        TextLabel(
        Component(
            topInfoFrame,
            Box(
                {x = 0, y = 0},
                {width = 42, height = topFrameHeight},
                "Top box background color",
                "Top box border color",
                false,
                nil,
                true
            )
        ),
        TextField(
            "Pow  " .. power,
            {x = 2, y = 3},
            TextStyle(
                Graphics.FONT.DEFAULT_FONT_SIZE,
                Graphics.FONT.DEFAULT_FONT_FAMILY,
                "Top box text color",
                "Top box background color",
                false,
                nil,
                true
            )
        )
    )
    local accLabel =
        TextLabel(
        Component(
            topInfoFrame,
            Box(
                {x = 0, y = 0},
                {width = 40, height = topFrameHeight},
                "Top box background color",
                "Top box border color",
                false,
                nil,
                true
            )
        ),
        TextField(
            "Acc  " .. moveAcc,
            {x = 2, y = 3},
            TextStyle(
                Graphics.FONT.DEFAULT_FONT_SIZE,
                Graphics.FONT.DEFAULT_FONT_FAMILY,
                "Top box text color",
                "Top box background color"
            )
        )
    )
end

function HoverFrameFactory.createMoveHoverTextFrame(BGColorKey, BGColorFillKey, move)
    local mainFrame =
        Frame(
        Box(
            {x = 0, y = 0},
            {
                width = 0,
                height = 0
            },
            nil,
            nil,
            false,
            nil,
            true
        ),
        Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 0}),
        nil
    )
    buildTopInfoFrame(BGColorKey, BGColorFillKey, move, mainFrame)
    local textFrame =
        HoverFrameFactory.createHoverTextFrame(
        BGColorKey,
        BGColorFillKey,
        MoveData.MOVES[move + 1].description,
        "Top box text color",
        164,
        mainFrame
    )
    mainFrame.resize({width = 164, height = 17 + textFrame.getSize().height})
    return mainFrame
end

local function createAreaLabel(areaName, parentFrame, size)
    local areaLabel =
        TextLabel(
        Component(
            parentFrame,
            Box(
                {x = 0, y = 0},
                {width = size.width, height = size.height},
                "Top box background color",
                "Top box border color"
            )
        ),
        TextField(
            areaName,
            {x = 2, y = 0},
            TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
        )
    )
    if size ~= nil then
        areaLabel.resize(size)
    end
    local centerX = (parentFrame.getSize().width - DrawingUtils.calculateWordPixelLength(areaName) - #areaName) / 2
    areaLabel.setTextOffset({x = centerX, y = 1})
end

local function formatEncounterEntry(entry)
    return "Level " .. entry.level .. " (" .. entry.percent .. "%)"
end

local function createVanillaEncounterRow(index, info, parentFrame)
    local rowFrame =
        Frame(
        Box(
            {x = 0, y = 0},
            {
                width = 100,
                height = 0
            },
            "Top box background color",
            "Top box border color"
        ),
        Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 0}),
        parentFrame
    )
    local numberRow =
        Frame(
        Box(
            {x = 0, y = 0},
            {
                width = 100,
                height = 12
            }
        ),
        Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 0, y = 0}),
        rowFrame
    )
    local indexLabel =
        TextLabel(
        Component(
            numberRow,
            Box({x = 0, y = 0}, {width = 15, height = 15}, "Top box background color", "Top box border color")
        ),
        TextField(
            index,
            {x = 4 - (3 * (#(tostring(index)) - 1)), y = 2},
            TextStyle(
                Graphics.FONT.DEFAULT_FONT_SIZE,
                Graphics.FONT.DEFAULT_FONT_FAMILY,
                "Top box text color",
                "Top box background color"
            )
        )
    )
    local firstEntry = info[1]
    local firstEntryLabel =
        TextLabel(
        Component(numberRow, Box({x = 0, y = 0}, {width = 14, height = 14})),
        TextField(
            formatEncounterEntry(firstEntry),
            {x = 3, y = 2},
            TextStyle(
                Graphics.FONT.DEFAULT_FONT_SIZE,
                Graphics.FONT.DEFAULT_FONT_FAMILY,
                "Top box text color",
                "Top box background color"
            )
        )
    )
    if #info > 1 then
        local frameForTheRest =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = 9,
                    height = 0
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 15, y = 0}),
            rowFrame
        )
        for i = 2, #info, 1 do
            local entry = info[i]
            local entryLabel =
                TextLabel(
                Component(frameForTheRest, Box({x = 0, y = 0}, {width = 14, height = 12})),
                TextField(
                    formatEncounterEntry(entry),
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
    local rowHeight = 12 * #info + 3
    rowFrame.resize({width = 100, height = rowHeight})
    return rowFrame
end

local function createTrackedEncounterRowFrame(parentFrame)
    local rowFrame =
        Frame(
        Box(
            {x = 0, y = 0},
            {
                width = 130,
                height = 8
            }
        ),
        Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 2, y = 0}),
        parentFrame
    )
    return rowFrame
end

local function fillTrackedEncounterRow(rowFrame, pokemonID, seenData)
    local name = "?"
    if pokemonID ~= -1 then
        name = PokemonData.POKEMON[pokemonID + 1].name
    end

    local pokemonNameLabel =
        TextLabel(
        Component(rowFrame, Box({x = 0, y = 0}, {width = 58, height = 0})),
        TextField(
            name,
            {x = 2, y = 0},
            TextStyle(
                Graphics.FONT.DEFAULT_FONT_SIZE,
                Graphics.FONT.DEFAULT_FONT_FAMILY,
                "Top box text color",
                "Top box background color"
            )
        )
    )
    local levelsText = "?"
    if seenData ~= nil then
        levelsText = "Lv "
        for _, level in pairs(seenData) do
            levelsText = levelsText .. level .. ", "
        end
        levelsText = levelsText:sub(1, #levelsText - 2)
    end
    local levelsLabel =
        TextLabel(
        Component(rowFrame, Box({x = 0, y = 0}, {width = 0, height = 0})),
        TextField(
            levelsText,
            {x = 2, y = 0},
            TextStyle(
                Graphics.FONT.DEFAULT_FONT_SIZE,
                Graphics.FONT.DEFAULT_FONT_FAMILY,
                "Top box text color",
                "Top box background color"
            )
        )
    )
end

local function sortTrackedEncounters(encounters)
    local keys = {}
    for pokemonID, _ in pairs(encounters) do
        table.insert(keys, pokemonID)
    end
    table.sort(
        keys,
        function(key1, key2)
            local levels1, levels2 = encounters[key1], encounters[key2]
            local currentIndex = 1
            while true do
                if levels1[currentIndex] == nil and levels2[currentIndex] == nil then
                    return PokemonData.POKEMON[key1 + 1].name < PokemonData.POKEMON[key2 + 1].name
                elseif levels1[currentIndex] == nil and levels2[currentIndex] ~= nil then
                    return true
                elseif levels2[currentIndex] == nil and levels1[currentIndex] ~= nil then
                    return false
                elseif levels1[currentIndex] ~= levels2[currentIndex] then
                    return levels1[currentIndex] < levels2[currentIndex]
                elseif levels1[currentIndex] == levels2[currentIndex] then
                    currentIndex = currentIndex + 1
                end
            end
        end
    )
    return keys
end

function HoverFrameFactory.createTrackedEncountersHoverFrame(vanillaData, encounterData)
    local mainFrame =
        Frame(
        Box(
            {x = 0, y = 0},
            {
                width = 130,
                height = 72
            },
            "Top box background color",
            "Top box border color",
            false,
            nil,
            true
        ),
        Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 3, {x = 0, y = 0}),
        nil
    )
    createAreaLabel(encounterData.areaName, mainFrame, {width = 130, height = 18})
    local totalSeen = 0
    local totalHeight = 22
    local sortedKeys = sortTrackedEncounters(encounterData.encountersSeen)
    for _, pokemonID in pairs(sortedKeys) do
        local seenData = encounterData.encountersSeen[pokemonID]
        local rowFrame = createTrackedEncounterRowFrame(mainFrame)
        fillTrackedEncounterRow(rowFrame, pokemonID, seenData)
        totalSeen = totalSeen + 1
        totalHeight = totalHeight + rowFrame.getSize().height + 3
    end
    for i = totalSeen + 1, vanillaData.totalPokemon, 1 do
        local rowFrame = createTrackedEncounterRowFrame(mainFrame)
        fillTrackedEncounterRow(rowFrame, -1, nil)
        totalHeight = totalHeight + rowFrame.getSize().height + 3
    end
    mainFrame.resize({width = 130, height = totalHeight + 3})
    return mainFrame
end

function HoverFrameFactory.createVanillaEncountersHoverFrame(areaName, encounterData)
    local mainFrame =
        Frame(
        Box(
            {x = 0, y = 0},
            {
                width = 100,
                height = 0
            },
            "Top box background color",
            "Top box border color",
            false,
            nil,
            true
        ),
        Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 2, {x = 0, y = 0}),
        nil
    )
    createAreaLabel(areaName, mainFrame, {width = 100, height = 18})
    local totalHeight = 18
    for index, pokemonData in pairs(encounterData.vanillaData) do
        local rowFrame = createVanillaEncounterRow(index, pokemonData, mainFrame)
        totalHeight = totalHeight + rowFrame.getSize().height + 2
    end
    mainFrame.resize({width = 100, height = totalHeight})
    return mainFrame
end

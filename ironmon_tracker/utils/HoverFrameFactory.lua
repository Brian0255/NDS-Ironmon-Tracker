HoverFrameFactory = {}

local Frame = dofile("ironmon_tracker/ui/UIBaseClasses/Frame.lua")
local Box = dofile("ironmon_tracker/ui/UIBaseClasses/Box.lua")
local Component = dofile("ironmon_tracker/ui/UIBaseClasses/Component.lua")
local TextLabel = dofile("ironmon_tracker/ui/UIBaseClasses/TextLabel.lua")
local ImageLabel = dofile("ironmon_tracker/ui/UIBaseClasses/ImageLabel.lua")
local ImageField = dofile("ironmon_tracker/ui/UIBaseClasses/ImageField.lua")
local TextField = dofile("ironmon_tracker/ui/UIBaseClasses/TextField.lua")
local TextStyle = dofile("ironmon_tracker/ui/UIBaseClasses/TextStyle.lua")
local Layout = dofile("ironmon_tracker/ui/UIBaseClasses/Layout.lua")
local Icon = dofile("ironmon_tracker/ui/UIBaseClasses/Icon.lua")
local HoverEventListener = dofile("ironmon_tracker/ui/UIBaseClasses/HoverEventListener.lua")
local MouseClickEventListener = dofile("ironmon_tracker/ui/UIBaseClasses/MouseClickEventListener.lua")

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
                        "Top box background color"
                    )
                ),
                TextField(
                    heading,
                    {x = 2, y = 0},
                    TextStyle(
                        10,
                        Graphics.FONT.DEFAULT_FONT_FAMILY,
                        "Top box text color",
                        "Top box background color"
                    )
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
                        "Top box background color"
                    )
                ),
                ImageField(
                    "ironmon_tracker/images/types/" ..
                        PokemonData.POKEMON_TYPES[defenseTable[currentTypeIndex]] .. ".png",
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
                "Top box border color"
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
        local hoverFrameSize = pokemonHoverFrame.getSize()
        local position = Input.getMousePosition()
        MiscUtils.clampFramePosition(nil,position,mainFrame.getSize(),hoverFrameSize)
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
        pokemonHoverFrame.move(position)
        return pokemonHoverFrame
    end
end

function HoverFrameFactory.createHoverTextFrame(BGColorKey, BGColorFillKey, text, textColorKey, width)
    local padding = 10
    local textArray = DrawingUtils.textToWrappedArray(text, width - padding)
    local hoverFrame =
        Frame(
        Box(
            {x = 0, y = 0},
            {
                width = width,
                height = #textArray * 10 + 10
            },
            BGColorKey,
            BGColorFillKey
        ),
        Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 5}),
        nil
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
                {x = 5, y = 0},
                TextStyle(Graphics.FONT.DEFAULT_FONT_SIZE, Graphics.FONT.DEFAULT_FONT_FAMILY, textColorKey, BGColorKey)
            )
        )
    end
    return hoverFrame
end
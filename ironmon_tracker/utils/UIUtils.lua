UIUtils = {}

local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")

function UIUtils.clampFramePosition(alignment, position, frameToAlignWith, frameSize)
    if alignment == Graphics.HOVER_ALIGNMENT_TYPE.ALIGN_ABOVE then
        position.y = position.y - frameSize.height
    end
    position.x =
        math.min(position.x, frameToAlignWith.getPosition().x + frameToAlignWith.getSize().width - frameSize.width - 1)
    position.y = math.max(0, position.y)
end

function UIUtils.moveHoverFrameToMouse(hoverFrame, alignment, frameToAlignWith)
    local position = Input.getMousePosition()
    UIUtils.clampFramePosition(alignment, position, frameToAlignWith, hoverFrame.getSize())
    hoverFrame.move(position)
end

local function moveAndShowHoverFrame(hoverFrame, alignment, frameToAlignWith, drawFunction)
    UIUtils.moveHoverFrameToMouse(hoverFrame, alignment, frameToAlignWith)
    drawFunction()
    hoverFrame.show()
end

function UIUtils.createAndDrawHoverFrame(hoverParams, drawFunction, frameToAlignWith)
    local BGColorKey = hoverParams.BGColorKey
    local BGColorFillKey = hoverParams.BGColorFillKey
    local textColorKey = hoverParams.textColorKey
    local text = hoverParams.text
    local hoverFrame
    if text ~= "" then
        local width = hoverParams.width
        local alignment = hoverParams.alignment
        hoverFrame = HoverFrameFactory.createHoverTextFrame(BGColorKey, BGColorFillKey, text, textColorKey, width)
        moveAndShowHoverFrame(hoverFrame, alignment, frameToAlignWith, drawFunction)
    end
    return hoverFrame
end

function UIUtils.createAndDrawItemHoverFrame(items, itemType, frameToAlignWith, drawFunction)
    local activeHoverFrame
    local itemsHoverFrame = HoverFrameFactory.createItemBagHoverFrame(items, frameToAlignWith, itemType)
    UIUtils.moveHoverFrameToMouse(itemsHoverFrame, Graphics.HOVER_ALIGNMENT_TYPE.ALIGN_ABOVE, frameToAlignWith)
    activeHoverFrame = itemsHoverFrame
    drawFunction()
    itemsHoverFrame.show()
    return activeHoverFrame
end

function UIUtils.createAndDrawTypeResistancesFrame(params, drawFunction, frameToAlignWith)
    local pokemonHoverFrame
    if params.pokemonID ~= 0 then
        pokemonHoverFrame = HoverFrameFactory.createTypeDefensesFrame(params)
        moveAndShowHoverFrame(pokemonHoverFrame, Graphics.HOVER_ALIGNMENT_TYPE.ALIGN_BELOW, frameToAlignWith, drawFunction)
    end
    return pokemonHoverFrame
end

function UIUtils.underlineTextLabel(label)
    local position = label.getPosition()
    local size = label.getSize()
    local x1, y1 = position.x + 3, position.y + size.height - 2
    local x2, y2 = position.x + size.width - 3, y1
    gui.drawLine(x1, y1, x2, y2, DrawingUtils.convertColorKeyToColor("Top box text color"))
end

function UIUtils.createAndDrawMoveHoverFrame(hoverParams, drawFunction, frameToAlignWith)
    local BGColorKey = hoverParams.BGColorKey
    local BGColorFillKey = hoverParams.BGColorFillKey
    local move = hoverParams.move
    local hoverFrame
    if move ~= nil and move ~= -1 then
        local alignment = Graphics.HOVER_ALIGNMENT_TYPE.ALIGN_ABOVE
        hoverFrame = HoverFrameFactory.createMoveHoverTextFrame(BGColorKey, BGColorFillKey, move)
        moveAndShowHoverFrame(hoverFrame, alignment, frameToAlignWith, drawFunction)
    end
    return hoverFrame
end

function UIUtils.createAndDrawTrackedEncounterData(vanillaData, encounterData, drawFunction, frameToAlignWith)
    local hoverFrame
    local alignment = Graphics.HOVER_ALIGNMENT_TYPE.ALIGN_ABOVE
    hoverFrame = HoverFrameFactory.createTrackedEncountersHoverFrame(vanillaData, encounterData)
    moveAndShowHoverFrame(hoverFrame, alignment, frameToAlignWith, drawFunction)
    return hoverFrame
end

function UIUtils.createAndDrawVanillaEncounterData(areaName, vanillaData, drawFunction, frameToAlignWith)
    local hoverFrame
    local alignment = Graphics.HOVER_ALIGNMENT_TYPE.ALIGN_ABOVE
    hoverFrame = HoverFrameFactory.createVanillaEncountersHoverFrame(areaName, vanillaData)
    moveAndShowHoverFrame(hoverFrame, alignment, frameToAlignWith, drawFunction)
    return hoverFrame
end

function UIUtils.createKeyboardMatchLabel(parentFrame, name, labelHeight)
    local labelWidth = DrawingUtils.calculateWordPixelLength(name) + 5
    local matchLabel =
        TextLabel(
        Component(
            parentFrame,
            Box(
                {x = 5, y = 5},
                {
                    width = labelWidth,
                    height = labelHeight
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
    return matchLabel
end

function UIUtils.createKeyboardLabelsFromMatches(matches, dataGroup, parentFrame, maxSearchResultWidth, labelHeight)
    local matchTextLabels = {}
    local currentResultWidth = 0
    for _, match in pairs(matches) do
        local name = dataGroup[match + 1].name
        if dataGroup.ALTERNATE_FORMS then
            if dataGroup.ALTERNATE_FORMS[name] and dataGroup.ALTERNATE_FORMS[name].cosmetic then
                name = dataGroup.ALTERNATE_FORMS[name].shortenedName
            end
        end
        local labelWidth = DrawingUtils.calculateWordPixelLength(name) + 5
        currentResultWidth = currentResultWidth + labelWidth + 1 --layout spacing
        if currentResultWidth > maxSearchResultWidth then
            table.insert(
                matchTextLabels,
                TextLabel(
                    Component(
                        parentFrame,
                        Box(
                            {x = 5, y = 5},
                            {
                                width = 20,
                                height = labelHeight
                            }
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
            table.insert(matchTextLabels, UIUtils.createKeyboardMatchLabel(parentFrame, name, labelHeight))
        end
    end
    return matchTextLabels
end

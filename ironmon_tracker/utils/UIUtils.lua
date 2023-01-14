UIUtils = {}

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
        UIUtils.moveHoverFrameToMouse(hoverFrame, alignment, frameToAlignWith)
        drawFunction()
        hoverFrame.show()
    end
    return hoverFrame
end

function UIUtils.createAndDrawTypeResistancesFrame(params, drawFunction, frameToAlignWith)
    local pokemonHoverFrame
    if params.pokemonID ~= 0 then
        pokemonHoverFrame = HoverFrameFactory.createTypeDefensesFrame(params)
        UIUtils.moveHoverFrameToMouse(pokemonHoverFrame, Graphics.HOVER_ALIGNMENT_TYPE.ALIGN_BELOW, frameToAlignWith)
        drawFunction()
        pokemonHoverFrame.show()
    end
    return pokemonHoverFrame
end

function UIUtils.createAndDrawMoveHoverFrame(hoverParams, drawFunction, frameToAlignWith)
    local BGColorKey = hoverParams.BGColorKey
    local BGColorFillKey = hoverParams.BGColorFillKey
    local move = hoverParams.move
    local hoverFrame
    if move ~= nil and move ~= -1 then
        local alignment = Graphics.HOVER_ALIGNMENT_TYPE.ALIGN_ABOVE
        hoverFrame = HoverFrameFactory.createMoveHoverTextFrame(BGColorKey, BGColorFillKey, move)
        UIUtils.moveHoverFrameToMouse(hoverFrame, alignment, frameToAlignWith)
        drawFunction()
        hoverFrame.show()
    end
    return hoverFrame
end

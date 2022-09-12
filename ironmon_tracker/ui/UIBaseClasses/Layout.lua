local function Layout(initialAlignment, initialSpacing, initialPadding)
    local self = {}
    local frame = nil
    local alignment = initialAlignment
    local spacing = initialSpacing
    local padding = initialPadding
    if padding == nil then
        padding = {
            x = 0,
            y = 0
        }
    end
    if spacing == nil then
        spacing = 0
    end
    local items = {}
    function self.setItems(newItems)
        items = newItems
    end
    function self.setFrame(newFrame)
        frame = newFrame
    end
    function self.setAlignment(newAlignment)
        alignment = newAlignment
    end
    function self.setSpacing(newSpacing)
        spacing = newSpacing
    end
    function self.changeItemPositions()
        local startPosition = frame.getPosition()
        startPosition.x = startPosition.x + padding.x
        startPosition.y = startPosition.y + padding.y
        local currentPosition = startPosition
        for _, item in pairs(items) do
            if item.isVisible() then
                item.move(currentPosition)
                if alignment == Graphics.ALIGNMENT_TYPE.HORIZONTAL then
                    currentPosition.x = currentPosition.x + item.getSize().width + spacing
                elseif alignment == Graphics.ALIGNMENT_TYPE.VERTICAL then
                    currentPosition.y = currentPosition.y + item.getSize().height + spacing
                end
            end
        end
    end
    return self
end

return Layout

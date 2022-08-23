local function TextField(initialText, initialTextOffset, initialTextStyle)
    local self = {}
    local text = initialText
    local textOffset = initialTextOffset
    local textStyle = initialTextStyle
    local position = nil
    function self.move(newPosition)
        position = {
            x = newPosition.x,
            y = newPosition.y
        }
    end
    function self.setText(newText)
        text = newText
    end
    function self.show()
        local shadowColorKey = textStyle.getShadowColorKey()
        local shadowColor = DrawingUtils.calcShadowColor(shadowColorKey)
        local newPosition = {
            x = position.x + textOffset.x,
            y = position.y + textOffset.y
        }
        DrawingUtils.drawText(newPosition.x, newPosition.y, text, textStyle, shadowColor)
    end
    return self
end

return TextField

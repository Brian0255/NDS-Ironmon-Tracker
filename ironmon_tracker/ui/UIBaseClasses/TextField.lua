local function TextField(initialText, initialTextPadding, initialTextStyle)
    local self = {}
    local text = initialText
    local textPadding = initialTextPadding
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
        DrawingUtils.drawText(position.x, position.y, text, textPadding, textStyle, shadowColor)
    end
    return self
end

return TextField

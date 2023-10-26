local function TextField(initialText, initialTextOffset, initialTextStyle, isJustifiable, justifiedSpacing)
    local self = {}
    local text = initialText
    local textOffset = initialTextOffset
    local textStyle = initialTextStyle
    local position = nil
    local justifiable = isJustifiable
    if justifiable == nil then
        justifiable = false
    end
    if justifiedSpacing == nil then
        justifiedSpacing = 3
    end
    function self.move(newPosition)
        position = {
            x = newPosition.x,
            y = newPosition.y
        }
    end
    function self.setText(newText)
        text = newText
    end
    function self.getText()
        return text
    end
    function self.setTextOffset(newOffset)
        textOffset = {
            x = newOffset.x,
            y = newOffset.y
        }
    end
    function self.setTextColorKey(newColorKey)
        textStyle.setTextColorKey(newColorKey)
    end
    function self.setShadowColorKey(newShadowColorKey)
        textStyle.setShadowColorKey(newShadowColorKey)
    end
    function self.show()
        if text == "" then
            return
        end
        local shadowColorKey = textStyle.getShadowColorKey()
        local shadowColor = DrawingUtils.calcShadowColor(shadowColorKey)
        local newPosition = {
            x = position.x + textOffset.x,
            y = position.y + textOffset.y
        }
        DrawingUtils.drawText(newPosition.x, newPosition.y, text, textStyle, shadowColor, justifiable, justifiedSpacing)
    end
    return self
end

return TextField

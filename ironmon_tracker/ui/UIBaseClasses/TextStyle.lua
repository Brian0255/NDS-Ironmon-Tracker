local function TextStyle(initialFontSize, initialFontFamily, initialTextColorKey, initialShadowColorKey, shouldBeBolded, initial)
    local self = {}
    local bold = nil
    if shouldBeBolded then
        bold = "bold"
    end
    local fontSize = initialFontSize
    local fontFamily = initialFontFamily
    local textColorKey = initialTextColorKey
    local shadowColorKey = initialShadowColorKey
    function self.isBolded()
        return bold
    end
    function self.getFontSize()
        return fontSize
    end
    function self.getFontFamily()
        return fontFamily
    end
    function self.getTextColorKey()
        return textColorKey
    end
    function self.setTextColorKey(newColorKey)
        textColorKey = newColorKey
    end
    function self.setShadowColorKey(newShadowColorKey)
        shadowColorKey = newShadowColorKey
    end
    function self.getShadowColorKey()
        return shadowColorKey
    end
    return self
end

return TextStyle

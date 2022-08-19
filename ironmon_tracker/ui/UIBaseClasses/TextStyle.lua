local function TextStyle(initialFontSize, initialFontFamily, initialTextColorKey, initialShadowColorKey)
    local self = {}
    local fontSize = initialFontSize
    local fontFamily = initialFontFamily
    local textColorKey = initialTextColorKey
    local shadowColorKey = initialShadowColorKey
    function self.getFontSize()
        return fontSize
    end
    function self.getFontFamily()
        return fontFamily
    end
    function self.getTextColorKey()
        return textColorKey
    end
    function self.getShadowColorKey()
        return shadowColorKey
    end
    return self
end

return TextStyle
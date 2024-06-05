local function TextStyle(
    initialFontSize,
    initialFontFamily,
    initialTextColorKey,
    initialShadowColorKey,
    shouldBeBolded,
    useStrikethrough)
    local self = {}
    local bold = nil
    if shouldBeBolded then
        bold = "bold"
    end
    local strikethrough = useStrikethrough or false
    local fontSize = initialFontSize
    local fontFamily = initialFontFamily
    local textColorKey = initialTextColorKey
    local shadowColorKey = initialShadowColorKey
    function self.isStrikethrough()
        return strikethrough
    end
    function self.setUseStrikethrough(newValue)
        strikethrough = newValue
    end
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

DrawingUtils = {}

local colorScheme
local colorSettings

function DrawingUtils.setColorScheme(newScheme)
    colorScheme = newScheme
    colorScheme["Black"] = 0xFF000000
end

function DrawingUtils.setColorSettings(newColorSettings)
    colorSettings = newColorSettings
end

function DrawingUtils.clearGUI()
    gui.drawRectangle(
        Graphics.SIZES.SCREEN_WIDTH,
        0,
        Graphics.SIZES.SCREEN_WIDTH + Graphics.SIZES.MAIN_SCREEN_WIDTH,
        Graphics.SIZES.MAIN_SCREEN_HEIGHT,
        0x00000000,
        0x00000000
    )
end

function DrawingUtils.createHoverTextFrame(BGColorKey, BGColorFillKey, text, textColorKey, width)
    local UIClassFolder = Paths.FOLDERS.UI_BASE_CLASSES .. "/"
    local Frame = dofile(UIClassFolder .. "Frame.lua")
    local Box = dofile(UIClassFolder .. "Box.lua")
    local Component = dofile(UIClassFolder .. "Component.lua")
    local TextLabel = dofile(UIClassFolder .. "TextLabel.lua")
    local TextField = dofile(UIClassFolder .. "TextField.lua")
    local TextStyle = dofile(UIClassFolder .. "TextStyle.lua")
    local Layout = dofile(UIClassFolder .. "Layout.lua")
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

function DrawingUtils.textToWrappedArray(text, maxWidth)
    local words = MiscUtils.split(text, " ")
    local newWords = {}
    local currentLineLength = 0
    local currentLine = ""
    for i, word in pairs(words) do
        --add 2 for space
        local wordPixelLength = DrawingUtils.calculateWordPixelLength(word)
        local nextLength = currentLineLength + wordPixelLength + 2
        if nextLength > maxWidth then
            table.insert(newWords, currentLine)
            currentLine = word .. " "
            currentLineLength = wordPixelLength + 2
        else
            currentLine = currentLine .. word .. " "
            currentLineLength = nextLength
        end
    end
    table.insert(newWords, currentLine)
    return newWords
end

function DrawingUtils.calculateWordPixelLength(text)
    local totalLength = 0
    for i = 1, #text do
        local char = text:sub(i, i)
        if Graphics.LETTER_PIXEL_LENGTHS[char] then
            totalLength = totalLength + Graphics.LETTER_PIXEL_LENGTHS[char]
        else
            totalLength = totalLength + 1
        end
    end
    totalLength = totalLength + #text --space in between each character
    return totalLength
end

function DrawingUtils.drawBox(x, y, width, height, fill, background, shadowed, shadowColor)
    if shadowed and colorSettings["Draw shadows"] and not colorSettings["Transparent backgrounds"] then
        gui.drawRectangle(x, y, width + 2, height + 2, 0x00000000, shadowColor)
    end
    gui.drawRectangle(x, y, width, height, fill, background)
end

function DrawingUtils.drawText(x, y, text, textStyle, shadowColor)
    local drawShadow = colorSettings["Draw shadows"] and not colorSettings["Transparent backgrounds"]
    local color = DrawingUtils.convertColorKeyToColor(textStyle.getTextColorKey())
    local spacing = 0
    local movePowerExceptions = {["<SPE"] = true, [">SPE"] = true}
    if movePowerExceptions[text] then
        spacing = -5
    end
    local number = tonumber(text)
    if number ~= nil then
        if number == -1 then
            spacing = 8
            text = "---"
        else
            spacing = (3 - string.len(tostring(number))) * 5
        end
    end
    if drawShadow then
        gui.drawText(x + spacing + 1, y + 1, text, shadowColor, nil, textStyle.getFontSize(), textStyle.getFontFamily())
    end
    local bolded = textStyle.isBolded()
    gui.drawText(x + spacing, y, text, color, nil, textStyle.getFontSize(), textStyle.getFontFamily(), bolded)
end

function DrawingUtils.convertColorKeyToColor(colorKey)
    local transparentKeys = {
        ["Main background color"] = true,
        ["Top box background color"] = true,
        ["Bottom box background color"] = true
    }
    if colorSettings["Transparent backgrounds"] and transparentKeys[colorKey] then
        return 0x00000000
    end
    local color = colorScheme[colorKey]
    if color == nil then
        color = Graphics.TYPE_COLORS[colorKey]
    end
    return color
end

function DrawingUtils.calcShadowColor(colorKey)
    local color = colorScheme[colorKey]
    local color_hexval = (color - 0xFF000000)

    local r = bit.rshift(color_hexval, 16)
    local g = bit.rshift(bit.band(color_hexval, 0x00FF00), 8)
    local b = bit.band(color_hexval, 0x0000FF)

    r = math.max(r * .92, 0)
    g = math.max(g * .92, 0)
    b = math.max(b * .92, 0)

    color_hexval = bit.lshift(r, 16) + bit.lshift(g, 8) + b
    return (0xFF000000 + color_hexval)
end

function DrawingUtils.drawNumber(x, y, number, spacing, color, style, drawShadow, colorToShadow)
    local new_spacing = 0
    if style == "right_justified" then
        new_spacing = (spacing - string.len(tostring(number))) * 5
        if number == "---" then
            new_spacing = 8
        end
    end
    if drawShadow then
        local shadow = DrawingUtils.calcShadowColor(colorToShadow)
        gui.drawText(x + 1 + new_spacing, y + 1, number, shadow, nil, 9, "Franklin Gothic Medium")
    end
    gui.drawText(x + new_spacing, y, number, color, nil, 9, "Franklin Gothic Medium")
end

function DrawingUtils.drawTriangleRight(x, y, size, color)
    gui.drawRectangle(x, y, size, size, color)
    gui.drawPolygon({{4 + x, 4 + y}, {4 + x, y + size - 4}, {x + size - 4, y + size / 2}}, color, color)
end

function DrawingUtils.drawTriangleLeft(x, y, size, color)
    gui.drawRectangle(x, y, size, size, color)
    gui.drawPolygon({{x + size - 4, 4 + y}, {x + size - 4, y + size - 4}, {4 + x, y + size / 2}}, color, color)
end

function DrawingUtils.drawChevronUp(x, y, width, height, thickness, color)
    local i = 0
    y = y + height + thickness + 1
    while i < thickness do
        gui.drawLine(x, y - i, x + (width / 2), y - i - height, color)
        gui.drawLine(x + (width / 2), y - i - height, x + width, y - i, color)
        i = i + 1
    end
end

function DrawingUtils.drawChevronDown(x, y, width, height, thickness, color)
    local i = 0
    y = y + thickness + 2
    while i < thickness do
        gui.drawLine(x, y + i, x + (width / 2), y + i + height, color)
        gui.drawLine(x + (width / 2), y + i + height, x + width, y + i, color)
        i = i + 1
    end
end

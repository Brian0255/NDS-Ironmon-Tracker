function DrawingUtils.drawText(x, y, text, color, style, drawShadow, colorToShadow)
    local font = 9
    if style == "nature" then
        font = 5
    end
    if drawShadow then
        local shadow = DrawingUtils.calcShadowColor(colorToShadow)
        gui.drawText(x + 1, y + 1, text, shadow, nil, font, "Franklin Gothic Medium")
    end
    gui.drawText(x, y, text, color, nil, font, "Franklin Gothic Medium")
end

function DrawingUtils.calcShadowColor(color)
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

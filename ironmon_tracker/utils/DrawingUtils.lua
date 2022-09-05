DrawingUtils = {}

local colorScheme
local colorSettings
local appearanceSettings

function DrawingUtils.setColorScheme(newScheme)
    colorScheme = newScheme
    colorScheme["Black"] = 0xFF000000
end

function DrawingUtils.setColorSettings(newColorSettings)
    colorSettings = newColorSettings
end

function DrawingUtils.setAppearanceSettings(newAppearanceSettings)
    appearanceSettings = newAppearanceSettings
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
        local nextLength = currentLineLength + wordPixelLength + 3
        if nextLength > maxWidth then
            table.insert(newWords, currentLine)
            currentLine = word .. " "
            currentLineLength = wordPixelLength + 1
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

function DrawingUtils.drawText(x, y, text, textStyle, shadowColor, justifiable)
    local drawShadow = colorSettings["Draw shadows"] and not colorSettings["Transparent backgrounds"]
    local color = DrawingUtils.convertColorKeyToColor(textStyle.getTextColorKey())
    local spacing = 0
    if appearanceSettings.RIGHT_JUSTIFIED_NUMBERS and justifiable then
        if text == "---" then
            spacing = 8
        else
            local number = tonumber(text)
            if number ~= nil then
                spacing = (3 - string.len(tostring(number))) * 5
            end
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

function DrawingUtils.drawTriangleRight(x, y, size, color)
    gui.drawRectangle(x, y, size, size, color)
    gui.drawPolygon({{4 + x, 4 + y}, {4 + x, y + size - 4}, {x + size - 4, y + size / 2}}, color, color)
end

function DrawingUtils.drawTriangleLeft(x, y, size, color)
    gui.drawRectangle(x, y, size, size, color)
    gui.drawPolygon({{x + size - 4, 4 + y}, {x + size - 4, y + size - 4}, {4 + x, y + size / 2}}, color, color)
end

local function drawChevronUp(position, colorKey)
    local color = DrawingUtils.convertColorKeyToColor(colorKey)
    local center = {x = position.x + 2, y = position.y}
    gui.drawLine(position.x, position.y+2, center.x, center.y, color)
    gui.drawLine(center.x, center.y, position.x + 4, position.y+2, color)
end

local function drawChevronDown(position, colorKey)
    local color = DrawingUtils.convertColorKeyToColor(colorKey)
    local center = {x = position.x + 2, y = position.y + 2}
    gui.drawLine(position.x, position.y, center.x, center.y, color)
    gui.drawLine(center.x, center.y, position.x + 4, position.y, color)
end

function DrawingUtils.drawChevron(direction, position, colorKey)
    if colorKey ~= nil then
        if direction == "up" then
            drawChevronUp(position, colorKey)
        else
            drawChevronDown(position, colorKey)
        end
    end
end

function DrawingUtils.drawStatStageChevrons(position, statStage)
    local colorStates = {"Negative text color", "Top box text color", nil, "Top box text color", "Positive text color"}
    local chevrons = {
        bottomChevron = {start = 2, position = {x = position.x, y = position.y}},
        middleChevron = {start = 1, position = {x = position.x, y = position.y - 2}},
        topChevron = {start = 0, position = {x = position.x, y = position.y - 4}}
    }
    local direction = "none"
    if statStage < 6 then
        direction = "down"
    else
        direction = "up"
    end
    for _, chevron in pairs(chevrons) do
        local colorState = math.floor((statStage+chevron.start)/3) + 1
        DrawingUtils.drawChevron(direction, chevron.position, colorStates[colorState])
    end
end

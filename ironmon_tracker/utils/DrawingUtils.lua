DrawingUtils = {}

local settings

local appearanceSettings
local blackInsteadOfTransparent

local UIClassFolder = Paths.FOLDERS.UI_BASE_CLASSES .. "/"
local Frame = dofile(UIClassFolder .. "Frame.lua")
local Box = dofile(UIClassFolder .. "Box.lua")
local Component = dofile(UIClassFolder .. "Component.lua")
local TextLabel = dofile(UIClassFolder .. "TextLabel.lua")
local TextField = dofile(UIClassFolder .. "TextField.lua")
local TextStyle = dofile(UIClassFolder .. "TextStyle.lua")
local Layout = dofile(UIClassFolder .. "Layout.lua")
local ImageField = dofile(UIClassFolder .. "/ImageField.lua")

-- Use this to prevent image files from being drawn onto the Tracker; helps solves caching issues and image locks
DrawingUtils.canDrawImages = true

function DrawingUtils.initialize(initialSettings)
    settings = initialSettings
    DrawingUtils.canDrawImages = true
end

function DrawingUtils.setTransparentBackgroundOverride(newValue)
    blackInsteadOfTransparent = newValue
end

function DrawingUtils.setAppearanceSettings(newAppearanceSettings)
    appearanceSettings = newAppearanceSettings
end

function DrawingUtils.textToWrappedArray(text, maxWidth)
    local words = MiscUtils.split(text, " ")
    local newWords = {}
    local currentLineLength = 0
    local currentLine = ""
    for _, word in pairs(words) do
        --add 3 for space between words
        local wordPixelLength = DrawingUtils.calculateWordPixelLength(word)
        local nextLength = currentLineLength + wordPixelLength + 3
        if (nextLength - 3) > maxWidth then
            table.insert(newWords, currentLine)
            currentLine = word .. " "
            currentLineLength = wordPixelLength + 3
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

function DrawingUtils.drawBox(x, y, width, height, fill, background, shadowed, shadowColor, opacity)
    if shadowed and settings.colorSettings["Draw shadows"] and not settings.colorSettings["Transparent backgrounds"] then
        gui.drawRectangle(x, y, width + 2, height + 2, 0x00000000, shadowColor)
    end
    local opacityStr = string.format("%X", opacity or 0xFF)
    if fill ~= nil and opacity ~= 0xFF then
        local fillStr = string.format("%X", fill)
        fill = tonumber(opacityStr .. fillStr:sub(3), 16)
    end
    if background ~= nil and opacity ~= 0xFF then
        local backgroundStr = string.format("%X", background)
        background = tonumber(opacityStr .. backgroundStr:sub(3), 16)
    end
    gui.drawRectangle(x, y, width, height, fill, background)
end

function DrawingUtils.drawHorizontalBarGraph(
    position,
    size,
    dataSet,
    headingText,
    borderColorKey,
    textBarColorKey,
    graphPadding,
    maxValue,
    horizontalPadding)
    local borderColor = DrawingUtils.convertColorKeyToColor(borderColorKey)
    local textBarColor = DrawingUtils.convertColorKeyToColor(textBarColorKey)
    local x, y = position.x, position.y
    local width, height = size.width, size.height
    local namePadding = horizontalPadding
    local topLeftPoint = {
        ["x"] = x + graphPadding + namePadding,
        ["y"] = y + graphPadding
    }
    local bottomLeftPoint = {
        ["x"] = x + graphPadding + namePadding,
        ["y"] = y + height - graphPadding - 3
    }
    local bottomRightPoint = {
        ["x"] = x + width - 2 * graphPadding,
        ["y"] = y + height - graphPadding
    }

    gui.drawLine(topLeftPoint.x, topLeftPoint.y, bottomLeftPoint.x, bottomLeftPoint.y, borderColor)
    --gui.drawLine(bottomLeftPoint.x, bottomLeftPoint.y, bottomRightPoint.x, bottomRightPoint.y, borderColor)

    local textLength = DrawingUtils.calculateWordPixelLength(headingText)
    local textX = x + graphPadding + namePadding + ((width - 2 * graphPadding - textLength - namePadding) / 2)
    local style =
        TextStyle(
        Graphics.FONT.DEFAULT_FONT_SIZE,
        Graphics.FONT.DEFAULT_FONT_FAMILY,
        "Top box text color",
        "Top box background color"
    )

    DrawingUtils.drawText(textX, y - 3, headingText, style, DrawingUtils.calcShadowColor("Top box background color"))

    local totalBars = 0
    for _, _ in pairs(dataSet) do
        totalBars = totalBars + 1
    end
    local barHeight = (height - 2 * graphPadding) / (totalBars + (totalBars / 2) + (1 / 2))
    local spacing = barHeight / 2
    local currentIndex = 0
    local topValue = maxValue * 1.35
    local horizontalDistance = math.abs(bottomRightPoint.x - bottomLeftPoint.x)
    for _, dataEntry in pairs(dataSet) do
        local name, value = dataEntry[1], dataEntry[2]
        local barY = math.floor(spacing + topLeftPoint.y + ((spacing + barHeight) * currentIndex)) - 1
        local horizontalDistanceFraction = horizontalDistance * (value / topValue)
        local barX = bottomLeftPoint.x + 1
        local verticalOffset = (barHeight - 10) / 2
        gui.drawRectangle(barX, barY, horizontalDistanceFraction, barHeight, textBarColor, textBarColor)

        value = tostring(value)
        local nameLength = DrawingUtils.calculateWordPixelLength(name)
        local valueLength = DrawingUtils.calculateWordPixelLength(value)
        local nameX = barX - nameLength - 4
        local valueX = barX + horizontalDistanceFraction + 3

        DrawingUtils.drawText(
            valueX,
            barY + verticalOffset,
            value,
            style,
            DrawingUtils.calcShadowColor("Top box background color")
        )
        DrawingUtils.drawText(
            nameX,
            barY + verticalOffset,
            name,
            style,
            DrawingUtils.calcShadowColor("Top box background color")
        )

        currentIndex = currentIndex + 1
    end
end

function DrawingUtils.drawVerticalBarGraph(
    position,
    size,
    dataSet,
    headingText,
    borderColorKey,
    textBarColorKey,
    graphPadding,
    maxValue)
    local borderColor = DrawingUtils.convertColorKeyToColor(borderColorKey)
    local textBarColor = DrawingUtils.convertColorKeyToColor(textBarColorKey)
    local x, y = position.x, position.y
    local width, height = size.width, size.height
    local topPoint = {
        ["x"] = x + graphPadding,
        ["y"] = y + graphPadding
    }
    local bottomLeftPoint = {
        ["x"] = x + graphPadding,
        ["y"] = y + height - graphPadding
    }
    local bottomRightPoint = {
        ["x"] = x + width - graphPadding,
        ["y"] = y + height - graphPadding
    }

    gui.drawLine(topPoint.x, topPoint.y, bottomLeftPoint.x, bottomLeftPoint.y, borderColor)
    gui.drawLine(bottomLeftPoint.x, bottomLeftPoint.y, bottomRightPoint.x, bottomRightPoint.y, borderColor)

    local textLength = DrawingUtils.calculateWordPixelLength(headingText)
    local textX = x + graphPadding + ((width - 2 * graphPadding - textLength) / 2)
    local style =
        TextStyle(
        Graphics.FONT.DEFAULT_FONT_SIZE,
        Graphics.FONT.DEFAULT_FONT_FAMILY,
        "Top box text color",
        "Top box background color"
    )

    DrawingUtils.drawText(textX, y - 3, headingText, style, DrawingUtils.calcShadowColor("Top box background color"))

    local totalBars = 0
    for _, _ in pairs(dataSet) do
        totalBars = totalBars + 1
    end
    local barWidth = (width - 2 * graphPadding) / (totalBars + (totalBars / 2) + (1 / 2))
    local spacing = barWidth / 2
    local currentIndex = 0
    --basically leave some room
    local topValue = maxValue * 1.25
    local verticalDistance = math.abs(topPoint.y - bottomRightPoint.y)
    for _, dataEntry in pairs(dataSet) do
        local name, value = dataEntry[1], dataEntry[2]
        local barX = math.floor(spacing + topPoint.x + ((spacing + barWidth) * currentIndex))
        local verticalDistanceFraction = verticalDistance * (value / topValue)
        local barY = bottomRightPoint.y - verticalDistanceFraction

        gui.drawRectangle(barX, barY, barWidth, verticalDistanceFraction, textBarColor, textBarColor)

        value = tostring(value)
        local nameLength = DrawingUtils.calculateWordPixelLength(name)
        local valueLength = DrawingUtils.calculateWordPixelLength(value)
        local nameX = (barX + (barWidth - nameLength) / 2) - 1
        local valueX = (barX + (barWidth - valueLength) / 2) - 1

        DrawingUtils.drawText(valueX, barY - 12, value, style, DrawingUtils.calcShadowColor("Top box background color"))
        DrawingUtils.drawText(
            nameX,
            bottomRightPoint.y + 2,
            name,
            style,
            DrawingUtils.calcShadowColor("Top box background color")
        )

        currentIndex = currentIndex + 1
    end
end

function DrawingUtils.drawText(x, y, text, textStyle, shadowColor, justifiable, justifiedSpacing)
    local drawShadow = settings.colorSettings["Draw shadows"] and not settings.colorSettings["Transparent backgrounds"]
    local color = DrawingUtils.convertColorKeyToColor(textStyle.getTextColorKey())
    local spacing = 0
    if appearanceSettings.RIGHT_JUSTIFIED_NUMBERS and justifiable then
        if text == "?" then
            spacing = 10
        end
        if text == "---" then
            if justifiedSpacing == 3 then
                spacing = 8
            elseif justifiedSpacing == 2 then
                spacing = 3
            end
        elseif text == "WT" or text == "HP" then
            spacing = 3
        elseif text == "ITM" then
            spacing = 2
        else
            local number = tonumber(text)
            if number ~= nil then
                spacing = (justifiedSpacing - string.len(tostring(number))) * 5
            end
        end
    end
    if drawShadow then
        gui.drawText(x + spacing + 1, y + 1, text, shadowColor, nil, textStyle.getFontSize(), textStyle.getFontFamily())
    end
    local bolded = textStyle.isBolded()
    gui.drawText(x + spacing, y, text, color, nil, textStyle.getFontSize(), textStyle.getFontFamily(), bolded)
end

local function getPokemonPath(pokemonID, currentIconSet)
    local pokemonData = PokemonData.POKEMON[pokemonID + 1]
    local pokemonIDPath = tostring(pokemonID)
    local folderPath = Paths.FOLDERS.POKEMON_ICONS_FOLDER .. "/" .. currentIconSet.FOLDER_NAME .. "/"
    local extension = currentIconSet.FILE_EXTENSION
    local usingAnimated = settings.appearance.ICON_SET_INDEX == 5
    if usingAnimated then
        pokemonIDPath = string.format("%03d", pokemonID)
    end
    if pokemonData.baseFormData then
        local baseFormData = pokemonData.baseFormData
        if PokemonData.ALTERNATE_FORMS[baseFormData.baseFormName] then
            local index = baseFormData.alternateFormIndex
            pokemonIDPath = "alternateForms/" .. baseFormData.baseFormName .. "/" .. index
            if usingAnimated then
                pokemonIDPath = baseFormData.baseFormIndex .. "_" .. index
            end
            if not FormsUtils.fileExists(folderPath .. pokemonIDPath .. extension) then
                pokemonID = baseFormData.baseFormIndex
                pokemonIDPath = string.format("%03d", pokemonID)
            end
        end
    end
    return folderPath .. pokemonIDPath .. extension
end

function DrawingUtils.readPokemonIDIntoImageLabel(currentIconSet, pokemonID, imageLabel, shouldChangeDirection)
    imageLabel.setOffset(currentIconSet.IMAGE_OFFSET)
    local path = getPokemonPath(pokemonID, currentIconSet)
    imageLabel.setPath(path)
    local usingAnimated = settings.appearance.ICON_SET_INDEX == 5
    if not usingAnimated then
        imageLabel.setImageRegionOffset({x = 0, y = -0})
        imageLabel.setOffset(currentIconSet.IMAGE_OFFSET)
    end
    AnimatedSpriteManager.addPokemonImage(imageLabel, pokemonID, usingAnimated, shouldChangeDirection)
end

function DrawingUtils.convertColorKeyToColor(colorKey, transparentOverride)
    local transparentKeys = {
        ["Main background color"] = true,
        ["Top box background color"] = true,
        ["Bottom box background color"] = true
    }
    if settings.colorSettings["Transparent backgrounds"] and transparentKeys[colorKey] then
        return 0xFF000000
    end
    if not settings.colorScheme[colorKey] and colorKey == "Alternate positive text color" then
        colorKey = "Positive text color"
    end
    if not settings.colorScheme[colorKey] and colorKey == "Alternate negative text color" then
        colorKey = "Negative text color"
    end
    local color = settings.colorScheme[colorKey]
    if color == nil then
        color = Graphics.TYPE_COLORS[colorKey]
    end
    return color
end

function DrawingUtils.calcShadowColor(colorKey, veryDark, colorCode)
    if colorKey == nil then
        return 0x00000000
    end
    local color = colorCode
    if color == nil then
        color = settings.colorScheme[colorKey]
    end
    local color_hexval = (color - 0xFF000000)

    local r = bit.rshift(color_hexval, 16)
    local g = bit.rshift(bit.band(color_hexval, 0x00FF00), 8)
    local b = bit.band(color_hexval, 0x0000FF)

    local multiplier = .92

    if veryDark then
        multiplier = .88
    end

    r = math.max(r * multiplier, 0)
    g = math.max(g * multiplier, 0)
    b = math.max(b * multiplier, 0)

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
    gui.drawLine(position.x, position.y + 2, center.x, center.y, color)
    gui.drawLine(center.x, center.y, position.x + 4, position.y + 2, color)
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
        local colorState = math.floor((statStage + chevron.start) / 3) + 1
        local position = chevron.position
        if direction == "up" then
            position.y = position.y - 1
        end
        DrawingUtils.drawChevron(direction, position, colorStates[colorState])
    end
end

function DrawingUtils.drawMoveEffectiveness(position, effectiveness)
    if effectiveness ~= 1.0 then
        local x, y = position.x, position.y
        if effectiveness == 2 then
            drawChevronUp({x = x, y = y + 2}, "Alternate positive text color")
        elseif effectiveness == 4 then
            drawChevronUp({x = x, y = y + 2}, "Alternate positive text color")
            drawChevronUp({x = x, y = y}, "Alternate positive text color")
        elseif effectiveness == 0.5 then
            drawChevronDown({x = x, y = y, 4}, "Alternate negative text color")
        elseif effectiveness == 0.25 then
            drawChevronDown({x = x, y = y, 4}, "Alternate negative text color")
            drawChevronDown({x = x, y = y + 2}, "Alternate negative text color")
        elseif effectiveness == 0 then
            DrawingUtils.drawText(
                x,
                y,
                "X",
                TextStyle(
                    7,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Alternate negative text color",
                    "Bottom box background color"
                ),
                DrawingUtils.convertColorKeyToColor("Bottom box background color")
            )
        end
    end
end

function DrawingUtils.drawNaturePlusMinus(position, affect)
    local color = "Positive text color"
    local text = "+"
    if affect == "minus" then
        text = "---"
        color = "Negative text color"
    end
    DrawingUtils.drawText(
        position.x,
        position.y,
        text,
        TextStyle(5, Graphics.FONT.DEFAULT_FONT_FAMILY, color, "Top box background color"),
        DrawingUtils.convertColorKeyToColor("Top box background color")
    )
end

function DrawingUtils.getNatureColor(stat, nature)
    local neutral = "Top box text color"
    local increase = "Positive text color"
    local decrease = "Negative text color"

    local color = neutral
    if nature % 6 == 0 then
        color = neutral
    elseif stat == "ATK" then
        if nature < 5 then
            color = increase
        elseif nature % 5 == 0 then
            color = decrease
        end
    elseif stat == "DEF" then
        if nature > 4 and nature < 10 then
            color = increase
        elseif nature % 5 == 1 then
            color = decrease
        end
    elseif stat == "SPE" then
        if nature > 9 and nature < 15 then
            color = increase
        elseif nature % 5 == 2 then
            color = decrease
        end
    elseif stat == "SPA" then
        if nature > 14 and nature < 20 then
            color = increase
        elseif nature % 5 == 3 then
            color = decrease
        end
    elseif stat == "SPD" then
        if nature > 19 then
            color = increase
        elseif nature % 5 == 4 then
            color = decrease
        end
    end
    return color
end

function DrawingUtils.drawExperienceBar(x, y, percent)
    local width = 61
    local multiplier = math.min(1, percent)
    local expBarWidth = math.floor((width - 4) * multiplier)
    local outlineColor = DrawingUtils.convertColorKeyToColor("Top box border color")
    local expBarColor = DrawingUtils.convertColorKeyToColor("Positive text color")
    local darkenedExpColor = DrawingUtils.calcShadowColor("Positive text color", true)
    gui.drawRectangle(x + 1, y, width - 2, 3, outlineColor, nil)
    gui.drawRectangle(x, y + 1, 0, 1, outlineColor, outlineColor)
    gui.drawRectangle(x + width, y + 1, 0, 1, outlineColor, outlineColor)
    if expBarWidth > 0 then
        gui.drawRectangle(x + 2, y + 2, expBarWidth, 0, expBarColor, expBarColor)
        gui.drawRectangle(x + 2, y + 1, expBarWidth, 0, darkenedExpColor, darkenedExpColor)
    end
end

function DrawingUtils.drawExtraMainScreenStuff(extraThingsToDraw)
    if extraThingsToDraw.experienceBar ~= nil then
        local x, y, percent =
            extraThingsToDraw.experienceBar.x - 1,
            extraThingsToDraw.experienceBar.y,
            extraThingsToDraw.experienceBar.percent
        DrawingUtils.drawExperienceBar(x, y, percent)
    elseif extraThingsToDraw.friendshipBar ~= nil then
        local x, y, progress =
            extraThingsToDraw.friendshipBar.x,
            extraThingsToDraw.friendshipBar.y,
            extraThingsToDraw.friendshipBar.progress
        if progress < 1 then
            IconDrawer.drawFriendshipProgress(x, y, progress)
        else
            local style =
                TextStyle(
                Graphics.FONT.DEFAULT_FONT_SIZE,
                Graphics.FONT.DEFAULT_FONT_FAMILY,
                "Positive text color",
                "Top box background color"
            )
            DrawingUtils.drawText(x - 2, y - 3, "READY", style, DrawingUtils.calcShadowColor("Top box background color"))
        end
    end
    if extraThingsToDraw.statStages ~= nil then
        for _, statStageInfo in pairs(extraThingsToDraw.statStages) do
            DrawingUtils.drawStatStageChevrons(statStageInfo.position, statStageInfo.stage)
        end
    end
    if extraThingsToDraw.moveEffectiveness ~= nil then
        for _, entry in pairs(extraThingsToDraw.moveEffectiveness) do
            DrawingUtils.drawMoveEffectiveness(entry.position, entry.effectiveness)
        end
    end
    if extraThingsToDraw.nature ~= nil then
        for _, entry in pairs(extraThingsToDraw.nature) do
            DrawingUtils.drawNaturePlusMinus(entry.position, entry.effect)
        end
    end
    if extraThingsToDraw.status ~= nil then
        local statusImage =
            ImageField(extraThingsToDraw.status.statusImagePath, extraThingsToDraw.status.position, {width = 16, height = 8})
        statusImage.move({x = 0, y = 0})
        statusImage.show()
    end
end

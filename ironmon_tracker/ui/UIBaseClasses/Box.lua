local function Box(initialPosition, initialSize, initialBGColorKey, initialBGFillColorKey)
    local self = {}
    local relativePosition = initialPosition
    local position = initialPosition
    local size = nil
    if initialSize ~= nil then
        size = initialSize
    end
    local backgroundColorKey = initialBGColorKey
    local backgroundFillColorKey = initialBGFillColorKey

    function self.move(newPosition)
        position.x = newPosition.x
        position.y = newPosition.y
    end

    function self.calculateActualPosition(parentPosition)
        position = {
            x = parentPosition.x + relativePosition.x,
            y = parentPosition.y + relativePosition.y
        }
    end

    function self.shift(xAmount, yAmount)
        relativePosition = {
            x = relativePosition.x + xAmount,
            y = relativePosition.y + yAmount
        }
    end

    function self.getPosition()
        return position
    end

    function self.getSize()
        return size
    end

    function self.resize(newSize)
        size.width = newSize.width
        size.height = newSize.height
    end

    function self.getBackgroundColor()
        if size ~= nil and backgroundColorKey ~= nil then
            return DrawingUtils.convertColorKeyToColor(backgroundColorKey)
        else
            return 0x00000000
        end
    end

    function self.getBackgroundFillColor()
        if backgroundFillColorKey ~= nil and size ~= nil then
            return DrawingUtils.convertColorKeyToColor(backgroundFillColorKey)
        else
            return 0x00000000
        end
    end

    function self.show()
        if size ~= nil then
            gui.drawRectangle(
                position.x,
                position.y,
                size.width,
                size.height,
                self.getBackgroundFillColor(),
                self.getBackgroundColor()
            )
        end
    end

    return self
end

return Box

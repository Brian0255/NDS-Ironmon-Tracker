local function Component(initialFrame, initialBox)
    local self = {}

    local frame = initialFrame
    local box = initialBox

    function self.calculateActualPosition(position)
        box.calculateActualPosition(position)
    end

    function self.show()
        box.show()
    end

    function self.getSize()
        return box.getSize()
    end

    function self.getFrame()
        return frame
    end

    function self.getPosition()
        return box.getPosition()
    end

    function self.resize(newSize)
        box.resize(newSize)
    end

    function self.move(newPosition)
        box.move(newPosition)
    end

    function self.shift(xAmount, yAmount)
        box.shift(xAmount, yAmount)
    end

    return self
end

return Component

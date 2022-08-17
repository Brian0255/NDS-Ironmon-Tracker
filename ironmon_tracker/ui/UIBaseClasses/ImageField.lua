local function ImageField(initialPath, initialOffset, initialSize)
    local self = {}
    local path = initialPath
    local size = initialSize
    local offset = initialOffset
    local position = nil
    function self.move(parentPosition)
        position = {
            x = parentPosition.x + offset.x,
            y = parentPosition.y + offset.y
        }
    end
    function self.show()
        if initialSize ~= nil and position ~= nil then
            gui.drawImage(path, position.x, position.y, size.width, size.height)
        else
            gui.drawImage(path, position.x, position.y)
        end
    end
    function self.setPath(newPath)
        path = newPath
    end
    return self
end

return ImageField

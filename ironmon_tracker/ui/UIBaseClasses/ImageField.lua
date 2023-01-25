local function ImageField(initialPath, initialOffset, initialSize)
    local self = {}
    local path = initialPath
    local size = initialSize
    local offset = initialOffset
    local position = nil
    function self.move(parentPosition)
        position = {
            x = parentPosition.x,
            y = parentPosition.y
        }
    end
    function self.show()
        if FormsUtils.fileExists(path) then
            if initialSize ~= nil and position ~= nil then
                gui.drawImage(path, position.x + offset.x, position.y + offset.y, size.width, size.height)
            else
                gui.drawImage(path, position.x + offset.x, position.y + offset.y)
            end
        end
    end
    function self.setOffset(newOffset)
        offset = {
            x = newOffset.x,
            y = newOffset.y
        }
    end
    function self.getPath()
        return path
    end
    function self.setPath(newPath)
        path = newPath
    end
    return self
end

return ImageField

local function ImageField(initialPath, initialOffset, initialSize, initialImageRegionSize, initialImageRegionOffset)
    local self = {}
    local path = initialPath
    local size = initialSize or {width = nil, height = nil}
    local offset = initialOffset
    local position = nil
    local imageRegionOffset = initialImageRegionOffset
    local imageRegionSize = initialImageRegionSize
    function self.move(parentPosition)
        position = {
            x = parentPosition.x,
            y = parentPosition.y
        }
    end
    function self.show()
        if FormsUtils.fileExists(path) then
            if position == nil then
                return
            end
            if imageRegionOffset == nil or imageRegionSize == nil then
                gui.drawImage(path, position.x + offset.x, position.y + offset.y)
            else
                gui.drawImageRegion(
                    path,
                    imageRegionOffset.x,
                    imageRegionOffset.y,
                    imageRegionSize.width,
                    imageRegionSize.height,
                    position.x + offset.x,
                    position.y + offset.y
                )
            end
        end
    end
    function self.setImageRegionSize(newSize)
        imageRegionSize = {width = newSize.width, height = newSize.height}
    end
    function self.setImageRegionOffset(newOffset)
        imageRegionOffset = {x = newOffset.x, y = newOffset.y}
    end
    function self.setOffset(newOffset)
        offset = {
            x = newOffset.x,
            y = newOffset.y
        }
    end
    function self.getOffset()
        return {x = offset.x, y = offset.y}
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

local function DragDropEventListener(initialControl, initialOnDrop, initialOnDropParams, initialDrawFunction)
    local self = {}
    local onDrop = initialOnDrop
    local onDropParams = initialOnDropParams
    local control = initialControl
    local initialMousePos = Input.getMousePosition()
    local initialControlPos = control.getPosition()
    local drawFunction = initialDrawFunction
    local currentFrames = 0
    local prevBorder = control.getBackgroundFillColorKey()
    local prevOpacity = control.getOpacity()
    control.setBackgroundFillColorKey("Positive text color")
    control.setOpacity(0xFF)

    function self.listen()
        if not Input.getMouse()["Middle"] then
            control.setBackgroundFillColorKey(prevBorder)
            control.setOpacity(prevOpacity)
            onDrop(onDropParams)
        end
        local currentMousePos = Input.getMousePosition()
        local difference = {x = currentMousePos.x - initialMousePos.x, y = currentMousePos.y - initialMousePos.y}
        local newControlPos = {x = initialControlPos.x + difference.x, y = initialControlPos.y + difference.y}
        local controlSize = control.getSize()
        newControlPos.x = math.max(newControlPos.x, 0)
        newControlPos.x = math.min(newControlPos.x, Graphics.SIZES.SCREEN_WIDTH - controlSize.width)
        newControlPos.y = math.max(newControlPos.y, 0)
        newControlPos.y = math.min(newControlPos.y, 2 * Graphics.SIZES.SCREEN_HEIGHT - controlSize.height - 1)
        control.move(newControlPos)
        currentFrames = currentFrames + 1
        if currentFrames == 5 then
            drawFunction()
            currentFrames = 0
        end
    end
    return self
end

return DragDropEventListener

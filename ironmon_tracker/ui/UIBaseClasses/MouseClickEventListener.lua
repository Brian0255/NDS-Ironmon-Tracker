local function MouseClickEventListener(initialControl, onClickFunction, initialOnClickParams)
    local self = {}
    local onClick = onClickFunction
    local onClickParams = initialOnClickParams
    local control = initialControl
    local previouslyPressed = nil
    function self.getOnClickParams()
        return onClickParams
    end
    function self.setOnClickParams(newParams)
        onClickParams = newParams
    end
    function self.listen()
        local inRange = true
        if control ~= nil and control.isVisible() then
            local mousePosition = Input.getMousePosition()
            local position = control.getPosition()
            local size = control.getSize()
            inRange =
                MiscUtils.mouseInRange(
                mousePosition.x,
                mousePosition.y,
                position.x,
                position.y,
                size.width,
                size.height
            )
        else
            inRange = false
        end
        local leftPress = Input.getMouse()["Left"]
        if previouslyPressed ~= nil then
            if leftPress and not previouslyPressed and inRange then
                onClick(onClickParams)
            end
        end
        previouslyPressed = leftPress
    end
    return self
end

return MouseClickEventListener

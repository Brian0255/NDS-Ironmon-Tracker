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
        if control ~= nil then
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
        end
        local leftPress = input.getmouse()["Left"]
        if previouslyPressed ~= nil then
            if previouslyPressed and not leftPress and inRange then
                onClick(onClickParams)
            end
        end
        previouslyPressed = leftPress
    end
    return self
end

return MouseClickEventListener

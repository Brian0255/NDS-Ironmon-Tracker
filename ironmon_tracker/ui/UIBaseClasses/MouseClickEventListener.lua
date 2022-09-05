local function MouseClickEventListener(control, onClickFunction, initialOnClickParams)
    local self = {}
    local onClick = onClickFunction
    local onClickParams = initialOnClickParams
    local previouslyPressed = nil
    function self.getOnClickParams()
        return onClickParams
    end
    function self.setOnClickParams(newParams)
        onClickParams = newParams
    end
    function self.listen()
        local position = control.getPosition()
        local size = control.getSize()
        local mousePosition = Input.getMousePosition()
        local leftPress = input.getmouse()["Left"]
        local inRange =
            MiscUtils.mouseInRange(mousePosition.x, mousePosition.y, position.x, position.y, size.width, size.height)
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

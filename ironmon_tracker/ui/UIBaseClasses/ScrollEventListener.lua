local function ScrollEventListener(initialControl, onScrollFunction, initialOnScrollParams, initialScrollDirection)
    local self = {}
    local onScroll = onScrollFunction
    local onScrollParams = initialOnScrollParams
    local control = initialControl
    local direction = initialScrollDirection
    function self.getOnScrollParams()
        return onScrollParams
    end
    function self.setOnScrollParams(newParams)
        onScrollParams = newParams
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
        if inRange then
            local scrollChange = Input.getScrollWheelChange()
            if direction == Graphics.SCROLL_DIRECTION.DOWN and scrollChange <= -100 then
                onScroll()
            elseif direction == Graphics.SCROLL_DIRECTION.UP and scrollChange >= 100 then
                onScroll()
            end
        end
    end
    return self
end

return ScrollEventListener

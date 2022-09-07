local function HoverEventListener(
    control,
    onHoverFunction,
    initialOnHoverParams,
    onHoverEndFunction,
    initialOnHoverEndParams)
    local self = {}
    local onHover = onHoverFunction
    local onHoverParams = initialOnHoverParams
    local onHoverEnd = onHoverEndFunction
    local onHoverEndParams = initialOnHoverEndParams
    local framesWaited = 0
    local hoverActive = false
    local baseWaitAmount = 30
    local clientFrameRate = client.get_approx_framerate()
    if clientFrameRate > 60 then
        baseWaitAmount = baseWaitAmount * (clientFrameRate / 60)
    end
    function self.setOnHoverParams(newParams)
        onHoverParams = newParams
    end
    function self.getOnHoverParams()
        return onHoverParams
    end
    function self.setOnHoverEndParams(newParams)
        onHoverEndParams = newParams
    end
    function self.getOnHoverEndParams()
        return onHoverEndParams
    end
    function self.listen()
        local position = control.getPosition()
        local size = control.getSize()
        local mousePosition = Input.getMousePosition()
        local inRange =
            MiscUtils.mouseInRange(mousePosition.x, mousePosition.y, position.x, position.y, size.width, size.height)
        if not hoverActive then
            if inRange then
                framesWaited = framesWaited + 1
                if framesWaited == 30 then
                    onHover(onHoverParams)
                    hoverActive = true
                end
            else
                framesWaited = 0
            end
        else
            if not inRange then
                onHoverEnd(onHoverEndParams)
                hoverActive = false
            end
        end
    end
    return self
end

return HoverEventListener

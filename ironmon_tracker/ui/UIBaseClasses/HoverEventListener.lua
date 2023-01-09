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
    local currentWaitAmount = baseWaitAmount
    function self.reset()
        hoverActive = false
        framesWaited = 0
    end
    function self.activateOnHover()
        onHover(onHoverParams)
    end
    function self.getControl()
        return control
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
    function self.setBackToZero()
        framesWaited = 0
    end
    local function resetCurrentAmount()
        local clientFrameRate = client.get_approx_framerate()
        if clientFrameRate ~= nil then
            if clientFrameRate > 60 then
                currentWaitAmount = math.floor(baseWaitAmount * (clientFrameRate / 60))
            end
        else
            currentWaitAmount = baseWaitAmount
        end
    end
    resetCurrentAmount()
    function self.listen()
        local position = control.getPosition()
        local size = control.getSize()
        local mousePosition = Input.getMousePosition()
        local inRange =
            MiscUtils.mouseInRange(mousePosition.x, mousePosition.y, position.x, position.y, size.width, size.height)
        if not hoverActive then
            if inRange then
                framesWaited = framesWaited + 1
                if framesWaited == currentWaitAmount then
                    onHover(onHoverParams)
                    hoverActive = true
                    resetCurrentAmount()
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

local function FrameCounter(frameAmount, onZeroEvent, onZeroParams, syncWithClient)
    local self = {}
    local totalFrames = frameAmount
    local currentFrames = totalFrames
    local paused = false
    if syncWithClient == nil then
        syncWithClient = false
    end
    local function reset()
        currentFrames = totalFrames
        if syncWithClient then
            --throttle if it's > 60 to cut down on lag
            local clientFrameRate = client.get_approx_framerate()
            if clientFrameRate ~= nil and clientFrameRate > 60 then
                currentFrames = math.floor(totalFrames * (clientFrameRate / 60))
            end
        end
    end
    function self.reset()
        reset()
    end
    function self.pause()
        paused = true
    end
    function self.resume()
        paused = false
    end
    function self.decrement()
        currentFrames = currentFrames - 1
        if currentFrames <= 0 then
            reset()
            if not paused then
                onZeroEvent(onZeroParams)
            end
        end
    end
    function self.setFrames(newFrames)
        totalFrames = newFrames
        reset()
    end
    reset()
    return self
end

return FrameCounter

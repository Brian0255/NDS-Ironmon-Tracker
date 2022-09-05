local function FrameCounter(frameAmount, onZeroEvent, onZeroParams, syncWithClient)
    local self = {}
    local totalFrames = frameAmount
    local currentFrames = totalFrames
    if syncWithClient == nil then
        syncWithClient = false
    end
    function self.decrement()
        currentFrames = currentFrames - 1
        if currentFrames <= 0 then
            currentFrames = totalFrames
            if syncWithClient then
                --throttle if it's > 60 to cut down on lag
                local clientFrameRate = client.get_approx_framerate()
                if clientFrameRate > 60 then
                    currentFrames = totalFrames * (clientFrameRate / 60)
                end
            end
            onZeroEvent(onZeroParams)
        end
    end
    return self
end

return FrameCounter

local function FrameCounter(frameAmount, onZeroEvent, onZeroParams)
    local self = {}
    local totalFrames = frameAmount
    local currentFrames = totalFrames
    function self.decrement()
        currentFrames = currentFrames - 1
        if currentFrames == 0 then
            currentFrames = totalFrames
            onZeroEvent(onZeroParams)
        end
    end
    return self
end

return FrameCounter
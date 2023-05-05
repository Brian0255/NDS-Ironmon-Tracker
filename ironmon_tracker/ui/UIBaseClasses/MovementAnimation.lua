local function MovementAnimation(initialControl, initialStartPos, initialEndPos, initialFrameTotal, initialFrameInterval, initialDrawFunction, initialOnEndFunction)
    local self = {}

    local FrameCounter = dofile(Paths.FOLDERS.DATA_FOLDER.."/FrameCounter.lua")

    local control = initialControl
    local startPos = initialStartPos
    local endPos = initialEndPos
    local frameTotal = initialFrameTotal
    local frameInterval = initialFrameInterval
    local framesPassed = 0
    local drawFunction = initialDrawFunction
    local onEnd = initialOnEndFunction

    local function checkCompleted()
        if framesPassed == frameTotal then
            control.move({x = endPos.x, y = endPos.y})
            onEnd()
        end
    end

    local function calculateDistancePercentage()
        --use quadratic easing
        local timePercentagePassed = framesPassed / frameTotal
        return (timePercentagePassed ^ 2) / 1
    end

    local function onFrameIntervalUpdate()
        local xDiff, yDiff = endPos.x - startPos.x, endPos.y - startPos.y
        framesPassed = math.min(framesPassed + frameInterval, frameTotal)
        local distancePercentage = calculateDistancePercentage()
        xDiff = xDiff * distancePercentage
        yDiff = yDiff * distancePercentage
        control.move({x = startPos.x + xDiff, y = startPos.y + yDiff})
        drawFunction()
        checkCompleted()
    end

    local frameCounter = FrameCounter(frameInterval, onFrameIntervalUpdate, nil, true)

    function self.update()
        frameCounter.decrement()
    end

    return self
end

return MovementAnimation
local ScreenStack = function(initialScreenSet)
    local self = {}
    local currentIndex = 1
    local screenSet = initialScreenSet

    function self.reset()
        currentIndex = 1
    end

    function self.setCurrentIndex(newIndex)
        currentIndex = newIndex
    end

    function self.show()
        screenSet[currentIndex].show()
    end

    function self.getScreens()
        return screenSet
    end

    function self.runEventListeners()
        screenSet[currentIndex].runEventListeners()
    end

    return self
end

return ScreenStack
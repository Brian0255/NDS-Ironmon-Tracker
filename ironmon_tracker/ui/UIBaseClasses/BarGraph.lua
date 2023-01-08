local function BarGraph(initialComponent, initialDataSet, initialHeadingText, initialBorderColorKey, initialTextBarColorKey, initialGraphPadding, initialMaxValue)
    local self = {}
    local component = initialComponent
    local dataSet = initialDataSet
    local headingText = initialHeadingText
    local borderColorKey = initialBorderColorKey
    local textBarColorKey = initialTextBarColorKey
    local padding = initialGraphPadding
    local maxValue = initialMaxValue
    local visible = true

    function self.setDataSet(newDataSet)
        dataSet = newDataSet
    end

    function self.setHeadingText(newHeadingText)
        headingText = newHeadingText
    end

    function self.calculateActualPosition(position)
        component.calculateActualPosition(position)
    end

    function self.show()
        DrawingUtils.drawBarGraph(component.getPosition(), component.getSize(), dataSet, headingText, borderColorKey, textBarColorKey, padding, maxValue)
    end

    function self.getSize()
        return component.getSize()
    end

    function self.isVisible()
        return visible
    end

    function self.setVisibility(newVisibility)
        visible = newVisibility
    end

    function self.getPosition()
        return component.getPosition()
    end
    
    function self.resize(newSize)
        component.resize(newSize)
    end

    function self.move(newPosition)
        component.move(newPosition)
    end

    function self.shift(xAmount, yAmount)
        component.shift(xAmount, yAmount)
    end
    component.getFrame().addControl(self)

    return self
end

return BarGraph
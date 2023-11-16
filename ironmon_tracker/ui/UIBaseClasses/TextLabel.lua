local function TextLabel(
    initialComponent,
    initialTextField,
    initialVisibility,
    initialRadioGroupTable,
    initialRadioGroupKey,
    initialRadioState)
    local self = {}
    local component = initialComponent
    local textField = initialTextField
    local visible = initialVisibility
    local radioGroupTable = initialRadioGroupTable
    local radioGroupKey = initialRadioGroupKey
    local radioState = initialRadioState

    if visible == nil then
        visible = true
    end

    local function changeFromRadioState()
        if radioGroupTable == nil then
            return
        end
        local newFill = "Top box background color"
        local newTextColor = "Top box text color"
        if radioGroupTable[radioGroupKey] == radioState then
            newFill = "Top box border color"
            newTextColor = "Positive text color"
        end
        self.setBackgroundFillColorKey(newFill)
        self.setTextColorKey(newTextColor)
    end

    function self.onRadioClick()
        radioGroupTable[radioGroupKey] = radioState
    end

    function self.setText(newText)
        textField.setText(newText)
    end

    function self.getText()
        return textField.getText()
    end

    function self.move(newPosition)
        component.move(newPosition)
        textField.move(newPosition)
    end

    function self.shift(xAmount, yAmount)
        component.shift(xAmount, yAmount)
    end

    function self.setVisibility(newVisibility)
        visible = newVisibility
    end

    function self.isVisible()
        return visible
    end

    function self.setTextOffset(newOffset)
        textField.setTextOffset(newOffset)
    end

    function self.setBackgroundColorKey(newColorKey)
        component.setBackgroundColorKey(newColorKey)
    end

    function self.setBackgroundFillColorKey(newColorKey)
        component.setBackgroundFillColorKey(newColorKey)
    end

    function self.getBackgroundFillColorKey()
        return component.getBackgroundFillColorKey()
    end

    function self.getZIndex()
        return component.getZIndex()
    end

    function self.show()
        if visible then
            changeFromRadioState()
            component.show()
            textField.show()
        end
    end

    function self.resize(newSize)
        component.resize(newSize)
    end

    function self.calculateActualPosition(parentPosition)
        component.calculateActualPosition(parentPosition)
        textField.move(component.getPosition())
    end

    function self.setTextColorKey(newTextColorKey)
        textField.setTextColorKey(newTextColorKey)
    end

    function self.setShadowColorKey(newShadowColorKey)
        textField.setShadowColorKey(newShadowColorKey)
    end

    function self.setOpacity(newOpacity)
        component.setOpacity(newOpacity)
    end

    function self.getOpacity()
        return component.getOpacity()
    end

    function self.getPosition()
        return component.getPosition()
    end

    function self.getSize()
        return component.getSize()
    end

    component.getFrame().addControl(self)

    return self
end

return TextLabel

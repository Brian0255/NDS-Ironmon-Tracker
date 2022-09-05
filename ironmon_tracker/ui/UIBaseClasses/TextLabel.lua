local function TextLabel(initialComponent, initialTextField, isJustifiable, initialVisibility)
    local self = {}
    local component = initialComponent
    local textField = initialTextField
    local visible = initialVisibility
    if visible == nil then
        visible = true
    end
    function self.setText(newText)
        textField.setText(newText)
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
    function self.show()
        if visible then
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

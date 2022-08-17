local function ImageLabel(initialComponent, initialImageField, initialVisibility)
    local self = {}
    local component = initialComponent
    local imageField = initialImageField
    local visible = initialVisibility
    if visible == nil then
        visible = true
    end
    function self.show()
        if visible then
            component.show()
            imageField.show()
        end
    end
    function self.setVisibility(newVisibility)
        visible = newVisibility
    end
    function self.isVisible()
        return visible
    end
    function self.calculateActualPosition(parentPosition)
        component.calculateActualPosition(parentPosition)
        imageField.move(component.getPosition())
    end
    function self.setPath(newPath)
        imageField.setPath(newPath)
    end
    function self.move(newPosition)
        component.move(newPosition)
        imageField.move(component.getPosition())
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

return ImageLabel

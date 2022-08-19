local function Icon(initialComponent, initialIconName, initialIconOffset, initialVisibility)
    local self = {}
    local component = initialComponent
    local iconName = initialIconName
    local iconOffset = initialIconOffset
    local visible = initialVisibility
    if visible == nil then
        visible = true
    end
    function self.show()
        if visible then
            component.show()
            local position = component.getPosition()
            IconDrawer.drawIcon(iconName, position.x + iconOffset.x, position.y + iconOffset.y)
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
    end
    function self.setIconName(newIconName)
        iconName = newIconName
    end
    function self.move(newPosition)
        component.move(newPosition)
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

return  Icon

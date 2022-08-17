local function Frame(initialBox, initialLayout, initialFrame, initialVisibility)
    local self = {}
    local layout = initialLayout
    local box = initialBox
    local parentFrame = initialFrame
    local visible = initialVisibility
    if visible == nil then
        visible = true
    end
    local controls = {}
    function self.calculateActualPosition(position)
        box.calculateActualPosition(position)
    end
    function self.changeParentFrame(newFrame, newIndex)
        parentFrame.removeControl(self)
        parentFrame = newFrame
        parentFrame.addControl(self, newIndex)
    end
    function self.addControl(control, newIndex)
        if newIndex ~= nil then
            table.insert(controls,newIndex,control)
        else
            table.insert(controls, control)
        end
    end
    function self.removeControl(control)
        for i, c in pairs(controls) do
            if c == control then
                table.remove(controls,i)
            end
        end
    end
    function self.resize(newSize)
        box.resize(newSize)
    end
    function self.getPosition()
        return box.getPosition()
    end
    function self.getSize()
        return box.getSize()
    end
    function self.setVisibility(newVisibility)
        visible = newVisibility
    end
    function self.isVisible()
        return visible
    end
    function self.move(newPosition)
        box.move(newPosition)
    end
    function self.shift(xAmount, yAmount)
        box.shift(xAmount, yAmount)
    end
    function self.setLayoutAlignment(newAlignment)
        layout.setAlignment(newAlignment)
    end
    function self.show()
        if visible then
            box.show()
            if layout ~= nil then
                layout.setFrame(self)
                layout.setItems(controls)
                layout.changeItemPositions()
            else
                for _, control in pairs(controls) do
                    control.calculateActualPosition(self.getPosition())
                end
            end
            for _, control in pairs(controls) do
                control.show()
            end
        end
    end
    if parentFrame ~= nil then
        parentFrame.addControl(self)
    end
    return self
end

return Frame

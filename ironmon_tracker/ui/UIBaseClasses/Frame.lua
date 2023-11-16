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
    function self.recalculateChildPositions()
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
            if control.recalculateChildPositions then
                control.recalculateChildPositions()
            end
        end
    end
    function self.calculateActualPosition(position)
        box.calculateActualPosition(position)
    end
    function self.setBackgroundColorKey(newColorKey)
        box.setBackgroundColorKey(newColorKey)
    end
    function self.setBackgroundFillColorKey(newColorKey)
        box.setBackgroundFillColorKey(newColorKey)
    end
    function self.changeParentFrame(newFrame, newIndex)
        if parentFrame ~= nil then
            parentFrame.removeControl(self)
        end
        parentFrame = newFrame
        parentFrame.addControl(self, newIndex)
    end
    function self.addControl(control, newIndex)
        if newIndex ~= nil then
            table.insert(controls, newIndex, control)
        else
            table.insert(controls, control)
        end
    end
    function self.removeControl(control)
        for i, c in pairs(controls) do
            if c == control then
                table.remove(controls, i)
            end
        end
    end
    function self.clearAllChildren()
        for _, control in pairs(controls) do
            if control.clearAllChildren then
                control.clearAllChildren()
            end
        end
        controls = {}
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
        if type(visible) == "function" then
            return visible()
        end
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
    function self.setLayoutSpacing(newSpacing)
        layout.setSpacing(newSpacing)
    end
    function self.setLayoutPadding(newPadding)
        layout.setPadding(newPadding)
    end
    function self.getZIndex()
        return box.getZIndex()
    end
    function self.show()
        if self.isVisible() then
            box.show()
            self.recalculateChildPositions()
            local toDraw = {}
            for _, control in pairs(controls) do
                table.insert(toDraw, control)
            end
            table.sort(
                toDraw,
                function(a, b)
                    local zA = 0
                    local zB = 0
                    if a.getZIndex then
                        zA = a.getZIndex()
                    end
                    if b.getZIndex then
                        zB = b.getZIndex()
                    end
                    return zA < zB
                end
            )
            for _, control in pairs(toDraw) do
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

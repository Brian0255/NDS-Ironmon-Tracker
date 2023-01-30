local function SettingToggleButton(
    initialComponent,
    initialSettings,
    initialSettingsKey,
    initialState,
    isInRadioGroup,
    initialVisibility,
    initialSaveFunction)
    local self = {}
    local component = initialComponent
    local visible = initialVisibility
    local settings = initialSettings
    local settingsKey = initialSettingsKey
    local state = settings[settingsKey]
    local saveFunction = initialSaveFunction
    if initialState ~= nil then
        state = initialState
    else
        state = settings[settingsKey]
    end
    local inRadioGroup = isInRadioGroup
    if visible == nil then
        visible = true
    end
    local function drawInnerFilledRectangle()
        local position = self.getPosition()
        local size = self.getSize()
        gui.drawRectangle(
            position.x + 1,
            position.y + 1,
            size.width - 2,
            size.height - 2,
            0x00000000,
            DrawingUtils.convertColorKeyToColor("Positive text color")
        )
    end
    local function drawCheckmark()
        local position = self.getPosition()
        local size = self.getSize()
        gui.drawLine(
            position.x + 1,
            position.y + 6,
            position.x + 4,
            position.y + 9,
            DrawingUtils.convertColorKeyToColor("Positive text color")
        )
        gui.drawLine(
            position.x + 4,
            position.y + 9,
            position.x + size.width - 2,
            position.y + 1,
            DrawingUtils.convertColorKeyToColor("Positive text color")
        )
    end
    function self.move(newPosition)
        component.move(newPosition)
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
    function self.show()
        if visible then
            component.show()
            if inRadioGroup then
                if settings[settingsKey] == state then
                    drawInnerFilledRectangle()
                end
            else
                if settings[settingsKey] == true then
                    drawCheckmark()
                end
            end
        end
    end
    function self.calculateActualPosition(parentPosition)
        component.calculateActualPosition(parentPosition)
    end
    function self.onClick()
        if inRadioGroup then
            settings[settingsKey] = state
        else
            settings[settingsKey] = not settings[settingsKey]
        end
        saveFunction()
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

return SettingToggleButton

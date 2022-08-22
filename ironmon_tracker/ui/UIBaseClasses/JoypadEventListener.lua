local function JoypadEventListener(controllerSettings, buttonKey, initialOnButtonPress, initialOnButtonPressParams)
    local self = {}
    local lastInput = nil
    local onButtonPress = initialOnButtonPress
    local onButtonPressParams = initialOnButtonPressParams
    function self.listen()
        local joypadButtons = joypad.get()
        local button = controllerSettings[buttonKey]
        if lastInput ~= nil then
            if lastInput[button] and joypadButtons[button] ~= lastInput[button] then
                onButtonPress(onButtonPressParams)
            end
        end
        lastInput = joypadButtons
    end
    return self
end

return JoypadEventListener
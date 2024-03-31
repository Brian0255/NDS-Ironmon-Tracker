local function JoypadEventListener(controllerSettings, initialButtonKey, initialOnButtonPress, initialOnButtonPressParams)
    local self = {}
    local lastInput = nil
    local onButtonPress = initialOnButtonPress
    local onButtonPressParams = initialOnButtonPressParams
    local buttonKey = initialButtonKey
    function self.listen()
        local joypadButtons = Input.getJoypad()
        if buttonKey == "ANY" then
            if lastInput ~= nil then
                for button, _ in pairs(joypadButtons) do
                    if button:sub(1, 5) ~= "Touch" and joypadButtons[button] and joypadButtons[button] ~= lastInput[button] then
                        if onButtonPressParams ~= nil then
                            onButtonPressParams.button = button
                        else
                            onButtonPressParams = button
                        end
                        onButtonPress(onButtonPressParams)
                    end
                end
            end
        else
            local button = controllerSettings[buttonKey]
            if lastInput ~= nil then
                if joypadButtons[button] and joypadButtons[button] ~= lastInput[button] then
                    onButtonPress(onButtonPressParams)
                end
            end
        end
        lastInput = joypadButtons
    end
    return self
end

return JoypadEventListener

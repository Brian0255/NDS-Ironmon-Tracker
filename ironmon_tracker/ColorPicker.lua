local function ColorPicker(initialColorScheme, initialColorKey, initialOnCloseFunction, initialOnCloseParams, initialSaveFunction)
    local self = {}

    local width = 220
    local height = 330
    local clientCenter = FormsUtils.getCenter(width, height)
    local xPos = clientCenter.xPos
    local yPos = clientCenter.yPos
    local circleRadius = 75
    local circleCenter = {85, 85}

    local onCloseFunction = initialOnCloseFunction
    local onCloseParams = initialOnCloseParams
    local saveFunction = initialSaveFunction

    local hue = 0
    local sat = 0
    local val = 100

    local red = 0
    local green = 0
    local blue = 0

    local mainForm = nil
    local mainCanvas = nil
    local colorTextBox = nil

    local valueSliderY = 10
    local ellipsesPos = {85, 85}

    local colorScheme = initialColorScheme
    local colorKey = initialColorKey
    local color = colorScheme[colorKey]
    local initialColor = colorScheme[colorKey]

    local draggingColor = false
    local draggingValueSlider = false

    local constants = {
        SLIDER_X_POS = 180,
        SLIDER_Y_POS = 10,
        SLIDER_WIDTH = 10,
        SLIDER_HEIGHT = 150
    }

    local function distance(point1, point2)
        local x1 = point1[1]
        local y1 = point1[2]
        local x2 = point2[1]
        local y2 = point2[2]

        local dist = math.sqrt(((x2 - x1) ^ 2) + ((y2 - y1) ^ 2))
        return dist
    end

    local function HSV_to_RGB()
        local hue2 = hue / 360
        local sat2 = sat / 100
        local val2 = val / 100

        if sat2 == 0 then
            red, green, blue = val2, val2, val2 -- achromatic
        else
            local function hue2rgb(p, q, t)
                if t < 0 then
                    t = t + 1
                end
                if t > 1 then
                    t = t - 1
                end
                if t < 1 / 6 then
                    return p + (q - p) * 6 * t
                end
                if t < 1 / 2 then
                    return q
                end
                if t < 2 / 3 then
                    return p + (q - p) * (2 / 3 - t) * 6
                end
                return p
            end

            local q = val2 < 0.5 and val2 * (1 + sat2) or val2 + sat2 - val2 * sat2
            local p = 2 * val2 - q
            red = hue2rgb(p, q, hue2 + 1 / 3)
            green = hue2rgb(p, q, hue2)
            blue = hue2rgb(p, q, hue2 - 1 / 3)
        end

        red, green, blue = red * 255, green * 255, blue * 255
    end

    local function HEX_to_RGB(hexStr)
        red, green, blue =
            tonumber(hexStr:sub(1, 2),16),
            tonumber(hexStr:sub(3, 4),16),
            tonumber(hexStr:sub(5, 6),16)
    end

    local function RGB_to_HSL()
        local r, g, b = red, green, blue

        local R, G, B = r / 255, g / 255, b / 255
        local max, min = math.max(R, G, B), math.min(R, G, B)
        local l, s, h

        -- Get luminance
        l = (max + min) / 2

        -- short circuit saturation and hue if it's grey to prevent divide by 0
        if max == min then
            s = 0
            h = hue or 0
            hue, sat, val = 0, 0, l * 100
            return
        end

        -- Get saturation
        if l <= 0.5 then
            s = (max - min) / (max + min)
        else
            s = (max - min) / (2 - max - min)
        end

        -- Get hue
        if max == R then
            h = (G - B) / (max - min) * 60
        elseif max == G then
            h = (2.0 + (B - R) / (max - min)) * 60
        else
            h = (4.0 + (R - G) / (max - min)) * 60
        end

        -- Make sure it goes around if it's negative (hue is a circle)
        if h ~= 360 then
            h = h % 360
        end
        hue, sat, val = h, s * 100, l * 100
    end

    local function RGB_to_Hex()
        --%02x: 0 means replace " "s with "0"s, 2 is width, x means hex
        return tonumber(string.format("0xFF%02x%02x%02x", math.floor(red), math.floor(green), math.floor(blue)))
    end

    local function drawMainCanvas()
        forms.clear(mainCanvas, 0x00000000)
        local wheelPath = Paths.FOLDERS.DATA_FOLDER .. "/images//colorPicker/HSVwheel3.png"
        local gradientPath = Paths.FOLDERS.DATA_FOLDER .. "/images//colorPicker/HSVgradient.png"
        forms.drawRectangle(mainCanvas, 0, 0, 250, 300, nil, 0xFF404040)
        forms.drawRectangle(mainCanvas, 69, 173, 30, 30, nil, color)
        forms.drawImage(mainCanvas, wheelPath, 10, 10, 150, 150)
        forms.drawImage(
            mainCanvas,
            gradientPath,
            constants.SLIDER_X_POS,
            constants.SLIDER_Y_POS,
            constants.SLIDER_WIDTH,
            constants.SLIDER_HEIGHT
        )
        forms.drawEllipse(mainCanvas, ellipsesPos[1] - 3, ellipsesPos[2] - 3, 6, 6, nil, tonumber(color))
        local sliderX = 178
        local sliderY = valueSliderY
        forms.drawRectangle(mainCanvas, sliderX, sliderY, 14, 4, nil, nil)
        forms.drawText(mainCanvas, 15, 221, "Color: ", 0xFFFFFFFF, 0x00000000, 14, "Arial")
        forms.refresh(mainCanvas)
    end

    local function convertHSVtoColorPicker()
        valueSliderY = 10 + ((100 - val) / 100 * 150)
        local sat2 = sat / 100
        local angle = hue
        angle = math.rad(angle)
        local relativeX = math.cos(angle) * (circleRadius) * sat2
        local relativeY = math.sin(angle) * (circleRadius) * sat2
        ellipsesPos = {relativeX + circleCenter[1], relativeY + circleCenter[2]}
        drawMainCanvas()
        colorScheme[colorKey] = color
    end

    local function initializeColorWheelSlider()
        local colorText = string.format("%X", color)
        HEX_to_RGB(colorText:sub(3))
        RGB_to_HSL()
        convertHSVtoColorPicker()
        forms.settext(colorTextBox, colorText:sub(3))
    end

    local function setColor()
        HSV_to_RGB()
        color = RGB_to_Hex()
        colorScheme[colorKey] = tonumber(color)
    end


    local function updateCirclePreview()
        local clickPos = {forms.getMouseX(mainCanvas), forms.getMouseY(mainCanvas)}
        local x, y = clickPos[1], clickPos[2]
        local distanceToRadius = distance(clickPos, circleCenter)
        if distanceToRadius > circleRadius then
            local ratio = distanceToRadius / circleRadius
            x = (x - 85) / ratio
            x = 85 + x
            y = (y - 85) / ratio
            y = 85 + y
        end
        local relativeX = x - circleCenter[1]
        local relativeY = -1 * (y - circleCenter[2])
        local radians = 2 * math.atan(relativeY / (relativeX + (math.sqrt(relativeX ^ 2 + relativeY ^ 2))))
        local degrees = math.deg(radians)
        --Check for NaN.
        if degrees == degrees then
            if degrees < 0 then
                degrees = (180 - math.abs(degrees)) + 180
            end
            hue = 360 - degrees + 0.5
            sat = math.min(100, distanceToRadius / circleRadius * 100 + 0.5)
            if val < 2 or val > 98 then
                valueSliderY = 85
                val = 50
            end
            setColor()
            forms.settext(colorTextBox, string.format("%X",color):sub(3))
            ellipsesPos = {x, y}
            drawMainCanvas()
        end
    end

    local function updateVSlider()
        local clickPos = {forms.getMouseX(mainCanvas), forms.getMouseY(mainCanvas)}
        local y = clickPos[2]
        y = math.min(160, y)
        y = math.max(10, y)
        valueSliderY = y
        local val2 = 100 - ((y - 10) / 150 * 100)
        val = val2
        setColor()
        forms.settext(colorTextBox, string.format("%X",color):sub(3))
        drawMainCanvas()
    end

    local function onClose()
        colorScheme[colorKey] = initialColor
        if onCloseFunction ~= nil then
            onCloseFunction(onCloseParams)
        end
        forms.destroyall()
    end

    
    local function onSave()
        initialColor = color
        colorScheme[colorKey] = initialColor
        saveFunction()
    end

    function self.show()
        forms.destroyall()
        mainForm =
            forms.newform(
            width,
            height,
            "Color Picker",
            function()
                onClose()
            end
        )
        forms.setproperty(mainForm, "Visible", false)
        colorTextBox = forms.textbox(mainForm, "", 70, 10, "HEX", 60, 218)

        local saveButton =
            forms.button(
            mainForm,
            "Save",
            function()
                onSave()
            end,
            15,
            250,
            85,
            30
        )
        local closeButton =
            forms.button(
            mainForm,
            "Close",
            function()
                onClose()
            end,
            105,
            250,
            85,
            30
        )

        forms.setlocation(mainForm, xPos, yPos)
        mainCanvas = forms.pictureBox(mainForm, 0, 0, 250, 300)
        initializeColorWheelSlider()
        forms.setproperty(mainForm, "Visible", true)
    end

    local function mouseInRange(pos, size)
        local x = forms.getMouseX(mainCanvas)
        local y = forms.getMouseY(mainCanvas)
        local width = size[1]
        local height = size[2]
        return x >= pos[1] and x < pos[1] + width and y >= pos[2] and y < pos[2] + height
    end


    function self.handleInput()
        if not draggingColor and not draggingValueSlider then
            local colorText = forms.gettext(colorTextBox)
            if #colorText == 6 then
                color = tonumber("0xFF" .. colorText)
                HEX_to_RGB(colorText)
                RGB_to_HSL()
                convertHSVtoColorPicker()
            end
        end
        local mouse = Input.getMouse()
        local leftPress = mouse["Left"]
        if leftPress then
            if draggingColor then
                updateCirclePreview()
            elseif draggingValueSlider then
                updateVSlider()
            else
                local clickPos = {forms.getMouseX(mainCanvas), forms.getMouseY(mainCanvas)}
                if not draggingColor then
                    local distanceToCenter = distance(clickPos, circleCenter)
                    if distanceToCenter >= 0 and distanceToCenter <= circleRadius then
                        draggingColor = true
                        updateCirclePreview()
                    end
                end
                if not draggingValueSlider then
                    local sliderPos = {constants.SLIDER_X_POS, constants.SLIDER_Y_POS}
                    local sliderSize = {constants.SLIDER_WIDTH, constants.SLIDER_HEIGHT}
                    if mouseInRange(sliderPos, sliderSize) then
                        draggingValueSlider = true
                    end
                end
            end
        else
            draggingValueSlider = false
            draggingColor = false
        end
    end

    self.show()

    return self
end

return ColorPicker




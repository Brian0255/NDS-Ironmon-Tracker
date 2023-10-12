RepelDrawer = {}

local currentMax = 0
local currentSteps = 0
local previousValue = 0
local currentImagePath = ""
local repelInfo = {
    {imageName = "Repel.png", maxSteps = 100},
    {imageName = "SuperRepel.png", maxSteps = 200},
    {imageName = "MaxRepel.png", maxSteps = 250}
}

local function onRepelUsage()
    for _, info in pairs(repelInfo) do
        if currentSteps <= info.maxSteps then
            currentImagePath =
                Paths.FOLDERS.DATA_FOLDER ..
                Paths.SLASH .. "images" .. Paths.SLASH .. "icons" .. Paths.SLASH .. info.imageName
            currentMax = info.maxSteps
            return
        end
    end
end

local function drawRepel()
    local thresholds = {
        {color = DrawingUtils.convertColorKeyToColor("Negative text color"), value = 0.25},
        {color = DrawingUtils.convertColorKeyToColor("Intermediate text color"), value = 0.50}
    }
    local x = Graphics.SIZES.SCREEN_WIDTH - 24
    local y = 2
    gui.drawImage(currentImagePath, x, y)
    local baseRectangleY = y
    local height = 21
    local width = 6
    local rectangleX = x + 15
    local percentLeft = currentSteps / currentMax
    local filledColor = DrawingUtils.convertColorKeyToColor("Positive text color")
    for _, threshold in pairs(thresholds) do
        if percentLeft <= threshold.value then
            filledColor = threshold.color
            break
        end
    end
    local filledHeight = math.ceil(percentLeft * height)
    filledHeight = math.min(filledHeight, height)
    local filledRectangleY = baseRectangleY + (height - filledHeight)
    DrawingUtils.drawBox(rectangleX, y, width, height, 0xFF000000, 0x00000000)
    gui.drawRectangle(rectangleX, filledRectangleY, width, filledHeight, 0x00000000, filledColor)
end

function RepelDrawer.Update(repelAddress)
    currentSteps = Memory.read_u8(repelAddress)
    if currentSteps > 0 then
        if previousValue == 0 then
            onRepelUsage()
        end
        drawRepel()
    end
    previousValue = currentSteps
end

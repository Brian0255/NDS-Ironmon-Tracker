FrameFactory = {}

local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
local Icon = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Icon.lua")
local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")

function FrameFactory.createArrowFrame(
    iconName,
    parentFrame,
    frameWidth,
    verticalOffset,
    horizontalOffset,
    backgroundColor,
    borderColor)
    verticalOffset = verticalOffset or 0
    horizontalOffset = horizontalOffset or 0
    local arrowFrame =
        Frame(
        Box(
            {
                x = 0,
                y = 0
            },
            {
                width = frameWidth,
                height = 12
            },
            backgroundColor,
            borderColor
        ),
        Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = horizontalOffset, y = verticalOffset}),
        parentFrame
    )
    local arrowButton =
        Icon(Component(arrowFrame, Box({x = 0, y = 0}, {width = 12, height = 12}, nil, nil)), iconName, {x = 2, y = 1})
    return {
        ["frame"] = arrowFrame,
        ["button"] = arrowButton
    }
end

function FrameFactory.createScreenOpeningFrame(parentFrame, frameWidth, frameHeight, iconName, iconOffset, text)
    iconOffset =
        iconOffset or
        {
            x = 2,
            y = 2
        }
    local frame =
        Frame(
        Box(
            {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
            {width = frameWidth, height = frameHeight},
            "Top box background color",
            "Top box border color",
            true,
            "Top box background color"
        ),
        Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 2),
        parentFrame
    )
    Icon(
        Component(frame, Box({x = 0, y = 0}, {width = 16, height = 16}, nil, nil)),
        iconName,
        {x = iconOffset.x, y = iconOffset.y}
    )
    local button =
        TextLabel(
        Component(frame, Box({x = 0, y = 0}, {width = frameWidth - 18, height = frameHeight})),
        TextField(
            text,
            {x = 3, y = 4},
            TextStyle(
                Graphics.FONT.DEFAULT_FONT_SIZE,
                Graphics.FONT.DEFAULT_FONT_FAMILY,
                "Top box text color",
                "Top box background color"
            )
        )
    )
    return {
        ["frame"] = frame,
        ["button"] = button
    }
end

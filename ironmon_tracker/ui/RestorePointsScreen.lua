local function RestorePointsScreen(initialSettings, initialTracker, initialProgram)
    local FrameCounter = dofile(Paths.FOLDERS.DATA_FOLDER .. "/FrameCounter.lua")
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/cOMPONENT.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local Icon = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Icon.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local settings = initialSettings
    local tracker = initialTracker
    local program = initialProgram

    local constants = {
        MAIN_FRAME_HEIGHT = 326,
        DESCRIPTION_FRAME_HEIGHT = 80,
        MAIN_BUTTONS_FRAME_HEIGHT = 196,
        RESTORE_FRAME_HEIGHT = 56,
        RESTORE_FRAME_WIDTH = 126,
        RESTORE_BUTTON_WIDTH = 90,
        RESTORE_BUTTON_HEIGHT = 16
    }
    local loadedARestore = false
    local maxRestorePoints = 3
    local restorePoints = {}
    local presentID = nil
    local currentBaseSeconds = os.time()
    local startSeconds = os.time()
    local ui = {}
    local eventListeners = {}
    local frameCounters = {}
    local self = {}

    local function readRestorePointIntoFrame(frame, restorePoint)
        frame.locationLabel.setText(restorePoint.location)
        local secondsAgo = os.time() - restorePoint.seconds
        local minutesAgo = math.floor(secondsAgo / 60)
        local text = "Just now"
        if minutesAgo ~= 0 then
            text = minutesAgo .. " minute"
            if minutesAgo == 1 then
                text = text .. " ago"
            else
                text = text .. "s ago"
            end
        end
        frame.timeLabel.setText(text)
    end

    local function loadPresent()
        if presentID ~= nil then
            memorysavestate.loadcorestate(presentID)
        end
    end

    local function onLoadRestorePoint(index)
        local restorePoint = restorePoints[index]
        if restorePoint ~= nil then
            local id = restorePoint.id
            if id == nil then
                return
            end
            if not loadedARestore then
                loadedARestore = true
                if presentID ~= nil then
                    memorysavestate.removestate(presentID)
                end
                presentID = memorysavestate.savecorestate()
            end
            memorysavestate.loadcorestate(id)
        end
    end

    local function readRestorePointsIntoUI()
        for index = 1, 3, 1 do
            local restorePoint = restorePoints[index]
            if restorePoint ~= nil then
                ui.restorePointFrames[index].frame.setVisibility(true)
                readRestorePointIntoFrame(ui.restorePointFrames[index], restorePoint)
            else
                ui.restorePointFrames[index].frame.setVisibility(false)
            end
        end
        ui.controls.noRestorePoints.setVisibility(#restorePoints == 0)
    end

    local function createRestorePoint()
        local id = memorysavestate.savecorestate()
        local seconds = os.time()
        table.insert(
            restorePoints,
            1,
            {
                ["id"] = id,
                ["location"] = program.getCurrentLocation() or "Unknown",
                ["seconds"] = seconds
            }
        )
        if #restorePoints > maxRestorePoints then
            local restorePoint = table.remove(restorePoints, maxRestorePoints + 1)
            memorysavestate.removestate(restorePoint.id)
        end
    end

    function self.initialize()
        presentID = nil
        loadedARestore = false
    end

    local function initDescriptionUI()
        ui.frames.descriptionFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.DESCRIPTION_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 3, y = 3}),
            ui.frames.mainInnerFrame
        )
        local lines = {
            "Savestates are created as you",
            "play in case of softlocks or other",
            "major issues. You can load these",
            "to return to an earlier state."
        }
        for _, line in pairs(lines) do
            TextLabel(
                Component(ui.frames.descriptionFrame, Box({x = 0, y = 0}, {width = 0, height = 12})),
                TextField(
                    line,
                    {x = 2, y = 1},
                    TextStyle(
                        Graphics.FONT.DEFAULT_FONT_SIZE,
                        Graphics.FONT.DEFAULT_FONT_FAMILY,
                        "Top box text color",
                        "Top box background color"
                    )
                )
            )
        end
        ui.frames.backToCurrentFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = 0,
                    height = 0
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 26, y = 6}),
            ui.frames.descriptionFrame
        )
        ui.controls.backToCurrent =
            TextLabel(
            Component(
                ui.frames.backToCurrentFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.RESTORE_BUTTON_WIDTH - 10,
                        height = constants.RESTORE_BUTTON_HEIGHT
                    },
                    "Top box background color",
                    "Top box border color"
                )
            ),
            TextField(
                "Back to present",
                {x = 9, y = 2},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        table.insert(eventListeners, MouseClickEventListener(ui.controls.backToCurrent, loadPresent))
    end

    local function createLoadRestoreButton(parentFrame, index)
        local frame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = 0,
                    height = 0
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 14, y = 5}),
            parentFrame
        )
        local button =
            TextLabel(
            Component(
                frame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.RESTORE_BUTTON_WIDTH,
                        height = constants.RESTORE_BUTTON_HEIGHT
                    },
                    "Top box background color",
                    "Top box border color"
                )
            ),
            TextField(
                "Load restore point",
                {x = 8, y = 2},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        table.insert(eventListeners, MouseClickEventListener(button, onLoadRestorePoint, index))
        return button
    end

    local function createRestorePointFrame(index)
        local frameInfo = {}
        local restoreFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = constants.RESTORE_FRAME_WIDTH,
                    height = constants.RESTORE_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 3, y = 3}),
            ui.frames.mainButtonsFrame
        )
        frameInfo.frame = restoreFrame
        local rowInfos = {
            {
                name = "location",
                iconName = "LOCATION_ICON_SMALL_FILLED",
                iconOffset = {x = 2, y = 4}
            },
            {
                name = "time",
                iconName = "CLOCK_SMALL",
                iconOffset = {x = 0, y = 3}
            }
        }
        for i = 1, 2, 1 do
            local rowInfo = rowInfos[i]
            local rowName, icon, offset = rowInfo.name, rowInfo.iconName, rowInfo.iconOffset
            local frame =
                Frame(
                Box(
                    {
                        x = 0,
                        y = 0
                    },
                    {
                        width = 0,
                        height = 13
                    }
                ),
                Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 1, {x = 0, y = 0}),
                restoreFrame
            )
            frameInfo[rowName .. "Icon"] =
                Icon(Component(frame, Box({x = 0, y = 0}, {width = 10, height = 0}, nil, nil)), icon, offset)
            frameInfo[rowName .. "Label"] =
                TextLabel(
                Component(
                    frame,
                    Box(
                        {x = 0, y = 0},
                        {
                            width = 0,
                            height = 0
                        },
                        nil,
                        nil
                    )
                ),
                TextField(
                    "10 minutes ago",
                    {x = 0, y = 2},
                    TextStyle(
                        Graphics.FONT.DEFAULT_FONT_SIZE,
                        Graphics.FONT.DEFAULT_FONT_FAMILY,
                        "Top box text color",
                        "Top box background color"
                    )
                )
            )
        end
        frameInfo.button = createLoadRestoreButton(restoreFrame, index)
        return frameInfo
    end

    local function initMainButtonsUI()
        ui.frames.mainButtonsFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.MAIN_BUTTONS_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 7, {x = 7, y = 7}),
            ui.frames.mainInnerFrame
        )
        ui.controls.noRestorePoints =
            TextLabel(
            Component(ui.frames.mainButtonsFrame, Box({x = 0, y = 0}, {width = 0, height = 12})),
            TextField(
                "No restore points available.",
                {x = -2, y = -2},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.restorePointFrames = {}
        for i = 1, 3, 1 do
            ui.restorePointFrames[i] = createRestorePointFrame(i)
        end
    end

    local function initBottomUI()
        ui.frames.bottomFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = 0,
                    height = 0
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 4, {x = 96, y = 4}),
            ui.frames.mainInnerFrame
        )
        ui.controls.goBackButton =
            TextLabel(
            Component(
                ui.frames.bottomFrame,
                Box(
                    {x = 0, y = 0},
                    {width = 40, height = 14},
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            TextField(
                "Go back",
                {x = 3, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        table.insert(
            eventListeners,
            MouseClickEventListener(ui.controls.goBackButton, program.openScreen, program.UI_SCREENS.TRACKED_INFO_SCREEN)
        )
    end

    local function initUI()
        ui.frames = {}
        ui.controls = {}
        ui.frames.mainFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = constants.MAIN_FRAME_HEIGHT},
                "Main background color",
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 5, y = 5}),
            nil
        )
        ui.frames.mainInnerFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.MAIN_FRAME_HEIGHT - 2 * Graphics.SIZES.BORDER_MARGIN
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL),
            ui.frames.mainFrame
        )
        ui.controls.topHeading =
            TextLabel(
            Component(
                ui.frames.mainInnerFrame,
                Box(
                    {x = 5, y = 5},
                    {width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN, height = 18},
                    "Top box background color",
                    "Top box border color",
                    false
                )
            ),
            TextField(
                "Restore Points",
                {x = 29, y = 1},
                TextStyle(13, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        initDescriptionUI()
        initMainButtonsUI()
        initBottomUI()
    end

    function self.update()
        local currentSeconds = os.time()
        --create a restore point every 5 minutes
        if (currentSeconds - currentBaseSeconds) > (60 * 5) then
            createRestorePoint()
            currentBaseSeconds = currentSeconds
        end
        readRestorePointsIntoUI()
    end

    function self.runEventListeners()
        for _, eventListener in pairs(eventListeners) do
            eventListener.listen()
        end
        for _, frameCounter in pairs(frameCounters) do
            frameCounter.decrement()
        end
    end

    function self.show()
        ui.frames.mainFrame.show()
    end

    initUI()

    return self
end

return RestorePointsScreen

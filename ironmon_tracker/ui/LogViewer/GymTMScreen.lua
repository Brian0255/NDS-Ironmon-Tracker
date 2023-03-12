local function GymTMScreen(initialSettings, initialTracker, initialProgram, initialLogViewerScreen)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local Icon = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Icon.lua")
    local ScrollBar = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ScrollBar.lua")
    local ImageLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageLabel.lua")
    local ImageField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageField.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local HoverEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/HoverEventListener.lua")
    local logInfo
    local settings = initialSettings
    local logViewerScreen = initialLogViewerScreen
    local tracker = initialTracker
    local program = initialProgram
    local TMScroller
    local TMs
    local gymTMs
    local gymLeaderGroups
    local moveHoverListeners = {}
    local leaderClickListeners = {}
    local activeHoverFrame

    local constants = {
        HEADER_HEIGHT = 20,
        TM_NUMBER_WIDTH = 30,
        MOVE_WIDTH = 68,
        ROW_HEIGHT = 18
    }

    local ui = {}
    local eventListeners = {}
    local self = {}
    local rows = {}

    local function onGoBackClick()
    end

    local function onHoverInfoEnd()
        activeHoverFrame = nil
        program.drawCurrentScreens()
    end

    local function onMoveInfoHover(params)
        activeHoverFrame = UIUtils.createAndDrawMoveHoverFrame(params, program.drawCurrentScreens, ui.frames.mainFrame)
    end

    local function createTMRow(index)
        local TMFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 40,
                    height = constants.ROW_HEIGHT
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 0, y = 0}),
            ui.frames.TMListFrame
        )
        local TMIcon =
            Icon(Component(TMFrame, Box({x = 0, y = 0}, {width = 13, height = 0}, nil, nil)), "TM_ICON", {x = 1, y = 2})
        local TMLabel =
            TextLabel(
            Component(
                TMFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.TM_NUMBER_WIDTH,
                        height = 0
                    },
                    nil,
                    nil
                )
            ),
            TextField(
                "",
                {x = 0, y = 2},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        local moveLabel =
            TextLabel(
            Component(
                TMFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.MOVE_WIDTH,
                        height = constants.ROW_HEIGHT
                    },
                    nil,
                    nil
                )
            ),
            TextField(
                "",
                {x = 0, y = 2},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        local badgeImage =
            ImageLabel(
            Component(TMFrame, Box({x = 0, y = 0}, {width = 18, height = 16}, nil, nil)),
            ImageField("", {x = 2, y = 0})
        )
        local leaderLabel =
            TextLabel(
            Component(
                TMFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = 40,
                        height = constants.ROW_HEIGHT
                    },
                    nil,
                    nil
                )
            ),
            TextField(
                "",
                {x = 1, y = 2},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        rows[index] = {
            ["TMIcon"] = TMIcon,
            ["TMLabel"] = TMLabel,
            ["moveLabel"] = moveLabel,
            ["badgeImage"] = badgeImage,
            ["leaderLabel"] = leaderLabel
        }
        table.insert(
            moveHoverListeners,
            HoverEventListener(
                moveLabel,
                onMoveInfoHover,
                {
                    BGColorKey = "Top box background color",
                    BGColorFillKey = "Top box border color",
                    move = nil
                },
                onHoverInfoEnd
            )
        )
        table.insert(
            leaderClickListeners,
            MouseClickEventListener(leaderLabel, logViewerScreen.openTrainerTeamFromTMPage)
        )
    end

    local function fillTMRow(index, TMNumber, moveName, badgePath, leaderName)
        local rowInfo = rows[index]
        local TMIcon, TMLabel, moveLabel, badgeImage, leaderLabel =
            rowInfo.TMIcon,
            rowInfo.TMLabel,
            rowInfo.moveLabel,
            rowInfo.badgeImage,
            rowInfo.leaderLabel
        if TMNumber ~= -1 then
            local TMText = string.format("TM%02d", TMNumber)
            TMLabel.setText(TMText)
            moveLabel.setText(moveName)
            badgeImage.setPath(badgePath)
            leaderLabel.setText(leaderName)
        end
        for _, control in pairs(rowInfo) do
            control.setVisibility(TMNumber ~= -1)
        end
    end

    local function readScrollerIntoUI()
        local gymLeaderIndex = 1
        local viewedTMs = TMScroller.getViewedItems()
        for rowIndex, TMInfo in pairs(viewedTMs) do
            local TM, index = TMInfo[1], TMInfo[2]
            if TM == -1 then
                --empty spacer for HG/SS
                fillTMRow(rowIndex, TM)
            else
                local moveID = TMs[TM]
                moveHoverListeners[rowIndex].getOnHoverParams().move = moveID
                local moveData = MoveData.MOVES[moveID + 1]
                local moveName = moveData.name
                local badgeNumber = index
                local prefix = program.getGameInfo().BADGE_PREFIX
                local badgePath = "ironmon_tracker/images/icons/" .. prefix .. "_"
                --funky HG/SS stuff
                if index > 9 then
                    badgeNumber = index - 9
                    gymLeaderIndex = 2
                    badgePath = badgePath .. "K_"
                end
                badgePath = badgePath .. "badge" .. badgeNumber .. ".png"
                local gymLeaderGroup = gymLeaderGroups[gymLeaderIndex].group
                local gymLeader = gymLeaderGroup.battles[badgeNumber]
                leaderClickListeners[rowIndex].setOnClickParams(
                    {
                        battle = gymLeader,
                        groupIndex = gymLeaderGroups[gymLeaderIndex].index
                    }
                )
                local leaderName = gymLeader.name
                fillTMRow(rowIndex, TM, moveName, badgePath, leaderName)
            end
        end
        program.drawCurrentScreens()
    end

    local function setUpScroller()
        local scrollerItems = {}
        for index, TM in pairs(gymTMs) do
            table.insert(scrollerItems, {TM, index})
        end
        TMScroller.setItems(scrollerItems)
    end

    function self.initialize(newLogInfo)
        gymLeaderGroups = {}
        logInfo = newLogInfo
        TMs = logInfo.getTMs()
        local gameInfo = program.getGameInfo()
        gymTMs = gameInfo.GYM_TMS
        local trainerGroups = logViewerScreen.getTrainerGroups()
        for index, group in pairs(trainerGroups) do
            if group.trainerType == TrainerData.TRAINER_TYPES.GYM_LEADERS then
                table.insert(gymLeaderGroups, {["group"] = group, ["index"] = index})
            end
        end
        setUpScroller()
        readScrollerIntoUI()
    end

    local function initUI()
        ui.controls = {}
        ui.frames = {}
        ui.frames.mainFrame =
            Frame(
            Box(
                {
                    x = Graphics.SIZES.BORDER_MARGIN,
                    y = Graphics.LOG_VIEWER.TAB_HEIGHT + Graphics.SIZES.BORDER_MARGIN + 5
                },
                {
                    width = Graphics.SIZES.SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = Graphics.SIZES.SCREEN_HEIGHT - 2 * Graphics.SIZES.BORDER_MARGIN -
                        Graphics.LOG_VIEWER.TAB_HEIGHT -
                        5
                },
                "Top box background color",
                "Top box border color"
            ),
            nil,
            nil
        )
        local mainFrameSize = ui.frames.mainFrame.getSize()
        ui.frames.TMScrollerFrame =
            Frame(
            Box(
                {
                    x = 30,
                    y = 0
                },
                {
                    width = 186,
                    height = mainFrameSize.height - 12
                },
                "Top box background color",
                "Top box border color"
            ),
            nil,
            ui.frames.mainFrame
        )
        ui.frames.TMListFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 0,
                    height = 0
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 3, y = 3}),
            ui.frames.TMScrollerFrame
        )
        for i = 1, 8, 1 do
            createTMRow(i)
        end
        TMScroller = ScrollBar(ui.frames.TMScrollerFrame, 8, {})
        TMScroller.setScrollReadingFunction(readScrollerIntoUI)
    end

    function self.runEventListeners()
        TMScroller.update()
        local listenerGroups = {eventListeners, moveHoverListeners, leaderClickListeners}
        for _, group in pairs(listenerGroups) do
            for _, eventListener in pairs(group) do
                eventListener.listen()
            end
        end
    end

    function self.show()
        ui.frames.mainFrame.show()
        if activeHoverFrame ~= nil then
            activeHoverFrame.show()
        end
    end

    initUI()
    return self
end

return GymTMScreen

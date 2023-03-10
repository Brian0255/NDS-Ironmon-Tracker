local function TrainerGroupOverviewScreen(initialSettings, initialTracker, initialProgram, initialLogViewerScreen)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local ImageLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageLabel.lua")
    local ImageField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageField.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local Icon = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Icon.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local ScreenStack = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ScreenStack.lua")
    local logViewerScreen = initialLogViewerScreen
    local settings = initialSettings
    local program = initialProgram
    local trainers
    local starterNumber
    local logInfo
    local trainerGroup = nil
    local constants = {
        RIVAL_OVERVIEW_OFFSET = 48,
        RIVAL_OVERVIEW_HEIGHT = 143,
        RIVAL_FRAME_HEIGHT = 64,
        CARD_FRAME_OFFSET = 5,
        CARD_WIDTH = 56,
        CARD_HEIGHT = 65,
        CARD_LOCATION_HEIGHT = 22,
        CARD_SPACING = 4
    }
    local ui = {}
    local eventListeners = {}
    local self = {}

    local function onGoBackClick()
    end

    function self.initialize(newLogInfo)
        logInfo = newLogInfo
        trainers = logInfo.getTrainers()
        starterNumber = logInfo.getStarterNumber()
    end

    local function createTrainerCard(battle, rowFrame)
        local teamID = battle.id
        local teamSize = #trainers[teamID]
        local cardFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.CARD_WIDTH,
                    height = constants.CARD_HEIGHT
                },
                "Top box background color",
                "Top box border color",
                true,
                "Top box background color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 0}),
            rowFrame
        )
        table.insert(eventListeners, MouseClickEventListener(cardFrame,logViewerScreen.openTrainerTeamFromCard, battle))
        ui.controls[battle.name .. "Image"] =
            ImageLabel(
            Component(cardFrame, Box({x = 0, y = 0}, {width = 0, height = constants.CARD_HEIGHT - 19}, nil, nil)),
            ImageField("ironmon_tracker/images/trainers/"..program.getGameInfo().BADGE_PREFIX.."/" .. battle.name .. "_vs.png", {x = 1, y = 1}, nil)
        )
        local badgeNameFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.CARD_WIDTH,
                    height = 19
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 0, y = 0}),
            cardFrame
        )
        local badgePrefix = program.getGameInfo().BADGE_PREFIX
        if trainerGroup.groupName == "Kanto Gyms" then
            badgePrefix = badgePrefix.."_K"
        end
        local badgeNumber = battle.badgeNumber
        if badgeNumber ~= nil then
            local badge =
                ImageLabel(
                Component(badgeNameFrame, Box({x = 0, y = 0}, {width = 18, height = 16}, nil, nil)),
                ImageField(
                    "ironmon_tracker/images/icons/" .. badgePrefix .. "_badge" .. badgeNumber .. ".png",
                    {x = 2, y = 2}
                )
            )
        end
        local name =
            TextLabel(
            Component(
                badgeNameFrame,
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
                battle.name,
                {x = 0, y = 4},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        if badgeNumber == nil then
            --center elite 4/other important trainers without a badge
            local centerX = (constants.CARD_WIDTH - DrawingUtils.calculateWordPixelLength(battle.name) - 2) / 2
            name.setTextOffset({x = centerX, y = 4})
        end
    end

    local function createTrainerCardRow(battleSet)
        local rowFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 0,
                    height = constants.CARD_HEIGHT
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, constants.CARD_SPACING, {x = 0, y = 0}),
            ui.frames.trainerCardFrame
        )
        for _, battle in pairs(battleSet) do
            createTrainerCard(battle, rowFrame)
        end
    end

    local function createTrainerCardFrames()
        local battles = trainerGroup.battles
        local battleSets = MiscUtils.splitTableByNumber(battles, 4)
        for _, battleSet in pairs(battleSets) do
            createTrainerCardRow(battleSet)
        end
    end

    function self.setTrainerGroup(newTrainerGroup)
        trainerGroup = newTrainerGroup
        ui.frames.trainerCardFrame.clearAllChildren()
        createTrainerCardFrames()
    end

    local function initUI()
        ui.controls = {}
        ui.frames = {}
        ui.frames.mainFrame =
            Frame(
            Box(
                {
                    x = Graphics.SIZES.BORDER_MARGIN,
                    y = constants.RIVAL_OVERVIEW_OFFSET
                },
                {
                    width = 0,
                    height = 0
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 0}),
            nil
        )

        ui.frames.trainerCardFrame =
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
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, constants.CARD_SPACING, {x = constants.CARD_FRAME_OFFSET, y = 0}),
            ui.frames.mainFrame
        )
    end

    function self.runEventListeners()
        for _, eventListener in pairs(eventListeners) do
            eventListener.listen()
        end
    end

    function self.show()
        ui.frames.mainFrame.show()
    end

    initUI()

    return self
end

return TrainerGroupOverviewScreen

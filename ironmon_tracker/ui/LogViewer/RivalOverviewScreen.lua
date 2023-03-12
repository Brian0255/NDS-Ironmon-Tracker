local function RivalOverviewScreen(initialSettings, initialTracker, initialProgram, initialLogViewerScreen)
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
        CARD_WIDTH = 76,
        CARD_HEIGHT = 32,
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

    local function createPokeballsForCard(cardFrame, teamSize)
        local pokeballFrame =
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
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 4, {x = 5, y = 0}),
            cardFrame
        )
        for i = 1, 6, 1 do
            if teamSize >= i then
                local pokeball =
                    ImageLabel(
                    Component(pokeballFrame, Box({x = 0, y = 0}, {width = 8, height = 0}, nil, nil)),
                    ImageField(Graphics.PATHS.TRAINER_IMAGES .. "/pokeball.png", {x = 0, y = 0}, nil)
                )
            else
                local noPokeballIcon =
                    Icon(
                    Component(pokeballFrame, Box({x = 0, y = 0}, {width = 8, height = 0}, nil, nil)),
                    "SMALL_DOT",
                    {x = 2, y = 3}
                )
            end
        end
    end

    local function createLocationCard(battle, rowFrame)
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
        local locationLabelFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 0,
                    height = constants.CARD_LOCATION_HEIGHT
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 1, {x = 0, y = 0}),
            cardFrame
        )
        local locationIcon =
            Icon(
            Component(locationLabelFrame, Box({x = 0, y = 0}, {width = 7, height = 0}, nil, nil)),
            "LOCATION_ICON_SMALL_FILLED",
            {x = 2, y = 4}
        )
        local locationLabel =
            TextLabel(
            Component(
                locationLabelFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = 0,
                        height = constants.CARD_LOCATION_HEIGHT
                    },
                    nil,
                    nil
                )
            ),
            TextField(
                battle.location,
                {x = 0, y = 2},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        createPokeballsForCard(cardFrame, teamSize)
    end

    local function createLocationCardRow(battleSet)
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
            ui.frames.locationCardFrame
        )
        for _, battle in pairs(battleSet) do
            createLocationCard(battle, rowFrame)
        end
    end

    local function createLocationCardFrames()
        local battles = trainerGroup.battles
        local battleSets = MiscUtils.splitTableByNumber(battles, 3)
        for _, battleSet in pairs(battleSets) do
            createLocationCardRow(battleSet)
        end
    end

    function self.setTrainerGroup(newTrainerGroup)
        trainerGroup = newTrainerGroup
        local rivalName = trainerGroup.groupName
        ui.controls.rivalImage.setPath(Graphics.PATHS.TRAINER_IMAGES .. "/"..program.getGameInfo().BADGE_PREFIX.."/" .. rivalName .. "_rival.png")
        ui.frames.locationCardFrame.clearAllChildren()
        createLocationCardFrames()
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
        --Exceedingly rare instance where I am not using a rigid layout. Don't feel like the rival image fits it, however.
        ui.controls.rivalImage =
            ImageLabel(
            Component(ui.frames.mainFrame, Box({x = 0, y = 0}, {width = 0, height = 0}, nil, nil)),
            ImageField("ironmon_tracker/images/trainers/cheren_vs.png", {x = 120, y = 75}, nil)
        )

        ui.frames.locationCardFrame =
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

return RivalOverviewScreen

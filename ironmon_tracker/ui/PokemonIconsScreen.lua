local function PokemonIconsScreen(initialSettings, initialTracker, initialProgram)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/cOMPONENT.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local ImageLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageLabel.lua")
    local ImageField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageField.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local FrameCounter = dofile(Paths.FOLDERS.DATA_FOLDER .. "/FrameCounter.lua")
    local settings = initialSettings
    local tracker = initialTracker
    local program = initialProgram
    local currentIconSet = IconSets.SETS[settings.appearance.ICON_SET_INDEX]
    local currentPokemonIndex = 600
    local constants = {
        MAIN_FRAME_HEIGHT = 142,
        POKEMON_ICON_WIDTH = 31,
        POKEMON_ICON_HEIGHT = 28,
        TEXT_HEADER_HEIGHT = 18,
        ICON_FRAME_HEIGHT = 90,
        FORWARD_BACK_BUTTON_WIDTH = 12,
        BOTTOM_FRAME_HEIGHT = 24,
        NAV_BUTTON_WIDTH = 12,
        NAV_LABEL_WIDTH = 50,
        NAV_FRAME_HEIGHT = 21
    }
    local ui = {}
    local eventListeners = {}
    local frameCounters = {}
    local self = {}

    local function changeIndexToRandomID()
        currentPokemonIndex = math.random(1, #PokemonData.POKEMON - 1)
    end

    local function getCenterStart(totalWidth, labelName)
        return (totalWidth - DrawingUtils.calculateWordPixelLength(labelName)) / 2
    end

    local function setAuthorLabel()
        local authorLines = currentIconSet.AUTHOR
        for i, label in pairs(ui.controls.authorLabels) do
            if authorLines[i] then
                label.setText(authorLines[i])
            else
                label.setText("")
            end
            local offset = {
                x = getCenterStart(label.getSize().width - 2, label.getText()),
                y = 1
            }
            label.setTextOffset(offset)
        end
    end

    local function randomizeIcon()
        changeIndexToRandomID()
        DrawingUtils.readPokemonIDIntoImageLabel(
            currentIconSet,
            currentPokemonIndex,
            ui.controls.pokemonImageLabel,
            currentIconSet.CHOOSE_IMAGE_OFFSET
        )
        program.drawCurrentScreens()
    end

    local function setUpIconSet()
        currentIconSet = IconSets.SETS[settings.appearance.ICON_SET_INDEX]
        local totalWidth = constants.NAV_LABEL_WIDTH
        local name = currentIconSet.NAME
        local xOffset = (totalWidth - DrawingUtils.calculateWordPixelLength(name)) / 2
        ui.controls.nameLabel.setText(currentIconSet.NAME)
        ui.controls.nameLabel.setTextOffset({x = xOffset - 1, y = 1})
        setAuthorLabel()
        frameCounters["changeIndex"].reset()
        randomizeIcon()
        program.saveSettings()
        program.drawCurrentScreens()
    end

    local function onForwardClick()
        local currentIndex = settings.appearance.ICON_SET_INDEX
        settings.appearance.ICON_SET_INDEX = MiscUtils.increaseTableIndex(currentIndex, #IconSets.SETS)
        setUpIconSet()
    end

    local function onBackwardClick()
        program.drawCurrentScreens()
        local totalSets = #IconSets.SETS
        local currentIndex = settings.appearance.ICON_SET_INDEX
        settings.appearance.ICON_SET_INDEX =  MiscUtils.decreaseTableIndex(currentIndex, totalSets)
        setUpIconSet()
    end

    local function onGoBackClick()
        program.setCurrentScreens({program.UI_SCREENS.APPEARANCE_OPTIONS_SCREEN})
        program.drawCurrentScreens()
    end

    local function setupNavFrameButtons()
        ui.controls.goBackwardButton =
            TextLabel(
            Component(
                ui.frames.navFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.NAV_BUTTON_WIDTH,
                        height = constants.NAV_BUTTON_WIDTH
                    },
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            TextField(
                "<",
                {x = 1, y = -1},
                TextStyle(10, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        local xOffset = getCenterStart(constants.NAV_LABEL_WIDTH, currentIconSet.NAME)
        ui.controls.nameLabel =
            TextLabel(
            Component(
                ui.frames.navFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.NAV_LABEL_WIDTH,
                        height = 0
                    },
                    nil,
                    nil,
                    false
                )
            ),
            TextField(
                currentIconSet.NAME,
                {x = xOffset - 1, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls.goForwardButton =
            TextLabel(
            Component(
                ui.frames.navFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.NAV_BUTTON_WIDTH,
                        height = constants.NAV_BUTTON_WIDTH
                    },
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            TextField(
                ">",
                {x = 2, y = -1},
                TextStyle(10, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        table.insert(eventListeners, MouseClickEventListener(ui.controls.goForwardButton, onForwardClick))
        table.insert(eventListeners, MouseClickEventListener(ui.controls.goBackwardButton, onBackwardClick))
    end

    local function setUpPokemonIcon()
        ui.frames.pokemonIconFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = 0,
                    height = constants.POKEMON_ICON_HEIGHT + Graphics.SIZES.BORDER_MARGIN
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 53, y = 0}),
            ui.frames.iconFrame
        )
        ui.controls.pokemonImageLabel =
            ImageLabel(
            Component(
                ui.frames.pokemonIconFrame,
                Box(
                    {x = 0, y = 0},
                    {width = constants.POKEMON_ICON_WIDTH, height = constants.POKEMON_ICON_HEIGHT},
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            ImageField("", {x = 0, y = -5}, nil)
        )
    end

    local function setUpAuthorLabels()
        ui.controls.authorLabels = {}
        for i = 1, 2, 1 do
            ui.controls.authorLabels[i] =
                TextLabel(
                Component(
                    ui.frames.iconFrame,
                    Box(
                        {x = 0, y = 0},
                        {
                            width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                            height = 13
                        },
                        nil,
                        nil,
                        false
                    )
                ),
                TextField(
                    "",
                    {x = 0, y = 0},
                    TextStyle(
                        Graphics.FONT.DEFAULT_FONT_SIZE,
                        Graphics.FONT.DEFAULT_FONT_FAMILY,
                        "Top box text color",
                        "Top box background color"
                    )
                )
            )
        end
    end

    local function initUI()
        ui.controls = {}
        ui.frames = {}
        ui.frames.mainFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = constants.MAIN_FRAME_HEIGHT},
                "Main background color",
                nil
            ),
            Layout(
                Graphics.ALIGNMENT_TYPE.VERTICAL,
                0,
                {x = Graphics.SIZES.BORDER_MARGIN, y = Graphics.SIZES.BORDER_MARGIN}
            ),
            nil
        )
        ui.controls.mainHeading =
            TextLabel(
            Component(
                ui.frames.mainFrame,
                Box(
                    {x = 5, y = 5},
                    {
                        width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                        height = constants.TEXT_HEADER_HEIGHT
                    },
                    "Top box background color",
                    "Top box border color",
                    false
                )
            ),
            TextField(
                "Pok"..Chars.accentedE.."mon Icon Sets",
                {x = 16, y = 1},
                TextStyle(13, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        ui.frames.iconFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.ICON_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 5}),
            ui.frames.mainFrame
        )
        ui.frames.navFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = 0,
                    height = constants.NAV_FRAME_HEIGHT
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 32, y = 0}),
            ui.frames.iconFrame
        )
        setupNavFrameButtons()
        setUpPokemonIcon()
        setUpAuthorLabels()
        ui.frames.goBackFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.BOTTOM_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 95, y = Graphics.SIZES.BORDER_MARGIN}),
            ui.frames.mainFrame
        )
        ui.controls.goBackButton =
            TextLabel(
            Component(
                ui.frames.goBackFrame,
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
        table.insert(eventListeners, MouseClickEventListener(ui.controls.goBackButton, onGoBackClick))
    end

    local function runFrameCounters()
        for _, frameCounter in pairs(frameCounters) do
            frameCounter.decrement()
        end
    end

    function self.runEventListeners()
        for _, eventListener in pairs(eventListeners) do
            eventListener.listen()
        end
        runFrameCounters()
    end

    function self.initialize()
        randomizeIcon()
        setUpIconSet()
    end

    function self.show()
        ui.frames.mainFrame.show()
    end

    frameCounters["changeIndex"] = FrameCounter(60, randomizeIcon, nil, true)
    initUI()
    return self
end

return PokemonIconsScreen

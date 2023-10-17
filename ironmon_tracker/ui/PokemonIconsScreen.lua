local function PokemonIconsScreen(initialSettings, initialTracker, initialProgram)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local ImageLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageLabel.lua")
    local ImageField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageField.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local SettingToggleButton = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/SettingToggleButton.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local FrameCounter = dofile(Paths.FOLDERS.DATA_FOLDER .. "/FrameCounter.lua")
    local settings = initialSettings
    local tracker = initialTracker
    local program = initialProgram
    local currentIconSet = IconSets.SETS[settings.appearance.ICON_SET_INDEX]
    local currentPokemonIndex = 600
    local constants = {
        MAIN_FRAME_HEIGHT = 154,
        POKEMON_ICON_WIDTH = 31,
        POKEMON_ICON_HEIGHT = 28,
        TEXT_HEADER_HEIGHT = 18,
        ICON_FRAME_HEIGHT = 102,
        FORWARD_BACK_BUTTON_WIDTH = 12,
        BOTTOM_FRAME_HEIGHT = 24,
        NAV_BUTTON_WIDTH = 12,
        NAV_LABEL_WIDTH = 50,
        NAV_FRAME_HEIGHT = 21,
        TOGGLE_BUTTON_SIZE = 10
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
        DrawingUtils.readPokemonIDIntoImageLabel(currentIconSet, currentPokemonIndex, ui.controls.pokemonImageLabel)
        program.drawCurrentScreens()
    end

    local function setUpIconSet()
        currentIconSet = IconSets.SETS[settings.appearance.ICON_SET_INDEX]
        local totalWidth = constants.NAV_LABEL_WIDTH + 36
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

    local function toggleClick(button)
        button.onClick()
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
        settings.appearance.ICON_SET_INDEX = MiscUtils.decreaseTableIndex(currentIndex, totalSets)
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
        ui.controls.nameLabel =
            TextLabel(
            Component(
                ui.frames.navFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.NAV_LABEL_WIDTH + 36,
                        height = 20
                    }
                )
            ),
            TextField(
                currentIconSet.NAME,
                {x = 0, y = 1},
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

    local function setUpBrowsToggle()
        local isVisible = function()
            return settings.appearance.ICON_SET_INDEX == 2
        end

        ui.frames.browsToggleFrame =
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
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 29, y = -11}),
            ui.frames.iconFrame,
            isVisible
        )
        ui.controls.browsToggleBox =
            SettingToggleButton(
            Component(
                ui.frames.browsToggleFrame,
                Box(
                    {x = 0, y = 0},
                    {width = constants.TOGGLE_BUTTON_SIZE, height = constants.TOGGLE_BUTTON_SIZE},
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            settings.extras,
            "BROWS_ENABLED",
            nil,
            false,
            true,
            program.saveSettings
        )
        local labelName = "Enable Brows"
        ui.controls.browsToggleLabel =
            TextLabel(
            Component(ui.frames.browsToggleFrame, Box({x = 0, y = 0}, {width = 0, height = 0}, nil, nil, false)),
            TextField(
                labelName,
                {x = 2, y = 0},
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
            MouseClickEventListener(ui.controls.browsToggleBox, toggleClick, ui.controls.browsToggleBox)
        )
    end

    local function createAnimatedToggleRow(option)
        local frame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = 0,
                    height = 12
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 5),
            ui.frames.animatedSpritesFrame
        )
        local toggleBox =
            SettingToggleButton(
            Component(
                frame,
                Box(
                    {x = 0, y = 0},
                    {width = constants.TOGGLE_BUTTON_SIZE, height = constants.TOGGLE_BUTTON_SIZE},
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            settings.animatedSprites,
            option,
            nil,
            false,
            true,
            program.saveSettings
        )
        local toggleLabel =
            TextLabel(
            Component(frame, Box({x = 0, y = 0}, {width = 0, height = 0})),
            TextField(
                option:sub(1, 1) .. option:sub(2):lower():gsub("_", " "),
                {x = 2, y = 0},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        table.insert(eventListeners, MouseClickEventListener(toggleBox, toggleClick, toggleBox))
        return frame
    end

    local function setUpAnimatedSpriteToggles()
        local isVisible = function()
            return settings.appearance.ICON_SET_INDEX == 5
        end
        ui.frames.animatedSpritesFrame =
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
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 29, y = -11}),
            ui.frames.iconFrame,
            isVisible
        )

        local options = {"FASTER_ANIMATIONS", "CHANGE_DIRECTION"}
        for _, option in pairs(options) do
            createAnimatedToggleRow(option)
        end
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
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = Graphics.SIZES.BORDER_MARGIN, y = Graphics.SIZES.BORDER_MARGIN}),
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
                "Pok" .. Chars.accentedE .. "mon Icon Sets",
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
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 14, y = 0}),
            ui.frames.iconFrame
        )
        setupNavFrameButtons()
        setUpPokemonIcon()
        setUpAuthorLabels()
        setUpBrowsToggle()
        setUpAnimatedSpriteToggles()
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
        ui.controls.browsToggleBox.setVisibility(currentIconSet and currentIconSet.NAME == "Stadium")
        ui.controls.browsToggleLabel.setVisibility(currentIconSet and currentIconSet.NAME == "Stadium")
        ui.frames.mainFrame.show()
    end

    frameCounters["changeIndex"] = FrameCounter(60, randomizeIcon, nil, true)
    initUI()
    return self
end

return PokemonIconsScreen

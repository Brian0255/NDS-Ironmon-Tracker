local function AppearanceOptionsScreen(initialSettings, initialTracker, initialProgram)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/cOMPONENT.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local ImageLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageLabel.lua")
    local ImageField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageField.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local Icon = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Icon.lua")
    local HoverEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/HoverEventListener.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local SettingToggleButton = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/SettingToggleButton.lua")
    local settings = initialSettings
    local tracker = initialTracker
    local program = initialProgram
    local constants = {
        MAIN_HEIGHT = 144,
        TOGGLE_FRAME_WIDTH = 200,
        TOGGLE_FRAME_HEIGHT = 12,
        BUTTON_SIZE = 10,
        MAIN_BUTTON_WIDTH = 106,
        MAIN_BUTTON_HEIGHT = 19,
        BADGE_COLOR_FRAME_HEIGHT = 60
    }
    local ui = {}
    local eventListeners = {}
    local self = {}
    local function onGoBackClick()
        program.setCurrentScreens({program.UI_SCREENS.MAIN_OPTIONS_SCREEN})
        program.drawCurrentScreens()
    end

    local function onBadgesAppearanceClick()
        client.SetGameExtraPadding(0, 0, Graphics.SIZES.BADGE_COLOR_EDIT_PADDING, 0)
        program.setCurrentScreens({program.UI_SCREENS.MAIN_SCREEN,program.UI_SCREENS.BADGES_APPEARANCE_SCREEN})
        program.drawCurrentScreens()
    end

    local function initEventListeners()
        --eventListeners.goBackClickListener = MouseClickEventListener(ui.controls.goBackButton, onGoBackClick)
    end

    local function onToggleClick(button)
        button.onClick()
        program.drawCurrentScreens()
    end

    local function initAppearanceToggleButtons()
        local orderedKeys = {
            "RIGHT_JUSTIFIED_NUMBERS",
            "SHOW_POKECENTER_HEALS"
        }
        for _, key in pairs(orderedKeys) do
            local frame =
                Frame(
                Box(
                    {x = 0, y = 0},
                    {width = constants.TOGGLE_FRAME_WIDTH, height = constants.TOGGLE_FRAME_HEIGHT},
                    nil,
                    nil
                ),
                Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 2, {x = 4, y = 0}),
                ui.frames.mainInnerFrame
            )
            local toggle =
                SettingToggleButton(
                Component(
                    frame,
                    Box(
                        {x = 0, y = 0},
                        {width = constants.BUTTON_SIZE, height = constants.BUTTON_SIZE},
                        "Top box background color",
                        "Top box border color",
                        true,
                        "Top box background color"
                    )
                ),
                settings.battle,
                key,
                nil,
                false
            )
            local labelName
            labelName = key:gsub("_", " "):lower()
            labelName = labelName:sub(1, 1):upper() .. labelName:sub(2)
            labelName = labelName:gsub("pokecenter", "Pok\233center")
            TextLabel(
                Component(frame, Box({x = 0, y = 0}, {width = 0, height = 0}, nil, nil, false)),
                TextField(
                    labelName,
                    {x = 0, y = 0},
                    TextStyle(
                        Graphics.FONT.DEFAULT_FONT_SIZE,
                        Graphics.FONT.DEFAULT_FONT_FAMILY,
                        "Top box text color",
                        "Top box background color"
                    )
                )
            )
            table.insert(eventListeners, MouseClickEventListener(toggle, onToggleClick, toggle))
        end
    end

    local function initBadgeColorButtons()
        ui.frames.badgeColorButtonsFrame =
            Frame(
            Box(
                {x = 0, y = Graphics.SIZES.BORDER_MARGIN},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.BADGE_COLOR_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 5, {x = 17, y = 8}),
            ui.frames.mainInnerFrame
        )
        local buttonNames = {
            badgesAppearanceButton = "Badges Appearance",
            colorThemeButton = "Edit Color Theme"
        }
        local order = {"badgesAppearanceButton", "colorThemeButton"}
        for i, key in pairs(order) do
            local text = buttonNames[key]
            local frameName = key .. "Frame"
            ui.frames[frameName] =
                Frame(
                Box(
                    {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                    {width = constants.MAIN_BUTTON_WIDTH, height = constants.MAIN_BUTTON_HEIGHT},
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                ),
                Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 2),
                ui.frames.badgeColorButtonsFrame
            )
            if key == "colorThemeButton" then
                local iconName = "PAINTBRUSH"
                Icon(
                    Component(ui.frames[frameName], Box({x = 0, y = 0}, {width = 16, height = 16}, nil, nil)),
                    iconName,
                    {x = 2, y = 2}
                )
            else
                local badgePrefix = program.getGameInfo().BADGE_PREFIX
                ImageLabel(
                    Component(ui.frames[frameName], Box({x = 0, y = 0}, {width = 16, height = 16}, nil, nil)),
                    ImageField("ironmon_tracker/images/icons/" .. badgePrefix .. "_badge1.png", {x = 3, y = 2})
                )
            end
            ui.controls[key] =
                TextLabel(
                Component(
                    ui.frames[frameName],
                    Box(
                        {x = 0, y = 0},
                        {width = constants.MAIN_BUTTON_WIDTH - 18, height = constants.MAIN_BUTTON_HEIGHT}
                    )
                ),
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
        end
    end

    local function initUI()
        ui.controls = {}
        ui.frames = {}
        ui.frames.mainFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = constants.MAIN_HEIGHT},
                "Main background color",
                nil
            ),
            nil,
            nil
        )
        ui.frames.mainInnerFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.BORDER_MARGIN, y = Graphics.SIZES.BORDER_MARGIN},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.MAIN_HEIGHT - 2 * Graphics.SIZES.BORDER_MARGIN
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 2, {x = 0, y = 22}),
            ui.frames.mainFrame
        )
        ui.controls.topHeading =
            TextLabel(
            Component(
                ui.frames.mainFrame,
                Box(
                    {x = 5, y = 5},
                    {width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN, height = 18},
                    "Top box background color",
                    "Top box border color",
                    false
                )
            ),
            TextField(
                "Tracker Appearance",
                {x = 14, y = 1},
                TextStyle(13, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        ui.controls.goBackButton =
            TextLabel(
            Component(
                ui.frames.mainFrame,
                Box(
                    {x = Graphics.SIZES.MAIN_SCREEN_WIDTH - 49, y = constants.MAIN_HEIGHT - 24},
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
        initAppearanceToggleButtons()
        initBadgeColorButtons()
        table.insert(eventListeners, MouseClickEventListener(ui.controls.goBackButton, onGoBackClick))
        table.insert(
            eventListeners,
            MouseClickEventListener(ui.frames.badgesAppearanceButtonFrame, onBadgesAppearanceClick)
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

return AppearanceOptionsScreen

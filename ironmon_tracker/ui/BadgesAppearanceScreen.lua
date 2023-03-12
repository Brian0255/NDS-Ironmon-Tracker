local function BadgesAppearanceScreen(initialSettings, initialTracker, initialProgram)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local SettingToggleButton = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/SettingToggleButton.lua")
    local settings = initialSettings
    local tracker = initialTracker
    local program = initialProgram
    local constants = {
        TOP_FRAME_HEIGHT = 108,
        SINGLE_BADGE_ALIGNMENT_FRAME_HEIGHT = 78,
        DOUBLE_ALIGNMENT_HEIGHT = 112,
        HGSS_HEADING_HEIGHT = 62,
        BUTTON_SIZE = 10,
        MAIN_BUTTON_WIDTH = 106,
        MAIN_BUTTON_HEIGHT = 10,
        BOTTOM_FRAME_HEIGHT = 31
    }
    local ui = {}
    local eventListeners = {}
    local self = {}

    local function initEventListeners()
        --eventListeners.goBackClickListener = MouseClickEventListener(ui.controls.goBackButton, onGoBackClick)
    end

    local function onGoBackClick()
        client.SetGameExtraPadding(0, 0, Graphics.SIZES.MAIN_SCREEN_PADDING, 0)
        program.setCurrentScreens({program.UI_SCREENS.APPEARANCE_OPTIONS_SCREEN})
        program.drawCurrentScreens()
    end

    local function onRadioButtonClick(button)
        button.onClick()
        program.drawCurrentScreens()
    end

    local function onSpacerClick(button)
        button.onClick()
        program.drawCurrentScreens()
    end

    local function createDoubleBadgeRadioButtons(frames)
        local rows = {{"BOTH_ABOVE", "BOTH_BELOW"}, {"BOTH_RIGHT", "BOTH_LEFT"}, {"LEFT_AND_RIGHT", "ABOVE_AND_BELOW"}}
        for i, rowPair in pairs(rows) do
            for _, settingName in pairs(rowPair) do
                local radioButton =
                    SettingToggleButton(
                    Component(
                        frames[i],
                        Box(
                            {x = 0, y = 0},
                            {width = constants.BUTTON_SIZE, height = constants.BUTTON_SIZE},
                            "Top box background color",
                            "Top box border color",
                            true,
                            "Top box background color"
                        )
                    ),
                    settings.badgesAppearance,
                    "DOUBLE_BADGE_ALIGNMENT",
                    settingName,
                    true,
                    true,
                    program.saveSettings
                )
                table.insert(eventListeners, MouseClickEventListener(radioButton, onRadioButtonClick, radioButton))
                local text = settingName
                text = text:gsub("_AND_", "/")
                text = text:gsub("_", " ")
                text = text:sub(1, 1):upper() .. text:sub(2):lower()
                TextLabel(
                    Component(frames[i], Box({x = 0, y = 0}, {width = 50, height = constants.MAIN_BUTTON_HEIGHT}, nil, nil)),
                    TextField(
                        text,
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
    end

    local function createDoubleBadgeFrames()
        local doubleBadgeFrames = {}
        for i = 1, 3, 1 do
            table.insert(
                doubleBadgeFrames,
                Frame(
                    Box(
                        {x = 0, y = 0},
                        {
                            width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                            height = constants.MAIN_BUTTON_HEIGHT
                        },
                        nil,
                        nil
                    ),
                    Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 2, {x = 6, y = 0}),
                    ui.frames.doubleAlignmentInnerFrame
                )
            )
        end
        return doubleBadgeFrames
    end

    local function createDoubleOrderRadioButtons()
        local settingNames = {"JOHTO", "KANTO"}
        for _, settingName in pairs(settingNames) do
            local radioButton =
                SettingToggleButton(
                Component(
                    ui.frames.orderFrame,
                    Box(
                        {x = 0, y = 0},
                        {width = constants.BUTTON_SIZE, height = constants.BUTTON_SIZE},
                        "Top box background color",
                        "Top box border color",
                        true,
                        "Top box background color"
                    )
                ),
                settings.badgesAppearance,
                "PRIMARY_BADGE_SET",
                settingName,
                true,
                true,
                program.saveSettings
            )
            table.insert(eventListeners, MouseClickEventListener(radioButton, onRadioButtonClick, radioButton))
            local text = settingName .. " first"
            text = text:sub(1, 1):upper() .. text:sub(2):lower()
            TextLabel(
                Component(
                    ui.frames.orderFrame,
                    Box({x = 0, y = 0}, {width = 50, height = constants.MAIN_BUTTON_HEIGHT}, nil, nil)
                ),
                TextField(
                    text,
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

    local function setUpDoubleAlignmentUI()
        ui.frames.doubleAlignmentOuterFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH,
                    height = constants.DOUBLE_ALIGNMENT_HEIGHT
                },
                "Main background color",
                nil
            ),
            nil,
            ui.frames.mainFrame
        )
        ui.frames.doubleAlignmentInnerFrame =
            Frame(
            Box(
                {x = 5, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.DOUBLE_ALIGNMENT_HEIGHT - Graphics.SIZES.BORDER_MARGIN - 2
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 5),
            ui.frames.doubleAlignmentOuterFrame
        )
        ui.controls.doubleAlignmentHeading =
            TextLabel(
            Component(
                ui.frames.doubleAlignmentInnerFrame,
                Box(
                    {x = 5, y = 0},
                    {width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN, height = 18}
                )
            ),
            TextField(
                "Double Badge Alignment",
                {x = 7, y = 3},
                TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        local doubleBadgeFrames = createDoubleBadgeFrames()
        createDoubleBadgeRadioButtons(doubleBadgeFrames)
        ui.controls.orderHeading =
            TextLabel(
            Component(
                ui.frames.doubleAlignmentInnerFrame,
                Box(
                    {x = 5, y = 0},
                    {width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN, height = 16}
                )
            ),
            TextField(
                "Double Badge Order",
                {x = 20, y = 2},
                TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        ui.frames.orderFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.MAIN_BUTTON_HEIGHT
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 2, {x = 6, y = 0}),
            ui.frames.doubleAlignmentInnerFrame
        )
        createDoubleOrderRadioButtons()
    end

    local function setUpBottomFrame()
        ui.frames.bottomFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH,
                    height = constants.BOTTOM_FRAME_HEIGHT
                },
                "Main background color",
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 5, y = 0}),
            ui.frames.mainFrame
        )
        ui.frames.goBackFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.BOTTOM_FRAME_HEIGHT - Graphics.SIZES.BORDER_MARGIN
                },
                "Top box background color",
                "Top box border color"
            ),
            nil,
            ui.frames.bottomFrame
        )
        ui.controls.goBackButton =
            TextLabel(
            Component(
                ui.frames.goBackFrame,
                Box(
                    {x = Graphics.SIZES.MAIN_SCREEN_WIDTH - 56, y = 6},
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
    end

    local function createSingleBadgeFrames()
        local singleBadgeFrames = {}
        for i = 0, 1, 1 do
            table.insert(
                singleBadgeFrames,
                Frame(
                    Box(
                        {x = 0, y = 0},
                        {
                            width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                            height = constants.MAIN_BUTTON_HEIGHT + i * 5
                        },
                        nil,
                        nil
                    ),
                    Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 2, {x = 25, y = 0}),
                    ui.frames.singleBadgeAlignmentFrame
                )
            )
        end
        return singleBadgeFrames
    end

    local function createSingleBadgeRadioButtons(singleBadgeFrames)
        local rows = {{"ABOVE", "BELOW"}, {"RIGHT", "LEFT"}}
        for i, rowPair in pairs(rows) do
            for _, settingName in pairs(rowPair) do
                local radioButton =
                    SettingToggleButton(
                    Component(
                        singleBadgeFrames[i],
                        Box(
                            {x = 0, y = 0},
                            {width = constants.BUTTON_SIZE, height = constants.BUTTON_SIZE},
                            "Top box background color",
                            "Top box border color",
                            true,
                            "Top box background color"
                        )
                    ),
                    settings.badgesAppearance,
                    "SINGLE_BADGE_ALIGNMENT",
                    settingName,
                    true,
                    true,
                    program.saveSettings
                )
                table.insert(eventListeners, MouseClickEventListener(radioButton, onRadioButtonClick, radioButton))
                local text = settingName:sub(1, 1):upper() .. settingName:sub(2):lower()
                TextLabel(
                    Component(
                        singleBadgeFrames[i],
                        Box({x = 0, y = 0}, {width = 32, height = constants.MAIN_BUTTON_HEIGHT}, nil, nil)
                    ),
                    TextField(
                        text,
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
    end

    local function createSpacerButton()
        local spacerFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = 0
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 5, {x = 14, y = 5}),
            ui.frames.singleBadgeAlignmentFrame
        )
        local spacerButton =
            SettingToggleButton(
            Component(
                spacerFrame,
                Box(
                    {x = 0, y = 0},
                    {width = constants.BUTTON_SIZE, height = constants.BUTTON_SIZE},
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            settings.badgesAppearance,
            "SPACER",
            nil,
            false,
            true,
            program.saveSettings
        )
        local spacerLabel =
            TextLabel(
            Component(spacerFrame, Box({x = 0, y = 0}, {width = 0, height = 0}, nil, nil, false)),
            TextField(
                "Spacer",
                {x = 0, y = 0},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        table.insert(eventListeners, MouseClickEventListener(spacerButton, onSpacerClick, spacerButton))
    end

    local function setUpSingleAlignmentUI()
        ui.frames.singleBadgeAlignmentFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.SINGLE_BADGE_ALIGNMENT_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 5, {x = 0, y = 0}),
            ui.frames.topFrame
        )
        ui.controls.singleBadgeAlignmentHeading =
            TextLabel(
            Component(
                ui.frames.singleBadgeAlignmentFrame,
                Box(
                    {x = 5, y = 0},
                    {width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN, height = 18},
                    nil,
                    nil,
                    false
                )
            ),
            TextField(
                "Alignment",
                {x = 42, y = 3},
                TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        local singleBadgeFrames = createSingleBadgeFrames()
        createSingleBadgeRadioButtons(singleBadgeFrames)
        createSpacerButton()
    end

    local function createHGSSChooseButtons(frames)
        local HGSS_showBoth = {true, false}
        local settingNames = {"Show both Johto/Kanto", "Show one (will auto swap)"}
        for i, state in pairs(HGSS_showBoth) do
            local radioButton =
                SettingToggleButton(
                Component(
                    frames[i],
                    Box(
                        {x = 0, y = 0},
                        {width = constants.BUTTON_SIZE, height = constants.BUTTON_SIZE},
                        "Top box background color",
                        "Top box border color",
                        true,
                        "Top box background color"
                    )
                ),
                settings.badgesAppearance,
                "SHOW_BOTH_BADGES",
                state,
                true,
                true,
                program.saveSettings
            )
            table.insert(eventListeners, MouseClickEventListener(radioButton, onRadioButtonClick, radioButton))
            TextLabel(
                Component(frames[i], Box({x = 0, y = 0}, {width = 32, height = constants.MAIN_BUTTON_HEIGHT}, nil, nil)),
                TextField(
                    settingNames[i],
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

    local function createHGSSChooseFrames()
        local frames = {}
        for i = 1, 2, 1 do
            table.insert(
                frames,
                Frame(
                    Box(
                        {x = 0, y = 0},
                        {
                            width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                            height = constants.MAIN_BUTTON_HEIGHT
                        },
                        nil,
                        nil
                    ),
                    Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 2, {x = 14, y = 0}),
                    ui.frames.HGSSInnerFrame
                )
            )
        end
        return frames
    end

    local function setUpHGSSUI()
        ui.frames.HGSSOuterFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH,
                    height = constants.HGSS_HEADING_HEIGHT
                },
                "Main background color",
                nil
            ),
            nil,
            ui.frames.mainFrame
        )
        ui.frames.HGSSInnerFrame =
            Frame(
            Box(
                {x = 5, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = 55
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 5),
            ui.frames.HGSSOuterFrame
        )
        ui.controls.HGSSHeading =
            TextLabel(
            Component(
                ui.frames.HGSSInnerFrame,
                Box(
                    {x = 5, y = 0},
                    {width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN, height = 16}
                )
            ),
            TextField(
                "HGSS Settings",
                {x = 34, y = 3},
                TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        local showBothFrames = createHGSSChooseFrames()
        createHGSSChooseButtons(showBothFrames)
    end

    local function initUI()
        ui.controls = {}
        ui.frames = {}
        ui.frames.mainFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH + Graphics.SIZES.MAIN_SCREEN_WIDTH + 48, y = 0},
                {width = 0, height = 0},
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, -7),
            nil
        )
        ui.frames.topFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH,
                    height = constants.TOP_FRAME_HEIGHT
                },
                "Main background color",
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 5, y = 5}),
            ui.frames.mainFrame
        )
        ui.controls.topHeading =
            TextLabel(
            Component(
                ui.frames.topFrame,
                Box(
                    {x = 5, y = 5},
                    {width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN, height = 18},
                    "Top box background color",
                    "Top box border color",
                    false
                )
            ),
            TextField(
                "Badges Appearance",
                {x = 14, y = 1},
                TextStyle(13, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        setUpHGSSUI()
        setUpSingleAlignmentUI()
        setUpDoubleAlignmentUI()
        setUpBottomFrame()
        table.insert(eventListeners, MouseClickEventListener(ui.controls.goBackButton, onGoBackClick))
    end

    function self.runEventListeners()
        for _, eventListener in pairs(eventListeners) do
            eventListener.listen()
        end
    end

    function self.show()
        local gameName = program.getGameInfo().NAME
        ui.frames.HGSSOuterFrame.setVisibility(gameName == "Pokemon HeartGold" or gameName == "Pokemon SoulSilver")
        ui.frames.doubleAlignmentOuterFrame.setVisibility(
            settings.badgesAppearance.SHOW_BOTH_BADGES and ui.frames.HGSSOuterFrame.isVisible()
        )
        ui.frames.mainFrame.show()
    end

    initUI()
    return self
end

return BadgesAppearanceScreen

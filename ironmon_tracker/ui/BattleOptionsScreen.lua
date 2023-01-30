local function BattleOptionsScreen(initialSettings, initialTracker, initialProgram)
	local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
	local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
	local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/cOMPONENT.lua")
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
        BATTLE_OPTIONS_HEIGHT = 124,
        TOGGLE_FRAME_WIDTH = 200,
        TOGGLE_FRAME_HEIGHT = 12,
        BUTTON_SIZE = 10
    }
    local ui = {}
    local eventListeners = {}
    local self = {}
    local function onGoBackClick()
        program.setCurrentScreens({program.UI_SCREENS.MAIN_OPTIONS_SCREEN})
        program.drawCurrentScreens()
    end
    local function onToggleClick(button)
        button.onClick()
        if not settings.battle.ENABLE_ENEMY_LOCKING then
            program.unlockEnemy()
        end
        program.drawCurrentScreens()
    end
    local function initBattleToggleButtons()
        local orderedKeys = {
            "SHOW_MOVE_EFFECTIVENESS",
            "CALCULATE_VARIABLE_DAMAGE",
            "SHOW_ACTUAL_ENEMY_PP",
            "SHOW_1ST_FIGHT_STATS_PLATINUM",
            "ENABLE_ENEMY_LOCKING"
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
                Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 2),
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
                false,
                true,
                program.saveSettings
            )
            local labelName
            if key == "SHOW_1ST_FIGHT_STATS_PLATINUM" then
                labelName = "Platinum: Show 1st fight stats"
            else
                labelName = key:gsub("_", " "):lower()
                labelName = labelName:sub(1, 1):upper() .. labelName:sub(2)
            end
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
    local function initUI()
        ui.controls = {}
        ui.frames = {}
        ui.frames.mainFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = constants.BATTLE_OPTIONS_HEIGHT},
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
                    height = constants.BATTLE_OPTIONS_HEIGHT - 2 * Graphics.SIZES.BORDER_MARGIN
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 2, {x = 4, y = 22}),
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
                "Battle Settings",
                {x = 28, y = 1},
                TextStyle(13, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        ui.controls.goBackButton =
            TextLabel(
            Component(
                ui.frames.mainFrame,
                Box(
                    {x = Graphics.SIZES.MAIN_SCREEN_WIDTH - 49, y = constants.BATTLE_OPTIONS_HEIGHT - 23},
                    {width = 40, height = 14},
                    "Top box background color",
                    "Top box border color", true, "Top box background color"
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
        table.insert(eventListeners,MouseClickEventListener(ui.controls.goBackButton,onGoBackClick))
        initBattleToggleButtons()
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

return BattleOptionsScreen

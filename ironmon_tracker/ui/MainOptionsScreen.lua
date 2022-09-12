local function MainOptionsScreen(initialSettings, initialTracker, initialProgram)
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
		MAIN_OPTIONS_HEIGHT = 176,
		MAIN_BUTTONS_Y_OFFSET = 23,
		MAIN_BUTTONS_X_OFFSET = 15,
		MAIN_BUTTON_SPACING = 5,
		MAIN_BUTTON_WIDTH = 110,
		MAIN_BUTTON_HEIGHT = 19
	}
	local ui = {}
	local eventListeners = {
		battleSettingsClickListener = nil,
		trackerAppearanceClickListener = nil,
		trackedPokemonClickListener = nil,
		editControlsClickListener = nil,
		quickLoadClickListener = nil,
		goBackClickListener = nil
	}
	local self = {}
	local function onTrackerAppearanceClick()
		program.setCurrentScreens({program.UI_SCREENS.APPEARANCE_OPTIONS_SCREEN})
		program.drawCurrentScreens()
	end
	local function onBattleSettingsClick()
		program.setCurrentScreens({program.UI_SCREENS.BATTLE_OPTIONS_SCREEN})
		program.drawCurrentScreens()
	end
	local function onTrackedPokemonClick()
		program.setCurrentScreens({program.UI_SCREENS.TRACKED_POKEMON_SCREEN, program.UI_SCREENS.MAIN_SCREEN})
		program.setUpForTrackedPokemonView()
		program.moveMainScreen({x = Graphics.SIZES.SCREEN_WIDTH, y = 40})
		program.drawCurrentScreens()
	end
	local function onEditControlsClick()
		program.setCurrentScreens({program.UI_SCREENS.EDIT_CONTROLS_SCREEN})
		program.drawCurrentScreens()
	end
	local function onQuickLoadClick()
		program.setCurrentScreens({program.UI_SCREENS.QUICK_LOAD_SCREEN})
		program.drawCurrentScreens()
	end
	local function onGoBackClick()
		program.setCurrentScreens({program.UI_SCREENS.MAIN_SCREEN})
		program.drawCurrentScreens()
	end

	local function initEventListeners()
		eventListeners.goBackClickListener = MouseClickEventListener(ui.controls.goBackButton, onGoBackClick)
		eventListeners.battleSettingsClickListener =
			MouseClickEventListener(ui.frames.battleSettingsButtonFrame, onBattleSettingsClick)
		eventListeners.trackerAppearanceClickListener =
			MouseClickEventListener(ui.frames.trackerAppearanceButtonFrame, onTrackerAppearanceClick)
		eventListeners.trackedPokemonClickListener =
			MouseClickEventListener(ui.frames.trackedPokemonButtonFrame, onTrackedPokemonClick)
		eventListeners.editControlsClickListener =
			MouseClickEventListener(ui.frames.editControlsButtonFrame, onEditControlsClick)
		eventListeners.quickLoadClickListener =
			MouseClickEventListener(ui.frames.quickLoadButtonFrame, onQuickLoadClick)
	end
	local function initBottomFrameControls()
		TextLabel(
			Component(ui.frames.bottomFrame, Box({x = 0, y = 0}, {width = 92, height = 18}, nil, nil)),
			TextField(
				"Tracker version: " .. MiscConstants.TRACKER_VERSION,
				{x = 4, y = 1},
				TextStyle(
					Graphics.FONT.DEFAULT_FONT_SIZE,
					Graphics.FONT.DEFAULT_FONT_FAMILY,
					"Top box text color",
					"Top box background color"
				)
			)
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
	end
	local function initMainButtons()
		local buttonNames = {
			battleSettingsButton = "Battle Settings",
			trackerAppearanceButton = "Tracker Appearance",
			trackedPokemonButton = "Tracked Pok\233mon ",
			editControlsButton = "Edit Controls",
			quickLoadButton = "QuickLoad Settings"
		}
		local icons = {"SWORD", "SPARKLES", "PENCIL", "CONTROLLER", "LIGHTNING_BOLT"}
		local order = {
			"battleSettingsButton",
			"trackerAppearanceButton",
			"trackedPokemonButton",
			"editControlsButton",
			"quickLoadButton"
		}
		for i, key in pairs(order) do
			local text = buttonNames[key]
			local iconName = icons[i]
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
				ui.frames.mainButtonFrame
			)
			Icon(
				Component(ui.frames[frameName], Box({x = 0, y = 0}, {width = 16, height = 16}, nil, nil)),
				iconName,
				{x = 2, y = 2}
			)
			ui.controls[key] =
				TextLabel(
				Component(
					ui.frames[frameName],
					Box({x = 0, y = 0}, {width = constants.MAIN_BUTTON_WIDTH - 18, height = constants.MAIN_BUTTON_HEIGHT})
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
				{width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = constants.MAIN_OPTIONS_HEIGHT},
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
					height = constants.MAIN_OPTIONS_HEIGHT - 2 * Graphics.SIZES.BORDER_MARGIN
				},
				"Top box background color",
				"Top box border color"
			),
			nil,
			ui.frames.mainFrame
		)
		ui.frames.mainButtonFrame =
			Frame(
			Box({x = constants.MAIN_BUTTONS_X_OFFSET, y = constants.MAIN_BUTTONS_Y_OFFSET}, {width = 0, height = 0}, nil, nil),
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, constants.MAIN_BUTTON_SPACING),
			ui.frames.mainInnerFrame
		)
		ui.frames.bottomFrame =
			Frame(
			Box(
				{x = 0, y = constants.MAIN_BUTTONS_Y_OFFSET + 122},
				{
					width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
					height = 21
				},
				nil,
				nil
			),
			Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 4, {x = 0, y = 3}),
			ui.frames.mainInnerFrame
		)
		ui.controls.topHeading =
			TextLabel(
			Component(
				ui.frames.mainInnerFrame,
				Box(
					{x = 0, y = 0},
					{width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN, height = 18},
					"Top box background color",
					"Top box border color",
					false
				)
			),
			TextField(
				"Config",
				{x = 48, y = 1},
				TextStyle(13, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
			)
		)
		initMainButtons()
		initBottomFrameControls()
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
	initEventListeners()
	return self
end

return MainOptionsScreen

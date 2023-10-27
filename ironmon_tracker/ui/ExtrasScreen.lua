local function ExtrasScreen(initialSettings, initialTracker, initialProgram)
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
	local SettingToggleButton = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/SettingToggleButton.lua")
	local settings = initialSettings
	local tracker = initialTracker
	local program = initialProgram
	local tourneyTracker

	local self = {}

	local constants = {
		MAIN_FRAME_HEIGHT = 230,
		EXTRAS_HEIGHT = 176,
		EXTRA_ENTRY_TITLE_ROW_HEIGHT = 21,
		EXTRA_ENTRY_TEXT_ROW_HEIGHT = 10,
		EXTRA_WIDTH = 124,
		EXTRA_HEIGHT = 90,
		BUTTON_SIZE = 10
	}
	local ui = {}
	local eventListeners = {}

	local function onToggleClick(button)
		button.onClick()
		if settings.tourneyTracker.ENABLED then
			tourneyTracker.loadData()
		end
		program.drawCurrentScreens()
	end

	local function initBottomFrame()
		ui.frames.goBackFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = 0,
					height = 0
				}
			),
			nil,
			ui.frames.mainInnerFrame
		)
		ui.controls.goBackButton =
			TextLabel(
			Component(
				ui.frames.goBackFrame,
				Box(
					{x = Graphics.SIZES.MAIN_SCREEN_WIDTH - 54, y = 8},
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
			MouseClickEventListener(ui.controls.goBackButton, program.openScreen, program.UI_SCREENS.MAIN_OPTIONS_SCREEN)
		)
	end

	local function onClearClick()
		FormsUtils.createConfirmDialog(tourneyTracker.clearData)
	end

	local function onCoverageCalc()
		program.openScreen(program.UI_SCREENS.COVERAGE_CALC_SCREEN)
	end

	local extras = {
		{
			name = "Coverage Calc",
			iconImage = "coverageCalc.png",
			imageOffset = {x = 2, y = 2},
			descriptionRows = {
				"Shows how many Pok" .. Chars.accentedE .. "mon",
				"your moves can hit."
			},
			settingsKey = "coverageCalc",
			useEnabledButton = false,
			buttonText = "Open",
			buttonFunction = onCoverageCalc
		},
		{
			name = "Tourney Tracker",
			iconImage = "trophy.png",
			imageOffset = {x = 0, y = 0},
			descriptionRows = {
				"Auto tracks your scores",
				"for Crozwords' tourneys."
			},
			settingsKey = "tourneyTracker",
			useEnabledButton = true,
			buttonText = "Clear Tourney Scores",
			buttonFunction = onClearClick
		}
	}

	local function createEnabledButtons(extra, extraFrame)
		local enabledFrame =
			Frame(
			Box({x = 0, y = 0}, {width = 0, height = 18}, nil, nil),
			Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 2, {x = 2, y = 4}),
			extraFrame
		)
		local toggle =
			SettingToggleButton(
			Component(
				enabledFrame,
				Box(
					{x = 0, y = 0},
					{width = constants.BUTTON_SIZE, height = constants.BUTTON_SIZE},
					"Top box background color",
					"Top box border color",
					true,
					"Top box background color"
				)
			),
			settings[extra.settingsKey],
			"ENABLED",
			nil,
			false,
			true,
			program.saveSettings
		)
		table.insert(eventListeners, MouseClickEventListener(toggle, onToggleClick, toggle))
		local label =
			TextLabel(
			Component(enabledFrame, Box({x = 0, y = 0}, {width = 0, height = 0}, nil, nil, false)),
			TextField(
				"Enabled",
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

	local function initExtra(extra)
		local extraFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = constants.EXTRA_WIDTH,
					height = constants.EXTRA_HEIGHT
				},
				"Top box background color",
				"Top box border color",
				true,
				"Top box background color"
			),
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 2, {x = 4, y = 1}),
			ui.frames.extrasFrame
		)
		local iconNameFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = 0,
					height = constants.EXTRA_ENTRY_TITLE_ROW_HEIGHT
				}
			),
			Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = -1, y = 4}),
			extraFrame
		)
		local iconPath =
			Paths.CURRENT_DIRECTORY ..
			Paths.SLASH .. "ironmon_tracker" .. Paths.SLASH .. "images" .. Paths.SLASH .. "icons" .. Paths.SLASH .. extra.iconImage
		local icon =
			ImageLabel(
			Component(iconNameFrame, Box({x = 0, y = 0}, {width = 15, height = 14})),
			ImageField(iconPath, extra.imageOffset, nil)
		)
		local title =
			TextLabel(
			Component(iconNameFrame, Box({x = 0, y = 0}, {width = 0, height = 0})),
			TextField(
				extra.name,
				{x = 1, y = 0},
				TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
			)
		)
		local rows = {}
		for i = 1, 2, 1 do
			rows[i] =
				TextLabel(
				Component(extraFrame, Box({x = 0, y = 0}, {width = 0, height = constants.EXTRA_ENTRY_TEXT_ROW_HEIGHT})),
				TextField(
					extra.descriptionRows[i] or "",
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

		if extra.useEnabledButton then
			createEnabledButtons(extra, extraFrame)
		else
			rows[2].resize({width = 0, height = constants.EXTRA_ENTRY_TEXT_ROW_HEIGHT + 3})
			extraFrame.resize(
				{
					width = constants.EXTRA_WIDTH,
					height = constants.EXTRA_HEIGHT - 17
				}
			)
		end

		local textOffset = (116 - DrawingUtils.calculateWordPixelLength(extra.buttonText)) / 2
		local button =
			TextLabel(
			Component(
				extraFrame,
				Box(
					{x = 0, y = 0},
					{width = 116, height = 18},
					"Top box background color",
					"Top box border color",
					true,
					"Top box background color"
				)
			),
			TextField(
				extra.buttonText,
				{x = textOffset, y = 3},
				TextStyle(
					Graphics.FONT.DEFAULT_FONT_SIZE,
					Graphics.FONT.DEFAULT_FONT_FAMILY,
					"Top box text color",
					"Top box background color"
				)
			)
		)

		table.insert(eventListeners, MouseClickEventListener(button, extra.buttonFunction))
	end

	local function initExtrasUI()
		ui.frames.extrasFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = 0,
					height = constants.EXTRAS_HEIGHT
				}
			),
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 5, {x = 8, y = 8}),
			ui.frames.mainInnerFrame
		)
		for _, extra in pairs(extras) do
			initExtra(extra)
		end
	end

	function self.injectExtraRelatedClasses(newTourneyTracker)
		tourneyTracker = newTourneyTracker
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
			Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 5, y = 5}),
			nil
		)
		ui.frames.mainInnerFrame =
			Frame(
			Box(
				{x = Graphics.SIZES.BORDER_MARGIN, y = Graphics.SIZES.BORDER_MARGIN},
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
					{x = 0, y = 0},
					{width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN, height = 18},
					"Top box background color",
					"Top box border color",
					false
				)
			),
			TextField(
				"Extras",
				{x = 50, y = 1},
				TextStyle(13, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
			)
		)
		initExtrasUI()
		initBottomFrame()
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

return ExtrasScreen

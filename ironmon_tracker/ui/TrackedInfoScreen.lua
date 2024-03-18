local function TrackedInfoScreen(initialSettings, initialTracker, initialProgram)
	local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
	local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
	local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
	local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
	local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
	local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
	local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
	local SettingToggleButton = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/SettingToggleButton.lua")
	local Icon = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Icon.lua")
	local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
	local settings = initialSettings
	local tracker = initialTracker
	local program = initialProgram
	local constants = {
		TRACKED_INFO_HEIGHT = 274,
		MAIN_BUTTONS_Y_OFFSET = 5,
		MAIN_BUTTONS_X_OFFSET = 15,
		MAIN_BUTTON_SPACING = 3,
		MAIN_BUTTON_WIDTH = 110,
		MAIN_BUTTON_HEIGHT = 19,
		BUTTONS_FRAME_HEIGHT = 149,
		FAINT_DETECTION_FRAME_HEIGHT = 75,
		FAINT_DETECTION_ROW_HEIGHT = 13,
		BUTTON_SIZE = 10
	}
	local ui = {}
	local eventListeners = {
		battleSettingsClickListener = nil,
		trackerAppearanceClickListener = nil,
		trackedInfoClickListener = nil,
		editControlsClickListener = nil,
		quickLoadClickListener = nil,
		goBackClickListener = nil
	}
	local self = {}

	local function onTrackedPokemonClick()
		program.setCurrentScreens({program.UI_SCREENS.TRACKED_POKEMON_SCREEN, program.UI_SCREENS.MAIN_SCREEN})
		program.setUpForTrackedPokemonView()
		program.drawCurrentScreens()
	end

	local function onOpenLogClick()
		local soundOn = client.GetSoundOn()
		client.SetSoundOn(false)
		local logPath = forms.openfile("*.log", Paths.CURRENT_DIRECTORY)
		program.openLogFromPath(logPath)
		client.SetSoundOn(soundOn)
	end

	local function onLoadTrackerDataClick()
		local soundOn = client.GetSoundOn()
		client.SetSoundOn(false)
		local trackerDataPath =
			forms.openfile("*.trackerdata", Paths.CURRENT_DIRECTORY .. Paths.SLASH .. "savedData" .. Paths.SLASH)
		if trackerDataPath ~= nil then
			tracker.loadExternalTrackerDataFile(trackerDataPath)
		end
		client.SetSoundOn(soundOn)
	end

	local function initEventListeners()
		eventListeners.goBackClickListener =
			MouseClickEventListener(ui.controls.goBackButton, program.openScreen, program.UI_SCREENS.MAIN_OPTIONS_SCREEN)
		eventListeners.logOpenListener = MouseClickEventListener(ui.frames.openLogButtonFrame, onOpenLogClick)
		eventListeners.trackedPokemonClickListener =
			MouseClickEventListener(ui.frames.trackedPokemonButtonFrame, onTrackedPokemonClick)
		eventListeners.pastRunsListeners =
			MouseClickEventListener(ui.frames.pastRunsButtonFrame, program.openScreen, program.UI_SCREENS.PAST_RUNS_SCREEN)
		eventListeners.statsListener =
			MouseClickEventListener(ui.frames.statisticsButtonFrame, program.openScreen, program.UI_SCREENS.STATISTICS_SCREEN)
		eventListeners.openRestorePoints =
			MouseClickEventListener(
			ui.frames.openRestorePointsButtonFrame,
			program.openScreen,
			program.UI_SCREENS.RESTORE_POINTS_SCREEN
		)
		eventListeners.loadTrackerData = MouseClickEventListener(ui.frames.loadTrackerDataButtonFrame, onLoadTrackerDataClick)
	end

	local function initBottomFrameControls()
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
			trackedPokemonButton = "Tracked Pok" .. Chars.accentedE .. "mon",
			pastRunsButton = "Past Runs",
			statisticsButton = "Statistics",
			openLogButton = "Open a Log",
			openRestorePointsButton = "Restore Points",
			loadTrackerDataButton = "Load Tracker Data"
		}
		local icons = {"PENCIL", "PAST_RUN_ICON", "STATISTICS_ICON", "OPEN_LOG_ICON", "RESTORE_POINTS_ICON", "LOAD_TRACKER_DATA"}
		local order = {
			"trackedPokemonButton",
			"pastRunsButton",
			"statisticsButton",
			"openLogButton",
			"openRestorePointsButton",
			"loadTrackerDataButton"
		}
		local iconOffsets = {
			{x = 2, y = 2},
			{x = 3, y = 2},
			{x = 3, y = 2},
			{x = 3, y = 2},
			{x = 3, y = 3},
			{x = 3, y = 2}
		}
		for i, key in pairs(order) do
			local text = buttonNames[key]
			local iconName = icons[i]
			local frameName = key .. "Frame"
			local frameInfo =
				FrameFactory.createScreenOpeningFrame(
				ui.frames.mainButtonFrame,
				constants.MAIN_BUTTON_WIDTH,
				constants.MAIN_BUTTON_HEIGHT,
				iconName,
				iconOffsets[i],
				text
			)
			ui.frames[frameName] = frameInfo.frame
			ui.controls[order[i]] = frameInfo.button
		end
	end

	local function onFaintDetectionClick(button)
		button.onClick()
		program.drawCurrentScreens()
	end

	local function createFaintDetectionChoosingRow(settingKey, settingValue, labelName)
		local frame =
			Frame(
			Box(
				{x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
				{
					width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
					height = constants.FAINT_DETECTION_ROW_HEIGHT
				},
				nil,
				nil
			),
			Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 3),
			ui.frames.faintDetectionFrame
		)
		local radioButton =
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
			settings.trackedInfo,
			settingKey,
			settingValue,
			true,
			true,
			program.saveSettings
		)
		local label =
			TextLabel(
			Component(frame, Box({x = 0, y = 0}, {width = 0, height = 0})),
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
		table.insert(eventListeners, MouseClickEventListener(radioButton, onFaintDetectionClick, radioButton))
	end

	local function initFaintDetectionUI()
		ui.frames.faintDetectionFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
					height = constants.FAINT_DETECTION_FRAME_HEIGHT
				},
				"Top box background color",
				"Top box border color"
			),
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 5, {x = 5, y = 5}),
			ui.frames.mainInnerFrame
		)
		ui.controls.faintDetectionLabel =
			TextLabel(
			Component(ui.frames.faintDetectionFrame, Box({x = 0, y = 0}, {width = 0, height = 13})),
			TextField(
				"Run is considered over when:",
				{x = -1, y = 0},
				TextStyle(
					Graphics.FONT.DEFAULT_FONT_SIZE,
					Graphics.FONT.DEFAULT_FONT_FAMILY,
					"Top box text color",
					"Top box background color"
				)
			)
		)
		local settingNames = {
			[PlaythroughConstants.FAINT_DETECTIONS.ON_FIRST_SLOT_FAINT] = "Lead Pok" .. Chars.accentedE .. "mon faints",
			[PlaythroughConstants.FAINT_DETECTIONS.ON_HIGHEST_LEVEL_FAINT] = "Highest level faints",
			[PlaythroughConstants.FAINT_DETECTIONS.ON_ENTIRE_PARTY_FAINT] = "Entire party faints"
		}
		for settingValue, name in pairs(settingNames) do
			createFaintDetectionChoosingRow("FAINT_DETECTION", settingValue, name)
		end
	end

	local function initUI()
		ui.controls = {}
		ui.frames = {}
		ui.frames.mainFrame =
			Frame(
			Box(
				{x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
				{width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = constants.TRACKED_INFO_HEIGHT},
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
					height = constants.TRACKED_INFO_HEIGHT - 2 * Graphics.SIZES.BORDER_MARGIN
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
				"Tracked Info",
				{x = 36, y = 1},
				TextStyle(13, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
			)
		)
		ui.frames.mainButtonFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN, height = constants.BUTTONS_FRAME_HEIGHT},
				"Top box background color",
				"Top box border color"
			),
			Layout(
				Graphics.ALIGNMENT_TYPE.VERTICAL,
				constants.MAIN_BUTTON_SPACING,
				{x = constants.MAIN_BUTTONS_X_OFFSET, y = constants.MAIN_BUTTONS_Y_OFFSET}
			),
			ui.frames.mainInnerFrame
		)
		initFaintDetectionUI()
		ui.frames.bottomFrame =
			Frame(
			Box(
				{x = 0, y = constants.MAIN_BUTTONS_Y_OFFSET + 104},
				{
					width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
					height = 22
				},
				"Top box background color",
				"Top box border color"
			),
			Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 4, {x = 96, y = 4}),
			ui.frames.mainInnerFrame
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
return TrackedInfoScreen

local function RunOverScreen(initialSettings, initialTracker, initialProgram)
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
		MAX_MESSAGE_WIDTH = Graphics.SIZES.MAIN_SCREEN_WIDTH - 20,
		RUN_OVER_HEIGHT = 124,
		BUTTON_WIDTH = 48,
	}
	local ui = {}
	local eventListeners = {}
	local self = {}

	local function openLogIfNoneFound()
		local soundOn = client.GetSoundOn()
		client.SetSoundOn(false)
		local logPath = forms.openfile("*.log", Paths.CURRENT_DIRECTORY)
		program.openLogFromPath(logPath)
		client.SetSoundOn(soundOn)
	end

	function self.initialize(runOverMessage)
		local messageLines = DrawingUtils.textToWrappedArray(runOverMessage, constants.MAX_MESSAGE_WIDTH)
		for i, line in pairs(messageLines) do
			if i < 5 then
				ui.controls.messageLines[i].setText(line)
			end
		end
	end

	local function initRunOverMessageUI()
		ui.frames.messagesFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = 0,
					height = 68
				},
				nil,
				nil
			),
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 5, y = 5}),
			ui.frames.mainInnerFrame
		)
		ui.controls.messageLines = {}
		for i = 1, 4, 1 do
			ui.controls.messageLines[i] =
				TextLabel(
				Component(ui.frames.messagesFrame, Box({x = 0, y = 0}, {width = 0, height = 14})),
				TextField(
					"",
					{x = 0, y = 1},
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
	
	local function onDismissClick()
		program.openScreen(program.UI_SCREENS.MAIN_SCREEN)
	end

	local function onOpenLogClick()
		local startingFolder = Paths.CURRENT_DIRECTORY.."\\"
		if settings.quickLoad.LOAD_TYPE == "USE_BATCH" then
			if settings.quickLoad.ROMS_FOLDER_PATH == nil or settings.quickLoad.ROMS_FOLDER_PATH == "" then
				return
			end
			startingFolder = settings.quickLoad.ROMS_FOLDER_PATH .."\\"
		end

		local romName = gameinfo.getromname()
		local logPath = startingFolder .. romName .. ".nds.log"

		local fileExists = FormsUtils.fileExists(logPath)
		if not fileExists then
			logPath = logPath:gsub(" ", "_")
			fileExists = FormsUtils.fileExists(logPath)
		end
		if not fileExists then
			openLogIfNoneFound()
		else
			program.openLogFromPath(logPath)
		end
	end

	local function initBottomFrameControls()
		ui.frames.bottomFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
					height = 21
				},
				nil,
				nil
			),
			Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 14, {x = 15, y = 0}),
			ui.frames.mainInnerFrame
		)
		ui.controls.dismissButton =
			TextLabel(
			Component(
				ui.frames.bottomFrame,
				Box(
					{x = 0, y = 0},
					{width = constants.BUTTON_WIDTH, height = 18},
					"Top box background color",
					"Top box border color",
					true,
					"Top box background color"
				)
			),
			TextField(
				"Dismiss",
				{x = 7, y = 3},
				TextStyle(
					Graphics.FONT.DEFAULT_FONT_SIZE,
					Graphics.FONT.DEFAULT_FONT_FAMILY,
					"Top box text color",
					"Top box background color"
				)
			)
		)
		ui.controls.openLogButton =
			TextLabel(
			Component(
				ui.frames.bottomFrame,
				Box(
					{x = 0, y = 0},
					{width = constants.BUTTON_WIDTH, height = 18},
					"Top box background color",
					"Top box border color",
					true,
					"Top box background color"
				)
			),
			TextField(
				"Open Log",
				{x = 4, y = 3},
				TextStyle(
					Graphics.FONT.DEFAULT_FONT_SIZE,
					Graphics.FONT.DEFAULT_FONT_FAMILY,
					"Top box text color",
					"Top box background color"
				)
			)
		)
		table.insert(eventListeners, MouseClickEventListener(ui.controls.dismissButton, onDismissClick))
		table.insert(eventListeners, MouseClickEventListener(ui.controls.openLogButton, onOpenLogClick))

	end

	local function initUI()
		ui.controls = {}
		ui.frames = {}
		ui.frames.mainFrame =
			Frame(
			Box(
				{x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
				{width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = constants.RUN_OVER_HEIGHT},
				"Main background color",
				nil
			),
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL,0,{x=5,y=5}),
			nil
		)
		ui.frames.mainInnerFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
					height = constants.RUN_OVER_HEIGHT - 2 * Graphics.SIZES.BORDER_MARGIN
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
					{x = 5, y = 5},
					{width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN, height = 18},
					"Top box background color",
					"Top box border color",
					false
				)
			),
			TextField(
				"Run Over!",
				{x = 42, y = 1},
				TextStyle(13, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
			)
		)
		initRunOverMessageUI()
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

	return self
end

return RunOverScreen

local function updatenotesscreen(initialSettings, initialTracker, initialProgram)
	local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
	local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
	local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/cOMPONENT.lua")
	local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
	local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
	local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
	local ScrollBar = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ScrollBar.lua")
	local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
	local Icon = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Icon.lua")
	local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
	local settings = initialSettings
	local tracker = initialTracker
	local program = initialProgram
	local constants = {
		MAX_MESSAGE_WIDTH = Graphics.SIZES.MAIN_SCREEN_WIDTH - 20,
		NOTES_ROW_HEIGHT = 12,
		BUTTON_WIDTH = 39,
		NOTES_MAIN_HEIGHT = Graphics.SIZES.MAIN_SCREEN_HEIGHT + 30
	}
	local ui = {}
	local eventListeners = {}
	local self = {}
	local noteRows = {}
	local notesScroller

	local function readNotesScroller()
		local viewedNotes = notesScroller.getViewedItems()
		for i, note in pairs(viewedNotes) do
			noteRows[i].setText(note)
		end
		program.drawCurrentScreens()
	end

	local function setUpScroller()
		local notes = MiscConstants.UPDATE_NOTES
		local notesWrapped = {}
		for _, note in pairs(notes) do
			local wrapped = DrawingUtils.textToWrappedArray(note, constants.MAX_MESSAGE_WIDTH)
			wrapped[#wrapped + 1] = ""
			MiscUtils.combineTables(notesWrapped, wrapped)
		end
		--remove last spacer
		notesWrapped[#notesWrapped] = nil
		notesScroller.setItems(notesWrapped)
		notesScroller.setScrollReadingFunction(readNotesScroller)
	end

	local function createTextRow(index)
		noteRows[index] =
			TextLabel(
			Component(ui.frames.noteTextRowsFrame, Box({x = 0, y = 0}, {width = 0, height = constants.NOTES_ROW_HEIGHT})),
			TextField(
				"",
				{x = 0, y = 2},
				TextStyle(
					Graphics.FONT.DEFAULT_FONT_SIZE,
					Graphics.FONT.DEFAULT_FONT_FAMILY,
					"Top box text color",
					"Top box background color"
				)
			)
		)
	end

	local function initNotesScrollbar()
		local mainFrameSize = ui.frames.mainInnerFrame.getSize()
		ui.frames.notesScrollerFrame =
			Frame(
			Box(
				{
					x = 30,
					y = 0
				},
				{
					width = mainFrameSize.width,
					height = mainFrameSize.height - 46
				},
				"Top box background color",
				"Top box border color"
			),
			nil,
			ui.frames.mainInnerFrame
		)
		ui.frames.noteTextRowsFrame =
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
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 5, y = 2}),
			ui.frames.notesScrollerFrame
		)
		for i = 1, 9, 1 do
			createTextRow(i)
		end
		notesScroller = ScrollBar(ui.frames.notesScrollerFrame, 9, {})
	end

	local function onCloseClick()
		program.openScreen(program.UI_SCREENS.MAIN_SCREEN)
		program.checkForUpdateBeforeLoading()
	end

	local function initBottomFrameControls()
		ui.frames.bottomFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = 0,
					height = 0
				},
				nil,
				nil
			),
			Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 49, y = 5}),
			ui.frames.mainInnerFrame
		)
		ui.controls.closeButton =
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
				"Close",
				{x = 8, y = 3},
				TextStyle(
					Graphics.FONT.DEFAULT_FONT_SIZE,
					Graphics.FONT.DEFAULT_FONT_FAMILY,
					"Top box text color",
					"Top box background color"
				)
			)
		)
		table.insert(eventListeners, MouseClickEventListener(ui.controls.closeButton, onCloseClick))
	end

	local function initUI()
		ui.controls = {}
		ui.frames = {}
		ui.frames.mainFrame =
			Frame(
			Box(
				{x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
				{width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = constants.NOTES_MAIN_HEIGHT},
				"Main background color",
				nil
			),
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 5, y = 5}),
			nil
		)
		ui.frames.mainInnerFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
					height = constants.NOTES_MAIN_HEIGHT - 2 * Graphics.SIZES.BORDER_MARGIN
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
				"Update " .. MiscConstants.TRACKER_VERSION,
				{x = 36, y = 1},
				TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
			)
		)
		initNotesScrollbar()
		initBottomFrameControls()
		setUpScroller()
	end

	function self.runEventListeners()
		for _, eventListener in pairs(eventListeners) do
			eventListener.listen()
		end
		notesScroller.update()
	end

	function self.initialize()
		readNotesScroller()
	end

	function self.show()
		ui.frames.mainFrame.show()
	end

	initUI()

	return self
end

return updatenotesscreen

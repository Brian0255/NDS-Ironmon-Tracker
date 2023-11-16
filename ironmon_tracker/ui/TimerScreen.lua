local function TimerScreen(initialSettings, initialTracker, initialProgram)
	local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
	local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
	local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
	local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
	local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
	local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
	local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
	local DragDropEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/DragDropEventListener.lua")

	local settings = initialSettings
	local tracker = initialTracker
	local program = initialProgram
	local prevTransparent = nil
	local canDraw = true
	local ui = {}
	local eventListeners = {}
	local self = {}
	local pausedSeconds = 0
	local startSeconds = os.time() - tracker.getTimerSeconds()
	local timeDeduct = 0
	local lastCheckedSeconds = os.time()
	local paused = false

	local function pause()
		pausedSeconds = os.time()
	end

	local function unpause()
		local secondsPaused = os.time() - pausedSeconds
		timeDeduct = timeDeduct + secondsPaused
	end

	local function onTimerDragEnd()
		eventListeners["timerDrag"] = nil
		local newTimerPos = ui.controls.timer.getPosition()
		settings.timer.XPOS = newTimerPos.x
		settings.timer.YPOS = newTimerPos.y
		program.drawCurrentScreens()
		program.saveSettings()
	end

	local function onTimerMiddleClick()
		eventListeners["timerDrag"] = DragDropEventListener(ui.controls.timer, onTimerDragEnd, nil, program.drawCurrentScreens)
	end

	local function onTimerLeftClick()
		paused = not paused
		if paused then
			pause()
		else
			unpause()
		end
	end

	local function updateTimerColors()
		if settings.timer.TRANSPARENT then
			ui.controls.timer.setOpacity(0x60)
			ui.controls.timer.setBackgroundFillColorKey("Black")
			ui.controls.timer.setBackgroundColorKey("Black")
			ui.controls.timer.setTextColorKey("White")
			ui.controls.timer.setShadowColorKey()
		else
			ui.controls.timer.setOpacity(0xFF)
			ui.controls.timer.setBackgroundFillColorKey("Top box border color")
			ui.controls.timer.setBackgroundColorKey("Top box background color")
			ui.controls.timer.setShadowColorKey("Top box background color")
			ui.controls.timer.setTextColorKey("Top box text color")
		end
	end

	local function initUI()
		ui.controls = {}
		ui.frames = {}
		ui.frames.mainFrame = Frame(Box({x = 0, y = 0}, {width = 0, height = 0}))
		ui.controls.timer =
			TextLabel(
			Component(
				ui.frames.mainFrame,
				Box(
					{x = settings.timer.XPOS, y = settings.timer.YPOS},
					{width = 38, height = 11},
					"Top box background color",
					"Top box background color"
				)
			),
			TextField(
				"00:00:00",
				{x = 1, y = 0},
				TextStyle(
					Graphics.FONT.DEFAULT_FONT_SIZE,
					Graphics.FONT.DEFAULT_FONT_FAMILY,
					"Top box text color",
					"Top box background color"
				)
			)
		)
		table.insert(eventListeners, MouseClickEventListener(ui.controls.timer, onTimerMiddleClick, nil, nil, nil, "Middle"))
		table.insert(eventListeners, MouseClickEventListener(ui.controls.timer, onTimerLeftClick))
		updateTimerColors()
	end

	function self.runEventListeners()
		for _, eventListener in pairs(eventListeners) do
			eventListener.listen()
		end
		if settings.timer.TRANSPARENT ~= prevTransparent then
			updateTimerColors()
		end
		prevTransparent = settings.timer.TRANSPARENT
		canDraw = true
	end

	local function secondsToHMS(seconds)
		local hours = math.floor(seconds / 3600)
		local minutes = math.floor((seconds % 3600) / 60)
		local remainingSeconds = seconds % 60
		return string.format("%02d:%02d:%02d", hours, minutes, remainingSeconds)
	end

	local function updateSeconds()
		local currentSeconds = os.time()
		if paused or tracker.hasRunEnded() then
			ui.controls.timer.setText(secondsToHMS(tracker.getTimerSeconds()))
			lastCheckedSeconds = currentSeconds
			return
		end
		if (currentSeconds - lastCheckedSeconds) > 1 then
			timeDeduct = timeDeduct + (currentSeconds - lastCheckedSeconds)
		end
		local calculatedSeconds = currentSeconds - startSeconds - timeDeduct
		local toDisplay = secondsToHMS(calculatedSeconds)
		ui.controls.timer.setText(toDisplay)
		tracker.setTimerSeconds(calculatedSeconds)
		lastCheckedSeconds = currentSeconds
	end

	function self.show()
		updateSeconds()
		--use boolean to draw max of once per frame advance, otherwise stacked transparency draws look bad
		if canDraw then
			ui.frames.mainFrame.show()
		end
		canDraw = false
	end

	initUI()

	return self
end

return TimerScreen

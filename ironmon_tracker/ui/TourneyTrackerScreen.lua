local function TourneyTrackerScreen(initialSettings, initialTracker, initialProgram)
	local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
	local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
	local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
	local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
	local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
	local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
	local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
	local Icon = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Icon.lua")
	local ScrollBar = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ScrollBar.lua")
	local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
	local HoverEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/HoverEventListener.lua")
	local MovementAnimation = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MovementAnimation.lua")
	local FrameCounter = dofile(Paths.FOLDERS.DATA_FOLDER .. "/FrameCounter.lua")
	local settings = initialSettings
	local tracker = initialTracker
	local program = initialProgram
	local constants = {
		ADD_BUTTON_WIDTH = 14,
		SEED_HEADING_WIDTH = 64,
		MAIN_HEIGHT = 299,
		SEED_SCORE_HEIGHT = 250,
		MILESTONES_BREAKDOWN_HEIGHT = 118,
		BONUSES_BREAKDOWN_HEIGHT = 82,
		GOAL_HEADER_WIDTH = 100,
		GOAL_ENTRY_NAME_WIDTH = 102,
		NOTIFICATION_FRAME_WIDTH = 150,
		NOTIFICATION_FRAME_HEIGHT = 30,
		NOTIFICATION_START_POS = {x = Graphics.SIZES.SCREEN_WIDTH, y = 0}
	}
	--not const because it can change depending on notif text length
	local notificationEndPos = {x = 0, y = 0}
	local ui = {}
	local eventListeners = {}
	local currentAnimation = nil
	local currentFrameCounter = nil
	local notifPlaying = false
	local tourneyScores = {}
	local tourneyTracker = nil
	local currentIndex = -1
	local milestonesFrameList = {}
	local bonusesFrameList = {}
	local milestonesScroller = nil
	local bonusesScroller = nil
	local screenThatOpened = nil
	local milestonesList = {}
	local bonusesList = {}
	local viewingScore = false
	local addingBonus = false
	local removingBonus = false
	local self = {}

	local function onNotifClearAnimationEnd()
		ui.frames.notificationFrame.setVisibility(false)
		currentAnimation = nil
		notifPlaying = false
	end

	local function onBeginNotificationClear()
		currentFrameCounter = nil
		currentAnimation =
			MovementAnimation(
			ui.frames.notificationFrame,
			notificationEndPos,
			constants.NOTIFICATION_START_POS,
			10,
			2,
			program.drawCurrentScreens,
			onNotifClearAnimationEnd
		)
	end

	function self.isNotifPlaying()
		return notifPlaying
	end

	local function onSpawnNotifAnimationEnd()
		currentAnimation = nil
		currentFrameCounter = FrameCounter(360, onBeginNotificationClear, nil, true)
	end

	function self.playMilestoneNotification(milestone, newPoints)
		notifPlaying = true
		ui.frames.notificationFrame.setVisibility(true)
		local notificationText = milestone.getName() .. "! +" .. milestone.getPoints()
		local newScoreText = "New total: " .. newPoints .. " point"
		if newPoints > 1 then
			newScoreText = newScoreText .. "s"
		end
		local newTextLength =
			math.max(DrawingUtils.calculateWordPixelLength(newScoreText), DrawingUtils.calculateWordPixelLength(notificationText))
		local newWidth = newTextLength + 11
		ui.frames.notificationFrame.resize({width = newWidth, height = 30})
		notificationEndPos = {x = Graphics.SIZES.SCREEN_WIDTH - newWidth - 1, y = 0}
		ui.controls.notificationMilestoneLabel.setText(notificationText)
		ui.controls.notificationScoreLabel.setText(newScoreText)
		currentAnimation =
			MovementAnimation(
			ui.frames.notificationFrame,
			constants.NOTIFICATION_START_POS,
			notificationEndPos,
			10,
			2,
			program.drawCurrentScreens,
			onSpawnNotifAnimationEnd
		)
	end

	local function onExportScoresClick()
		forms.destroyall()
		local formWidth, formHeight = 560, 400
		local buttonWidth, buttonHeight = 70, 30
		local copyForm = forms.newform(formWidth, formHeight, "Tourney Scores")
		local centerPosition = FormsUtils.getCenter(formWidth, formHeight)
		forms.setlocation(copyForm, centerPosition.xPos, centerPosition.yPos)
		local textBoxLines = tourneyTracker.convertScoresToLines()
		local completeLines = table.concat(textBoxLines, "\r\n")
		forms.textbox(copyForm, completeLines, formWidth - 36, formHeight - 100, nil, 10, 10, true, false)
		forms.button(
			copyForm,
			"Close",
			function()
				forms.destroyall()
			end,
			formWidth / 2 - 45,
			formHeight - 80,
			buttonWidth,
			buttonHeight
		)
	end

	local function initNotificationFrame()
		ui.frames.notificationFrame =
			Frame(
			Box(
				{x = constants.NOTIFICATION_START_POS.x, y = constants.NOTIFICATION_START_POS.y},
				{
					width = constants.NOTIFICATION_FRAME_WIDTH,
					height = constants.NOTIFICATION_FRAME_HEIGHT
				},
				"Top box background color",
				"Top box border color"
			),
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 2, {x = 4, y = 2}),
			nil,
			false
		)
		ui.controls.notificationMilestoneLabel =
			TextLabel(
			Component(ui.frames.notificationFrame, Box({x = 0, y = 0}, {width = 0, height = 12})),
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
		ui.controls.notificationScoreLabel =
			TextLabel(
			Component(ui.frames.notificationFrame, Box({x = 0, y = 0}, {width = 0, height = 18})),
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

	local function readScrollerItems(scroller, goalList, frameList, totalInList)
		local goalIDs = scroller.getViewedItems()
		for i = 1, totalInList, 1 do
			local goalID = goalIDs[i]
			if goalID ~= nil then
				local goalInfo = goalList[goalID]
				frameList[i].nameLabel.setText(goalInfo.getName())
				frameList[i].scoreLabel.setText("+" .. goalInfo.getPoints())
			else
				frameList[i].nameLabel.setText("")
				frameList[i].scoreLabel.setText("")
			end
		end
		program.drawCurrentScreens()
	end

	local function readMilestoneScrollerItems()
		readScrollerItems(milestonesScroller, milestonesList, milestonesFrameList, 8)
	end

	local function readBonusScrollerItems()
		readScrollerItems(bonusesScroller, bonusesList, bonusesFrameList, 5)
	end

	local function loadCurrentIndex()
		local tourneyData = tourneyScores[currentIndex]
		milestonesScroller.setItems(tourneyData.completedMilestoneIDs)
		bonusesScroller.setItems(tourneyData.completedBonusIDs)
		milestonesList = tourneyTracker.MILESTONES
		bonusesList = tourneyTracker.BONUSES
		milestonesScroller.setScrollReadingFunction(readMilestoneScrollerItems)
		bonusesScroller.setScrollReadingFunction(readBonusScrollerItems)
		readBonusScrollerItems()
		readMilestoneScrollerItems()
		ui.controls.seedScore.setText(tourneyTracker.getTotalPoints(tourneyData))
		ui.controls.seedHeading.setText("Seed " .. currentIndex .. "/" .. #tourneyScores)
		ui.controls.cumulativeScore.setText(tourneyTracker.getCumulativePoints())
		program.drawCurrentScreens()
	end

	local function setAddRemoveBonusVisibility(visible)
		ui.controls.addBonusButton.setVisibility(visible)
		ui.controls.removeBonusButton.setVisibility(visible)
	end

	local function removeBonus(index)
		if ui.controls.addBonusButton.isVisible() or bonusesScroller.getViewedItems()[index] == nil then
			return
		end
		table.remove(tourneyScores[currentIndex].completedBonusIDs, bonusesScroller.getBaseIndex() + index - 1)
		tourneyTracker.saveData()
		setAddRemoveBonusVisibility(true)
		ui.controls.bonusesTitle.setText("Bonuses")
		loadCurrentIndex()
	end

	local function addBonus(index)
		local items = bonusesScroller.getViewedItems()
		if ui.controls.addBonusButton.isVisible() or items[index] == nil then
			return
		end
		local tourneyData = tourneyScores[currentIndex]
		table.insert(tourneyData.completedBonusIDs, items[index])
		tourneyTracker.saveData()
		setAddRemoveBonusVisibility(true)
		ui.controls.bonusesTitle.setText("Bonuses")
		loadCurrentIndex()
	end

	local function onRemoveBonusClick(bonusesFrameInfo)
		if #tourneyScores[currentIndex].completedBonusIDs < 1 then
			return
		end
		addingBonus = false
		removingBonus = true
		bonusesFrameInfo.titleLabel.setText("Select One to Remove:")
		setAddRemoveBonusVisibility(false)
		program.drawCurrentScreens()
	end

	local function onAddBonusClick(bonusesFrameInfo)
		addingBonus = true
		removingBonus = false
		bonusesFrameInfo.titleLabel.setText("Select One to Add:")
		setAddRemoveBonusVisibility(false)
		local bonusIDs = {}
		for id, bonus in pairs(tourneyTracker.BONUSES) do
			table.insert(bonusIDs, id)
		end
		bonusesScroller.setItems(bonusIDs)
		readBonusScrollerItems()
	end

	local function onBonusRowClick(index)
		if addingBonus then
			addBonus(index)
		end
		if removingBonus then
			removeBonus(index)
		end
	end

	local function addToBonusesUI(breakdownFrameInfo)
		local topFrame = breakdownFrameInfo.topFrame
		ui.controls.addBonusButton =
			TextLabel(
			Component(topFrame, Box({x = 0, y = 0}, {width = constants.ADD_BUTTON_WIDTH, height = constants.ADD_BUTTON_WIDTH})),
			TextField(
				"+",
				{x = 2, y = -1},
				TextStyle(13, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
			)
		)
		ui.controls.removeBonusButton =
			TextLabel(
			Component(topFrame, Box({x = 0, y = 0}, {width = constants.ADD_BUTTON_WIDTH, height = constants.ADD_BUTTON_WIDTH})),
			TextField(
				"--",
				{x = 2, y = -2},
				TextStyle(13, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
			)
		)
		for i = 1, #bonusesFrameList, 1 do
			table.insert(eventListeners, MouseClickEventListener(bonusesFrameList[i].frame, onBonusRowClick, i))
		end
		table.insert(eventListeners, MouseClickEventListener(ui.controls.addBonusButton, onAddBonusClick, breakdownFrameInfo))
		table.insert(
			eventListeners,
			MouseClickEventListener(ui.controls.removeBonusButton, onRemoveBonusClick, breakdownFrameInfo)
		)
	end

	local function createGoalBreakdownFrame(frameHeight, titleName, frameList, totalRows)
		local goalBreakdownFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 20,
					height = frameHeight
				},
				"Top box background color",
				"Top box border color"
			),
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 0}),
			ui.frames.goalBreakdownsFrame
		)
		local topFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = 0,
					height = 18
				}
			),
			Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 0, y = 2}),
			goalBreakdownFrame
		)
		local titleLabel =
			TextLabel(
			Component(topFrame, Box({x = 0, y = 0}, {width = constants.GOAL_HEADER_WIDTH, height = 18})),
			TextField(
				titleName,
				{x = 2, y = -1},
				TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
			)
		)
		local goalListScrollerFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 20,
					height = frameHeight - 18
				},
				"Top box background color",
				"Top box border color"
			),
			nil,
			goalBreakdownFrame
		)
		local goalListFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 30,
					height = frameHeight - 36
				}
			),
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 2}),
			goalListScrollerFrame
		)
		local scrollerItems = {}
		for i = 1, totalRows, 1 do
			local entryFrame =
				Frame(
				Box(
					{x = 0, y = 0},
					{
						width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 20,
						height = 12
					}
				),
				Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL),
				goalListFrame
			)
			local nameLabel =
				TextLabel(
				Component(entryFrame, Box({x = 0, y = 0}, {width = constants.GOAL_ENTRY_NAME_WIDTH, height = 0})),
				TextField(
					"",
					{x = 2, y = 0},
					TextStyle(
						Graphics.FONT.DEFAULT_FONT_SIZE,
						Graphics.FONT.DEFAULT_FONT_FAMILY,
						"Top box text color",
						"Top box background color"
					)
				)
			)
			local scoreLabel =
				TextLabel(
				Component(entryFrame, Box({x = 0, y = 0}, {width = 12, height = 12})),
				TextField(
					"+2",
					{x = 2, y = 1},
					TextStyle(
						Graphics.FONT.DEFAULT_FONT_SIZE,
						Graphics.FONT.DEFAULT_FONT_FAMILY,
						"Positive text color",
						"Top box background color"
					)
				)
			)
			frameList[i] = {
				["frame"] = entryFrame,
				["nameLabel"] = nameLabel,
				["scoreLabel"] = scoreLabel
			}
		end
		return {
			mainFrame = goalBreakdownFrame,
			["titleLabel"] = titleLabel,
			["topFrame"] = topFrame,
			scrollerFrame = goalListScrollerFrame
		}
	end

	local function increaseSeedIndex()
		currentIndex = MiscUtils.increaseTableIndex(currentIndex, #tourneyScores)
		loadCurrentIndex()
	end

	local function decreaseSeedIndex()
		currentIndex = MiscUtils.decreaseTableIndex(currentIndex, #tourneyScores)
		loadCurrentIndex()
	end

	local function initTopNav()
		ui.frames.topFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 10,
					height = 18
				},
				"Top box background color",
				"Top box border color"
			),
			Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 22, y = 2}),
			ui.frames.mainInnerFrame
		)

		local arrowWidth = 18
		local arrowFrameInfo = FrameFactory.createArrowFrame("LEFT_ARROW_LARGE", ui.frames.topFrame, arrowWidth, 1)
		ui.frames.leftSeedArrow, ui.controls.leftSeedArrowButton = arrowFrameInfo.frame, arrowFrameInfo.button

		ui.controls.seedHeading =
			TextLabel(
			Component(ui.frames.topFrame, Box({x = 0, y = 0}, {width = constants.SEED_HEADING_WIDTH, height = 0})),
			TextField(
				"Seed 1/10",
				{x = 0, y = -1},
				TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
			)
		)

		arrowFrameInfo = FrameFactory.createArrowFrame("RIGHT_ARROW_LARGE", ui.frames.topFrame, arrowWidth, 1)
		ui.frames.rightSeedArrow, ui.controls.rightSeedArrowButton = arrowFrameInfo.frame, arrowFrameInfo.button

		eventListeners.leftSeed = MouseClickEventListener(ui.frames.leftSeedArrow, decreaseSeedIndex)
		eventListeners.rightSeed = MouseClickEventListener(ui.frames.rightSeedArrow, increaseSeedIndex)
	end

	local function createMainScoreRowFrame(scoreLabelText, scoreAmountKey)
		local rowFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = 0,
					height = 10
				}
			),
			Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = -1, y = -2}),
			ui.frames.goalBreakdownsFrame
		)
		local label =
			TextLabel(
			Component(rowFrame, Box({x = 0, y = 0}, {width = 99, height = 0})),
			TextField(
				scoreLabelText,
				{x = 3, y = 1},
				TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
			)
		)
		ui.controls[scoreAmountKey] =
			TextLabel(
			Component(rowFrame, Box({x = 0, y = 0}, {width = 0, height = 0})),
			TextField(
				90,
				{x = 3, y = 1},
				TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
			)
		)
	end

	local function initScoreSummaryUI()
		ui.frames.goalBreakdownsFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 10,
					height = constants.SEED_SCORE_HEIGHT
				}
			),
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 5, {x = 5, y = 5}),
			ui.frames.mainInnerFrame
		)
		local milestoneFrameInfo =
			createGoalBreakdownFrame(constants.MILESTONES_BREAKDOWN_HEIGHT, "Milestones", milestonesFrameList, 8)
		ui.frames.milestonesBreakdown = milestoneFrameInfo.mainFrame
		local bonusesFrameInfo = createGoalBreakdownFrame(constants.BONUSES_BREAKDOWN_HEIGHT, "Bonuses", bonusesFrameList, 5)
		ui.controls.bonusesTitle = bonusesFrameInfo.titleLabel
		addToBonusesUI(bonusesFrameInfo)
		ui.frames.bonusesBreakdown = bonusesFrameInfo.mainFrame
		milestonesScroller = ScrollBar(milestoneFrameInfo.scrollerFrame, 8, {})
		bonusesScroller = ScrollBar(bonusesFrameInfo.scrollerFrame, 5, {})

		createMainScoreRowFrame("Seed Score:", "seedScore")
		createMainScoreRowFrame("Cumulative Score:", "cumulativeScore")
	end

	local function onClose()
		viewingScore = false
		program.openScreen(screenThatOpened)
	end

	local function initBottomUI()
		ui.frames.bottomButtonsFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = 0,
					height = 0
				}
			),
			Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 6, {x = 5, y = 0}),
			ui.frames.mainInnerFrame
		)

		ui.controls.exportScoresButton =
			TextLabel(
			Component(
				ui.frames.bottomButtonsFrame,
				Box(
					{x = 0, y = 0},
					{width = 62, height = 16},
					"Top box background color",
					"Top box border color",
					true,
					"Top box background color"
				)
			),
			TextField(
				"Export Scores",
				{x = 4, y = 2},
				TextStyle(
					Graphics.FONT.DEFAULT_FONT_SIZE,
					Graphics.FONT.DEFAULT_FONT_FAMILY,
					"Top box text color",
					"Top box background color"
				)
			)
		)

		ui.controls.closeButton =
			TextLabel(
			Component(
				ui.frames.bottomButtonsFrame,
				Box(
					{x = 0, y = 0},
					{width = 62, height = 16},
					"Top box background color",
					"Top box border color",
					true,
					"Top box background color"
				)
			),
			TextField(
				"Close",
				{x = 20, y = 2},
				TextStyle(
					Graphics.FONT.DEFAULT_FONT_SIZE,
					Graphics.FONT.DEFAULT_FONT_FAMILY,
					"Top box text color",
					"Top box background color"
				)
			)
		)

		table.insert(eventListeners, MouseClickEventListener(ui.controls.exportScoresButton, onExportScoresClick))
		table.insert(eventListeners, MouseClickEventListener(ui.controls.closeButton, onClose))
	end

	local function initScoreBreakdownUI()
		ui.frames.mainFrame =
			Frame(
			Box(
				{x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
				{
					width = Graphics.SIZES.MAIN_SCREEN_WIDTH,
					height = constants.MAIN_HEIGHT
				},
				"Main background color",
				"Main background color"
			),
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 5, y = 5}),
			nil
		)
		ui.frames.mainInnerFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 10,
					height = constants.MAIN_HEIGHT - 10
				},
				"Top box background color",
				"Top box border color"
			),
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 0}),
			ui.frames.mainFrame
		)
		initTopNav()
		initScoreSummaryUI()
		initBottomUI()
	end

	local function initUI()
		ui.controls = {}
		ui.frames = {}
		initNotificationFrame()
		initScoreBreakdownUI()
	end

	function self.setUpScoreBreakdown(newTourneyTracker, newScreenThatOpened)
		screenThatOpened = newScreenThatOpened or screenThatOpened
		tourneyTracker = newTourneyTracker
		tourneyScores = tourneyTracker.getTourneyScores()
		currentIndex = #tourneyScores
		viewingScore = true
		addingBonus = false
		removingBonus = false
		setAddRemoveBonusVisibility(true)
		ui.controls.bonusesTitle.setText("Bonuses")
		loadCurrentIndex()
	end

	function self.isViewingScore()
		return viewingScore
	end

	function self.runEventListeners()
		if viewingScore then
			for _, eventListener in pairs(eventListeners) do
				eventListener.listen()
			end
			milestonesScroller.update()
			bonusesScroller.update()
		end
		if currentAnimation ~= nil then
			currentAnimation.update()
		end
		if currentFrameCounter ~= nil then
			currentFrameCounter.decrement()
		end
	end

	function self.show()
		ui.frames.notificationFrame.show()
		if viewingScore then
			ui.frames.mainFrame.show()
		end
	end

	initUI()

	return self
end

return TourneyTrackerScreen

local function EvoDataScreen(initialSettings, initialTracker, initialProgram)
	local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
	local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
	local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
	local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
	local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
	local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
	local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
	local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
	local ScrollBar = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ScrollBar.lua")
	local settings = initialSettings
	local tracker = initialTracker
	local program = initialProgram
	local currentTargetIDs = {}
	local currentIndex = 1
	local tourneyTracker

	local self = {}

	local constants = {
		MAIN_FRAME_HEIGHT = 166,
		TOP_FRAME_HEIGHT = 20,
		EVO_DATA_FRAME_HEIGHT = 95,
		EVO_DATA_ROW_HEIGHT = 12,
		CREDITS_FRAME_HEIGHT = 34
	}

	local SORT_TYPES = {
		NAME = 0,
		BST = 1,
		PERCENT = 2
	}

	local sorting = {
		sortType = SORT_TYPES.PERCENT
	}

	local evoRows = {}
	local evoData = {}

	local ui = {}
	local eventListeners = {}
	local evoScroller = nil

	local function sortEvos()
		table.sort(
			evoData,
			function(a, b)
				if sorting.sortType == SORT_TYPES.BST then
					return PokemonData.POKEMON[a.id + 1].bst > PokemonData.POKEMON[b.id + 1].bst
				elseif sorting.sortType == SORT_TYPES.NAME then
					return PokemonData.POKEMON[a.id + 1].name < PokemonData.POKEMON[b.id + 1].name
				else
					return a.percent > b.percent
				end
			end
		)
	end

	local function clearEvoRow(index)
		local row = evoRows[index]
		row.name.setText("")
		row.bst.setText("")
		row.percent.setText("")
	end

	local function fillRow(evoEntry, row)
		if evoEntry == nil then
			return
		end
		if not PokemonData.POKEMON[evoEntry.id + 1] then
			return
		end
		local pokemonData = PokemonData.POKEMON[evoEntry.id + 1]
		row.name.setText(pokemonData.name)
		row.bst.setText(pokemonData.bst)
		row.percent.setText(string.format("%.2f%%", evoEntry.percent))
		local percentTextOffset = {
			x = 8,
			y = 1
		}
		if evoEntry.percent >= 10.00 then
			percentTextOffset = {x = 3, y = 1}
		end
		row.percent.setTextOffset(percentTextOffset)
	end

	local function readScroller()
		local items = evoScroller.getViewedItems()
		for i = 1, 7, 1 do
			if items[i] then
				local evoEntry = items[i]
				fillRow(evoEntry, evoRows[i])
			else
				clearEvoRow(i)
			end
		end
		program.drawCurrentScreens()
	end

	local function readCurrentIndex()
		local currentID = currentTargetIDs[currentIndex]
		evoScroller.setItems(evoData[currentID])
		local name = PokemonData.POKEMON[currentID + 1].name
		local xOffset = -2
		xOffset = xOffset + ((ui.controls.targetEvoLabel.getSize().width - DrawingUtils.calculateWordPixelLength(name)) / 2)
		ui.controls.targetEvoLabel.setText(name)
		ui.controls.targetEvoLabel.setTextOffset({x = xOffset, y = 2})
		readScroller()
	end

	function self.initialize(playerPokemon)
		if playerPokemon == nil or not EvoData.EVOLUTIONS[playerPokemon.pokemonID] then
			program.openScreen(program.UI_SCREENS.MAIN_SCREEN)
			return
		end
		evoData = {}
		evoData = EvoData.EVOLUTIONS[playerPokemon.pokemonID]
		sortEvos()
		currentTargetIDs = {}
		currentIndex = 1
		for targetID, data in pairs(evoData) do
			table.insert(currentTargetIDs, targetID)
		end
		ui.frames.targetEvoNavFrame.setVisibility(#currentTargetIDs > 1)
		local spacerHeight = 1
		local mainFrameHeight = constants.MAIN_FRAME_HEIGHT
		if #currentTargetIDs > 1 then
			spacerHeight = 2
			mainFrameHeight = mainFrameHeight + 21
		end
		ui.frames.mainFrame.resize({width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = mainFrameHeight})
		local size = ui.controls.spacer.getSize()
		ui.controls.spacer.resize({width = size.width, height = spacerHeight})
		readCurrentIndex()
		readScroller()
	end

	local function onSortButtonClick(button)
		button.onRadioClick()
		sortEvos()
		readScroller()
		program.drawCurrentScreens()
	end

	local function onViewSiteClick()
		local brdyURL = "https://brdyweb.com/kaizo/evo/"
		os.execute(string.format('start "" "%s"', brdyURL))
	end

	local function initTopSortFrame()
		ui.frames.topFrame =
			Frame(
			Box(
				{x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
				{width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 10, height = constants.TOP_FRAME_HEIGHT},
				"Top box background color",
				nil
			),
			Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 5, y = 3}),
			ui.frames.mainFrame
		)
		ui.controls.sortLabel =
			TextLabel(
			Component(ui.frames.topFrame, Box({x = 0, y = 0}, {width = 35, height = 0})),
			TextField(
				"Sort by:",
				{x = 0, y = 1},
				TextStyle(
					Graphics.FONT.DEFAULT_FONT_SIZE,
					Graphics.FONT.DEFAULT_FONT_FAMILY,
					"Top box text color",
					"Top box background color"
				)
			)
		)
		local sortButtonsFrame =
			Frame(Box({x = 0, y = 0}, {width = 0, height = 0}), Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 2), ui.frames.topFrame)
		local buttonInfo = {
			{name = "Name", width = 32, sortType = SORT_TYPES.NAME},
			{name = "BST", width = 22, sortType = SORT_TYPES.BST},
			{name = "Percent", width = 38, sortType = SORT_TYPES.PERCENT}
		}
		for _, info in pairs(buttonInfo) do
			local button =
				TextLabel(
				Component(sortButtonsFrame, Box({x = 0, y = 0}, {width = info.width, height = 14})),
				TextField(
					info.name,
					{x = 3, y = 1},
					TextStyle(
						Graphics.FONT.DEFAULT_FONT_SIZE,
						Graphics.FONT.DEFAULT_FONT_FAMILY,
						"Top box text color",
						"Top box background color"
					)
				),
				true,
				sorting,
				"sortType",
				info.sortType
			)
			table.insert(eventListeners, MouseClickEventListener(button, onSortButtonClick, button))
		end
	end

	local function onLeftEvoClick()
		currentIndex = MiscUtils.decreaseTableIndex(currentIndex, #currentTargetIDs)
		readCurrentIndex()
	end

	local function onRightEvoClick()
		currentIndex = MiscUtils.increaseTableIndex(currentIndex, #currentTargetIDs)
		readCurrentIndex()
	end

	local function initNavUI()
		ui.frames.targetEvoNavFrame =
			Frame(
			Box(
				{
					x = 0,
					y = 0
				},
				{
					width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 10,
					height = 20
				},
				"Top box background color",
				"Top box border color"
			),
			Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 16, y = 2}),
			ui.frames.mainFrame
		)
		local arrowWidth = 16
		local arrowFrameInfo = FrameFactory.createArrowFrame("LEFT_ARROW_LARGE", ui.frames.targetEvoNavFrame, arrowWidth, 1)
		ui.frames.leftEvoArrow, ui.controls.leftEvoArrowButton = arrowFrameInfo.frame, arrowFrameInfo.button
		ui.controls.targetEvoLabel =
			TextLabel(
			Component(
				ui.frames.targetEvoNavFrame,
				Box(
					{x = 0, y = 0},
					{
						width = 76,
						height = 0
					}
				)
			),
			TextField(
				"",
				{x = 11, y = 2},
				TextStyle(
					Graphics.FONT.DEFAULT_FONT_SIZE,
					Graphics.FONT.DEFAULT_FONT_FAMILY,
					"Top box text color",
					"Top box background color"
				)
			)
		)
		arrowFrameInfo = FrameFactory.createArrowFrame("RIGHT_ARROW_LARGE", ui.frames.targetEvoNavFrame, arrowWidth, 1)
		ui.frames.rightEvoArrow, ui.controls.rightEvoArrowButton = arrowFrameInfo.frame, arrowFrameInfo.button
		table.insert(eventListeners, MouseClickEventListener(ui.controls.rightEvoArrowButton, onLeftEvoClick))
		table.insert(eventListeners, MouseClickEventListener(ui.controls.leftEvoArrowButton, onRightEvoClick))
	end

	local function createEvoDataRow()
		local rowData = {}
		rowData.rowFrame =
			Frame(
			Box({x = 0, y = 0}, {width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 10, height = constants.EVO_DATA_ROW_HEIGHT}),
			Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 1, y = 2}),
			ui.frames.evoDataRowsFrame
		)
		local labelInfo = {
			{name = "name", width = 61},
			{name = "bst", width = 27},
			{name = "percent", width = 26}
		}
		for _, info in pairs(labelInfo) do
			rowData[info.name] =
				TextLabel(
				Component(rowData.rowFrame, Box({x = 0, y = 0}, {width = info.width, height = 0})),
				TextField(
					"",
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
		return rowData
	end

	local function initEvoDataFrame()
		ui.frames.evoDataOuterFrame =
			Frame(
			Box(
				{x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
				{width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 10, height = constants.EVO_DATA_FRAME_HEIGHT},
				"Top box background color",
				nil
			),
			Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 3, y = 3}),
			ui.frames.mainFrame
		)
		ui.frames.evoDataScrollFrame =
			Frame(
			Box(
				{x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
				{width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 16, height = constants.EVO_DATA_FRAME_HEIGHT - 6},
				"Top box background color",
				"Top box border color"
			),
			nil,
			ui.frames.evoDataOuterFrame
		)
		ui.frames.evoDataRowsFrame =
			Frame(
			Box({x = 0, y = 0}, {width = 0, height = 0}),
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL),
			ui.frames.evoDataScrollFrame
		)
		for i = 1, 7, 1 do
			evoRows[i] = createEvoDataRow()
		end
		evoScroller = ScrollBar(ui.frames.evoDataScrollFrame, 7, {})
		evoScroller.setScrollReadingFunction(readScroller)
	end

	local function initCreditsUI()
		ui.frames.creditsFrame =
			Frame(
			Box(
				{x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
				{width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 10, height = constants.CREDITS_FRAME_HEIGHT},
				nil,
				nil
			),
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 1, y = 0}),
			ui.frames.mainFrame
		)
		ui.controls.namesLabel =
			TextLabel(
			Component(
				ui.frames.creditsFrame,
				Box(
					{x = 0, y = 0},
					{width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 12, height = 17},
					"Top box background color",
					"Top box background color"
				)
			),
			TextField(
				"Data from brdy and Harkenn",
				{x = 3, y = 1},
				TextStyle(
					Graphics.FONT.DEFAULT_FONT_SIZE,
					Graphics.FONT.DEFAULT_FONT_FAMILY,
					"Top box text color",
					"Top box background color"
				)
			)
		)
		ui.frames.bottomFrame =
			Frame(
			Box(
				{x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
				{width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 12, height = 22},
				"Top box background color",
				"Top box background color"
			),
			Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 10, {x = 8, y = 0}),
			ui.frames.creditsFrame
		)
		ui.controls.viewSiteButton =
			TextLabel(
			Component(
				ui.frames.bottomFrame,
				Box(
					{x = 0, y = 0},
					{width = 56, height = 16},
					"Top box background color",
					"Top box border color",
					true,
					"Top box background color"
				)
			),
			TextField(
				"View Site",
				{x = 9, y = 2},
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
				ui.frames.bottomFrame,
				Box(
					{x = 0, y = 0},
					{width = 56, height = 16},
					"Top box background color",
					"Top box border color",
					true,
					"Top box background color"
				)
			),
			TextField(
				"Close",
				{x = 17, y = 2},
				TextStyle(
					Graphics.FONT.DEFAULT_FONT_SIZE,
					Graphics.FONT.DEFAULT_FONT_FAMILY,
					"Top box text color",
					"Top box background color"
				)
			)
		)
		table.insert(eventListeners, MouseClickEventListener(ui.controls.viewSiteButton, onViewSiteClick))
		table.insert(
			eventListeners,
			MouseClickEventListener(ui.controls.closeButton, program.openScreen, program.UI_SCREENS.MAIN_SCREEN)
		)
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
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 5, y = 5}),
			nil
		)
		initTopSortFrame()
		ui.controls.spacer =
			TextLabel(
			Component(
				ui.frames.mainFrame,
				Box({x = 0, y = 0}, {width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = 2}, "Main background color")
			),
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
		initNavUI()
		initEvoDataFrame()
		initCreditsUI()
	end

	function self.runEventListeners()
		for _, eventListener in pairs(eventListeners) do
			eventListener.listen()
		end
		evoScroller.update()
	end

	function self.show()
		ui.frames.mainFrame.show()
	end

	initUI()

	return self
end

return EvoDataScreen

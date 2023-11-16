local function TitleScreen(initialSettings, initialTracker, initialProgram)
	local FrameCounter = dofile(Paths.FOLDERS.DATA_FOLDER .. "/FrameCounter.lua")
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
	local settings = initialSettings
	local seedLogger
	local attempts = 0
	local tracker = initialTracker
	local program = initialProgram
	local editingFavorites = false
	local bottomOnly = false
	local constants = {
		FAVORITES_LABEL_FRAME_HEIGHT = 91,
		FAVORITES_ROW_HEIGHT = 17,
		FAVORITES_LABEL_WIDTH = 104,
		SET_BUTTON_WIDTH = 23,
		SET_BUTTON_HEIGHT = 13,
		CLOSE_BUTTON_WIDTH = 39,
		CLOSE_BUTTON_HEIGHT = 16
	}
	local favoriteStartIndex = 4
	local favorites = {1, 2, 3, 4, 5}
	local ui = {}
	local favoriteEditEventListeners = {}
	local titleScreenEventListeners = {}
	local favoritePictureListeners = {}
	local self = {}
	local frameCounters = {}

	function self.isEditingFavorites()
		return editingFavorites
	end

	local function formatStatisticMapping(mapping, pastRunStatistics)
		local statistic = pastRunStatistics[mapping.statKey]
		local data = statistic[2]
		local text = ""
		for i = 1, mapping.amount, 1 do
			if i == mapping.amount then
				text = text .. "and "
			end
			if data[i] then
				text = text .. data[i][1]
			end
			if i ~= mapping.amount then
				text = text .. ", "
			end
		end
		return mapping.title:gsub("%%data%%", text)
	end

	local function hasEnoughData(statistics)
		local baseStatistic, endStatistic = 4, 11
		for i = baseStatistic, endStatistic, 1 do
			local statistic = statistics[i]
			local data = statistic[2]
			if #data < 3 then
				return false
			end
		end
		return true
	end

	local function formatPercentMapping(mapping, pastRunStatistics, runAmount)
		local statKey, dataEntryKey = mapping.statKey, mapping.dataEntryKey
		local statistic = pastRunStatistics[statKey]
		local title, statisticData = statistic[1], statistic[2]
		local dataEntry = statisticData[dataEntryKey]
		local total = tonumber(dataEntry[2])
		local percent = string.format("%.1f", total / runAmount * 100) .. "%"
		return mapping.title:gsub("%%percent%%", percent .. "%")
	end

	local percentStatisticMappings = {
		{
			title = "You get out of the lab %percent% of the time.",
			statKey = 1,
			dataEntryKey = 1
		},
		{
			title = "You run sub 300 BST Pok" .. Chars.accentedE .. "mon %percent% of the time.",
			statKey = 2,
			dataEntryKey = 1
		},
		{
			title = "You run 300 - 400 BST Pok" .. Chars.accentedE .. "mon %percent% of the time.",
			statKey = 2,
			dataEntryKey = 2
		},
		{
			title = "You run 400 - 500 BST Pok" .. Chars.accentedE .. "mon %percent% of the time.",
			statKey = 2,
			dataEntryKey = 3
		},
		{
			title = "You run 500+ BST Pok" .. Chars.accentedE .. "mon %percent% of the time.",
			statKey = 2,
			dataEntryKey = 4
		},
		{
			title = "You lose to sub 300 BST Pok" .. Chars.accentedE .. "mon %percent% of the time.",
			statKey = 3,
			dataEntryKey = 1
		},
		{
			title = "You lose to 300 - 400 BST Pok" .. Chars.accentedE .. "mon %percent% of the time.",
			statKey = 3,
			dataEntryKey = 2
		},
		{
			title = "You lose to 400 - 500 BST Pok" .. Chars.accentedE .. "mon %percent% of the time.",
			statKey = 3,
			dataEntryKey = 3
		},
		{
			title = "You lose to 500+ BST Pok" .. Chars.accentedE .. "mon %percent% of the time.",
			statKey = 3,
			dataEntryKey = 4
		}
	}

	local basicStatisticMappings = {
		--types
		{
			title = "You use %data% types the most.",
			statKey = 4,
			amount = 3
		},
		{
			title = "You lose to %data% types the most.",
			statKey = 5,
			amount = 3
		},
		--pokemon
		{
			title = "You run %data% the most.",
			statKey = 6,
			amount = 3
		},
		{
			title = "You lose to %data% the most.",
			statKey = 7,
			amount = 3
		},
		--moves
		{
			title = "Your moves are %data% the most.",
			statKey = 8,
			amount = 3
		},
		{
			title = "Your enemies have %data% the most.",
			statKey = 9,
			amount = 3
		},
		--abilities
		{
			title = "Your abilities are %data% the most.",
			statKey = 10,
			amount = 3
		},
		{
			title = "Your enemies have %data% the most.",
			statKey = 11,
			amount = 3
		}
	}

	local function getRandomStatistic()
		local statistics = seedLogger.getPastRunStatistics()
		local completeText = "Fun statistics will be shown here once you play enough."
		if hasEnoughData(statistics) then
			local choices = {}
			for _, mapping in pairs(basicStatisticMappings) do
				local description = formatStatisticMapping(mapping, statistics)
				table.insert(choices, description)
			end
			for _, mapping in pairs(percentStatisticMappings) do
				local runsToUse = seedLogger.getTotalRunsPastLab()
				if mapping.statKey == 1 then
					runsToUse = seedLogger.getTotalRuns()
				end
				local description = formatPercentMapping(mapping, statistics, runsToUse)
				table.insert(choices, description)
			end
			local text = MiscUtils.randomTableValue(choices)
			completeText = "Did you know? " .. text
		end
		local array = DrawingUtils.textToWrappedArray(completeText, ui.frames.mainInnerFrame.getSize().width - 10)
		for i = 1, 3, 1 do
			local textToSet = ""
			if array[i] then
				textToSet = array[i]
			end
			ui.controls["statisticLabel" .. i].setText(textToSet)
		end
	end

	local function saveCurrentFavorites()
		local fileName = "savedData" .. Paths.SLASH .. program.getGameInfo().NAME .. ".faves"
		local favoritesList = table.concat(favorites, ",")
		MiscUtils.writeStringToFile(fileName, favoritesList)
	end

	local function toggleFavoriteEditing(override)
		bottomOnly = false
		editingFavorites = not editingFavorites
		if override then
			editingFavorites = override
		end
		ui.frames.topFrame.setVisibility(not editingFavorites)
		ui.frames.bottomFrame.setVisibility(not editingFavorites)
		for _, favoriteImage in pairs(ui.favoriteImages) do
			favoriteImage.setVisibility(not editingFavorites)
		end
		ui.frames.favoriteEditFrame.setVisibility(editingFavorites)
		if not editingFavorites and override == nil then
			program.openScreen(program.UI_SCREENS.MAIN_SCREEN)
		end
	end

	local function onCloseFromSetup()
		toggleFavoriteEditing(false)
		program.openScreen(program.UI_SCREENS.TRACKER_SETUP_SCREEN)
		favoriteEditEventListeners.close.setOnClickFunction(toggleFavoriteEditing)
		favoriteEditEventListeners.close.setOnClickParams()
	end

	function self.openedFromSetup()
		editingFavorites = false
		toggleFavoriteEditing()
		favoriteEditEventListeners.close.setOnClickFunction(onCloseFromSetup)
		favoriteEditEventListeners.close.setOnClickParams()
	end

	function self.setTopVisibility(newVisibility)
		bottomOnly = not newVisibility
	end

	local function readFavoritesIntoUI()
		local iconSet = IconSets.SETS[settings.appearance.ICON_SET_INDEX]
		for i = 1, 4, 1 do
			local favoritesIndex = ((i + favoriteStartIndex) % #favorites) + 1
			local rotatedPokemonID = favorites[favoritesIndex]
			if PokemonData.POKEMON[rotatedPokemonID + 1] then
				DrawingUtils.readPokemonIDIntoImageLabel(iconSet, rotatedPokemonID, ui.favoriteImages[i])
			end
		end
		for i = 1, program.getGameInfo().GEN, 1 do
			local pokemonID = favorites[i]
			local name = PokemonData.POKEMON[pokemonID + 1].name
			ui.favoritesRows[i].nameLabel.setText("Favorite " .. i .. ": " .. name)
		end
	end

	local function rotateFavorites()
		favoriteStartIndex = MiscUtils.increaseTableIndex(favoriteStartIndex, #favorites)
		readFavoritesIntoUI()
		program.drawCurrentScreens()
	end

	local function initFavorites()
		local fileName = "savedData" .. Paths.SLASH .. program.getGameInfo().NAME .. ".faves"
		local favesList = MiscUtils.readStringFromFile(fileName)
		if favesList ~= nil and favesList ~= "" then
			favesList = MiscUtils.split(favesList, ",", true)
		end
		for i = 1, program.getGameInfo().GEN, 1 do
			if favesList ~= nil and favesList[i] then
				favorites[i] = tonumber(favesList[i])
			end
		end
		readFavoritesIntoUI()
	end

	local function readAttemptsIntoUI()
		local attemptsText = "Attempts: " .. attempts
		ui.controls.attemptsLabel.setText(attemptsText)
		program.drawCurrentScreens()
	end

	local function onAttemptsSet()
		attempts = QuickLoader.getAttempts()
		readAttemptsIntoUI()
	end

	local function onAttemptsClick()
		QuickLoader.openAttemptsEditingWindow(onAttemptsSet)
	end

	function self.initialize(newSeedLogger)
		seedLogger = newSeedLogger
		initFavorites()
		attempts = QuickLoader.getAttempts()
		local name = program.getGameInfo().NAME:gsub("Pokemon", "Pok" .. Chars.accentedE .. "mon")
		ui.controls.gameLabel.setText(name)
		getRandomStatistic()
		readAttemptsIntoUI()
		favoriteEditEventListeners.close.setOnClickFunction(toggleFavoriteEditing)
		favoriteEditEventListeners.close.setOnClickParams()
	end

	function self.moveMainFrame(newPosition)
		ui.frames.mainFrame.move({x = newPosition.x, y = newPosition.y})
	end

	local function changeFavorite(index, newID)
		favorites[index] = newID
		readFavoritesIntoUI()
		saveCurrentFavorites()
		program.drawCurrentScreens()
	end

	local function onSetFavoriteClick(index)
		FormsUtils.createFavoriteChoosingForm(changeFavorite, index)
	end

	local function createFavoriteEditRow(index, parentFrame)
		local rowFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = 0,
					height = constants.FAVORITES_ROW_HEIGHT
				}
			),
			Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 4, {x = 0, y = 2}),
			parentFrame
		)

		local nameLabel =
			TextLabel(
			Component(rowFrame, Box({x = 0, y = 0}, {width = constants.FAVORITES_LABEL_WIDTH, height = 0})),
			TextField(
				"Favorite " .. index .. ":",
				{x = 2, y = 0},
				TextStyle(
					Graphics.FONT.DEFAULT_FONT_SIZE,
					Graphics.FONT.DEFAULT_FONT_FAMILY,
					"Top box text color",
					"Top box background color"
				)
			)
		)

		local setButton =
			TextLabel(
			Component(
				rowFrame,
				Box(
					{x = 0, y = 0},
					{width = constants.SET_BUTTON_WIDTH, height = constants.SET_BUTTON_HEIGHT},
					"Top box background color",
					"Top box border color"
				)
			),
			TextField(
				"Set",
				{x = 4, y = 1},
				TextStyle(
					Graphics.FONT.DEFAULT_FONT_SIZE,
					Graphics.FONT.DEFAULT_FONT_FAMILY,
					"Top box text color",
					"Top box background color"
				)
			)
		)

		table.insert(favoriteEditEventListeners, MouseClickEventListener(setButton, onSetFavoriteClick, index))

		return {
			["frame"] = rowFrame,
			["nameLabel"] = nameLabel
		}
	end

	local function initFavoriteEditCloseButton()
		ui.frames.favoriteEditCloseFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = 0,
					height = 0
				}
			),
			Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 52, y = 4}),
			ui.frames.favoriteEditFrame
		)
		local closeButton =
			TextLabel(
			Component(
				ui.frames.favoriteEditCloseFrame,
				Box(
					{x = 0, y = 0},
					{width = constants.CLOSE_BUTTON_WIDTH, height = constants.CLOSE_BUTTON_HEIGHT},
					"Top box background color",
					"Top box border color"
				)
			),
			TextField(
				"Close",
				{x = 8, y = 2},
				TextStyle(
					Graphics.FONT.DEFAULT_FONT_SIZE,
					Graphics.FONT.DEFAULT_FONT_FAMILY,
					"Top box text color",
					"Top box background color"
				)
			)
		)
		favoriteEditEventListeners.close = MouseClickEventListener(closeButton, toggleFavoriteEditing, false)
	end

	local function initFavoriteEditsFrame()
		ui.frames.favoriteEditFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
					height = ui.frames.mainInnerFrame.getSize().height
				},
				"Top box background color",
				"Top box border color"
			),
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL),
			ui.frames.mainInnerFrame
		)
		ui.controls.favoritesHeading =
			TextLabel(
			Component(
				ui.frames.favoriteEditFrame,
				Box(
					{x = 0, y = 0},
					{width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN, height = 16},
					"Top box background color",
					"Top box border color"
				)
			),
			TextField(
				"Edit Favorites",
				{x = 36, y = 0},
				TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
			)
		)
		ui.frames.favoriteLabelsFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
					height = constants.FAVORITES_LABEL_FRAME_HEIGHT
				},
				"Top box background color",
				"Top box border color"
			),
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 3, y = 3}),
			ui.frames.favoriteEditFrame
		)
		ui.favoritesRows = {}
		for i = 1, program.getGameInfo().GEN, 1 do
			ui.favoritesRows[i] = createFavoriteEditRow(i, ui.frames.favoriteLabelsFrame)
		end
		initFavoriteEditCloseButton()
	end

	local function initBottomUI()
		ui.frames.bottomFrame =
			Frame(
			Box(
				{x = 0, y = 86},
				{
					width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
					height = 45
				},
				"Top box background color",
				"Top box border color"
			),
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL),
			ui.frames.mainInnerFrame
		)
		ui.controls.favoritesHeading =
			TextLabel(
			Component(
				ui.frames.bottomFrame,
				Box(
					{x = 0, y = 0},
					{width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN, height = 14},
					nil,
					nil,
					nil,
					nil,
					nil,
					1
				)
			),
			TextField(
				"Favorites",
				{x = 3, y = 0},
				TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
			)
		)
		ui.frames.favoritesFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
					height = 32
				}
			),
			Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 4, {x = 4, y = 1}),
			ui.frames.bottomFrame
		)
		ui.favoriteImages = {}
		for i = 1, 4, 1 do
			ui.favoriteImages[i] =
				ImageLabel(
				Component(ui.frames.favoritesFrame, Box({x = 0, y = 0}, {width = 30, height = 28})),
				ImageField("ironmon_tracker/images/pokemonIconSets/stadiumset/" .. i .. ".png", {x = 0, y = 0}, nil)
			)
			table.insert(favoritePictureListeners, MouseClickEventListener(ui.favoriteImages[i], toggleFavoriteEditing, true))
		end
	end

	local function createTopLabels()
		ui.frames.gameGearFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = 0,
					height = 9
				}
			),
			Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 0, y = 0}),
			ui.frames.topInfoFrame
		)
		ui.controls.gameLabel =
			TextLabel(
			Component(ui.frames.gameGearFrame, Box({x = 0, y = 0}, {width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 23, height = 0})),
			TextField(
				"",
				{x = 2, y = 1},
				TextStyle(
					Graphics.FONT.DEFAULT_FONT_SIZE,
					Graphics.FONT.DEFAULT_FONT_FAMILY,
					"Top box text color",
					"Top box background color"
				)
			)
		)
		ui.controls.gearIcon =
			Icon(Component(ui.frames.gameGearFrame, Box({x = 0, y = 0}, {width = 8, height = 8}, nil, nil)), "GEAR", {x = 0, y = 2})
		table.insert(
			titleScreenEventListeners,
			MouseClickEventListener(ui.controls.gearIcon, program.openScreen, program.UI_SCREENS.MAIN_OPTIONS_SCREEN)
		)
		local labels = {
			"attemptsLabel",
			"statisticLabel1",
			"statisticLabel2",
			"statisticLabel3"
		}
		local heights = {13, 9, 9, 9}
		for i, name in pairs(labels) do
			ui.controls[name] =
				TextLabel(
				Component(
					ui.frames.topInfoFrame,
					Box({x = 0, y = 0}, {width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN, height = heights[i]})
				),
				TextField(
					"",
					{x = 2, y = 1},
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

	local function initTopUI()
		local versionText = "NDS Ironmon Tracker " .. MiscConstants.TRACKER_VERSION
		ui.frames.topFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
					height = Graphics.SIZES.MAIN_SCREEN_HEIGHT - 60
				},
				"Top box background color",
				"Top box border color"
			),
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL),
			ui.frames.mainInnerFrame
		)
		ui.controls.versionHeading =
			TextLabel(
			Component(
				ui.frames.topFrame,
				Box(
					{x = 0, y = 0},
					{width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN, height = 16},
					"Top box background color",
					"Top box border color"
				)
			),
			TextField(
				versionText,
				{x = 4, y = 0},
				TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
			)
		)
		ui.frames.topInfoFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = 0,
					height = 0
				}
			),
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 2, {x = 2, y = 2}),
			ui.frames.topFrame
		)
		createTopLabels()
		table.insert(titleScreenEventListeners, MouseClickEventListener(ui.controls.attemptsLabel, onAttemptsClick))
	end

	local function initUI()
		ui.controls = {}
		ui.frames = {}
		ui.frames.mainFrame =
			Frame(
			Box(
				{x = Graphics.SIZES.SCREEN_WIDTH, y = 5},
				{width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 10, height = Graphics.SIZES.MAIN_SCREEN_HEIGHT - 10},
				"Main background color",
				nil
			),
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 0}),
			nil
		)
		ui.frames.mainInnerFrame =
			Frame(
			Box(
				{x = 0, y = 0},
				{
					width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
					height = Graphics.SIZES.MAIN_SCREEN_HEIGHT - 2 * Graphics.SIZES.BORDER_MARGIN
				}
			),
			nil,
			ui.frames.mainFrame
		)
		initTopUI()
		initFavoriteEditsFrame()
		initBottomUI()
		ui.frames.favoriteEditFrame.setVisibility(false)
		if program.getGameInfo().GEN == 5 then
			frameCounters.rotateFavorites = FrameCounter(60, rotateFavorites, nil, true)
		end
	end

	local function runFrameCounters()
		for _, frameCounter in pairs(frameCounters) do
			frameCounter.decrement()
		end
	end

	function self.runEventListeners()
		self.runBottomEvents()
		if not bottomOnly then
			local eventListeners = titleScreenEventListeners
			if editingFavorites then
				eventListeners = favoriteEditEventListeners
			end
			for _, eventListener in pairs(eventListeners) do
				eventListener.listen()
			end
		end
		runFrameCounters()
	end

	function self.runBottomEvents()
		for _, eventListener in pairs(favoritePictureListeners) do
			eventListener.listen()
		end
	end

	function self.showBottomFrame()
		ui.frames.bottomFrame.show()
	end

	function self.show()
		if not bottomOnly then
			ui.frames.mainFrame.show()
		else
			ui.frames.bottomFrame.show()
		end
	end

	initUI()

	return self
end

return TitleScreen

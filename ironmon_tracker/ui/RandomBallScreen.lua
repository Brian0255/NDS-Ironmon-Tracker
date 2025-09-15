local function RandomBallScreen(initialSettings, initialTracker, initialProgram)
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
	local tracker = initialTracker
	local program = initialProgram
	local constants = {
		MAIN_FRAME_WIDTH = 84,
		MAIN_FRAME_HEIGHT = 49,
		POKEBALL_SIZE = 16,
		DICE_SIZE = 12
	}
	local ui = {}
	local eventListeners = {}
	local self = {}

	local function selectAndReadRandomBall()
		local randomBall = math.random(1, 3)
		local labels = {"Left", "Middle", "Right"}
		local HGSSImageIcons = {"pokeball_blue.png", "pokeball_green.png", "pokeball_red.png"}
		local icon = "pokeball_red.png"
		if program.getGameInfo().VERSION_GROUP == 3 then
			icon = HGSSImageIcons[randomBall]
		end
		ui.controls.pokeballs[randomBall].setPath("ironmon_tracker/images/icons/" .. icon)
		local text = "Random ball: " .. labels[randomBall]
		local centerX = (94 - DrawingUtils.calculateWordPixelLength(text)) / 2
		ui.controls.ballLabel.setText(text)
		ui.controls.ballLabel.setTextOffset({x = centerX, y = 4})

		if program.getGameInfo().VERSION_GROUP == 3 then
			local colors = {
				[1] = "WATER",
				[2] = "GRASS",
				[3] = "FIGHTING"
			}
			ui.controls.ballLabel.setTextColorKey(colors[randomBall])
		end
	end

	local function initDiceBallLabel()
		ui.frames.bottomFrame =
			Frame(Box({x = 0, y = 0}, {width = 0, height = 0}), Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0), ui.frames.mainFrame)
		ui.controls.ballLabel =
			TextLabel(
			Component(ui.frames.bottomFrame, Box({x = 0, y = 0}, {width = 0, height = 0})),
			TextField(
				"",
				{x = 0, y = 4},
				TextStyle(
					Graphics.FONT.DEFAULT_FONT_SIZE,
					Graphics.FONT.DEFAULT_FONT_FAMILY,
					"Top box text color",
					"Top box background color"
				)
			)
		)
	end

	function self.initialize(position)
		ui.frames.mainFrame.move({x = position.x + 1, y = position.y + 1})
	end

	local function initPokeballs()
		ui.frames.pokeballFrame =
			Frame(
			Box({x = 0, y = 0}, {width = 0, height = constants.MAIN_FRAME_HEIGHT - 18}),
			Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 5, {x = 19, y = 0}),
			ui.frames.mainFrame
		)
		local HGSSVerticalOffsets = {
			0,
			18,
			0
		}
		ui.controls.pokeballs = {}
		ui.controls.bstLabels = {}

		local info = program.getGameInfo()

		local colors = {
			[1] = "WATER",
			[2] = "GRASS",
			[3] = "FIGHTING"
		}
		for i = 1, 3, 1 do
			local bstColor = "Top box text color"
			if info.VERSION_GROUP == 3 then
				bstColor = colors[i]
			end

			local offsetY = 12
			if info.VERSION_GROUP == 3 then
				offsetY = HGSSVerticalOffsets[i]
			end
			ui.controls.pokeballs[i] =
				ImageLabel(
				Component(
					ui.frames.pokeballFrame,
					Box({x = 0, y = 0}, {width = constants.POKEBALL_SIZE, height = constants.POKEBALL_SIZE}, nil, nil)
				),
				ImageField("ironmon_tracker/images/trainers/pokeball_large_off.png", {x = 1, y = offsetY}, nil)
			)
			local pokeballWidth = constants.POKEBALL_SIZE
			local bstText = ""

			local id = 0;
		
			if info.VERSION_GROUP == 3 then
			-- Order of the pokeball and starters is 3, 1, 2 in HGSS
				if i == 1 and PokemonData.STARTERS[3] then
					id = PokemonData.STARTERS[3] + 1
					bstText = tostring(PokemonData.POKEMON[id].bst)
				elseif i == 2 and PokemonData.STARTERS[1] then
					id = PokemonData.STARTERS[1] + 1
					bstText = tostring(PokemonData.POKEMON[id].bst)
				elseif i == 3 and PokemonData.STARTERS[2] then
					id = PokemonData.STARTERS[2] + 1
					bstText = tostring(PokemonData.POKEMON[id].bst)
				end
			else
				if i == 1 and PokemonData.STARTERS[1] then
					id = PokemonData.STARTERS[1] + 1
					bstText = tostring(PokemonData.POKEMON[id].bst)
				elseif i == 2 and PokemonData.STARTERS[2] then
					id = PokemonData.STARTERS[2] + 1
					bstText = tostring(PokemonData.POKEMON[id].bst)
				elseif i == 3 and PokemonData.STARTERS[3] then
					id = PokemonData.STARTERS[3] + 1
					bstText = tostring(PokemonData.POKEMON[id].bst)
				end
			end
			local textWidth = DrawingUtils.calculateWordPixelLength(bstText)
			local centerX = 0
			local offsetBSTY = offsetY
			if info.VERSION_GROUP == 3 then
				centerX = - pokeballWidth * 2 - textWidth/2
			else
				centerX = 0
				offsetBSTY = offsetY + 5
			end
			ui.controls.bstLabels[i] =
				TextLabel(
				Component(
					ui.frames.pokeballFrame,
					Box({x = 0, y = 0}, {width = 0, height = 0}, nil, nil, false, nil, nil, 100)
				),
				TextField(
					bstText,
					{x = centerX, y = offsetBSTY}, 
					TextStyle(
						Graphics.FONT.DEFAULT_FONT_SIZE,
						Graphics.FONT.DEFAULT_FONT_FAMILY,
						bstColor,
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
				{x = Graphics.SIZES.SCREEN_WIDTH + 6, y = 6},
				{width = constants.MAIN_FRAME_WIDTH, height = constants.MAIN_FRAME_HEIGHT},
				"Top box background color",
				"Top box background color"
			),
			Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 3}),
			nil
		)
		initPokeballs()
		initDiceBallLabel()
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
	selectAndReadRandomBall()

	return self
end

return RandomBallScreen

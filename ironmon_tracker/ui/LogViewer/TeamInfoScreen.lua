local function TeamInfoScreen(initialSettings, initialTracker, initialProgram, initialLogViewerScreen)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/cOMPONENT.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local ImageLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageLabel.lua")
    local ImageField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageField.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local Icon = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Icon.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local logInfo
    local logViewerScreen = initialLogViewerScreen
    local settings = initialSettings
    local tracker = initialTracker
    local program = initialProgram
    local currentTrainerIndex
    local currentTrainerGroup
    local currentTrainer
    local currentTrainerTeam
    local currentTeamIndex
    local pokemonLoadingFunction
    local gameInfo
    local ui = {}
    local eventListeners = {}
    local self = {}
    local constants = {
        BATTLER_IMAGE_WIDTH = 84,
        BATTLE_IMAGE_HEIGHT = 100,
        POKEBALL_SIZE = 16
    }

    local function onGoBackClick()
    end

    function self.setTrainerGroup(newTrainerGroup)
        currentTrainerGroup = newTrainerGroup
    end

    function self.setTrainerIndex(newTrainerIndex)
        currentTrainerIndex = newTrainerIndex
    end

    local function estimateStat(baseStatName, baseStat, level, iv)
        if baseStatName == "HP" then
            return MiscUtils.round(((iv + 2 * baseStat) * level / 100) + 10 + level)
        else
            return MiscUtils.round(((iv + 2 * baseStat) * level / 100) + 5)
        end
    end

    local function readCurrentTeamIndexIntoUI()
        program.changeMainScreenForTeamInfoView(currentTrainerTeam[currentTeamIndex], pokemonLoadingFunction)
        ui.controls.pokeballs[currentTeamIndex].setPath("ironmon_tracker/images/trainers/pokeball_large.png")
        program.drawCurrentScreens()
    end

    local function onForwardTrainerClick()
        currentTrainerIndex = MiscUtils.increaseTableIndex(currentTrainerIndex, #currentTrainerGroup.battles)
        logViewerScreen.openTrainerTeam(currentTrainerGroup.battles[currentTrainerIndex])
    end

    local function onBackwardTrainerClick()
        currentTrainerIndex = MiscUtils.decreaseTableIndex(currentTrainerIndex, #currentTrainerGroup.battles)
        logViewerScreen.openTrainerTeam(currentTrainerGroup.battles[currentTrainerIndex])
    end

    local function onBackwardPokemonClick()
        ui.controls.pokeballs[currentTeamIndex].setPath("ironmon_tracker/images/trainers/pokeball_large_off.png")
        currentTeamIndex = MiscUtils.decreaseTableIndex(currentTeamIndex, #currentTrainerTeam)
        readCurrentTeamIndexIntoUI()
    end

    local function onForwardPokemonClick()
        ui.controls.pokeballs[currentTeamIndex].setPath("ironmon_tracker/images/trainers/pokeball_large_off.png")
        currentTeamIndex = MiscUtils.increaseTableIndex(currentTeamIndex, #currentTrainerTeam)
        readCurrentTeamIndexIntoUI()
    end

    local function formatPokemon(pokemon)
        --formatting to display it with the main screen
        program.addAdditionalDataToPokemon(pokemon)
        local logPokemon = logInfo.getPokemon()
        pokemon.stats = MiscUtils.shallowCopy(logPokemon[pokemon.pokemonID].stats)
        for statName, baseStat in pairs(pokemon.stats) do
            pokemon.stats[statName] = estimateStat(statName, baseStat, pokemon.level, currentTrainer.iv)
        end
        local learnSet = logPokemon[pokemon.pokemonID].moves
        pokemon.moveIDs = MoveUtils.calculateEnemyMovesAtLevel(learnSet, pokemon.level)
        pokemon.movePPs = {}
        for index, moveID in pairs(pokemon.moveIDs) do
            local pp = MoveData.MOVES[moveID + 1].pp
            pokemon.movePPs[index] = pp
        end
        pokemon.curHP = pokemon.stats.HP
        pokemon.friendship = 0
        pokemon.isEgg = 0
        pokemon.isFemale = 0
        pokemon.status = 0
        pokemon.abilities = logPokemon[pokemon.pokemonID].abilities
        pokemon.ability = logPokemon[pokemon.pokemonID].abilities[1]
        pokemon.nature = 0
        pokemon.fromTeamInfoView = true
    end

    function self.initialize(newLogInfo)
        logInfo = newLogInfo
        gameInfo = program.getGameInfo()
    end

    local function onPokeballClick(index)
        ui.controls.pokeballs[currentTeamIndex].setPath("ironmon_tracker/images/trainers/pokeball_large_off.png")
        currentTeamIndex = index
        readCurrentTeamIndexIntoUI()
    end

    local function createPokeballs(trainerTeam)
        ui.frames.pokeballFrame.clearAllChildren()
        ui.controls.pokeballs = {}
        local imageName = "no_pokeball"
        for i = 1, #trainerTeam, 1 do
            ui.controls.pokeballs[i] =
                ImageLabel(
                Component(
                    ui.frames.pokeballFrame,
                    Box({x = 0, y = 0}, {width = constants.POKEBALL_SIZE, height = constants.POKEBALL_SIZE}, nil, nil)
                ),
                ImageField("ironmon_tracker/images/trainers/pokeball_large_off.png", {x = 1, y = 1}, nil)
            )
            eventListeners["pokeball"..i] = MouseClickEventListener(ui.controls.pokeballs[i],onPokeballClick, i)
        end
        for i = #trainerTeam + 1, 6, 1 do
            ui.controls.pokeballs[i] =
                Icon(
                Component(ui.frames.pokeballFrame, Box({x = 0, y = 0}, {width = 16, height = 0}, nil, nil)),
                "LARGE_DOT",
                {x = 6, y = 6}
            )
            eventListeners["pokeball"..i] = nil
        end
    end

    local function initImageNameUI()
        ui.frames.imageNameFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.BATTLER_IMAGE_WIDTH,
                    height = 0
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 6, y = 10}),
            ui.frames.mainFrame
        )
        ui.controls.battlerImage =
            ImageLabel(
            Component(
                ui.frames.imageNameFrame,
                Box(
                    {x = 0, y = 0},
                    {width = constants.BATTLER_IMAGE_WIDTH, height = constants.BATTLE_IMAGE_HEIGHT},
                    nil,
                    nil
                )
            ),
            ImageField("ironmon_tracker/images/trainers/" .. "shauntal" .. "_team.png", {x = 1, y = 1}, nil)
        )
        ui.frames.arrowNameFrame =
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
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 0, y = 0}),
            ui.frames.imageNameFrame
        )
        local arrowFrameInfo = FrameFactory.createArrowFrame("LEFT_ARROW_LARGE", ui.frames.arrowNameFrame, 14, 4)
        ui.frames.leftTrainerArrow, ui.controls.leftTrainerButton = arrowFrameInfo.frame, arrowFrameInfo.button
        eventListeners.trainerLeft = MouseClickEventListener(ui.controls.leftTrainerButton, onBackwardTrainerClick)
        ui.controls.battlerNameLabel =
            TextLabel(
            Component(
                ui.frames.arrowNameFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = 52,
                        height = 0
                    },
                    nil,
                    nil
                )
            ),
            TextField(
                "Shauntal",
                {x = 0, y = 2},
                TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        arrowFrameInfo = FrameFactory.createArrowFrame("RIGHT_ARROW_LARGE", ui.frames.arrowNameFrame, 14, 4)
        ui.frames.rightTrainerArrow, ui.controls.rightTrainerButton = arrowFrameInfo.frame, arrowFrameInfo.button
        eventListeners.trainerRight = MouseClickEventListener(ui.controls.rightTrainerButton, onForwardTrainerClick)
    end

    local function initPokeballFrame()
        ui.frames.pokeballArrowFrame =
            Frame(
            Box(
                {
                    x = 9,
                    y = 139
                },
                {
                    width = 0,
                    height = 0
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 0, y = 0}),
            ui.frames.teamNavPokeballFrame
        )
        local arrowFrameInfo = FrameFactory.createArrowFrame("LEFT_ARROW_LARGE", ui.frames.pokeballArrowFrame, 14, 3)
        ui.frames.leftPokemonArrow, ui.controls.leftPokemonButton = arrowFrameInfo.frame, arrowFrameInfo.button
        eventListeners.pokemonLeft = MouseClickEventListener(ui.controls.leftPokemonButton, onBackwardPokemonClick)
        ui.frames.pokeballFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 114,
                    height = 0
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 3, {x = 2, y = 1}),
            ui.frames.pokeballArrowFrame
        )

        arrowFrameInfo = FrameFactory.createArrowFrame("RIGHT_ARROW_LARGE", ui.frames.pokeballArrowFrame, 14, 3)
        ui.frames.rightPokemonArrow, ui.controls.rightPokemonButton = arrowFrameInfo.frame, arrowFrameInfo.button
        eventListeners.pokemonright = MouseClickEventListener(ui.controls.rightPokemonButton, onForwardPokemonClick)
    end

    local function initUI()
        ui.controls = {}
        ui.frames = {}
        ui.frames.mainFrame =
            Frame(
            Box(
                {
                    x = Graphics.SIZES.BORDER_MARGIN,
                    y = Graphics.LOG_VIEWER.TAB_HEIGHT + Graphics.SIZES.BORDER_MARGIN + 5
                },
                {
                    width = Graphics.SIZES.SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = Graphics.SIZES.SCREEN_HEIGHT - 2 * Graphics.SIZES.BORDER_MARGIN -
                        Graphics.LOG_VIEWER.TAB_HEIGHT -
                        5
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL),
            nil
        )
        initImageNameUI()
        ui.frames.teamNavPokeballFrame =
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
            nil,
            ui.frames.mainFrame
        )
        initPokeballFrame()
    end

    function self.readCurrentTrainerIndex(newPokemonLoadingFunction, teamIndex)
        pokemonLoadingFunction = newPokemonLoadingFunction
        currentTrainer = currentTrainerGroup.battles[currentTrainerIndex]
        local teamID = currentTrainer.id
        currentTrainerTeam = logInfo.getTrainers()[teamID]
        local name = currentTrainer.name
        if currentTrainerGroup.trainerType == TrainerData.TRAINER_TYPES.RIVAL then
            name = name .. " "..currentTrainer.index
        end
        ui.controls.battlerNameLabel.setText(name)
        local length = DrawingUtils.calculateWordPixelLength(name)
        if currentTrainerGroup.groupType == TrainerData.TRAINER_TYPES.RIVAL then
            length = length - 2
        end
        local centerX = (44 - length) / 2
        ui.controls.battlerNameLabel.setTextOffset({x = centerX, y = 2})
        local prefix = program.getGameInfo().BADGE_PREFIX
        ui.controls.battlerImage.setPath("ironmon_tracker/images/trainers/"..prefix.."/" .. currentTrainer.name .. "_team.png")
        for _, pokemon in pairs(currentTrainerTeam) do
            formatPokemon(pokemon)
        end
        program.moveMainScreen({x = 94, y = 26})
        program.setCurrentScreens({program.UI_SCREENS.LOG_VIEWER_SCREEN, program.UI_SCREENS.MAIN_SCREEN})
        ui.controls.leftPokemonButton.setVisibility(#currentTrainerTeam > 1)
        ui.controls.rightPokemonButton.setVisibility(#currentTrainerTeam > 1)
        createPokeballs(currentTrainerTeam)
        currentTeamIndex = 1
        if teamIndex ~= nil then
            currentTeamIndex = teamIndex
        end
        readCurrentTeamIndexIntoUI()
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

return TeamInfoScreen

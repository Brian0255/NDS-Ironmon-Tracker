local function LogViewerScreen(initialSettings, initialTracker, initialProgram)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local Icon = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Icon.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local PokemonOverviewScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/LogViewer/PokemonOverviewScreen.lua")
    local PokemonStatScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/LogViewer/PokemonStatScreen.lua")
    local TrainerOverviewScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/LogViewer/TrainerOverviewScreen.lua")
    local TeamInfoScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/LogViewer/TeamInfoScreen.lua")
    local InfoScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/LogViewer/InfoScreen.lua")
    local GymTMScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/LogViewer/GymTMScreen.lua")
    local StatsScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/LogViewer/StatsScreen.lua")
    local SearchScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/LogViewer/SearchScreen.lua")
    local PivotsScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/LogViewer/PivotsScreen.lua")
    local ScreenStack = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ScreenStack.lua")

    local tabScreenStack
    local settings = initialSettings
    local tracker = initialTracker
    local program = initialProgram
    local previousTabIndex = nil
    local logInfo
    local pokemonOverviewScreen
    local gymTMScreen
    local statsScreen
    local pokemonStatScreen
    local trainerOverviewScreen
    local teamInfoScreen
    local pokemonScreenStack
    local trainerScreenStack
    local infoScreen
    local searchScreen
    local pivotsScreen
    local sortedTrackedIDs
    local trainerGroups
    local currentIndex = 1
    local tabs = {
        "Pok" .. Chars.accentedE .. "mon",
        "Trainers",
        "Pivots",
        "Gym TMs",
        "Info",
        "Search"
    }
    local tabControls = {}
    local ui = {}
    local eventListeners = {}
    local self = {}
    local goBackFunctionList = {}

    local function updateBackButton()
        ui.controls.goBackButton.setIconName("LONG_LEFT_ARROW")
        if #goBackFunctionList == 0 then
            ui.controls.goBackButton.setIconName("BIG_X")
        end
    end

    local function onGoBackClick()
        local historyLength = #goBackFunctionList
        if historyLength ~= 0 then
            local mostRecent = goBackFunctionList[historyLength]
            goBackFunctionList[historyLength] = nil
            updateBackButton()
            local functionName, argument = mostRecent.functionName, mostRecent.argument
            functionName(argument)
        else
            program.undoTeamInfoView()
            program.openScreen(program.UI_SCREENS.MAIN_SCREEN)
        end
    end

    function self.addGoBackFunction(goBackFunction, argument)
        table.insert(
            goBackFunctionList,
            {
                ["functionName"] = goBackFunction,
                ["argument"] = argument
            }
        )
        updateBackButton()
    end

    function self.setTeamInfoTrainerGroup(newTrainerGroup)
        teamInfoScreen.setTrainerGroup(newTrainerGroup)
    end

    local function undoOpenTrainerTeamFromCard(index)
        program.setCurrentScreens({program.UI_SCREENS.LOG_VIEWER_SCREEN})
        trainerScreenStack.setCurrentIndex(1)
        trainerOverviewScreen.onTabClick(index)
    end

    local function undoOpenTrainerTeamFromTMs()
        program.setCurrentScreens({program.UI_SCREENS.LOG_VIEWER_SCREEN})
        self.changeActiveTabIndex(4)
        program.drawCurrentScreens()
    end

    local function undoOpenTrainerTeamFromSearch()
        program.setCurrentScreens({program.UI_SCREENS.LOG_VIEWER_SCREEN})
        self.changeActiveTabIndex(6)
        program.drawCurrentScreens()
    end

    local function goBackToTeamInfo()
        self.changeActiveTabIndex(2)
        program.setCurrentScreens({program.UI_SCREENS.LOG_VIEWER_SCREEN, program.UI_SCREENS.MAIN_SCREEN})
        program.drawCurrentScreens()
    end

    local function pokemonLoadingFunction(id)
        self.addGoBackFunction(goBackToTeamInfo)
        self.loadPokemonStats(id)
    end

    function self.openStatsScreen()
        self.addGoBackFunction(self.goBackToOverview)
        pokemonScreenStack.setCurrentIndex(3)
        program.drawCurrentScreens()
    end

    function self.goBackToSearchScreen()
        self.changeActiveTabIndex(6)
        program.drawCurrentScreens()
    end

    function self.goBackToOverview()
        self.resetTabs()
        self.changeActiveTabIndex(1)
        program.drawCurrentScreens()
    end

    function self.openTrainerTeam(battle, teamIndex)
        teamInfoScreen.setTrainerIndex(battle.index)
        trainerScreenStack.setCurrentIndex(2)
        teamInfoScreen.readCurrentTrainerIndex(pokemonLoadingFunction, teamIndex)
    end

    function self.openTrainerTeamFromCard(battle)
        self.addGoBackFunction(undoOpenTrainerTeamFromCard, trainerOverviewScreen.getCurrentScreenIndex())
        self.openTrainerTeam(battle)
    end

    function self.openTrainerTeamFromTMPage(trainerInfo)
        self.addGoBackFunction(undoOpenTrainerTeamFromTMs)
        self.changeActiveTabIndex(2)
        trainerOverviewScreen.onTabClick(trainerInfo.groupIndex)
        self.openTrainerTeam(trainerInfo.battle)
    end

    function self.openTrainerTeamFromSearch(trainerInfo, pokemonIndex)
        self.addGoBackFunction(undoOpenTrainerTeamFromSearch)
        self.changeActiveTabIndex(2)
        trainerOverviewScreen.onTabClick(trainerInfo.groupIndex)
        self.openTrainerTeam(trainerInfo.battle, pokemonIndex)
    end

    local function drawLineUnderActiveTab()
        local activeTabControl = tabControls[currentIndex]
        local size = activeTabControl.getSize()
        local position = activeTabControl.getPosition()
        local x1, y1 = position.x, position.y + size.height - 0
        local color = DrawingUtils.convertColorKeyToColor("Top box text color")
        gui.drawRectangle(x1, y1, size.width, 0, color, nil)
    end

    function self.changeActiveTabIndex(newIndex)
        program.setCurrentScreens({program.UI_SCREENS.LOG_VIEWER_SCREEN})
        currentIndex = newIndex
        tabScreenStack.setCurrentIndex(newIndex)
    end

    function self.resetTabs()
        updateBackButton()
        --resets cause lots of screen drawing, disable it
        program.setCanDraw(false)
        pokemonOverviewScreen.reset()
        trainerOverviewScreen.reset()
        statsScreen.reset()
        searchScreen.reset()
        pivotsScreen.reset()
        pokemonScreenStack.setCurrentIndex(1)
        trainerScreenStack.setCurrentIndex(1)
        program.setCanDraw(true)
    end

    local function onTabClick(index)
        goBackFunctionList = {}
        self.resetTabs()
        self.changeActiveTabIndex(index)
        program.drawCurrentScreens()
    end

    local function createTabs()
        local xOffsets = {3, 3, 3, 3, 3, 3}
        for index, tabName in pairs(tabs) do
            local tabWidth = DrawingUtils.calculateWordPixelLength(tabName) + 7
            local tabControl =
                TextLabel(
                Component(
                    ui.frames.tabFrame,
                    Box(
                        {x = 5, y = 5},
                        {
                            width = tabWidth,
                            height = Graphics.LOG_VIEWER.TAB_HEIGHT
                        },
                        "Top box background color",
                        "Top box background color"
                    )
                ),
                TextField(
                    tabName,
                    {x = xOffsets[index], y = 3},
                    TextStyle(
                        Graphics.FONT.DEFAULT_FONT_SIZE,
                        Graphics.FONT.DEFAULT_FONT_FAMILY,
                        "Top box text color",
                        "Top box background color"
                    )
                )
            )
            table.insert(eventListeners, MouseClickEventListener(tabControl, onTabClick, index))
            table.insert(tabControls, tabControl)
        end
        local arrowFrameInfo =
            FrameFactory.createArrowFrame(
            "BIG_X",
            ui.frames.tabFrame,
            27,
            3,
            5,
            "Top box background color",
            "Top box background color"
        )
        ui.frames.goBackFrame, ui.controls.goBackButton = arrowFrameInfo.frame, arrowFrameInfo.button
        ui.frames.goBackFrame.resize({width = 26, height = Graphics.LOG_VIEWER.TAB_HEIGHT})
        table.insert(eventListeners, MouseClickEventListener(ui.frames.goBackFrame, onGoBackClick))
    end

    local function initUI()
        ui.controls = {}
        ui.frames = {}
        ui.frames.mainFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {width = Graphics.SIZES.SCREEN_WIDTH, height = Graphics.SIZES.SCREEN_HEIGHT},
                "Main background color",
                "Main background color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = Graphics.SIZES.BORDER_MARGIN, y = Graphics.SIZES.BORDER_MARGIN}),
            nil
        )
        ui.frames.tabFrame =
            Frame(
            Box({x = 0, y = 0}, {width = 0, height = 0}, nil, nil),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 1, {x = 2, y = 0}),
            ui.frames.mainFrame
        )
        createTabs()
        pokemonStatScreen = PokemonStatScreen(settings, tracker, program, self)
        pokemonOverviewScreen = PokemonOverviewScreen(settings, tracker, program, self)
        trainerOverviewScreen = TrainerOverviewScreen(settings, tracker, program, self)
        teamInfoScreen = TeamInfoScreen(settings, tracker, program, self)
        gymTMScreen = GymTMScreen(settings, tracker, program, self)
        statsScreen = StatsScreen(settings, tracker, program, self)
        searchScreen = SearchScreen(settings, tracker, program, self)
        pokemonScreenStack = ScreenStack({pokemonOverviewScreen, pokemonStatScreen, statsScreen})
        trainerScreenStack = ScreenStack({trainerOverviewScreen, teamInfoScreen})
        infoScreen = InfoScreen(settings, tracker, program, self)
        pivotsScreen = PivotsScreen(settings, tracker, program, self)
        tabScreenStack =
            ScreenStack(
            {pokemonScreenStack, trainerScreenStack, pivotsScreen, gymTMScreen, infoScreen, searchScreen, statsScreen}
        )
    end

    function self.updatePokemonStatIDs(newIDs)
        pokemonStatScreen.updateIDs(newIDs)
    end

    function self.loadPokemonStats(id)
        self.changeActiveTabIndex(1)
        pokemonScreenStack.setCurrentIndex(2)
        pokemonStatScreen.loadPokemonID(id)
    end

    function self.readStats(pokemon)
        local orderedStats = {"HP", "ATK", "DEF", "SPA", "SPD", "SPE"}
        local dataSet = {}
        for _, stat in pairs(orderedStats) do
            table.insert(dataSet, {stat, pokemon.stats[stat]})
        end
        return dataSet
    end

    local function formatTrainerGroups()
        local starterNumber = logInfo.getStarterNumber()
        for _, trainerGroup in pairs(trainerGroups) do
            for index, battle in pairs(trainerGroup.battles) do
                --bw gym 1 has 3 different trainers based on starter
                if #battle == 3 then
                    battle = battle[starterNumber]
                end
                local battleIndex = 1
                --rivals have 3 different teams based on starter
                if #battle.ids == 3 then
                    battleIndex = starterNumber
                end
                battle.id = battle.ids[battleIndex]
                battle.index = index
                trainerGroup.battles[index] = battle
                if trainerGroup.trainerType == TrainerData.TRAINER_TYPES.RIVAL then
                    battle.name = trainerGroup.groupName
                end
            end
        end
    end

    function self.getTrainerGroups()
        return trainerGroups
    end

    function self.initialize(newLogInfo)
        logInfo = newLogInfo
        trainerGroups = MiscUtils.deepCopy(program.getGameInfo().TRAINERS.IMPORTANT_GROUPS)
        formatTrainerGroups()
        trainerOverviewScreen.initialize(logInfo)
        teamInfoScreen.initialize(logInfo)
        pokemonStatScreen.initialize(logInfo)
        pokemonOverviewScreen.initialize(logInfo)
        statsScreen.initialize(logInfo)
        gymTMScreen.initialize(logInfo)
        infoScreen.initialize(logInfo)
        searchScreen.initialize(logInfo, trainerGroups)
        pivotsScreen.initialize(logInfo)
        self.resetTabs()
        self.changeActiveTabIndex(1)
        program.drawCurrentScreens()
    end

    function self.runEventListeners()
        for _, eventListener in pairs(eventListeners) do
            eventListener.listen()
        end
        tabScreenStack.runEventListeners()
    end

    function self.show()
        ui.frames.mainFrame.show()
        drawLineUnderActiveTab()
        tabScreenStack.show()
    end

    initUI()

    return self
end

return LogViewerScreen

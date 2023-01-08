local function LogViewerScreen(initialSettings, initialTracker, initialProgram)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/cOMPONENT.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local Icon = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Icon.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local PokemonOverviewScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/LogViewer/PokemonOverviewScreen.lua")
    local PokemonStatScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/LogViewer/PokemonStatScreen.lua")
    local TrainerOverviewScreen = dofile(Paths.FOLDERS.UI_FOLDER .. "/LogViewer/TrainerOverviewScreen.lua")
    local ScreenStack = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ScreenStack.lua")
    local tabScreenStack
    local settings = initialSettings
    local tracker = initialTracker
    local program = initialProgram
    local previousTabIndex = nil
    local pokemonOverviewScreen
    local pokemonStatScreen
    local pokemonScreenStack
    local trainerOverviewScreen
    local sortedTrackedIDs
    local currentIndex = 1
    local tabs = {
        "Pok\233mon",
        "Trainers",
        "Gym TMs",
        "Statistics"
    }
    local tabControls = {}
    local ui = {}
    local eventListeners = {}
    local self = {}
    local goBackFunctionList = {}

    local function onGoBackClick()
        local historyLength = #goBackFunctionList
        if historyLength ~= 0 then
            local mostRecent = goBackFunctionList[historyLength]
            local functionName, argument = mostRecent.functionName, mostRecent.argument
            functionName(argument)
            goBackFunctionList[historyLength] = nil
        end
    end

    local function addGoBackFunction(goBackFunction, argument)
        table.insert(
            goBackFunctionList,
            {
                ["functionName"] = goBackFunction,
                ["argument"] = argument
            }
        )
    end

    local function setPreviousTabIndex(newPreviousTabIndex)
        previousTabIndex = newPreviousTabIndex
    end

    local function drawLineUnderActiveTab()
        local activeTabControl = tabControls[currentIndex]
        local size = activeTabControl.getSize()
        local position = activeTabControl.getPosition()
        local x1, y1 = position.x, position.y + size.height - 0
        local x2, y2 = x1 + size.width, y1
        local color = DrawingUtils.convertColorKeyToColor("Top box text color")
        gui.drawRectangle(x1, y1, size.width, 0, color, nil)
    end

    local function changeActiveTabIndex(newIndex)
        currentIndex = newIndex
        tabScreenStack.setCurrentIndex(newIndex)
    end

    local function onTabClick(index)
        currentIndex = index
        changeActiveTabIndex(index)
        program.drawCurrentScreens()
    end

    local function createTabs()
        local xOffsets = {5, 10, 7, 7}
        for index, tabName in pairs(tabs) do
            local tabControl =
                TextLabel(
                Component(
                    ui.frames.tabFrame,
                    Box(
                        {x = 5, y = 5},
                        {
                            width = Graphics.LOG_VIEWER.TAB_WIDTH,
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
            Layout(
                Graphics.ALIGNMENT_TYPE.VERTICAL,
                0,
                {x = Graphics.SIZES.BORDER_MARGIN, y = Graphics.SIZES.BORDER_MARGIN}
            ),
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
        trainerOverviewScreen = TrainerOverviewScreen(settings, tracker, program)
        pokemonScreenStack = ScreenStack({pokemonOverviewScreen, pokemonStatScreen})
        tabScreenStack = ScreenStack({pokemonScreenStack, trainerOverviewScreen})
    end

    function self.loadPokemonStats(id)
        pokemonScreenStack.setCurrentIndex(2)
        pokemonStatScreen.loadPokemonID(id)
    end

    function self.initialize(logInfo)
        changeActiveTabIndex(1)
        pokemonStatScreen.initialize(logInfo)
        pokemonOverviewScreen.initialize(logInfo)
    end

    function self.runEventListeners()
        for _, eventListener in pairs(eventListeners) do
            eventListener.listen()
        end
        tabScreenStack.runEventListeners()
    end

    function self.show()
        ui.frames.mainFrame.show()
        tabScreenStack.show()
        drawLineUnderActiveTab()
    end

    initUI()

    return self
end

return LogViewerScreen

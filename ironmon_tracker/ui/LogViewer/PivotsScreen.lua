local function PivotsScreen(initialSettings, initialTracker, initialProgram, initialLogViewerScreen)
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
    local logInfo
    local logViewerScreen = initialLogViewerScreen
    local settings = initialSettings
    local tracker = initialTracker
    local program = initialProgram
    local constants = {
        SELECTOR_FRAME_WIDTH = 80,
        AREAS_TITLE_HEIGHT = 16,
        AREA_NAME_HEIGHT = 12,
        ENCOUNTER_TAB_HEIGHT = 21,
        POKEMON_LIST_HEIGHT = 133
    }
    local ui = {}
    local pokemonScrollBar
    local eventListeners = {}
    local pokemonListeners = {}
    local self = {}
    local areaLabels = {}
    local encounterTabs = {}
    local encounterRows = {}
    local currentEncounterType = ""
    local currentEncounterArea = {}
    local currentIDs = {}
    local currentPokemonList = {}
    local pivotData = {}
    local encounterTypes = {
        "Grass",
        "Cave",
        "Shaking Spots",
        "Old Rod",
        "Headbutt(C)",
        "Headbutt(R)",
        "Dark Grass",
        "Tuesday",
        "Thursday",
        "Saturday"
    }

    local function underlineActiveTab()
    end

    local function onPokemonClick(id)
        if id == nil then
            return
        end
        logViewerScreen.addGoBackFunction(
            function()
                logViewerScreen.changeActiveTabIndex(3)
                program.drawCurrentScreens()
            end
        )
        logViewerScreen.loadPokemonStats(id)
    end

    local function sortIDs(ids, pokemonList)
        table.sort(
            ids,
            function(id1, id2)
                local data1 = pokemonList[id1]
                local data2 = pokemonList[id2]
                if data1.percent == data2.percent then
                    if data1.minLevel == data2.minLevel then
                        if data1.maxLevel == data2.maxLevel then
                            return data1.percent > data2.percent
                        else
                            return data1.maxLevel < data2.maxLevel
                        end
                    else
                        return data1.minLevel < data2.minLevel
                    end
                else
                    return data1.percent > data2.percent
                end
            end
        )
    end

    local function readScroller()
        local items = pokemonScrollBar.getViewedItems()
        local extraXOffset = 0
        if #currentIDs < 9 then
            extraXOffset = 3
        end
        for i = 1, 8, 1 do
            local row = encounterRows[i]
            local name, levels, percent = "", "", ""
            local pokemonID = items[i]
            local data = currentPokemonList[pokemonID]
            if pokemonID ~= nil then
                name = PokemonData.POKEMON[pokemonID + 1].name
                levels = "Lv. " .. data.minLevel
                if data.minLevel ~= data.maxLevel then
                    levels = levels .. " - " .. data.maxLevel
                end
                percent = data.percent .. "%"
                local xOffset = (3 - #tostring(percent)) * 5 + extraXOffset * 2
                row.percent.setTextOffset({x = xOffset, y = -1})
                row.levels.setTextOffset({x = extraXOffset, y = -1})
            end
            row.name.setText(name)
            row.levels.setText(levels)
            row.percent.setText(percent)
            pokemonListeners[i].setOnClickParams(pokemonID)
        end
        program.drawCurrentScreens()
    end

    local function readCurrentEncounterType()
        currentPokemonList = currentEncounterArea[currentEncounterType]
        local ids = {}
        for id, data in pairs(currentPokemonList) do
            table.insert(ids, id)
        end
        sortIDs(ids, currentPokemonList)
        currentIDs = ids
        pokemonScrollBar.setItems(ids)
        readScroller()
    end

    local function onAreaClick(labelIndex)
        local areaName = areaLabels[labelIndex].getText()
        if areaName == nil or areaName == "" then
            return
        end
        currentEncounterArea = pivotData[areaName]
        for _, encounterType in pairs(encounterTypes) do
            if currentEncounterArea[encounterType] then
                currentEncounterType = encounterType
                break
            end
        end
        for encounterAreaName, label in pairs(encounterTabs) do
            local visible = currentEncounterArea[encounterAreaName] ~= nil
            label.setVisibility(visible)
        end
        for _, areaLabel in pairs(areaLabels) do
            areaLabel.setTextColorKey("Top box text color")
        end
        areaLabels[labelIndex].setTextColorKey("Positive text color")
        readCurrentEncounterType()
    end

    function self.reset()
        onAreaClick(1)
    end

    local function onEncounterTypeClick(encounterType)
        currentEncounterType = encounterType
        readCurrentEncounterType()
    end

    function self.initialize(newLogInfo)
        logInfo = newLogInfo
        local gameInfo = program.getGameInfo()
        pivotData = logInfo.getPivotData()
        local areas = logInfo.getPivotData()
        for i, areaName in pairs(gameInfo.LOCATION_DATA.encounterAreaOrder) do
            areaLabels[i].setText(areaName)
        end
        self.reset()
    end

    local function createAreaLabel()
        local areaLabel =
            TextLabel(
            Component(
                ui.frames.areaListFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = 72,
                        height = constants.AREA_NAME_HEIGHT
                    }
                )
            ),
            TextField(
                "",
                {x = 0, y = -1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )

        table.insert(areaLabels, areaLabel)
        table.insert(eventListeners, MouseClickEventListener(areaLabel, onAreaClick, #areaLabels))
    end

    local function initAreaSelectorFrame()
        ui.frames.mainSelectorFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = constants.SELECTOR_FRAME_WIDTH,
                    height = Graphics.SIZES.SCREEN_HEIGHT - 2 * Graphics.SIZES.BORDER_MARGIN - Graphics.LOG_VIEWER.TAB_HEIGHT -
                        5
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL),
            ui.frames.mainFrame
        )

        ui.controls.areasLabel =
            TextLabel(
            Component(
                ui.frames.mainSelectorFrame,
                Box(
                    {x = 20, y = 0},
                    {
                        width = constants.SELECTOR_FRAME_WIDTH,
                        height = constants.AREAS_TITLE_HEIGHT
                    },
                    nil,
                    "Top box border color"
                )
            ),
            TextField(
                "Areas",
                {x = 24, y = 0},
                TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        ui.frames.areaListFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = 0,
                    height = 0
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 3, y = 4}),
            ui.frames.mainSelectorFrame
        )
        for i = 1, 11, 1 do
            createAreaLabel()
        end
    end

    local function initEncounterTabs()
        for _, encounterType in pairs(encounterTypes) do
            local tab =
                TextLabel(
                Component(
                    ui.frames.encounterTabsFrame,
                    Box(
                        {x = 0, y = 0},
                        {
                            ["width"] = DrawingUtils.calculateWordPixelLength(encounterType) + 5,
                            height = 12
                        }
                    )
                ),
                TextField(
                    encounterType,
                    {x = 2, y = -1},
                    TextStyle(
                        Graphics.FONT.DEFAULT_FONT_SIZE,
                        Graphics.FONT.DEFAULT_FONT_FAMILY,
                        "Top box text color",
                        "Top box background color"
                    )
                )
            )
            encounterTabs[encounterType] = tab
            table.insert(eventListeners, MouseClickEventListener(tab, onEncounterTypeClick, encounterType))
        end
    end

    local function createPokemonDataRow()
        local rowLabels = {}
        local rowFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = 132,
                    height = 16
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 20, {x = 0, y = 0}),
            ui.frames.pokemonListFrame
        )
        local widths = {46, 34, 20}
        local names = {"name", "levels", "percent"}
        for i = 1, 3, 1 do
            rowLabels[names[i]] =
                TextLabel(
                Component(
                    rowFrame,
                    Box(
                        {x = 0, y = 0},
                        {
                            width = widths[i],
                            height = 16
                        }
                    )
                ),
                TextField(
                    "",
                    {x = 0, y = -1},
                    TextStyle(
                        Graphics.FONT.DEFAULT_FONT_SIZE,
                        Graphics.FONT.DEFAULT_FONT_FAMILY,
                        "Top box text color",
                        "Top box background color"
                    )
                )
            )
        end
        table.insert(pokemonListeners, MouseClickEventListener(rowFrame, onPokemonClick, nil))
        return rowLabels
    end

    local function initEncounterDataList()
        ui.frames.pokemonScrollFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = Graphics.SIZES.SCREEN_WIDTH - constants.SELECTOR_FRAME_WIDTH - 21,
                    height = constants.POKEMON_LIST_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            nil,
            ui.frames.areaDataFrame
        )
        ui.frames.pokemonListFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = 0,
                    height = 0
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 4, y = 6}),
            ui.frames.pokemonScrollFrame
        )
        for i = 1, 8, 1 do
            encounterRows[i] = createPokemonDataRow()
        end
        pokemonScrollBar = ScrollBar(ui.frames.pokemonScrollFrame, 8, {})
        pokemonScrollBar.setScrollReadingFunction(readScroller)
    end

    local function initAreaDataFrame()
        ui.frames.areaDataFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = Graphics.SIZES.SCREEN_WIDTH - constants.SELECTOR_FRAME_WIDTH - 15,
                    height = Graphics.SIZES.SCREEN_HEIGHT - 2 * Graphics.SIZES.BORDER_MARGIN - Graphics.LOG_VIEWER.TAB_HEIGHT -
                        5
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 3, y = 3}),
            ui.frames.mainFrame
        )
        ui.frames.encounterTabsFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = 0,
                    height = constants.ENCOUNTER_TAB_HEIGHT
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 2, {x = 1, y = 4}),
            ui.frames.areaDataFrame
        )
        initEncounterTabs()
        initEncounterDataList()
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
                    height = Graphics.SIZES.SCREEN_HEIGHT - 2 * Graphics.SIZES.BORDER_MARGIN - Graphics.LOG_VIEWER.TAB_HEIGHT -
                        5
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 5),
            nil
        )
        initAreaSelectorFrame()
        initAreaDataFrame()
    end

    function self.runEventListeners()
        for _, eventListener in pairs(eventListeners) do
            eventListener.listen()
        end
        for _, eventListener in pairs(pokemonListeners) do
            eventListener.listen()
        end
        pokemonScrollBar.update()
    end

    function self.show()
        ui.frames.mainFrame.show()
        UIUtils.underlineTextLabel(encounterTabs[currentEncounterType])
    end

    initUI()
    return self
end

return PivotsScreen

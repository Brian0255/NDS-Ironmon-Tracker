local function SearchScreen(initialSettings, initialTracker, initialProgram, initialLogViewerScreen)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local Icon = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Icon.lua")
    local ScrollBar = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ScrollBar.lua")
    local ImageLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageLabel.lua")
    local ImageField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageField.lua")
    local SearchKeyboard = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/SearchKeyboard.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local HoverEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/HoverEventListener.lua")
    local logInfo
    local miscInfo
    local settings = initialSettings
    local logViewerScreen = initialLogViewerScreen
    local tracker = initialTracker
    local program = initialProgram
    local currentDataGroup = MoveData.MOVES
    local currentMatchGroups = {}
    local currentMatchGroupIndex = 1
    local logPokemon
    local sortedPokemonIDs = {}
    local sortedTrainers = {}
    local currentMatchID = -1
    local logTrainers
    local resultsScroller

    local constants = {
        LOOK_FOR = {
            POKEMON = "Pok" .. Chars.accentedE .. "mon",
            TRAINERS = "Trainers"
        },
        WITH = {
            MOVE = "Move",
            ABILITY = "Ability"
        },
        RESULT_FRAME_WIDTH = 99,
        RESULT_FRAME_HEIGHT = 137,
        SEARCH_FRAME_WIDTH = 138,
        POKEMON_RESULT_HEIGHT = 28
    }

    local searchOptions = {
        ["Look for:"] = constants.LOOK_FOR.POKEMON,
        ["With:"] = constants.WITH.MOVE
    }

    local ui = {}
    local eventListeners = {}
    local resultFrames = {}
    local matchEventListeners = {}
    local resultEventListeners = {}
    local matchTextLabels = {}
    local self = {}

    local function turnOffAllMatches()
        for _, label in pairs(matchTextLabels) do
            label.setTextColorKey("Top box text color")
        end
    end

    local function clearMatches()
        matchTextLabels = {}
        ui.frames.matchFrame.clearAllChildren()
    end

    local function onPokemonClick(pokemonID)
        if pokemonID == nil then
            return
        end
        logViewerScreen.addGoBackFunction(logViewerScreen.goBackToSearchScreen)
        logViewerScreen.loadPokemonStats(pokemonID)
    end

    local function clearResultFrame(frameInfo)
        frameInfo.imageLabel.setPath("")
        frameInfo.label1.setText("")
        frameInfo.label2.setText("")
    end

    local function clearResults()
        resultEventListeners = {}
        for index = 1, 4, 1 do
            local frameInfo = resultFrames[index]
            clearResultFrame(frameInfo)
        end
    end

    local function onTrainerClick(params)
        local trainerInfo, foundPokemon = params.trainerInfo, params.foundPokemon
        logViewerScreen.openTrainerTeamFromSearch(trainerInfo, foundPokemon[1])
    end

    local function readTrainerIntoRow(frameInfo, rowInfo)
        local trainerInfo = rowInfo.trainerInfo
        frameInfo.imageLabel.setOffset({x = 0, y = 0})
        local folderName = program.getGameInfo().BADGE_PREFIX
        frameInfo.imageLabel.setPath(
            "ironmon_tracker/images/trainers/" .. folderName .. "/small/" .. trainerInfo.imageName .. ".png"
        )
        frameInfo.label1.setText(trainerInfo.battleName)
        frameInfo.label2.setText(#rowInfo.foundPokemon .. " Pok" .. Chars.accentedE .. "mon")
        AnimatedSpriteManager.removeImage(frameInfo.imageLabel)
        table.insert(resultEventListeners, MouseClickEventListener(frameInfo.frame, onTrainerClick, rowInfo))
    end

    local function readPokemonIDIntoFrame(frameInfo, pokemonID)
        local currentIconSet = IconSets.SETS[settings.appearance.ICON_SET_INDEX]
        DrawingUtils.readPokemonIDIntoImageLabel(currentIconSet, pokemonID, frameInfo.imageLabel)
        local info = PokemonData.POKEMON[pokemonID + 1]
        frameInfo.label1.setText(info.name)
    end

    local function readPokemonIntoRow(rowInfo, frameInfo)
        readPokemonIDIntoFrame(frameInfo, rowInfo.pokemonID)
        frameInfo.label2.setText(rowInfo.label2)
        table.insert(resultEventListeners, MouseClickEventListener(frameInfo.frame, onPokemonClick, rowInfo.pokemonID))
    end

    function self.reset()
        clearMatches()
        searchOptions["Look for:"] = constants.LOOK_FOR.POKEMON
        searchOptions["With:"] = constants.WITH.MOVE
        currentDataGroup = MoveData.MOVES
        ui.searchKeyboard.updateDataGroup(currentDataGroup)
        ui.searchKeyboard.updateItemSet(MiscUtils.getSortedKeysByName(currentDataGroup))
        ui.searchKeyboard.clearKeyboard()
        ui.controls.totalFound.setText("None found")
        ui.controls.totalFound.setTextOffset({x = 20, y = 1})
        resultsScroller.setItems({})
        clearResults()
    end

    local function readResultsIntoScroller()
        clearResults()
        resultEventListeners = {}
        local rowInfos = resultsScroller.getViewedItems()
        for index = 1, 4, 1 do
            local frameInfo = resultFrames[index]
            local rowInfo = rowInfos[index]
            if rowInfo ~= nil then
                if searchOptions["Look for:"] == constants.LOOK_FOR.POKEMON then
                    readPokemonIntoRow(rowInfo, frameInfo)
                else
                    readTrainerIntoRow(frameInfo, rowInfo)
                end
            end
        end
        program.drawCurrentScreens()
    end

    local function findPokemonWithMove(moveID)
        local matchingPokemonWithMove = {}
        for _, pokemonID in pairs(sortedPokemonIDs) do
            local pokemonInfo = logPokemon[pokemonID]
            local moves = pokemonInfo.moves
            for index, moveInfo in pairs(moves) do
                if moveInfo.move == moveID then
                    table.insert(
                        matchingPokemonWithMove,
                        {
                            ["pokemonID"] = pokemonID,
                            label2 = MoveUtils.calculateLevelRangeOfMove(index, moves)
                        }
                    )
                end
            end
        end
        return matchingPokemonWithMove
    end

    local function getAbilityText(abilities)
        local total = 0
        for _, ability in pairs(abilities) do
            if ability ~= 0 then
                total = total + 1
            end
        end
        local text = "Only ability"
        if total > 1 then
            text = "1 of " .. total .. " abilities"
        end
        return text
    end

    local function findPokemonWithAbility(abilityID)
        local matchingPokemonWithAbility = {}
        for _, pokemonID in pairs(sortedPokemonIDs) do
            local pokemonInfo = logPokemon[pokemonID]
            local abilities = pokemonInfo.abilities
            if MiscUtils.tableContains(abilities, abilityID) then
                table.insert(
                    matchingPokemonWithAbility,
                    {
                        ["pokemonID"] = pokemonID,
                        label2 = getAbilityText(abilities)
                    }
                )
            end
        end
        return matchingPokemonWithAbility
    end

    local function findTrainersWithMatch(id, checkingForMove)
        local matchedTrainers = {}
        for _, trainerEntry in pairs(sortedTrainers) do
            local trainerID = trainerEntry.battle.id
            local trainerTeam = logTrainers[trainerID]
            local foundPokemon = {}
            for pokemonIndex, pokemonEntry in pairs(trainerTeam) do
                local pokemonInfo = logPokemon[pokemonEntry.pokemonID]
                if checkingForMove then
                    local moves = MoveUtils.calculateEnemyMovesAtLevel(pokemonInfo.moves, pokemonEntry.level)
                    for _, currentMoveID in pairs(moves) do
                        if currentMoveID == id then
                            table.insert(foundPokemon, pokemonIndex)
                        end
                    end
                else
                    local abilities = pokemonInfo.abilities
                    if MiscUtils.tableContains(abilities, id) then
                        table.insert(foundPokemon, pokemonIndex)
                    end
                end
            end
            if next(foundPokemon) ~= nil then
                table.insert(
                    matchedTrainers,
                    {
                        trainerInfo = trainerEntry,
                        ["foundPokemon"] = foundPokemon
                    }
                )
            end
        end
        return matchedTrainers
    end

    local function getTrainerResults(matchedID)
        local checkingMove = searchOptions["With:"] == constants.WITH.MOVE
        return findTrainersWithMatch(matchedID, checkingMove)
    end

    local function getPokemonResults(matchedID)
        local matchingResults = {}
        if searchOptions["With:"] == constants.WITH.MOVE then
            matchingResults = findPokemonWithMove(matchedID)
        else
            matchingResults = findPokemonWithAbility(matchedID)
        end
        return matchingResults
    end

    local function updateSearch()
        local matchingResults = {}
        if searchOptions["Look for:"] == constants.LOOK_FOR.POKEMON then
            matchingResults = getPokemonResults(currentMatchID)
        else
            matchingResults = getTrainerResults(currentMatchID)
        end
        resultsScroller.setItems(matchingResults)
        local newText = "Total: " .. #matchingResults
        if #matchingResults == 0 then
            newText = "None found"
        end
        local newLength = DrawingUtils.calculateWordPixelLength(newText) + #newText + 2
        local centerX = (constants.RESULT_FRAME_WIDTH - newLength) / 2
        ui.controls.totalFound.setTextOffset({x = centerX, y = 1})
        ui.controls.totalFound.setText(newText)
        readResultsIntoScroller()
    end

    local function updateKeyboardItems()
        local dataGroups = {
            [constants.WITH.MOVE] = MoveData.MOVES,
            [constants.WITH.ABILITY] = AbilityData.ABILITIES
        }
        currentDataGroup = dataGroups[searchOptions["With:"]]
        ui.searchKeyboard.updateItemSet(MiscUtils.getSortedKeysByName(currentDataGroup))
        ui.searchKeyboard.updateDataGroup(currentDataGroup)
        ui.searchKeyboard.updateSearch()
        currentMatchID = -1
    end

    local function onSearchTypeRadioClick(params)
        local radioButton, isLookForButton = params.radioButton, params.isLookForButton
        radioButton.onRadioClick()
        if not isLookForButton then
            updateKeyboardItems()
        end
        updateSearch()
        program.drawCurrentScreens()
    end

    local function onMatchClick(params)
        local button, matchID = params.button, params.matchID
        currentMatchID = matchID
        turnOffAllMatches()
        button.setTextColorKey("Positive text color")
        updateSearch()
    end

    local function createResultFrame()
        local frame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.RESULT_FRAME_WIDTH - 11,
                    height = constants.POKEMON_RESULT_HEIGHT
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 0, y = 0}),
            ui.frames.resultListFrame
        )
        local imageLabel =
            ImageLabel(
            Component(frame, Box({x = 0, y = 0}, {width = 30, height = 28}, nil, nil)),
            ImageField("ironmon_tracker/images/trainers/bw/caitlin_vs.png", {x = 0, y = -5}, nil)
        )

        local labelFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 0,
                    height = 14
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 0}),
            frame
        )

        local labels = {}

        for i = 1, 2, 1 do
            labels[i] =
                TextLabel(
                Component(labelFrame, Box({x = 0, y = 0}, {width = 0, height = 12})),
                TextField(
                    "Lv. 30 - 100",
                    {x = 2, y = 2},
                    TextStyle(
                        Graphics.FONT.DEFAULT_FONT_SIZE,
                        Graphics.FONT.DEFAULT_FONT_FAMILY,
                        "Top box text color",
                        "Top box background color"
                    )
                )
            )
        end

        local resultFrame = {
            ["frame"] = frame,
            ["imageLabel"] = imageLabel,
            label1 = labels[1],
            label2 = labels[2]
        }
        return resultFrame
    end

    local function createResultListUI()
        ui.frames.resultListFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.RESULT_FRAME_WIDTH - 5,
                    height = ui.frames.mainFrame.getSize().height - 6
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 5, {x = 3, y = 5}),
            ui.frames.resultFrame
        )
        for i = 1, 4, 1 do
            local frame = createResultFrame()
            resultFrames[i] = frame
        end
    end

    local function createSearchOptionRow(parentFrame, firstLabelName, searchOptionSet, radioGroupKey)
        local rowFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.SEARCH_FRAME_WIDTH,
                    height = 22
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 1, {x = 0, y = 3}),
            parentFrame
        )
        local rightAlignedX = 39 - DrawingUtils.calculateWordPixelLength(firstLabelName) - 4
        local searchTypeLabel =
            TextLabel(
            Component(rowFrame, Box({x = 0, y = 0}, {width = 39, height = 16})),
            TextField(
                firstLabelName,
                {x = rightAlignedX, y = 2},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        for _, searchOption in pairs(searchOptionSet) do
            local length = DrawingUtils.calculateWordPixelLength(searchOption)
            local labelWidth = length + 10
            local centerX = (labelWidth - length) / 2 - 1
            local searchOptionLabel =
                TextLabel(
                Component(rowFrame, Box({x = 0, y = 0}, {width = labelWidth, height = 16})),
                TextField(
                    searchOption,
                    {x = centerX, y = 2},
                    TextStyle(
                        Graphics.FONT.DEFAULT_FONT_SIZE,
                        Graphics.FONT.DEFAULT_FONT_FAMILY,
                        "Top box text color",
                        "Top box background color"
                    )
                ),
                true,
                searchOptions,
                radioGroupKey,
                searchOption
            )
            local params = {
                radioButton = searchOptionLabel,
                isLookForButton = radioGroupKey == "Look for:"
            }
            table.insert(eventListeners, MouseClickEventListener(searchOptionLabel, onSearchTypeRadioClick, params))
        end
    end

    function self.initialize(newLogInfo, trainerGroups)
        sortedTrainers = MiscUtils.convertTrainerGroupsToSortedIndices(trainerGroups)
        logInfo = newLogInfo
        logTrainers = logInfo.getTrainers()
        logPokemon = logInfo.getPokemon()
        sortedPokemonIDs = {}
        for id, _ in pairs(logPokemon) do
            table.insert(sortedPokemonIDs, id)
        end
        MiscUtils.sortPokemonIDsByName(sortedPokemonIDs)
        ui.searchKeyboard.clearKeyboard()
        currentDataGroup = MoveData.MOVES
    end

    local function readCurrentMatchGroup()
        clearMatches()
        matchEventListeners = {}
        local matches = currentMatchGroups[currentMatchGroupIndex]
        if matches == nil then
            return
        end
        for _, match in pairs(matches) do
            local name = currentDataGroup[match + 1].name
            local label = UIUtils.createKeyboardMatchLabel(ui.frames.matchFrame, name, 13)
            table.insert(matchTextLabels, label)
        end
        for index, label in pairs(matchTextLabels) do
            local matchParams = {
                button = matchTextLabels[index],
                matchID = matches[index]
            }
            table.insert(matchEventListeners, MouseClickEventListener(label, onMatchClick, matchParams))
        end
    end

    local function createLabelsFromMatches(matches)
        currentMatchGroups =
            MiscUtils.splitIDsByMaximumPixelLength(matches, currentDataGroup, ui.frames.matchFrame.getSize().width - 6, 7)
        currentMatchGroupIndex = 1
        ui.controls.matchRight.setVisibility(#currentMatchGroups > 1)
        ui.controls.matchLeft.setVisibility(#currentMatchGroups > 1)
        readCurrentMatchGroup()
        program.drawCurrentScreens()
    end

    local function increaseMatchGroupIndex()
        currentMatchGroupIndex = MiscUtils.increaseTableIndex(currentMatchGroupIndex, #currentMatchGroups)
        readCurrentMatchGroup()
        program.drawCurrentScreens()
    end

    local function decreaseMatchGroupIndex()
        currentMatchGroupIndex = MiscUtils.decreaseTableIndex(currentMatchGroupIndex, #currentMatchGroups)
        readCurrentMatchGroup()
        program.drawCurrentScreens()
    end

    local function initMatchesUI()
        ui.frames.matchMainFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 0,
                    height = 17
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 2, y = 6}),
            ui.frames.keyboardFrame
        )
        local arrowWidth, arrowHeight = 10, 13
        ui.controls.matchLeft =
            TextLabel(
            Component(
                ui.frames.matchMainFrame,
                Box(
                    {x = 0, y = 0},
                    {width = arrowWidth, height = arrowHeight},
                    "Top box background color",
                    "Top box border color"
                )
            ),
            TextField(
                "<",
                {x = 1, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.frames.matchFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.SEARCH_FRAME_WIDTH - 20,
                    height = 12
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 3, {x = 3, y = 0}),
            ui.frames.matchMainFrame
        )
        ui.controls.matchRight =
            TextLabel(
            Component(
                ui.frames.matchMainFrame,
                Box(
                    {x = 0, y = 0},
                    {width = arrowWidth, height = arrowHeight},
                    "Top box background color",
                    "Top box border color"
                )
            ),
            TextField(
                ">",
                {x = 0, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        table.insert(eventListeners, MouseClickEventListener(ui.controls.matchLeft, decreaseMatchGroupIndex))
        table.insert(eventListeners, MouseClickEventListener(ui.controls.matchRight, increaseMatchGroupIndex))
    end

    local function initKeyboardUI()
        ui.frames.keyboardFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 0,
                    height = 0
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 5, {x = -2, y = 5}),
            ui.frames.searchFrame
        )
        initMatchesUI()
        ui.searchKeyboard =
            SearchKeyboard(
            MiscUtils.getSortedKeysByName(MoveData.MOVES),
            ui.frames.keyboardFrame,
            createLabelsFromMatches,
            clearMatches,
            MoveData.MOVES
        )
        ui.searchKeyboard.setDrawFunction(program.drawCurrentScreens)
    end

    local function initResultsUI()
        ui.frames.mainResultFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.RESULT_FRAME_WIDTH,
                    height = ui.frames.mainFrame.getSize().height - 6
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL),
            ui.frames.mainFrame
        )
        ui.controls.totalFound =
            TextLabel(
            Component(ui.frames.mainResultFrame, Box({x = 0, y = 0}, {width = 0, height = 17})),
            TextField(
                "Total: 18",
                {x = 22, y = 1},
                TextStyle(11, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        ui.frames.resultFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.RESULT_FRAME_WIDTH,
                    height = constants.RESULT_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            nil,
            ui.frames.mainResultFrame
        )
        createResultListUI()
        resultsScroller = ScrollBar(ui.frames.resultFrame, 4, {})
        resultsScroller.setScrollReadingFunction(readResultsIntoScroller)
    end

    local function initSearchOptionsUI()
        ui.frames.searchOptionsFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.SEARCH_FRAME_WIDTH,
                    height = 54
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 5, y = 5}),
            ui.frames.searchFrame
        )
        local optionSets = {
            ["Look for:"] = {constants.LOOK_FOR.POKEMON, constants.LOOK_FOR.TRAINERS},
            ["With:"] = {constants.WITH.MOVE, constants.WITH.ABILITY}
        }
        local order = {"Look for:", "With:"}
        for _, optionType in pairs(order) do
            local optionSet = optionSets[optionType]
            createSearchOptionRow(ui.frames.searchOptionsFrame, optionType, optionSet, optionType)
        end
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
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 3, {x = 3, y = 3}),
            nil
        )
        initResultsUI()
        local mainFrameHeight = ui.frames.mainFrame.getSize().height
        ui.frames.searchFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.SEARCH_FRAME_WIDTH,
                    height = mainFrameHeight - 6
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL),
            ui.frames.mainFrame
        )
        initSearchOptionsUI()
        initKeyboardUI()
    end

    function self.runEventListeners()
        for _, eventListener in pairs(eventListeners) do
            eventListener.listen()
        end
        for _, eventListener in pairs(matchEventListeners) do
            eventListener.listen()
        end
        for _, eventListener in pairs(resultEventListeners) do
            eventListener.listen()
        end
        resultsScroller.update()
        ui.searchKeyboard.runEventListeners()
    end

    function self.show()
        ui.frames.mainFrame.show()
    end

    initUI()
    return self
end

return SearchScreen

local function MainScreen(initialSettings, initialTracker, initialProgram)
    local HoverEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/HoverEventListener.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local JoypadEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/JoypadEventListener.lua")
    local FrameCounter = dofile(Paths.FOLDERS.DATA_FOLDER .. "/FrameCounter.lua")
    local MainScreenUIInitializer = dofile(Paths.FOLDERS.UI_FOLDER .. "/MainScreenUIInitializer.lua")
    local BrowsManager = dofile(Paths.FOLDERS.EXTRAS_FOLDER .. "/BrowsManager.lua")

    local settings = initialSettings
    local tracker = initialTracker
    local program = initialProgram
    local justChangedHiddenPower = false
    local moveEffectivenessEnabled = true
    local currentPokemon = nil
    local opposingPokemon = nil
    local inTrackedView = false
    local inPastRunView = false
    local inLockedView = false
    local randomBallPickerActive = false
    local defeatedLance = false
    local mainScreenUIInitializer
    local browsManager
    local statCycleIndex = -1
    local stats = {"HP", "ATK", "DEF", "SPA", "SPD", "SPE"}
    local eventListeners = {
        abilityHoverListener = nil
    }
    local constants = Graphics.MAIN_SCREEN_CONSTANTS
    local frameCounters = {}
    local hoverListeners = {}
    local moveEventListeners = {}
    local statPredictionEventListeners = {}
    local ui = {}
    local self = {}
    local activeHoverFrame = nil
    local extraThingsToDraw = {
        moveEffectiveness = {},
        nature = {},
        statStages = {},
        status = {}
    }
    local function onHoverInfoEnd()
        activeHoverFrame = nil
        program.drawCurrentScreens()
    end

    local function setStatPredictionToControl(control, newPrediction, newColor)
        if newPrediction == "_" then
            control.setTextOffset({x = 0, y = -5})
        elseif newPrediction == "=" then
            control.setTextOffset({x = 0, y = -2})
        else
            control.setTextOffset({x = 0, y = -1})
        end
        control.setText(newPrediction)
        control.setTextColorKey(newColor)
    end

    local function onStatPredictionClick(params)
        local pokemonID = params.pokemonID
        local stat = params.stat
        if pokemonID ~= nil and pokemonID ~= 0 then
            local pokemonStatPredictions = tracker.getStatPredictions(pokemonID)
            local states = constants.STAT_PREDICTION_STATES
            local currentState = pokemonStatPredictions[stat]
            local nextState = (currentState % 4) + 1
            pokemonStatPredictions[stat] = nextState
            tracker.setStatPredictions(pokemonID, pokemonStatPredictions)
            setStatPredictionToControl(
                ui.controls[stat .. "StatPrediction"],
                states[nextState].text,
                states[nextState].color
            )
            program.drawCurrentScreens()
        end
    end

    local function onSurvivalHealClick(add)
        if add then
            tracker.increasePokecenterCount()
        else
            tracker.decreasePokecenterCount()
        end
        program.drawCurrentScreens()
    end

    local function resetStatPredictionColor()
        if statCycleIndex ~= -1 then
            local oldStat = stats[statCycleIndex]
            ui.controls[oldStat .. "StatPrediction"].setBackgroundColorKey("Top box background color")
            ui.controls[oldStat .. "StatPrediction"].setTextColorKey("Top box text color")
        end
    end

    local function increaseCycleStatIndex()
        if statCycleIndex == -1 then
            statCycleIndex = 1
        else
            resetStatPredictionColor()
            statCycleIndex = (statCycleIndex % 6) + 1
        end
        local newStat = stats[statCycleIndex]
        ui.controls[newStat .. "StatPrediction"].setBackgroundColorKey("Top box border color")
        program.drawCurrentScreens()
    end

    local function increaseStatPrediction()
        if currentPokemon ~= nil and currentPokemon.owner ~= program.SELECTED_PLAYERS.PLAYER then
            if statCycleIndex ~= -1 then
                local stat = stats[statCycleIndex]
                local params = {
                    pokemonID = currentPokemon.pokemonID,
                    ["stat"] = stat
                }
                onStatPredictionClick(params)
            end
        end
    end

    local function readStatPredictions(pokemonID)
        local pokemonStatPredictions = tracker.getStatPredictions(pokemonID)
        local states = constants.STAT_PREDICTION_STATES
        for stat, predictionState in pairs(pokemonStatPredictions) do
            setStatPredictionToControl(
                ui.controls[stat .. "StatPrediction"],
                states[predictionState].text,
                states[predictionState].color
            )
        end
    end

    local function createNote(params)
        local pokemonID = params.pokemon
        local isEnemy = params.isEnemy
        if pokemonID ~= 0 and isEnemy then
            FormsUtils.createMainScreenNote(
                pokemonID,
                tracker.getNote(pokemonID),
                tracker.setNote,
                program.drawCurrentScreens
            )
        end
    end

    local function onPokemonImageHover(params)
        activeHoverFrame = UIUtils.createAndDrawTypeResistancesFrame(params, program.drawCurrentScreens, ui.frames.mainFrame)
    end

    local function onEncounterHoverEnd()
        activeHoverFrame = nil
        eventListeners.encounterFrameClick.setOnClickParams(true)
        program.drawCurrentScreens()
    end

    local function onEncounterFrameClick(useTrackedData)
        if activeHoverFrame ~= nil then
            activeHoverFrame = nil
            useTrackedData = not useTrackedData
            local encounterData = tracker.getEncounterData()
            local vanillaData = program.getGameInfo().LOCATION_DATA.encounters[encounterData.areaName]
            if useTrackedData then
                activeHoverFrame =
                    UIUtils.createAndDrawTrackedEncounterData(
                    vanillaData,
                    encounterData,
                    program.drawCurrentScreens,
                    ui.frames.mainFrame
                )
            else
                activeHoverFrame =
                    UIUtils.createAndDrawVanillaEncounterData(
                    encounterData.areaName,
                    vanillaData,
                    program.drawCurrentScreens,
                    ui.frames.mainFrame
                )
            end
            eventListeners.encounterFrameClick.setOnClickParams(useTrackedData)
        end
    end

    local function onEncounterDataHover()
        local encounterData = tracker.getEncounterData()
        if encounterData == nil then
            return
        end
        local vanillaData = program.getGameInfo().LOCATION_DATA.encounters[encounterData.areaName]
        activeHoverFrame =
            UIUtils.createAndDrawTrackedEncounterData(
            vanillaData,
            tracker.getEncounterData(),
            program.drawCurrentScreens,
            ui.frames.mainFrame
        )
    end

    local function onMoveHeaderHover(params)
        if params.pokemon == nil then
            return
        end
        local movelvls = params.pokemon.movelvls
        local moveHeaderHoverFrame
        if #movelvls == 0 then
            moveHeaderHoverFrame =
                HoverFrameFactory.createHoverTextFrame(
                "Bottom box background color",
                "Bottom box border color",
                "This Pok" .. Chars.accentedE .. "mon does not learn any moves.",
                "Bottom box text color",
                126
            )
            UIUtils.moveHoverFrameToMouse(
                moveHeaderHoverFrame,
                Graphics.HOVER_ALIGNMENT_TYPE.ALIGN_ABOVE,
                ui.frames.mainFrame
            )
        else
            moveHeaderHoverFrame = HoverFrameFactory.createMoveLevelsHoverFrame(params.pokemon, params.mainFrame)
            UIUtils.moveHoverFrameToMouse(
                moveHeaderHoverFrame,
                Graphics.HOVER_ALIGNMENT_TYPE.ALIGN_ABOVE,
                ui.frames.mainFrame
            )
        end
        activeHoverFrame = moveHeaderHoverFrame
        program.drawCurrentScreens()
        activeHoverFrame.show()
    end

    local function onHoverInfo(hoverParams)
        if hoverParams.text ~= "" then
            activeHoverFrame = UIUtils.createAndDrawHoverFrame(hoverParams, program.drawCurrentScreens, ui.frames.mainFrame)
        end
    end

    local function onItemBagInfoHover(params)
        if ui.frames.healFrame.isVisible() then
            local items = params.items
            local itemType = params.itemType
            if items == nil or next(items) == nil then
                local infoHoverParams = {
                    BGColorKey = "Top box background color",
                    BGColorFillKey = "Top box border color",
                    text = "You currently do not have any " .. itemType:lower() .. " items.",
                    textColorKey = "Top box text color",
                    width = 114,
                    alignment = Graphics.HOVER_ALIGNMENT_TYPE.ALIGN_ABOVE
                }
                onHoverInfo(infoHoverParams)
            else
                activeHoverFrame =
                    UIUtils.createAndDrawItemHoverFrame(items, itemType, ui.frames.mainFrame, program.drawCurrentScreens)
            end
        end
    end

    function self.getInnerFramePosition()
        return ui.frames.mainInnerFrame.getPosition()
    end

    local function onHiddenPowerFrameCounter()
        frameCounters["hiddenPowerCounter"] = nil
        justChangedHiddenPower = false
        program.drawCurrentScreens()
    end

    local function onChangeHiddenPower(direction)
        if direction == "forward" then
            tracker.increaseHiddenPowerType()
        else
            tracker.decreaseHiddenPowerType()
        end
        local baseWait = 90
        local clientFrameRate = client.get_approx_framerate()
        if clientFrameRate ~= nil and clientFrameRate > 60 then
            baseWait = math.floor(baseWait * (clientFrameRate / 60))
        end
        frameCounters["hiddenPowerCounter"] = FrameCounter(baseWait, onHiddenPowerFrameCounter)
        justChangedHiddenPower = true
        program.drawCurrentScreens()
    end

    local function initUI()
        ui.controls = {}
        ui.frames = {}
        ui.mainFrame = nil
        mainScreenUIInitializer = MainScreenUIInitializer(ui, program.getGameInfo())
        mainScreenUIInitializer.initUI()
        browsManager = BrowsManager(settings, ui, currentPokemon, frameCounters, program)
        browsManager.initialize()
    end

    local function setUpStatStages(isEnemy)
        local showAccEva = settings.appearance.SHOW_ACCURACY_AND_EVASION and program.isInBattle() and not isEnemy
        extraThingsToDraw.statStages = {}
        if currentPokemon.statStages ~= nil then
            for statName, statStage in pairs(currentPokemon.statStages) do
                local namePosition
                local chevronPosition
                if statName ~= "ACC" and statName ~= "EVA" then
                    namePosition = ui.controls[statName .. "StatName"].getPosition()
                elseif statName == "ACC" and showAccEva then
                    namePosition = ui.controls.accuracyLabel.getPosition()
                    namePosition.x = namePosition.x - 2
                elseif statName == "EVA" and showAccEva then
                    namePosition = ui.controls.evasionLabel.getPosition()
                    namePosition.x = namePosition.x - 2
                end
                if namePosition ~= nil then
                    chevronPosition = {x = namePosition.x + 20, y = namePosition.y + 5}
                    extraThingsToDraw.statStages[statName] = {stage = statStage, position = chevronPosition}
                end
            end
        end
    end

    local function setUpMoveEffectiveness(moveIDs)
        extraThingsToDraw.moveEffectiveness = {}
        if settings.battle.SHOW_MOVE_EFFECTIVENESS and moveEffectivenessEnabled then
            for i, moveID in pairs(moveIDs) do
                local moveFrame = ui.moveInfoFrames[i]
                local PPLabelPosition = moveFrame.PPLabel.getPosition()
                local chevronPosition = {x = PPLabelPosition.x + 14, y = PPLabelPosition.y + 3}
                local moveData = MoveData.MOVES[moveID + 1]
                local moveEffectiveness =
                    MoveUtils.netEffectiveness(
                    moveData,
                    opposingPokemon,
                    opposingPokemon == program.SELECTED_PLAYERS.ENEMY,
                    tracker.getCurrentHiddenPowerType()
                )
                table.insert(
                    extraThingsToDraw.moveEffectiveness,
                    {position = chevronPosition, effectiveness = moveEffectiveness}
                )
            end
        end
    end

    local function getImageForStatus(status)
        local imgName = ""
        if program.getGameInfo().GEN == 4 then
            local statusTable = {
                [0] = "",
                [16] = "BRN",
                [32] = "FRZ",
                [64] = "PAR",
                [128] = "PSN"
            }
            if statusTable[status] then
                imgName = statusTable[status]
            elseif status < 8 then
                imgName = "SLP"
            else
                return ""
            end
        elseif program.getGameInfo().GEN == 5 then
            imgName = MiscData.STATUS_TO_IMG_NAME[status]
            if imgName == nil then
                return ""
            end
        end
        local statusPath = "ironmon_tracker/images/status/" .. imgName .. ".png"
        return statusPath
    end

    local function setUpStatusIcon()
        local imagePath = getImageForStatus(currentPokemon.status)
        local iconPosition = ui.controls.pokemonImageLabel.getPosition()
        extraThingsToDraw.status = {
            position = {x = iconPosition.x + 15, y = iconPosition.y + 1},
            statusImagePath = imagePath
        }
    end

    local function checkForVariableMoves(isEnemy, moveIDs, movePPs)
        if not settings.battle.CALCULATE_VARIABLE_DAMAGE then
            return
        end
        for index, moveID in pairs(moveIDs) do
            local name = MoveData.MOVES[moveID + 1].name
            local moveFrame = ui.moveInfoFrames[index]
            local damage =
                MoveUtils.calculateVariableDamage(
                name,
                movePPs,
                index,
                currentPokemon,
                opposingPokemon,
                isEnemy,
                program.isInBattle()
            )
            if damage ~= nil then
                moveFrame.powLabel.setText(damage)
            end
        end
    end

    local function readMovesIntoUI(moveIDs, movePPs, isEnemy)
        for i, moveID in pairs(moveIDs) do
            local moveData = MoveData.MOVES[moveID + 1]
            local moveFrame = ui.moveInfoFrames[i]
            local movePP = movePPs[i]

            moveFrame.categoryIcon.setIconName(moveData.category)
            if settings.colorSettings["Color move names by type"] and moveID ~= 0 then
                moveFrame.moveNameLabel.setTextColorKey(moveData.type)
                if moveData.name == "Hidden Power" and not isEnemy and not currentPokemon.fromTeamInfoView then
                    moveFrame.moveNameLabel.setTextColorKey(tracker.getCurrentHiddenPowerType())
                end
            else
                moveFrame.moveNameLabel.setTextColorKey("Bottom box text color")
            end

            local moveType = moveData.type
            if moveData.name == "Hidden Power" and not isEnemy then
                moveType = tracker.getCurrentHiddenPowerType()
            end

            moveFrame.moveTypeIcon.setIconName(moveType)
            moveFrame.moveTypeIcon.setVisibility(settings.colorSettings["Draw move type icons"])

            moveFrame.categoryIcon.setVisibility(settings.colorSettings["Show phys/spec move icons"])
            local moveNameText = moveData.name

            if justChangedHiddenPower and moveData.name == "Hidden Power" and not isEnemy then
                local hiddenPowerType = tracker:getCurrentHiddenPowerType()
                moveNameText = hiddenPowerType:sub(1, 1) .. hiddenPowerType:sub(2):lower()
            end

            if isEnemy then
                local stars = MoveUtils.getStars(currentPokemon)
                moveNameText = moveNameText .. stars[i]
            end

            moveFrame.moveNameLabel.setText(moveNameText)
            moveFrame.moveNameLabel.resize({width = 70, height = 8})

            if moveData.name == "Hidden Power" and not isEnemy then
                moveFrame.moveNameLabel.resize({width = 53, height = 8})
                local frame = ui.frames["move" .. i .. "NameIconFrame"]
                ui.frames.hiddenPowerArrowsFrame.changeParentFrame(frame, 4)
                ui.frames.hiddenPowerArrowsFrame.setVisibility(true)
            end

            moveFrame.PPLabel.setText(movePP)
            moveFrame.powLabel.setTextColorKey("Bottom box text color")
            if MoveUtils.isSTAB(moveData, currentPokemon) and program.isInBattle() then
                moveFrame.powLabel.setTextColorKey("Positive text color")
            end
            moveFrame.powLabel.setText(moveData.power)
            moveFrame.accLabel.setText(moveData.accuracy)

            if moveData.name == "Return" and not isEnemy then
                local basePower = math.max(currentPokemon.friendship / 2.5, 1)
                basePower = math.floor(basePower)
                if basePower >= 100 then
                    moveFrame.powLabel.setText(tostring(basePower))
                end
            end

            local listener = moveEventListeners[i]
            local params = listener.getOnHoverParams()
            params.text = moveData.description
        end
    end

    local function setUpMoves(isEnemy)
        local movesHeader = MoveUtils.getMoveHeader(currentPokemon)
        ui.controls.moveHeaderLearnedText.setText(movesHeader)
        ui.frames.hiddenPowerArrowsFrame.setVisibility(false)
        local moveIDs = currentPokemon.moveIDs
        local movePPs = {}
        if isEnemy then
            local info =
                MoveUtils.calculateEnemyPPs(
                currentPokemon,
                tracker.getMoves(currentPokemon.pokemonID),
                settings.battle.SHOW_ACTUAL_ENEMY_PP
            )
            moveIDs, movePPs = info.moveIDs, info.movePPs
        else
            for i, moveID in pairs(moveIDs) do
                if moveID == 0 then
                    movePPs[i] = Graphics.TEXT.NO_PP
                else
                    movePPs[i] = currentPokemon.movePPs[i]
                end
            end
        end
        if opposingPokemon ~= nil then
            setUpMoveEffectiveness(moveIDs)
        end
        readMovesIntoUI(moveIDs, movePPs, isEnemy)
        checkForVariableMoves(isEnemy, moveIDs, movePPs)
    end

    local function readTrackedEncountersIntoLabel()
        if inTrackedView or not program.isWildBattle() or inPastRunView then
            ui.frames.encounterDataFrame.setVisibility(false)
            return
        end
        local encounterData = tracker.getEncounterData()
        if encounterData ~= nil then
            local vanillaData = program.getGameInfo().LOCATION_DATA.encounters[encounterData.areaName]
            ui.frames.encounterDataFrame.setVisibility(vanillaData ~= nil)
            if vanillaData ~= nil then
                ui.controls.encountersSeen.setText(encounterData.uniqueSeen .. "/" .. vanillaData.totalPokemon)
            end
        end
    end

    local function setEnemySpecificControls()
        ui.controls.lockIcon.setVisibility(
            not (inTrackedView or inLockedView or inPastRunView) and settings.battle.ENABLE_ENEMY_LOCKING
        )
        local lockIcon = "LOCKED"
        if not program.isLocked() then
            lockIcon = "UNLOCKED"
        end
        ui.controls.lockIcon.setIconName(lockIcon)
        local abilityHoverParams = hoverListeners.abilityHoverListener.getOnHoverParams()
        local itemHoverParams = hoverListeners.heldItemHoverListener.getOnHoverParams()
        readStatPredictions(currentPokemon.pokemonID)
        ui.controls.pokemonHP.setText("HP: ?/?")
        abilityHoverParams.text = ""
        itemHoverParams.text = ""
        local note = tracker.getNote(currentPokemon.pokemonID)
        local lines = DrawingUtils.textToWrappedArray(note, 80)
        ui.controls.mainNoteLabel.setText(lines[1])
        ui.controls.mainNoteLabel.setVisibility(#lines == 1)
        hoverListeners.enemyNoteHoverListener.getOnHoverParams().text = ""
        for i = 1, 2, 1 do
            ui.controls.noteLabels[i].setVisibility(#lines > 1)
            if #lines > 1 and DrawingUtils.calculateWordPixelLength(lines[i]) <= 80 then
                ui.controls.noteLabels[i].setText(lines[i])
            end
        end
        if #lines > 2 then
            local text = ui.controls.noteLabels[2].getText()
            ui.controls.noteLabels[2].setText(MiscUtils.trimWhitespace(text).."...")
            hoverListeners.enemyNoteHoverListener.getOnHoverParams().text = note
        end
        ui.controls.heldItem.setText("Total seen: " .. tracker.getAmountSeen(currentPokemon.pokemonID))
        ui.controls.abilityDetails.setText("Last level: " .. tracker.getLastLevelSeen(currentPokemon.pokemonID))
        ui.controls.healsLabel.setText("")
        ui.controls.statusItemsLabel.setText("")
        local bookmarked = tracker.isMarked(currentPokemon.pokemonID)
        local iconName = "BOOKMARK_FILLED"
        if not bookmarked then
            iconName = "BOOKMARK_EMPTY"
        end
        ui.controls.bookmarkIcon.setIconName(iconName)
        readTrackedEncountersIntoLabel()
    end

    local function setUpStats(isEnemy)
        ui.controls.BSTNumber.setText(currentPokemon.bst)
        extraThingsToDraw.nature = {}
        for statName, stat in pairs(currentPokemon.stats) do
            ui.controls[statName .. "StatName"].setTextColorKey("Top box text color")
            ui.controls[statName .. "StatNumber"].setVisibility(not isEnemy)
            ui.controls[statName .. "StatPrediction"].setVisibility(isEnemy)
            if isEnemy then
                ui.controls[statName .. "StatName"].resize({width = 30, height = 10})
                statPredictionEventListeners[statName].setOnClickParams(
                    {["stat"] = statName, pokemonID = currentPokemon.pokemonID}
                )
            else
                ui.controls[statName .. "StatName"].resize({width = 25, height = 10})
                ui.controls[statName .. "StatNumber"].setText(stat)
                if statName ~= "HP" and settings.appearance.BLIND_MODE then
                    ui.controls[statName .. "StatNumber"].setText("?")
                end
                local color = DrawingUtils.getNatureColor(statName, currentPokemon.nature)
                local namePosition = ui.controls[statName .. "StatName"].getPosition()
                local naturePosition = {
                    x = namePosition.x + 16,
                    y = namePosition.y - 4
                }
                local colorMapping = {
                    ["Positive text color"] = "plus",
                    ["Negative text color"] = "minus"
                }
                if colorMapping[color] then
                    table.insert(
                        extraThingsToDraw.nature,
                        {
                            position = naturePosition,
                            effect = colorMapping[color]
                        }
                    )
                end
                ui.controls[statName .. "StatName"].setTextColorKey(
                    DrawingUtils.getNatureColor(statName, currentPokemon.nature)
                )
            end
        end
    end

    local function readTeamInfoPokemonIntoUI()
        ui.controls.gearIcon.setVisibility(false)
        ui.frames.healFrame.setVisibility(false)
        ui.frames.enemyNoteFrame.setVisibility(true)
        ui.controls.noteIcon.setVisibility(false)
        ui.controls.mainNoteLabel.setVisibility(true)
        ui.frames.survivalHealFrame.setVisibility(false)
        ui.frames.accEvaFrame.setVisibility(false)
        ui.frames.hiddenPowerArrowsFrame.setVisibility(false)
        ui.controls.noteLabels[1].setVisibility(false)
        ui.controls.noteLabels[2].setVisibility(false)

        eventListeners.loadStatOverview.setOnClickParams(currentPokemon.pokemonID)

        --Repurpose notes into held item viewing.
        local itemDescription = ""
        if currentPokemon.heldItem ~= nil then
            local heldItem = ItemData.ITEMS[currentPokemon.heldItem]
            itemDescription = heldItem.description
            ui.controls.mainNoteLabel.setText("Item: " .. heldItem.name)
        else
            ui.controls.mainNoteLabel.setText("Item: None")
        end
        hoverListeners.heldItemTeamInfo.getOnHoverParams().text = itemDescription
        hoverListeners.abilityHoverListener.getOnHoverParams().text = ""
        hoverListeners.heldItemHoverListener.getOnHoverParams().text = ""

        --pokemon from a log trainer team have a list of abilities, show all 3
        local newAbilityLabels = {ui.controls.pokemonHP, ui.controls.heldItem, ui.controls.abilityDetails}
        local abilities = currentPokemon.abilities
        for index = 1, 3, 1 do
            local ability = abilities[index]
            local hoverListener = hoverListeners["abilityHoverListener" .. index]
            local abilityName = ""
            local abilityDescription = ""
            if ability ~= nil then
                local abilityData = AbilityData.ABILITIES[abilities[index] + 1]
                abilityName = abilityData.name
                abilityDescription = abilityData.description
            end
            newAbilityLabels[index].setText(abilityName)
            hoverListener.getOnHoverParams().text = abilityDescription
        end
    end

    function self.formatForTeamInfoView(pokemonLoadingFunction)
        ui.frames.mainFrame.setBackgroundColorKey("")
        inLockedView = true
        eventListeners.loadStatOverview =
            MouseClickEventListener(ui.controls.pokemonImageLabel, pokemonLoadingFunction, currentPokemon.pokemonID)
        local newAbilityLabels = {ui.controls.pokemonHP, ui.controls.heldItem, ui.controls.abilityDetails}
        for index, newAbilityLabel in pairs(newAbilityLabels) do
            hoverListeners["abilityHoverListener" .. index] =
                HoverEventListener(
                newAbilityLabel,
                onHoverInfo,
                {
                    BGColorKey = "Top box background color",
                    BGColorFillKey = "Top box border color",
                    text = "",
                    textColorKey = "Top box text color",
                    width = 120,
                    alignment = Graphics.HOVER_ALIGNMENT_TYPE.ALIGN_ABOVE
                },
                onHoverInfoEnd
            )
            newAbilityLabel.setTextColorKey("Intermediate text color")
        end
        hoverListeners.heldItemTeamInfo =
            HoverEventListener(
            ui.controls.mainNoteLabel,
            onHoverInfo,
            {
                BGColorKey = "Top box background color",
                BGColorFillKey = "Top box border color",
                text = "",
                textColorKey = "Top box text color",
                width = 120,
                alignment = Graphics.HOVER_ALIGNMENT_TYPE.ALIGN_ABOVE
            },
            onHoverInfoEnd
        )
        local moveHeaderLabels = {"moveHeaderLearnedText", "moveHeaderAcc", "moveHeaderPP", "moveHeaderPow"}
        for _, labelName in pairs(moveHeaderLabels) do
            ui.controls[labelName].setTextColorKey("Top box text color")
            ui.controls[labelName].setShadowColorKey("Top box background color")
        end
    end

    function self.undoTeamInfoView()
        ui.controls.pokemonHP.setTextColorKey("Top box text color")
        ui.frames.mainFrame.setBackgroundColorKey("Main background color")
        inLockedView = false
        eventListeners.loadStatOverview = nil
        for i = 1, 3, 1 do
            hoverListeners["abilityHoverListener" .. i] = nil
        end
        hoverListeners.heldItemTeamInfo = nil
        ui.controls.gearIcon.setVisibility(true)
        local moveHeaderLabels = {"moveHeaderLearnedText", "moveHeaderAcc", "moveHeaderPP", "moveHeaderPow"}
        for _, labelName in pairs(moveHeaderLabels) do
            ui.controls[labelName].setTextColorKey("Move header text color")
            ui.controls[labelName].setShadowColorKey("Main background color")
        end
    end

    function self.undoPastRunView()
        inPastRunView = false
        ui.controls.noteLabels[1].setVisibility(false)
        ui.controls.noteLabels[2].setVisibility(false)
        ui.controls.pastRunLocationIcon.setVisibility(false)
    end

    local function setUpMiscInfo(isEnemy)
        local pokecenters = tracker.getPokecenterCount()
        if pokecenters < 10 then
            pokecenters = " " .. pokecenters
        end
        ui.controls.survivalHealAmountLabel.setText(pokecenters)
       local survivalLabelOffset = {x=-2,y=-3}
       if tonumber(pokecenters) > 9 then
        survivalLabelOffset.x = -3
       end
       ui.controls.survivalHealAmountLabel.setTextOffset(survivalLabelOffset)
        local showAccEva =
            settings.appearance.SHOW_ACCURACY_AND_EVASION and program.isInBattle() and not isEnemy and not inLockedView and
            not inPastRunView
        local showPokecenterHeals =
            not isEnemy and settings.appearance.SHOW_POKECENTER_HEALS and not showAccEva and not inPastRunView
        ui.frames.accEvaFrame.setVisibility(showAccEva)
        ui.frames.survivalHealFrame.setVisibility(showPokecenterHeals)
        local healingTotals = program.getHealingTotals()
        local statusTotals = program.getStatusTotals()
        if healingTotals == nil then
            healingTotals = {healing = 0, numHeals = 0}
        end
        hoverListeners.statusItemsHoverListener.setOnHoverParams({items = program.getStatusItems(), itemType = "Status"})
        hoverListeners.healingItemsHoverListener.setOnHoverParams({items = program.getHealingItems(), itemType = "Healing"})
        ui.controls.healsLabel.setText("Heals: " .. healingTotals.healing .. "% (" .. healingTotals.numHeals .. ")")
        ui.controls.statusItemsLabel.setText("Status items: " .. statusTotals)
        ui.frames.enemyNoteFrame.setVisibility(isEnemy or inPastRunView)
        ui.controls.noteIcon.setVisibility(not inPastRunView)
        ui.frames.healFrame.setVisibility(not isEnemy and not inPastRunView)
        ui.frames.infoBottomFrame.setVisibility(isEnemy)
        ui.frames.encounterDataFrame.setVisibility(false)
        ui.controls.gearIcon.setVisibility(not inTrackedView and not inPastRunView)
    end

    local function readNatureSpecificBerry(heldItemName, heldItemDescription)
        local badNatures = ItemData.NATURE_SPECIFIC_BERRIES[heldItemName]
        local natureName = MiscData.NATURES[currentPokemon.nature + 1]
        if badNatures[natureName] then
            heldItemDescription = heldItemDescription .. " Your Pok" .. Chars.accentedE .. "mon will dislike this."
        else
            heldItemDescription = heldItemDescription .. " Yum!"
        end
        return heldItemDescription
    end

    local function setUpEvo(isEnemy)
        extraThingsToDraw.friendshipBar = nil
        local evo = currentPokemon.evolution
        --male/female difference evos
        if type(evo) == "table" then
            if not currentPokemon.isFemale then
                currentPokemon.isFemale = 0
            end
            evo = evo[currentPokemon.isFemale + 1]
        end
        if evo == PokemonData.EVOLUTION_TYPES.FRIEND and not isEnemy and not inPastRunView then
            local position = ui.controls.pokemonLevelAndEvo.getPosition()
            local base = currentPokemon.baseFriendship or 0
            local progress = (currentPokemon.friendship - base) / (220 - base)

            extraThingsToDraw.friendshipBar = {
                ["progress"] = progress,
                x = position.x + 19 + (5 * #(tostring(currentPokemon.level))),
                y = position.y + 3
            }
            if progress >= 1 then
                evo = "READY"
            end
        end
        ui.controls.pokemonLevelAndEvo.setText("Lv. " .. currentPokemon.level .. " (" .. evo .. ")")
    end

    local function setUpMainPokemonInfo(isEnemy)
        local heldItemInfo = ItemData.GEN_5_ITEMS[currentPokemon.heldItem]
        if heldItemInfo == nil then
            heldItemInfo = {
                name = "",
                description = ""
            }
        end
        local name = currentPokemon.name
        ui.controls.pokemonNameLabel.setText(name)
        ui.controls.pokemonHP.setVisibility(not isEnemy)
        local currentIconSet = IconSets.SETS[settings.appearance.ICON_SET_INDEX]
        local imageID = currentPokemon.pokemonID
        if currentPokemon.alternateFormID ~= nil then
            imageID = currentPokemon.alternateFormID
        end
        eventListeners.noteIconListener.setOnClickParams({pokemon = currentPokemon.pokemonID, ["isEnemy"] = isEnemy})
        DrawingUtils.readPokemonIDIntoImageLabel(
            currentIconSet,
            imageID,
            ui.controls.pokemonImageLabel,
            currentIconSet.IMAGE_OFFSET
        )
        setUpEvo(isEnemy)
        local pokemonHoverParams = hoverListeners.pokemonHoverListener.getOnHoverParams()
        pokemonHoverParams.pokemon = currentPokemon
        ui.controls.pokemonHP.setText("HP: " .. currentPokemon.curHP .. "/" .. currentPokemon.stats.HP)
        local abilityName = AbilityData.ABILITIES[currentPokemon.ability + 1].name
        if settings.appearance.BLIND_MODE then
            abilityName = "?"
        end
        ui.controls.abilityDetails.setText(abilityName)
        ui.controls.heldItem.setText(heldItemInfo.name)
        for i, type in pairs(currentPokemon.type) do
            ui.controls["pokemonType" .. i].setPath(Paths.FOLDERS.TYPE_IMAGES_FOLDER .. "/" .. type .. ".png")
        end
        local abilityHoverParams = hoverListeners.abilityHoverListener.getOnHoverParams()
        local description = AbilityData.ABILITIES[currentPokemon.ability + 1].description
        if settings.appearance.BLIND_MODE then
            description = ""
        end
        if type(description) == "table" then
            description = description[program.getGameInfo().GEN - 3]
        end
        abilityHoverParams.text = description
        local itemHoverParams = hoverListeners.heldItemHoverListener.getOnHoverParams()
        local heldItemDescription = heldItemInfo.description
        if ItemData.NATURE_SPECIFIC_BERRIES[heldItemInfo.name] ~= nil then
            heldItemDescription = readNatureSpecificBerry(heldItemInfo.name, heldItemDescription)
        end
        itemHoverParams.text = heldItemDescription
    end

    local function readPokemonIntoUI()
        ui.controls.lockIcon.setVisibility(false)
        if not program.isInBattle() and not program.isLocked() then
            resetStatPredictionColor()
            statCycleIndex = -1
        end
        ui.frames.mainFrame.recalculateChildPositions()
        local pokemon = currentPokemon
        local isEnemy = pokemon.owner == program.SELECTED_PLAYERS.ENEMY

        setUpMainPokemonInfo(isEnemy)
        setUpMiscInfo(isEnemy)

        hoverListeners.moveHeaderHoverListener.setOnHoverParams({["pokemon"] = pokemon, mainFrame = ui.frames.mainFrame})

        setUpStats(isEnemy)
        if isEnemy then
            setEnemySpecificControls()
        end
        setUpMoves(isEnemy)
        setUpStatStages(isEnemy)
        setUpStatusIcon()
        if pokemon.fromTeamInfoView then
            readTeamInfoPokemonIntoUI()
        end
    end

    local function openOptionsScreen()
        ui.frames.mainFrame.setVisibility(false)
        client.SetGameExtraPadding(0, 0, Graphics.SIZES.MAIN_SCREEN_PADDING, 0)
        program.setCurrentScreens({program.UI_SCREENS.MAIN_OPTIONS_SCREEN})
        program.drawCurrentScreens()
        ui.frames.mainFrame.setVisibility(true)
    end

    function self.setPokemonToDraw(pokemon, otherPokemon)
        currentPokemon = pokemon
        browsManager.setCurrentPokemon(pokemon)
        opposingPokemon = otherPokemon
    end

    function self.addEventListener(eventListener)
        table.insert(eventListeners, eventListener)
    end

    function self.runEventListeners()
        local listenerGroups = {eventListeners, hoverListeners, statPredictionEventListeners, moveEventListeners}
        for _, listenerGroup in pairs(listenerGroups) do
            for _, eventListener in pairs(listenerGroup) do
                eventListener.listen()
            end
        end
        self.runFrameCounters()
    end

    function self.runFrameCounters()
        for _, counter in pairs(frameCounters) do
            counter.decrement()
        end
    end

    function self.resetEventListeners()
        local listenerGroups = {eventListeners, moveEventListeners, statPredictionEventListeners}
        for _, listenerGroup in pairs(listenerGroups) do
            for _, eventListener in pairs(listenerGroup) do
                if eventListener.reset then
                    eventListener.reset()
                end
            end
        end
    end

    function self.resetHoverFrame()
        activeHoverFrame = nil
        self.resetEventListeners()
    end

    function self.setRandomBallPickerActive(newValue)
        randomBallPickerActive = newValue
    end

    local function setUpBasedOnRandomBallPicker()
        if randomBallPickerActive then
            ui.controls.pokemonNameLabel.setText("")
            ui.controls.pokemonLevelAndEvo.setText("")
            ui.controls.pokemonHP.setText("")
            ui.controls.heldItem.setText("")
            ui.controls.abilityDetails.setText("")
        end
        ui.controls.pokemonImageLabel.setVisibility(not randomBallPickerActive)
        ui.controls.pokemonType1.setVisibility(not randomBallPickerActive)
        ui.controls.pokemonType2.setVisibility(not randomBallPickerActive)
    end

    function self.show()
        self.updateBadgeLayout()
        readPokemonIntoUI()
        setUpBasedOnRandomBallPicker()
        browsManager.show()
        ui.frames.mainFrame.show()
        if not program.isInBattle() or inPastRunView or inTrackedView then
            extraThingsToDraw.moveEffectiveness = {}
            extraThingsToDraw.statStages = {}
        end
        if not currentPokemon.fromTeamInfoView then
            DrawingUtils.drawExtraMainScreenStuff(extraThingsToDraw)
        end
        if activeHoverFrame ~= nil then
            activeHoverFrame.show()
        end
    end

    local function initMoveListeners()
        for i = 1, 4, 1 do
            local moveFrame = ui.moveInfoFrames[i]
            moveEventListeners[i] =
                HoverEventListener(
                moveFrame.moveNameLabel,
                onHoverInfo,
                {
                    BGColorKey = "Bottom box background color",
                    BGColorFillKey = "Bottom box border color",
                    text = "",
                    textColorKey = "Bottom box text color",
                    width = 120,
                    alignment = Graphics.HOVER_ALIGNMENT_TYPE.ALIGN_ABOVE
                },
                onHoverInfoEnd
            )
        end
    end

    function self.setNotesAsPastRun(pastRun)
        local location = pastRun.getLocation()
        ui.controls.pastRunLocationIcon.setVisibility(true)
        local validRun = (location ~= "")
        ui.controls.noteLabels[1].setVisibility(validRun)
        ui.controls.noteLabels[2].setVisibility(validRun)
        ui.controls.mainNoteLabel.setVisibility(not validRun)
        if validRun then
            ui.controls.noteLabels[1].setText(pastRun.getDate())
            ui.controls.noteLabels[2].setText(pastRun.getLocation())
        else
            ui.controls.mainNoteLabel.setText("No data was found.")
        end
        if pastRun.getProgress() == PlaythroughConstants.PROGRESS.WON then
            ui.controls.pastRunLocationIcon.setVisibility(false)
            ui.controls.noteLabels[2].setText("You won!")
        end
    end

    local function onBookmarkClick()
        local filled = string.match(ui.controls.bookmarkIcon.getIconName(), "FILLED")
        local newIconName = "BOOKMARK_FILLED"
        if filled then
            newIconName = "BOOKMARK_EMPTY"
        end
        ui.controls.bookmarkIcon.setIconName(newIconName)
        filled = not filled
        if filled then
            tracker.markID(currentPokemon.pokemonID)
        else
            tracker.unmarkID(currentPokemon.pokemonID)
        end
        program.drawCurrentScreens()
    end

    local function initStatListeners()
        for _, stat in pairs(stats) do
            local predictionLabel = stat .. "StatPrediction"
            statPredictionEventListeners[stat] =
                MouseClickEventListener(ui.controls[predictionLabel], onStatPredictionClick, {stat = stat, pokemonID = nil})
        end
    end

    local function initEventListeners()
        initMoveListeners()
        hoverListeners.abilityHoverListener =
            HoverEventListener(
            ui.controls.abilityDetails,
            onHoverInfo,
            {
                BGColorKey = "Top box background color",
                BGColorFillKey = "Top box border color",
                text = "",
                textColorKey = "Top box text color",
                width = 120,
                alignment = Graphics.HOVER_ALIGNMENT_TYPE.ALIGN_BELOW
            },
            onHoverInfoEnd
        )
        hoverListeners.heldItemHoverListener =
            HoverEventListener(
            ui.controls.heldItem,
            onHoverInfo,
            {
                BGColorKey = "Top box background color",
                BGColorFillKey = "Top box border color",
                text = "",
                textColorKey = "Top box text color",
                width = 120,
                alignment = Graphics.HOVER_ALIGNMENT_TYPE.ALIGN_BELOW
            },
            onHoverInfoEnd
        )
        hoverListeners.pokemonHoverListener =
            HoverEventListener(
            ui.controls.pokemonImageLabel,
            onPokemonImageHover,
            {pokemon = nil, mainFrame = ui.frames.mainFrame},
            onHoverInfoEnd
        )
        hoverListeners.enemyNoteHoverListener =
            HoverEventListener(
            ui.frames.enemyNoteFrame,
            onHoverInfo,
            {
                BGColorKey = "Top box background color",
                BGColorFillKey = "Top box border color",
                text = "",
                textColorKey = "Top box text color",
                width = 120,
                alignment = Graphics.HOVER_ALIGNMENT_TYPE.ALIGN_ABOVE
            },
            onHoverInfoEnd
        )
        hoverListeners.moveHeaderHoverListener =
            HoverEventListener(ui.controls.moveHeaderLearnedText, onMoveHeaderHover, {pokemon = nil}, onHoverInfoEnd)
        eventListeners.optionsIconListener = MouseClickEventListener(ui.controls.gearIcon, openOptionsScreen, nil)
        eventListeners.noteIconListener = MouseClickEventListener(ui.controls.noteIcon, createNote, nil)
        hoverListeners.healingItemsHoverListener =
            HoverEventListener(ui.controls.healsLabel, onItemBagInfoHover, nil, onHoverInfoEnd)
        hoverListeners.statusItemsHoverListener =
            HoverEventListener(ui.controls.statusItemsLabel, onItemBagInfoHover, nil, onHoverInfoEnd)
        eventListeners.cycleStatListener = JoypadEventListener(settings.controls, "CYCLE_STAT", increaseCycleStatIndex)
        eventListeners.cyclePredictionListener =
            JoypadEventListener(settings.controls, "CYCLE_PREDICTION", increaseStatPrediction)
        eventListeners.increaseSurvivalHealsListener =
            MouseClickEventListener(ui.controls.increaseHealsIcon, onSurvivalHealClick, true)
        eventListeners.decreaseSurvivalHealsListener =
            MouseClickEventListener(ui.controls.decreaseHealsIcon, onSurvivalHealClick, false)
        table.insert(
            eventListeners,
            HoverEventListener(ui.frames.encounterDataFrame, onEncounterDataHover, nil, onEncounterHoverEnd)
        )
        eventListeners.encounterFrameClick =
            MouseClickEventListener(ui.frames.encounterDataFrame, onEncounterFrameClick, true)
        initStatListeners()
        table.insert(
            eventListeners,
            MouseClickEventListener(ui.controls.leftHiddenPowerLabel, onChangeHiddenPower, "backward")
        )
        table.insert(
            eventListeners,
            MouseClickEventListener(ui.controls.rightHiddenPowerLabel, onChangeHiddenPower, "forward")
        )
        table.insert(eventListeners, MouseClickEventListener(ui.controls.bookmarkIcon, onBookmarkClick))
    end

    function self.getMainFrameSize()
        return ui.frames.mainFrame.getSize()
    end

    local function recalculateMainFrameSize(orientation)
        local baseSize = {
            width = Graphics.SIZES.MAIN_SCREEN_WIDTH,
            height = Graphics.SIZES.MAIN_SCREEN_HEIGHT
        }
        local spacing = 0
        if settings.badgesAppearance.SPACER then
            spacing = 5
        end
        ui.frames.mainFrame.setLayoutSpacing(spacing)
        local add = {width = 0, height = 0}
        local gameInfo = program.getGameInfo()
        local numBadges = 0
        if ui.frames.badgeFrame1.isVisible() then
            numBadges = numBadges + 1
        end
        if ui.frames.badgeFrame2.isVisible() then
            numBadges = numBadges + 1
        end
        if orientation == "VERTICAL" then
            add.width = numBadges * constants.BADGE_VERTICAL_WIDTH + spacing * numBadges
        else
            add.height = numBadges * constants.BOTTOM_BOX_HEIGHT + spacing * numBadges
        end
        ui.frames.mainFrame.resize({width = baseSize.width + add.width, height = baseSize.height + add.height})
    end

    function self.HGSS_setBadgesToKanto()
        local badgeControls = ui.badgeControlsSet1
        for _, control in pairs(badgeControls) do
            control.setPath(control.getPath():gsub("HGSS", "HGSS_K"))
        end
    end

    function self.updateBadges(newBadges)
        local badgeSets = {
            {badges = newBadges.firstSet, controls = ui.badgeControlsSet1},
            {badges = newBadges.secondSet, controls = ui.badgeControlsSet2}
        }
        for i, badgeSet in pairs(badgeSets) do
            for badgeIndex, control in pairs(badgeSet.controls) do
                local prefix = program.getGameInfo().BADGE_PREFIX
                local badgeValue = badgeSet.badges[badgeIndex]
                local off = ""
                if badgeValue == 0 then
                    off = "_OFF"
                end
                if badgeSet.badges == newBadges.secondSet then
                    prefix = prefix .. "_K"
                end
                control.setPath("ironmon_tracker/images/icons/" .. prefix .. "_badge" .. badgeIndex .. off .. ".png")
            end
        end
    end

    function self.setLanceDefeated(newValue)
        defeatedLance = newValue
    end

    function self.setUpForTrackedPokemonView()
        inTrackedView = true
    end

    function self.setUpForPastRunView()
        inPastRunView = true
    end

    function self.resetToDefault()
        ui.frames.mainFrame.move({x = Graphics.SIZES.SCREEN_WIDTH, y = 0})
        inTrackedView = false
        inLockedView = false
    end

    function self.moveMainScreen(newPosition)
        ui.frames.mainFrame.move(newPosition)
    end

    local function setUpPrimarySecondaryBadgeFrames(primaryBadgeFrame, secondaryBadgeFrame, showBoth)
        if showBoth then
            if settings.badgesAppearance.PRIMARY_BADGE_SET == "KANTO" then
                local temp = primaryBadgeFrame
                primaryBadgeFrame = secondaryBadgeFrame
                secondaryBadgeFrame = temp
            end
        elseif defeatedLance then
            local temp = primaryBadgeFrame
            primaryBadgeFrame = secondaryBadgeFrame
            secondaryBadgeFrame = temp
        end
        primaryBadgeFrame.setVisibility(true)
        return {
            primary = primaryBadgeFrame,
            secondary = secondaryBadgeFrame
        }
    end

    local function setBadgeAlignmentAndSize(badgeFrame, newOrientation, showBoth)
        local newSize = {width = 0, height = 0}
        if showBoth then
            badgeFrame.setVisibility(true)
        end
        if newOrientation == "VERTICAL" then
            badgeFrame.setLayoutAlignment(Graphics.ALIGNMENT_TYPE.VERTICAL)
            badgeFrame.setLayoutSpacing(0)
            newSize.width = constants.BADGE_VERTICAL_WIDTH
            newSize.height = constants.BADGE_VERTICAL_HEIGHT
        else
            badgeFrame.setLayoutAlignment(Graphics.ALIGNMENT_TYPE.HORIZONTAL)
            badgeFrame.setLayoutSpacing(1)
            newSize.width = constants.BADGE_HORIZONTAL_WIDTH
            newSize.height = constants.BOTTOM_BOX_HEIGHT
        end
        badgeFrame.resize(newSize)
    end

    local function setUpBadgeParentFrames(primaryBadgeFrame, secondaryBadgeFrame, alignment, showBoth)
        local MAIN_FRAME_INDICES = Graphics.MAIN_FRAME_BADGE_INDICES
        if showBoth then
            local indices = MAIN_FRAME_INDICES[alignment]
            primaryBadgeFrame.changeParentFrame(ui.frames.mainFrame, indices[1])
            secondaryBadgeFrame.changeParentFrame(ui.frames.mainFrame, indices[2])
        else
            secondaryBadgeFrame.setVisibility(false)
            local index = MAIN_FRAME_INDICES[alignment]
            primaryBadgeFrame.changeParentFrame(ui.frames.mainFrame, index)
        end
    end

    function self.updateBadgeLayout()
        if inTrackedView or inLockedView then
            ui.frames.badgeFrame1.setVisibility(false)
            ui.frames.badgeFrame2.setVisibility(false)
            recalculateMainFrameSize("VERTICAL")
            return
        end
        local gameInfo = program.getGameInfo()
        local showBoth =
            settings.badgesAppearance.SHOW_BOTH_BADGES and
            (gameInfo.NAME == "Pokemon HeartGold" or gameInfo.NAME == "Pokemon SoulSilver")

        local primaryBadgeFrame = ui.frames.badgeFrame1
        local secondaryBadgeFrame = ui.frames.badgeFrame2

        local primarySecondary = setUpPrimarySecondaryBadgeFrames(primaryBadgeFrame, secondaryBadgeFrame, showBoth)
        primaryBadgeFrame, secondaryBadgeFrame = primarySecondary.primary, primarySecondary.secondary

        local alignment = Graphics.BADGE_ALIGNMENT_TYPE[settings.badgesAppearance.SINGLE_BADGE_ALIGNMENT]
        if showBoth then
            alignment = Graphics.BADGE_ALIGNMENT_TYPE[settings.badgesAppearance.DOUBLE_BADGE_ALIGNMENT]
        end

        local newOrientation = Graphics.BADGE_ORIENTATION[alignment]

        local badgeFrames = {primaryBadgeFrame, secondaryBadgeFrame}

        ui.frames.mainFrame.setLayoutAlignment(Graphics.ALIGNMENT_TYPE.VERTICAL)
        if newOrientation == "VERTICAL" then
            ui.frames.mainFrame.setLayoutAlignment(Graphics.ALIGNMENT_TYPE.HORIZONTAL)
        end

        for _, badgeFrame in pairs(badgeFrames) do
            setBadgeAlignmentAndSize(badgeFrame, newOrientation, showBoth)
        end

        setUpBadgeParentFrames(primaryBadgeFrame, secondaryBadgeFrame, alignment, showBoth)
        recalculateMainFrameSize(newOrientation)
    end

    function self.setMoveEffectiveness(newValue)
        moveEffectivenessEnabled = newValue
    end

    initUI()
    initEventListeners()

    return self
end

return MainScreen

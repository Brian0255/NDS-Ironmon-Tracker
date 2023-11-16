local function BattleHandler(
    initialGameInfo,
    initialMemoryAddresses,
    initialPokemonDataReader,
    initialTracker,
    initialProgram,
    initialSettings)
    local FrameCounter = dofile(Paths.FOLDERS.DATA_FOLDER .. "/FrameCounter.lua")
    local JoypadEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/JoypadEventListener.lua")

    local self = {}

    local gameInfo = initialGameInfo
    local memoryAddresses = initialMemoryAddresses
    local pokemonDataReader = initialPokemonDataReader
    local tracker = initialTracker
    local program = initialProgram
    local settings = initialSettings

    local defeatedTrainerList = {}
    local GEN5_activePlayerMonPIDAddr = nil
    local GEN5_PIDSwitchData = {}
    local joypadEvents = {}
    local totalBattlesCompleted = 0
    local playerBattleData = {
        partyBase = memoryAddresses.playerBattleBase,
        PIDBase = memoryAddresses.playerBattleMonPID,
        slots = {},
        battleTeamPIDs = {},
        slotIndex = 1,
        monIndex = 0
    }
    local enemyBattleData = {
        partyBase = memoryAddresses.enemyBase,
        PIDBase = memoryAddresses.enemyBattleMonPID,
        slots = {},
        battleTeamPIDs = {},
        slotIndex = 1,
        mnIndex = 0
    }
    local faintMonIndex = -1
    local firstBattleComplete = false
    local battleDataFetched = false
    local frameCounters = {}
    local inBattle = false
    local enemyTrainerID = nil
    local GEN5_transformed = false
    local enemyEffectivenessSlot = 1
    local multiPlayerDouble = false

    self.BATTLE_STATUS_TYPES = {
        [0x2100] = true,
        [0x2101] = true,
        [0x2800] = false
    }

    function self.setGameInfo(newGameInfo)
        gameInfo = newGameInfo
    end

    function self.setMemoryAddresses(newMemoryAddresses)
        memoryAddresses = newMemoryAddresses
    end

    local function GEN5_initializePIDSlots()
        local start = memoryAddresses.playerBattleMonPID
        local battleDatas = {playerBattleData, enemyBattleData}
        GEN5_PIDSwitchData = {
            initialPIDs = {},
            switchSlots = {}
        }
        for _, battleData in pairs(battleDatas) do
            for _, slot in pairs(battleData.slots) do
                GEN5_PIDSwitchData.initialPIDs[Memory.read_u32_le(slot.activePIDAddress)] = true
            end
        end
        for i = 0, 5, 1 do
            local addr = start + i * gameInfo.ACTIVE_PID_DIFFERENCE
            local initialValue = Memory.read_u32_le(addr)
            GEN5_PIDSwitchData.switchSlots[addr] = {
                ["initialValue"] = initialValue
            }
        end
    end

    local function addBattlerSlot(battlers, slot, PIDAddress)
        if slot == nil then
            slot = #battlers + 1
        end
        battlers[slot] = {
            activePIDAddress = PIDAddress,
            lastValidPID = -1,
            lastValidPokemon = nil,
            previousHP = -1,
            initialPID = Memory.read_u32_le(PIDAddress)
        }
    end

    local function isGen5AlternateDoubleBattle()
        if gameInfo.GEN ~= 5 then
            return false
        end
        --Basically checking for the types of double battles with 2 friendly trainers vs. 2 enemy trainers
        --compared to just you vs. 2 other enemy trainers
        return Memory.read_u16_le(memoryAddresses.playerBattleMonPID) == 0 and
            Memory.read_u16_le(memoryAddresses.enemyBattleMonPID) == 0
    end

    local function readTeamPIDs(battleData)
        local currentBase = battleData.partyBase
        local limit = 11
        if not isGen5AlternateDoubleBattle() then
            limit = 5
        end
        for i = 0, limit, 1 do
            if i == 6 then
                currentBase = battleData.partyBase + gameInfo.ENEMY_PARTY_OFFSET
            end
            local pid = Memory.read_u32_le(currentBase)
            if pid ~= 0 then
                battleData.battleTeamPIDs[pid] = i
            end
            currentBase = currentBase + gameInfo.ENCRYPTED_POKEMON_SIZE
        end
    end

    local function GEN4_readBattlePIDInfo(battleData)
        for i = 0, 1, 1 do
            local newBase = battleData.PIDBase + (i * gameInfo.ACTIVE_PID_DIFFERENCE)
            if (Memory.read_u32_le(newBase)) ~= 0 then
                addBattlerSlot(battleData.slots, i + 1, newBase)
            end
        end
    end

    local function GEN5_readBattlePIDInfo()
        --gen 5 is super weird
        --we basically need to scan over the pid switch slot addresses to find out how many battlers there are
        local battleDatas = {playerBattleData, enemyBattleData}
        local PIDStartBase = memoryAddresses.enemyBattleMonPID + 2 * gameInfo.ACTIVE_PID_DIFFERENCE
        local usedAddresses = {
            [playerBattleData.partyBase] = true,
            [enemyBattleData.partyBase] = true
        }
        addBattlerSlot(playerBattleData.slots, nil, memoryAddresses.playerBattleBase)
        addBattlerSlot(enemyBattleData.slots, nil, memoryAddresses.enemyBase)
        for i = 0, 3, 1 do
            local offset = gameInfo.ACTIVE_PID_DIFFERENCE * i
            local pid = Memory.read_u32_le(PIDStartBase + offset)
            for index, _ in pairs(battleDatas) do
                local battleData = battleDatas[index]
                if battleData.battleTeamPIDs[pid] then
                    local slot = battleData.battleTeamPIDs[pid]
                    local partyOffset = slot * gameInfo.ENCRYPTED_POKEMON_SIZE
                    local monLocation = battleData.partyBase + partyOffset
                    if battleData.battleTeamPIDs[pid] and not usedAddresses[monLocation] then
                        addBattlerSlot(battleData.slots, nil, monLocation)
                    end
                end
            end
        end
    end

    local function tryToFetchBattleData()
        local firstPlayerPartyPID = Memory.read_u32_le(memoryAddresses.playerBase)
        local firstPlayerPID = Memory.read_u32_le(memoryAddresses.playerBattleBase)
        local firstEnemyPID = Memory.read_u32_le(memoryAddresses.enemyBase)
        if firstPlayerPID == 0 or firstEnemyPID == 0 or firstPlayerPID ~= firstPlayerPartyPID then
            return false
        end

        if gameInfo.GEN == 5 then
            local gen5SwitchInPIDs = {
                memoryAddresses.enemyBattleMonPID,
                memoryAddresses.enemyBattleMonPID + 0x5C,
                memoryAddresses.enemyBattleMonPID + 2 * 0x5C
            }
            local valid = false
            for _, addr in pairs(gen5SwitchInPIDs) do
                if Memory.read_u32_le(addr) ~= 0 then
                    valid = true
                end
            end
            if not valid then
                return false
            end
        end
        local battleDatas = {playerBattleData, enemyBattleData}
        for _, battleData in pairs(battleDatas) do
            readTeamPIDs(battleData)
            if gameInfo.GEN == 4 then
                GEN4_readBattlePIDInfo(battleData)
            end
        end
        if gameInfo.GEN == 5 then
            GEN5_readBattlePIDInfo()
        end
        if #playerBattleData.slots == 0 or #enemyBattleData.slots == 0 then
            playerBattleData.slots = {}
            enemyBattleData.slots = {}
            return false
        end
        return true
    end

    local function getBattleMonPID(battler)
        local pidAddress = battler.activePIDAddress
        local activePID = Memory.read_u32_le(pidAddress)
        if activePID == 0 then
            return Memory.read_u32_le(pidAddress)
        else
            return activePID
        end
    end

    local function getMonIndex(battleData)
        if battleData == nil then
            return
        end
        local activeMonPID = getBattleMonPID(battleData.slots[battleData.slotIndex])
        return battleData.battleTeamPIDs[activeMonPID]
    end

    function self.updateStatStages(playerPokemon, enemyPokemon)
        if inBattle and battleDataFetched and enemyPokemon ~= nil and playerPokemon ~= nil then
            local playerMonIndex = getMonIndex(playerBattleData)
            local enemyMonIndex = getMonIndex(enemyBattleData)
            if playerMonIndex == nil or enemyMonIndex == nil then
                return
            end
            if gameInfo.GEN == 5 then
                pokemonDataReader.setCurrentBase(memoryAddresses.statStagesStart)
                playerPokemon.statStages = pokemonDataReader.readBattleStatStages(false, playerMonIndex)
                enemyPokemon.statStages = pokemonDataReader.readBattleStatStages(true, enemyMonIndex)
            else
                pokemonDataReader.setCurrentBase(memoryAddresses.statStagesEnemy)
                enemyPokemon.statStages = pokemonDataReader.readBattleStatStages(true, enemyMonIndex)
                pokemonDataReader.setCurrentBase(memoryAddresses.statStagesPlayer)
                playerPokemon.statStages = pokemonDataReader.readBattleStatStages(false, playerMonIndex)
            end
        end
    end

    local function checkForTransform(battleData, slotIndex)
        local activePID = getBattleMonPID(battleData.slots[slotIndex])
        return not battleData.battleTeamPIDs[activePID]
    end

    local function GEN5_checkPlayerTransform(currentPlayerPokemon, compare)
        if GEN5_transformed or compare == nil then
            return
        end
        local previous = currentPlayerPokemon
        if compare.PID == previous.PID and compare.level == previous.level then
            for statName, value in pairs(compare.stats) do
                if previous[statName] ~= value then
                    GEN5_transformed = true
                end
            end
        end
    end

    local function setUpDelay()
        local delay = 150
        if gameInfo.GEN == 5 then
            delay = 90
        end
        if lastValidEnemyBattlePID == -1 then
            delay = 300
            if gameInfo.GEN == 5 and battleDataFetched then
                delay = 0
            end
        end
        return delay
    end

    local function logNewEnemy(data)
        local delay = setUpDelay()
        tracker.logNewEnemyPokemonInBattle(data.pokemonID)
        program.disableMoveEffectiveness()
        program.addEffectivenessEnablingFrameCounter(delay)
        tracker.updateCurrentLevel(data.pokemonID, data.level)
        program.switchToEnemy()
        if enemyTrainerID ~= nil and enemyTrainerID == 0 then
            tracker.updateEncounterData(data.pokemonID, data.level)
        end
    end

    function self.isMultiPlayerDouble()
        return multiPlayerDouble
    end

    local function GEN5_accountForIllusion(battleData, enemyBattler)
        local pokemon = enemyBattler.lastValidPokemon
        if next(GEN5_PIDSwitchData) == nil or pokemon == nil then
            return
        end
        if AbilityData.ABILITIES[pokemon.ability + 1].name ~= "Illusion" then
            return
        end
        local highestNonFaintedIndex = -1
        local highestNonFaintedPID = -1
        pokemonDataReader.setCurrentBase(battleData.partyBase)
        for pid, index in pairs(battleData.battleTeamPIDs) do
            local data = pokemonDataReader.decryptPokemonInfo(false, index, true)
            if data.curHP and data.curHP > 0 and index > highestNonFaintedIndex then
                highestNonFaintedIndex = index
                highestNonFaintedPID = pid
            end
        end
        if highestNonFaintedIndex == -1 then
            return
        end
        if highestNonFaintedPID == pokemon.pid then
            return
        end
        local start = memoryAddresses.playerBattleMonPID
        for i = 0, 5, 1 do
            local switchAddr = start + i * gameInfo.ACTIVE_PID_DIFFERENCE
            local switchData = Memory.read_u32_le(switchAddr)
            if switchData == highestNonFaintedPID then
                enemyBattler.activePIDAddress = switchAddr
            end
        end
    end

    function self.getPokemonData(currentPokemon, battleData, slotIndex, isEnemy)
        if not battleDataFetched then
            return
        end
        local battlers = battleData.slots
        local battler = battlers[slotIndex]
        local currentBase = memoryAddresses.playerBattleBase
        if isEnemy then
            currentBase = memoryAddresses.enemyBase
        end
        local activePID
        local transformed = checkForTransform(battleData, slotIndex)
        if transformed then
            activePID = battler.lastValidPID
        else
            activePID = getBattleMonPID(battler)
        end
        local monIndex = battleData.battleTeamPIDs[activePID]
        if monIndex ~= nil then
            if monIndex > 5 then
                multiPlayerDouble = true
                currentBase = currentBase + gameInfo.ENEMY_PARTY_OFFSET
                monIndex = monIndex - 6
            end
            local base = currentBase + monIndex * gameInfo.ENCRYPTED_POKEMON_SIZE
            pokemonDataReader.setCurrentBase(base)
            local data = pokemonDataReader.decryptPokemonInfo(false, monIndex, isEnemy)
            if data == nil or next(data) == nil then
                return nil
            end
            program.checkForAlternateForm(data)
            if currentPokemon ~= nil and gameInfo.GEN == 5 and not isEnemy then
                GEN5_checkPlayerTransform(currentPokemon, data)
                if GEN5_transformed then
                    return nil
                end
            end
            if activePID ~= battler.lastValidPID and isEnemy then
                if battler.lastValidPokemon ~= nil then
                    tracker.updateLastLevelSeen(battler.lastValidPokemon.pokemonID, battler.lastValidPokemon.level)
                end
                logNewEnemy(data)
                battler.lastValidPokemon = data
            end
            battler.lastValidPID = activePID
            if isEnemy then
                GEN5_accountForIllusion(battleData, battler)
            end
            return data
        end
    end

    function self.isWildBattle()
        if enemyTrainerID == nil then
            return false
        end
        return enemyTrainerID == 0
    end

    local function checkEnemyPP(enemy)
        if inBattle and enemy ~= nil then
            for i, moveID in pairs(enemy.moveIDs) do
                local data = MoveData.MOVES[moveID + 1]
                local currentPP = enemy.movePPs[i]
                local maxPP = data.pp
                if data.id ~= "---" then
                    if currentPP < tonumber(maxPP) then
                        tracker.trackMove(enemy.pokemonID, moveID, enemy.level)
                    end
                end
            end
        end
    end

    function self.getPokemonInBattle(selectedPlayer, selectedPokemon)
        local pokemon = {}
        local isEnemy = (selectedPlayer == program.SELECTED_PLAYERS.ENEMY)
        local battleData = playerBattleData
        if isEnemy then
            battleData = enemyBattleData
        end
        for i = 1, #battleData.slots, 1 do
            local data = self.getPokemonData(selectedPokemon, battleData, i, isEnemy)
            if isEnemy then
                checkEnemyPP(data)
            end
            pokemon[i] = data
        end
        local slotIndex = battleData.slotIndex
        if program.getSelectedPlayer() == program.SELECTED_PLAYERS.PLAYER and isEnemy then
            slotIndex = enemyEffectivenessSlot
        end
        return pokemon[slotIndex]
    end

    local function GEN5_getMatchingBattlerIndexFromSlotValue(teamPIDs, slots, currentSlotValue)
        local slotValueIndex = teamPIDs[currentSlotValue]
        for i = #slots, 1, -1 do
            local battler = slots[i]
            local activePID = Memory.read_u32_le(battler.activePIDAddress)
            local index = teamPIDs[activePID]
            if index == nil then
                return nil
            end
            if slotValueIndex >= index then
                return i
            end
        end
        return nil
    end

    local function checkBattlerHasMatchingPID(currentSlotValue, switchAddress)
        local battleDatas = {playerBattleData, enemyBattleData}
        for _, battleData in pairs(battleDatas) do
            if battleData.battleTeamPIDs[currentSlotValue] then
                battleData.slots[1].activePIDAddress = switchAddress
            end
        end
    end

    function self.GEN5_checkLastSwitchin()
        --In gen 5, there is no active battler PID.
        --Instead, several memory addresses seemingly get updated when switch-ins occur.
        --So what we do is check these addresses. If the PID belongs to player or enemy, update accordingly.
        local sawAZero = false
        if next(GEN5_PIDSwitchData) == nil then
            return
        end
        local start = memoryAddresses.playerBattleMonPID
        for i = 0, 5, 1 do
            local switchAddr = start + i * gameInfo.ACTIVE_PID_DIFFERENCE
            local switchSlot = GEN5_PIDSwitchData.switchSlots[switchAddr]
            local currentValue = Memory.read_u32_le(switchAddr)
            if currentValue == 0 then
                sawAZero = true
            else
                --checking for player pokeball being sent out (and changing the initial value if so),
                --as well as making sure no switch in occured yet (seeing a zero means there was no switch in)
                if switchSlot.initialValue == 0 and sawAZero and currentValue ~= 0 then
                    switchSlot.initialValue = currentValue
                end
                local slotChanged = currentValue ~= switchSlot.initialValue
                local slotUnused = not switchSlot.active
                local slotNotInitial = not GEN5_PIDSwitchData.initialPIDs[currentValue]
                if slotChanged and slotUnused and slotNotInitial then
                    switchSlot.active = true
                    checkBattlerHasMatchingPID(currentValue, switchAddr)
                end
            end
        end
    end

    function self.getDefeatedTrainers()
        return defeatedTrainerList
    end

    local function onEndOfBattle()
        if inBattle then
            if not tracker.hasRunEnded() then
                if enemyTrainerID ~= nil then
                    defeatedTrainerList[enemyTrainerID] = true
                end
                if gameInfo.TRAINERS.LAB_IDS[enemyTrainerID] then
                    tracker.setProgress(PlaythroughConstants.PROGRESS.PAST_LAB)
                elseif gameInfo.TRAINERS.FINAL_FIGHT_ID == enemyTrainerID then
                    tracker.setProgress(PlaythroughConstants.PROGRESS.WON)
                    program.onRunEnded()
                end
            end
            totalBattlesCompleted = totalBattlesCompleted + 1
            firstBattleComplete = true

            for _, battler in pairs(enemyBattleData.slots) do
                if battler.lastValidPokemon ~= nil then
                    tracker.updateLastLevelSeen(battler.lastValidPokemon.pokemonID, battler.lastValidPokemon.level)
                end
            end
        end
        faintMonIndex = -1
        inBattle = false
        GEN5_transformed = false
        multiPlayerDouble = false
    end

    local function getPlayerParty()
        local playerParty = {}
        local currentBase = memoryAddresses.playerBattleBase
        for monIndex = 0, 5, 1 do
            pokemonDataReader.setCurrentBase(currentBase + monIndex * gameInfo.ENCRYPTED_POKEMON_SIZE)
            local data = pokemonDataReader.decryptPokemonInfo(false, monIndex, false)
            if MiscUtils.validPokemonData(data) then
                playerParty[monIndex] = data
            end
        end
        return playerParty
    end

    local function calculateHighestPlayerMonIndex()
        local party = getPlayerParty()
        local maxLevel = 0
        local highestLevelMonIndex = -1
        for monIndex, mon in pairs(party) do
            if mon.level > maxLevel then
                maxLevel = mon.level
                highestLevelMonIndex = monIndex
            end
        end
        return highestLevelMonIndex
    end

    function self.checkIfRunHasEnded()
        if not inBattle or not battleDataFetched then
            return
        end
        if faintMonIndex == -1 then
            if settings.trackedInfo.FAINT_DETECTION == PlaythroughConstants.FAINT_DETECTIONS.ON_HIGHEST_LEVEL_FAINT then
                faintMonIndex = calculateHighestPlayerMonIndex()
            elseif settings.trackedInfo.FAINT_DETECTION == PlaythroughConstants.FAINT_DETECTIONS.ON_FIRST_SLOT_FAINT then
                faintMonIndex = 0
            end
        end
        local currentBase = memoryAddresses.playerBattleBase
        pokemonDataReader.setCurrentBase(currentBase + faintMonIndex * gameInfo.ENCRYPTED_POKEMON_SIZE)
        local data = pokemonDataReader.decryptPokemonInfo(false, faintMonIndex, false)
        if MiscUtils.validPokemonData(data) then
            if data.curHP == 0 then
                program.onRunEnded()
            end
        end
    end

    local function onBattleFetchFrameCounter()
        battleDataFetched = tryToFetchBattleData()
        if battleDataFetched then
            enemyTrainerID = Memory.read_u16_le(memoryAddresses.enemyTrainerID)
            calculateHighestPlayerMonIndex()
            GEN5_initializePIDSlots()
        end
    end

    local function setUpBattleVariables()
        inBattle = true
        battleDataFetched = false
        playerBattleData = {
            partyBase = memoryAddresses.playerBattleBase,
            PIDBase = memoryAddresses.playerBattleMonPID,
            slots = {},
            battleTeamPIDs = {},
            slotIndex = 1
        }
        enemyBattleData = {
            partyBase = memoryAddresses.enemyBase,
            PIDBase = memoryAddresses.enemyBattleMonPID,
            slots = {},
            battleTeamPIDs = {},
            slotIndex = 1
        }
        GEN5_PIDSwitchData = {}
        frameCounters["fetchBattleData"] = FrameCounter(60, onBattleFetchFrameCounter)
        multiPlayerDouble = false
    end

    function self.isInBattle()
        return inBattle
    end

    function self.firstBattleComplete()
        return firstBattleComplete
    end

    function self.updateBattleStatus()
        local battleStatus = Memory.read_u16_le(memoryAddresses.battleStatus)
        if self.BATTLE_STATUS_TYPES[battleStatus] == true then
            if not inBattle then
                setUpBattleVariables()
            else
                if battleDataFetched then
                    frameCounters["fetchBattleData"] = nil
                end
            end
        else
            if inBattle then
                onEndOfBattle()
            end
        end
    end

    function self.inBattleAndFetched()
        return (inBattle and battleDataFetched)
    end

    function self.setPlayerSlotIndex(newIndex)
        playerBattleData.slotIndex = newIndex
    end

    function self.updateEnemySlotIndex(selectedPlayer)
        local limit = #enemyBattleData.slots
        if enemyBattleData.slotIndex == limit then
            selectedPlayer = program.SELECTED_PLAYERS.PLAYER
            enemyBattleData.slotIndex = 1
            playerBattleData.slotIndex = 1
        else
            enemyBattleData.slotIndex = enemyBattleData.slotIndex + 1
        end
        return selectedPlayer
    end

    function self.updatePlayerSlotIndex(selectedPlayer)
        if inBattle and not battleDataFetched then
            return selectedPlayer
        end
        local limit = #playerBattleData.slots
        if settings.battle.DOUBLES_MODE and not inBattle then
            limit = 2
        end
        if playerBattleData.slotIndex == limit then
            selectedPlayer = program.SELECTED_PLAYERS.ENEMY
            enemyBattleData.slotIndex = 1
            playerBattleData.slotIndex = 1
        else
            playerBattleData.slotIndex = playerBattleData.slotIndex + 1
        end
        return selectedPlayer
    end

    function self.getPlayerSlotIndex()
        return playerBattleData.slotIndex
    end

    local function onEffectivenessChange(newEnemySlot)
        enemyEffectivenessSlot = newEnemySlot
        if not enemyBattleData.slots[newEnemySlot] then
            enemyEffectivenessSlot = 1
        end
        program.updateEnemyPokemonData()
        program.setPokemonForMainScreen()
        program.drawCurrentScreens()
    end

    table.insert(joypadEvents, JoypadEventListener(settings.controls, "LEFT_EFFECTIVENESS", onEffectivenessChange, 2))
    table.insert(joypadEvents, JoypadEventListener(settings.controls, "RIGHT_EFFECTIVENESS", onEffectivenessChange, 1))

    function self.runFrameCounters()
        for _, frameCounter in pairs(frameCounters) do
            frameCounter.decrement()
        end
        for _, listener in pairs(joypadEvents) do
            listener.listen()
        end
    end

    return self
end

return BattleHandler

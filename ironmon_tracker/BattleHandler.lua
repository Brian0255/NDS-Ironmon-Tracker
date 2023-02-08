local function BattleHandler(
    initialGameInfo,
    initialMemoryAddresses,
    initialPokemonDataReader,
    initialTracker,
    initialProgram,
    initialSettings)
    local FrameCounter = dofile(Paths.FOLDERS.DATA_FOLDER .. "/FrameCounter.lua")

    local self = {}

    local gameInfo = initialGameInfo
    local memoryAddresses = initialMemoryAddresses
    local pokemonDataReader = initialPokemonDataReader
    local tracker = initialTracker
    local program = initialProgram
    local settings = initialSettings

    local GEN5_activePlayerMonPIDAddr = nil
    local GEN5_PIDSwitchData = {}
    local totalBattlesCompleted = 0
    local playerBattleTeamPIDs = {list = {}}
    local enemyBattlers = {}
    local playerMonIndex = 0
    local faintMonIndex = -1
    local firstBattleComplete = false
    local battleDataFetched = false
    local enemyMonIndex = 0
    local enemySlotIndex = 1
    local frameCounters = {}
    local lastValidPlayerBattlePID = -1
    local inBattle = false
    local enemyTrainerID = nil
    local GEN5_transformed = false

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
        GEN5_PIDSwitchData = {
            initialPIDs = {},
            switchSlots = {}
        }
        for _, battler in pairs(enemyBattlers) do
            GEN5_PIDSwitchData.initialPIDs[Memory.read_u32_le(battler.addressBase)] = true
        end
        GEN5_activePlayerMonPIDAddr = memoryAddresses.playerBattleBase
        GEN5_PIDSwitchData.initialPIDs[Memory.read_u32_le(memoryAddresses.playerBattleBase)] = true
        for i = 0, 5, 1 do
            local addr = start + i * gameInfo.ACTIVE_PID_DIFFERENCE
            local initialValue = Memory.read_u32_le(addr)
            GEN5_PIDSwitchData.switchSlots[addr] = {
                ["initialValue"] = initialValue
            }
        end
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

    local function addEnemyBattler(currentBase, currentEnemyIndex, totalPlayerMons, startIndex)
        local total = 0
        total = total + #enemyBattlers
        if isGen5AlternateDoubleBattle() then
            total = total + Memory.read_u32_le(memoryAddresses.enemyBase + gameInfo.ENEMY_PARTY_OFFSET - 0x04)
            total = total * 2
            total = total + totalPlayerMons
        end
        local activePID = memoryAddresses.enemyBattleMonPID + (currentEnemyIndex - 1) * 0x180
        if gameInfo.GEN == 5 then
            activePID = currentBase
        end
        enemyBattlers[currentEnemyIndex] = {
            teamPIDs = {},
            addressBase = currentBase,
            activePIDAddress = activePID,
            ["startIndex"] = startIndex,
            lastValidPID = nil,
            lastValidPokemon = nil,
            secondMon = true,
            extraOffset = 0x224 * total
        }
    end

    local function fetchEnemyData()
        local currentBase = memoryAddresses.enemyBase
        local currentEnemyIndex = 1
        local gen5AlternateDouble = isGen5AlternateDoubleBattle()
        local totalPlayerMons = Memory.read_u32_le(memoryAddresses.totalMonsParty)
        local doublesOffset = 0
        if gen5AlternateDouble then
            doublesOffset = 0x224 * totalPlayerMons
        end
        enemyBattlers[currentEnemyIndex] = {
            teamPIDs = {},
            addressBase = currentBase,
            activePIDAddress = currentBase,
            startIndex = 0,
            lastValidPID = -1,
            lastValidPokemon = nil,
            extraOffset = doublesOffset,
            transformed = false
        }
        if gameInfo.GEN == 4 then
            enemyBattlers[currentEnemyIndex].activePIDAddress = memoryAddresses.enemyBattleMonPID
        end
        local lookFor = memoryAddresses.enemyBattleMonPID + gameInfo.ACTIVE_PID_DIFFERENCE
        if gen5AlternateDouble then
            lookFor = lookFor + gameInfo.ACTIVE_PID_DIFFERENCE
        end
        for i = 0, 11, 1 do
            if i == 6 then
                if currentEnemyIndex ~= 2 or (gameInfo.GEN == 5 and currentEnemyIndex == 2) then
                    currentBase = memoryAddresses.enemyBase + gameInfo.ENEMY_PARTY_OFFSET
                    if gen5AlternateDouble then
                        currentBase = currentBase + gameInfo.ENEMY_PARTY_OFFSET
                    end
                else
                    break
                end
            end
            local pid = Memory.read_u32_le(currentBase)
            if pid ~= 0 then
                pokemonDataReader.setCurrentBase(currentBase)
                local pokemonData = pokemonDataReader.decryptPokemonInfo(false, i, true)
                if MiscUtils.validPokemonData(pokemonData) then
                    if pid == Memory.read_u32_le(lookFor) then
                        lookFor = lookFor + gameInfo.ACTIVE_PID_DIFFERENCE
                        currentEnemyIndex = currentEnemyIndex + 1
                        addEnemyBattler(currentBase, currentEnemyIndex, totalPlayerMons, i)
                    end
                    local indexToInsert = i - enemyBattlers[currentEnemyIndex].startIndex

                    local enemyBattler = enemyBattlers[currentEnemyIndex]
                    if enemyBattler.teamPIDs[pid] ~= nil and gameInfo.GEN == 4 then
                        --annoying case to handle when trainer has 2 with the same PID, no fix for gen 5 yet (battle data structures different)
                        if type(enemyBattler.teamPIDs[pid]) == "table" then
                            table.insert(enemyBattler.teamPIDs[pid], indexToInsert)
                        else
                            enemyBattler.teamPIDs[pid] = {enemyBattler.teamPIDs[pid], indexToInsert}
                        end
                    else
                        enemyBattler.teamPIDs[pid] = indexToInsert
                    end
                end
            end
            currentBase = currentBase + gameInfo.ENCRYPTED_POKEMON_SIZE
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

        local currentBase = memoryAddresses.playerBattleBase

        for i = 0, 5, 1 do
            local pid = Memory.read_u32_le(currentBase)
            if pid ~= 0 then
                playerBattleTeamPIDs[pid] = i
            else
                break
            end
            currentBase = currentBase + gameInfo.ENCRYPTED_POKEMON_SIZE
        end
        fetchEnemyData()
        return true
    end

    function self.updateStatStages(playerPokemon, enemyPokemon)
        if inBattle and battleDataFetched and enemyPokemon ~= nil and playerPokemon ~= nil then
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

    local function getPlayerBattleMonPID()
        local activePID = Memory.read_u32_le(memoryAddresses.playerBattleMonPID)
        if gameInfo.GEN == 5 then
            activePID = Memory.read_u32_le(GEN5_activePlayerMonPIDAddr)
        end
        if activePID == 0 then
            return Memory.read_u32_le(memoryAddresses.playerBattleBase)
        else
            return activePID
        end
    end

    local function getEnemyBattleMonPID(enemyBattler)
        local activePID = Memory.read_u32_le(enemyBattler.activePIDAddress)
        if activePID == 0 then
            return Memory.read_u32_le(enemyBattler.addressBase)
        else
            return activePID
        end
    end

    local function checkForPlayerTransform()
        local activePID = getPlayerBattleMonPID()
        return not playerBattleTeamPIDs[activePID]
    end

    local function checkForEnemyTransform(enemyBattler)
        local activePID = getEnemyBattleMonPID(enemyBattler)
        return not enemyBattler.teamPIDs[activePID]
    end

    local function GEN5_checkPlayerTransform(currentPlayerPokemon, compare)
        if GEN5_transformed then return end
        local previous = currentPlayerPokemon
        if compare.PID == previous.PID and compare.level == previous.level then
            for statName, value in pairs(compare.stats) do
                if previous[statName] ~= value then
                    GEN5_transformed = true
                end
            end
        end
    end

    function self.getPokemonDataPlayer(currentPlayerPokemon)
        if not battleDataFetched then
            return
        end
        local currentBase = memoryAddresses.playerBattleBase
        local activePID
        local transformed = checkForPlayerTransform()
        if transformed then
            activePID = lastValidPlayerBattlePID
        else
            activePID = getPlayerBattleMonPID()
            lastValidPlayerBattlePID = activePID
        end
        local monIndex = playerBattleTeamPIDs[activePID]
        if monIndex ~= nil then
            playerMonIndex = monIndex
            pokemonDataReader.setCurrentBase(currentBase + monIndex * gameInfo.ENCRYPTED_POKEMON_SIZE)
            local data = pokemonDataReader.decryptPokemonInfo(false, monIndex, false)
            if currentPlayerPokemon ~= nil and gameInfo.GEN == 5 then
                GEN5_checkPlayerTransform(currentPlayerPokemon, data)
                if GEN5_transformed then return nil end
            end
            return data
        end
    end

    local function handleIdenticalMonsInParty(slot, currentBase, monIndex)
        local pokemonData
        for _, indexToCheck in pairs(monIndex) do
            pokemonDataReader.setCurrentBase(currentBase + indexToCheck * gameInfo.ENCRYPTED_POKEMON_SIZE)
            local testForID = pokemonDataReader.decryptPokemonInfo(false, monIndex, true)
            if MiscUtils.validPokemonData(testForID) then
                if testForID.pokemonID == memory.read_u16_le(memoryAddresses.enemyPokemonID + 180 * (slot - 1)) then
                    pokemonData = testForID
                    return pokemonData
                end
            end
        end
        return pokemonData
    end

    local function setUpDelay(enemyBattler)
        local delay = 150
        if gameInfo.GEN == 5 then
            delay = 90
        end
        if enemyBattler.lastValidPID == -1 then
            delay = 300
            if gameInfo.GEN == 5 and battleDataFetched then
                delay = 0
            end
        end
        return delay
    end

    function self.isWildBattle()
        if enemyTrainerID == nil then
            return false
        end
        return enemyTrainerID == 0
    end

    function self.getPokemonDataEnemy(slot)
        if inBattle and battleDataFetched then
            local enemyBattler = enemyBattlers[slot]
            local currentBase = enemyBattler.addressBase
            local activePID
            local transformed = checkForEnemyTransform(enemyBattler)
            if transformed then
                activePID = enemyBattler.lastValidPID
            else
                activePID = getEnemyBattleMonPID(enemyBattler)
                local activePokemon = enemyBattler.activeEnemyPokemon
                if activePID ~= enemyBattler.lastValidPID and enemyBattler.activeEnemyPokemon ~= nil then
                    tracker.updateLastLevelSeen(activePokemon.pokemonID, activePokemon.level)
                end
            end
            local pokemonData
            local monIndex = enemyBattler.teamPIDs[activePID]
            if type(monIndex) == "table" then
                pokemonData = handleIdenticalMonsInParty(slot, currentBase, monIndex)
                if pokemonData == nil then
                    monIndex = monIndex[1]
                end
            end
            if monIndex ~= nil and pokemonData == nil then
                enemyMonIndex = monIndex
                pokemonDataReader.setCurrentBase(currentBase + monIndex * gameInfo.ENCRYPTED_POKEMON_SIZE)
                pokemonData = pokemonDataReader.decryptPokemonInfo(false, monIndex, true, enemyBattler.extraOffset)
            end
            if MiscUtils.validPokemonData(pokemonData) then
                program.checkForAlternateForm(pokemonData)
                enemyBattler.lastValidPokemon = pokemonData
                enemyBattler.activeEnemyPokemon = pokemonData
                if activePID ~= enemyBattler.lastValidPID then
                    local delay = setUpDelay(enemyBattler)
                    tracker.logNewEnemyPokemonInBattle(pokemonData.pokemonID)
                    program.disableMoveEffectiveness()
                    program.addEffectivenessEnablingFrameCounter(delay)
                    tracker.updateCurrentLevel(pokemonData.pokemonID, pokemonData.level)
                    if enemyTrainerID ~= nil and enemyTrainerID == 0 then
                        tracker.updateEncounterData(pokemonData.pokemonID, pokemonData.level)
                    end
                end
                enemyBattler.lastValidPID = activePID
                return pokemonData
            else
                return nil
            end
        end
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

    function self.getEnemyData()
        local enemies = {}
        for i = 1, #enemyBattlers, 1 do
            local enemy = self.getPokemonDataEnemy(i)
            checkEnemyPP(enemy)
            enemies[i] = enemy
        end
        return enemies[enemySlotIndex]
    end

    function self.GEN5_checkLastSwitchin()
        --In gen 5, there is no active battler PID.
        --Instead, several memory addresses seemingly get updated when switch-ins occur.
        --So what we do is check these addresses. If the PID belongs to player or enemy, update accordingly.
        local sawAZero = false
        if next(GEN5_PIDSwitchData) ~= nil then
            local start = memoryAddresses.playerBattleMonPID
            for i = 0, 5, 1 do
                local switchAddr = start + i * gameInfo.ACTIVE_PID_DIFFERENCE
                local data = GEN5_PIDSwitchData.switchSlots[switchAddr]
                local currentValue = Memory.read_u32_le(switchAddr)
                if currentValue == 0 then
                    sawAZero = true
                else
                    --checking for player pokeball being sent out (and changing the initial value if so),
                    --as well as making sure no switch in occured yet (seeing a zero means there was no switch in)
                    if data.initialValue == 0 and sawAZero and currentValue ~= 0 then
                        data.initialValue = currentValue
                    end
                    if
                        not data.active and currentValue ~= data.initialValue and
                            not GEN5_PIDSwitchData.initialPIDs[currentValue]
                     then
                        data.active = true
                        if
                            playerBattleTeamPIDs[currentValue] and
                                GEN5_activePlayerMonPIDAddr == memoryAddresses.playerBattleBase
                         then
                            GEN5_activePlayerMonPIDAddr = switchAddr
                        else
                            for _, battler in pairs(enemyBattlers) do
                                if battler.teamPIDs[currentValue] and battler.activePIDAddress == battler.addressBase then
                                    battler.activePIDAddress = switchAddr
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    local function onEndOfBattle()
        if inBattle then
            if not tracker.hasRunEnded() then
                if gameInfo.TRAINERS.LAB_IDS[enemyTrainerID] then
                    tracker.setProgress(PlaythroughConstants.PROGRESS.PAST_LAB)
                elseif gameInfo.TRAINERS.FINAL_FIGHT_ID == enemyTrainerID then
                    tracker.setProgress(PlaythroughConstants.PROGRESS.WON)
                    program.onRunEnded()
                end
            end
            totalBattlesCompleted = totalBattlesCompleted + 1
            firstBattleComplete = true
            for _, battler in pairs(enemyBattlers) do
                if battler.lastValidPokemon ~= nil then
                    tracker.updateLastLevelSeen(battler.lastValidPokemon.pokemonID, battler.lastValidPokemon.level)
                end
            end
        end
        faintMonIndex = -1
        inBattle = false
        GEN5_transformed = false
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
            elseif settings.trackedInfo.FAINT_DETECTION ==PlaythroughConstants.FAINT_DETECTIONS.ON_FIRST_SLOT_FAINT then
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
        lastValidPlayerBattlePID = -1
        inBattle = true
        battleDataFetched = false
        enemySlotIndex = 1
        playerBattleTeamPIDs = {}
        enemyBattlers = {}
        GEN5_PIDSwitchData = {}
        frameCounters["fetchBattleData"] = FrameCounter(60, onBattleFetchFrameCounter)
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

    function self.updateEnemySlotIndex(selectedPlayer)
        if enemySlotIndex == #enemyBattlers then
            selectedPlayer = program.SELECTED_PLAYERS.PLAYER
            enemySlotIndex = 1
        else
            enemySlotIndex = enemySlotIndex + 1
        end
        return selectedPlayer
    end

    function self.runFrameCounters()
        for _, frameCounter in pairs(frameCounters) do
            frameCounter.decrement()
        end
    end

    return self
end

return BattleHandler

local FrameCounter = dofile(Paths.FOLDERS.DATA_FOLDER .. "/FrameCounter.lua")
local JoypadEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/JoypadEventListener.lua")

BattleHandlerBase = {
    BATTLE_STATUS_TYPES = {
        [0x2100] = true,
        [0x2101] = true,
        [0x2800] = false
    },
    _frameCounters = {},
    _joypadEvents = {},
    _enemyEffectivenessSlot = 1,
    _battleData = {
        ["player"] = {},
        ["enemy"] = {}
    },
    _inBattle = false,
    _battleDataFetched = false,
    _firstBattleComplete = false,
    _enemyTrainerID = nil,
    _faintMonIndex = -1,
    _defeatedTrainerList = {}
}

function BattleHandlerBase:new(o, gameInfo, memoryAddresses, pokemonDataReader, tracker, program, settings)
    o = o or {}
    setmetatable(o, self)
    self.__index = self
    self._gameInfo = gameInfo
    self._pokemonDataReader = pokemonDataReader
    self._tracker = tracker
    self._program = program
    self._settings = settings

    self._joypadEvents = {}

    self.memoryAddresses = memoryAddresses

    if self._settings ~= nil then
        table.insert(
            self._joypadEvents,
            JoypadEventListener(self._settings.controls, "LEFT_EFFECTIVENESS", self._onEffectivenessChange, {self, 2})
        )
        table.insert(
            self._joypadEvents,
            JoypadEventListener(self._settings.controls, "RIGHT_EFFECTIVENESS", self._onEffectivenessChange, {self, 2})
        )
    end

    return o
end

function BattleHandlerBase._onEffectivenessChange(params)
    local self, newEnemySlot = params[1], params[2]
    self._enemyEffectivenessSlot = newEnemySlot
    if not self._battleData["enemy"].slots[newEnemySlot] then
        self._enemyEffectivenessSlot = 1
    end
    self._program.updateEnemyPokemonData()
    self._program.setPokemonForMainScreen()
    self._program.drawCurrentScreens()
end

function BattleHandlerBase:addFrameCounter(frameCounterKey, frameCounter)
    self._frameCounters[frameCounterKey] = frameCounter
end

function BattleHandlerBase:removeFrameCounter(frameCounterKey)
    self._frameCounters[frameCounterKey] = nil
end

function BattleHandlerBase:getEnemyEffectivenessSlot()
    return self._enemyEffectivenessSlot
end

function BattleHandlerBase:_setUpDelay()
    local delay = 150
    if self._gameInfo.GEN == 5 then
        delay = 90
    end
    return delay
end

function BattleHandlerBase:_logNewEnemy(data)
    local delay = self:_setUpDelay()
    self._tracker.logNewEnemyPokemonInBattle(data.pokemonID)
    self._program.disableMoveEffectiveness()
    self._program.addEffectivenessEnablingFrameCounter(delay)
    self._tracker.updateCurrentLevel(data.pokemonID, data.level)
    self._program.switchToEnemy()
    if self._enemyTrainerID ~= nil and self._enemyTrainerID == 0 then
        self._tracker.updateEncounterData(data.pokemonID, data.level)
    end
end

function BattleHandlerBase:getBattleData()
    return self._battleData
end

function BattleHandlerBase:setMemoryAddresses(newMemoryAddresses)
    self.memoryAddresses = newMemoryAddresses
end

function BattleHandlerBase:isMultiPlayerDouble()
    return self._multiPlayerDouble
end

function BattleHandlerBase:isWildBattle()
    if self._enemyTrainerID == nil then
        return false
    end
    return self._enemyTrainerID == 0
end

function BattleHandlerBase:isInBattle()
    return self._inBattle
end

function BattleHandlerBase:inBattleAndFetched()
    return self._inBattle and self._battleDataFetched
end

function BattleHandlerBase:isFirstBattleComplete()
    return self._firstBattleComplete
end

function BattleHandlerBase:getDefeatedTrainers()
    return self._defeatedTrainerList
end

function BattleHandlerBase:_getPlayerParty()
    local playerParty = {}
    local currentBase = self.memoryAddresses.playerBattleBase
    for monIndex = 0, 5, 1 do
        self._pokemonDataReader.setCurrentBase(currentBase + monIndex * self._gameInfo.ENCRYPTED_POKEMON_SIZE)
        local data = self._pokemonDataReader.decryptPokemonInfo(false, monIndex, false)
        if MiscUtils.validPokemonData(data) then
            playerParty[monIndex] = data
        end
    end
    return playerParty
end

function BattleHandlerBase:_hasPartyWiped()
    local party = self:_getPlayerParty()
    for _, pokemon in pairs(party) do
        if pokemon.curHP ~= 0 or pokemon.curHP == nil then
            return false
        end
    end
    return true
end

function BattleHandlerBase:_calculateHighestPlayerMonIndex()
    local party = self:_getPlayerParty()
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

function BattleHandlerBase:checkIfRunHasEnded()
    if not self:inBattleAndFetched() then
        return
    end
    if
        self._settings.trackedInfo.FAINT_DETECTION == PlaythroughConstants.FAINT_DETECTIONS.ON_ENTIRE_PARTY_FAINT and
            self:_hasPartyWiped()
     then
        self._program.onRunEnded()
        return
    end
    if self._faintMonIndex == -1 then
        if self._settings.trackedInfo.FAINT_DETECTION == PlaythroughConstants.FAINT_DETECTIONS.ON_HIGHEST_LEVEL_FAINT then
            self._faintMonIndex = self:_calculateHighestPlayerMonIndex()
        elseif self._settings.trackedInfo.FAINT_DETECTION == PlaythroughConstants.FAINT_DETECTIONS.ON_FIRST_SLOT_FAINT then
            self._faintMonIndex = 0
        end
    end
    local currentBase = self.memoryAddresses.playerBattleBase
    self._pokemonDataReader.setCurrentBase(currentBase + self._faintMonIndex * self._gameInfo.ENCRYPTED_POKEMON_SIZE)
    local data = self._pokemonDataReader.decryptPokemonInfo(false, self._faintMonIndex, false)
    if MiscUtils.validPokemonData(data) then
        if data.curHP == 0 then
            self._program.onRunEnded()
        end
    end
end

function BattleHandlerBase:_getCorrectBattleData(isEnemy)
    if isEnemy then
        return self._battleData["enemy"]
    end
    return self._battleData["player"]
end

function BattleHandlerBase:checkEnemyPP(enemy)
    if not self._inBattle or enemy == nil then
        return
    end
    for i, moveID in pairs(enemy.moveIDs) do
        local data = MoveData.MOVES[moveID + 1]
        local currentPP = enemy.movePPs[i]
        local maxPP = data.pp
        if data.id ~= "---" then
            if currentPP < tonumber(maxPP) then
                self._tracker.trackMove(enemy.pokemonID, moveID, enemy.level)
            end
        end
    end
end

function BattleHandlerBase:_updateSlotIndex(isEnemy, limit)
    local switchTo = self._program.SELECTED_PLAYERS.ENEMY
    if isEnemy then
        switchTo = self._program.SELECTED_PLAYERS.PLAYER
    end
    local battleData = self:_getCorrectBattleData(isEnemy)
    if battleData.slotIndex == limit then
        self._battleData["player"].slotIndex = 1
        self._battleData["enemy"].slotIndex = 1
        return switchTo
    else
        battleData.slotIndex = battleData.slotIndex + 1
    end
    return nil
end

function BattleHandlerBase:updatePlayerSlotIndex(currentSelectedPlayer)
    if self._inBattle and not self._battleDataFetched then
        return currentSelectedPlayer
    end
    local limit = #self._battleData["player"].slots
    if self._settings.battle.DOUBLES_MODE and not self._inBattle then
        limit = 2
    end
    return self:_updateSlotIndex(false, limit) or currentSelectedPlayer
end

function BattleHandlerBase:updateEnemySlotIndex(currentSelectedPlayer)
    local limit = #self._battleData["enemy"].slots
    return self:_updateSlotIndex(true, limit) or currentSelectedPlayer
end

function BattleHandlerBase:setPlayerSlotIndex(newIndex)
    self._battleData["player"].slotIndex = newIndex
end

function BattleHandlerBase:getPlayerSlotIndex()
    return self._battleData["player"].slotIndex
end

function BattleHandlerBase._onBattleFetchFrameCounter(self)
    self._battleDataFetched = self:_tryToFetchBattleData()
    if self._battleDataFetched then
        self._enemyTrainerID = Memory.read_u16_le(self.memoryAddresses.enemyTrainerID)
        self:_calculateHighestPlayerMonIndex()
    end
end

function BattleHandlerBase:_baseSetUpBattleVariables()
    self._inBattle = true
    self._battleDataFetched = false
    self._battleData["player"] = {
        partyBase = self.memoryAddresses.playerBattleBase,
        PIDBase = self.memoryAddresses.playerBattleMonPID,
        slots = {},
        battleTeamPIDs = {},
        slotIndex = 1,
        isEnemy = false
    }
    self._battleData["enemy"] = {
        partyBase = self.memoryAddresses.enemyBase,
        PIDBase = self.memoryAddresses.enemyBattleMonPID,
        slots = {},
        battleTeamPIDs = {},
        slotIndex = 1,
        isEnemy = true
    }
    self._frameCounters["fetchBattleData"] = FrameCounter(60, self._onBattleFetchFrameCounter, self)
    self._multiPlayerDouble = false
end

function BattleHandlerBase:_onEndOfBattle()
    if self._inBattle then
        if not self._tracker.hasRunEnded() then
            if self._enemyTrainerID ~= nil then
                self._defeatedTrainerList[self._enemyTrainerID] = true
            end
            if self._gameInfo.TRAINERS.LAB_IDS[self._enemyTrainerID] then
                self._tracker.setProgress(PlaythroughConstants.PROGRESS.PAST_LAB)
            elseif self._gameInfo.TRAINERS.FINAL_FIGHT_ID == self._enemyTrainerID then
                self._tracker.setProgress(PlaythroughConstants.PROGRESS.WON)
                self._program.onRunEnded()
            end
        end
        self._totalBattlesCompleted = self._totalBattlesCompleted + 1
        self._firstBattleComplete = true

        for _, battler in pairs(self._battleData["enemy"].slots) do
            if battler.lastValidPokemon ~= nil then
                self._tracker.updateLastLevelSeen(battler.lastValidPokemon.pokemonID, battler.lastValidPokemon.level)
            end
        end
    end
    self._faintMonIndex = -1
    self._inBattle = false
    self._multiPlayerDouble = false
end

function BattleHandlerBase:updateBattleStatus()
    local battleStatus = Memory.read_u16_le(self.memoryAddresses.battleStatus)
    if self.BATTLE_STATUS_TYPES[battleStatus] == true then
        if not self._inBattle then
            self:_setUpBattleVariables()
        else
            if self._battleDataFetched then
                self._frameCounters["fetchBattleData"] = nil
            end
        end
    else
        if self._inBattle then
            self:_onEndOfBattle()
        end
    end
end

function BattleHandlerBase:getAllPokemonInBattle()
    local pokemon = {}
    local order = {"player", "enemy"}
    for _, key in pairs(order) do
        local battlerData = self._battleData[key]
        for _, slot in pairs(battlerData.slots) do
            table.insert(pokemon, slot.activePokemon)
        end
    end
    return pokemon
end

function BattleHandlerBase:updateAllPokemonInBattle()
    if not self:inBattleAndFetched() then
        return
    end
    for _, battlerData in pairs(self:getBattleData()) do
        for slot = 1, #battlerData.slots, 1 do
            local data = self:_getPokemonData(battlerData, slot, battlerData.isEnemy)
            if battlerData.isEnemy then
                self:checkEnemyPP(data)
            end
            battlerData.slots[slot].activePokemon = data
        end
    end
end

function BattleHandlerBase:getActivePokemonInBattle(selected)
    local isEnemy = selected == self._program.SELECTED_PLAYERS.ENEMY
    local battlerData = self:_getCorrectBattleData(isEnemy)
    local slotIndex = battlerData.slotIndex
    if self._program.getSelectedPlayer() == self._program.SELECTED_PLAYERS.PLAYER and isEnemy then
        slotIndex = self:getEnemyEffectivenessSlot()
    end
    return battlerData.slots[slotIndex].activePokemon
end

function BattleHandlerBase:runEvents()
    for _, frameCounter in pairs(self._frameCounters) do
        frameCounter.decrement()
    end
    for _, listener in pairs(self._joypadEvents) do
        listener.listen()
    end
end

--child class should define these
function BattleHandlerBase:_setUpBattleVariables()
end

function BattleHandlerBase:_tryToFetchBattleData()
end

function BattleHandlerBase:_getPokemonData(battleData, slot, isEnemy)
end

function BattleHandlerBase:updateStatStages()
end

function BattleHandlerBase:_isTransformed()
end

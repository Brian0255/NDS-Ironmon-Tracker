BattleHandlerGen4 = BattleHandlerBase:new()
local FrameCounter = dofile(Paths.FOLDERS.DATA_FOLDER .. "/FrameCounter.lua")
local JoypadEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/JoypadEventListener.lua")

function BattleHandlerGen4._readAbilityMessages(self)
    if not self:inBattleAndFetched() or not self.memoryAddresses.battleSubscriptMsgs then
        return
    end

    -- Check current battle message to see if it's related to an ability triggering
    local msgId = Memory.read_u16_le(self.memoryAddresses.battleSubscriptMsgs) or -1
    local knownMsg = AbilityData.BATTLE_MSGS[msgId]
    if not knownMsg then
        return
    end

    --TODO: fix
    local battleMons = {}
    --self:getBattleMons()

    -- Determine what ability triggered and which pokemon triggered it (the source)
    local sourcePokemon
    local numPossibleSources = 0
    for _, pokemon in pairs(battleMons) do
        if knownMsg[pokemon.ability] then
            numPossibleSources = numPossibleSources + 1
            sourcePokemon = pokemon
        end
    end

    -- Don't track the ability if more than one pokemon may have triggered it
    -- NOTE: This is currently a necessary precaution, since there isn't a good way to determine the source of the ability
    if not sourcePokemon or numPossibleSources ~= 1 then
        return
    end

    self._tracker.trackAbilityNote(sourcePokemon.pokemonID, sourcePokemon.ability)

    -- Check if Trace(id=36) triggered in a 1v1 battle and it belongs to the player, if so track enemy ability
    if sourcePokemon.ability == 36 and #battleMons == 2 and sourcePokemon == battleMons[1] then
        self._tracker.trackAbilityNote(battleMons[2].pokemonID, battleMons[2].ability)
    end
end

function BattleHandlerGen4:_setUpBattleVariables()
    self:_baseSetUpBattleVariables()
    self:addFrameCounter("abilityTracking", FrameCounter(10, self._readAbilityMessages, self))
end

function BattleHandlerGen4:_addBattlerSlot(battlerSlots, slot, PIDAddress)
    if slot == nil then
        slot = #battlerSlots + 1
    end
    battlerSlots[slot] = {
        activePIDAddress = PIDAddress,
        lastValidPID = -1,
        lastValidPokemon = nil,
        previousHP = -1,
        initialPID = Memory.read_u32_le(PIDAddress)
    }
end

function BattleHandlerGen4:_readTeamPIDs(battleData)
    local currentBase = battleData.partyBase
    local limit = 11
    for i = 0, limit, 1 do
        if i == 6 then
            currentBase = battleData.partyBase + self._gameInfo.ENEMY_PARTY_OFFSET
        end
        local pid = Memory.read_u32_le(currentBase)
        if pid ~= 0 then
            battleData.battleTeamPIDs[pid] = i
        end
        currentBase = currentBase + self._gameInfo.ENCRYPTED_POKEMON_SIZE
    end
end

function BattleHandlerGen4:_readBattlePIDInfo(battleData)
    for i = 0, 1, 1 do
        local newBase = battleData.PIDBase + (i * self._gameInfo.ACTIVE_PID_DIFFERENCE)
        if (Memory.read_u32_le(newBase)) ~= 0 then
            self:_addBattlerSlot(battleData.slots, i + 1, newBase)
        end
    end
end

function BattleHandlerGen4:_tryToFetchBattleData()
    local firstPlayerPartyPID = Memory.read_u32_le(self.memoryAddresses.playerBase)
    local firstPlayerPID = Memory.read_u32_le(self.memoryAddresses.playerBattleBase)
    local firstEnemyPID = Memory.read_u32_le(self.memoryAddresses.enemyBase)
    if firstPlayerPID == 0 or firstEnemyPID == 0 or firstPlayerPID ~= firstPlayerPartyPID then
        return false
    end
    local battleData = self:getBattleData()
    for _, data in pairs(battleData) do
        self:_readTeamPIDs(data)
        self:_readBattlePIDInfo(data)
    end
    if #battleData["player"].slots == 0 or #battleData["enemy"].slots == 0 then
        battleData["player"].slots = {}
        battleData["enemy"].slots = {}
        return false
    end
    return true
end

function BattleHandlerGen4:_getBattleMonPID(battler)
    local pidAddress = battler.activePIDAddress
    local activePID = Memory.read_u32_le(pidAddress)
    if activePID == 0 then
        return Memory.read_u32_le(pidAddress)
    else
        return activePID
    end
end

function BattleHandlerGen4:_isTransformed(battleData, activePID)
    return not battleData.battleTeamPIDs[activePID]
end

function BattleHandlerGen4:_getPokemonData(battleData, slotIndex, isEnemy)
    if not self:inBattleAndFetched() then
        return
    end
    local battlers = battleData.slots
    local battler = battlers[slotIndex]
    local currentBase = battleData.partyBase
    local activePID = self:_getBattleMonPID(battler)
    local transformed = self:_isTransformed(battleData, activePID)
    if transformed then
        activePID = battler.lastValidPID
    end
    local monIndex = battleData.battleTeamPIDs[activePID]
    if monIndex == nil then
        return
    end
    local base = currentBase + monIndex * self._gameInfo.ENCRYPTED_POKEMON_SIZE
    self._pokemonDataReader.setCurrentBase(base)
    local data = self._pokemonDataReader.decryptPokemonInfo(false, monIndex, isEnemy)
    if data == nil or next(data) == nil then
        return
    end
    self._program.checkForAlternateForm(data)
    if activePID ~= battler.lastValidPID and isEnemy then
        self:_logNewEnemy(data)
        if battler.lastValidPokemon ~= nil then
            self._tracker.updateLastLevelSeen(battler.lastValidPokemon.pokemonID, battler.lastValidPokemon.level)
        end
        battler.lastValidPokemon = data
    end
    battler.lastValidPID = activePID
    return data
end

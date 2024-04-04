BattleHandlerGen5 = BattleHandlerBase:new()
local FrameCounter = dofile(Paths.FOLDERS.DATA_FOLDER .. "/FrameCounter.lua")

function BattleHandlerGen5:_setUpBattleVariables()
    self:_baseSetUpBattleVariables()
    local battleData = self:getBattleData()
    self._battlerAmount = 0
end

function BattleHandlerGen5:new(o, gameInfo, memoryAddresses, pokemonDataReader, tracker, program, settings)
    self = BattleHandlerBase.new(self, o, gameInfo, memoryAddresses, pokemonDataReader, tracker, program, settings)
    self._activeSlotsInBattle = 0
    self.DOUBLE_TRIPLE_FLAG_TO_BATTLER_AMOUNT = {
        [0] = 1,
        [1] = 2,
        [2] = 3,
        [3] = 3
    }
    self.BATTLE_STAT_OFFSETS = {
        ["curHP"] = 0x10,
        ["totalHP"] = 0x0E,
        ["level"] = 0x18,
        ["statStages"] = 0xFC,
        ["stats"] = 0xEE,
        ["status"] = 0x20,
        ["moves"] = 0x104
    }
    self._battlerAmount = 0
    self._playerPartyPointers = {}
    return self
end

function BattleHandlerGen5:_readAmountOfBattlers()
    --more than 2 mean multi-player double/triple
    local currentPointer = self.memoryAddresses.mainBattleDataPtr + 0x18
    local total = 0
    while (Memory.read_u32_le(currentPointer)) ~= 0 do
        currentPointer = currentPointer + 0x1C
        total = total + 1
    end
    self._battlerAmount = total
end

function BattleHandlerGen5:_addBattlerSlot(battlerSlots, slot, battleDataPtr, abilityTriggerAddr)
    if slot == nil then
        slot = #battlerSlots + 1
    end
    battlerSlots[slot] = {
        ["battleDataPtr"] = battleDataPtr,
        lastPointerValue = nil,
        lastValidPokemon = nil,
        activePokemon = nil,
        lastAbilityValue = -1,
        ["abilityTriggerAddress"] = abilityTriggerAddr
    }
end

function BattleHandlerGen5:_readBattleDataPtr(currentBattleDataPtr, amount, isEnemy, advanceAmount, abilityTriggerStart)
    local battleData = self:_getCorrectBattleData(isEnemy)
    local endPoint = currentBattleDataPtr + ((amount - 1) * advanceAmount)
    for addr = currentBattleDataPtr, endPoint, advanceAmount do
        local index = (addr - currentBattleDataPtr) / advanceAmount
        local abilityTriggerAddr = abilityTriggerStart + (0x08 * index)
        self:_addBattlerSlot(battleData.slots, nil, addr, abilityTriggerAddr)
    end
end

function BattleHandlerGen5:_readPlayerPartyPointers()
    local base = self.memoryAddresses.mainBattleDataPtr
    for i = 0, 5, 1 do
        local data = Memory.read_pointer(base + (i * 0x04))
        if data ~= 0 then
            table.insert(self._playerPartyPointers, data)
        end
    end
    table.sort(
        self._playerPartyPointers,
        function(pointer1, pointer2)
            return pointer1 < pointer2
        end
    )
end

function BattleHandlerGen5:_tryToFetchBattleData()
    local firstPlayerPartyPID = Memory.read_u32_le(self.memoryAddresses.playerBase)
    local firstPlayerPID = Memory.read_u32_le(self.memoryAddresses.playerBattleBase)
    local firstEnemyPID = Memory.read_u32_le(self.memoryAddresses.enemyBase)
    self._playerPartyPointers = {}
    if firstPlayerPID == 0 or firstEnemyPID == 0 or firstPlayerPID ~= firstPlayerPartyPID then
        return false
    end
    self:_readAmountOfBattlers()
    local currentBattleDataPtr = self.memoryAddresses.mainBattleDataPtr
    if self._battlerAmount == 2 then
        local doubleTriple = Memory.read_u8(self.memoryAddresses.doubleTripleFlag)
        local activeSlots = self.DOUBLE_TRIPLE_FLAG_TO_BATTLER_AMOUNT[doubleTriple] or 1
        self:_readBattleDataPtr(currentBattleDataPtr, activeSlots, false, 4, self.memoryAddresses.abilityTriggerStart)
        currentBattleDataPtr = self.memoryAddresses.mainBattleDataPtr + 0x1C
        self:_readBattleDataPtr(currentBattleDataPtr, activeSlots, true, 4, self.memoryAddresses.abilityTriggerStart + 4)
    elseif self._battlerAmount > 2 and self._battlerAmount <= 6 then
        --multi-player double, read only the first block as player and the rest as enemies
        --this way, if you have an ally you don't get revealed info about them
        self:_readBattleDataPtr(currentBattleDataPtr, 1, false, 0x1C, self.memoryAddresses.abilityTriggerStart)
        --little awkward here because memory is laid out as follows:
        --player (you), enemy 1, player ally 1, enemy 2, etc. with distance of 0x1C
        --don't want to read in this order because it's awkward for swapping, so we instead read all players then enemies by skipping
        local numEnemies = self._battlerAmount / 2
        local numAllies = numEnemies - 1
        local enemyStart = currentBattleDataPtr + 0x1C
        local allyStart = currentBattleDataPtr + (2 * 0x1C)
        self:_readBattleDataPtr(allyStart, numAllies, true, 2 * 0x1C, self.memoryAddresses.abilityTriggerStart + 0x08)
        self:_readBattleDataPtr(enemyStart, numEnemies, true, 2 * 0x1C, self.memoryAddresses.abilityTriggerStart + 0x04)
    else
        return false
    end
    self:addFrameCounter("checkAbilityTriggers", FrameCounter(30, self._checkAbilityTriggers, self))
    self:_readPlayerPartyPointers()
    return true
end

function BattleHandlerGen5:_readBattleStats(decryptedData, battleDataBase, isEnemy)
    decryptedData.curHP = Memory.read_u16_le(battleDataBase + self.BATTLE_STAT_OFFSETS["curHP"])
    decryptedData.HP = Memory.read_u16_le(battleDataBase + self.BATTLE_STAT_OFFSETS["totalHP"])
    if not isEnemy then
        decryptedData.level = Memory.read_u16_le(battleDataBase + self.BATTLE_STAT_OFFSETS["level"]) % 256
        local statStart = battleDataBase + self.BATTLE_STAT_OFFSETS["stats"]
        local stats = {"ATK", "DEF", "SPA", "SPD", "SPE"}
        for i = 0, 4, 1 do
            local stat = stats[i + 1]
            decryptedData[stat] = Memory.read_u16_le(statStart + i * 2)
        end
    end
    local statusStart = battleDataBase + self.BATTLE_STAT_OFFSETS["status"]
    for i = 1, #MiscData.STATUS_TO_IMG_NAME + 1, 1 do
        local status = Memory.read_u32_le(statusStart)
        if status ~= 0 then
            decryptedData.status = i
        end
    end
    local movesStart = battleDataBase + self.BATTLE_STAT_OFFSETS["moves"]
    local moveIDs = {"move1", "move2", "move3", "move4"}
    local movePPs = {"move1PP", "move2PP", "move3PP", "move4PP"}
    for i = 0, 3, 1 do
        local currentMove = movesStart + i * 14
        local moveID = Memory.read_u16_le(currentMove)
        local movePP = Memory.read_u8(currentMove + 2)
        decryptedData[moveIDs[i + 1]] = moveID
        decryptedData[movePPs[i + 1]] = movePP
    end
    self.pokemonDataReader.setCurrentBase(battleDataBase + self.BATTLE_STAT_OFFSETS["statStages"])
    decryptedData.statStages = self.pokemonDataReader.readBattleStatStages()
end

function BattleHandlerGen5:_checkBattlerAbilityTriggered(battler, slotIndex, isEnemy)
    local pokemonData = battler.activePokemon
    if battler.activePokemon == nil then
        return
    end
    local triggerAddress = battler.abilityTriggerAddress
    local abilityTrigger = memory.read_u16_le(triggerAddress)
    if abilityTrigger == battler.lastAbilityValue or abilityTrigger == 0 then
        return
    end
    if abilityTrigger == pokemonData.ability then
        self:_trackAbility(pokemonData.pokemonID, abilityTrigger)
    end
    local traceTriggered = pokemonData.ability == 36 and pokemonData.ability ~= abilityTrigger
    if traceTriggered and not isEnemy then
        local sources = 0
        local mons = self:getAllPokemonInBattle()
        if mons == nil or next(mons) == nil then
            return
        end
        local sourceMon = nil
        for _, mon in pairs(mons) do
            if mon.isEnemy and mon.ability == abilityTrigger then
                sources = sources + 1
                sourceMon = mon
            end
        end
        if sources == 1 and sourceMon ~= nil then
            self:_trackAbility(sourceMon.pokemonID, abilityTrigger)
        end
    end
    battler.lastAbilityValue = abilityTrigger
end

function BattleHandlerGen5._checkAbilityTriggers(self)
    local battleData = self:getBattleData()
    for key, battlerData in pairs(battleData) do
        for slotIndex, battler in pairs(battlerData.slots) do
            local isEnemy = (key == "enemy")
            self:_checkBattlerAbilityTriggered(battler, slotIndex, isEnemy)
        end
    end
end

--overriding base class function
function BattleHandlerGen5:_hasPartyWiped()
    for _, pointer in pairs(self._playerPartyPointers) do
        local pokemonData = {}
        self:_readBattleStats(pokemonData, pointer, false)
        if not pokemonData["curHP"] then
            return false
        end
        if pokemonData["curHP"] > 0 then
            return false
        end
    end
    return true
end

--overriding base class function
function BattleHandlerGen5:_playerSlotHasFainted(slotIndex)
    if self._playerPartyPointers == nil or next(self._playerPartyPointers) == nil then
        return false
    end
    local battlePointer = self._playerPartyPointers[slotIndex + 1]
    if battlePointer == nil then
        return false
    end
    local pokemonData = {}
    self:_readBattleStats(pokemonData, battlePointer, false)
    if not pokemonData["curHP"] then
        return false
    end
    return pokemonData["curHP"] == 0
end

function BattleHandlerGen5:_getPokemonData(battleData, slotIndex, isEnemy)
    if not self:inBattleAndFetched() then
        return
    end
    local battlers = battleData.slots
    local battler = battlers[slotIndex]
    local battleDataBase = Memory.read_pointer(battler.battleDataPtr)
    local pokemonDataBase = Memory.read_pointer(battleDataBase)
    local illusionedMonPointer = battleDataBase + 0x04
    if Memory.read_u32_le(illusionedMonPointer) ~= 0 and isEnemy then
        pokemonDataBase = Memory.read_pointer(illusionedMonPointer)
    end
    self.pokemonDataReader.setCurrentBase(pokemonDataBase)
    local data = self.pokemonDataReader.decryptPokemonInfo(false, 1, isEnemy)
    if data == nil or next(data) == nil then
        return
    end
    self:_readBattleStats(data, battleDataBase, battleData.isEnemy)
    self._program.checkForAlternateForm(data)
    local different = (battler.lastPointerValue == nil) or (battleDataBase ~= battler.lastPointerValue)
    if different and isEnemy then
        self:_logNewEnemy(data)
        if battler.lastValidPokemon ~= nil then
            self._tracker.updateLastLevelSeen(battler.lastValidPokemon.pokemonID, battler.lastValidPokemon.level)
        end
        battler.lastValidPokemon = data
    end
    battler.lastPointerValue = battleDataBase
    return data
end

function BattleHandlerGen5:_isTransformed()
    --TODO: not needed seemingly?
    return false
end

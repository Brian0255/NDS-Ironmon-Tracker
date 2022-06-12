Decrypter = {
    pokemonDataSize = 0,
    startAddress = 0
}

Decrypter.BLOCK_SHUFFLE_ORDER = {
    "ABCD",
    "ABDC",
    "ACBD",
    "ACDB",
    "ADBC",
    "ADCB",
    "BACD",
    "BADC",
    "BCAD",
    "BCDA",
    "BDAC",
    "BDCA",
    "CABD",
    "CADB",
    "CBAD",
    "CBDA",
    "CDAB",
    "CDBA",
    "DABC",
    "DACB",
    "DBAC",
    "DBCA",
    "DCAB",
    "DCBA"
}

Decrypter.DecryptedDataInit = {
    pokemonID = 0,
    trainerID = 0,
    heldItem = 0,
    friendship = 0,
    ability = 0,
    move1 = 0,
    move2 = 0,
    move3 = 0,
    move4 = 0,
    move1PP = 0,
    move2PP = 0,
    move3PP = 0,
    move4PP = 0,
    status = 0,
    level = 0,
    curHP = 0,
    maxHP = 0,
    atk = 0,
    def = 0,
    spe = 0,
    spa = 0,
    spd = 0,
    nature = 0,
    encounterType = 0,
    actualMoves = {
        0,0,0,0
    },
    movePPs = {
        "","","",""
    }
}

Decrypter.DecryptedData = {}

--[[
To cut down on memory read calls, we should only do it when we need to for this 128 byte set of encrypted blocks.
Reading these 128 byte structures could get super costly, so I think we should note the important values here and what blocks they're in.
Offsets to read must be even (since the RNG is advanced every 2 bytes of encrypted data).

Format: 
{offsetFromBlock, {byte1Data,byte2Data}}
or
{offsetFromBlock, {2ByteData}}
--]]

Decrypter.GEN_4_5_IMPORTANT_BLOCK_DATA = {
    A = {
            {0,{"pokemonID"}},
            {2,{"heldItem"}},
            {4,{"trainerID"}},
            {12, { "friendship","ability"  }}
    
    },
    B = {
            {0 , {"move1"}},
            {2 , {"move2"}},
            {4 , {"move3"}},
            {6 , {"move4"}},
            {8, { "move1PP","move2PP"  }},
            {10, { "move3PP","move4PP"  }},
    },
    C = {},
    D = {
            {28,{"unused","encounterType"}}
    }
}

Decrypter.GEN_4_5_BATTLE_STAT_OFFSETS = {
    {0, {"status","unused"}},
    {4,{"level","unused"}},
    {6,{"curHP"}},
    {8,{"maxHP"}},
    {10,{"atk"}},
    {12,{"def"}},
    {14,{"spe"}},
    {16,{"spa"}},
    {18,{"spd"}},
}

Decrypter.GEN_4_5_BLOCK_TOTAL = 4
Decrypter.GEN_4_5_BLOCK_TOTAL = 4
Decrypter.GEN_4_5_BLOCK_SIZE = 32
Decrypter.GEN_4_TOTAL_DATA_SIZE = 236
Decrypter.GEN_5_TOTAL_DATA_SIZE = 220

--Each battle mon's hp/maxHP in gen 5 are separated by 548 bytes.
Decrypter.GEN_5_BATTLE_HP_OFFSET = 548

function Decrypter.init()
    local gen = GameSettings.gen
    Decrypter.pokemonDataSize = Utils.inlineIf(gen == 4,Decrypter.GEN_4_TOTAL_DATA_SIZE,Decrypter.GEN_5_TOTAL_DATA_SIZE)
end

function Decrypter.decrypt(checkingParty,monIndex)
    Decrypter.DecryptedData = {}
    local currentBase = Decrypter.currentBase
    --Find the first mon that hasn't fainted.
    for i = 1,6,1 do
        local pid = memory.read_u32_le(currentBase)
        local checksum = memory.read_u16_le(currentBase+0x06)
        if checksum ~= 0 then
            Decrypter.DecryptedData.nature = (pid % 25)
            local blockShift = bit.rshift(bit.band(pid, 0x3E000),0xD) % 24
            local blockOrder = Decrypter.BLOCK_SHUFFLE_ORDER[blockShift+1]
            local blockReadingStart = currentBase+0x08
            local seed = checksum
            Decrypter.decryptBlocks(seed,blockReadingStart,blockOrder)
            local battleStatStart = currentBase+0x88
            Decrypter.decryptBattleStats(pid,battleStatStart,monIndex)
            Decrypter.DecryptedData.actualMoves = {
                Decrypter.DecryptedData.move1,
                Decrypter.DecryptedData.move2,
                Decrypter.DecryptedData.move3,
                Decrypter.DecryptedData.move4,
            }
            Decrypter.DecryptedData.movePPs = {
                Decrypter.DecryptedData.move1PP,
                Decrypter.DecryptedData.move2PP,
                Decrypter.DecryptedData.move3PP,
                Decrypter.DecryptedData.move4PP,
            }
            if checkingParty then 
                if Decrypter.DecryptedData.curHP ~= 0 then
                     return Decrypter.DecryptedData
                end
            else
                break
            end
            currentBase = currentBase + Decrypter.pokemonDataSize
        else
            break
        end
    end

    return Decrypter.DecryptedData
end

function Decrypter.decryptBlocks(seed,blockReadingStart,blockOrder)
    for i = 0, Decrypter.GEN_4_5_BLOCK_TOTAL-1, 1 do
        local currentBlockStart = blockReadingStart + (Decrypter.GEN_4_5_BLOCK_SIZE*i)
        local totalBytesAdvanced = 0
        local currentBlockLetter = string.sub(blockOrder,i+1,i+1)
        local offsets = Decrypter.GEN_4_5_IMPORTANT_BLOCK_DATA[currentBlockLetter]
        local previousOffset = 0
        seed = Decrypter.advanceRNG(seed)
        totalBytesAdvanced = totalBytesAdvanced + 2
        if offsets ~= nil then
            for _,offsetData in ipairs(offsets) do
                local offsetAmount = offsetData[1]
                local difference = offsetAmount - previousOffset
                seed = Decrypter.advanceRNGByDifference(seed,difference)
                totalBytesAdvanced = totalBytesAdvanced + difference
                Decrypter.decryptWord(seed,offsetData,currentBlockStart)
                previousOffset = offsetAmount
            end
        end
        local remainder = Decrypter.GEN_4_5_BLOCK_SIZE - totalBytesAdvanced
        for i = 2, remainder, 2 do
            seed = Decrypter.advanceRNG(seed)
        end
    end
    return seed
end

function Decrypter.decryptBattleStats(pid,battleStatStart,monIndex)
    local offsets = Decrypter.GEN_4_5_BATTLE_STAT_OFFSETS
    local previousOffset = 0
    local seed = pid
    seed = Decrypter.advanceRNG(seed)
    if offsets ~= nil then
        for _,offsetData in ipairs(offsets) do
            local offsetAmount = offsetData[1]
            local difference = offsetAmount - previousOffset
            seed = Decrypter.advanceRNGByDifference(seed,difference)
            Decrypter.decryptWord(seed,offsetData,battleStatStart)
            previousOffset = offsetAmount
        end
    end
    --Gen 5 does not update the current HP in the player's battle party. It's stored elsewhere as unencrypted data.
    if Tracker.Data.inBattle == 1 and GameSettings.gen == 5 then
        Decrypter.DecryptedData.curHP = memory.read_u16_le(GameSettings.curHPBattlePlayer+monIndex*548)
        Decrypter.DecryptedData.maxHP = memory.read_u16_le(GameSettings.maxHPBattlePlayer+monIndex*548)
    end
end

function Decrypter.decryptWord(seed,offsetData,address)
    local offsetAmount = offsetData[1]  
    local dataName = offsetData[2]
    local combineBytes = (#dataName == 1)
    local encryptedWord = memory.read_u16_le(address+offsetAmount)
    local encryptedByte1 = bit.band(encryptedWord,0xFF)
    local encryptedByte2 = bit.band(bit.rshift(encryptedWord,8),0xFF)

    local shift16 = bit.rshift(seed,16)
    local shift24 = bit.rshift(seed,24)

    local byte1Data = bit.bxor(encryptedByte1,bit.band(shift16,0xFF))
    byte1Data = bit.band(byte1Data,0xFF)

    local byte2Data = bit.bxor(encryptedByte2,bit.band(shift24,0xFF))
    byte2Data = bit.band(byte2Data,0xFF)

    if combineBytes then
        local combinedBytes = bit.band(byte2Data,0x00FF)
        combinedBytes = bit.lshift(combinedBytes,8)
        local combinedBytes = bit.bor(combinedBytes,byte1Data)
        Decrypter.DecryptedData[dataName[1]] = combinedBytes
    else
        Decrypter.DecryptedData[dataName[1]] = byte1Data
        Decrypter.DecryptedData[dataName[2]] = byte2Data
    end
end

function Decrypter.advanceRNGByDifference(seed,difference)
    for i = 1, difference, 2 do
        --Need to recursively advance the seed RNG.
        seed = Decrypter.advanceRNG(seed)
    end
    return seed
end

function Decrypter.advanceRNG(seed)
    return Decrypter.mult32(seed,0x41C64E6D) + 0x00006073
end


--This function was taken from https://github.com/Killklli/PokemonBWAutoPokedex/blob/master/PokemonBWOverlay/process_ram.lua.
--I honestly don't really know what this is doing.
--I'm also not sure why it's necessary to do this to the seed value after advancing the RNG, but it doesn't work otherwise for decryption.
function Decrypter.mult32(num1,num2)
    local num1Shift = bit.rshift(num1,16)
    local remainderNum1 = num1 % 0x10000

    local num2Shift = bit.rshift(num2,16)
    local remainderNum2 = num2 % 0x10000

    local remainderBoth = ( num1Shift * remainderNum2 + remainderNum1 * num2Shift) % 0x10000
    local remainderProduct = remainderNum1 * remainderNum2 
    local result = remainderBoth * 0x10000 + remainderProduct
    return result
end

function Decrypter.find4ByteValueAddr(base,searchFor,limit)
    local currentBase = base
    while currentBase < 0x27C400 do
        local value = memory.read_u32_le(currentBase)
        if  value == searchFor then
            return currentBase
        end
        currentBase = currentBase + 0x04
    end
    return -1
end

function Decrypter.readBattleStatStages()

    local statStages = {}

    local first4Bytes = memory.read_u32_le(Decrypter.currentBase)
    local last4Bytes = memory.read_u32_le(Decrypter.currentBase+4)
    local HP = 6
    local ATK = 6
    local DEF = 6
    local SPE = 6
    local SPA = 6
    local SPD = 6
    local ACC = 6
    local EVA = 6

    if GameSettings.gen ==  4 then
        --format(gen 4):
        --HP, ATK, DEF, SPEED, SPATK, SPDEF, ACC, EVASION, 
        HP = bit.band(first4Bytes,0xFF)
        ATK = bit.band(bit.rshift(first4Bytes,8),0xFF)
        DEF = bit.band(bit.rshift(first4Bytes,16),0xFF)
        SPE = bit.band(bit.rshift(first4Bytes,24),0xFF)

        SPA = bit.band(last4Bytes,0xFF)
        SPD = bit.band(bit.rshift(last4Bytes,8),0xFF)
        ACC = bit.band(bit.rshift(last4Bytes,16),0xFF)
        EVA = bit.band(bit.rshift(last4Bytes,24),0xFF)
    end
    --[[elseif GameSettings.gen == 5 then
        ATK = bit.band(first4Bytes,0xFF)
        DEF = bit.band(bit.rshift(first4Bytes,8),0xFF)
        SPA = bit.band(bit.rshift(first4Bytes,16),0xFF)
        SPD = bit.band(bit.rshift(first4Bytes,24),0xFF)

        SPE = bit.band(last4Bytes,0xFF)
        ACC = bit.band(bit.rshift(last4Bytes,8),0xFF)
        EVA = bit.band(bit.rshift(last4Bytes,16),0xFF)
        HP = 6
    end--]]

    statStages = {
        ["HP"] = HP,
        ["ATK"] = ATK,
        ["DEF"] = DEF,
        ["SPE"] = SPE,
        ["SPA"] = SPA,
        ["SPD"] = SPD,
        ["ACC"] = ACC,
        ["EVA"] = EVA
    }

   --[[ if GameSettings.gen == 5 then
        statStages = {
            ["ATK"] = ATK,
            ["DEF"] = DEF,
            ["SPE"] = SPE,
            ["SPA"] = SPA,
            ["SPD"] = SPD,
            ["ACC"] = ACC,
            ["EVA"] = EVA
        }
    end--]]

    local validStats = true
    local all0 = true

    --Make sure all are in range.
    for i,stat in pairs(statStages) do
        if stat < 0 or stat > 12 then
            validStats = false
        else
            if stat ~= 0 then all0 = false end
        end
    end

    if not validStats or all0 then
        for i, stat in pairs(statStages) do
            statStages[i] = 6
        end
    end

    return statStages
end






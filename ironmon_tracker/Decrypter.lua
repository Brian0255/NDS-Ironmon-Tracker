Decrypter = {}

--[[
    For Gen 4+, documentation on Pokemon data encryption can be found here:
    https://projectpokemon.org/home/docs/gen-4/pkm-structure-r65/
]]

Decrypter.BLOCK_A_SHUFFLE_ORDER = {1,1,1,1,1,1,2,2,3,4,3,4,2,2,3,4,3,4,2,2,3,4,3,4}
Decrypter.BLOCK_B_SHUFFLE_ORDER = {2,2,3,4,3,4,1,1,1,1,1,1,3,4,2,2,4,3,3,4,2,2,4,3}
Decrypter.BLOCK_C_SHUFFLE_ORDER = {3,4,2,2,4,3,3,4,2,2,4,3,1,1,1,1,1,1,4,3,4,3,2,2}
Decrypter.BLOCK_D_SHUFFLE_ORDER = {4,3,4,3,2,2,4,3,4,3,2,2,4,3,4,3,2,2,1,1,1,1,1,1}

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

Decrypter.GEN_4_BLOCK_SIZE = 32

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
    moves = {
        move1 = 0,
        move2 = 0,
        move3 = 0,
        move4 = 0
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
[offsetFromBlockStart] = {
    byte1Data, byte2Data
}
or
[offsetFromBlockStart] = {
    2ByteData
}
--]]

Decrypter.GEN_4_IMPORTANT_BLOCK_DATA = {
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

Decrypter.GEN_4_BATTLE_STAT_OFFSETS = {
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


Decrypter.GEN_4_BLOCK_TOTAL = 4

--[[
function Decrypter.unshuffleBlocks(blocks, shiftValue)
    local correctedBlocks = {}

    local ABlockPosition = Decrypter.BLOCK_A_SHUFFLE_ORDER[shiftValue+1]
    local BBlockPosition = Decrypter.BLOCK_B_SHUFFLE_ORDER[shiftValue+1]
    local CBlockPosition = Decrypter.BLOCK_C_SHUFFLE_ORDER[shiftValue+1]
    local DBlockPosition = Decrypter.BLOCK_D_SHUFFLE_ORDER[shiftValue+1]

    table.insert(correctedBlocks,blocks[ABlockPosition])
    table.insert(correctedBlocks,blocks[BBlockPosition])
    table.insert(correctedBlocks,blocks[CBlockPosition])
    table.insert(correctedBlocks,blocks[DBlockPosition])

    return correctedBlocks
end--]]

function Decrypter.rand(seed)
    return (0x41C64E6D * seed) + 0x00006073
end

function Decrypter.decrypt(base,checkingParty)
    Decrypter.DecryptedData = {}
    local trainerID = memory.read_u16_le(GameSettings.trainerID)
	local memdomain = "Main RAM"
    memory.usememorydomain(memdomain)
    local currentBase = base
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
            Decrypter.decryptBattleStats(pid,battleStatStart)
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
                     break
                end
            else
                break
            end
            currentBase = currentBase + 236
        else
            break
        end
    end
    return Decrypter.DecryptedData
end

function Decrypter.decryptBlocks(seed,blockReadingStart,blockOrder)
    for i = 0, Decrypter.GEN_4_BLOCK_TOTAL-1, 1 do
        local currentBlockStart = blockReadingStart + (Decrypter.GEN_4_BLOCK_SIZE*i)
        local totalBytesAdvanced = 0
        local currentBlockLetter = string.sub(blockOrder,i+1,i+1)
        local offsets = Decrypter.GEN_4_IMPORTANT_BLOCK_DATA[currentBlockLetter]
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
        local remainder = Decrypter.GEN_4_BLOCK_SIZE - totalBytesAdvanced
        for i = 2, remainder, 2 do
            seed = Decrypter.advanceRNG(seed)
        end
    end
    return seed
end

function Decrypter.decryptBattleStats(pid,battleStatStart)
    local offsets = Decrypter.GEN_4_BATTLE_STAT_OFFSETS
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







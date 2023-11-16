--[[
global pointer = 0xBA8
0x27C288 - HG/SS
function GameSettings.setAsHeartGoldSoulSilver()
	GameSettings.playerBase = 0x27C330
	GameSettings.playerBattleBase = 0x2CAD20
	GameSettings.enemyBase = 0x2CB2F0
	GameSettings.playerBattleMonPID = 0x2C6104
	GameSettings.enemyBattleMonPID = 0x2C61C4
	GameSettings.battleStatus = 0x246F48
	GameSettings.itemStartNoBattle = 0x27CDFC
	GameSettings.itemStartBattle = 0x2C2D60
	GameSettings.statStagesPlayer = 0x2C60B4
	GameSettings.statStagesEnemy = 0x2C6174
end
--]]
--TO-DO: add gen 4 repel steps addresses and also test B/W
MemoryAddresses = {}

MemoryAddresses.NDS_CONSTANTS = {
    CARTRIDGE_HEADER = 0x3FFE00
}

MemoryAddresses[GameInfo.VERSION_NUMBER.HEART_GOLD] = {
    GLOBAL_POINTER = 0xBA8,
    VERSION_POINTER_OFFSET = 0x20,
    VERSION_POINTER_OFFSETS = {
        childMapHeader = 0x25FE4,
        parentMapHeader = 0x25FE4,
        enemyTrainerID = 0x440AA,
        playerBase = 0xA8,
        playerBattleBase = 0x4EA98,
        enemyBase = 0x4F068,
        playerBattleMonPID = 0x49E7C,
        enemyBattleMonPID = 0x49F3C,
        itemStartNoBattle = 0xB74,
        itemStartBattle = 0x46AD8,
        statStagesPlayer = 0x49E2C,
        statStagesEnemy = 0x49EEC,
        enemyPokemonID = 0x49ED4,
        berryBagStart = 0xC14,
        berryBagStartBattle = 0x46B78,
        johtoBadges = 0x8E,
        kantoBadges = 0x93,
        leagueBeaten = 0x1000,
        facingDirection = 0x25DA8,
        repelSteps = 0x6919
    },
    GLOBAL = {
        battleStatus = 0x246F48
    }
}

MemoryAddresses[GameInfo.VERSION_NUMBER.SOUL_SILVER] = {
    GLOBAL_POINTER = 0xBA8,
    VERSION_POINTER_OFFSET = 0x20,
    VERSION_POINTER_OFFSETS = {
        childMapHeader = 0x25FE4,
        parentMapHeader = 0x25FE4,
        enemyTrainerID = 0x440AA,
        playerBase = 0xA8,
        playerBattleBase = 0x4EA98,
        enemyBase = 0x4F068,
        playerBattleMonPID = 0x49E7C,
        enemyBattleMonPID = 0x49F3C,
        itemStartNoBattle = 0xB74,
        itemStartBattle = 0x46AD8,
        statStagesPlayer = 0x49E2C,
        statStagesEnemy = 0x49EEC,
        enemyPokemonID = 0x49ED4,
        berryBagStart = 0xC14,
        berryBagStartBattle = 0x46B78,
        johtoBadges = 0x8E,
        kantoBadges = 0x93,
        leagueBeaten = 0x1000,
        facingDirection = 0x25DA8,
        repelSteps = 0x6919
    },
    GLOBAL = {
        battleStatus = 0x246F48
    }
}

MemoryAddresses[GameInfo.VERSION_NUMBER.PLATINUM] = {
    GLOBAL_POINTER = 0xBA8,
    VERSION_POINTER_OFFSET = 0x20,
    VERSION_POINTER_OFFSETS = {
        childMapHeader = 0x239B0,
        parentMapHeader = 0x239B0,
        playerBase = 0xB4,
        playerBattleBase = 0x4B8AC,
        enemyTrainerID = 0x4189E,
        enemyBase = 0x4BE5C,
        playerBattleMonPID = 0x47620,
        enemyBattleMonPID = 0x476E0,
        itemStartNoBattle = 0xB60,
        itemStartBattle = 0x442BC,
        statStagesPlayer = 0x475D0,
        statStagesEnemy = 0x47690,
        enemyPokemonID = 0x47678,
        berryBagStart = 0xC00,
        berryBagStartBattle = 0x4435C,
        badges = 0x96,
        facingDirection = 0x238A4,
        repelSteps = 0x8087
    },
    GLOBAL = {
        battleStatus = 0x24A55A
    }
}

MemoryAddresses[GameInfo.VERSION_NUMBER.DIAMOND] = {
    GLOBAL_POINTER = 0xB70,
    VERSION_POINTER_OFFSET = 0x20,
    VERSION_POINTER_OFFSETS = {
        parentMapHeader = 0x144C,
        childMapHeader = 0x144C,
        enemyTrainerID = 0x42A8E,
        playerBase = 0x2AC,
        playerBattleBase = 0x4C7D8,
        enemyBase = 0x4CD88,
        playerBattleMonPID = 0x485E8,
        enemyBattleMonPID = 0x486A8,
        itemStartNoBattle = 0xD54,
        itemStartBattle = 0x4546C,
        statStagesPlayer = 0x48598,
        statStagesEnemy = 0x48658,
        enemyPokemonID = 0x48640,
        berryBagStart = 0xDF4,
        berryBagStartBattle = 0x4550C,
        badges = 0x292,
        repelSteps = 0x764C,
        facingDirection = 0x24A5C
    },
    GLOBAL = {
        battleStatus = 0x23BB38
    }
}

MemoryAddresses[GameInfo.VERSION_NUMBER.PEARL] = {
    GLOBAL_POINTER = 0xB70,
    VERSION_POINTER_OFFSET = 0x20,
    VERSION_POINTER_OFFSETS = {
        parentMapHeader = 0x144C,
        childMapHeader = 0x144C,
        enemyTrainerID = 0x42A8E,
        playerBase = 0x2AC,
        playerBattleBase = 0x4C7D8,
        enemyBase = 0x4CD88,
        playerBattleMonPID = 0x485E8,
        enemyBattleMonPID = 0x486A8,
        itemStartNoBattle = 0xD54,
        itemStartBattle = 0x4546C,
        statStagesPlayer = 0x48598,
        statStagesEnemy = 0x48658,
        enemyPokemonID = 0x48640,
        berryBagStart = 0xDF4,
        berryBagStartBattle = 0x4550C,
        badges = 0x292,
        repelSteps = 0x764C,
        facingDirection = 0x24A5C
    },
    GLOBAL = {
        battleStatus = 0x23BB38
    }
}

MemoryAddresses[GameInfo.VERSION_NUMBER.BLACK] = {
    GLOBAL = {
        childMapHeader = 0x2592B2,
        parentMapHeader = 0x2592B4,
        playerBase = 0x2349B4,
        playerBattleBase = 0x26A794,
        enemyTrainerID = 0x2697BE,
        enemyBase = 0x26B254,
        playerBattleMonPID = 0x2A7E14,
        enemyBattleMonPID = 0x2A7E70,
        battleStatus = 0x1D0798,
        itemStartNoBattle = 0x234784,
        itemStartBattle = 0x234784,
        statStagesStart = 0x26D7A0,
        statStagesEnemy = 0x26D9C4,
        HPBattlePlayer = 0x26D6B2,
        curHPBattlePlayer = 0x26D6B4,
        curBattleLevel = 0x26D6BC,
        curBattleStats = 0x26D792,
        totalMonsParty = 0x2349B0,
        berryBagStart = 0x234844,
        berryBagStartBattle = 0x234844,
        badges = 0x23CDB0,
        repelSteps = 0x23D6DD,
        facingDirection = 0x2521FC,
        mapNPCIDStart = 0x2521EC
    }
}

MemoryAddresses[GameInfo.VERSION_NUMBER.WHITE] = {
    GLOBAL = {
        childMapHeader = 0x2592B2 + 0x20,
        parentMapHeader = 0x2592B4 + 0x20,
        playerBase = 0x2349B4 + 0x20,
        playerBattleBase = 0x26A794 + 0x20,
        enemyTrainerID = 0x2697BE + 0x20,
        enemyBase = 0x26B254 + 0x20,
        playerBattleMonPID = 0x2A7E14 + 0x20,
        enemyBattleMonPID = 0x2A7E70 + 0x20,
        battleStatus = 0x1D0798 + 0x20,
        itemStartNoBattle = 0x234784 + 0x20,
        itemStartBattle = 0x234784 + 0x20,
        statStagesStart = 0x26D7A0 + 0x20,
        statStagesEnemy = 0x26D9C4 + 0x20,
        HPBattlePlayer = 0x26D6B2 + 0x20,
        curHPBattlePlayer = 0x26D6B4 + 0x20,
        curBattleLevel = 0x26D6BC + 0x20,
        curBattleStats = 0x26D792 + 0x20,
        totalMonsParty = 0x2349B0 + 0x20,
        berryBagStart = 0x234844 + 0x20,
        berryBagStartBattle = 0x234844 + 0x20,
        badges = 0x23CDB0 + 0x20,
        repelSteps = 0x23D6DD + 0x20,
        facingDirection = 0x2521FC + 0x20,
        mapNPCIDStart = 0x2521EC + 0x20
    }
}

MemoryAddresses[GameInfo.VERSION_NUMBER.BLACK2] = {
    GLOBAL = {
        parentMapHeader = 0x246848,
        childMapHeader = 0x246860,
        enemyTrainerID = 0x257332,
        playerBase = 0x21E42C,
        playerBattleBase = 0x258314,
        enemyBase = 0x258874,
        playerBattleMonPID = 0x2968D4,
        enemyBattleMonPID = 0x296930,
        battleStatus = 0x1B5138,
        itemStartNoBattle = 0x21E1FC,
        itemStartBattle = 0x21E1FC,
        statStagesStart = 0x25B320,
        HPBattlePlayer = 0x25B232,
        curHPBattlePlayer = 0x25B234,
        curBattleLevel = 0x25B23C,
        curBattleStats = 0x25B312,
        totalMonsParty = 0x21E428,
        berryBagStart = 0x21E2BC,
        berryBagStartBattle = 0x21E2BC,
        badges = 0x226728,
        repelSteps = 0x226F51,
        facingDirection = 0x23D9FC,
        mapNPCIDStart = 0x23D9EC
    }
}

MemoryAddresses[GameInfo.VERSION_NUMBER.WHITE2] = {
    GLOBAL = {
        parentMapHeader = 0x246848 + 0x80,
        childMapHeader = 0x246860 + 0x80,
        enemyTrainerID = 0x257332 + 0x80,
        playerBase = 0x21E42C + 0x80,
        playerBattleBase = 0x258314 + 0x80,
        enemyBase = 0x258874 + 0x80,
        playerBattleMonPID = 0x2968D4 + 0x80,
        enemyBattleMonPID = 0x296930 + 0x80,
        battleStatus = 0x1B5178,
        itemStartNoBattle = 0x21E1FC + 0x80,
        itemStartBattle = 0x21E1FC + 0x80,
        statStagesStart = 0x25B320 + 0x80,
        HPBattlePlayer = 0x25B232 + 0x80,
        curHPBattlePlayer = 0x25B234 + 0x80,
        curBattleLevel = 0x25B23C + 0x80,
        curBattleStats = 0x25B312 + 0x80,
        totalMonsParty = 0x21E428 + 0x80,
        berryBagStart = 0x21E2BC + 0x80,
        berryBagStartBattle = 0x21E2BC + 0x80,
        badges = 0x226728 + 0x80,
        repelSteps = 0x226F51 + 0x80,
        facingDirection = 0x23D9FC + 0x80,
        mapNPCIDStart = 0x23D9EC + 0x80
    }
}

--[[

function GameSettings.setAsPlatinum()
    GameSettings.playerBase = 0x27E24C
    GameSettings.playerBattleBase = 0x2C9A44
    GameSettings.enemyBase = 0x2C9FF4
    GameSettings.playerBattleMonPID = 0x2C57B8
    GameSettings.enemyBattleMonPID = 0x2C5878
    GameSettings.battleStatus = 0x24A55A
    GameSettings.itemStartNoBattle = 0x27ecf8
    GameSettings.itemStartBattle = 0x2C2454
    GameSettings.statStagesPlayer = 0x2C5768
    GameSettings.statStagesEnemy = 0x2C5828
end--]]

--[[
function GameSettings.setAsDiamondPearl()
    --26D300
    GameSettings.playerBase = 0x26D5AC
    GameSettings.playerBattleBase = 0x2B9AD8
    GameSettings.enemyBase = 0x2BA088
    GameSettings.playerBattleMonPID = 0x2B58E8
    GameSettings.enemyBattleMonPID = 0x2B59A8
    GameSettings.battleStatus = 0x23BB38
    GameSettings.itemStartNoBattle = 0x26E054
    GameSettings.itemStartBattle = 0x2B276C
    GameSettings.statStagesPlayer = 0x2B5898
    GameSettings.statStagesEnemy = 0x2B5958
end

function GameSettings.setAsBlack()
    GameSettings.playerBase = 0x2349B4
    GameSettings.playerBattleBase = 0x26A794
    GameSettings.enemyBase = 0x26B254
    GameSettings.playerBattleMonPID = 0x2a7e14
    GameSettings.enemyBattleMonPID = 0x2A7E14
    GameSettings.battleStatus = 0x1D0798
    GameSettings.itemStartNoBattle = 0x234784
    GameSettings.itemStartBattle = 0x234784
    GameSettings.statStagesStart = 0x26D7A0
    GameSettings.statStagesEnemy = 0x26D9C4
    GameSettings.maxHPBattlePlayer = 0x26D6B2
    GameSettings.curHPBattlePlayer = 0x26D6B4
    GameSettings.totalMonsParty = 0x2349B0
    GameSettings.berryBagStart = 0x234844
end

function GameSettings.setAsWhite()
    GameSettings.playerBase = 0x2349B4 + 0x20
    GameSettings.playerBattleBase = 0x26A794 + 0x20
    GameSettings.enemyBase = 0x26B254 + 0x20
    GameSettings.playerBattleMonPID = 0x2a7e14 + 0x20
    GameSettings.enemyBattleMonPID = 0x2A7E14 + 0x20
    GameSettings.battleStatus = 0x1D0798 + 0x20
    GameSettings.itemStartNoBattle = 0x234784 + 0x20
    GameSettings.itemStartBattle = 0x234784 + 0x20
    GameSettings.statStagesStart = 0x26D7A0 + 0x20
    GameSettings.statStagesEnemy = 0x26D9C4 + 0x20
    GameSettings.maxHPBattlePlayer = 0x26D6B2 + 0x20
    GameSettings.curHPBattlePlayer = 0x26D6B4 + 0x20
    GameSettings.totalMonsParty = 0x2349B0 + 0x20
    GameSettings.berryBagStart = 0x234844 + 0x20
end

function GameSettings.setAsBlack2()
    GameSettings.playerBase = 0x21E42C
    GameSettings.playerBattleBase = 0x258314
    GameSettings.enemyBase = 0x258874
    GameSettings.playerBattleMonPID = 0x2968D4
    GameSettings.enemyBattleMonPID = 0x2968D4
    GameSettings.battleStatus = 0x1B5138
    GameSettings.itemStartNoBattle = 0x21E1FC
    GameSettings.itemStartBattle = 0x21E1FC
    GameSettings.statStagesStart = 0x25B320
    GameSettings.maxHPBattlePlayer = 0x25B232
    GameSettings.curHPBattlePlayer = 0x25B234
    GameSettings.totalMonsParty = 0x21E428
    GameSettings.berryBagStart = 0x21E2BC
    --002E8688
end

function GameSettings.setAsWhite2()
    GameSettings.playerBase = 0x21E42C + 0x80
    GameSettings.playerBattleBase = 0x258314 + 0x80
    GameSettings.enemyBase = 0x258DD4 + 0x80
    GameSettings.playerBattleMonPID = 0x2968D4
    GameSettings.enemyBattleMonPID = 0x2968D4
    GameSettings.battleStatus = 0x1Bc9f2
    GameSettings.itemStartNoBattle = 0x21E1FC + 0x80
    GameSettings.itemStartBattle = 0x21E1FC + 0x80
    GameSettings.statStagesStart = 0x25B320 + 0x80
    GameSettings.maxHPBattlePlayer = 0x25B232 + 0x80
    GameSettings.curHPBattlePlayer = 0x25B234 + 0x80
    GameSettings.totalMonsParty = 0x21E428 + 0x80
    GameSettings.berryBagStart = 0x21E2BC + 0x80
end

--]]

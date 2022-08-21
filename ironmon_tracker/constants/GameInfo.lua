GameInfo = {}

GameInfo.VERSION_NUMBER = {
    DIAMOND = 0x45414441,
    PEARL = 0x45415041,
    PLATINUM = 0x45555043,
    HEART_GOLD = 0x454B5049,
    SOUL_SILVER = 0x45475049,
    BLACK = 0x4F425249,
    WHITE = 0x4F415249,
    BLACK2 = 0x4F455249,
    WHITE2 = 0x4F445249
}

GameInfo.GAME_INFO = {
    [GameInfo.VERSION_NUMBER.DIAMOND] = {
        GEN = 4,
        NAME = "Pokemon Diamond",
        BADGE_PREFIX = "DPPT",
        VERSION_GROUP = 8,
        ENCRYPTED_POKEMON_SIZE = 236
    },
    [GameInfo.VERSION_NUMBER.PEARL] = {
        GEN = 4,
        NAME = "Pokemon Pearl",
        BADGE_PREFIX = "DPPT",
        VERSION_GROUP = 8,
        ENCRYPTED_POKEMON_SIZE = 236
    },
    [GameInfo.VERSION_NUMBER.PLATINUM] = {
        GEN = 4,
        NAME = "Pokemon Platinum",
        BADGE_PREFIX = "DPPT",
        VERSION_GROUP = 9,
        ENCRYPTED_POKEMON_SIZE = 236
    },
    [GameInfo.VERSION_NUMBER.HEART_GOLD] = {
        GEN = 4,
        NAME = "Pokemon HeartGold",
        BADGE_PREFIX = "HGSS",
        VERSION_GROUP = 10,
        ENCRYPTED_POKEMON_SIZE = 236
    },
    [GameInfo.VERSION_NUMBER.SOUL_SILVER] = {
        GEN = 4,
        NAME = "Pokemon SoulSilver",
        BADGE_PREFIX = "HGSS",
        VERSION_GROUP = 10,
        ENCRYPTED_POKEMON_SIZE = 236
    },
    [GameInfo.VERSION_NUMBER.BLACK] = {
        GEN = 5,
        NAME = "Pokemon Black",
        BADGE_PREFIX = "BW",
        VERSION_GROUP = 11,
        ENCRYPTED_POKEMON_SIZE = 220
    },
    [GameInfo.VERSION_NUMBER.WHITE] = {
        GEN = 5,
        NAME = "Pokemon White",
        BADGE_PREFIX = "BW",
        VERSION_GROUP = 11,
        ENCRYPTED_POKEMON_SIZE = 220
    },
    [GameInfo.VERSION_NUMBER.BLACK2] = {
        GEN = 5,
        NAME = "Pokemon Black 2",
        BADGE_PREFIX = "BW2",
        VERSION_GROUP = 12,
        ENCRYPTED_POKEMON_SIZE = 220
    },
    [GameInfo.VERSION_NUMBER.WHITE2] = {
        GEN = 5,
        NAME = "Pokemon White 2",
        BADGE_PREFIX = "BW2",
        VERSION_GROUP = 12,
        ENCRYPTED_POKEMON_SIZE = 220
    }
}

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

local LocationData = {
    [GameInfo.VERSION_NUMBER.BLACK] = {
        [0] = {
            name = "Black City",
            encounterSlots = nil
        },
        [6] = {
            name = "Striaton City",
            encounterSlots = nil
        },
        [7] = {
            name = "the first gym",
            encountersSlots = nil
        },
        [16] = {
            name = "Nacrene City",
            encounterSlots = nil
        },
        [18] = {
            name = "the second gym",
            encounterSlots = nil
        },
        [19] = {
            name = "the second gym",
            encounterSlots = nil
        },
        [28] = {
            name = "Castelia City",
            encounterSlots = nil
        },
        [62] = {
            name = "Nimbasa City",
            encounterSlots = nil
        },
        [96] = {
            name = "Driftveil City",
            encounterSlots = nil
        },
        [107] = {
            name = "Mistralton City",
            encounterSlots = nil
        },
        [113] = {
            name = "Icirrus City",
            encounterSlots = nil
        },
        [120] = {
            name = "Opelucid City",
            encounterSlots = nil
        },
        [136] = {
            name = "Pok\233mon League",
            encounterSlots = nil
        },
        [147] = {
            name = "Unity Tower",
            encounterSlots = nil
        },
        [152] = {
            name = "Dreamyard",
            encounterSlots = nil
        },
        [154] = {
            name = "Pinwheel Forest Exterior",
            encounterSlots = nil
        },
        [155] = {
            name = "Pinwheel Forest Interior",
            encounterSlots = nil
        },
        [157] = {
            name = "Desert Resort",
            encounterSlots = nil
        },
        [160] = {
            name = "Relic Castle",
            encounterSlots = nil
        },
        [191] = {
            name = "Cold Storage",
            encounterSlots = nil
        },
        [194] = {
            name = "Chargestone Cave",
            encounterSlots = nil
        },
        [198] = {
            name = "Twist Mountain",
            encounterSlots = nil
        },
        [205] = {
            name = "Dragonspiral Tower",
            encounterSlots = nil
        },
        [214] = {
            name = "Victory Road",
            encounterSlots = nil
        },
        [230] = {
            name = "Giant Chasm",
            encounterSlots = nil
        },
        [235] = {
            name = "Liberty Garden",
            encounterSlots = nil
        },
        [238] = {
            name = "P2 Laboratory",
            encounterSlots = nil
        },
        [240] = {
            name = "Undella Bay",
            encounterSlots = nil
        },
        [241] = {
            name = "Abyssal Ruins",
            encounterSlots = nil
        },
        [249] = {
            name = "Skyarrow Bridge",
            encounterSlots = nil
        },
        [253] = {
            name = "Driftveil Drawbridge",
            encounterSlots = nil
        },
        [254] = {
            name = "Tubeline Bridge",
            encounterSlots = nil
        },
        [255] = {
            name = "Village Bridge",
            encounterSlots = nil
        },
        [263] = {
            name = "Marvelous Bridge",
            encounterSlots = nil
        },
        [264] = {
            name = "N's Castle",
            encounterSlots = nil
        },
        [279] = {
            name = "Entree Forest",
            encounterSlots = nil
        },
        [289] = {
            name = "Nimbasa City",
            encounterSlots = nil
        },
        [290] = {
            name = "Driftveil City",
            encounterSlots = nil
        },
        [291] = {
            name = "Mistralton City",
            encounterSlots = nil
        },
        [292] = {
            name = "Icirrus City",
            encounterSlots = nil
        },
        [293] = {
            name = "Opelucid City",
            encounterSlots = nil
        },
        [294] = {
            name = "Black City",
            encounterSlots = nil
        },
        [295] = {
            name = "White Forest",
            encounterSlots = nil
        },
        [296] = {
            name = "Cold Storage",
            encounterSlots = nil
        },
        [297] = {
            name = "Chargestone Cave",
            encounterSlots = nil
        },
        [298] = {
            name = "Twist Mountain",
            encounterSlots = nil
        },
        [299] = {
            name = "Dragonspiral Tower",
            encounterSlots = nil
        },
        [300] = {
            name = "Giant Chasm",
            encounterSlots = nil
        },
        [301] = {
            name = "Driftveil Drawbridge",
            encounterSlots = nil
        },
        [302] = {
            name = "Tubeline Bridge",
            encounterSlots = nil
        },
        [303] = {
            name = "Marvelous Bridge",
            encounterSlots = nil
        },
        [304] = {
            name = "Route 5",
            encounterSlots = nil
        },
        [305] = {
            name = "Route 6",
            encounterSlots = nil
        },
        [306] = {
            name = "Route 7",
            encounterSlots = nil
        },
        [307] = {
            name = "Route 8",
            encounterSlots = nil
        },
        [308] = {
            name = "Route 9",
            encounterSlots = nil
        },
        [309] = {
            name = "Route 11",
            encounterSlots = nil
        },
        [310] = {
            name = "Route 12",
            encounterSlots = nil
        },
        [311] = {
            name = "Route 13",
            encounterSlots = nil
        },
        [312] = {
            name = "Route 14",
            encounterSlots = nil
        },
        [313] = {
            name = "Route 15",
            encounterSlots = nil
        },
        [314] = {
            name = "Route 16",
            encounterSlots = nil
        },
        [315] = {
            name = "Lacunosa Town",
            encounterSlots = nil
        },
        [316] = {
            name = "Undella Town",
            encounterSlots = nil
        },
        [317] = {
            name = "Route 1",
            encounterSlots = nil
        },
        [319] = {
            name = "Route 2",
            encounterSlots = nil
        },
        [321] = {
            name = "Route 3",
            encounterSlots = nil
        },
        [324] = {
            name = "Wellspring Cave",
            encounterSlots = nil
        },
        [326] = {
            name = "Route 4",
            encounterSlots = nil
        },
        [329] = {
            name = "Route 5",
            encounterSlots = nil
        },
        [331] = {
            name = "Route 6",
            encounterSlots = nil
        },
        [333] = {
            name = "Mistralton Cave",
            encounterSlots = nil
        },
        [337] = {
            name = "Route 7",
            encounterSlots = nil
        },
        [338] = {
            name = "Celestial Tower",
            encounterSlots = nil
        },
        [345] = {
            name = "Route 8",
            encounterSlots = nil
        },
        [346] = {
            name = "Moor of Icirrus",
            encounterSlots = nil
        },
        [348] = {
            name = "Route 9",
            encounterSlots = nil
        },
        [352] = {
            name = "Challenger's Cave",
            encounterSlots = nil
        },
        [355] = {
            name = "Route 10",
            encounterSlots = nil
        },
        [365] = {
            name = "Route 11",
            encounterSlots = nil
        },
        [368] = {
            name = "Route 12",
            encounterSlots = nil
        },
        [370] = {
            name = "Route 13",
            encounterSlots = nil
        },
        [374] = {
            name = "Route 14",
            encounterSlots = nil
        },
        [376] = {
            name = "Abundant Shrine",
            encounterSlots = nil
        },
        [378] = {
            name = "Route 15",
            encounterSlots = nil
        },
        [381] = {
            name = "Pok\233 Transfer Lab",
            encounterSlots = nil
        },
        [383] = {
            name = "Route 16",
            encounterSlots = nil
        },
        [385] = {
            name = "Lostlorn Forest",
            encounterSlots = nil
        },
        [387] = {
            name = "Route 18",
            encounterSlots = nil
        },
        [389] = {
            name = "Nuvema Town",
            encounterSlots = nil
        },
        [397] = {
            name = "Accumula Town",
            encounterSlots = nil
        },
        [406] = {
            name = "Lacunosa Town",
            encounterSlots = nil
        },
        [412] = {
            name = "Undella Town",
            encounterSlots = nil
        },
        [418] = {
            name = "Anville Town",
            encounterSlots = nil
        },
        [423] = {
            name = "Route 17",
            encounterSlots = nil
        },
        [424] = {
            name = "White Forest",
            encounterSlots = nil
        },
    }
}


GameInfo.GAME_INFO = {
    [GameInfo.VERSION_NUMBER.DIAMOND] = {
        GEN = 4,
        NAME = "Pokemon Diamond",
        BADGE_PREFIX = "DPPT",
        VERSION_GROUP = 1,
        ENEMY_PARTY_OFFSET = 0xB60,
        ACTIVE_PID_DIFFERENCE=0x180,
        ENCRYPTED_POKEMON_SIZE = 236
    },
    [GameInfo.VERSION_NUMBER.PEARL] = {
        GEN = 4,
        NAME = "Pokemon Pearl",
        BADGE_PREFIX = "DPPT",
        VERSION_GROUP = 1,
        ENEMY_PARTY_OFFSET = 0xB60,
        ACTIVE_PID_DIFFERENCE=0x180,
        ENCRYPTED_POKEMON_SIZE = 236
    },
    [GameInfo.VERSION_NUMBER.PLATINUM] = {
        GEN = 4,
        NAME = "Pokemon Platinum",
        BADGE_PREFIX = "DPPT",
        VERSION_GROUP = 2,
        ENEMY_PARTY_OFFSET = 0xB60,
        ACTIVE_PID_DIFFERENCE=0x180,
        ENCRYPTED_POKEMON_SIZE = 236
    },
    [GameInfo.VERSION_NUMBER.HEART_GOLD] = {
        GEN = 4,
        NAME = "Pokemon HeartGold",
        BADGE_PREFIX = "HGSS",
        VERSION_GROUP = 3,
        ENEMY_PARTY_OFFSET = 0xBA0,
        ACTIVE_PID_DIFFERENCE=0x180,
        ENCRYPTED_POKEMON_SIZE = 236
    },
    [GameInfo.VERSION_NUMBER.SOUL_SILVER] = {
        GEN = 4,
        NAME = "Pokemon SoulSilver",
        BADGE_PREFIX = "HGSS",
        VERSION_GROUP = 3,
        ENEMY_PARTY_OFFSET = 0xBA0,
        ACTIVE_PID_DIFFERENCE=0x180,
        ENCRYPTED_POKEMON_SIZE = 236
    },
    [GameInfo.VERSION_NUMBER.BLACK] = {
        GEN = 5,
        NAME = "Pokemon Black",
        BADGE_PREFIX = "BW",
        VERSION_GROUP = 4,
        ENEMY_PARTY_OFFSET = 0xAC0,
        ACTIVE_PID_DIFFERENCE=0x5C,
        ENCRYPTED_POKEMON_SIZE = 220,
        LOCATION_DATA = LocationData[GameInfo.VERSION_NUMBER.BLACK]
    },
    [GameInfo.VERSION_NUMBER.WHITE] = {
        GEN = 5,
        NAME = "Pokemon White",
        BADGE_PREFIX = "BW",
        VERSION_GROUP = 4,
        ENEMY_PARTY_OFFSET = 0xAC0,
        ACTIVE_PID_DIFFERENCE=0x5C,
        ENCRYPTED_POKEMON_SIZE = 220
    },
    [GameInfo.VERSION_NUMBER.BLACK2] = {
        GEN = 5,
        NAME = "Pokemon Black 2",
        BADGE_PREFIX = "BW2",
        VERSION_GROUP = 5,
        ENEMY_PARTY_OFFSET = 0xAC0,
        ACTIVE_PID_DIFFERENCE=0x5C,
        ENCRYPTED_POKEMON_SIZE = 220
    },
    [GameInfo.VERSION_NUMBER.WHITE2] = {
        GEN = 5,
        NAME = "Pokemon White 2",
        BADGE_PREFIX = "BW2",
        VERSION_GROUP = 5,
        ENEMY_PARTY_OFFSET = 0xAC0,
        ACTIVE_PID_DIFFERENCE=0x5C,
        ENCRYPTED_POKEMON_SIZE = 220
    }
}

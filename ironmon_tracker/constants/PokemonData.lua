PokemonData = {}

PokemonData.TYPE_LIST = {
    "BUG",
    "DARK",
    "DRAGON",
    "ELECTRIC",
    "FIGHTING",
    "FIRE",
    "FLYING",
    "GHOST",
    "GRASS",
    "GROUND",
    "ICE",
    "POISON",
    "PSYCHIC",
    "ROCK",
    "STEEL",
    "WATER"
}

PokemonData.LAST_INDEX_GEN_4 = 494

-- Enumerated constants that defines the various types a Pokemon and its Moves are
PokemonData.POKEMON_TYPES =
    MiscUtils.readOnly(
    {
        NORMAL = "NORMAL",
        FIGHTING = "FIGHTING",
        FLYING = "FLYING",
        POISON = "POISON",
        GROUND = "GROUND",
        ROCK = "ROCK",
        BUG = "BUG",
        GHOST = "GHOST",
        STEEL = "STEEL",
        FIRE = "FIRE",
        WATER = "WATER",
        GRASS = "GRASS",
        ELECTRIC = "ELECTRIC",
        PSYCHIC = "PSYCHIC",
        ICE = "ICE",
        DRAGON = "DRAGON",
        DARK = "DARK",
        FAIRY = "FAIRY", -- Expect this to be unused in Gen 1-5
        UNKNOWN = "UNKNOWN", -- For the move "Curse" in Gen 2-4
        EMPTY = "" -- No second type for this Pokemon or an empty field
    }
)

-- Enumerated constants that defines various evolution possibilities
-- This enum does NOT include levels for evolution, only stones, friendship, no evolution, etc.

--max 7 characters
PokemonData.EVOLUTION_TYPES =
    MiscUtils.readOnly(
    {
        NONE = Graphics.TEXT.PLACEHOLDER, -- This Pokemon does not evolve.
        FRIEND = "FRIEND", -- High friendship
        VARIOUS = "VARIOUS", -- Various evolution stone items
        THUNDER = "THUNDR", -- Thunder stone item
        FIRE = "FIRE", -- Fire stone item
        WATER = "WATER", -- Water stone item
        MOON = "MOON", -- Moon stone item
        DAWN = "DAWN", -- Dawn stone item
        DUSK = "DUSK", -- Dusk stone item
        LEAF = "LEAF", -- Leaf stone item
        SUN = "SUN", -- Sun stone item
        OVAL = "OVAL", --Oval stone item
        LEAF_SUN = "LEAF/SUN", -- Leaf or Sun stone items
        PROTECTOR = "PROTCR", -- Protector held item
        ELECTIRIZER = "ELERZR", -- Elecirizer held item
        MAGMARIZER = "MAGMZR", -- Magmarizer held item
        SHINY_STONE = "SHNY ST", -- Magmarizer held item
        RAZOR_FANG = "RZ FNG", -- Razor Fang held item
        RAZOR_CLAW = "RZ CLW", -- Razor Claw held item
        DUBIOUS_DISC = "DUB DSC", -- Dubious Disc held item
        REAPER_CLOTH = "REA CLH", -- Reaper Cloth held item
        UPGRADE = "UPGDE", --Up-Grade held item
        DRAGON_SCALE = "DRG SCL", --Dragon Scale held item
        METAL_COAT = "MTL CT", --Metal Coat held item
        KINGS_ROCK = "KNG RCK", --King's Rock held item
        CLAMPERL = "DST/DSS",
        SNORUNT = {"42", "42/DWN"},
        KIRLIA = {"30/DWN", "30"},
        SLOWPOKE = "37/WTR",
        POLIWHIRL = "RCK/WTR",
        MANTYKE = "RMRAID",
        KARRABLAST = "SHLMT",
        SHELMET = "KRBLST",
        BURMY = "20 M/F",
        COMBEE = {Graphics.TEXT.PLACEHOLDER, "21 F"}
    }
)

PokemonData.EVO_LONGER_NAMES = {
    [PokemonData.EVOLUTION_TYPES.FRIEND] = {"High friendship"},
    [PokemonData.EVOLUTION_TYPES.VARIOUS] = {
        "Leaf stone",
        "Dawn stone",
        "Thunder stone",
        "Water stone",
        "Fire stone",
        "Sun stone",
        "Moon stone"
    },
    [PokemonData.EVOLUTION_TYPES.THUNDER] = {"Thunder stone"},
    [PokemonData.EVOLUTION_TYPES.FIRE] = {"Fire stone"},
    [PokemonData.EVOLUTION_TYPES.WATER] = {"Water stone"},
    [PokemonData.EVOLUTION_TYPES.MOON] = {"Moon stone"},
    [PokemonData.EVOLUTION_TYPES.DAWN] = {"Dawn stone"},
    [PokemonData.EVOLUTION_TYPES.DUSK] = {"Dusk stone"},
    [PokemonData.EVOLUTION_TYPES.LEAF] = {"Leaf stone"},
    [PokemonData.EVOLUTION_TYPES.SUN] = {"Sun stone"},
    [PokemonData.EVOLUTION_TYPES.OVAL] = {"Oval stone"},
    [PokemonData.EVOLUTION_TYPES.LEAF_SUN] = {"Leaf stone", "Sun stone"},
    [PokemonData.EVOLUTION_TYPES.PROTECTOR] = {"Protector"},
    [PokemonData.EVOLUTION_TYPES.ELECTIRIZER] = {"Electirizer"},
    [PokemonData.EVOLUTION_TYPES.MAGMARIZER] = {"Magmarizer"},
    [PokemonData.EVOLUTION_TYPES.SHINY_STONE] = {"Shiny stone"},
    [PokemonData.EVOLUTION_TYPES.RAZOR_FANG] = {"Razor Fang"},
    [PokemonData.EVOLUTION_TYPES.RAZOR_CLAW] = {"Razor Claw"},
    [PokemonData.EVOLUTION_TYPES.DUBIOUS_DISC] = {"Dubious Disc"},
    [PokemonData.EVOLUTION_TYPES.REAPER_CLOTH] = {"Reaper Cloth"},
    [PokemonData.EVOLUTION_TYPES.UPGRADE] = {"Up-Grade"},
    [PokemonData.EVOLUTION_TYPES.DRAGON_SCALE] = {"Dragon Scale"},
    [PokemonData.EVOLUTION_TYPES.METAL_COAT] = {"Metal Coat"},
    [PokemonData.EVOLUTION_TYPES.KINGS_ROCK] = {"King's Rock"},
    [PokemonData.EVOLUTION_TYPES.CLAMPERL] = {"DeepSeaTooth", "DeepSeaScale"},
    [PokemonData.EVOLUTION_TYPES.SNORUNT] = {"42", "Dawn stone, F"},
    [PokemonData.EVOLUTION_TYPES.KIRLIA] = {"30", "Dawn stone, M"},
    [PokemonData.EVOLUTION_TYPES.SLOWPOKE] = {"37", "King's Rock"},
    [PokemonData.EVOLUTION_TYPES.POLIWHIRL] = {"Water stone", "King's Rock"},
    [PokemonData.EVOLUTION_TYPES.MANTYKE] = {"Level w/ Remoraid"},
    [PokemonData.EVOLUTION_TYPES.KARRABLAST] = {"Level w/ Shelmet"},
    [PokemonData.EVOLUTION_TYPES.SHELMET] = {"Level w/ Karrablast"},
    [PokemonData.EVOLUTION_TYPES.BURMY] = {"Level 20, F", "Level 20, M"},
    [PokemonData.EVOLUTION_TYPES.COMBEE] = {"Level 21, F only"}
}

PokemonData.POKEMON = {
    {
        -- Empty entry for ID 0
        name = "---",
        type = {PokemonData.POKEMON_TYPES.EMPTY, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "---",
        movelvls = {
            {},
            {},
            {},
            {},
            {},
            {},
            {},
            {},
            {},
            {},
            {},
            {}
        },
        weight = 0.0
    },
    {
        name = "Bulbasaur",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.POISON},
        evolution = "16",
        bst = "318",
        movelvls = {
            {3, 7, 9, 13, 13, 15, 19, 21, 25, 27, 31, 33, 37},
            {3, 7, 9, 13, 13, 15, 19, 21, 25, 27, 31, 33, 37},
            {3, 7, 9, 13, 13, 15, 19, 21, 25, 27, 31, 33, 37},
            {3, 7, 9, 13, 13, 15, 19, 21, 25, 27, 31, 33, 37},
            {3, 7, 9, 13, 13, 15, 19, 21, 25, 27, 31, 33, 37}
        },
        weight = 6.9,
        theme = "9AE1D3 9AE1D3 37E889 D4979E FFFFFF 309481 76D7C4 309481 76D7C4 309481 76D7C4 FFC631 7DB6FF DBDBDB 0 1 1 0 0 1"
    },
    {
        name = "Ivysaur",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.POISON},
        evolution = "32",
        bst = "405",
        movelvls = {
            {3, 7, 9, 13, 13, 15, 20, 23, 28, 31, 36, 39, 44},
            {3, 7, 9, 13, 13, 15, 20, 23, 28, 31, 36, 39, 44},
            {3, 7, 9, 13, 13, 15, 20, 23, 28, 31, 36, 39, 44},
            {3, 7, 9, 13, 13, 15, 20, 23, 28, 31, 36, 39, 44},
            {3, 7, 9, 13, 13, 15, 20, 23, 28, 31, 36, 39, 44}
        },
        weight = 13.0,
        theme = "9AE1D3 9AE1D3 37E889 D4979E FFFFFF 309481 76D7C4 309481 76D7C4 309481 76D7C4 FFC631 7DB6FF DBDBDB 0 1 1 0 0 1"
    },
    {
        name = "Venusaur",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.POISON},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "525",
        movelvls = {
            {3, 7, 9, 13, 13, 15, 20, 23, 28, 31, 32, 39, 45, 53},
            {3, 7, 9, 13, 13, 15, 20, 23, 28, 31, 32, 39, 45, 53},
            {3, 7, 9, 13, 13, 15, 20, 23, 28, 31, 32, 39, 45, 53},
            {3, 7, 9, 13, 13, 15, 20, 23, 28, 31, 32, 39, 45, 53},
            {3, 7, 9, 13, 13, 15, 20, 23, 28, 31, 32, 39, 45, 53}
        },
        weight = 100.0,
        theme = "FFFFFF FFFFFF 6CFF5B FFC67D FAFF5B FFFFFF 9EDF88 0ABD69 01E5EC 00BFCF E9829E FFD430 006CF4 DBDBDB 0 1 1 0 0 1"
    },
    {
        name = "Charmander",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "16",
        bst = "309",
        movelvls = {
            {7, 10, 16, 19, 25, 28, 34, 37},
            {7, 10, 16, 19, 25, 28, 34, 37},
            {7, 10, 16, 19, 25, 28, 34, 37},
            {7, 10, 16, 19, 25, 28, 34, 37, 43, 46},
            {7, 10, 16, 19, 25, 28, 34, 37, 43, 46}
        },
        weight = 8.5,
        theme = "FFFFFF FFFFFF 5BE8FF FAFFA2 F6FF81 FFFFFF CE7107 F09028 CE7107 F09028 624BC8 D96400 0088F4 DBDBDB 0 1 1 0 0 1"
    },
    {
        name = "Charmeleon",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "36",
        bst = "405",
        movelvls = {
            {7, 10, 17, 21, 28, 32, 39, 43},
            {7, 10, 17, 21, 28, 32, 39, 43},
            {7, 10, 17, 21, 28, 32, 39, 43},
            {7, 10, 17, 21, 28, 32, 39, 43, 50, 54},
            {7, 10, 17, 21, 28, 32, 39, 43, 50, 54}
        },
        weight = 19.0,
        theme = "FFFFFF FFFFFF 5BE8FF FAFFA2 F6FF81 FFFFFF CE7107 F09028 CE7107 F09028 624BC8 D96400 0088F4 DBDBDB 0 1 1 0 0 1"
    },
    {
        name = "Charizard",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "534",
        movelvls = {
            {7, 10, 17, 21, 28, 32, 36, 42, 49, 59, 66},
            {7, 10, 17, 21, 28, 32, 36, 42, 49, 59, 66},
            {7, 10, 17, 21, 28, 32, 36, 42, 49, 59, 66},
            {7, 10, 17, 21, 28, 32, 36, 41, 47, 56, 62, 71, 77},
            {7, 10, 17, 21, 28, 32, 36, 41, 47, 56, 62, 71, 77}
        },
        weight = 90.5,
        theme = "FFFFFF FFFFFF 5BE8FF FAFFA2 F6FF81 FFFFFF CE7107 F09028 CE7107 F09028 624BC8 D96400 0088F4 DBDBDB 0 1 1 0 0 1"
    },
    {
        name = "Squirtle",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "16",
        bst = "314",
        movelvls = {
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40}
        },
        weight = 9.0,
        theme = "5D4E45 5D4E45 257BD9 8649AB 257BD9 F5F2ED 7B675B CCBAA1 7B675B CCBAA1 84ADD7 5D4E45 5D4E45 5D4E45 0 1 1 0 0 1"
    },
    {
        name = "Wartortle",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "36",
        bst = "405",
        movelvls = {
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 40, 44},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 40, 44, 48},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 40, 44, 48},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 40, 44, 48},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 40, 44, 48}
        },
        weight = 22.5,
        theme = "5D4E45 5D4E45 257BD9 8649AB 257BD9 F5F2ED 7B675B CCBAA1 7B675B CCBAA1 84ADD7 5D4E45 5D4E45 5D4E45 0 1 1 0 0 1"
    },
    {
        name = "Blastoise",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "530",
        movelvls = {
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 39, 46, 53},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 39, 46, 53, 60},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 39, 46, 53, 60},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 39, 46, 53, 60},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 39, 46, 53, 60}
        },
        weight = 85.5,
        theme = "5D4E45 5D4E45 257BD9 8649AB 257BD9 F5F2ED 7B675B CCBAA1 7B675B CCBAA1 84ADD7 5D4E45 5D4E45 5D4E45 0 1 1 0 0 1"
    },
    {
        name = "Caterpie",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "7",
        bst = "195",
        movelvls = {
            {},
            {15},
            {15},
            {15},
            {15}
        },
        weight = 2.9,
        theme = "313131 313131 00FE08 FFB195 A3FEFE 000000 FF9FC3 A094D0 FF9FC3 A094D0 BEB3BE FED116 1B55FE ECE8E5 0 1 1 1 0 1"
    },
    {
        name = "Metapod",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "10",
        bst = "205",
        movelvls = {
            {7},
            {7},
            {7},
            {7},
            {7}
        },
        weight = 9.9,
        theme = "313131 313131 00FE08 FFB195 A3FEFE 000000 FF9FC3 A094D0 FF9FC3 A094D0 BEB3BE FED116 1B55FE ECE8E5 0 1 1 1 0 1"
    },
    {
        name = "Butterfree",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "385",
        movelvls = {
            {10, 12, 12, 12, 16, 18, 22, 24, 28, 30, 34, 36, 40},
            {10, 12, 12, 12, 16, 18, 22, 24, 28, 30, 34, 36, 40},
            {10, 12, 12, 12, 16, 18, 22, 24, 28, 30, 34, 36, 40},
            {10, 12, 12, 12, 16, 18, 22, 24, 28, 30, 34, 36, 40, 42, 46},
            {10, 12, 12, 12, 16, 18, 22, 24, 28, 30, 34, 36, 40, 42, 46}
        },
        weight = 32.0,
        theme = "313131 313131 00FE08 FFB195 A3FEFE 000000 FF9FC3 A094D0 FF9FC3 A094D0 BEB3BE FED116 1B55FE ECE8E5 0 1 1 1 0 1"
    },
    {
        name = "Weedle",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.POISON},
        evolution = "7",
        bst = "195",
        movelvls = {
            {},
            {15},
            {15},
            {15},
            {15}
        },
        weight = 3.2,
        theme = "FFFFFF FFFFFF 00DDFE FFB195 FCFF6B FFFFFF FF78AF 2F2F2F FFE84F 2F2F2F 000000 FED116 1A8AFF ECE8E5 1 1 0 1 0 1"
    },
    {
        name = "Kakuna",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.POISON},
        evolution = "10",
        bst = "205",
        movelvls = {
            {7},
            {7},
            {7},
            {7},
            {7}
        },
        weight = 10.0,
        theme = "FFFFFF FFFFFF 00DDFE FFB195 FCFF6B FFFFFF FF78AF 2F2F2F FFE84F 2F2F2F 000000 FED116 1A8AFF ECE8E5 1 1 0 1 0 1"
    },
    {
        name = "Beedrill",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.POISON},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "385",
        movelvls = {
            {10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40},
            {10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40},
            {10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40},
            {10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40},
            {10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40}
        },
        weight = 29.5,
        theme = "FFFFFF FFFFFF 00DDFE FFB195 FCFF6B FFFFFF FF78AF 2F2F2F FFE84F 2F2F2F 000000 FED116 1A8AFF ECE8E5 1 1 0 1 0 1"
    },
    {
        name = "Pidgey",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = "18",
        bst = "251",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53}
        },
        weight = 1.8,
        theme = "000000 000000 009DC5 FF6500 DE6546 000000 B59099 F1E6BA B59099 F1E6BA BD985F 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Pidgeotto",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = "36",
        bst = "349",
        movelvls = {
            {5, 9, 13, 17, 22, 27, 32, 37, 42, 47, 52, 57},
            {5, 9, 13, 17, 22, 27, 32, 37, 42, 47, 52, 57},
            {5, 9, 13, 17, 22, 27, 32, 37, 42, 47, 52, 57},
            {5, 9, 13, 17, 22, 27, 32, 37, 42, 47, 52, 57, 62},
            {5, 9, 13, 17, 22, 27, 32, 37, 42, 47, 52, 57, 62}
        },
        weight = 30.0,
        theme = "000000 000000 009DC5 FF6500 DE6546 000000 B59099 F1E6BA B59099 F1E6BA BD985F 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Pidgeot",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "469",
        movelvls = {
            {5, 9, 13, 17, 22, 27, 32, 38, 44, 50, 56, 62},
            {5, 9, 13, 17, 22, 27, 32, 38, 44, 50, 56, 62},
            {5, 9, 13, 17, 22, 27, 32, 38, 44, 50, 56, 62},
            {5, 9, 13, 17, 22, 27, 32, 38, 44, 50, 56, 62, 68},
            {5, 9, 13, 17, 22, 27, 32, 38, 44, 50, 56, 62, 68}
        },
        weight = 39.5,
        theme = "000000 000000 009DC5 FF6500 DE6546 000000 B59099 F1E6BA B59099 F1E6BA BD985F 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Rattata",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "20",
        bst = "253",
        movelvls = {
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34}
        },
        weight = 3.5,
        theme = "000000 000000 009DC5 FF6500 DE6546 000000 D1A07E FFF7B0 D1A07E FFF7B0 BF7700 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Raticate",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "413",
        movelvls = {
            {4, 7, 10, 13, 16, 19, 20, 24, 29, 34, 39, 44},
            {4, 7, 10, 13, 16, 19, 20, 24, 29, 34, 39, 44},
            {4, 7, 10, 13, 16, 19, 20, 24, 29, 34, 39, 44},
            {4, 7, 10, 13, 16, 19, 20, 24, 29, 34, 39, 44},
            {4, 7, 10, 13, 16, 19, 20, 24, 29, 34, 39, 44}
        },
        weight = 18.5,
        theme = "000000 000000 009DC5 FF6500 DE6546 000000 D1A07E FFF7B0 D1A07E FFF7B0 BF7700 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Spearow",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = "20",
        bst = "262",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37},
            {5, 9, 13, 17, 21, 25, 29, 33, 37},
            {5, 9, 13, 17, 21, 25, 29, 33, 37},
            {5, 9, 13, 17, 21, 25, 29, 33, 37},
            {5, 9, 13, 17, 21, 25, 29, 33, 37}
        },
        weight = 2.0,
        theme = "000000 000000 0076D5 BB0600 FDFF00 E2DBC9 FACCC2 EC9B4B FACCC2 EC9B4B AA614A 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Fearow",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "442",
        movelvls = {
            {5, 9, 13, 17, 23, 29, 35, 41, 47},
            {5, 9, 13, 17, 23, 29, 35, 41, 47},
            {5, 9, 13, 17, 23, 29, 35, 41, 47},
            {5, 9, 13, 17, 23, 29, 35, 41, 47, 53},
            {5, 9, 13, 17, 23, 29, 35, 41, 47, 53}
        },
        weight = 38.0,
        theme = "000000 000000 0076D5 BB0600 FDFF00 E2DBC9 FACCC2 EC9B4B FACCC2 EC9B4B AA614A 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Ekans",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "22",
        bst = "288",
        movelvls = {
            {4, 9, 12, 17, 20, 25, 25, 25, 28, 33, 36, 41},
            {4, 9, 12, 17, 20, 25, 25, 25, 28, 33, 36, 41},
            {4, 9, 12, 17, 20, 25, 25, 25, 28, 33, 36, 41},
            {4, 9, 12, 17, 20, 25, 25, 25, 28, 33, 36, 41, 44, 49},
            {4, 9, 12, 17, 20, 25, 25, 25, 28, 33, 36, 41, 44, 49}
        },
        weight = 6.9,
        theme = "E6E0ED E6E0ED 8ED5FF FECE50 F0F028 DB7264 606058 9078C8 606058 9078C8 413C43 E6E0ED E6E0ED E6E0ED 0 1 1 0 0 1"
    },
    {
        name = "Arbok",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "438",
        movelvls = {
            {4, 9, 12, 17, 20, 22, 28, 28, 28, 34, 42, 48, 56},
            {4, 9, 12, 17, 20, 22, 28, 28, 28, 34, 42, 48, 56},
            {4, 9, 12, 17, 20, 22, 28, 28, 28, 34, 42, 48, 56},
            {4, 9, 12, 17, 20, 22, 27, 27, 27, 32, 39, 44, 51, 56, 63},
            {4, 9, 12, 17, 20, 22, 27, 27, 27, 32, 39, 44, 51, 56, 63}
        },
        weight = 65.0,
        theme = "E6E0ED E6E0ED 8ED5FF FECE50 F0F028 DB7264 606058 9078C8 606058 9078C8 413C43 E6E0ED E6E0ED E6E0ED 0 1 1 0 0 1"
    },
    {
        name = "Pikachu",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.THUNDER,
        bst = "300",
        movelvls = {
            {5, 10, 13, 18, 21, 26, 29, 34, 37, 42, 45},
            {5, 10, 13, 18, 21, 26, 29, 34, 37, 42, 45},
            {5, 10, 13, 18, 21, 26, 29, 34, 37, 42, 45},
            {5, 10, 13, 18, 21, 26, 29, 34, 37, 42, 45, 50},
            {5, 10, 13, 18, 21, 26, 29, 34, 37, 42, 45, 50}
        },
        weight = 6.0,
        theme = "000000 000000 0081E0 C13200 E2F800 EAA700 FFD600 F2A300 FFD600 F2A300 74532C 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Raichu",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "475",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = 30.0,
        theme = "000000 000000 0081E0 C13200 E2F800 EAA700 FFD600 F2A300 FFD600 F2A300 74532C 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Sandshrew",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "22",
        bst = "300",
        movelvls = {
            {3, 7, 9, 13, 15, 19, 21, 25, 27, 31, 33, 37},
            {3, 7, 9, 13, 15, 19, 21, 25, 27, 31, 33, 37},
            {3, 7, 9, 13, 15, 19, 21, 25, 27, 31, 33, 37},
            {3, 7, 9, 13, 15, 19, 21, 25, 27, 31, 33, 37},
            {3, 5, 7, 9, 11, 14, 17, 20, 23, 26, 30, 34, 38, 42, 46}
        },
        weight = 12.0,
        theme = "000000 000000 0081E0 C13200 956B00 EBC174 FEE94E F1CFA8 FEE94E F1CFA8 8D5711 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Sandslash",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "450",
        movelvls = {
            {3, 7, 9, 13, 15, 19, 21, 22, 28, 33, 40, 45, 52},
            {3, 7, 9, 13, 15, 19, 21, 22, 28, 33, 40, 45, 52},
            {3, 7, 9, 13, 15, 19, 21, 22, 28, 33, 40, 45, 52},
            {3, 7, 9, 13, 15, 19, 21, 22, 28, 33, 40, 45, 52},
            {3, 5, 7, 9, 11, 14, 17, 20, 22, 23, 26, 30, 34, 38, 42, 46}
        },
        weight = 29.5,
        theme = "000000 000000 0081E0 C13200 956B00 EBC174 FEE94E F1CFA8 FEE94E F1CFA8 8D5711 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Nidoran F",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "16",
        bst = "275",
        movelvls = {
            {7, 9, 13, 19, 21, 25, 31, 33, 37, 43, 45},
            {7, 9, 13, 19, 21, 25, 31, 33, 37, 43, 45},
            {7, 9, 13, 19, 21, 25, 31, 33, 37, 43, 45},
            {7, 9, 13, 19, 21, 25, 31, 33, 37, 43, 45},
            {7, 9, 13, 19, 21, 25, 31, 33, 37, 43, 45}
        },
        weight = 7.0,
        theme = "000000 000000 218700 C13200 995838 DDC895 43ACF5 86CAF9 CA8E38 E5C89E 5C4A1D 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Nidorina",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.MOON,
        bst = "365",
        movelvls = {
            {7, 9, 13, 20, 23, 28, 35, 38, 43, 50, 58},
            {7, 9, 13, 20, 23, 28, 35, 38, 43, 50, 58},
            {7, 9, 13, 20, 23, 28, 35, 38, 43, 50, 58},
            {7, 9, 13, 20, 23, 28, 35, 38, 43, 50, 58},
            {7, 9, 13, 20, 23, 28, 35, 38, 43, 50, 58}
        },
        weight = 20.0,
        theme = "000000 000000 218700 C13200 995838 DDC895 43ACF5 86CAF9 CA8E38 E5C89E 5C4A1D 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Nidoqueen",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.GROUND},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "495",
        movelvls = {
            {23, 43, 58},
            {23, 43, 58},
            {23, 43, 58},
            {23, 35, 43, 58},
            {23, 35, 43, 58}
        },
        weight = 60.0,
        theme = "000000 000000 218700 C13200 995838 DDC895 43ACF5 86CAF9 CA8E38 E5C89E 5C4A1D 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Nidoran M",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "16",
        bst = "273",
        movelvls = {
            {7, 9, 13, 19, 21, 25, 31, 33, 37, 43, 45},
            {7, 9, 13, 19, 21, 25, 31, 33, 37, 43, 45},
            {7, 9, 13, 19, 21, 25, 31, 33, 37, 43, 45},
            {7, 9, 13, 19, 21, 25, 31, 33, 37, 43, 45},
            {7, 9, 13, 19, 21, 25, 31, 33, 37, 43, 45}
        },
        weight = 9.0,
        theme = "000000 000000 0072D2 C13200 FFF71D DDC895 E8BCEF DF9BE1 E9EAEB BDC0C3 075368 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Nidorino",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.MOON,
        bst = "365",
        movelvls = {
            {7, 9, 13, 20, 23, 28, 35, 38, 43, 50, 58},
            {7, 9, 13, 20, 23, 28, 35, 38, 43, 50, 58},
            {7, 9, 13, 20, 23, 28, 35, 38, 43, 50, 58},
            {7, 9, 13, 20, 23, 28, 35, 38, 43, 50, 58},
            {7, 9, 13, 20, 23, 28, 35, 38, 43, 50, 58}
        },
        weight = 19.5,
        theme = "000000 000000 0072D2 C13200 FFF71D DDC895 E8BCEF DF9BE1 E9EAEB BDC0C3 075368 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Nidoking",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.GROUND},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "495",
        movelvls = {
            {23, 43, 58},
            {23, 43, 58},
            {23, 43, 58},
            {23, 35, 43, 58},
            {23, 35, 43, 58}
        },
        weight = 62.0,
        theme = "000000 000000 0072D2 C13200 FFF71D DDC895 E8BCEF DF9BE1 E9EAEB BDC0C3 075368 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Clefairy",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.MOON,
        bst = "323",
        movelvls = {
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46, 49, 52, 55},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46, 49, 52, 55, 58}
        },
        weight = 7.5,
        theme = "000000 000000 0072D2 C13200 CC789F E3CCD0 C996A5 FFC5BB C996A5 FFC5BB 895D5D 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Clefable",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "473",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = 40.0,
        theme = "000000 000000 0072D2 C13200 CC789F E3CCD0 C996A5 FFC5BB C996A5 FFC5BB 895D5D 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Vulpix",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.FIRE,
        bst = "299",
        movelvls = {
            {4, 7, 11, 14, 17, 21, 24, 27, 31, 34, 37, 41, 44, 47},
            {4, 7, 11, 14, 17, 21, 24, 27, 31, 34, 37, 41, 44, 47},
            {4, 7, 11, 14, 17, 21, 24, 27, 31, 34, 37, 41, 44, 47},
            {4, 7, 11, 14, 17, 21, 24, 27, 31, 34, 37, 41, 44, 47, 51, 54},
            {4, 7, 10, 12, 15, 18, 20, 23, 26, 28, 31, 34, 36, 39, 42, 44, 47, 50}
        },
        weight = 9.9,
        theme = "000000 000000 0072D2 C13200 8F9788 9E4834 E6A651 F4F4A0 E6A651 F4F4A0 E6A651 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Ninetales",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "505",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = 19.9,
        theme = "000000 000000 0072D2 C13200 8F9788 9E4834 E6A651 F4F4A0 E6A651 F4F4A0 E6A651 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Jigglypuff",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.MOON,
        bst = "270",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53}
        },
        weight = 5.5,
        theme = "000000 000000 0072D2 C13200 C17794 D6CED6 DBB0C1 FCD2DE DBB0C1 FCD2DE 075E6B 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Wigglytuff",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "425",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = 12.0,
        theme = "000000 000000 0072D2 C13200 C17794 D6CED6 DBB0C1 FCD2DE DBB0C1 FCD2DE 075E6B 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Zubat",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.FLYING},
        evolution = "22",
        bst = "245",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {4, 8, 12, 15, 19, 23, 26, 30, 34, 37, 41, 45}
        },
        weight = 7.5,
        theme = "FFFFFF FFFFFF A2DFFF FFA73F FEFB9C FEFB9C 9A57B3 D57FF5 9A57B3 D57FF5 396680 FFFFFF FFFFFF FFFFFF 0 1 1 0 0 1"
    },
    {
        name = "Golbat",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.FRIEND,
        baseFriendship = 70,
        bst = "455",
        movelvls = {
            {5, 9, 13, 17, 21, 27, 33, 39, 45, 51},
            {5, 9, 13, 17, 21, 27, 33, 39, 45, 51},
            {5, 9, 13, 17, 21, 27, 33, 39, 45, 51},
            {5, 9, 13, 17, 21, 27, 33, 39, 45, 51, 57},
            {4, 8, 12, 15, 19, 24, 28, 33, 38, 42, 47, 52}
        },
        weight = 55.0,
        theme = "FFFFFF FFFFFF A2DFFF FFA73F FEFB9C FEFB9C 9A57B3 D57FF5 9A57B3 D57FF5 396680 FFFFFF FFFFFF FFFFFF 0 1 1 0 0 1"
    },
    {
        name = "Oddish",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.POISON},
        evolution = "21",
        bst = "320",
        movelvls = {
            {5, 9, 13, 15, 17, 21, 25, 29, 33, 37, 41},
            {5, 9, 13, 15, 17, 21, 25, 29, 33, 37, 41},
            {5, 9, 13, 15, 17, 21, 25, 29, 33, 37, 41},
            {5, 9, 13, 15, 17, 21, 25, 29, 33, 37, 41},
            {5, 9, 13, 15, 17, 21, 25, 29, 33, 37, 41}
        },
        weight = 5.4,
        theme = "FFFFFF FFFFFF 65FF7E FFC43F FEFB9C FEFB9C B52028 EC5968 5B8BB5 73AEE4 3C6385 FFFFFF FFFFFF FFFFFF 0 1 1 0 0 1"
    },
    {
        name = "Gloom",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.POISON},
        evolution = PokemonData.EVOLUTION_TYPES.LEAF_SUN,
        bst = "395",
        movelvls = {
            {5, 9, 13, 15, 17, 23, 29, 35, 41, 47, 53},
            {5, 9, 13, 15, 17, 23, 29, 35, 41, 47, 53},
            {5, 9, 13, 15, 17, 23, 29, 35, 41, 47, 53},
            {5, 9, 13, 15, 17, 23, 29, 35, 41, 47, 53},
            {5, 9, 13, 15, 17, 23, 29, 35, 41, 47, 53}
        },
        weight = 8.6,
        theme = "FFFFFF FFFFFF 65FF7E FFC43F FEFB9C FEFB9C B52028 EC5968 5B8BB5 73AEE4 3C6385 FFFFFF FFFFFF FFFFFF 0 1 1 0 0 1"
    },
    {
        name = "Vileplume",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.POISON},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "480",
        movelvls = {
            {53, 65},
            {53, 65},
            {53, 65},
            {53, 65},
            {53, 65}
        },
        weight = 18.6,
        theme = "FFFFFF FFFFFF 65FF7E FFC43F FEFB9C FEFB9C B52028 EC5968 5B8BB5 73AEE4 3C6385 FFFFFF FFFFFF FFFFFF 0 1 1 0 0 1"
    },
    {
        name = "Paras",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.GRASS},
        evolution = "24",
        bst = "285",
        movelvls = {
            {6, 6, 11, 17, 22, 27, 33, 38, 43},
            {6, 6, 11, 17, 22, 27, 33, 38, 43},
            {6, 6, 11, 17, 22, 27, 33, 38, 43},
            {6, 6, 11, 17, 22, 27, 33, 38, 43, 49, 54},
            {6, 6, 11, 17, 22, 27, 33, 38, 43, 49, 54}
        },
        weight = 5.4,
        theme = "FFFFFF FFFFFF 65FF7E FFC43F FEFB9C FEFB9C CC0039 EC5968 FEB42F FE844B 000000 FFFFFF FFFFFF FFFFFF 0 1 1 0 0 1"
    },
    {
        name = "Parasect",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.GRASS},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "405",
        movelvls = {
            {6, 6, 11, 17, 22, 30, 39, 47, 55},
            {6, 6, 11, 17, 22, 30, 39, 47, 55},
            {6, 6, 11, 17, 22, 30, 39, 47, 55},
            {6, 6, 11, 17, 22, 29, 37, 44, 51, 59, 66},
            {6, 6, 11, 17, 22, 29, 37, 44, 51, 59, 66}
        },
        weight = 29.5,
        theme = "FFFFFF FFFFFF 65FF7E FFC43F FEFB9C FEFB9C CC0039 EC5968 FEB42F FE844B 000000 FFFFFF FFFFFF FFFFFF 0 1 1 0 0 1"
    },
    {
        name = "Venonat",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.POISON},
        evolution = "31",
        bst = "305",
        movelvls = {
            {5, 11, 13, 17, 23, 25, 29, 35, 37, 41, 47},
            {5, 11, 13, 17, 23, 25, 29, 35, 37, 41, 47},
            {5, 11, 13, 17, 23, 25, 29, 35, 37, 41, 47},
            {5, 11, 13, 17, 23, 25, 29, 35, 37, 41, 47},
            {5, 11, 13, 17, 23, 25, 29, 35, 37, 41, 47}
        },
        weight = 30.0,
        theme = "F0EDEE F0EDEE 64DEFF FFC43F FEFB9C CCF4FE E1CDD0 C69BC9 E1CDD0 C69BC9 69B1DF F0EDEE F0EDEE F0EDEE 0 1 1 0 0 1"
    },
    {
        name = "Venomoth",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.POISON},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "450",
        movelvls = {
            {5, 11, 13, 17, 23, 25, 29, 31, 37, 41, 47, 55, 59},
            {5, 11, 13, 17, 23, 25, 29, 31, 37, 41, 47, 55, 59},
            {5, 11, 13, 17, 23, 25, 29, 31, 37, 41, 47, 55, 59},
            {5, 11, 13, 17, 23, 25, 29, 31, 37, 41, 47, 55, 59, 63},
            {5, 11, 13, 17, 23, 25, 29, 31, 37, 41, 47, 55, 59, 63}
        },
        weight = 12.5,
        theme = "F0EDEE F0EDEE 64DEFF FFC43F FEFB9C CCF4FE E1CDD0 C69BC9 E1CDD0 C69BC9 69B1DF F0EDEE F0EDEE F0EDEE 0 1 1 0 0 1"
    },
    {
        name = "Diglett",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "26",
        bst = "265",
        movelvls = {
            {4, 7, 12, 15, 18, 23, 26, 29, 34, 37, 40},
            {4, 7, 12, 15, 18, 23, 26, 29, 34, 37, 40},
            {4, 7, 12, 15, 18, 23, 26, 29, 34, 37, 40},
            {4, 7, 12, 15, 18, 23, 26, 29, 34, 37, 40, 45},
            {4, 7, 12, 15, 18, 23, 26, 29, 34, 37, 40, 45}
        },
        weight = 0.8,
        theme = "000000 000000 0083CC D61F00 FEFB9C FFDDFC AF8674 DCAC91 AF8674 DCAC91 815F49 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Dugtrio",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "405",
        movelvls = {
            {4, 7, 12, 15, 18, 23, 26, 28, 33, 40, 45, 50},
            {4, 7, 12, 15, 18, 23, 26, 28, 33, 40, 45, 50},
            {4, 7, 12, 15, 18, 23, 26, 28, 33, 40, 45, 50},
            {4, 7, 12, 15, 18, 23, 26, 28, 33, 40, 45, 50, 57},
            {4, 7, 12, 15, 18, 23, 26, 28, 33, 40, 45, 50, 57}
        },
        weight = 33.3,
        theme = "000000 000000 0083CC D61F00 FEFB9C FFDDFC AF8674 DCAC91 AF8674 DCAC91 815F49 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Meowth",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "28",
        bst = "290",
        movelvls = {
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49, 54},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49, 54},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49, 54},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49, 54}
        },
        weight = 4.2,
        theme = "000000 000000 0076D5 BB0600 CD000F EEDCCC BC8B5A FEFF99 BC8B5A FEFF99 BC8B5A 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Persian",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "440",
        movelvls = {
            {6, 9, 14, 17, 22, 25, 32, 37, 44, 49, 56, 61},
            {6, 9, 14, 17, 22, 25, 32, 37, 44, 49, 56, 61, 68},
            {6, 9, 14, 17, 22, 25, 32, 37, 44, 49, 56, 61, 68},
            {6, 9, 14, 17, 22, 25, 32, 37, 44, 49, 56, 61, 68},
            {6, 9, 14, 17, 22, 25, 28, 32, 37, 44, 49, 56, 61, 68}
        },
        weight = 32.0,
        theme = "000000 000000 0076D5 BB0600 CD000F EEDCCC BC8B5A FEFF99 BC8B5A FEFF99 BC8B5A 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Psyduck",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "33",
        bst = "320",
        movelvls = {
            {5, 9, 14, 18, 22, 27, 31, 35, 40, 44, 48},
            {5, 9, 14, 18, 22, 27, 31, 35, 40, 44, 48},
            {5, 9, 14, 18, 22, 27, 31, 35, 40, 44, 48},
            {5, 9, 14, 18, 22, 27, 31, 35, 40, 44, 48, 53, 57},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46, 50}
        },
        weight = 19.6,
        theme = "000000 000000 1C9436 BB0600 D90400 C3DDF6 72A1DA 8BC5FF E4C416 FFFFA2 2D6EA8 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Golduck",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "500",
        movelvls = {
            {5, 9, 14, 18, 22, 27, 31, 37, 44, 50, 56},
            {5, 9, 14, 18, 22, 27, 31, 37, 44, 50, 56},
            {5, 9, 14, 18, 22, 27, 31, 37, 44, 50, 56},
            {5, 9, 14, 18, 22, 27, 31, 37, 44, 50, 56, 63, 69},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 38, 43, 49, 54, 60}
        },
        weight = 76.6,
        theme = "000000 000000 1C9436 BB0600 D90400 C3DDF6 72A1DA 8BC5FF E4C416 FFFFA2 2D6EA8 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Mankey",
        type = {PokemonData.POKEMON_TYPES.FIGHTING, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "28",
        bst = "305",
        movelvls = {
            {9, 13, 17, 21, 25, 33, 37, 41, 45, 49},
            {9, 13, 17, 21, 25, 33, 37, 41, 45, 49},
            {9, 13, 17, 21, 25, 33, 37, 41, 45, 49},
            {9, 13, 17, 21, 25, 33, 37, 41, 45, 49, 53},
            {9, 13, 17, 21, 25, 33, 37, 41, 45, 49, 53}
        },
        weight = 28.0,
        theme = "000000 000000 0095C5 BB0600 E783A1 ECE5DB F9CAD6 FFF3E4 F9CAD6 FFF3E4 9B6A39 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Primeape",
        type = {PokemonData.POKEMON_TYPES.FIGHTING, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "455",
        movelvls = {
            {9, 13, 17, 21, 25, 28, 35, 41, 47, 53, 59},
            {9, 13, 17, 21, 25, 28, 35, 41, 47, 53, 59},
            {9, 13, 17, 21, 25, 28, 35, 41, 47, 53, 59},
            {9, 13, 17, 21, 25, 28, 35, 41, 47, 53, 59, 63},
            {9, 13, 17, 21, 25, 28, 35, 41, 47, 53, 59, 63}
        },
        weight = 32.0,
        theme = "000000 000000 0095C5 BB0600 E783A1 ECE5DB F9CAD6 FFF3E4 F9CAD6 FFF3E4 9B6A39 000000 000000 000000 0 1 1 0 0 1"
    },
    {
        name = "Growlithe",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.FIRE,
        bst = "350",
        movelvls = {
            {6, 9, 14, 17, 20, 25, 28, 31, 34, 39, 42, 45, 48},
            {6, 9, 14, 17, 20, 25, 28, 31, 34, 39, 42, 45, 48},
            {6, 9, 14, 17, 20, 25, 28, 31, 34, 39, 42, 45, 48},
            {6, 9, 14, 17, 20, 25, 28, 31, 34, 39, 42, 45, 48, 51, 56},
            {6, 8, 10, 12, 17, 19, 21, 23, 28, 30, 32, 34, 39, 41, 43, 45}
        },
        weight = 19.0
    },
    {
        name = "Arcanine",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "555",
        movelvls = {
            {39},
            {39},
            {39},
            {39},
            {34}
        },
        weight = 155.0
    },
    {
        name = "Poliwag",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "25",
        bst = "300",
        movelvls = {
            {5, 8, 11, 15, 18, 21, 25, 28, 31, 35, 38, 41},
            {5, 8, 11, 15, 18, 21, 25, 28, 31, 35, 38, 41},
            {5, 8, 11, 15, 18, 21, 25, 28, 31, 35, 38, 41},
            {5, 8, 11, 15, 18, 21, 25, 28, 31, 35, 38, 41},
            {5, 8, 11, 15, 18, 21, 25, 28, 31, 35, 38, 41}
        },
        weight = 12.4
    },
    {
        name = "Poliwhirl",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.POLIWHIRL,
        bst = "385",
        movelvls = {
            {5, 8, 11, 15, 18, 21, 27, 32, 37, 43, 48, 53},
            {5, 8, 11, 15, 18, 21, 27, 32, 37, 43, 48, 53},
            {5, 8, 11, 15, 18, 21, 27, 32, 37, 43, 48, 53},
            {5, 8, 11, 15, 18, 21, 27, 32, 37, 43, 48, 53},
            {5, 8, 11, 15, 18, 21, 27, 32, 37, 43, 48, 53}
        },
        weight = 20.0
    },
    {
        name = "Poliwrath",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.FIGHTING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "500",
        movelvls = {
            {43, 53},
            {43, 53},
            {43, 53},
            {32, 43, 53},
            {32, 43, 53}
        },
        weight = 54.0
    },
    {
        name = "Abra",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "16",
        bst = "310",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = 19.5
    },
    {
        name = "Kadabra",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "37", -- Level 37 replaces trade evolution
        bst = "400",
        movelvls = {
            {16, 18, 22, 24, 28, 30, 34, 36, 40, 42, 46},
            {16, 18, 22, 24, 28, 30, 34, 36, 40, 42, 46},
            {16, 18, 22, 24, 28, 30, 34, 36, 40, 42, 46},
            {16, 18, 22, 24, 28, 30, 34, 36, 40, 42, 46, 48, 52},
            {16, 18, 22, 24, 28, 30, 34, 36, 40, 42, 46, 48, 52}
        },
        weight = 56.5
    },
    {
        name = "Alakazam",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "490",
        movelvls = {
            {16, 18, 22, 24, 28, 30, 34, 36, 40, 42, 46},
            {16, 18, 22, 24, 28, 30, 34, 36, 40, 42, 46},
            {16, 18, 22, 24, 28, 30, 34, 36, 40, 42, 46},
            {16, 18, 22, 24, 28, 30, 34, 36, 40, 42, 46, 48, 52},
            {16, 18, 22, 24, 28, 30, 34, 36, 40, 42, 46, 48, 52}
        },
        weight = 48.0
    },
    {
        name = "Machop",
        type = {PokemonData.POKEMON_TYPES.FIGHTING, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "28",
        bst = "305",
        movelvls = {
            {7, 10, 13, 19, 22, 25, 31, 34, 37, 43, 46},
            {7, 10, 13, 19, 22, 25, 31, 34, 37, 43, 46},
            {7, 10, 13, 19, 22, 25, 31, 34, 37, 43, 46},
            {7, 10, 13, 19, 22, 25, 31, 34, 37, 43, 46, 49},
            {7, 10, 13, 19, 22, 25, 31, 34, 37, 43, 46, 49}
        },
        weight = 19.5
    },
    {
        name = "Machoke",
        type = {PokemonData.POKEMON_TYPES.FIGHTING, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "37", -- Level 37 replaces trade evolution
        bst = "405",
        movelvls = {
            {7, 10, 13, 19, 22, 25, 32, 36, 40, 44, 51},
            {7, 10, 13, 19, 22, 25, 32, 36, 40, 44, 51},
            {7, 10, 13, 19, 22, 25, 32, 36, 40, 44, 51},
            {7, 10, 13, 19, 22, 25, 32, 36, 40, 44, 51, 55},
            {7, 10, 13, 19, 22, 25, 32, 36, 40, 44, 51, 55}
        },
        weight = 70.5
    },
    {
        name = "Machamp",
        type = {PokemonData.POKEMON_TYPES.FIGHTING, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "505",
        movelvls = {
            {7, 10, 13, 19, 22, 25, 32, 36, 40, 44, 51},
            {7, 10, 13, 19, 22, 25, 32, 36, 40, 44, 51},
            {7, 10, 13, 19, 22, 25, 32, 36, 40, 44, 51},
            {7, 10, 13, 19, 22, 25, 32, 36, 40, 44, 51, 55},
            {7, 10, 13, 19, 22, 25, 32, 36, 40, 44, 51, 55}
        },
        weight = 130.0
    },
    {
        name = "Bellsprout",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.POISON},
        evolution = "21",
        bst = "300",
        movelvls = {
            {7, 11, 13, 15, 17, 23, 27, 29, 35, 39, 41, 47},
            {7, 11, 13, 15, 17, 23, 27, 29, 35, 39, 41, 47},
            {7, 11, 13, 15, 17, 23, 27, 29, 35, 39, 41, 47},
            {7, 11, 13, 15, 17, 23, 27, 29, 35, 39, 41, 47},
            {7, 11, 13, 15, 17, 23, 27, 29, 35, 39, 41, 47}
        },
        weight = 4.0
    },
    {
        name = "Weepinbell",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.POISON},
        evolution = PokemonData.EVOLUTION_TYPES.LEAF,
        bst = "390",
        movelvls = {
            {7, 11, 13, 15, 17, 23, 27, 29, 35, 39, 41, 47},
            {7, 11, 13, 15, 17, 23, 27, 29, 35, 39, 41, 47},
            {7, 11, 13, 15, 17, 23, 27, 29, 35, 39, 41, 47},
            {7, 11, 13, 15, 17, 23, 27, 29, 35, 39, 41, 47},
            {7, 11, 13, 15, 17, 23, 27, 29, 35, 39, 41, 47}
        },
        weight = 6.4
    },
    {
        name = "Victreebel",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.POISON},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "480",
        movelvls = {
            {47},
            {47, 47},
            {47, 47},
            {27, 47, 47},
            {27, 47, 47}
        },
        weight = 15.5
    },
    {
        name = "Tentacool",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.POISON},
        evolution = "30",
        bst = "335",
        movelvls = {
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43, 47, 50, 54},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43, 47, 50, 54}
        },
        weight = 45.5
    },
    {
        name = "Tentacruel",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.POISON},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "515",
        movelvls = {
            {5, 8, 12, 15, 19, 22, 26, 29, 36, 42, 49, 55},
            {5, 8, 12, 15, 19, 22, 26, 29, 36, 42, 49, 55},
            {5, 8, 12, 15, 19, 22, 26, 29, 36, 42, 49, 55},
            {5, 8, 12, 15, 19, 22, 26, 29, 34, 38, 43, 47, 52, 56, 61},
            {5, 8, 12, 15, 19, 22, 26, 29, 34, 38, 43, 47, 52, 56, 61}
        },
        weight = 55.0
    },
    {
        name = "Geodude",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.GROUND},
        evolution = "25",
        bst = "300",
        movelvls = {
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46, 50},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46, 50}
        },
        weight = 20.0
    },
    {
        name = "Graveler",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.GROUND},
        evolution = "37", -- Level 37 replaces trade evolution
        bst = "390",
        movelvls = {
            {4, 8, 11, 15, 18, 22, 27, 33, 38, 44, 49},
            {4, 8, 11, 15, 18, 22, 27, 33, 38, 44, 49},
            {4, 8, 11, 15, 18, 22, 27, 33, 38, 44, 49},
            {4, 8, 11, 15, 18, 22, 27, 31, 36, 42, 47, 53, 58, 64},
            {4, 8, 11, 15, 18, 22, 27, 31, 36, 42, 47, 53, 58, 64}
        },
        weight = 105.0
    },
    {
        name = "Golem",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.GROUND},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "485",
        movelvls = {
            {4, 8, 11, 15, 18, 22, 27, 33, 38, 44, 49},
            {4, 8, 11, 15, 18, 22, 27, 33, 38, 44, 49},
            {4, 8, 11, 15, 18, 22, 27, 33, 38, 44, 49},
            {4, 8, 11, 15, 18, 22, 27, 31, 36, 42, 47, 53, 58, 64, 69},
            {4, 8, 11, 15, 18, 22, 27, 31, 36, 42, 47, 53, 58, 64, 69}
        },
        weight = 300.0
    },
    {
        name = "Ponyta",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "40",
        bst = "410",
        movelvls = {
            {7, 10, 16, 19, 25, 28, 34, 38, 44, 48},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46},
            {4, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49},
            {4, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49}
        },
        weight = 30.0
    },
    {
        name = "Rapidash",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "500",
        movelvls = {
            {7, 10, 16, 19, 25, 28, 34, 38, 40, 49, 58},
            {6, 10, 15, 19, 24, 28, 33, 37, 40, 47, 56},
            {6, 10, 15, 19, 24, 28, 33, 37, 40, 47, 56},
            {4, 9, 13, 17, 21, 25, 29, 33, 37, 40, 41, 45, 49},
            {4, 9, 13, 17, 21, 25, 29, 33, 37, 40, 41, 45, 49}
        },
        weight = 95.0
    },
    {
        name = "Slowpoke",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = PokemonData.EVOLUTION_TYPES.SLOWPOKE,
        bst = "315",
        movelvls = {
            {6, 11, 15, 20, 25, 29, 34, 39, 43, 48, 53, 57},
            {6, 11, 15, 20, 25, 29, 34, 39, 43, 48, 53, 57},
            {6, 11, 15, 20, 25, 29, 34, 39, 43, 48, 53, 57},
            {5, 9, 14, 19, 23, 28, 32, 36, 41, 45, 49, 54, 58},
            {5, 9, 14, 19, 23, 28, 32, 36, 41, 45, 49, 54, 58}
        },
        weight = 36.0
    },
    {
        name = "Slowbro",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "490",
        movelvls = {
            {6, 11, 15, 20, 25, 29, 34, 37, 41, 47, 54, 61, 67},
            {6, 11, 15, 20, 25, 29, 34, 37, 41, 47, 54, 61, 67},
            {6, 11, 15, 20, 25, 29, 34, 37, 41, 47, 54, 61, 67},
            {5, 9, 14, 19, 23, 28, 32, 36, 37, 43, 49, 55, 62, 68},
            {5, 9, 14, 19, 23, 28, 32, 36, 37, 43, 49, 55, 62, 68}
        },
        weight = 78.5
    },
    {
        name = "Magnemite",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.STEEL},
        evolution = "30",
        bst = "325",
        movelvls = {
            {6, 11, 14, 17, 22, 27, 30, 33, 38, 43, 46, 49, 54},
            {6, 11, 14, 17, 22, 27, 30, 33, 38, 43, 46, 49, 54},
            {6, 11, 14, 17, 22, 27, 30, 33, 38, 43, 46, 49, 54},
            {6, 11, 14, 17, 22, 27, 30, 33, 38, 43, 46, 49, 54, 59},
            {4, 7, 11, 15, 18, 21, 25, 29, 32, 35, 39, 43, 46, 49, 53, 57}
        },
        weight = 6.0
    },
    {
        name = "Magneton",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.STEEL},
        evolution = "40",
        bst = "465",
        movelvls = {
            {6, 11, 14, 17, 22, 27, 30, 34, 40, 46, 50, 54, 60},
            {6, 11, 14, 17, 22, 27, 30, 34, 40, 46, 50, 54, 60},
            {6, 11, 14, 17, 22, 27, 30, 34, 40, 46, 50, 54, 60},
            {6, 11, 14, 17, 22, 27, 30, 34, 40, 46, 50, 54, 60, 66},
            {4, 7, 11, 15, 18, 21, 25, 29, 34, 39, 45, 51, 56, 62, 67, 73}
        },
        weight = 60.0
    },
    {
        name = "Farfetch'd",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "352",
        movelvls = {
            {7, 9, 13, 19, 21, 25, 31, 33, 37, 43},
            {7, 9, 13, 19, 21, 25, 31, 33, 37, 43, 45},
            {7, 9, 13, 19, 21, 25, 31, 33, 37, 43, 45},
            {7, 9, 13, 19, 21, 25, 31, 33, 37, 43, 45, 49, 55},
            {7, 9, 13, 19, 21, 25, 31, 33, 37, 43, 45, 49, 55}
        },
        weight = 15.0
    },
    {
        name = "Doduo",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = "31",
        bst = "310",
        movelvls = {
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50}
        },
        weight = 39.2
    },
    {
        name = "Dodrio",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "460",
        movelvls = {
            {5, 10, 14, 19, 23, 28, 34, 41, 47, 54},
            {5, 10, 14, 19, 23, 28, 34, 41, 47, 54},
            {5, 10, 14, 19, 23, 28, 34, 41, 47, 54},
            {5, 10, 14, 19, 23, 28, 34, 41, 47, 54, 60},
            {5, 10, 14, 19, 23, 28, 34, 41, 47, 54, 60}
        },
        weight = 85.2
    },
    {
        name = "Seel",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "34",
        bst = "325",
        movelvls = {
            {3, 7, 11, 13, 17, 21, 23, 27, 31, 33, 37, 41, 43, 47, 51},
            {3, 7, 11, 13, 17, 21, 23, 27, 31, 33, 37, 41, 43, 47, 51},
            {3, 7, 11, 13, 17, 21, 23, 27, 31, 33, 37, 41, 43, 47, 51},
            {3, 7, 11, 13, 17, 21, 23, 27, 31, 33, 37, 41, 43, 47, 51, 53},
            {3, 7, 11, 13, 17, 21, 23, 27, 31, 33, 37, 41, 43, 47, 51, 53}
        },
        weight = 90.0
    },
    {
        name = "Dewgong",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.ICE},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "475",
        movelvls = {
            {3, 7, 11, 13, 17, 21, 23, 27, 31, 33, 34, 37, 41, 43, 47, 51},
            {3, 7, 11, 13, 17, 21, 23, 27, 31, 33, 34, 37, 41, 43, 47, 51},
            {3, 7, 11, 13, 17, 21, 23, 27, 31, 33, 34, 37, 41, 43, 47, 51},
            {3, 7, 11, 13, 17, 21, 23, 27, 31, 33, 34, 39, 45, 49, 55, 61, 65},
            {3, 7, 11, 13, 17, 21, 23, 27, 31, 33, 34, 39, 45, 49, 55, 61, 65}
        },
        weight = 120.0
    },
    {
        name = "Grimer",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "38",
        bst = "325",
        movelvls = {
            {4, 7, 12, 17, 20, 23, 28, 33, 36, 39, 44, 49},
            {4, 7, 12, 17, 20, 23, 28, 33, 36, 39, 44, 49},
            {4, 7, 12, 17, 20, 23, 28, 33, 36, 39, 44, 49},
            {4, 7, 12, 17, 20, 23, 28, 33, 36, 39, 44, 49, 52},
            {4, 7, 12, 15, 18, 21, 26, 29, 32, 37, 40, 43, 48}
        },
        weight = 30.0
    },
    {
        name = "Muk", -- PUMP SLOP
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "500",
        movelvls = {
            {4, 7, 12, 17, 20, 23, 28, 33, 36, 44, 54, 65},
            {4, 7, 12, 17, 20, 23, 28, 33, 36, 44, 54, 65},
            {4, 7, 12, 17, 20, 23, 28, 33, 36, 44, 54, 65},
            {4, 7, 12, 17, 20, 23, 28, 33, 36, 42, 50, 58, 64},
            {4, 7, 12, 15, 18, 21, 26, 29, 32, 37, 43, 49, 57}
        },
        weight = 30.0
    },
    {
        name = "Shellder",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.WATER,
        bst = "305",
        movelvls = {
            {4, 8, 13, 16, 20, 25, 28, 32, 37, 40, 44, 49},
            {4, 8, 13, 16, 20, 25, 28, 32, 37, 40, 44, 49},
            {4, 8, 13, 16, 20, 25, 28, 32, 37, 40, 44, 49},
            {4, 8, 13, 16, 20, 25, 28, 32, 37, 40, 44, 49, 52, 56, 61},
            {4, 8, 13, 16, 20, 25, 28, 32, 37, 40, 44, 49, 52, 56, 61}
        },
        weight = 4.0
    },
    {
        name = "Cloyster",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.ICE},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "525",
        movelvls = {
            {28, 40},
            {28, 40},
            {28, 40},
            {13, 28, 52},
            {13, 28, 52}
        },
        weight = 132.5
    },
    {
        name = "Gastly",
        type = {PokemonData.POKEMON_TYPES.GHOST, PokemonData.POKEMON_TYPES.POISON},
        evolution = "25",
        bst = "310",
        movelvls = {
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43, 47},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43, 47}
        },
        weight = 0.1
    },
    {
        name = "Haunter",
        type = {PokemonData.POKEMON_TYPES.GHOST, PokemonData.POKEMON_TYPES.POISON},
        evolution = "37", -- Level 37 replaces trade evolution
        bst = "405",
        movelvls = {
            {5, 8, 12, 15, 19, 22, 25, 28, 33, 39, 44, 50, 55},
            {5, 8, 12, 15, 19, 22, 25, 28, 33, 39, 44, 50, 55},
            {5, 8, 12, 15, 19, 22, 25, 28, 33, 39, 44, 50, 55},
            {5, 8, 12, 15, 19, 22, 25, 28, 33, 39, 44, 50, 55, 61},
            {5, 8, 12, 15, 19, 22, 25, 28, 33, 39, 44, 50, 55, 61}
        },
        weight = 0.1
    },
    {
        name = "Gengar",
        type = {PokemonData.POKEMON_TYPES.GHOST, PokemonData.POKEMON_TYPES.POISON},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "500",
        movelvls = {
            {5, 8, 12, 15, 19, 22, 25, 28, 33, 39, 44, 50, 55},
            {5, 8, 12, 15, 19, 22, 25, 28, 33, 39, 44, 50, 55},
            {5, 8, 12, 15, 19, 22, 25, 28, 33, 39, 44, 50, 55},
            {5, 8, 12, 15, 19, 22, 25, 28, 33, 39, 44, 50, 55, 61},
            {5, 8, 12, 15, 19, 22, 25, 28, 33, 39, 44, 50, 55, 61}
        },
        weight = 40.5
    },
    {
        name = "Onix",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.GROUND},
        evolution = PokemonData.EVOLUTION_TYPES.METAL_COAT,
        bst = "385",
        movelvls = {
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49, 54},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49, 54},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49, 54, 57, 62},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46, 49, 52}
        },
        weight = 210.0
    },
    {
        name = "Drowzee",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "26",
        bst = "328",
        movelvls = {
            {7, 9, 15, 18, 21, 26, 29, 32, 37, 40, 43, 50, 53},
            {7, 9, 15, 18, 21, 26, 29, 32, 37, 40, 43, 50, 53},
            {7, 9, 15, 18, 21, 26, 29, 32, 37, 40, 43, 50, 53},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61}
        },
        weight = 32.4
    },
    {
        name = "Hypno",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "483",
        movelvls = {
            {7, 9, 15, 18, 21, 28, 33, 38, 45, 50, 55, 64, 69},
            {7, 9, 15, 18, 21, 28, 33, 38, 45, 50, 55, 64, 69},
            {7, 9, 15, 18, 21, 28, 33, 38, 45, 50, 55, 64, 69},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61}
        },
        weight = 75.6
    },
    {
        name = "Krabby",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "28",
        bst = "325",
        movelvls = {
            {5, 9, 11, 15, 19, 21, 25, 29, 31, 35, 39, 41, 45},
            {5, 9, 11, 15, 19, 21, 25, 29, 31, 35, 39, 41, 45},
            {5, 9, 11, 15, 19, 21, 25, 29, 31, 35, 39, 41, 45},
            {5, 9, 11, 15, 19, 21, 25, 29, 31, 35, 39, 41, 45},
            {5, 9, 11, 15, 19, 21, 25, 29, 31, 35, 39, 41, 45}
        },
        weight = 6.5
    },
    {
        name = "Kingler",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "475",
        movelvls = {
            {5, 9, 11, 15, 19, 21, 25, 32, 37, 44, 51, 56, 63},
            {5, 9, 11, 15, 19, 21, 25, 32, 37, 44, 51, 56, 63},
            {5, 9, 11, 15, 19, 21, 25, 32, 37, 44, 51, 56, 63},
            {5, 9, 11, 15, 19, 21, 25, 32, 37, 44, 51, 56, 63},
            {5, 9, 11, 15, 19, 21, 25, 32, 37, 44, 51, 56, 63}
        },
        weight = 60.0
    },
    {
        name = "Voltorb",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "30",
        bst = "330",
        movelvls = {
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43, 47},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43, 47},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43, 47},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43, 47, 50},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43, 47, 50}
        },
        weight = 10.4
    },
    {
        name = "Electrode",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "480",
        movelvls = {
            {5, 8, 12, 15, 19, 22, 26, 29, 35, 40, 46, 51, 57},
            {5, 8, 12, 15, 19, 22, 26, 29, 35, 40, 46, 51, 57},
            {5, 8, 12, 15, 19, 22, 26, 29, 35, 40, 46, 51, 57},
            {5, 8, 12, 15, 19, 22, 26, 29, 35, 40, 46, 51, 57, 62},
            {5, 8, 12, 15, 19, 22, 26, 29, 35, 40, 46, 51, 57, 62}
        },
        weight = 66.6
    },
    {
        name = "Exeggcute",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = PokemonData.EVOLUTION_TYPES.LEAF,
        bst = "325",
        movelvls = {
            {7, 11, 17, 19, 21, 23, 27, 33, 37, 43, 47},
            {7, 11, 17, 19, 21, 23, 27, 33, 37, 43, 47},
            {7, 11, 17, 19, 21, 23, 27, 33, 37, 43, 47},
            {7, 11, 17, 19, 21, 23, 27, 33, 37, 43, 47, 53},
            {7, 11, 17, 19, 21, 23, 27, 33, 37, 43, 47, 53}
        },
        weight = 2.5
    },
    {
        name = "Exeggutor",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "520",
        movelvls = {
            {17, 27, 37, 47},
            {17, 27, 37, 47},
            {17, 27, 37, 47},
            {17, 27, 37, 47},
            {17, 27, 37, 47}
        },
        weight = 120.0
    },
    {
        name = "Cubone",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "28",
        bst = "320",
        movelvls = {
            {3, 7, 11, 13, 17, 21, 23, 27, 31, 33, 37, 41, 43},
            {3, 7, 11, 13, 17, 21, 23, 27, 31, 33, 37, 41, 43},
            {3, 7, 11, 13, 17, 21, 23, 27, 31, 33, 37, 41, 43},
            {3, 7, 11, 13, 17, 21, 23, 27, 31, 33, 37, 41, 43, 47},
            {3, 7, 11, 13, 17, 21, 23, 27, 31, 33, 37, 41, 43, 47}
        },
        weight = 6.5
    },
    {
        name = "Marowak",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "425",
        movelvls = {
            {3, 7, 11, 13, 17, 21, 23, 27, 33, 37, 43, 49, 53},
            {3, 7, 11, 13, 17, 21, 23, 27, 33, 37, 43, 49, 53},
            {3, 7, 11, 13, 17, 21, 23, 27, 33, 37, 43, 49, 53},
            {3, 7, 11, 13, 17, 21, 23, 27, 33, 37, 43, 49, 53, 59},
            {3, 7, 11, 13, 17, 21, 23, 27, 33, 37, 43, 49, 53, 59}
        },
        weight = 45.0
    },
    {
        name = "Hitmonlee",
        type = {PokemonData.POKEMON_TYPES.FIGHTING, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "455",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61}
        },
        weight = 49.8
    },
    {
        name = "Hitmonchan",
        type = {PokemonData.POKEMON_TYPES.FIGHTING, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "455",
        movelvls = {
            {6, 11, 16, 16, 21, 26, 31, 31, 31, 36, 41, 46, 51, 56},
            {6, 11, 16, 16, 21, 26, 31, 31, 31, 36, 41, 46, 51, 56},
            {6, 11, 16, 16, 21, 26, 31, 31, 31, 36, 41, 46, 51, 56},
            {6, 11, 16, 16, 21, 26, 31, 36, 36, 36, 41, 46, 51, 56, 61, 66},
            {6, 11, 16, 16, 21, 26, 31, 36, 36, 36, 41, 46, 51, 56, 61, 66}
        },
        weight = 50.2
    },
    {
        name = "Lickitung",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "33",
        bst = "385",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57}
        },
        weight = 65.5
    },
    {
        name = "Koffing",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "35",
        bst = "340",
        movelvls = {
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51, 55},
            {4, 7, 12, 15, 18, 23, 26, 29, 34, 37, 40, 45}
        },
        weight = 1.0
    },
    {
        name = "Weezing",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "490",
        movelvls = {
            {6, 10, 15, 19, 24, 28, 33, 40, 48, 55, 63},
            {6, 10, 15, 19, 24, 28, 33, 40, 48, 55, 63},
            {6, 10, 15, 19, 24, 28, 33, 40, 48, 55, 63},
            {6, 10, 15, 19, 24, 28, 33, 39, 46, 52, 59, 65},
            {4, 7, 12, 15, 18, 23, 26, 29, 34, 40, 46, 54}
        },
        weight = 9.5
    },
    {
        name = "Rhyhorn",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.ROCK},
        evolution = "42",
        bst = "345",
        movelvls = {
            {9, 13, 21, 25, 33, 37, 45, 49, 57},
            {9, 13, 21, 25, 33, 37, 45, 49, 57},
            {9, 13, 21, 25, 33, 37, 45, 49, 57},
            {8, 12, 19, 23, 30, 34, 41, 45, 52, 56, 63, 67},
            {8, 12, 19, 23, 30, 34, 41, 45, 52, 56, 63, 67}
        },
        weight = 115.0
    },
    {
        name = "Rhydon",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.ROCK},
        evolution = PokemonData.EVOLUTION_TYPES.PROTECTOR,
        bst = "485",
        movelvls = {
            {9, 13, 21, 25, 33, 37, 42, 45, 49, 57},
            {9, 13, 21, 25, 33, 37, 42, 45, 49, 57},
            {9, 13, 21, 25, 33, 37, 42, 45, 49, 57},
            {9, 12, 19, 23, 30, 34, 41, 42, 47, 56, 62, 71, 77},
            {9, 12, 19, 23, 30, 34, 41, 42, 47, 56, 62, 71, 77}
        },
        weight = 120.0
    },
    {
        name = "Chansey",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.FRIEND,
        baseFriendship = 140,
        bst = "450",
        movelvls = {
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 46},
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 46},
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 46},
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 46, 50, 54},
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 46, 50, 54}
        },
        weight = 34.6
    },
    {
        name = "Tangela",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "33",
        bst = "435",
        movelvls = {
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43, 47, 50, 54},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43, 47, 50, 54},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43, 47, 50, 54},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43, 47, 50, 54},
            {4, 7, 10, 14, 17, 20, 23, 27, 30, 33, 36, 40, 43, 46, 49, 53}
        },
        weight = 35.0
    },
    {
        name = "Kangaskhan",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "490",
        movelvls = {
            {7, 10, 13, 19, 22, 25, 31, 34, 37, 43, 46, 49},
            {7, 10, 13, 19, 22, 25, 31, 34, 37, 43, 46, 49},
            {7, 10, 13, 19, 22, 25, 31, 34, 37, 43, 46, 49},
            {7, 10, 13, 19, 22, 25, 31, 34, 37, 43, 46, 49, 55},
            {7, 10, 13, 19, 22, 25, 31, 34, 37, 43, 46, 49, 55}
        },
        weight = 80.0
    },
    {
        name = "Horsea",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "32",
        bst = "295",
        movelvls = {
            {4, 8, 11, 14, 18, 23, 26, 30, 35, 38, 42},
            {4, 8, 11, 14, 18, 23, 26, 30, 35, 38, 42},
            {4, 8, 11, 14, 18, 23, 26, 30, 35, 38, 42},
            {4, 8, 11, 14, 18, 23, 26, 30, 35, 38, 42},
            {4, 8, 11, 14, 18, 23, 26, 30, 35, 38, 42}
        },
        weight = 8.0
    },
    {
        name = "Seadra",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.DRAGON_SCALE,
        bst = "440",
        movelvls = {
            {4, 8, 11, 14, 18, 23, 26, 30, 40, 48, 57},
            {4, 8, 11, 14, 18, 23, 26, 30, 40, 48, 57},
            {4, 8, 11, 14, 18, 23, 26, 30, 40, 48, 57},
            {4, 8, 11, 14, 18, 23, 26, 30, 40, 48, 57},
            {4, 8, 11, 14, 18, 23, 26, 30, 40, 48, 57}
        },
        weight = 25.0
    },
    {
        name = "Goldeen",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "33",
        bst = "320",
        movelvls = {
            {7, 11, 17, 21, 27, 31, 37, 41, 47, 51},
            {7, 11, 17, 21, 27, 31, 37, 41, 47, 51},
            {7, 11, 17, 21, 27, 31, 37, 41, 47, 51},
            {7, 11, 17, 21, 27, 31, 37, 41, 47, 51, 57},
            {7, 11, 17, 21, 27, 31, 37, 41, 47, 51, 57}
        },
        weight = 15.0
    },
    {
        name = "Seaking",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "450",
        movelvls = {
            {7, 11, 17, 21, 27, 31, 40, 47, 56, 63},
            {7, 11, 17, 21, 27, 31, 40, 47, 56, 63},
            {7, 11, 17, 21, 27, 31, 40, 47, 56, 63},
            {7, 11, 17, 21, 27, 31, 40, 47, 56, 63, 72},
            {7, 11, 17, 21, 27, 31, 40, 47, 56, 63, 72}
        },
        weight = 39.0
    },
    {
        name = "Staryu",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.WATER,
        bst = "340",
        movelvls = {
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51, 55},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51, 55},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51, 55},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51, 55, 60},
            {6, 10, 12, 15, 18, 22, 25, 30, 33, 36, 40, 43, 48, 52}
        },
        weight = 34.5
    },
    {
        name = "Starmie",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "520",
        movelvls = {
            {28},
            {28},
            {28},
            {28},
            {22}
        },
        weight = 80.0
    },
    {
        name = "Mr. Mime",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "460",
        movelvls = {
            {4, 8, 11, 15, 18, 22, 22, 25, 29, 32, 36, 39, 43, 46, 50},
            {4, 8, 11, 15, 18, 22, 22, 25, 29, 32, 36, 39, 43, 46, 50},
            {4, 8, 11, 15, 18, 22, 22, 25, 29, 32, 36, 39, 43, 46, 50},
            {4, 8, 11, 15, 18, 22, 22, 25, 29, 32, 36, 39, 43, 46, 50},
            {4, 8, 11, 15, 15, 18, 22, 22, 25, 29, 32, 36, 39, 43, 46, 50}
        },
        weight = 54.5
    },
    {
        name = "Scyther",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.METAL_COAT,
        bst = "500",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61}
        },
        weight = 56.0
    },
    {
        name = "Jynx",
        type = {PokemonData.POKEMON_TYPES.ICE, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "455",
        movelvls = {
            {5, 8, 11, 15, 18, 21, 25, 28, 33, 39, 44, 49, 55},
            {5, 8, 11, 15, 18, 21, 25, 28, 33, 39, 44, 49, 55},
            {5, 8, 11, 15, 18, 21, 25, 28, 33, 39, 44, 49, 55},
            {5, 8, 11, 15, 18, 21, 25, 28, 33, 39, 44, 49, 55, 60},
            {5, 8, 11, 15, 18, 21, 25, 28, 33, 39, 44, 49, 55, 60}
        },
        weight = 40.6
    },
    {
        name = "Electabuzz",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.ELECTIRIZER,
        bst = "490",
        movelvls = {
            {7, 10, 16, 19, 25, 28, 37, 43, 52, 58},
            {7, 10, 16, 19, 25, 28, 37, 43, 52, 58},
            {7, 10, 16, 19, 25, 28, 37, 43, 52, 58},
            {6, 11, 16, 21, 26, 32, 38, 44, 50, 56, 62},
            {5, 8, 12, 15, 19, 22, 26, 29, 36, 42, 49, 55}
        },
        weight = 30.0
    },
    {
        name = "Magmar", -- MAMGAR
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.MAGMARIZER,
        bst = "495",
        movelvls = {
            {7, 10, 16, 19, 25, 28, 36, 41, 49, 54},
            {7, 10, 16, 19, 25, 28, 36, 41, 49, 54},
            {7, 10, 16, 19, 25, 28, 36, 41, 49, 54},
            {6, 11, 16, 21, 26, 32, 38, 44, 50, 56, 62},
            {5, 8, 12, 15, 19, 22, 26, 29, 36, 42, 49, 55}
        },
        weight = 44.5
    },
    {
        name = "Pinsir",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "500",
        movelvls = {
            {4, 8, 13, 18, 21, 25, 30, 35, 38, 42, 47, 52},
            {4, 8, 13, 18, 21, 25, 30, 35, 38, 42, 47, 52},
            {4, 8, 13, 18, 21, 25, 30, 35, 38, 42, 47, 52},
            {4, 8, 13, 18, 21, 25, 30, 35, 38, 42, 47, 52},
            {4, 8, 11, 15, 18, 22, 26, 29, 33, 36, 40, 43, 47}
        },
        weight = 55.0
    },
    {
        name = "Tauros",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "490",
        movelvls = {
            {3, 5, 8, 11, 15, 19, 24, 29, 35, 41, 48, 55},
            {3, 5, 8, 11, 15, 19, 24, 29, 35, 41, 48, 55},
            {3, 5, 8, 11, 15, 19, 24, 29, 35, 41, 48, 55},
            {3, 5, 8, 11, 15, 19, 24, 29, 35, 41, 48, 55, 63},
            {3, 5, 8, 11, 15, 19, 24, 29, 35, 41, 48, 55, 63}
        },
        weight = 88.4
    },
    {
        name = "Magikarp",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "20",
        bst = "200",
        movelvls = {
            {15, 30},
            {15, 30},
            {15, 30},
            {15, 30},
            {15, 30}
        },
        weight = 10.0
    },
    {
        name = "Gyarados",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "540",
        movelvls = {
            {20, 23, 26, 29, 32, 35, 38, 41, 44, 47},
            {20, 23, 26, 29, 32, 35, 38, 41, 44, 47},
            {20, 23, 26, 29, 32, 35, 38, 41, 44, 47},
            {20, 23, 26, 29, 32, 35, 38, 41, 44, 47},
            {20, 23, 26, 29, 32, 35, 38, 41, 44, 47}
        },
        weight = 235.0
    },
    {
        name = "Lapras",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.ICE},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "535",
        movelvls = {
            {4, 7, 10, 14, 18, 22, 27, 32, 37, 43, 49, 55},
            {4, 7, 10, 14, 18, 22, 27, 32, 37, 43, 49, 55},
            {4, 7, 10, 14, 18, 22, 27, 32, 37, 43, 49, 55},
            {4, 7, 10, 14, 18, 22, 27, 32, 37, 43, 49, 55},
            {4, 7, 10, 14, 18, 22, 27, 32, 37, 43, 49, 55}
        },
        weight = 220.0
    },
    {
        name = "Ditto",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "288",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = 4.0
    },
    {
        name = "Eevee",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.VARIOUS,
        bst = "325",
        movelvls = {
            {8, 15, 22, 29, 36, 43, 50, 57},
            {8, 15, 22, 29, 36, 43, 50, 57},
            {8, 15, 22, 29, 36, 43, 50, 57},
            {8, 15, 22, 29, 36, 43, 50, 57},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45}
        },
        weight = 6.5
    },
    {
        name = "Vaporeon",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "525",
        movelvls = {
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45}
        },
        weight = 29.0
    },
    {
        name = "Jolteon",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "525",
        movelvls = {
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45}
        },
        weight = 24.5
    },
    {
        name = "Flareon",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "525",
        movelvls = {
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45}
        },
        weight = 25.0
    },
    {
        name = "Porygon",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.UPGRADE,
        bst = "395",
        movelvls = {
            {7, 12, 18, 23, 29, 34, 40, 45, 51, 56, 62},
            {7, 12, 18, 23, 29, 34, 40, 45, 51, 56, 62},
            {7, 12, 18, 23, 29, 34, 40, 45, 51, 56, 62},
            {7, 12, 18, 23, 29, 34, 40, 45, 51, 56, 62},
            {7, 12, 18, 23, 29, 34, 40, 45, 51, 56, 62}
        },
        weight = 36.5
    },
    {
        name = "Omanyte",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.WATER},
        evolution = "40",
        bst = "355",
        movelvls = {
            {7, 10, 16, 19, 25, 28, 34, 37, 43, 46, 52},
            {7, 10, 16, 19, 25, 28, 34, 37, 43, 46, 52},
            {7, 10, 16, 19, 25, 28, 34, 37, 43, 46, 52},
            {7, 10, 16, 19, 25, 28, 34, 37, 43, 46, 52, 55},
            {7, 10, 16, 19, 25, 28, 34, 37, 43, 46, 52, 55}
        },
        weight = 7.5
    },
    {
        name = "Omastar", -- LORD HELIX
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.WATER},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "495",
        movelvls = {
            {7, 10, 16, 19, 25, 28, 34, 37, 40, 48, 56, 67},
            {7, 10, 16, 19, 25, 28, 34, 37, 40, 48, 56, 67},
            {7, 10, 16, 19, 25, 28, 34, 37, 40, 48, 56, 67},
            {7, 10, 16, 19, 25, 28, 34, 37, 40, 48, 56, 67, 75},
            {7, 10, 16, 19, 25, 28, 34, 37, 40, 48, 56, 67, 75}
        },
        weight = 35.0
    },
    {
        name = "Kabuto",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.WATER},
        evolution = "40",
        bst = "355",
        movelvls = {
            {6, 11, 16, 21, 26, 31, 36, 41, 46, 51},
            {6, 11, 16, 21, 26, 31, 36, 41, 46, 51},
            {6, 11, 16, 21, 26, 31, 36, 41, 46, 51},
            {6, 11, 16, 21, 26, 31, 36, 41, 46, 51},
            {6, 11, 16, 21, 26, 31, 36, 41, 46, 51}
        },
        weight = 11.5
    },
    {
        name = "Kabutops",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.WATER},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "495",
        movelvls = {
            {6, 11, 16, 21, 26, 31, 36, 40, 45, 54, 63, 72},
            {6, 11, 16, 21, 26, 31, 36, 40, 45, 54, 63, 72},
            {6, 11, 16, 21, 26, 31, 36, 40, 45, 54, 63, 72},
            {6, 11, 16, 21, 26, 31, 36, 40, 45, 54, 63, 72},
            {6, 11, 16, 21, 26, 31, 36, 40, 45, 54, 63, 72}
        },
        weight = 40.5
    },
    {
        name = "Aerodactyl",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "515",
        movelvls = {
            {9, 17, 25, 33, 41, 49, 57, 65, 73},
            {9, 17, 25, 33, 41, 49, 57, 65, 73},
            {9, 17, 25, 33, 41, 49, 57, 65, 73},
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81},
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81}
        },
        weight = 59.0
    },
    {
        name = "Snorlax",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "540",
        movelvls = {
            {4, 9, 12, 17, 20, 25, 28, 28, 33, 36, 41, 44, 49},
            {4, 9, 12, 17, 20, 25, 28, 28, 33, 36, 41, 44, 49},
            {4, 9, 12, 17, 20, 25, 28, 28, 33, 36, 41, 44, 49},
            {4, 9, 12, 17, 20, 25, 28, 28, 33, 36, 41, 44, 49, 52, 57},
            {4, 9, 12, 17, 20, 25, 28, 28, 33, 36, 41, 44, 49, 52, 57}
        },
        weight = 460.0
    },
    {
        name = "Articuno",
        type = {PokemonData.POKEMON_TYPES.ICE, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "580",
        movelvls = {
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85, 92}
        },
        weight = 55.4
    },
    {
        name = "Zapdos",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "580",
        movelvls = {
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85, 92}
        },
        weight = 52.6
    },
    {
        name = "Moltres",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "580",
        movelvls = {
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85, 92}
        },
        weight = 60.0
    },
    {
        name = "Dratini",
        type = {PokemonData.POKEMON_TYPES.DRAGON, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "30",
        bst = "300",
        movelvls = {
            {5, 11, 15, 21, 25, 31, 35, 41, 45, 51, 55},
            {5, 11, 15, 21, 25, 31, 35, 41, 45, 51, 55},
            {5, 11, 15, 21, 25, 31, 35, 41, 45, 51, 55},
            {5, 11, 15, 21, 25, 31, 35, 41, 45, 51, 55, 61},
            {5, 11, 15, 21, 25, 31, 35, 41, 45, 51, 55, 61}
        },
        weight = 3.3
    },
    {
        name = "Dragonair",
        type = {PokemonData.POKEMON_TYPES.DRAGON, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "55",
        bst = "420",
        movelvls = {
            {5, 11, 15, 21, 25, 33, 39, 47, 53, 61, 67},
            {5, 11, 15, 21, 25, 33, 39, 47, 53, 61, 67},
            {5, 11, 15, 21, 25, 33, 39, 47, 53, 61, 67},
            {5, 11, 15, 21, 25, 33, 39, 47, 53, 61, 67, 75},
            {5, 11, 15, 21, 25, 33, 39, 47, 53, 61, 67, 75}
        },
        weight = 16.5
    },
    {
        name = "Dragonite",
        type = {PokemonData.POKEMON_TYPES.DRAGON, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "600",
        movelvls = {
            {5, 11, 15, 21, 25, 33, 39, 47, 53, 55, 64, 73},
            {5, 11, 15, 21, 25, 33, 39, 47, 53, 55, 64, 73},
            {5, 11, 15, 21, 25, 33, 39, 47, 53, 55, 64, 73},
            {5, 11, 15, 21, 25, 33, 39, 47, 53, 55, 61, 67, 75, 81},
            {5, 11, 15, 21, 25, 33, 39, 47, 53, 55, 61, 67, 75, 81}
        },
        weight = 210.0
    },
    {
        name = "Mewtwo",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "680",
        movelvls = {
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 64, 71, 79, 86, 93, 100},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 64, 71, 79, 86, 93, 100},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 64, 71, 79, 86, 93, 100},
            {8, 15, 22, 29, 36, 43, 50, 57, 57, 64, 71, 79, 86, 93, 100},
            {8, 15, 22, 29, 36, 43, 50, 57, 57, 64, 71, 79, 86, 93, 100}
        },
        weight = 122.0
    },
    {
        name = "Mew",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "600",
        movelvls = {
            {10, 20, 30, 40, 50, 60, 70, 80, 90, 100},
            {10, 20, 30, 40, 50, 60, 70, 80, 90, 100},
            {10, 20, 30, 40, 50, 60, 70, 80, 90, 100},
            {10, 20, 30, 40, 50, 60, 70, 80, 90, 100},
            {10, 20, 30, 40, 50, 60, 70, 80, 90, 100}
        },
        weight = 4.0
    },
    {
        name = "Chikorita",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "16",
        bst = "318",
        movelvls = {
            {6, 9, 12, 17, 20, 23, 28, 31, 34, 39, 42, 45},
            {6, 9, 12, 17, 20, 23, 28, 31, 34, 39, 42, 45},
            {6, 9, 12, 17, 20, 23, 28, 31, 34, 39, 42, 45},
            {6, 9, 12, 17, 20, 23, 28, 31, 34, 39, 42, 45},
            {6, 9, 12, 17, 20, 23, 28, 31, 34, 39, 42, 45}
        },
        weight = 6.4
    },
    {
        name = "Bayleef",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "32",
        bst = "405",
        movelvls = {
            {6, 9, 12, 18, 22, 26, 32, 36, 40, 46, 50, 54},
            {6, 9, 12, 18, 22, 26, 32, 36, 40, 46, 50, 54},
            {6, 9, 12, 18, 22, 26, 32, 36, 40, 46, 50, 54},
            {6, 9, 12, 18, 22, 26, 32, 36, 40, 46, 50, 54},
            {6, 9, 12, 18, 22, 26, 32, 36, 40, 46, 50, 54}
        },
        weight = 15.8
    },
    {
        name = "Meganium",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "525",
        movelvls = {
            {6, 9, 12, 18, 22, 26, 32, 34, 40, 46, 54, 60, 66},
            {6, 9, 12, 18, 22, 26, 32, 34, 40, 46, 54, 60, 66},
            {6, 9, 12, 18, 22, 26, 32, 34, 40, 46, 54, 60, 66},
            {6, 9, 12, 18, 22, 26, 32, 34, 40, 46, 54, 60, 66},
            {6, 9, 12, 18, 22, 26, 32, 34, 40, 46, 54, 60, 66}
        },
        weight = 100.5
    },
    {
        name = "Cyndaquil",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "14",
        bst = "309",
        movelvls = {
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 46, 49},
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 46, 49},
            {6, 10, 13, 19, 22, 28, 31, 37, 40, 46, 49},
            {6, 10, 13, 19, 22, 28, 31, 37, 40, 46, 49, 55, 58},
            {6, 10, 13, 19, 22, 28, 31, 37, 40, 46, 49, 55, 58}
        },
        weight = 7.9
    },
    {
        name = "Quilava",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "36",
        bst = "405",
        movelvls = {
            {4, 10, 13, 20, 24, 31, 35, 42, 46, 53, 57},
            {4, 10, 13, 20, 24, 31, 35, 42, 46, 53, 57},
            {6, 10, 13, 20, 24, 31, 35, 42, 46, 53, 57},
            {6, 10, 13, 20, 24, 31, 35, 42, 46, 53, 57, 64, 68},
            {6, 10, 13, 20, 24, 31, 35, 42, 46, 53, 57, 64, 68}
        },
        weight = 19.0
    },
    {
        name = "Typhlosion",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "534",
        movelvls = {
            {4, 10, 13, 20, 24, 31, 35, 42, 46, 53, 57},
            {4, 10, 13, 20, 24, 31, 35, 42, 46, 53, 57},
            {6, 10, 13, 20, 24, 31, 35, 42, 46, 53, 57},
            {6, 10, 13, 20, 24, 31, 35, 43, 48, 56, 61, 69, 74},
            {6, 10, 13, 20, 24, 31, 35, 43, 48, 56, 61, 69, 74}
        },
        weight = 79.5
    },
    {
        name = "Totodile",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "18",
        bst = "314",
        movelvls = {
            {6, 8, 13, 15, 20, 22, 27, 29, 34, 36, 41, 43},
            {6, 8, 13, 15, 20, 22, 27, 29, 34, 36, 41, 43, 48},
            {6, 8, 13, 15, 20, 22, 27, 29, 34, 36, 41, 43, 48},
            {6, 8, 13, 15, 20, 22, 27, 29, 34, 36, 41, 43, 48, 50},
            {6, 8, 13, 15, 20, 22, 27, 29, 34, 36, 41, 43, 48, 50}
        },
        weight = 9.5
    },
    {
        name = "Croconaw",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "30",
        bst = "405",
        movelvls = {
            {6, 8, 13, 15, 21, 24, 30, 33, 39, 42, 48, 51},
            {6, 8, 13, 15, 21, 24, 30, 33, 39, 42, 48, 51, 57},
            {6, 8, 13, 15, 21, 24, 30, 33, 39, 42, 48, 51, 57},
            {6, 8, 13, 15, 21, 24, 30, 33, 39, 42, 48, 51, 57, 60},
            {6, 8, 13, 15, 21, 24, 30, 33, 39, 42, 48, 51, 57, 60}
        },
        weight = 25.0
    },
    {
        name = "Feraligatr",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "530",
        movelvls = {
            {6, 8, 13, 15, 21, 24, 30, 32, 37, 45, 50, 58, 63},
            {6, 8, 13, 15, 21, 24, 30, 32, 37, 45, 50, 58, 63, 71},
            {6, 8, 13, 15, 21, 24, 30, 32, 37, 45, 50, 58, 63, 71},
            {6, 8, 13, 15, 21, 24, 30, 32, 37, 45, 50, 58, 63, 71, 76},
            {6, 8, 13, 15, 21, 24, 30, 32, 37, 45, 50, 58, 63, 71, 76}
        },
        weight = 88.8
    },
    {
        name = "Sentret",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "15",
        bst = "215",
        movelvls = {
            {4, 7, 13, 16, 19, 25, 28, 31, 36, 39, 42, 47},
            {4, 7, 13, 16, 19, 25, 28, 31, 36, 39, 42, 47},
            {4, 7, 13, 16, 19, 25, 28, 31, 36, 39, 42, 47},
            {4, 7, 13, 16, 19, 25, 28, 31, 36, 39, 42, 47},
            {4, 7, 13, 16, 19, 25, 28, 31, 36, 39, 42, 47}
        },
        weight = 6.0
    },
    {
        name = "Furret",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "415",
        movelvls = {
            {4, 7, 13, 17, 21, 28, 32, 36, 42, 46, 50, 56},
            {4, 7, 13, 17, 21, 28, 32, 36, 42, 46, 50, 56},
            {4, 7, 13, 17, 21, 28, 32, 36, 42, 46, 50, 56},
            {4, 7, 13, 17, 21, 28, 32, 36, 42, 46, 50, 56},
            {4, 7, 13, 17, 21, 28, 32, 36, 42, 46, 50, 56}
        },
        weight = 32.5
    },
    {
        name = "Hoothoot",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = "20",
        bst = "262",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57}
        },
        weight = 21.2
    },
    {
        name = "Noctowl",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "442",
        movelvls = {
            {5, 9, 13, 17, 22, 27, 32, 37, 42, 47, 52, 57},
            {5, 9, 13, 17, 22, 27, 32, 37, 42, 47, 52, 57},
            {5, 9, 13, 17, 22, 27, 32, 37, 42, 47, 52, 57},
            {5, 9, 13, 17, 22, 27, 32, 37, 42, 47, 52, 57, 62, 67},
            {5, 9, 13, 17, 22, 27, 32, 37, 42, 47, 52, 57, 62, 67}
        },
        weight = 40.8
    },
    {
        name = "Ledyba",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.FLYING},
        evolution = "18",
        bst = "265",
        movelvls = {
            {6, 9, 14, 14, 14, 17, 22, 25, 30, 33, 38, 41},
            {6, 9, 14, 14, 14, 17, 22, 25, 30, 33, 38, 41},
            {6, 9, 14, 14, 14, 17, 22, 25, 30, 33, 38, 41},
            {6, 9, 14, 14, 14, 17, 22, 25, 30, 33, 38, 41},
            {6, 9, 14, 14, 14, 17, 22, 25, 30, 33, 38, 41}
        },
        weight = 10.8
    },
    {
        name = "Ledian",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "390",
        movelvls = {
            {6, 9, 14, 14, 14, 17, 24, 29, 36, 41, 48, 53},
            {6, 9, 14, 14, 14, 17, 24, 29, 36, 41, 48, 53},
            {6, 9, 14, 14, 14, 17, 24, 29, 36, 41, 48, 53},
            {6, 9, 14, 14, 14, 17, 24, 29, 36, 41, 48, 53},
            {6, 9, 14, 14, 14, 17, 24, 29, 36, 41, 48, 53}
        },
        weight = 35.6
    },
    {
        name = "Spinarak",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.POISON},
        evolution = "22",
        bst = "250",
        movelvls = {
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43, 47},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43, 47}
        },
        weight = 8.5
    },
    {
        name = "Ariados",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.POISON},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "390",
        movelvls = {
            {5, 8, 12, 15, 19, 23, 28, 32, 37, 41, 46, 50},
            {5, 8, 12, 15, 19, 23, 28, 32, 37, 41, 46, 50},
            {5, 8, 12, 15, 19, 23, 28, 32, 37, 41, 46, 50},
            {5, 8, 12, 15, 19, 23, 28, 32, 37, 41, 46, 50, 55},
            {5, 8, 12, 15, 19, 23, 28, 32, 37, 41, 46, 50, 55}
        },
        weight = 33.5
    },
    {
        name = "Crobat",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "535",
        movelvls = {
            {5, 9, 13, 17, 21, 27, 33, 39, 45, 51},
            {5, 9, 13, 17, 21, 27, 33, 39, 45, 51},
            {5, 9, 13, 17, 21, 27, 33, 39, 45, 51},
            {5, 9, 13, 17, 21, 27, 33, 39, 45, 51, 57},
            {4, 8, 12, 15, 19, 24, 28, 33, 38, 42, 47, 52}
        },
        weight = 75.0,
        theme = "FFFFFF FFFFFF A2DFFF FFA73F FEFB9C FEFB9C 9A57B3 D57FF5 9A57B3 D57FF5 396680 FFFFFF FFFFFF FFFFFF 0 1 1 0 0 1"
    },
    {
        name = "Chinchou",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.ELECTRIC},
        evolution = "27",
        bst = "330",
        movelvls = {
            {6, 9, 12, 17, 20, 23, 28, 31, 34, 39, 42, 45},
            {6, 9, 12, 17, 20, 23, 28, 31, 34, 39, 42, 45},
            {6, 9, 12, 17, 20, 23, 28, 31, 34, 39, 42, 45},
            {6, 9, 12, 17, 20, 23, 28, 31, 34, 39, 42, 45, 50},
            {6, 9, 12, 17, 20, 23, 28, 31, 34, 39, 42, 45, 50}
        },
        weight = 12.0
    },
    {
        name = "Lanturn",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.ELECTRIC},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "460",
        movelvls = {
            {6, 9, 12, 17, 20, 23, 27, 27, 27, 30, 35, 40, 47, 52, 57},
            {6, 9, 12, 17, 20, 23, 27, 27, 27, 30, 35, 40, 47, 52, 57},
            {6, 9, 12, 17, 20, 23, 27, 27, 27, 30, 35, 40, 47, 52, 57},
            {6, 9, 12, 17, 20, 23, 27, 27, 27, 30, 35, 40, 47, 52, 57, 64},
            {6, 9, 12, 17, 20, 23, 27, 27, 27, 30, 35, 40, 47, 52, 57, 64}
        },
        weight = 22.5
    },
    {
        name = "Pichu",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.FRIEND,
        baseFriendship = 70,
        bst = "205",
        movelvls = {
            {5, 10, 13, 18},
            {5, 10, 13, 18},
            {5, 10, 13, 18},
            {5, 10, 13, 18},
            {5, 10, 13, 18}
        },
        weight = 2.0
    },
    {
        name = "Cleffa",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.FRIEND,
        baseFriendship = 140,
        bst = "218",
        movelvls = {
            {4, 7, 10, 13, 16},
            {4, 7, 10, 13, 16},
            {4, 7, 10, 13, 16},
            {4, 7, 10, 13, 16},
            {4, 7, 10, 13, 16}
        },
        weight = 3.0
    },
    {
        name = "Igglybuff",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.FRIEND,
        baseFriendship = 70,
        bst = "210",
        movelvls = {
            {5, 9, 13, 17},
            {5, 9, 13, 17},
            {5, 9, 13, 17},
            {5, 9, 13, 17},
            {5, 9, 13, 17}
        },
        weight = 1.0
    },
    {
        name = "Togepi",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.FRIEND,
        baseFriendship = 70,
        bst = "245",
        movelvls = {
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53}
        },
        weight = 1.5
    },
    {
        name = "Togetic",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.SHINY_STONE,
        bst = "405",
        movelvls = {
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53}
        },
        weight = 3.2
    },
    {
        name = "Natu",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.FLYING},
        evolution = "25",
        bst = "320",
        movelvls = {
            {6, 9, 12, 17, 20, 23, 28, 33, 36, 39, 44, 44, 47},
            {6, 9, 12, 17, 20, 23, 28, 33, 36, 39, 44, 44, 47},
            {6, 9, 12, 17, 20, 23, 28, 33, 36, 39, 44, 44, 47},
            {6, 9, 12, 17, 20, 23, 28, 33, 36, 39, 44, 47, 47, 50},
            {6, 9, 12, 17, 20, 23, 28, 33, 36, 39, 44, 47, 47, 50}
        },
        weight = 2.0
    },
    {
        name = "Xatu",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "470",
        movelvls = {
            {6, 9, 12, 17, 20, 23, 27, 30, 37, 42, 47, 54, 54, 59},
            {6, 9, 12, 17, 20, 23, 27, 30, 37, 42, 47, 54, 54, 59},
            {6, 9, 12, 17, 20, 23, 27, 30, 37, 42, 47, 54, 54, 59},
            {6, 9, 12, 17, 20, 23, 27, 30, 37, 42, 47, 54, 54, 59, 66},
            {6, 9, 12, 17, 20, 23, 27, 30, 37, 42, 47, 54, 54, 59, 66}
        },
        weight = 15.0
    },
    {
        name = "Mareep",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "15",
        bst = "280",
        movelvls = {
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50, 55},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46}
        },
        weight = 7.8
    },
    {
        name = "Flaaffy",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "30",
        bst = "365",
        movelvls = {
            {5, 10, 14, 20, 25, 31, 36, 42, 47, 53},
            {5, 10, 14, 20, 25, 31, 36, 42, 47, 53},
            {5, 10, 14, 20, 25, 31, 36, 42, 47, 53},
            {5, 10, 14, 20, 25, 31, 36, 42, 47, 53, 59, 65},
            {4, 8, 11, 16, 20, 25, 29, 34, 38, 43, 47, 52, 56}
        },
        weight = 13.3
    },
    {
        name = "Ampharos",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "500",
        movelvls = {
            {5, 10, 14, 20, 25, 30, 34, 42, 51, 59, 68},
            {5, 10, 14, 20, 25, 30, 34, 42, 51, 59, 68},
            {5, 10, 14, 20, 25, 30, 34, 42, 51, 59, 68},
            {5, 10, 14, 20, 25, 30, 33, 40, 48, 55, 63, 71, 79},
            {4, 8, 11, 16, 20, 25, 29, 30, 35, 40, 46, 51, 57, 62}
        },
        weight = 61.5
    },
    {
        name = "Bellossom",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "480",
        movelvls = {
            {23, 53},
            {23, 53},
            {23, 53},
            {23, 53},
            {23, 53}
        },
        weight = 5.8
    },
    {
        name = "Marill",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "18",
        bst = "250",
        movelvls = {
            {2, 7, 10, 15, 18, 23, 27, 32, 37, 42},
            {2, 7, 10, 15, 18, 23, 27, 32, 37, 42},
            {2, 7, 10, 15, 18, 23, 27, 32, 37, 42},
            {2, 7, 10, 15, 18, 23, 27, 32, 37, 42},
            {2, 5, 7, 10, 10, 13, 16, 20, 23, 28, 31, 37, 40}
        },
        weight = 8.5
    },
    {
        name = "Azumarill",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "410",
        movelvls = {
            {2, 7, 10, 15, 20, 27, 33, 40, 47, 54},
            {2, 7, 10, 15, 20, 27, 33, 40, 47, 54},
            {2, 7, 10, 15, 20, 27, 33, 40, 47, 54},
            {2, 7, 10, 15, 20, 27, 33, 40, 47, 54},
            {2, 5, 7, 10, 10, 13, 16, 21, 25, 31, 35, 42, 46}
        },
        weight = 28.5
    },
    {
        name = "Sudowoodo",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "410",
        movelvls = {
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49},
            {5, 8, 12, 15, 15, 19, 22, 26, 29, 33, 36, 40, 43, 47}
        },
        weight = 38.0
    },
    {
        name = "Politoed",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "500",
        movelvls = {
            {43, 53},
            {27, 37, 48},
            {27, 37, 48},
            {27, 37, 48},
            {27, 37, 48}
        },
        weight = 33.9
    },
    {
        name = "Hoppip",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.FLYING},
        evolution = "18",
        bst = "250",
        movelvls = {
            {4, 7, 10, 12, 14, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43},
            {4, 7, 10, 12, 14, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43},
            {4, 7, 10, 12, 14, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43},
            {4, 7, 10, 12, 14, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46, 49},
            {4, 7, 10, 12, 14, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46, 49}
        },
        weight = 0.5
    },
    {
        name = "Skiploom",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.FLYING},
        evolution = "27",
        bst = "340",
        movelvls = {
            {4, 7, 10, 12, 14, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52},
            {4, 7, 10, 12, 14, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52},
            {4, 7, 10, 12, 14, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52},
            {4, 7, 10, 12, 14, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60},
            {4, 7, 10, 12, 14, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56, 60}
        },
        weight = 1.0
    },
    {
        name = "Jumpluff",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "450",
        movelvls = {
            {4, 7, 10, 12, 14, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52},
            {4, 7, 10, 12, 14, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52},
            {4, 7, 10, 12, 14, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52},
            {4, 7, 10, 12, 14, 16, 20, 24, 29, 34, 39, 44, 49, 54, 59, 64, 69},
            {4, 7, 10, 12, 14, 16, 20, 24, 29, 34, 39, 44, 49, 54, 59, 64, 69}
        },
        weight = 3.0
    },
    {
        name = "Aipom",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "32",
        bst = "360",
        movelvls = {
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43}
        },
        weight = 11.5
    },
    {
        name = "Sunkern",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.SUN,
        bst = "180",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43}
        },
        weight = 1.8
    },
    {
        name = "Sunflora",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "425",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 43},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 43},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 43},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43}
        },
        weight = 8.5
    },
    {
        name = "Yanma",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.FLYING},
        evolution = "33",
        bst = "390",
        movelvls = {
            {6, 11, 14, 17, 22, 27, 30, 33, 38, 43, 46, 49, 54, 57},
            {6, 11, 14, 17, 22, 27, 30, 33, 38, 43, 46, 49, 54, 57},
            {6, 11, 14, 17, 22, 27, 30, 33, 38, 43, 46, 49, 54, 57},
            {6, 11, 14, 17, 22, 27, 30, 33, 38, 43, 46, 49, 54, 57},
            {6, 11, 14, 17, 22, 27, 30, 33, 38, 43, 46, 49, 54, 57}
        },
        weight = 38.0
    },
    {
        name = "Wooper",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.GROUND},
        evolution = "20",
        bst = "210",
        movelvls = {
            {5, 9, 15, 19, 23, 29, 33, 37, 43, 43, 47},
            {5, 9, 15, 19, 23, 29, 33, 37, 43, 43, 47},
            {5, 9, 15, 19, 23, 29, 33, 37, 43, 43, 47},
            {5, 9, 15, 19, 23, 29, 33, 37, 43, 43, 47},
            {5, 9, 15, 19, 23, 29, 33, 37, 43, 43, 47}
        },
        weight = 8.5
    },
    {
        name = "Quagsire",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.GROUND},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "430",
        movelvls = {
            {5, 9, 15, 19, 24, 31, 36, 41, 48, 48, 53},
            {5, 9, 15, 19, 24, 31, 36, 41, 48, 48, 53},
            {5, 9, 15, 19, 24, 31, 36, 41, 48, 48, 53},
            {5, 9, 15, 19, 24, 31, 36, 41, 48, 48, 53},
            {5, 9, 15, 19, 24, 31, 36, 41, 48, 48, 53}
        },
        weight = 75.0
    },
    {
        name = "Espeon",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "525",
        movelvls = {
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45}
        },
        weight = 26.5
    },
    {
        name = "Umbreon",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "525",
        movelvls = {
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45}
        },
        weight = 27.0
    },
    {
        name = "Murkrow",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.DUSK,
        bst = "405",
        movelvls = {
            {5, 11, 15, 21, 25, 31, 35, 41, 45},
            {5, 11, 15, 21, 25, 31, 35, 41, 45},
            {5, 11, 15, 21, 25, 31, 35, 41, 45},
            {5, 11, 15, 21, 25, 31, 35, 41, 45, 51, 55, 61, 65},
            {5, 11, 15, 21, 25, 31, 35, 41, 45, 51, 55, 61, 65}
        },
        weight = 2.1
    },
    {
        name = "Slowking",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "490",
        movelvls = {
            {6, 11, 15, 20, 25, 29, 34, 39, 43, 48, 53, 57},
            {6, 11, 15, 20, 25, 29, 34, 39, 43, 48, 53, 57},
            {6, 11, 15, 20, 25, 29, 34, 39, 43, 48, 53, 57},
            {5, 9, 14, 19, 23, 28, 32, 36, 41, 45, 49, 54, 58},
            {5, 9, 14, 19, 23, 28, 32, 36, 41, 45, 49, 54, 58}
        },
        weight = 79.5
    },
    {
        name = "Misdreavus",
        type = {PokemonData.POKEMON_TYPES.GHOST, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.DUSK,
        bst = "435",
        movelvls = {
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50, 55},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50, 55}
        },
        weight = 1.0
    },
    {
        name = "Unown",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "336",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = 5.0
    },
    {
        name = "Wobbuffet",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "405",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = 28.5
    },
    {
        name = "Girafarig",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "455",
        movelvls = {
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46}
        },
        weight = 41.5
    },
    {
        name = "Pineco",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "31",
        bst = "290",
        movelvls = {
            {6, 9, 12, 17, 20, 23, 28, 31, 34, 39, 42},
            {6, 9, 12, 17, 20, 23, 28, 31, 34, 39, 42, 45},
            {6, 9, 12, 17, 20, 23, 28, 31, 34, 39, 42, 45},
            {6, 9, 12, 17, 20, 23, 28, 31, 34, 39, 42, 45},
            {6, 9, 12, 17, 20, 23, 28, 31, 34, 39, 42, 45}
        },
        weight = 7.2
    },
    {
        name = "Forretress",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.STEEL},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "465",
        movelvls = {
            {6, 9, 12, 17, 20, 23, 28, 31, 33, 38, 45, 50, 57, 62},
            {6, 9, 12, 17, 20, 23, 28, 31, 33, 38, 45, 50, 55, 62, 67},
            {6, 9, 12, 17, 20, 23, 28, 31, 33, 38, 45, 50, 55, 62, 67},
            {6, 9, 12, 17, 20, 23, 28, 31, 32, 36, 42, 46, 50, 56, 60, 64, 70},
            {6, 9, 12, 17, 20, 23, 28, 31, 32, 36, 42, 46, 50, 56, 60, 64, 70}
        },
        weight = 125.8
    },
    {
        name = "Dunsparce",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "415",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53},
            {4, 8, 12, 16, 20, 24, 28, 33, 38, 43, 48, 53, 58, 63},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46, 49}
        },
        weight = 14.0
    },
    {
        name = "Gligar",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.RAZOR_FANG,
        bst = "430",
        movelvls = {
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 45},
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 45},
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 45},
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 45, 49},
            {4, 7, 10, 13, 16, 19, 22, 27, 30, 35, 40, 45, 50, 55}
        },
        weight = 64.8
    },
    {
        name = "Steelix",
        type = {PokemonData.POKEMON_TYPES.STEEL, PokemonData.POKEMON_TYPES.GROUND},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "510",
        movelvls = {
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49, 54},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49, 54},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49, 54, 57, 62},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46, 49, 52}
        },
        weight = 400.0
    },
    {
        name = "Snubbull",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "23",
        bst = "300",
        movelvls = {
            {7, 13, 19, 25, 31, 37, 43, 49},
            {7, 13, 19, 25, 31, 37, 43, 49},
            {7, 13, 19, 25, 31, 37, 43, 49},
            {7, 13, 19, 25, 31, 37, 43, 49},
            {7, 13, 19, 25, 31, 37, 43, 49}
        },
        weight = 7.8
    },
    {
        name = "Granbull",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "450",
        movelvls = {
            {7, 13, 19, 27, 35, 43, 51, 59},
            {7, 13, 19, 27, 35, 43, 51, 59},
            {7, 13, 19, 27, 35, 43, 51, 59},
            {7, 13, 19, 27, 35, 43, 51, 59, 67},
            {7, 13, 19, 27, 35, 43, 51, 59, 67}
        },
        weight = 48.7
    },
    {
        name = "Qwilfish",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.POISON},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "430",
        movelvls = {
            {9, 9, 13, 17, 21, 25, 25, 29, 33, 37, 41, 45, 49, 53, 57},
            {9, 9, 13, 17, 21, 25, 25, 29, 33, 37, 41, 45, 49, 53, 57},
            {9, 9, 13, 17, 21, 25, 25, 29, 33, 37, 41, 45, 49, 53, 57},
            {9, 9, 13, 17, 21, 25, 25, 29, 33, 37, 41, 45, 49, 53, 57},
            {9, 9, 13, 17, 21, 25, 25, 29, 33, 37, 41, 45, 49, 53, 57}
        },
        weight = 3.9
    },
    {
        name = "Scizor",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.STEEL},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "500",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61}
        },
        weight = 118.0
    },
    {
        name = "Shuckle",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.ROCK},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "505",
        movelvls = {
            {9, 14, 22, 27, 35, 40, 48},
            {9, 14, 22, 27, 35, 40, 48},
            {9, 14, 22, 27, 35, 40, 48},
            {7, 13, 19, 25, 31, 37, 43, 49, 55, 55},
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 45, 45, 49}
        },
        weight = 20.5
    },
    {
        name = "Heracross",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.FIGHTING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "500",
        movelvls = {
            {7, 13, 19, 25, 31, 37, 43, 49, 55},
            {7, 13, 19, 25, 31, 37, 43, 49, 55},
            {7, 13, 19, 25, 31, 37, 43, 49, 55},
            {7, 13, 19, 25, 31, 37, 43, 49, 55},
            {7, 10, 16, 19, 25, 28, 34, 37, 43, 46}
        },
        weight = 54.0
    },
    {
        name = "Sneasel",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.ICE},
        evolution = PokemonData.EVOLUTION_TYPES.RAZOR_CLAW,
        bst = "430",
        movelvls = {
            {8, 10, 14, 21, 24, 28, 35, 38, 42, 49},
            {8, 10, 14, 21, 24, 28, 35, 38, 42, 49},
            {8, 10, 14, 21, 24, 28, 35, 38, 42, 49},
            {8, 10, 14, 21, 24, 28, 35, 38, 42, 49, 51},
            {8, 10, 14, 16, 20, 22, 25, 28, 32, 35, 40, 44, 47}
        },
        weight = 28.0
    },
    {
        name = "Teddiursa",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "30",
        bst = "330",
        movelvls = {
            {8, 15, 22, 29, 36, 43, 43, 50, 57},
            {8, 15, 22, 29, 36, 43, 43, 50, 57},
            {8, 15, 22, 29, 36, 43, 43, 50, 57},
            {8, 15, 22, 29, 36, 43, 43, 50, 57},
            {8, 15, 22, 29, 36, 43, 43, 50, 57}
        },
        weight = 8.8
    },
    {
        name = "Ursaring",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "500",
        movelvls = {
            {8, 15, 22, 29, 38, 47, 49, 58, 67},
            {8, 15, 22, 29, 38, 47, 49, 58, 67},
            {8, 15, 22, 29, 38, 47, 49, 58, 67},
            {8, 15, 22, 29, 38, 47, 49, 58, 67},
            {8, 15, 22, 29, 38, 47, 49, 58, 67}
        },
        weight = 125.8
    },
    {
        name = "Slugma",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "38",
        bst = "250",
        movelvls = {
            {8, 11, 16, 23, 26, 31, 38, 41, 46, 53, 56},
            {8, 11, 16, 23, 26, 31, 38, 41, 46, 53, 56},
            {8, 11, 16, 23, 26, 31, 38, 41, 46, 53, 56},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50, 55},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50, 55}
        },
        weight = 35.0
    },
    {
        name = "Magcargo",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.ROCK},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "410",
        movelvls = {
            {8, 11, 16, 23, 26, 31, 40, 45, 52, 61, 66},
            {8, 11, 16, 23, 26, 31, 40, 45, 52, 61, 66},
            {8, 11, 16, 23, 26, 31, 40, 45, 52, 61, 66},
            {5, 10, 14, 19, 23, 28, 32, 37, 38, 44, 52, 59, 67},
            {5, 10, 14, 19, 23, 28, 32, 37, 38, 44, 52, 59, 67}
        },
        weight = 55.0
    },
    {
        name = "Swinub",
        type = {PokemonData.POKEMON_TYPES.ICE, PokemonData.POKEMON_TYPES.GROUND},
        evolution = "33",
        bst = "250",
        movelvls = {
            {4, 8, 13, 16, 20, 25, 28, 32, 37, 40, 44, 49},
            {4, 8, 13, 16, 20, 25, 28, 32, 37, 40, 44, 49},
            {4, 8, 13, 16, 20, 25, 28, 32, 37, 40, 44, 49},
            {4, 8, 13, 16, 20, 25, 28, 32, 37, 40, 44, 49},
            {5, 8, 11, 14, 18, 21, 24, 28, 35, 37, 40, 44, 48}
        },
        weight = 6.5
    },
    {
        name = "Piloswine",
        type = {PokemonData.POKEMON_TYPES.ICE, PokemonData.POKEMON_TYPES.GROUND},
        evolution = "45",
        bst = "450",
        movelvls = {
            {4, 8, 13, 16, 20, 25, 28, 32, 33, 40, 48, 56, 65},
            {4, 8, 13, 16, 20, 25, 28, 32, 33, 40, 48, 56, 65},
            {4, 8, 13, 16, 20, 25, 28, 32, 33, 40, 48, 56, 65},
            {4, 8, 13, 16, 20, 25, 28, 32, 33, 40, 48, 56, 65},
            {5, 8, 11, 14, 18, 21, 24, 28, 33, 37, 41, 46, 52, 58}
        },
        weight = 55.8
    },
    {
        name = "Corsola",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.ROCK},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "380",
        movelvls = {
            {4, 8, 13, 16, 20, 25, 28, 32, 37, 40, 44, 48, 53},
            {4, 8, 13, 16, 20, 25, 28, 32, 37, 40, 44, 48, 53},
            {4, 8, 13, 16, 20, 25, 28, 32, 37, 40, 44, 48, 53},
            {4, 8, 13, 16, 20, 25, 28, 32, 37, 40, 44, 48, 53},
            {4, 8, 10, 13, 17, 20, 23, 27, 29, 31, 35, 38, 41, 45, 47, 52}
        },
        weight = 5.0
    },
    {
        name = "Remoraid",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "25",
        bst = "300",
        movelvls = {
            {6, 10, 14, 19, 23, 27, 32, 36, 40, 45},
            {6, 10, 14, 19, 23, 27, 32, 36, 40, 45},
            {6, 10, 14, 19, 23, 27, 32, 36, 40, 45},
            {6, 10, 14, 19, 23, 27, 32, 36, 40, 45, 49},
            {6, 10, 14, 18, 22, 26, 30, 34, 38, 42, 46, 50}
        },
        weight = 12.0
    },
    {
        name = "Octillery",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "480",
        movelvls = {
            {6, 10, 14, 19, 23, 25, 29, 36, 42, 48, 55},
            {6, 10, 14, 19, 23, 25, 29, 36, 42, 48, 55},
            {6, 10, 14, 19, 23, 25, 29, 36, 42, 48, 55},
            {6, 10, 14, 19, 23, 25, 29, 36, 42, 48, 55, 61},
            {6, 10, 14, 18, 22, 25, 28, 34, 40, 46, 52, 58, 64}
        },
        weight = 28.5
    },
    {
        name = "Delibird",
        type = {PokemonData.POKEMON_TYPES.ICE, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "330",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = 16.0
    },
    {
        name = "Mantine",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "465",
        movelvls = {
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 46, 49},
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 46, 49},
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 46, 49},
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 46, 49},
            {3, 7, 11, 14, 16, 19, 23, 27, 32, 36, 39, 46, 49}
        },
        weight = 220.0
    },
    {
        name = "Skarmory",
        type = {PokemonData.POKEMON_TYPES.STEEL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "465",
        movelvls = {
            {7, 11, 14, 20, 24, 27, 33, 38, 40, 46, 50},
            {6, 9, 12, 17, 20, 23, 28, 31, 34, 39, 42, 45},
            {6, 9, 12, 17, 20, 23, 28, 31, 34, 39, 42, 45},
            {6, 9, 12, 17, 20, 23, 28, 31, 34, 39, 42, 45, 50},
            {6, 9, 12, 17, 20, 23, 28, 31, 34, 39, 42, 45, 50}
        },
        weight = 50.5
    },
    {
        name = "Houndour",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.FIRE},
        evolution = "24",
        bst = "330",
        movelvls = {
            {4, 9, 14, 17, 22, 27, 30, 35, 40, 43, 48, 53},
            {4, 9, 14, 17, 22, 27, 30, 35, 40, 43, 48, 53},
            {4, 9, 14, 17, 22, 27, 30, 35, 40, 43, 48, 53},
            {4, 8, 13, 16, 20, 25, 28, 32, 37, 40, 44, 49, 52, 56},
            {4, 8, 13, 16, 20, 25, 28, 32, 37, 40, 44, 49, 52, 56}
        },
        weight = 10.8
    },
    {
        name = "Houndoom",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.FIRE},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "500",
        movelvls = {
            {4, 9, 14, 17, 22, 28, 32, 38, 44, 48, 54, 60},
            {4, 9, 14, 17, 22, 28, 32, 38, 44, 48, 54, 60},
            {4, 9, 14, 17, 22, 28, 32, 38, 44, 48, 54, 60},
            {4, 8, 13, 16, 20, 26, 30, 35, 41, 45, 50, 56, 60, 65},
            {4, 8, 13, 16, 20, 26, 30, 35, 41, 45, 50, 56, 60, 65}
        },
        weight = 35.0
    },
    {
        name = "Kingdra",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.DRAGON},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "540",
        movelvls = {
            {4, 8, 11, 14, 18, 23, 26, 30, 40, 48, 57},
            {4, 8, 11, 14, 18, 23, 26, 30, 40, 48, 57},
            {4, 8, 11, 14, 18, 23, 26, 30, 40, 48, 57},
            {4, 8, 11, 14, 18, 23, 26, 30, 40, 48, 57},
            {4, 8, 11, 14, 18, 23, 26, 30, 40, 48, 57}
        },
        weight = 152.0
    },
    {
        name = "Phanpy",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "25",
        bst = "330",
        movelvls = {
            {6, 10, 15, 19, 24, 28, 33, 37, 42},
            {6, 10, 15, 19, 24, 28, 33, 37, 42},
            {6, 10, 15, 19, 24, 28, 33, 37, 42},
            {6, 10, 15, 19, 24, 28, 33, 37, 42},
            {6, 10, 15, 19, 24, 28, 33, 37, 42}
        },
        weight = 33.5
    },
    {
        name = "Donphan",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "500",
        movelvls = {
            {6, 10, 15, 19, 24, 25, 31, 39, 46, 54},
            {6, 10, 15, 19, 24, 25, 31, 39, 46, 54},
            {6, 10, 15, 19, 24, 25, 31, 39, 46, 54},
            {6, 10, 15, 19, 24, 25, 31, 39, 46, 54},
            {6, 10, 15, 19, 24, 25, 31, 39, 46, 54}
        },
        weight = 120.0
    },
    {
        name = "Porygon2",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.DUBIOUS_DISC,
        bst = "515",
        movelvls = {
            {7, 12, 18, 23, 29, 34, 40, 45, 51, 56, 62, 67},
            {7, 12, 18, 23, 29, 34, 40, 45, 51, 56, 62, 67},
            {7, 12, 18, 23, 29, 34, 40, 45, 51, 56, 62, 67},
            {7, 12, 18, 23, 29, 34, 40, 45, 51, 56, 62, 67},
            {7, 12, 18, 23, 29, 34, 40, 45, 51, 56, 62, 67}
        },
        weight = 32.5
    },
    {
        name = "Stantler",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "465",
        movelvls = {
            {3, 7, 10, 13, 16, 21, 23, 27, 33, 38, 43, 49, 53},
            {3, 7, 10, 13, 16, 21, 23, 27, 33, 38, 43, 49, 53},
            {3, 7, 10, 13, 16, 21, 23, 27, 33, 38, 43, 49, 53},
            {3, 7, 10, 13, 16, 21, 23, 27, 33, 38, 43, 49, 53, 55},
            {3, 7, 10, 13, 16, 21, 23, 27, 33, 38, 43, 49, 53, 55}
        },
        weight = 71.2
    },
    {
        name = "Smeargle",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "250",
        movelvls = {
            {11, 21, 31, 41, 51, 61, 71, 81, 91},
            {11, 21, 31, 41, 51, 61, 71, 81, 91},
            {11, 21, 31, 41, 51, 61, 71, 81, 91},
            {11, 21, 31, 41, 51, 61, 71, 81, 91},
            {11, 21, 31, 41, 51, 61, 71, 81, 91}
        },
        weight = 58.0
    },
    {
        name = "Tyrogue",
        type = {PokemonData.POKEMON_TYPES.FIGHTING, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "20",
        bst = "210",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = 21.0
    },
    {
        name = "Hitmontop",
        type = {PokemonData.POKEMON_TYPES.FIGHTING, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "455",
        movelvls = {
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51, 55},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51, 55},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51, 55},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 46, 51, 55, 60},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 46, 51, 55, 60}
        },
        weight = 48.0
    },
    {
        name = "Smoochum",
        type = {PokemonData.POKEMON_TYPES.ICE, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = "30",
        bst = "305",
        movelvls = {
            {5, 8, 11, 15, 18, 21, 25, 28, 31, 35, 38, 41, 45},
            {5, 8, 11, 15, 18, 21, 25, 28, 31, 35, 38, 41, 45},
            {5, 8, 11, 15, 18, 21, 25, 28, 31, 35, 38, 41, 45},
            {5, 8, 11, 15, 18, 21, 25, 28, 31, 35, 38, 41, 45, 48},
            {5, 8, 11, 15, 18, 21, 25, 28, 31, 35, 38, 41, 45, 48}
        },
        weight = 6.0
    },
    {
        name = "Elekid",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "30",
        bst = "360",
        movelvls = {
            {7, 10, 16, 19, 25, 28, 34, 37, 43, 46},
            {7, 10, 16, 19, 25, 28, 34, 37, 43, 46},
            {7, 10, 16, 19, 25, 28, 34, 37, 43, 46},
            {6, 11, 16, 21, 26, 31, 36, 41, 46, 51, 56},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43}
        },
        weight = 23.5
    },
    {
        name = "Magby",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "30",
        bst = "365",
        movelvls = {
            {7, 10, 16, 19, 25, 28, 34, 37, 43, 46},
            {7, 10, 16, 19, 25, 28, 34, 37, 43, 46},
            {7, 10, 16, 19, 25, 28, 34, 37, 43, 46},
            {7, 10, 16, 19, 25, 28, 34, 37, 43, 46, 49},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43}
        },
        weight = 21.4
    },
    {
        name = "Miltank",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "490",
        movelvls = {
            {3, 5, 8, 11, 15, 19, 24, 29, 35, 41, 48, 55},
            {3, 5, 8, 11, 15, 19, 24, 29, 35, 41, 48, 55},
            {3, 5, 8, 11, 15, 19, 24, 29, 35, 41, 48, 55},
            {3, 5, 8, 11, 15, 19, 24, 29, 35, 41, 48, 55},
            {3, 5, 8, 11, 15, 19, 24, 29, 35, 41, 48, 55}
        },
        weight = 75.5
    },
    {
        name = "Blissey",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "540",
        movelvls = {
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 46},
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 46},
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 46},
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 46, 50, 54},
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 46, 50, 54}
        },
        weight = 46.8
    },
    {
        name = "Raikou",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "580",
        movelvls = {
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85}
        },
        weight = 178.0
    },
    {
        name = "Entei",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "580",
        movelvls = {
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85}
        },
        weight = 198.0
    },
    {
        name = "Suicune",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "580",
        movelvls = {
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85}
        },
        weight = 187.0
    },
    {
        name = "Larvitar",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.GROUND},
        evolution = "30",
        bst = "300",
        movelvls = {
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50, 55},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50, 55}
        },
        weight = 72.0
    },
    {
        name = "Pupitar",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.GROUND},
        evolution = "55",
        bst = "410",
        movelvls = {
            {5, 10, 14, 19, 23, 28, 34, 41, 47, 54, 60},
            {5, 10, 14, 19, 23, 28, 34, 41, 47, 54, 60},
            {5, 10, 14, 19, 23, 28, 34, 41, 47, 54, 60},
            {5, 10, 14, 19, 23, 28, 34, 41, 47, 54, 60, 67},
            {5, 10, 14, 19, 23, 28, 34, 41, 47, 54, 60, 67}
        },
        weight = 152.0
    },
    {
        name = "Tyranitar",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.DARK},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "600",
        movelvls = {
            {5, 10, 14, 19, 23, 28, 34, 41, 47, 54, 70},
            {5, 10, 14, 19, 23, 28, 34, 41, 47, 54, 70},
            {5, 10, 14, 19, 23, 28, 34, 41, 47, 54, 70},
            {5, 10, 14, 19, 23, 28, 34, 41, 47, 54, 63, 73, 82},
            {5, 10, 14, 19, 23, 28, 34, 41, 47, 54, 63, 73, 82}
        },
        weight = 202.0
    },
    {
        name = "Lugia",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "680",
        movelvls = {
            {9, 15, 23, 29, 37, 43, 51, 57, 65, 71, 79, 85, 93, 99},
            {9, 15, 23, 29, 37, 43, 51, 57, 65, 71, 79, 85, 93, 99},
            {9, 15, 23, 29, 37, 43, 50, 57, 65, 71, 79, 85, 93, 99},
            {9, 15, 23, 29, 37, 43, 50, 57, 65, 71, 79, 85, 93, 99},
            {9, 15, 23, 29, 37, 43, 50, 57, 65, 71, 79, 85, 93, 99}
        },
        weight = 216.0
    },
    {
        name = "Ho-Oh",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "680",
        movelvls = {
            {9, 15, 23, 29, 37, 43, 51, 57, 65, 71, 79, 85, 93, 99},
            {9, 15, 23, 29, 37, 43, 51, 57, 65, 71, 79, 85, 93, 99},
            {9, 15, 23, 29, 37, 43, 50, 57, 65, 71, 79, 85, 93, 99},
            {9, 15, 23, 29, 37, 43, 50, 57, 65, 71, 79, 85, 93, 99},
            {9, 15, 23, 29, 37, 43, 50, 57, 65, 71, 79, 85, 93, 99}
        },
        weight = 199.0
    },
    {
        name = "Celebi",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.GRASS},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "600",
        movelvls = {
            {10, 19, 28, 37, 46, 55, 64, 73, 82, 91},
            {10, 19, 28, 37, 46, 55, 64, 73, 82, 91},
            {10, 19, 28, 37, 46, 55, 64, 73, 82, 91},
            {10, 19, 28, 37, 46, 55, 64, 73, 82, 91},
            {10, 19, 28, 37, 46, 55, 64, 73, 82, 91}
        },
        weight = 5.0
    },
    {
        name = "Treecko",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "16",
        bst = "310",
        movelvls = {
            {6, 11, 16, 21, 26, 31, 36, 41, 46, 51},
            {6, 11, 16, 21, 26, 31, 36, 41, 46, 51},
            {6, 11, 16, 21, 26, 31, 36, 41, 46, 51},
            {6, 11, 16, 21, 26, 31, 36, 41, 46, 51},
            {6, 11, 16, 21, 26, 31, 36, 41, 46, 51}
        },
        weight = 5.0
    },
    {
        name = "Grovyle",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "36",
        bst = "405",
        movelvls = {
            {6, 11, 16, 17, 23, 29, 35, 41, 47, 53, 59},
            {6, 11, 16, 17, 23, 29, 35, 41, 47, 53, 59},
            {6, 11, 16, 17, 23, 29, 35, 41, 47, 53, 59},
            {6, 11, 16, 17, 23, 29, 35, 41, 47, 53, 59},
            {6, 11, 16, 17, 23, 29, 35, 41, 47, 53, 59}
        },
        weight = 21.6
    },
    {
        name = "Sceptile",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "530",
        movelvls = {
            {6, 11, 16, 17, 23, 29, 35, 43, 51, 59, 67},
            {6, 11, 16, 17, 23, 29, 35, 43, 51, 59, 67},
            {6, 11, 16, 17, 23, 29, 35, 43, 51, 59, 67},
            {6, 11, 16, 17, 23, 29, 35, 43, 51, 59, 67},
            {6, 11, 16, 17, 23, 29, 35, 43, 51, 59, 67}
        },
        weight = 52.2
    },
    {
        name = "Torchic",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "16",
        bst = "310",
        movelvls = {
            {7, 10, 16, 19, 25, 28, 34, 37, 43},
            {7, 10, 16, 19, 25, 28, 34, 37, 43},
            {7, 10, 16, 19, 25, 28, 34, 37, 43},
            {7, 10, 16, 19, 25, 28, 34, 37, 43},
            {7, 10, 16, 19, 25, 28, 34, 37, 43}
        },
        weight = 2.5
    },
    {
        name = "Combusken",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.FIGHTING},
        evolution = "36",
        bst = "405",
        movelvls = {
            {7, 13, 16, 17, 21, 28, 32, 39, 43, 50, 54},
            {7, 13, 16, 17, 21, 28, 32, 39, 43, 50, 54},
            {7, 13, 16, 17, 21, 28, 32, 39, 43, 50, 54},
            {7, 13, 16, 17, 21, 28, 32, 39, 43, 50, 54},
            {7, 13, 16, 17, 21, 28, 32, 39, 43, 50, 54}
        },
        weight = 19.5
    },
    {
        name = "Blaziken",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.FIGHTING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "530",
        movelvls = {
            {7, 13, 16, 17, 21, 28, 32, 36, 42, 49, 59, 66},
            {7, 13, 16, 17, 21, 28, 32, 36, 42, 49, 59, 66},
            {7, 13, 16, 17, 21, 28, 32, 36, 42, 49, 59, 66},
            {7, 13, 16, 17, 21, 28, 32, 36, 42, 49, 59, 66},
            {7, 13, 16, 17, 21, 28, 32, 36, 42, 49, 59, 66}
        },
        weight = 52.0
    },
    {
        name = "Mudkip",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "16",
        bst = "310",
        movelvls = {
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46}
        },
        weight = 7.6
    },
    {
        name = "Marshtomp",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.GROUND},
        evolution = "36",
        bst = "405",
        movelvls = {
            {6, 10, 15, 16, 20, 25, 31, 37, 42, 46, 53},
            {6, 10, 15, 16, 20, 25, 31, 37, 42, 46, 53},
            {6, 10, 15, 16, 20, 25, 31, 37, 42, 46, 53},
            {6, 10, 15, 16, 20, 25, 31, 37, 42, 46, 53},
            {6, 10, 15, 16, 20, 25, 31, 37, 42, 46, 53}
        },
        weight = 28.0
    },
    {
        name = "Swampert",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.GROUND},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "535",
        movelvls = {
            {6, 10, 15, 16, 20, 25, 31, 39, 46, 52, 61, 69},
            {6, 10, 15, 16, 20, 25, 31, 39, 46, 52, 61, 69},
            {6, 10, 15, 16, 20, 25, 31, 39, 46, 52, 61, 69},
            {6, 10, 15, 16, 20, 25, 31, 39, 46, 52, 61, 69},
            {6, 10, 15, 16, 20, 25, 31, 39, 46, 52, 61, 69}
        },
        weight = 81.9
    },
    {
        name = "Poochyena",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "18",
        bst = "220",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53}
        },
        weight = 13.6
    },
    {
        name = "Mightyena",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "420",
        movelvls = {
            {5, 9, 13, 17, 22, 27, 32, 37, 42, 47, 52, 57, 62},
            {5, 9, 13, 17, 22, 27, 32, 37, 42, 47, 52, 57, 62},
            {5, 9, 13, 17, 22, 27, 32, 37, 42, 47, 52, 57, 62},
            {5, 9, 13, 17, 22, 27, 32, 37, 42, 47, 52, 57, 62},
            {5, 9, 13, 17, 22, 27, 32, 37, 42, 47, 52, 57, 62}
        },
        weight = 37.0
    },
    {
        name = "Zigzagoon",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "20",
        bst = "240",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49}
        },
        weight = 17.5
    },
    {
        name = "Linoone",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "420",
        movelvls = {
            {5, 9, 13, 17, 23, 29, 35, 41, 47, 53, 59},
            {5, 9, 13, 17, 23, 29, 35, 41, 47, 53, 59},
            {5, 9, 13, 17, 23, 29, 35, 41, 47, 53, 59},
            {5, 9, 13, 17, 23, 29, 35, 41, 47, 53, 59, 65},
            {5, 9, 13, 17, 23, 29, 35, 41, 47, 53, 59, 65}
        },
        weight = 32.5
    },
    {
        name = "Wurmple",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "7",
        bst = "195",
        movelvls = {
            {5},
            {5, 15},
            {5, 15},
            {5, 15},
            {5, 15}
        },
        weight = 3.6
    },
    {
        name = "Silcoon",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "10",
        bst = "205",
        movelvls = {
            {7},
            {7},
            {7},
            {7},
            {7}
        },
        weight = 10.0
    },
    {
        name = "Beautifly",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "385",
        movelvls = {
            {10, 13, 17, 20, 24, 27, 31, 34, 38, 41},
            {10, 13, 17, 20, 24, 27, 31, 34, 38, 41},
            {10, 13, 17, 20, 24, 27, 31, 34, 38, 41},
            {10, 13, 17, 20, 24, 27, 31, 34, 38, 41, 45},
            {10, 13, 17, 20, 24, 27, 31, 34, 38, 41, 45}
        },
        weight = 28.4
    },
    {
        name = "Cascoon",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "10",
        bst = "205",
        movelvls = {
            {7},
            {7},
            {7},
            {7},
            {7}
        },
        weight = 11.5
    },
    {
        name = "Dustox",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.POISON},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "385",
        movelvls = {
            {10, 13, 17, 20, 24, 27, 31, 34, 38, 41},
            {10, 13, 17, 20, 24, 27, 31, 34, 38, 41},
            {10, 13, 17, 20, 24, 27, 31, 34, 38, 41},
            {10, 13, 17, 20, 24, 27, 31, 34, 38, 41, 45},
            {10, 13, 17, 20, 24, 27, 31, 34, 38, 41, 45}
        },
        weight = 31.6
    },
    {
        name = "Lotad",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.GRASS},
        evolution = "14",
        bst = "220",
        movelvls = {
            {3, 5, 7, 11, 15, 19, 27, 35, 43},
            {3, 5, 7, 11, 15, 19, 25, 31, 37, 45},
            {3, 5, 7, 11, 15, 19, 25, 31, 37, 45},
            {3, 5, 7, 11, 15, 19, 25, 31, 37, 45},
            {3, 5, 7, 11, 15, 19, 25, 31, 37, 45}
        },
        weight = 2.6
    },
    {
        name = "Lombre",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.GRASS},
        evolution = PokemonData.EVOLUTION_TYPES.WATER,
        bst = "340",
        movelvls = {
            {3, 5, 7, 11, 15, 19, 27, 35, 43},
            {3, 5, 7, 11, 15, 19, 25, 31, 37, 45},
            {3, 5, 7, 11, 15, 19, 25, 31, 37, 45},
            {3, 5, 7, 11, 15, 19, 25, 31, 37, 45},
            {3, 5, 7, 11, 15, 19, 25, 31, 37, 45}
        },
        weight = 32.5
    },
    {
        name = "Ludicolo",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.GRASS},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "480",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = 55.0
    },
    {
        name = "Seedot",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "14",
        bst = "220",
        movelvls = {
            {3, 7, 13, 21, 31, 43},
            {3, 7, 13, 21, 31, 43},
            {3, 7, 13, 21, 31, 43},
            {3, 7, 13, 21, 31, 43},
            {3, 7, 13, 21, 31, 43}
        },
        weight = 4.0
    },
    {
        name = "Nuzleaf",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.DARK},
        evolution = PokemonData.EVOLUTION_TYPES.LEAF,
        bst = "340",
        movelvls = {
            {3, 7, 13, 19, 25, 31, 37, 43, 49},
            {3, 7, 13, 19, 25, 31, 37, 43, 49},
            {3, 7, 13, 19, 25, 31, 37, 43, 49},
            {3, 7, 13, 19, 25, 31, 37, 43, 49},
            {3, 7, 13, 19, 25, 31, 37, 43, 49}
        },
        weight = 28.0
    },
    {
        name = "Shiftry",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.DARK},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "480",
        movelvls = {
            {49},
            {49},
            {49},
            {19, 49},
            {19, 49}
        },
        weight = 59.6
    },
    {
        name = "Taillow",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = "22",
        bst = "270",
        movelvls = {
            {4, 8, 13, 19, 26, 34, 43, 53},
            {4, 8, 13, 19, 26, 34, 43, 53},
            {4, 8, 13, 19, 26, 34, 43, 53},
            {4, 8, 13, 19, 26, 34, 43, 53},
            {4, 8, 13, 19, 26, 34, 43, 53}
        },
        weight = 2.3
    },
    {
        name = "Swellow",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "430",
        movelvls = {
            {4, 8, 13, 19, 28, 38, 49, 61},
            {4, 8, 13, 19, 28, 38, 49, 61},
            {4, 8, 13, 19, 28, 38, 49, 61},
            {4, 8, 13, 19, 28, 38, 49, 61},
            {4, 8, 13, 19, 28, 38, 49, 61}
        },
        weight = 19.8
    },
    {
        name = "Wingull",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.FLYING},
        evolution = "25",
        bst = "270",
        movelvls = {
            {6, 11, 16, 19, 24, 29, 34, 37, 42, 47},
            {6, 11, 16, 19, 24, 29, 34, 37, 42, 47},
            {6, 11, 16, 19, 24, 29, 34, 37, 42, 47},
            {6, 11, 16, 19, 24, 29, 34, 37, 42, 47, 50},
            {6, 9, 14, 17, 22, 26, 30, 33, 38, 42, 46, 49}
        },
        weight = 9.5
    },
    {
        name = "Pelipper",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "430",
        movelvls = {
            {6, 11, 16, 19, 24, 25, 31, 38, 38, 38, 43, 50, 57},
            {6, 11, 16, 19, 24, 25, 31, 38, 38, 38, 43, 50, 57},
            {6, 11, 16, 19, 24, 25, 31, 38, 38, 38, 43, 50, 57},
            {6, 11, 16, 19, 24, 25, 31, 38, 38, 38, 43, 50, 57, 63},
            {6, 9, 14, 17, 22, 25, 28, 34, 39, 39, 39, 46, 52, 58, 63}
        },
        weight = 28.0
    },
    {
        name = "Ralts",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "20",
        bst = "198",
        movelvls = {
            {6, 10, 12, 17, 21, 23, 28, 32, 34, 39, 43, 45},
            {6, 10, 12, 17, 21, 23, 28, 32, 34, 39, 43, 45},
            {6, 10, 12, 17, 21, 23, 28, 32, 34, 39, 43, 45},
            {6, 10, 12, 17, 21, 23, 28, 32, 34, 39, 43, 45, 50, 54},
            {6, 10, 12, 17, 21, 23, 28, 32, 34, 39, 43, 45, 50, 54}
        },
        weight = 6.6
    },
    {
        name = "Kirlia",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.KIRLIA,
        bst = "278",
        movelvls = {
            {6, 10, 12, 17, 22, 25, 31, 36, 39, 45, 50, 53},
            {6, 10, 12, 17, 22, 25, 31, 36, 39, 45, 50, 53},
            {6, 10, 12, 17, 22, 25, 31, 36, 39, 45, 50, 53},
            {6, 10, 12, 17, 22, 25, 31, 36, 39, 45, 50, 53, 59, 64},
            {6, 10, 12, 17, 22, 25, 31, 36, 39, 45, 50, 53, 59, 64}
        },
        weight = 20.2
    },
    {
        name = "Gardevoir",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "518",
        movelvls = {
            {6, 10, 12, 17, 22, 25, 33, 40, 45, 53, 60, 65},
            {6, 10, 12, 17, 22, 25, 33, 40, 45, 53, 60, 65},
            {6, 10, 12, 17, 22, 25, 33, 40, 45, 53, 60, 65},
            {6, 10, 12, 17, 22, 25, 33, 40, 45, 53, 60, 65, 73, 80},
            {6, 10, 12, 17, 22, 25, 33, 40, 45, 53, 60, 65, 73, 80}
        },
        weight = 48.4
    },
    {
        name = "Surskit",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.WATER},
        evolution = "22",
        bst = "269",
        movelvls = {
            {7, 13, 19, 25, 31, 37, 37, 43},
            {7, 13, 19, 25, 31, 37, 37, 43},
            {7, 13, 19, 25, 31, 37, 37, 43},
            {7, 13, 19, 25, 31, 37, 37, 43},
            {7, 13, 19, 25, 31, 37, 37, 43}
        },
        weight = 1.7
    },
    {
        name = "Masquerain",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "414",
        movelvls = {
            {7, 13, 19, 22, 26, 33, 40, 47, 54, 61},
            {7, 13, 19, 22, 26, 33, 40, 47, 54, 61},
            {7, 13, 19, 22, 26, 33, 40, 47, 54, 61},
            {7, 13, 19, 22, 26, 33, 40, 47, 54, 61, 68},
            {7, 13, 19, 22, 26, 33, 40, 47, 54, 61, 68}
        },
        weight = 3.6
    },
    {
        name = "Shroomish",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "23",
        bst = "295",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45}
        },
        weight = 4.5
    },
    {
        name = "Breloom",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.FIGHTING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "460",
        movelvls = {
            {5, 9, 13, 17, 21, 23, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 23, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 23, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 23, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 23, 25, 29, 33, 37, 41, 45}
        },
        weight = 39.2
    },
    {
        name = "Slakoth",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "18",
        bst = "280",
        movelvls = {
            {7, 13, 19, 25, 31, 37, 43},
            {7, 13, 19, 25, 31, 37, 43},
            {7, 13, 19, 25, 31, 37, 43},
            {7, 13, 19, 25, 31, 37, 43, 49},
            {7, 13, 19, 25, 31, 37, 43, 49}
        },
        weight = 24.0
    },
    {
        name = "Vigoroth",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "36",
        bst = "440",
        movelvls = {
            {7, 13, 19, 25, 31, 37, 43, 49},
            {7, 13, 19, 25, 31, 37, 43, 49},
            {7, 13, 19, 25, 31, 37, 43, 49},
            {7, 13, 19, 25, 31, 37, 43, 49, 55},
            {7, 13, 19, 25, 31, 37, 43, 49, 55}
        },
        weight = 46.5
    },
    {
        name = "Slaking",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "670",
        movelvls = {
            {7, 13, 19, 25, 31, 36, 37, 43, 49, 55, 61},
            {7, 13, 19, 25, 31, 36, 37, 43, 49, 55, 61},
            {7, 13, 19, 25, 31, 36, 37, 43, 49, 55, 61},
            {7, 13, 19, 25, 31, 36, 37, 43, 49, 55, 61, 67},
            {7, 13, 19, 25, 31, 36, 37, 43, 49, 55, 61, 67}
        },
        weight = 130.5
    },
    {
        name = "Nincada",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.GROUND},
        evolution = "20",
        bst = "266",
        movelvls = {
            {5, 9, 14, 19, 25, 31, 38, 45},
            {5, 9, 14, 19, 25, 31, 38, 45},
            {5, 9, 14, 19, 25, 31, 38, 45},
            {5, 9, 14, 19, 25, 31, 38, 45},
            {5, 9, 14, 19, 25, 31, 38, 45}
        },
        weight = 5.5
    },
    {
        name = "Ninjask",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "456",
        movelvls = {
            {5, 9, 14, 19, 20, 20, 20, 25, 31, 38, 45, 52},
            {5, 9, 14, 19, 20, 20, 20, 25, 31, 38, 45, 52},
            {5, 9, 14, 19, 20, 20, 20, 25, 31, 38, 45, 52},
            {5, 9, 14, 19, 20, 20, 20, 25, 31, 38, 45, 52},
            {5, 9, 14, 19, 20, 20, 20, 25, 31, 38, 45, 52}
        },
        weight = 12.0
    },
    {
        name = "Shedinja",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.GHOST},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "236",
        movelvls = {
            {5, 9, 14, 19, 25, 31, 38, 45, 52, 59},
            {5, 9, 14, 19, 25, 31, 38, 45, 52, 59},
            {5, 9, 14, 19, 25, 31, 38, 45, 52, 59},
            {5, 9, 14, 19, 25, 31, 38, 45, 52, 59},
            {5, 9, 14, 19, 25, 31, 38, 45, 52, 59}
        },
        weight = 1.2
    },
    {
        name = "Whismur",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "20",
        bst = "240",
        movelvls = {
            {5, 11, 15, 21, 25, 31, 35, 41, 41, 45},
            {5, 11, 15, 21, 25, 31, 35, 41, 41, 45},
            {5, 11, 15, 21, 25, 31, 35, 41, 41, 45},
            {5, 11, 15, 21, 25, 31, 35, 41, 45, 45, 51},
            {5, 11, 15, 21, 25, 31, 35, 41, 45, 45, 51}
        },
        weight = 16.3
    },
    {
        name = "Loudred",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "40",
        bst = "360",
        movelvls = {
            {5, 11, 15, 20, 23, 29, 37, 43, 51, 51, 57},
            {5, 11, 15, 20, 23, 29, 37, 43, 51, 51, 57},
            {5, 11, 15, 20, 23, 29, 37, 43, 51, 51, 57},
            {5, 11, 15, 20, 23, 29, 37, 43, 51, 57, 57, 65},
            {5, 11, 15, 20, 23, 29, 37, 43, 51, 57, 57, 65}
        },
        weight = 40.5
    },
    {
        name = "Exploud",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "480",
        movelvls = {
            {5, 11, 15, 20, 23, 29, 37, 40, 45, 55, 55, 63, 71},
            {5, 11, 15, 20, 23, 29, 37, 40, 45, 55, 55, 63, 71},
            {5, 11, 15, 20, 23, 29, 37, 40, 45, 55, 55, 63, 71},
            {5, 11, 15, 20, 23, 29, 37, 40, 45, 55, 55, 63, 71, 79},
            {5, 11, 15, 20, 23, 29, 37, 40, 45, 55, 55, 63, 71, 79}
        },
        weight = 84.0
    },
    {
        name = "Makuhita",
        type = {PokemonData.POKEMON_TYPES.FIGHTING, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "24",
        bst = "237",
        movelvls = {
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46}
        },
        weight = 86.4
    },
    {
        name = "Hariyama",
        type = {PokemonData.POKEMON_TYPES.FIGHTING, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "474",
        movelvls = {
            {4, 7, 10, 13, 16, 19, 22, 27, 32, 37, 42, 47, 52, 57},
            {4, 7, 10, 13, 16, 19, 22, 27, 32, 37, 42, 47, 52, 57},
            {4, 7, 10, 13, 16, 19, 22, 27, 32, 37, 42, 47, 52, 57},
            {4, 7, 10, 13, 16, 19, 22, 27, 32, 37, 42, 47, 52, 57, 62},
            {4, 7, 10, 13, 16, 19, 22, 27, 32, 37, 42, 47, 52, 57, 62}
        },
        weight = 253.8
    },
    {
        name = "Azurill",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.FRIEND,
        baseFriendship = 70,
        bst = "190",
        movelvls = {
            {2, 7, 10, 15, 18},
            {2, 7, 10, 15, 18},
            {2, 7, 10, 15, 18},
            {2, 7, 10, 15, 18},
            {2, 5, 7, 10, 13, 16, 20, 23}
        },
        weight = 2.0
    },
    {
        name = "Nosepass",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "40",
        bst = "375",
        movelvls = {
            {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73},
            {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73, 79},
            {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73, 79},
            {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73, 79},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46, 50, 50}
        },
        weight = 97.0
    },
    {
        name = "Skitty",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.MOON,
        bst = "260",
        movelvls = {
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 42},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 42, 46},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 42, 46},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 42, 46},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 42, 46}
        },
        weight = 11.0
    },
    {
        name = "Delcatty",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "380",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = 32.6
    },
    {
        name = "Sableye",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.GHOST},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "380",
        movelvls = {
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46, 50, 53, 57},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46, 50, 53, 57},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46, 50, 53, 57},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46, 50, 53, 57, 60},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46, 50, 53, 57, 60}
        },
        weight = 11.0
    },
    {
        name = "Mawile",
        type = {PokemonData.POKEMON_TYPES.STEEL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "380",
        movelvls = {
            {6, 11, 16, 21, 26, 31, 36, 41, 46, 51, 51, 51, 56},
            {6, 11, 16, 21, 26, 31, 36, 41, 46, 51, 51, 51, 56},
            {6, 11, 16, 21, 26, 31, 36, 41, 46, 51, 51, 51, 56},
            {6, 11, 16, 21, 26, 31, 36, 41, 46, 51, 51, 51, 56},
            {6, 11, 16, 21, 26, 31, 36, 41, 46, 51, 51, 51, 56}
        },
        weight = 11.5
    },
    {
        name = "Aron",
        type = {PokemonData.POKEMON_TYPES.STEEL, PokemonData.POKEMON_TYPES.ROCK},
        evolution = "32",
        bst = "330",
        movelvls = {
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46, 50, 53},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46, 50}
        },
        weight = 60.0
    },
    {
        name = "Lairon",
        type = {PokemonData.POKEMON_TYPES.STEEL, PokemonData.POKEMON_TYPES.ROCK},
        evolution = "42",
        bst = "430",
        movelvls = {
            {4, 8, 11, 15, 18, 22, 25, 29, 34, 40, 45, 51, 56},
            {4, 8, 11, 15, 18, 22, 25, 29, 34, 40, 45, 51, 56},
            {4, 8, 11, 15, 18, 22, 25, 29, 34, 40, 45, 51, 56},
            {4, 8, 11, 15, 18, 22, 25, 29, 34, 40, 45, 51, 56, 62, 67},
            {4, 8, 11, 15, 18, 22, 25, 29, 34, 40, 45, 51, 56, 62}
        },
        weight = 120.0
    },
    {
        name = "Aggron",
        type = {PokemonData.POKEMON_TYPES.STEEL, PokemonData.POKEMON_TYPES.ROCK},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "530",
        movelvls = {
            {4, 8, 11, 15, 18, 22, 25, 29, 34, 40, 48, 57, 65},
            {4, 8, 11, 15, 18, 22, 25, 29, 34, 40, 48, 57, 65},
            {4, 8, 11, 15, 18, 22, 25, 29, 34, 40, 48, 57, 65},
            {4, 8, 11, 15, 18, 22, 25, 29, 34, 40, 48, 57, 65, 74, 82},
            {4, 8, 11, 15, 18, 22, 25, 29, 34, 40, 48, 57, 65, 74}
        },
        weight = 360.0
    },
    {
        name = "Meditite",
        type = {PokemonData.POKEMON_TYPES.FIGHTING, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = "37",
        bst = "280",
        movelvls = {
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46, 50},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46, 50}
        },
        weight = 11.2
    },
    {
        name = "Medicham",
        type = {PokemonData.POKEMON_TYPES.FIGHTING, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "410",
        movelvls = {
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 42, 49, 55},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 42, 49, 55},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 42, 49, 55},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 42, 49, 55, 62},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 42, 49, 55, 62}
        },
        weight = 31.5
    },
    {
        name = "Electrike",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "26",
        bst = "295",
        movelvls = {
            {4, 9, 12, 17, 20, 25, 28, 33, 36, 41, 44, 49},
            {4, 9, 12, 17, 20, 25, 28, 33, 36, 41, 44, 49},
            {4, 9, 12, 17, 20, 25, 28, 33, 36, 41, 44, 49},
            {4, 9, 12, 17, 20, 25, 28, 33, 36, 41, 44, 49, 52},
            {4, 9, 12, 17, 20, 25, 28, 33, 36, 41, 44, 49, 52}
        },
        weight = 15.2
    },
    {
        name = "Manectric",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "475",
        movelvls = {
            {4, 9, 12, 17, 20, 25, 30, 37, 42, 49, 54, 61},
            {4, 9, 12, 17, 20, 25, 30, 37, 42, 49, 54, 61},
            {4, 9, 12, 17, 20, 25, 30, 37, 42, 49, 54, 61},
            {4, 9, 12, 17, 20, 25, 30, 37, 42, 49, 54, 61, 66},
            {4, 9, 12, 17, 20, 25, 30, 37, 42, 49, 54, 61, 66}
        },
        weight = 40.2
    },
    {
        name = "Plusle",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "405",
        movelvls = {
            {3, 7, 10, 15, 17, 21, 24, 29, 31, 35, 38, 42, 44, 48, 51},
            {3, 7, 10, 15, 17, 21, 24, 29, 31, 35, 38, 42, 44, 48, 51},
            {3, 7, 10, 15, 17, 21, 24, 29, 31, 35, 38, 42, 44, 48, 51},
            {3, 7, 10, 15, 17, 21, 24, 29, 31, 35, 38, 42, 44, 48, 51, 56, 63},
            {3, 7, 10, 15, 17, 21, 24, 29, 31, 35, 38, 42, 44, 48, 51, 56, 63}
        },
        weight = 4.2
    },
    {
        name = "Minun",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "405",
        movelvls = {
            {3, 7, 10, 15, 17, 21, 24, 29, 31, 35, 38, 42, 44, 48, 51},
            {3, 7, 10, 15, 17, 21, 24, 29, 31, 35, 38, 42, 44, 48, 51},
            {3, 7, 10, 15, 17, 21, 24, 29, 31, 35, 38, 42, 44, 48, 51},
            {3, 7, 10, 15, 17, 21, 24, 29, 31, 35, 38, 42, 44, 48, 51, 56, 63},
            {3, 7, 10, 15, 17, 21, 24, 29, 31, 35, 38, 42, 44, 48, 51, 56, 63}
        },
        weight = 4.2
    },
    {
        name = "Volbeat",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "400",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45}
        },
        weight = 17.7
    },
    {
        name = "Illumise",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "400",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45}
        },
        weight = 17.7
    },
    {
        name = "Roselia",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.POISON},
        evolution = PokemonData.EVOLUTION_TYPES.SHINY_STONE,
        bst = "400",
        movelvls = {
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46}
        },
        weight = 2.0
    },
    {
        name = "Gulpin",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "26",
        bst = "302",
        movelvls = {
            {6, 9, 14, 17, 23, 28, 34, 34, 34, 39, 44, 49, 54},
            {6, 9, 14, 17, 23, 28, 34, 34, 34, 39, 44, 49, 54},
            {6, 9, 14, 17, 23, 28, 34, 34, 34, 39, 44, 49, 54},
            {6, 9, 14, 17, 23, 28, 34, 39, 39, 39, 44, 49, 54, 59},
            {6, 9, 14, 17, 23, 28, 34, 39, 39, 39, 44, 49, 54, 59}
        },
        weight = 10.3
    },
    {
        name = "Swalot",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "467",
        movelvls = {
            {6, 9, 14, 17, 23, 26, 30, 38, 38, 38, 45, 52, 59, 66},
            {6, 9, 14, 17, 23, 26, 30, 38, 38, 38, 45, 52, 59, 66},
            {6, 9, 14, 17, 23, 26, 30, 38, 38, 38, 45, 52, 59, 66},
            {6, 9, 14, 17, 23, 26, 30, 38, 45, 45, 45, 52, 59, 66, 73},
            {6, 9, 14, 17, 23, 26, 30, 38, 45, 45, 45, 52, 59, 66, 73}
        },
        weight = 80.0
    },
    {
        name = "Carvanha",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.DARK},
        evolution = "30",
        bst = "305",
        movelvls = {
            {6, 8, 11, 16, 18, 21, 26, 28, 31, 36, 38},
            {6, 8, 11, 16, 18, 21, 26, 28, 31, 36, 38},
            {6, 8, 11, 16, 18, 21, 26, 28, 31, 36, 38},
            {6, 8, 11, 16, 18, 21, 26, 28, 31, 36, 38},
            {6, 8, 11, 16, 18, 21, 26, 28, 31, 36, 38}
        },
        weight = 20.8
    },
    {
        name = "Sharpedo",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.DARK},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "460",
        movelvls = {
            {6, 8, 11, 16, 18, 21, 26, 28, 30, 34, 40, 45, 50, 56},
            {6, 8, 11, 16, 18, 21, 26, 28, 30, 34, 40, 45, 50, 56},
            {6, 8, 11, 16, 18, 21, 26, 28, 30, 34, 40, 45, 50, 56},
            {6, 8, 11, 16, 18, 21, 26, 28, 30, 34, 40, 45, 50, 56},
            {6, 8, 11, 16, 18, 21, 26, 28, 30, 34, 40, 45, 50, 56}
        },
        weight = 88.8
    },
    {
        name = "Wailmer",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "40",
        bst = "400",
        movelvls = {
            {4, 7, 11, 14, 17, 21, 24, 27, 31, 34, 37, 41, 44, 47},
            {4, 7, 11, 14, 17, 21, 24, 27, 31, 34, 37, 41, 44, 47},
            {4, 7, 11, 14, 17, 21, 24, 27, 31, 34, 37, 41, 44, 47},
            {4, 7, 11, 14, 17, 21, 24, 27, 31, 34, 37, 41, 44, 47, 50},
            {4, 7, 11, 14, 17, 21, 24, 27, 31, 34, 37, 41, 44, 47, 50}
        },
        weight = 130.0
    },
    {
        name = "Wailord", -- STONKS
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "500",
        movelvls = {
            {4, 7, 11, 14, 17, 21, 24, 27, 31, 34, 37, 46, 54, 62},
            {4, 7, 11, 14, 17, 21, 24, 27, 31, 34, 37, 46, 54, 62},
            {4, 7, 11, 14, 17, 21, 24, 27, 31, 34, 37, 46, 54, 62},
            {4, 7, 11, 14, 17, 21, 24, 27, 31, 34, 37, 46, 54, 62, 70},
            {4, 7, 11, 14, 17, 21, 24, 27, 31, 34, 37, 46, 54, 62, 70}
        },
        weight = 398.0
    },
    {
        name = "Numel",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.GROUND},
        evolution = "33",
        bst = "305",
        movelvls = {
            {5, 11, 15, 21, 25, 31, 35, 41, 45, 51},
            {5, 11, 15, 21, 25, 31, 35, 41, 45, 51},
            {5, 11, 15, 21, 25, 31, 35, 41, 45, 51},
            {5, 11, 15, 21, 25, 31, 35, 41, 45, 51, 55},
            {5, 8, 12, 15, 19, 22, 26, 29, 31, 36, 40, 43, 47}
        },
        weight = 24.0
    },
    {
        name = "Camerupt",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.GROUND},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "460",
        movelvls = {
            {5, 11, 15, 21, 25, 31, 33, 39, 49, 57, 67},
            {5, 11, 15, 21, 25, 31, 33, 39, 49, 57, 67},
            {5, 11, 15, 21, 25, 31, 33, 39, 49, 57, 67},
            {5, 11, 15, 21, 25, 31, 33, 39, 49, 57, 67, 75},
            {5, 8, 12, 15, 19, 22, 26, 29, 31, 33, 39, 46, 52, 59}
        },
        weight = 220.0
    },
    {
        name = "Torkoal",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "470",
        movelvls = {
            {4, 7, 12, 17, 20, 23, 28, 33, 36, 39, 44, 49, 52, 55},
            {4, 7, 12, 17, 20, 23, 28, 33, 36, 39, 44, 49, 52, 55},
            {4, 7, 12, 17, 20, 23, 28, 33, 36, 39, 44, 49, 52, 55},
            {4, 7, 12, 17, 20, 23, 28, 33, 36, 39, 44, 49, 52, 55, 60, 65},
            {4, 7, 12, 17, 20, 23, 28, 33, 36, 39, 44, 49, 52, 55, 60, 65}
        },
        weight = 80.4
    },
    {
        name = "Spoink",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "32",
        bst = "330",
        movelvls = {
            {7, 10, 14, 15, 18, 21, 26, 29, 29, 34, 41, 46, 48},
            {7, 10, 14, 15, 18, 21, 26, 29, 29, 34, 41, 46, 48},
            {7, 10, 14, 15, 18, 21, 26, 29, 29, 34, 41, 46, 48},
            {7, 10, 14, 15, 18, 21, 26, 29, 29, 34, 41, 46, 48, 53},
            {7, 10, 14, 15, 18, 21, 26, 29, 29, 33, 38, 40, 44, 50}
        },
        weight = 30.6
    },
    {
        name = "Grumpig",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "470",
        movelvls = {
            {7, 10, 14, 15, 18, 21, 26, 29, 29, 37, 47, 55, 60},
            {7, 10, 14, 15, 18, 21, 26, 29, 29, 37, 47, 55, 60},
            {7, 10, 14, 15, 18, 21, 26, 29, 29, 37, 47, 55, 60},
            {7, 10, 14, 15, 18, 21, 26, 29, 29, 37, 47, 55, 60, 68},
            {7, 10, 14, 15, 18, 21, 26, 29, 29, 35, 42, 46, 52, 60}
        },
        weight = 71.5
    },
    {
        name = "Spinda",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "360",
        movelvls = {
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50, 55},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50, 55},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50, 55},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50, 55},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50, 55}
        },
        weight = 5.0
    },
    {
        name = "Trapinch",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "35",
        bst = "290",
        movelvls = {
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89},
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89},
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89},
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89},
            {4, 7, 10, 13, 17, 21, 25, 29, 34, 39, 44, 49, 55, 61, 67, 73}
        },
        weight = 15.0
    },
    {
        name = "Vibrava",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.DRAGON},
        evolution = "45",
        bst = "340",
        movelvls = {
            {9, 17, 25, 33, 35, 41, 49, 57},
            {9, 17, 25, 33, 35, 41, 49, 57},
            {9, 17, 25, 33, 35, 41, 49, 57},
            {9, 17, 25, 33, 35, 41, 49, 57},
            {4, 7, 10, 13, 17, 21, 25, 29, 34, 35, 39, 44, 49}
        },
        weight = 15.3
    },
    {
        name = "Flygon",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.DRAGON},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "520",
        movelvls = {
            {9, 17, 25, 33, 35, 41, 45, 49, 57},
            {9, 17, 25, 33, 35, 41, 45, 49, 57},
            {9, 17, 25, 33, 35, 41, 45, 49, 57},
            {9, 17, 25, 33, 35, 41, 45, 49, 57, 65},
            {4, 7, 10, 13, 17, 21, 25, 29, 34, 35, 39, 44, 45, 49, 55}
        },
        weight = 82.0
    },
    {
        name = "Cacnea",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "32",
        bst = "335",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57}
        },
        weight = 51.3
    },
    {
        name = "Cacturne",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.DARK},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "475",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 35, 41, 47, 53, 59, 65, 71},
            {5, 9, 13, 17, 21, 25, 29, 35, 41, 47, 53, 59, 65, 71},
            {5, 9, 13, 17, 21, 25, 29, 35, 41, 47, 53, 59, 65, 71},
            {5, 9, 13, 17, 21, 25, 29, 35, 41, 47, 53, 59, 65, 71},
            {5, 9, 13, 17, 21, 25, 29, 35, 41, 47, 53, 59, 65, 71}
        },
        weight = 77.4
    },
    {
        name = "Swablu",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = "35",
        bst = "310",
        movelvls = {
            {5, 9, 13, 18, 23, 28, 32, 36, 40, 45, 50},
            {5, 9, 13, 18, 23, 28, 32, 36, 40, 45, 50},
            {5, 9, 13, 18, 23, 28, 32, 36, 40, 45, 50},
            {5, 9, 13, 18, 23, 28, 32, 36, 40, 45, 50, 55},
            {4, 8, 10, 13, 15, 18, 21, 25, 29, 34, 39, 42, 48}
        },
        weight = 1.2
    },
    {
        name = "Altaria",
        type = {PokemonData.POKEMON_TYPES.DRAGON, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "490",
        movelvls = {
            {5, 9, 13, 18, 23, 28, 32, 35, 39, 46, 54, 62, 70},
            {5, 9, 13, 18, 23, 28, 32, 35, 39, 46, 54, 62, 70},
            {5, 9, 13, 18, 23, 28, 32, 35, 39, 46, 54, 62, 70},
            {5, 9, 13, 18, 23, 28, 32, 35, 39, 46, 54, 62, 70, 77},
            {4, 8, 10, 13, 15, 18, 21, 25, 29, 34, 35, 42, 48, 57, 64}
        },
        weight = 20.6
    },
    {
        name = "Zangoose",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "458",
        movelvls = {
            {5, 9, 14, 18, 22, 27, 31, 35, 40, 44, 48, 53},
            {5, 9, 14, 18, 22, 27, 31, 35, 40, 44, 48, 53},
            {5, 9, 14, 18, 22, 27, 31, 35, 40, 44, 48, 53},
            {5, 9, 14, 18, 22, 27, 31, 35, 40, 44, 48, 53},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43, 47}
        },
        weight = 40.3
    },
    {
        name = "Seviper",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "458",
        movelvls = {
            {7, 10, 16, 19, 25, 28, 34, 37, 43, 46, 52, 55},
            {7, 10, 16, 19, 25, 28, 34, 37, 43, 46, 52, 55},
            {7, 10, 16, 19, 25, 28, 34, 37, 43, 46, 52, 55},
            {7, 10, 16, 19, 25, 28, 34, 37, 43, 46, 52, 55, 61, 64},
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 45, 49, 53}
        },
        weight = 52.5
    },
    {
        name = "Lunatone",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "440",
        movelvls = {
            {9, 12, 20, 23, 31, 34, 42, 45, 53, 56},
            {9, 12, 20, 23, 31, 34, 42, 45, 53, 56},
            {9, 12, 20, 23, 31, 34, 42, 45, 53, 56},
            {9, 12, 20, 23, 31, 34, 42, 45, 53, 56, 64},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53}
        },
        weight = 168.0
    },
    {
        name = "Solrock",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "440",
        movelvls = {
            {9, 12, 20, 23, 31, 34, 42, 45, 53, 56},
            {9, 12, 20, 23, 31, 34, 42, 45, 53, 56},
            {9, 12, 20, 23, 31, 34, 42, 45, 53, 56},
            {9, 12, 20, 23, 31, 34, 42, 45, 53, 56, 64},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53}
        },
        weight = 154.0
    },
    {
        name = "Barboach",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.GROUND},
        evolution = "30",
        bst = "288",
        movelvls = {
            {6, 6, 10, 14, 18, 22, 26, 31, 31, 35, 39, 43, 47},
            {6, 6, 10, 14, 18, 22, 26, 31, 31, 35, 39, 43, 47},
            {6, 6, 10, 14, 18, 22, 26, 31, 31, 35, 39, 43, 47},
            {6, 6, 10, 14, 18, 22, 26, 31, 31, 35, 39, 43, 47},
            {6, 6, 10, 14, 18, 22, 26, 31, 31, 35, 39, 43, 47}
        },
        weight = 1.9
    },
    {
        name = "Whiscash",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.GROUND},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "468",
        movelvls = {
            {6, 6, 10, 14, 18, 22, 26, 33, 33, 39, 45, 51, 57},
            {6, 6, 10, 14, 18, 22, 26, 33, 33, 39, 45, 51, 57},
            {6, 6, 10, 14, 18, 22, 26, 33, 33, 39, 45, 51, 57},
            {6, 6, 10, 14, 18, 22, 26, 33, 33, 39, 45, 51, 57},
            {6, 6, 10, 14, 18, 22, 26, 33, 33, 39, 45, 51, 57}
        },
        weight = 23.6
    },
    {
        name = "Corphish",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "30",
        bst = "308",
        movelvls = {
            {7, 10, 13, 20, 23, 26, 32, 35, 38, 44, 47, 53},
            {7, 10, 13, 20, 23, 26, 32, 35, 38, 44, 47, 53},
            {7, 10, 13, 20, 23, 26, 32, 35, 38, 44, 47, 53},
            {7, 10, 13, 20, 23, 26, 32, 35, 38, 44, 47, 53},
            {7, 10, 13, 20, 23, 26, 32, 35, 38, 44, 47, 53}
        },
        weight = 11.5
    },
    {
        name = "Crawdaunt", -- FRAUD
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.DARK},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "468",
        movelvls = {
            {7, 10, 13, 20, 23, 26, 30, 34, 39, 44, 52, 57, 65},
            {7, 10, 13, 20, 23, 26, 30, 34, 39, 44, 52, 57, 65},
            {7, 10, 13, 20, 23, 26, 30, 34, 39, 44, 52, 57, 65},
            {7, 10, 13, 20, 23, 26, 30, 34, 39, 44, 52, 57, 65},
            {7, 10, 13, 20, 23, 26, 30, 34, 39, 44, 52, 57, 65}
        },
        weight = 32.8
    },
    {
        name = "Baltoy",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = "36",
        bst = "300",
        movelvls = {
            {3, 5, 7, 11, 15, 19, 25, 31, 37, 45, 53, 61, 71},
            {3, 5, 7, 11, 15, 19, 25, 31, 37, 45, 53, 61, 71},
            {3, 5, 7, 11, 15, 19, 25, 31, 37, 45, 53, 61, 71},
            {4, 7, 11, 15, 18, 21, 26, 31, 34, 37, 43, 48, 48, 51, 54, 60},
            {4, 7, 10, 13, 17, 21, 25, 28, 31, 34, 34, 37, 41, 45, 49}
        },
        weight = 21.5
    },
    {
        name = "Claydol",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "500",
        movelvls = {
            {3, 5, 7, 11, 15, 19, 25, 31, 36, 40, 51, 62, 73, 86},
            {3, 5, 7, 11, 15, 19, 25, 31, 36, 40, 51, 62, 73, 86},
            {3, 5, 7, 11, 15, 19, 25, 31, 36, 40, 51, 62, 73, 86},
            {4, 7, 11, 15, 18, 21, 26, 31, 34, 36, 39, 47, 54, 54, 59, 64, 72},
            {4, 7, 10, 13, 17, 21, 25, 28, 31, 34, 34, 36, 40, 47, 54, 61}
        },
        weight = 108.0
    },
    {
        name = "Lileep",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.GRASS},
        evolution = "40",
        bst = "355",
        movelvls = {
            {8, 15, 22, 29, 36, 43, 50, 57, 57, 57, 64},
            {8, 15, 22, 29, 36, 43, 50, 57, 57, 57, 64},
            {8, 15, 22, 29, 36, 43, 50, 57, 57, 57, 64},
            {8, 15, 22, 29, 36, 43, 50, 57, 57, 57, 64},
            {8, 15, 22, 29, 36, 43, 50, 57, 57, 57, 64}
        },
        weight = 23.8
    },
    {
        name = "Cradily",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.GRASS},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "495",
        movelvls = {
            {8, 15, 22, 29, 36, 46, 56, 66, 66, 66, 76},
            {8, 15, 22, 29, 36, 46, 56, 66, 66, 66, 76},
            {8, 15, 22, 29, 36, 46, 56, 66, 66, 66, 76},
            {8, 15, 22, 29, 36, 46, 56, 66, 66, 66, 76},
            {8, 15, 22, 29, 36, 46, 56, 66, 66, 66, 76}
        },
        weight = 60.4
    },
    {
        name = "Anorith",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.BUG},
        evolution = "40",
        bst = "355",
        movelvls = {
            {7, 13, 19, 25, 31, 37, 43, 49, 55, 61},
            {7, 13, 19, 25, 31, 37, 43, 49, 55, 61},
            {7, 13, 19, 25, 31, 37, 43, 49, 55, 61},
            {7, 13, 19, 25, 31, 37, 43, 49, 55, 61},
            {7, 13, 19, 25, 31, 37, 43, 49, 55, 61}
        },
        weight = 12.5
    },
    {
        name = "Armaldo",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.BUG},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "495",
        movelvls = {
            {7, 13, 19, 25, 31, 37, 46, 55, 67, 73},
            {7, 13, 19, 25, 31, 37, 46, 55, 67, 73},
            {7, 13, 19, 25, 31, 37, 46, 55, 67, 73},
            {7, 13, 19, 25, 31, 37, 46, 55, 67, 73},
            {7, 13, 19, 25, 31, 37, 46, 55, 67, 73}
        },
        weight = 68.2
    },
    {
        name = "Feebas",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "35",
        bst = "200",
        movelvls = {
            {15, 30},
            {15, 30},
            {15, 30},
            {15, 30},
            {15, 30}
        },
        weight = 7.4
    },
    {
        name = "Milotic", -- THICC
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "540",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49}
        },
        weight = 162.0
    },
    {
        name = "Castform",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "420",
        movelvls = {
            {10, 10, 10, 20, 20, 20, 30},
            {10, 10, 10, 20, 20, 20, 30},
            {10, 10, 10, 20, 20, 20, 30},
            {10, 10, 10, 20, 30, 30, 30, 40, 50, 50, 50},
            {10, 10, 10, 15, 20, 20, 20, 30, 40, 40, 40}
        },
        weight = 0.8
    },
    {
        name = "Kecleon",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "440",
        movelvls = {
            {4, 7, 10, 15, 20, 25, 32, 39, 46, 55, 64},
            {4, 7, 10, 14, 18, 22, 27, 32, 37, 43, 49, 55},
            {4, 7, 10, 14, 18, 22, 27, 32, 37, 43, 49, 55},
            {4, 7, 10, 14, 18, 22, 27, 32, 37, 43, 49, 55, 58},
            {4, 7, 10, 14, 18, 22, 27, 32, 37, 43, 49, 55, 58}
        },
        weight = 22.0
    },
    {
        name = "Shuppet",
        type = {PokemonData.POKEMON_TYPES.GHOST, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "37",
        bst = "295",
        movelvls = {
            {5, 8, 13, 16, 20, 23, 28, 31, 35, 38, 43, 46, 50},
            {5, 8, 13, 16, 20, 23, 28, 31, 35, 38, 43, 46, 50},
            {5, 8, 13, 16, 20, 23, 28, 31, 35, 38, 43, 46, 50},
            {5, 8, 13, 16, 20, 23, 28, 31, 35, 38, 43, 46, 50, 55},
            {4, 7, 10, 13, 16, 19, 22, 26, 30, 34, 38, 42, 46, 50}
        },
        weight = 2.3
    },
    {
        name = "Banette",
        type = {PokemonData.POKEMON_TYPES.GHOST, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "455",
        movelvls = {
            {5, 8, 13, 16, 20, 23, 28, 31, 35, 42, 51, 58, 66},
            {5, 8, 13, 16, 20, 23, 28, 31, 35, 42, 51, 58, 66},
            {5, 8, 13, 16, 20, 23, 28, 31, 35, 42, 51, 58, 66},
            {5, 8, 13, 16, 20, 23, 28, 31, 35, 42, 51, 58, 66, 75},
            {4, 7, 10, 13, 16, 19, 22, 26, 30, 34, 40, 46, 52, 58}
        },
        weight = 12.5
    },
    {
        name = "Duskull",
        type = {PokemonData.POKEMON_TYPES.GHOST, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "37",
        bst = "295",
        movelvls = {
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49}
        },
        weight = 15.0
    },
    {
        name = "Dusclops",
        type = {PokemonData.POKEMON_TYPES.GHOST, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.REAPER_CLOTH,
        bst = "455",
        movelvls = {
            {6, 9, 14, 17, 22, 25, 30, 33, 37, 43, 51, 61},
            {6, 9, 14, 17, 22, 25, 30, 33, 37, 43, 51, 61},
            {6, 9, 14, 17, 22, 25, 30, 33, 37, 43, 51, 61},
            {6, 9, 14, 17, 22, 25, 30, 33, 37, 42, 49, 58, 61},
            {6, 9, 14, 17, 22, 25, 30, 33, 37, 42, 49, 58, 61}
        },
        weight = 30.6
    },
    {
        name = "Tropius",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "460",
        movelvls = {
            {7, 11, 17, 21, 27, 31, 37, 41, 47, 51, 57, 61},
            {7, 11, 17, 21, 27, 31, 37, 41, 47, 51, 57, 61},
            {7, 11, 17, 21, 27, 31, 37, 41, 47, 51, 57, 61},
            {7, 11, 17, 21, 27, 31, 37, 41, 47, 51, 57, 61, 67, 71},
            {7, 11, 17, 21, 27, 31, 37, 41, 47, 51, 57, 61, 67, 71}
        },
        weight = 100.0
    },
    {
        name = "Chimecho",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "425",
        movelvls = {
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49, 54, 57},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49, 54, 57}
        },
        weight = 1.0
    },
    {
        name = "Absol",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "465",
        movelvls = {
            {4, 9, 12, 17, 20, 25, 28, 33, 36, 41, 44, 49, 52, 57, 60, 65},
            {4, 9, 12, 17, 20, 25, 28, 33, 36, 41, 44, 49, 52, 57, 60, 65},
            {4, 9, 12, 17, 20, 25, 28, 33, 36, 41, 44, 49, 52, 57, 60, 65},
            {4, 9, 12, 17, 20, 25, 28, 33, 36, 41, 44, 49, 52, 57, 60, 65},
            {4, 9, 12, 17, 20, 25, 28, 33, 36, 41, 44, 49, 52, 57, 60, 65}
        },
        weight = 47.0
    },
    {
        name = "Wynaut",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "15",
        bst = "260",
        movelvls = {
            {15, 15, 15, 15},
            {15, 15, 15, 15},
            {15, 15, 15, 15},
            {15, 15, 15, 15},
            {15, 15, 15, 15}
        },
        weight = 14.0
    },
    {
        name = "Snorunt",
        type = {PokemonData.POKEMON_TYPES.ICE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.SNORUNT,
        bst = "300",
        movelvls = {
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 46},
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 46},
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 46},
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 46},
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 46}
        },
        weight = 16.8
    },
    {
        name = "Glalie",
        type = {PokemonData.POKEMON_TYPES.ICE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "480",
        movelvls = {
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 51, 59},
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 51, 59},
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 51, 59},
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 51, 59},
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 51, 59}
        },
        weight = 256.5
    },
    {
        name = "Spheal",
        type = {PokemonData.POKEMON_TYPES.ICE, PokemonData.POKEMON_TYPES.WATER},
        evolution = "32",
        bst = "290",
        movelvls = {
            {7, 13, 19, 25, 31, 37, 37, 43, 49},
            {7, 13, 19, 25, 31, 37, 37, 43, 49},
            {7, 13, 19, 25, 31, 37, 37, 43, 49},
            {7, 13, 19, 25, 31, 37, 37, 43, 49},
            {7, 13, 19, 25, 31, 37, 37, 43, 49}
        },
        weight = 39.5
    },
    {
        name = "Sealeo",
        type = {PokemonData.POKEMON_TYPES.ICE, PokemonData.POKEMON_TYPES.WATER},
        evolution = "44",
        bst = "410",
        movelvls = {
            {7, 13, 19, 25, 31, 32, 39, 39, 47, 55},
            {7, 13, 19, 25, 31, 32, 39, 39, 47, 55},
            {7, 13, 19, 25, 31, 32, 39, 39, 47, 55},
            {7, 13, 19, 25, 31, 32, 39, 39, 47, 55},
            {7, 13, 19, 25, 31, 32, 39, 39, 47, 55}
        },
        weight = 87.6
    },
    {
        name = "Walrein",
        type = {PokemonData.POKEMON_TYPES.ICE, PokemonData.POKEMON_TYPES.WATER},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "530",
        movelvls = {
            {7, 13, 19, 25, 31, 32, 39, 39, 44, 52, 65},
            {7, 13, 19, 25, 31, 32, 39, 39, 44, 52, 65},
            {7, 13, 19, 25, 31, 32, 39, 39, 44, 52, 65},
            {7, 13, 19, 25, 31, 32, 39, 39, 44, 52, 65},
            {7, 13, 19, 25, 31, 32, 39, 39, 44, 52, 65}
        },
        weight = 150.6
    },
    {
        name = "Clamperl",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.CLAMPERL,
        bst = "345",
        movelvls = {
            {},
            {},
            {},
            {51},
            {51}
        },
        weight = 52.5
    },
    {
        name = "Huntail",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "485",
        movelvls = {
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51}
        },
        weight = 27.0
    },
    {
        name = "Gorebyss",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "485",
        movelvls = {
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 51}
        },
        weight = 22.6
    },
    {
        name = "Relicanth",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.ROCK},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "485",
        movelvls = {
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78}
        },
        weight = 23.4
    },
    {
        name = "Luvdisc",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "330",
        movelvls = {
            {4, 7, 9, 14, 17, 22, 27, 31, 37, 40, 46, 51},
            {4, 7, 9, 14, 17, 22, 27, 31, 37, 40, 46, 51},
            {4, 7, 9, 14, 17, 22, 27, 31, 37, 40, 46, 51},
            {4, 7, 9, 14, 17, 22, 27, 31, 37, 40, 46, 51, 55},
            {4, 7, 9, 14, 17, 22, 27, 31, 37, 40, 46, 51, 55}
        },
        weight = 8.7
    },
    {
        name = "Bagon",
        type = {PokemonData.POKEMON_TYPES.DRAGON, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "30",
        bst = "300",
        movelvls = {
            {5, 10, 16, 20, 25, 31, 35, 40, 46, 50, 55},
            {5, 10, 16, 20, 25, 31, 35, 40, 46, 50, 55},
            {5, 10, 16, 20, 25, 31, 35, 40, 46, 50, 55},
            {5, 10, 16, 20, 25, 31, 35, 40, 46, 50, 55},
            {5, 10, 16, 20, 25, 31, 35, 40, 46, 50, 55}
        },
        weight = 42.1
    },
    {
        name = "Shelgon",
        type = {PokemonData.POKEMON_TYPES.DRAGON, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "50",
        bst = "420",
        movelvls = {
            {5, 10, 16, 20, 25, 30, 32, 37, 43, 50, 55, 61},
            {5, 10, 16, 20, 25, 30, 32, 37, 43, 50, 55, 61},
            {5, 10, 16, 20, 25, 30, 32, 37, 43, 50, 55, 61},
            {5, 10, 16, 20, 25, 30, 32, 37, 43, 50, 55, 61},
            {5, 10, 16, 20, 25, 30, 32, 37, 43, 50, 55, 61}
        },
        weight = 110.5
    },
    {
        name = "Salamence",
        type = {PokemonData.POKEMON_TYPES.DRAGON, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "600",
        movelvls = {
            {5, 10, 16, 20, 25, 30, 32, 37, 43, 50, 53, 61, 70},
            {5, 10, 16, 20, 25, 30, 32, 37, 43, 50, 53, 61, 70},
            {5, 10, 16, 20, 25, 30, 32, 37, 43, 50, 53, 61, 70},
            {5, 10, 16, 20, 25, 30, 32, 37, 43, 50, 53, 61, 70, 80},
            {5, 10, 16, 20, 25, 30, 32, 37, 43, 50, 53, 61, 70, 80}
        },
        weight = 102.6
    },
    {
        name = "Beldum",
        type = {PokemonData.POKEMON_TYPES.STEEL, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = "20",
        bst = "300",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = 95.2
    },
    {
        name = "Metang",
        type = {PokemonData.POKEMON_TYPES.STEEL, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = "45",
        bst = "420",
        movelvls = {
            {20, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56},
            {20, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56},
            {20, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56},
            {20, 20, 24, 28, 32, 36, 40, 44, 48, 52, 56},
            {20, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47, 50}
        },
        weight = 202.5
    },
    {
        name = "Metagross",
        type = {PokemonData.POKEMON_TYPES.STEEL, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "600",
        movelvls = {
            {20, 20, 24, 28, 32, 36, 40, 44, 45, 53, 62, 71},
            {20, 20, 24, 28, 32, 36, 40, 44, 45, 53, 62, 71},
            {20, 20, 24, 28, 32, 36, 40, 44, 45, 53, 62, 71},
            {20, 20, 24, 28, 32, 36, 40, 44, 45, 53, 62, 71},
            {20, 20, 23, 26, 29, 32, 35, 38, 41, 44, 45, 53, 62}
        },
        weight = 550.0
    },
    {
        name = "Regirock",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "580",
        movelvls = {
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89},
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89},
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89},
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89},
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89}
        },
        weight = 230.0
    },
    {
        name = "Regice",
        type = {PokemonData.POKEMON_TYPES.ICE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "580",
        movelvls = {
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89},
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89},
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89},
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89},
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89}
        },
        weight = 175.0
    },
    {
        name = "Registeel",
        type = {PokemonData.POKEMON_TYPES.STEEL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "580",
        movelvls = {
            {9, 17, 25, 33, 41, 41, 49, 57, 65, 73, 73, 81, 89},
            {9, 17, 25, 33, 41, 41, 49, 57, 65, 73, 73, 81, 89},
            {9, 17, 25, 33, 41, 41, 49, 57, 65, 73, 73, 81, 89},
            {9, 17, 25, 33, 41, 41, 49, 57, 65, 73, 73, 81, 89},
            {9, 17, 25, 33, 41, 41, 49, 57, 65, 73, 73, 81, 89}
        },
        weight = 205.0
    },
    {
        name = "Latias",
        type = {PokemonData.POKEMON_TYPES.DRAGON, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "600",
        movelvls = {
            {5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70},
            {5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70},
            {5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70},
            {5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85},
            {5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85}
        },
        weight = 40.0
    },
    {
        name = "Latios",
        type = {PokemonData.POKEMON_TYPES.DRAGON, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "600",
        movelvls = {
            {5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70},
            {5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70},
            {5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70},
            {5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85},
            {5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85}
        },
        weight = 60.0
    },
    {
        name = "Kyogre",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "670",
        movelvls = {
            {5, 15, 20, 30, 35, 45, 50, 60, 65, 75, 80},
            {5, 15, 20, 30, 35, 45, 50, 60, 65, 75, 80},
            {5, 15, 20, 30, 35, 45, 50, 60, 65, 75, 80, 90},
            {5, 15, 20, 30, 35, 45, 50, 60, 65, 75, 80, 90},
            {5, 15, 20, 30, 35, 45, 50, 60, 65, 75, 80, 90}
        },
        weight = 352.0
    },
    {
        name = "Groudon",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "670",
        movelvls = {
            {5, 15, 20, 30, 35, 45, 50, 60, 65, 75, 80},
            {5, 15, 20, 30, 35, 45, 50, 60, 65, 75, 80},
            {5, 15, 20, 30, 35, 45, 50, 60, 65, 75, 80, 90},
            {5, 15, 20, 30, 35, 45, 50, 60, 65, 75, 80, 90},
            {5, 15, 20, 30, 35, 45, 50, 60, 65, 75, 80, 90}
        },
        weight = 950.0
    },
    {
        name = "Rayquaza",
        type = {PokemonData.POKEMON_TYPES.DRAGON, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "680",
        movelvls = {
            {5, 15, 20, 30, 35, 45, 50, 60, 65, 75, 80},
            {5, 15, 20, 30, 35, 45, 50, 60, 65, 75, 80},
            {5, 15, 20, 30, 35, 45, 50, 60, 65, 75, 80, 90},
            {5, 15, 20, 30, 35, 45, 50, 60, 65, 75, 80, 90},
            {5, 15, 20, 30, 35, 45, 50, 60, 65, 75, 80, 90}
        },
        weight = 206.5
    },
    {
        name = "Jirachi",
        type = {PokemonData.POKEMON_TYPES.STEEL, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "600",
        movelvls = {
            {5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70},
            {5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70},
            {5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70},
            {5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70},
            {5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70}
        },
        weight = 1.1
    },
    {
        name = "Deoxys",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "600",
        movelvls = {
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97},
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97},
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97},
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97},
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97}
        },
        weight = 60.8
    },
    --gen 4(#387-493)
    {
        name = "Turtwig",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "18",
        bst = "318",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45}
        },
        weight = 10.2
    },
    {
        name = "Grotle",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "32",
        bst = "405",
        movelvls = {
            {5, 9, 13, 17, 22, 27, 32, 37, 42, 47, 52},
            {5, 9, 13, 17, 22, 27, 32, 37, 42, 47, 52},
            {5, 9, 13, 17, 22, 27, 32, 37, 42, 47, 52},
            {5, 9, 13, 17, 22, 27, 32, 37, 42, 47, 52},
            {5, 9, 13, 17, 22, 27, 32, 37, 42, 47, 52}
        },
        weight = 97.0
    },
    {
        name = "Torterra",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.GROUND},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "525",
        movelvls = {
            {5, 9, 13, 17, 22, 27, 32, 33, 39, 45, 51, 57},
            {5, 9, 13, 17, 22, 27, 32, 33, 39, 45, 51, 57},
            {5, 9, 13, 17, 22, 27, 32, 33, 39, 45, 51, 57},
            {5, 9, 13, 17, 22, 27, 32, 33, 39, 45, 51, 57},
            {5, 9, 13, 17, 22, 27, 32, 33, 39, 45, 51, 57}
        },
        weight = 310.0
    },
    {
        name = "Chimchar",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "14",
        bst = "309",
        movelvls = {
            {7, 9, 15, 17, 23, 25, 31, 33, 39, 41},
            {7, 9, 15, 17, 23, 25, 31, 33, 39, 41},
            {7, 9, 15, 17, 23, 25, 31, 33, 39, 41},
            {7, 9, 15, 17, 23, 25, 31, 33, 39, 41, 47},
            {7, 9, 15, 17, 23, 25, 31, 33, 39, 41, 47}
        },
        weight = 6.2
    },
    {
        name = "Monferno",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.FIGHTING},
        evolution = "36",
        bst = "405",
        movelvls = {
            {7, 9, 14, 16, 19, 26, 29, 36, 39, 46, 49},
            {7, 9, 14, 16, 19, 26, 29, 36, 39, 46, 49},
            {7, 9, 14, 16, 19, 26, 29, 36, 39, 46, 49},
            {7, 9, 14, 16, 19, 26, 29, 36, 39, 46, 49, 56},
            {7, 9, 14, 16, 19, 26, 29, 36, 39, 46, 49, 56}
        },
        weight = 22.0
    },
    {
        name = "Infernape",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.FIGHTING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "534",
        movelvls = {
            {7, 9, 14, 17, 21, 29, 33, 41, 45, 53, 57},
            {7, 9, 14, 17, 21, 29, 33, 41, 45, 53, 57},
            {7, 9, 14, 17, 21, 29, 33, 41, 45, 53, 57},
            {7, 9, 14, 16, 19, 26, 29, 36, 42, 52, 58, 68},
            {7, 9, 14, 16, 19, 26, 29, 36, 42, 52, 58, 68}
        },
        weight = 55.0
    },
    {
        name = "Piplup",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "16",
        bst = "314",
        movelvls = {
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43}
        },
        weight = 5.2
    },
    {
        name = "Prinplup",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "36",
        bst = "405",
        movelvls = {
            {4, 8, 11, 15, 16, 19, 24, 28, 33, 37, 42, 46, 51},
            {4, 8, 11, 15, 16, 19, 24, 28, 33, 37, 42, 46, 51},
            {4, 8, 11, 15, 16, 19, 24, 28, 33, 37, 42, 46, 51},
            {4, 8, 11, 15, 16, 19, 24, 28, 33, 37, 42, 46, 51},
            {4, 8, 11, 15, 16, 19, 24, 28, 33, 37, 42, 46, 51}
        },
        weight = 23.0
    },
    {
        name = "Empoleon",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.STEEL},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "530",
        movelvls = {
            {4, 8, 11, 15, 16, 19, 24, 28, 33, 36, 39, 46, 52, 59},
            {4, 8, 11, 15, 16, 19, 24, 28, 33, 36, 39, 46, 52, 59},
            {4, 8, 11, 15, 16, 19, 24, 28, 33, 36, 39, 46, 52, 59},
            {4, 8, 11, 15, 16, 19, 24, 28, 33, 36, 39, 46, 52, 59},
            {4, 8, 11, 15, 16, 19, 24, 28, 33, 36, 39, 46, 52, 59}
        },
        weight = 84.5
    },
    {
        name = "Starly",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = "14",
        bst = "245",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37},
            {5, 9, 13, 17, 21, 25, 29, 33, 37},
            {5, 9, 13, 17, 21, 25, 29, 33, 37},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41}
        },
        weight = 2.0
    },
    {
        name = "Staravia",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = "34",
        bst = "340",
        movelvls = {
            {5, 9, 13, 18, 23, 28, 33, 38, 43},
            {5, 9, 13, 18, 23, 28, 33, 38, 43},
            {5, 9, 13, 18, 23, 28, 33, 38, 43},
            {5, 9, 13, 18, 23, 28, 33, 38, 43, 48},
            {5, 9, 13, 18, 23, 28, 33, 38, 43, 48}
        },
        weight = 15.5
    },
    {
        name = "Staraptor",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "475",
        movelvls = {
            {5, 9, 13, 18, 23, 28, 33, 34, 41, 49},
            {5, 9, 13, 18, 23, 28, 33, 34, 41, 49},
            {5, 9, 13, 18, 23, 28, 33, 34, 41, 49},
            {5, 9, 13, 18, 23, 28, 33, 34, 41, 49, 57},
            {5, 9, 13, 18, 23, 28, 33, 34, 41, 49, 57}
        },
        weight = 24.9
    },
    {
        name = "Bidoof",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "15",
        bst = "250",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45}
        },
        weight = 20.0
    },
    {
        name = "Bibarel",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.WATER},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "410",
        movelvls = {
            {5, 9, 13, 15, 18, 23, 28, 33, 38, 43, 48},
            {5, 9, 13, 15, 18, 23, 28, 33, 38, 43, 48, 53},
            {5, 9, 13, 15, 18, 23, 28, 33, 38, 43, 48, 53},
            {5, 9, 13, 15, 18, 23, 28, 33, 38, 43, 48, 53},
            {5, 9, 13, 15, 18, 23, 28, 33, 38, 43, 48, 53}
        },
        weight = 31.5
    },
    {
        name = "Kricketot",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "10",
        bst = "194",
        movelvls = {
            {},
            {16},
            {16},
            {6, 16},
            {6, 16}
        },
        weight = 2.2
    },
    {
        name = "Kricketune",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "384",
        movelvls = {
            {10, 14, 18, 22, 26, 30, 34, 38},
            {10, 14, 18, 22, 26, 30, 34, 38, 42, 46, 50},
            {10, 14, 18, 22, 26, 30, 34, 38, 42, 46, 50},
            {10, 14, 18, 22, 26, 30, 34, 38, 42, 46, 50},
            {10, 14, 18, 22, 26, 30, 34, 38, 42, 46, 50}
        },
        weight = 25.5
    },
    {
        name = "Shinx",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "15",
        bst = "263",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45}
        },
        weight = 9.5
    },
    {
        name = "Luxio",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "30",
        bst = "363",
        movelvls = {
            {5, 9, 13, 18, 23, 28, 33, 38, 43, 48},
            {5, 9, 13, 18, 23, 28, 33, 38, 43, 48},
            {5, 9, 13, 18, 23, 28, 33, 38, 43, 48},
            {5, 9, 13, 18, 23, 28, 33, 38, 43, 48, 53},
            {5, 9, 13, 18, 23, 28, 33, 38, 43, 48, 53}
        },
        weight = 30.5
    },
    {
        name = "Luxray",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "523",
        movelvls = {
            {5, 9, 13, 18, 23, 28, 35, 42, 49, 56},
            {5, 9, 13, 18, 23, 28, 35, 42, 49, 56},
            {5, 9, 13, 18, 23, 28, 35, 42, 49, 56},
            {5, 9, 13, 18, 23, 28, 35, 42, 49, 56, 63},
            {5, 9, 13, 18, 23, 28, 35, 42, 49, 56, 63}
        },
        weight = 42.0
    },
    {
        name = "Budew",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.POISON},
        evolution = PokemonData.EVOLUTION_TYPES.FRIEND,
        baseFriendship = 70,
        bst = "280",
        movelvls = {
            {4, 7, 10, 13, 16},
            {4, 7, 10, 13, 16},
            {4, 7, 10, 13, 16},
            {4, 7, 10, 13, 16},
            {4, 7, 10, 13, 16}
        },
        weight = 1.2
    },
    {
        name = "Roserade",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.POISON},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "505",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = 14.5
    },
    {
        name = "Cranidos",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "30",
        bst = "350",
        movelvls = {
            {6, 10, 15, 19, 24, 28, 33, 37, 43},
            {6, 10, 15, 19, 24, 28, 33, 37, 43},
            {6, 10, 15, 19, 24, 28, 33, 37, 43},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46}
        },
        weight = 31.5
    },
    {
        name = "Rampardos",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "495",
        movelvls = {
            {6, 10, 15, 19, 24, 28, 30, 36, 43, 52},
            {6, 10, 15, 19, 24, 28, 30, 36, 43, 52},
            {6, 10, 15, 19, 24, 28, 30, 36, 43, 52},
            {6, 10, 15, 19, 24, 28, 30, 36, 43, 51, 58},
            {6, 10, 15, 19, 24, 28, 30, 36, 43, 51, 58}
        },
        weight = 102.5
    },
    {
        name = "Shieldon",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.STEEL},
        evolution = "30",
        bst = "350",
        movelvls = {
            {6, 10, 15, 19, 24, 28, 33, 37, 43},
            {6, 10, 15, 19, 24, 28, 33, 37, 43},
            {6, 10, 15, 19, 24, 28, 33, 37, 43},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46}
        },
        weight = 57.0
    },
    {
        name = "Bastiodon",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.STEEL},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "495",
        movelvls = {
            {6, 10, 15, 19, 24, 28, 30, 36, 43, 52},
            {6, 10, 15, 19, 24, 28, 30, 36, 43, 52},
            {6, 10, 15, 19, 24, 28, 30, 36, 43, 52},
            {6, 10, 15, 19, 24, 28, 30, 36, 43, 51, 58},
            {6, 10, 15, 19, 24, 28, 30, 36, 43, 51, 58}
        },
        weight = 149.5
    },
    {
        name = "Burmy P",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.BURMY,
        bst = "224",
        movelvls = {
            {10, 20},
            {10, 15, 20},
            {10, 15, 20},
            {10, 15, 20},
            {10, 15, 20}
        },
        weight = 3.4
    },
    {
        name = "Wormadam P",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.GRASS},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "424",
        movelvls = {
            {10, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47},
            {10, 15, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47},
            {10, 15, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47},
            {10, 15, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47},
            {10, 15, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47}
        },
        weight = 6.5
    },
    {
        name = "Mothim",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "424",
        movelvls = {
            {10, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47},
            {10, 15, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47},
            {10, 15, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47},
            {10, 15, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47, 50},
            {10, 15, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47, 50}
        },
        weight = 23.3
    },
    {
        name = "Combee",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.COMBEE,
        bst = "244",
        movelvls = {
            {},
            {13},
            {13},
            {13},
            {13, 29}
        },
        weight = 5.5
    },
    {
        name = "Vespiquen",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "474",
        movelvls = {
            {3, 7, 9, 13, 15, 19, 21, 25, 27, 31, 33, 37, 39, 43},
            {3, 7, 9, 13, 15, 19, 21, 25, 27, 31, 33, 37, 39, 43},
            {3, 7, 9, 13, 15, 19, 21, 25, 27, 31, 33, 37, 39, 43},
            {3, 7, 9, 13, 15, 19, 21, 25, 27, 31, 33, 37, 39, 43},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53}
        },
        weight = 38.5
    },
    {
        name = "Pachirisu",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "405",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37},
            {5, 9, 13, 17, 21, 25, 29, 33, 37},
            {5, 9, 13, 17, 21, 25, 29, 33, 37},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49}
        },
        weight = 3.9
    },
    {
        name = "Buizel",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "26",
        bst = "330",
        movelvls = {
            {3, 6, 10, 15, 21, 28, 36, 45},
            {3, 6, 10, 15, 21, 28, 36, 45},
            {3, 6, 10, 15, 21, 28, 36, 45},
            {3, 6, 10, 15, 21, 28, 36, 45, 55},
            {4, 7, 11, 15, 18, 21, 24, 27, 31, 35, 38, 41, 45}
        },
        weight = 29.5
    },
    {
        name = "Floatzel",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "495",
        movelvls = {
            {3, 6, 10, 15, 21, 26, 29, 39, 50},
            {3, 6, 10, 15, 21, 26, 29, 39, 50},
            {3, 6, 10, 15, 21, 26, 29, 39, 50},
            {3, 6, 10, 15, 21, 26, 29, 39, 50, 62},
            {4, 7, 11, 15, 18, 21, 24, 29, 35, 41, 46, 51, 57}
        },
        weight = 33.5
    },
    {
        name = "Cherubi",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "25",
        bst = "275",
        movelvls = {
            {7, 10, 13, 19, 22, 28, 31, 37, 40},
            {7, 10, 13, 19, 22, 28, 31, 37, 40},
            {7, 10, 13, 19, 22, 28, 31, 37, 40},
            {7, 10, 13, 19, 22, 28, 31, 37, 40},
            {7, 10, 13, 19, 22, 28, 31, 37, 40}
        },
        weight = 3.3
    },
    {
        name = "Cherrim O",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "450",
        movelvls = {
            {7, 10, 13, 19, 22, 25, 30, 35, 43, 48},
            {7, 10, 13, 19, 22, 25, 30, 35, 43, 48},
            {7, 10, 13, 19, 22, 25, 30, 35, 43, 48},
            {7, 10, 13, 19, 22, 25, 30, 35, 43, 48},
            {7, 10, 13, 19, 22, 25, 30, 35, 43, 48}
        },
        weight = 9.3
    },
    {
        name = "Shellos W",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "30",
        bst = "325",
        movelvls = {
            {2, 4, 7, 11, 16, 22, 29, 37, 46},
            {2, 4, 7, 11, 16, 22, 29, 37, 46},
            {2, 4, 7, 11, 16, 22, 29, 37, 46},
            {2, 4, 7, 11, 16, 22, 29, 37, 46},
            {2, 4, 7, 11, 16, 22, 29, 37, 46}
        },
        weight = 6.3
    },
    {
        name = "Gastrodon W",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.GROUND},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "475",
        movelvls = {
            {2, 4, 7, 11, 16, 22, 29, 41, 54},
            {2, 4, 7, 11, 16, 22, 29, 41, 54},
            {2, 4, 7, 11, 16, 22, 29, 41, 54},
            {2, 4, 7, 11, 16, 22, 29, 41, 54},
            {2, 4, 7, 11, 16, 22, 29, 41, 54}
        },
        weight = 29.9
    },
    {
        name = "Ambipom",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "482",
        movelvls = {
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43}
        },
        weight = 20.3
    },
    {
        name = "Drifloon",
        type = {PokemonData.POKEMON_TYPES.GHOST, PokemonData.POKEMON_TYPES.FLYING},
        evolution = "28",
        bst = "348",
        movelvls = {
            {6, 11, 14, 17, 22, 27, 27, 30, 33, 38, 43},
            {6, 11, 14, 17, 22, 27, 27, 30, 33, 38, 43},
            {6, 11, 14, 17, 22, 27, 27, 30, 33, 38, 43},
            {6, 11, 14, 17, 22, 27, 30, 30, 33, 38, 43, 46},
            {4, 8, 13, 16, 20, 25, 27, 32, 32, 36, 40, 44, 50}
        },
        weight = 1.2
    },
    {
        name = "Drifblim",
        type = {PokemonData.POKEMON_TYPES.GHOST, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "498",
        movelvls = {
            {6, 11, 14, 17, 22, 27, 27, 32, 37, 44, 51},
            {6, 11, 14, 17, 22, 27, 27, 32, 37, 44, 51},
            {6, 11, 14, 17, 22, 27, 27, 32, 37, 44, 51},
            {6, 11, 14, 17, 22, 27, 32, 32, 37, 44, 51, 56},
            {4, 8, 13, 16, 20, 25, 27, 34, 34, 40, 46, 52, 60}
        },
        weight = 15.0
    },
    {
        name = "Buneary",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.FRIEND,
        baseFriendship = 0,
        bst = "350",
        movelvls = {
            {6, 13, 16, 23, 26, 33, 36, 43, 46, 53},
            {6, 13, 16, 23, 26, 33, 36, 43, 46, 53},
            {6, 13, 16, 23, 26, 33, 36, 43, 46, 53},
            {6, 13, 16, 23, 26, 33, 36, 43, 46, 53, 56, 63},
            {6, 13, 16, 23, 26, 33, 36, 43, 46, 53, 56, 63}
        },
        weight = 5.5
    },
    {
        name = "Lopunny",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "480",
        movelvls = {
            {6, 13, 16, 23, 26, 33, 36, 43, 46, 53},
            {6, 13, 16, 23, 26, 33, 36, 43, 46, 53},
            {6, 13, 16, 23, 26, 33, 36, 43, 46, 53},
            {6, 13, 16, 23, 26, 33, 36, 43, 46, 53, 56, 63},
            {6, 13, 16, 23, 26, 33, 36, 43, 46, 53, 56, 63}
        },
        weight = 33.3
    },
    {
        name = "Mismagius",
        type = {PokemonData.POKEMON_TYPES.GHOST, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "495",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = 4.4
    },
    {
        name = "Honchkrow",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "505",
        movelvls = {
            {25, 35, 45, 55},
            {25, 35, 45, 55},
            {25, 35, 45, 55},
            {25, 35, 45, 55, 65, 75},
            {25, 35, 45, 55, 65, 75}
        },
        weight = 27.3
    },
    {
        name = "Glameow",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "38",
        bst = "310",
        movelvls = {
            {5, 8, 13, 17, 20, 25, 29, 32, 37, 41, 45},
            {5, 8, 13, 17, 20, 25, 29, 32, 37, 41, 45},
            {5, 8, 13, 17, 20, 25, 29, 32, 37, 41, 45},
            {5, 8, 13, 17, 20, 25, 29, 32, 37, 41, 44, 48},
            {5, 8, 13, 17, 20, 25, 29, 32, 37, 41, 44, 48}
        },
        weight = 3.9
    },
    {
        name = "Purugly",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "452",
        movelvls = {
            {5, 8, 13, 17, 20, 25, 29, 32, 37, 38, 45, 53},
            {5, 8, 13, 17, 20, 25, 29, 32, 37, 38, 45, 53},
            {5, 8, 13, 17, 20, 25, 29, 32, 37, 38, 45, 53},
            {5, 8, 13, 17, 20, 25, 29, 32, 37, 38, 45, 52, 60},
            {5, 8, 13, 17, 20, 25, 29, 32, 37, 38, 45, 52, 60}
        },
        weight = 43.8
    },
    {
        name = "Chingling",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.FRIEND,
        baseFriendship = 70,
        bst = "285",
        movelvls = {
            {6, 9, 14, 17, 22},
            {6, 9, 14, 17, 22},
            {6, 9, 14, 17, 22},
            {6, 9, 14, 17, 22, 25},
            {6, 9, 14, 17, 22, 25}
        },
        weight = .6
    },
    {
        name = "Stunky",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.DARK},
        evolution = "34",
        bst = "329",
        movelvls = {
            {4, 7, 11, 15, 20, 25, 31, 37, 44},
            {4, 7, 10, 14, 18, 22, 27, 32, 38, 44},
            {4, 7, 10, 14, 18, 22, 27, 32, 38, 44},
            {4, 7, 10, 14, 18, 22, 27, 32, 37, 43, 49},
            {4, 7, 10, 14, 18, 22, 27, 32, 37, 43, 49}
        },
        weight = 19.2
    },
    {
        name = "Skuntank",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.DARK},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "479",
        movelvls = {
            {4, 7, 11, 15, 20, 25, 31, 34, 41, 52},
            {4, 7, 10, 14, 18, 22, 27, 32, 34, 42, 52},
            {4, 7, 10, 14, 18, 22, 27, 32, 34, 42, 52},
            {4, 7, 10, 14, 18, 22, 27, 32, 34, 41, 51, 61},
            {4, 7, 10, 14, 18, 22, 27, 32, 34, 41, 51, 61}
        },
        weight = 38.0
    },
    {
        name = "Bronzor",
        type = {PokemonData.POKEMON_TYPES.STEEL, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = "33",
        bst = "300",
        movelvls = {
            {7, 12, 14, 19, 26, 30, 35, 37, 41, 49, 52},
            {7, 12, 14, 19, 26, 30, 35, 37, 41, 49, 52},
            {7, 12, 14, 19, 26, 30, 35, 37, 41, 49, 52},
            {7, 12, 14, 19, 26, 30, 35, 37, 41, 49, 52, 54},
            {5, 9, 11, 15, 19, 21, 25, 29, 31, 35, 39, 41, 45, 49}
        },
        weight = 60.5
    },
    {
        name = "Bronzong",
        type = {PokemonData.POKEMON_TYPES.STEEL, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "500",
        movelvls = {
            {7, 12, 14, 19, 26, 30, 33, 38, 43, 50, 61, 67},
            {7, 12, 14, 19, 26, 30, 33, 38, 43, 50, 61, 67},
            {7, 12, 14, 19, 26, 30, 33, 38, 43, 50, 61, 67},
            {7, 12, 14, 19, 26, 30, 33, 38, 43, 50, 61, 67, 72},
            {5, 9, 11, 15, 19, 21, 25, 29, 31, 33, 36, 42, 46, 52, 58}
        },
        weight = 187.0
    },
    {
        name = "Bonsly",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "17",
        bst = "290",
        movelvls = {
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40}
        },
        weight = 15.0
    },
    {
        name = "Mime Jr.",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "18",
        bst = "310",
        movelvls = {
            {4, 8, 11, 15, 18, 22, 22, 25, 29, 32, 36, 39, 43, 46, 50},
            {4, 8, 11, 15, 18, 22, 22, 25, 29, 32, 36, 39, 43, 46, 50},
            {4, 8, 11, 15, 18, 22, 22, 25, 29, 32, 36, 39, 43, 46, 50},
            {4, 8, 11, 15, 18, 22, 22, 25, 29, 32, 36, 39, 43, 46, 50},
            {4, 8, 11, 15, 18, 22, 22, 25, 29, 32, 36, 39, 43, 46, 50}
        },
        weight = 13.0
    },
    {
        name = "Happiny",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.OVAL,
        bst = "220",
        movelvls = {
            {5, 9, 12},
            {5, 9, 12},
            {5, 9, 12},
            {5, 9, 12},
            {5, 9, 12}
        },
        weight = 24.4
    },
    {
        name = "Chatot",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "411",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57}
        },
        weight = 1.9
    },
    {
        name = "Spiritomb",
        type = {PokemonData.POKEMON_TYPES.GHOST, PokemonData.POKEMON_TYPES.DARK},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "485",
        movelvls = {
            {7, 13, 19, 25, 31, 37, 43, 49},
            {7, 13, 19, 25, 31, 37, 43, 49},
            {7, 13, 19, 25, 31, 37, 43, 49},
            {7, 13, 19, 25, 31, 37, 43, 49},
            {7, 13, 19, 25, 31, 37, 43, 49}
        },
        weight = 108.0
    },
    {
        name = "Gible",
        type = {PokemonData.POKEMON_TYPES.DRAGON, PokemonData.POKEMON_TYPES.GROUND},
        evolution = "24",
        bst = "300",
        movelvls = {
            {3, 7, 13, 15, 19, 25, 27, 31, 37},
            {3, 7, 13, 15, 19, 25, 27, 31, 37},
            {3, 7, 13, 15, 19, 25, 27, 31, 37},
            {3, 7, 13, 15, 19, 25, 27, 31, 37},
            {3, 7, 13, 15, 19, 25, 27, 31, 37}
        },
        weight = 20.5
    },
    {
        name = "Gabite",
        type = {PokemonData.POKEMON_TYPES.DRAGON, PokemonData.POKEMON_TYPES.GROUND},
        evolution = "48",
        bst = "410",
        movelvls = {
            {3, 7, 13, 15, 19, 28, 33, 40, 49},
            {3, 7, 13, 15, 19, 28, 33, 40, 49},
            {3, 7, 13, 15, 19, 28, 33, 40, 49},
            {3, 7, 13, 15, 19, 24, 28, 33, 40, 49},
            {3, 7, 13, 15, 19, 24, 28, 33, 40, 49}
        },
        weight = 56.0
    },
    {
        name = "Garchomp",
        type = {PokemonData.POKEMON_TYPES.DRAGON, PokemonData.POKEMON_TYPES.GROUND},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "600",
        movelvls = {
            {3, 7, 13, 15, 19, 28, 33, 40, 48, 55},
            {3, 7, 13, 15, 19, 28, 33, 40, 48, 55},
            {3, 7, 13, 15, 19, 28, 33, 40, 48, 55},
            {3, 7, 13, 15, 19, 24, 28, 33, 40, 48, 55},
            {3, 7, 13, 15, 19, 24, 28, 33, 40, 48, 55}
        },
        weight = 95.0
    },
    {
        name = "Munchlax",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.FRIEND,
        baseFriendship = 70,
        bst = "390",
        movelvls = {
            {4, 9, 12, 17, 20, 25, 28, 33, 36, 41, 44, 49},
            {4, 9, 12, 17, 20, 25, 28, 33, 36, 41, 44, 49},
            {4, 9, 12, 17, 20, 25, 28, 33, 36, 41, 44, 49},
            {4, 9, 12, 17, 20, 25, 28, 33, 36, 41, 44, 49, 52, 57},
            {4, 9, 12, 17, 20, 25, 28, 33, 36, 41, 44, 49, 52, 57}
        },
        weight = 105.0
    },
    {
        name = "Riolu",
        type = {PokemonData.POKEMON_TYPES.FIGHTING, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.FRIEND,
        baseFriendship = 70,
        bst = "285",
        movelvls = {
            {6, 11, 15, 19, 24, 29},
            {6, 11, 15, 19, 24, 29},
            {6, 11, 15, 19, 24, 29},
            {6, 11, 15, 19, 24, 29, 47, 55},
            {6, 11, 15, 19, 24, 29, 47, 55}
        },
        weight = 20.2
    },
    {
        name = "Lucario",
        type = {PokemonData.POKEMON_TYPES.FIGHTING, PokemonData.POKEMON_TYPES.STEEL},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "525",
        movelvls = {
            {6, 11, 15, 19, 24, 29, 33, 37, 42, 47, 51},
            {6, 11, 15, 19, 24, 29, 33, 37, 42, 47, 51},
            {6, 11, 15, 19, 24, 29, 33, 37, 42, 47, 51},
            {6, 11, 15, 19, 24, 29, 33, 37, 42, 47, 51, 55, 60, 65},
            {6, 11, 15, 19, 24, 29, 33, 37, 42, 47, 51, 55, 60, 65}
        },
        weight = 54.0
    },
    {
        name = "Hippopotas",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "34",
        bst = "330",
        movelvls = {
            {7, 13, 19, 25, 31, 37, 44, 50},
            {7, 13, 19, 25, 31, 37, 44, 50},
            {7, 13, 19, 19, 25, 31, 37, 44, 50},
            {7, 13, 19, 19, 25, 31, 37, 44, 50},
            {7, 13, 19, 19, 25, 31, 37, 44, 50}
        },
        weight = 49.5
    },
    {
        name = "Hippowdon",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "525",
        movelvls = {
            {7, 13, 19, 25, 31, 40, 50, 60},
            {7, 13, 19, 25, 31, 40, 50, 60},
            {7, 13, 19, 19, 25, 31, 40, 50, 60},
            {7, 13, 19, 19, 25, 31, 40, 50, 60},
            {7, 13, 19, 19, 25, 31, 40, 50, 60}
        },
        weight = 300.0
    },
    {
        name = "Skorupi",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.BUG},
        evolution = "40",
        bst = "330",
        movelvls = {
            {6, 12, 17, 23, 28, 34, 39, 45, 50},
            {6, 12, 17, 23, 28, 34, 39, 45, 50},
            {6, 12, 17, 23, 28, 34, 39, 45, 50},
            {6, 12, 17, 23, 28, 34, 39, 45, 50, 56, 61},
            {5, 9, 13, 16, 20, 23, 27, 30, 34, 38, 41, 45, 49}
        },
        weight = 12.0
    },
    {
        name = "Drapion",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.DARK},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "500",
        movelvls = {
            {6, 12, 17, 23, 28, 34, 39, 49, 58},
            {6, 12, 17, 23, 28, 34, 39, 49, 58},
            {6, 12, 17, 23, 28, 34, 39, 49, 58},
            {6, 12, 17, 23, 28, 34, 39, 48, 56, 65, 73},
            {5, 9, 13, 16, 20, 23, 27, 30, 34, 38, 43, 49, 57}
        },
        weight = 61.5
    },
    {
        name = "Croagunk",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.FIGHTING},
        evolution = "37",
        bst = "300",
        movelvls = {
            {3, 8, 10, 15, 17, 22, 24, 29, 31, 36, 38, 43, 45},
            {3, 8, 10, 15, 17, 22, 24, 29, 31, 36, 38, 43, 45},
            {3, 8, 10, 15, 17, 22, 24, 29, 31, 36, 38, 43, 45},
            {3, 8, 10, 15, 17, 22, 24, 29, 31, 36, 38, 43, 45, 50},
            {3, 8, 10, 15, 17, 22, 24, 29, 31, 36, 38, 43, 45, 50}
        },
        weight = 23.0
    },
    {
        name = "Toxicroak",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.FIGHTING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "490",
        movelvls = {
            {3, 8, 10, 15, 17, 22, 24, 29, 31, 36, 41, 49, 54},
            {3, 8, 10, 15, 17, 22, 24, 29, 31, 36, 41, 49, 54},
            {3, 8, 10, 15, 17, 22, 24, 29, 31, 36, 41, 49, 54},
            {3, 8, 10, 15, 17, 22, 24, 29, 31, 36, 41, 49, 54, 62},
            {3, 8, 10, 15, 17, 22, 24, 29, 31, 36, 41, 49, 54, 62}
        },
        weight = 44.4
    },
    {
        name = "Carnivine",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "454",
        movelvls = {
            {7, 11, 17, 21, 27, 31, 31, 31, 37, 41, 47},
            {7, 11, 17, 21, 27, 31, 31, 31, 37, 41, 47},
            {7, 11, 17, 21, 27, 31, 31, 31, 37, 41, 47},
            {7, 11, 17, 21, 27, 31, 37, 37, 37, 41, 47, 51},
            {7, 11, 17, 21, 27, 31, 37, 37, 37, 41, 47, 51}
        },
        weight = 27.0
    },
    {
        name = "Finneon",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "31",
        bst = "330",
        movelvls = {
            {6, 10, 13, 17, 22, 26, 29, 33, 38, 42, 45, 49},
            {6, 10, 13, 17, 22, 26, 29, 33, 38, 42, 45, 49},
            {6, 10, 13, 17, 22, 26, 29, 33, 38, 42, 45, 49},
            {6, 10, 13, 17, 22, 26, 29, 33, 38, 42, 45, 49, 54},
            {6, 10, 13, 17, 22, 26, 29, 33, 38, 42, 45, 49, 54}
        },
        weight = 7.0
    },
    {
        name = "Lumineon",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "460",
        movelvls = {
            {6, 10, 13, 17, 22, 26, 29, 35, 42, 48, 53, 59},
            {6, 10, 13, 17, 22, 26, 29, 35, 42, 48, 53, 59},
            {6, 10, 13, 17, 22, 26, 29, 35, 42, 48, 53, 59},
            {6, 10, 13, 17, 22, 26, 29, 35, 42, 48, 53, 59, 66},
            {6, 10, 13, 17, 22, 26, 29, 35, 42, 48, 53, 59, 66}
        },
        weight = 24.0
    },
    {
        name = "Mantyke",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.MANTYKE,
        bst = "345",
        movelvls = {
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 46, 49},
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 46, 49},
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 46, 49},
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 46, 49},
            {3, 7, 11, 14, 16, 19, 23, 27, 32, 36, 39, 46, 49}
        },
        weight = 65.0
    },
    {
        name = "Snover",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.ICE},
        evolution = "40",
        bst = "334",
        movelvls = {
            {5, 9, 13, 17, 21, 26, 31, 36, 41, 46},
            {5, 9, 13, 17, 21, 26, 31, 36, 41, 46},
            {5, 9, 13, 17, 21, 26, 31, 36, 41, 46},
            {5, 9, 13, 17, 21, 26, 31, 36, 41, 46},
            {5, 9, 13, 17, 21, 26, 31, 36, 41, 46}
        },
        weight = 50.5
    },
    {
        name = "Abomasnow",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.ICE},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "494",
        movelvls = {
            {5, 9, 13, 17, 21, 26, 31, 36, 47, 58},
            {5, 9, 13, 17, 21, 26, 31, 36, 47, 58},
            {5, 9, 13, 17, 21, 26, 31, 36, 47, 58},
            {5, 9, 13, 17, 21, 26, 31, 36, 47, 58},
            {5, 9, 13, 17, 21, 26, 31, 36, 47, 58}
        },
        weight = 135.5
    },
    {
        name = "Weavile",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.ICE},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "510",
        movelvls = {
            {8, 10, 14, 21, 24, 28, 35, 38, 42, 49},
            {8, 10, 14, 21, 24, 28, 35, 38, 42, 49},
            {8, 10, 14, 21, 24, 28, 35, 38, 42, 49},
            {8, 10, 14, 21, 24, 28, 35, 38, 42, 49, 51},
            {8, 10, 14, 16, 20, 22, 25, 28, 32, 35, 40, 44, 47}
        },
        weight = 34.0
    },
    {
        name = "Magnezone",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.STEEL},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "535",
        movelvls = {
            {6, 11, 14, 17, 22, 27, 30, 34, 40, 46, 50, 54, 60},
            {6, 11, 14, 17, 22, 27, 30, 34, 40, 46, 50, 54, 60},
            {6, 11, 14, 17, 22, 27, 30, 34, 40, 46, 50, 54, 60},
            {6, 11, 14, 17, 22, 27, 30, 34, 40, 46, 50, 54, 60, 66},
            {4, 7, 11, 15, 18, 21, 25, 29, 34, 39, 45, 51, 56, 62, 67, 73}
        },
        weight = 180.0
    },
    {
        name = "Lickilicky",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "515",
        movelvls = {
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61}
        },
        weight = 140.0
    },
    {
        name = "Rhyperior",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.ROCK},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "535",
        movelvls = {
            {9, 13, 21, 25, 33, 37, 42, 45, 49, 57, 61},
            {9, 13, 21, 25, 33, 37, 42, 45, 49, 57, 61},
            {9, 13, 21, 25, 33, 37, 42, 45, 49, 57, 61},
            {9, 19, 19, 23, 30, 41, 42, 47, 56, 62, 71, 77, 86},
            {9, 19, 19, 23, 30, 41, 42, 47, 56, 62, 71, 77, 86}
        },
        weight = 282.8
    },
    {
        name = "Tangrowth",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "535",
        movelvls = {
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43, 47, 50, 54, 57},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43, 47, 50, 54, 57},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43, 47, 50, 54, 57},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43, 47, 50, 54, 57},
            {4, 7, 10, 14, 17, 20, 23, 27, 30, 33, 36, 40, 43, 46, 49, 53, 56}
        },
        weight = 128.6
    },
    {
        name = "Electivire",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "540",
        movelvls = {
            {7, 10, 16, 19, 25, 28, 37, 43, 52, 58, 67},
            {7, 10, 16, 19, 25, 28, 37, 43, 52, 58, 67},
            {7, 10, 16, 19, 25, 28, 37, 43, 52, 58, 67},
            {6, 11, 16, 21, 26, 32, 38, 44, 50, 56, 62, 68},
            {5, 8, 12, 15, 19, 22, 26, 29, 36, 42, 49, 55, 62}
        },
        weight = 138.6
    },
    {
        name = "Magmortar",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "540",
        movelvls = {
            {7, 10, 16, 19, 25, 28, 37, 43, 52, 58, 67},
            {7, 10, 16, 19, 25, 28, 37, 43, 52, 58, 67},
            {7, 10, 16, 19, 25, 28, 37, 43, 52, 58, 67},
            {6, 11, 16, 21, 26, 32, 38, 44, 50, 56, 62, 68},
            {5, 8, 12, 15, 19, 22, 26, 29, 36, 42, 49, 55, 62}
        },
        weight = 68.0
    },
    {
        name = "Togekiss",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "545",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = 38.0
    },
    {
        name = "Yanmega",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "515",
        movelvls = {
            {6, 11, 14, 17, 22, 27, 30, 33, 38, 43, 46, 49, 54},
            {6, 11, 14, 17, 22, 27, 30, 33, 38, 43, 46, 49, 54, 57},
            {6, 11, 14, 17, 22, 27, 30, 33, 38, 43, 46, 49, 54, 57},
            {6, 11, 14, 17, 22, 27, 30, 33, 38, 43, 46, 49, 54, 57},
            {6, 11, 14, 17, 22, 27, 30, 33, 38, 43, 46, 49, 54, 57}
        },
        weight = 51.5
    },
    {
        name = "Leafeon",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "525",
        movelvls = {
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45}
        },
        weight = 25.5
    },
    {
        name = "Glaceon",
        type = {PokemonData.POKEMON_TYPES.ICE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "525",
        movelvls = {
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45}
        },
        weight = 25.9
    },
    {
        name = "Gliscor",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "510",
        movelvls = {
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 45},
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 45},
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 45},
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 45, 49},
            {4, 7, 10, 13, 16, 19, 22, 27, 30, 35, 40, 45, 50, 55}
        },
        weight = 42.5
    },
    {
        name = "Mamoswine",
        type = {PokemonData.POKEMON_TYPES.ICE, PokemonData.POKEMON_TYPES.GROUND},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "530",
        movelvls = {
            {4, 8, 13, 16, 20, 25, 28, 32, 33, 40, 48, 56, 65},
            {4, 8, 13, 16, 20, 25, 28, 32, 33, 40, 48, 56, 65},
            {4, 8, 13, 16, 20, 25, 28, 32, 33, 40, 48, 56, 65},
            {4, 8, 13, 16, 20, 25, 28, 32, 33, 40, 48, 56, 65},
            {5, 8, 11, 14, 18, 21, 24, 28, 33, 37, 41, 46, 52, 58}
        },
        weight = 291.0
    },
    {
        name = "Porygon-Z",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "535",
        movelvls = {
            {7, 12, 18, 23, 29, 34, 40, 45, 51, 56, 62, 67},
            {7, 12, 18, 23, 29, 34, 40, 45, 51, 56, 62, 67},
            {7, 12, 18, 23, 29, 34, 40, 45, 51, 56, 62, 67},
            {7, 12, 18, 23, 29, 34, 40, 45, 51, 56, 62, 67},
            {7, 12, 18, 23, 29, 34, 40, 45, 51, 56, 62, 67}
        },
        weight = 34.0
    },
    {
        name = "Gallade",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.FIGHTING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "518",
        movelvls = {
            {6, 10, 12, 17, 22, 25, 31, 36, 39, 45, 50, 53},
            {6, 10, 12, 17, 22, 25, 31, 36, 39, 45, 50, 53},
            {6, 10, 12, 17, 22, 25, 31, 36, 39, 45, 50, 53},
            {6, 10, 12, 17, 22, 25, 31, 36, 39, 45, 50, 53, 59, 64},
            {6, 10, 12, 17, 22, 25, 31, 36, 39, 45, 50, 53, 59, 64}
        },
        weight = 52.0
    },
    {
        name = "Probopass",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.STEEL},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "525",
        movelvls = {
            {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73},
            {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73, 79},
            {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73, 79},
            {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73, 79},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46, 50, 50}
        },
        weight = 340.0
    },
    {
        name = "Dusknoir",
        type = {PokemonData.POKEMON_TYPES.GHOST, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "525",
        movelvls = {
            {6, 9, 14, 17, 22, 25, 30, 33, 37, 43, 51, 61},
            {6, 9, 14, 17, 22, 25, 30, 33, 37, 43, 51, 61},
            {6, 9, 14, 17, 22, 25, 30, 33, 37, 43, 51, 61},
            {6, 9, 14, 17, 22, 25, 30, 33, 37, 42, 49, 58, 61},
            {6, 9, 14, 17, 22, 25, 30, 33, 37, 42, 49, 58, 61}
        },
        weight = 106.6
    },
    {
        name = "Froslass",
        type = {PokemonData.POKEMON_TYPES.ICE, PokemonData.POKEMON_TYPES.GHOST},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "480",
        movelvls = {
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 51, 59},
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 51, 59},
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 51, 59},
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 51, 59},
            {4, 10, 13, 19, 22, 28, 31, 37, 40, 51, 59}
        },
        weight = 26.6
    },
    {
        name = "Rotom",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.GHOST},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "440",
        movelvls = {
            {8, 15, 22, 29, 36, 43, 50},
            {8, 15, 22, 29, 36, 43, 50},
            {8, 15, 22, 29, 36, 43, 50},
            {8, 15, 22, 29, 36, 43, 50, 57, 64},
            {8, 15, 22, 29, 36, 43, 50, 57, 64}
        },
        weight = .3
    },
    {
        name = "Uxie",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "580",
        movelvls = {
            {6, 16, 21, 31, 36, 46, 51, 61, 66, 76},
            {6, 16, 21, 31, 36, 46, 51, 61, 66, 76},
            {6, 16, 21, 31, 36, 46, 51, 61, 66, 76},
            {6, 16, 21, 31, 36, 46, 51, 61, 66, 76},
            {6, 16, 21, 31, 36, 46, 51, 61, 66, 76}
        },
        weight = .3
    },
    {
        name = "Mesprit",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "580",
        movelvls = {
            {6, 16, 21, 31, 36, 46, 51, 61, 66, 76},
            {6, 16, 21, 31, 36, 46, 51, 61, 66, 76},
            {6, 16, 21, 31, 36, 46, 51, 61, 66, 76},
            {6, 16, 21, 31, 36, 46, 51, 61, 66, 76},
            {6, 16, 21, 31, 36, 46, 51, 61, 66, 76}
        },
        weight = .3
    },
    {
        name = "Azelf",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "580",
        movelvls = {
            {6, 16, 21, 31, 36, 46, 51, 61, 66, 76},
            {6, 16, 21, 31, 36, 46, 51, 61, 66, 76},
            {6, 16, 21, 31, 36, 46, 51, 61, 66, 76},
            {6, 16, 21, 31, 36, 46, 51, 61, 66, 76},
            {6, 16, 21, 31, 36, 46, 51, 61, 66, 76}
        },
        weight = .3
    },
    {
        name = "Dialga",
        type = {PokemonData.POKEMON_TYPES.STEEL, PokemonData.POKEMON_TYPES.DRAGON},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "680",
        movelvls = {
            {10, 20, 30, 40, 50, 60, 70, 80, 90},
            {10, 20, 30, 40, 50, 60, 70, 80, 90},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 50},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 50}
        },
        weight = 683.0
    },
    {
        name = "Palkia",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.DRAGON},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "680",
        movelvls = {
            {10, 20, 30, 40, 50, 60, 70, 80, 90},
            {10, 20, 30, 40, 50, 60, 70, 80, 90},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 50},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 50}
        },
        weight = 336.0
    },
    {
        name = "Heatran",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.STEEL},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "600",
        movelvls = {
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 88, 96},
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 88, 96},
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 88, 96},
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 88, 96},
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 88, 96}
        },
        weight = 430.0
    },
    {
        name = "Regigigas",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "670",
        movelvls = {
            {25, 50, 75, 100},
            {25, 50, 75, 100},
            {25, 50, 75, 100},
            {25, 40, 50, 65, 75, 90, 100},
            {25, 40, 50, 65, 75, 90, 100}
        },
        weight = 420.0
    },
    {
        name = "Giratina A",
        type = {PokemonData.POKEMON_TYPES.GHOST, PokemonData.POKEMON_TYPES.DRAGON},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "680",
        movelvls = {
            {10, 20, 30, 40, 50, 60, 70, 80, 90},
            {10, 20, 30, 40, 50, 60, 70, 80, 90},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 50},
            {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 50}
        },
        weight = 750.0
    },
    {
        name = "Cresselia",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "600",
        movelvls = {
            {11, 20, 29, 38, 47, 57, 66, 75, 84, 93},
            {11, 20, 29, 38, 47, 57, 66, 75, 84, 93},
            {11, 20, 29, 38, 47, 57, 66, 75, 84, 93},
            {11, 20, 29, 38, 47, 57, 66, 75, 84, 93},
            {11, 20, 29, 38, 47, 57, 66, 75, 84, 93}
        },
        weight = 85.6
    },
    {
        name = "Phione",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "480",
        movelvls = {
            {9, 16, 24, 31, 39, 46, 54, 61, 69},
            {9, 16, 24, 31, 39, 46, 54, 61, 69},
            {9, 16, 24, 31, 39, 46, 54, 61, 69},
            {9, 16, 24, 31, 39, 46, 54, 61, 69},
            {9, 16, 24, 31, 39, 46, 54, 61, 69}
        },
        weight = 3.1
    },
    {
        name = "Manaphy",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "600",
        movelvls = {
            {9, 16, 24, 31, 39, 46, 54, 61, 69, 76},
            {9, 16, 24, 31, 39, 46, 54, 61, 69, 76},
            {9, 16, 24, 31, 39, 46, 54, 61, 69, 76},
            {9, 16, 24, 31, 39, 46, 54, 61, 69, 76},
            {9, 16, 24, 31, 39, 46, 54, 61, 69, 76}
        },
        weight = 1.4
    },
    {
        name = "Darkrai",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "600",
        movelvls = {
            {11, 20, 29, 38, 47, 57, 66, 75, 84, 93},
            {11, 20, 29, 38, 47, 57, 66, 75, 84, 93},
            {11, 20, 29, 38, 47, 57, 66, 75, 84, 93},
            {11, 20, 29, 38, 47, 57, 66, 75, 84, 93},
            {11, 20, 29, 38, 47, 57, 66, 75, 84, 93}
        },
        weight = 50.5
    },
    {
        name = "Shaymin L",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "600",
        movelvls = {
            {10, 19, 28, 37, 46, 55, 64, 73, 82, 91, 100},
            {10, 19, 28, 37, 46, 55, 64, 73, 82, 91, 100},
            {10, 19, 28, 37, 46, 55, 64, 73, 82, 91, 100},
            {10, 19, 28, 37, 46, 55, 64, 73, 82, 91, 100},
            {10, 19, 28, 37, 46, 55, 64, 73, 82, 91, 100}
        },
        weight = 2.1
    },
    {
        name = "Arceus",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "720",
        movelvls = {
            {10, 20, 30, 40, 50, 60, 70, 80, 90, 100},
            {10, 20, 30, 40, 50, 60, 70, 80, 90, 100},
            {10, 20, 30, 40, 50, 60, 70, 80, 90, 100},
            {10, 20, 30, 40, 50, 60, 70, 80, 90, 100},
            {10, 20, 30, 40, 50, 60, 70, 80, 90, 100}
        },
        weight = 320.0
    },
    --gen 5(#494-649)
    {
        name = "Victini",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.FIRE},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "600",
        movelvls = {
            {},
            {},
            {},
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97},
            {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97}
        },
        weight = 4.0
    },
    {
        name = "Snivy",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "17",
        bst = "308",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43}
        },
        weight = 8.1
    },
    {
        name = "Servine",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "36",
        bst = "413",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 40, 44, 48, 52}
        },
        weight = 16.0
    },
    {
        name = "Serperior",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "528",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 38, 44, 50, 56, 62},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 38, 44, 50, 56, 62}
        },
        weight = 63.0
    },
    {
        name = "Tepig",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "17",
        bst = "308",
        movelvls = {
            {},
            {},
            {},
            {3, 7, 9, 13, 15, 19, 21, 25, 27, 31, 33, 37, 39, 43},
            {3, 7, 9, 13, 15, 19, 21, 25, 27, 31, 33, 37, 39, 43}
        },
        weight = 9.9
    },
    {
        name = "Pignite",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.FIGHTING},
        evolution = "36",
        bst = "418",
        movelvls = {
            {},
            {},
            {},
            {3, 7, 9, 13, 15, 17, 20, 23, 28, 31, 36, 39, 44, 47, 52},
            {3, 7, 9, 13, 15, 17, 20, 23, 28, 31, 36, 39, 44, 47, 52}
        },
        weight = 55.5
    },
    {
        name = "Emboar",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.FIGHTING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "528",
        movelvls = {
            {},
            {},
            {},
            {3, 7, 9, 13, 15, 17, 20, 23, 28, 31, 38, 43, 50, 55, 62},
            {3, 7, 9, 13, 15, 17, 20, 23, 28, 31, 38, 43, 50, 55, 62}
        },
        weight = 150.0
    },
    {
        name = "Oshawott",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "17",
        bst = "308",
        movelvls = {
            {},
            {},
            {},
            {5, 7, 11, 13, 17, 19, 23, 25, 29, 31, 35, 37, 41, 43},
            {5, 7, 11, 13, 17, 19, 23, 25, 29, 31, 35, 37, 41, 43}
        },
        weight = 5.9
    },
    {
        name = "Dewott",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "36",
        bst = "413",
        movelvls = {
            {},
            {},
            {},
            {5, 7, 11, 13, 17, 20, 25, 28, 33, 36, 41, 44, 49, 52},
            {5, 7, 11, 13, 17, 20, 25, 28, 33, 36, 41, 44, 49, 52}
        },
        weight = 24.5
    },
    {
        name = "Samurott",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "528",
        movelvls = {
            {},
            {},
            {},
            {5, 7, 11, 13, 17, 20, 25, 28, 33, 36, 38, 45, 50, 57, 62},
            {5, 7, 11, 13, 17, 20, 25, 28, 33, 36, 38, 45, 50, 57, 62}
        },
        weight = 94.6
    },
    {
        name = "Patrat",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "20",
        bst = "255",
        movelvls = {
            {},
            {},
            {},
            {3, 6, 8, 11, 13, 16, 18, 21, 23, 26, 28, 31, 33, 36},
            {3, 6, 8, 11, 13, 16, 18, 21, 23, 26, 28, 31, 33, 36}
        },
        weight = 11.6
    },
    {
        name = "Watchog",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "420",
        movelvls = {
            {},
            {},
            {},
            {3, 6, 8, 11, 13, 16, 18, 20, 22, 25, 29, 32, 36, 39, 43},
            {3, 6, 8, 11, 13, 16, 18, 20, 22, 25, 29, 32, 36, 39, 43}
        },
        weight = 27.0
    },
    {
        name = "Lillipup",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "16",
        bst = "275",
        movelvls = {
            {},
            {},
            {},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40}
        },
        weight = 4.1
    },
    {
        name = "Herdier",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "32",
        bst = "370",
        movelvls = {
            {},
            {},
            {},
            {5, 8, 12, 15, 20, 24, 29, 33, 38, 42, 47},
            {5, 8, 12, 15, 20, 24, 29, 33, 38, 42, 47}
        },
        weight = 14.7
    },
    {
        name = "Stoutland",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "490",
        movelvls = {
            {},
            {},
            {},
            {5, 8, 12, 15, 20, 24, 29, 36, 42, 51, 59},
            {5, 8, 12, 15, 20, 24, 29, 36, 42, 51, 59}
        },
        weight = 61.0
    },
    {
        name = "Purrloin",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "20",
        bst = "281",
        movelvls = {
            {},
            {},
            {},
            {3, 6, 10, 12, 15, 19, 21, 24, 28, 30, 33, 37, 39, 42, 46},
            {3, 6, 10, 12, 15, 19, 21, 24, 28, 30, 33, 37, 39, 42, 46}
        },
        weight = 10.1
    },
    {
        name = "Liepard",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "446",
        movelvls = {
            {},
            {},
            {},
            {3, 6, 10, 12, 15, 19, 22, 26, 31, 34, 38, 43, 47, 50, 55},
            {3, 6, 10, 12, 15, 19, 22, 26, 31, 34, 38, 43, 47, 50, 55}
        },
        weight = 37.5
    },
    {
        name = "Pansage",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.LEAF,
        bst = "316",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43}
        },
        weight = 10.5
    },
    {
        name = "Simisage",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "498",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = 30.5
    },
    {
        name = "Pansear",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.FIRE,
        bst = "316",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43}
        },
        weight = 11.0
    },
    {
        name = "Simisear",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "498",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = 28.0
    },
    {
        name = "Panpour",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.WATER,
        bst = "316",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43}
        },
        weight = 13.5
    },
    {
        name = "Simipour",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "498",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = 29.0
    },
    {
        name = "Munna",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.MOON,
        bst = "292",
        movelvls = {
            {},
            {},
            {},
            {5, 7, 11, 13, 17, 19, 23, 25, 29, 31, 35, 37, 41, 43, 47},
            {5, 7, 11, 13, 17, 19, 23, 25, 29, 31, 35, 37, 41, 43, 47}
        },
        weight = 23.3
    },
    {
        name = "Musharna",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "487",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = 60.5
    },
    {
        name = "Pidove",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = "21",
        bst = "264",
        movelvls = {
            {},
            {},
            {},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46, 50},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46, 50}
        },
        weight = 2.1
    },
    {
        name = "Tranquill",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = "32",
        bst = "358",
        movelvls = {
            {},
            {},
            {},
            {4, 8, 11, 15, 18, 23, 27, 32, 36, 41, 45, 50, 54, 59},
            {4, 8, 11, 15, 18, 23, 27, 32, 36, 41, 45, 50, 54, 59}
        },
        weight = 15.0
    },
    {
        name = "Unfezant M",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "478",
        movelvls = {
            {},
            {},
            {},
            {4, 8, 11, 15, 18, 23, 27, 33, 38, 44, 49, 55, 60, 66},
            {4, 8, 11, 15, 18, 23, 27, 33, 38, 44, 49, 55, 60, 66}
        },
        weight = 29.0
    },
    {
        name = "Blitzle",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "27",
        bst = "295",
        movelvls = {
            {},
            {},
            {},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43}
        },
        weight = 29.8
    },
    {
        name = "Zebstrika",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "497",
        movelvls = {
            {},
            {},
            {},
            {4, 8, 11, 15, 18, 22, 25, 31, 36, 42, 47, 53},
            {4, 8, 11, 15, 18, 22, 25, 31, 36, 42, 47, 53}
        },
        weight = 79.5
    },
    {
        name = "Roggenrola",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "25",
        bst = "280",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 10, 14, 17, 20, 23, 27, 30, 33, 36, 40},
            {4, 7, 10, 14, 17, 20, 23, 27, 30, 33, 36, 40}
        },
        weight = 18.0
    },
    {
        name = "Boldore",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "37",
        bst = "390",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 10, 14, 17, 20, 23, 25, 30, 36, 42, 48, 55},
            {4, 7, 10, 14, 17, 20, 23, 25, 30, 36, 42, 48, 55}
        },
        weight = 102.0
    },
    {
        name = "Gigalith",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "505",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 10, 14, 17, 20, 23, 25, 30, 36, 42, 48, 55},
            {4, 7, 10, 14, 17, 20, 23, 25, 30, 36, 42, 48, 55}
        },
        weight = 260.0
    },
    {
        name = "Woobat",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.FRIEND,
        baseFriendship = 70,
        bst = "313",
        movelvls = {
            {},
            {},
            {},
            {4, 8, 12, 15, 19, 21, 25, 29, 29, 32, 36, 41, 47},
            {4, 8, 12, 15, 19, 21, 25, 29, 29, 32, 36, 41, 47}
        },
        weight = 2.1
    },
    {
        name = "Swoobat",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "425",
        movelvls = {
            {},
            {},
            {},
            {4, 8, 12, 15, 19, 21, 25, 29, 29, 32, 36, 41, 47},
            {4, 8, 12, 15, 19, 21, 25, 29, 29, 32, 36, 41, 47}
        },
        weight = 10.5
    },
    {
        name = "Drilbur",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "31",
        bst = "328",
        movelvls = {
            {},
            {},
            {},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43, 47},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43, 47}
        },
        weight = 8.5
    },
    {
        name = "Excadrill",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.STEEL},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "508",
        movelvls = {
            {},
            {},
            {},
            {5, 8, 12, 15, 19, 22, 26, 29, 31, 36, 42, 49, 55, 62},
            {5, 8, 12, 15, 19, 22, 26, 29, 31, 36, 42, 49, 55, 62}
        },
        weight = 40.4
    },
    {
        name = "Audino",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "445",
        movelvls = {
            {},
            {},
            {},
            {5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55},
            {5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55}
        },
        weight = 31.0
    },
    {
        name = "Timburr",
        type = {PokemonData.POKEMON_TYPES.FIGHTING, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "25",
        bst = "305",
        movelvls = {
            {},
            {},
            {},
            {4, 8, 12, 16, 20, 24, 28, 31, 34, 37, 40, 43, 46, 49},
            {4, 8, 12, 16, 20, 24, 28, 31, 34, 37, 40, 43, 46, 49}
        },
        weight = 12.5
    },
    {
        name = "Gurdurr",
        type = {PokemonData.POKEMON_TYPES.FIGHTING, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "37",
        bst = "405",
        movelvls = {
            {},
            {},
            {},
            {4, 8, 12, 16, 20, 24, 29, 33, 37, 41, 45, 49, 53, 57},
            {4, 8, 12, 16, 20, 24, 29, 33, 37, 41, 45, 49, 53, 57}
        },
        weight = 40.0
    },
    {
        name = "Conkeldurr",
        type = {PokemonData.POKEMON_TYPES.FIGHTING, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "505",
        movelvls = {
            {},
            {},
            {},
            {4, 8, 12, 16, 20, 24, 29, 33, 37, 41, 45, 49, 53, 57},
            {4, 8, 12, 16, 20, 24, 29, 33, 37, 41, 45, 49, 53, 57}
        },
        weight = 87.0
    },
    {
        name = "Tympole",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "25",
        bst = "294",
        movelvls = {
            {},
            {},
            {},
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 45},
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 45}
        },
        weight = 4.5
    },
    {
        name = "Palpitoad",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.GROUND},
        evolution = "36",
        bst = "384",
        movelvls = {
            {},
            {},
            {},
            {5, 9, 12, 16, 20, 23, 28, 33, 37, 42, 47, 51},
            {5, 9, 12, 16, 20, 23, 28, 33, 37, 42, 47, 51}
        },
        weight = 17.0
    },
    {
        name = "Seismitoad",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.GROUND},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "499",
        movelvls = {
            {},
            {},
            {},
            {5, 9, 12, 16, 20, 23, 28, 33, 36, 39, 44, 49, 53, 59},
            {5, 9, 12, 16, 20, 23, 28, 33, 36, 39, 44, 49, 53, 59}
        },
        weight = 62.0
    },
    {
        name = "Throh",
        type = {PokemonData.POKEMON_TYPES.FIGHTING, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "465",
        movelvls = {
            {},
            {},
            {},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53}
        },
        weight = 55.5
    },
    {
        name = "Sawk",
        type = {PokemonData.POKEMON_TYPES.FIGHTING, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "465",
        movelvls = {
            {},
            {},
            {},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53}
        },
        weight = 51.0
    },
    {
        name = "Sewaddle",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.GRASS},
        evolution = "20",
        bst = "310",
        movelvls = {
            {},
            {},
            {},
            {8, 15, 22, 29, 36, 43},
            {8, 15, 22, 29, 36, 43}
        },
        weight = 2.5
    },
    {
        name = "Swadloon",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.GRASS},
        evolution = PokemonData.EVOLUTION_TYPES.FRIEND,
        baseFriendship = 70,
        bst = "380",
        movelvls = {
            {},
            {},
            {},
            {20},
            {20}
        },
        weight = 7.3
    },
    {
        name = "Leavanny",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.GRASS},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "490",
        movelvls = {
            {},
            {},
            {},
            {8, 15, 22, 29, 32, 36, 39, 43, 46, 50},
            {8, 15, 22, 29, 32, 36, 39, 43, 46, 50}
        },
        weight = 20.5
    },
    {
        name = "Venipede",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.POISON},
        evolution = "22",
        bst = "260",
        movelvls = {
            {},
            {},
            {},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43},
            {5, 8, 12, 15, 19, 22, 26, 29, 33, 36, 40, 43}
        },
        weight = 5.3
    },
    {
        name = "Whirlipede",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.POISON},
        evolution = "30",
        bst = "360",
        movelvls = {
            {},
            {},
            {},
            {5, 8, 12, 15, 19, 22, 23, 28, 32, 37, 41, 46, 50},
            {5, 8, 12, 15, 19, 22, 23, 28, 32, 37, 41, 46, 50}
        },
        weight = 58.5
    },
    {
        name = "Scolipede",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.POISON},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "475",
        movelvls = {
            {},
            {},
            {},
            {5, 8, 12, 15, 19, 23, 28, 30, 33, 39, 44, 50, 55},
            {5, 8, 12, 15, 19, 23, 28, 30, 33, 39, 44, 50, 55}
        },
        weight = 200.5
    },
    {
        name = "Cottonee",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.SUN,
        bst = "280",
        movelvls = {
            {},
            {},
            {},
            {4, 8, 10, 13, 17, 19, 22, 26, 28, 31, 35, 37, 40, 44, 46},
            {4, 8, 10, 13, 17, 19, 22, 26, 28, 31, 35, 37, 40, 44, 46}
        },
        weight = .6
    },
    {
        name = "Whimsicott",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "480",
        movelvls = {
            {},
            {},
            {},
            {10, 28, 46},
            {10, 28, 46}
        },
        weight = 6.6
    },
    {
        name = "Petilil",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.SUN,
        bst = "280",
        movelvls = {
            {},
            {},
            {},
            {4, 8, 10, 13, 17, 19, 22, 26, 28, 31, 35, 37, 40, 44, 46},
            {4, 8, 10, 13, 17, 19, 22, 26, 28, 31, 35, 37, 40, 44, 46}
        },
        weight = 6.6
    },
    {
        name = "Lilligant",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "480",
        movelvls = {
            {},
            {},
            {},
            {10, 28, 46},
            {10, 28, 46}
        },
        weight = 16.3
    },
    {
        name = "Basculin R",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "460",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 41, 46, 51, 56},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 41, 46, 51, 56}
        },
        weight = 18.0
    },
    {
        name = "Sandile",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.DARK},
        evolution = "29",
        bst = "292",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 31, 34, 37, 40, 43, 46}
        },
        weight = 15.2
    },
    {
        name = "Krokorok",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.DARK},
        evolution = "40",
        bst = "351",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 32, 36, 40, 44, 48, 52},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 32, 36, 40, 44, 48, 52}
        },
        weight = 33.4
    },
    {
        name = "Krookodile",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.DARK},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "509",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 32, 36, 42, 48, 54, 60},
            {4, 7, 10, 13, 16, 19, 22, 25, 28, 32, 36, 42, 48, 54, 60}
        },
        weight = 96.3
    },
    {
        name = "Darumaka",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "35",
        bst = "315",
        movelvls = {
            {},
            {},
            {},
            {3, 6, 9, 11, 14, 17, 19, 22, 25, 27, 30, 33, 35, 39, 42},
            {3, 6, 9, 11, 14, 17, 19, 22, 25, 27, 30, 33, 35, 39, 42}
        },
        weight = 37.5
    },
    {
        name = "Darmanitan",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "480",
        movelvls = {
            {},
            {},
            {},
            {3, 6, 9, 11, 14, 17, 19, 22, 25, 27, 30, 33, 35, 39, 47, 54},
            {3, 6, 9, 11, 14, 17, 19, 22, 25, 27, 30, 33, 35, 39, 47, 54}
        },
        weight = 92.9
    },
    {
        name = "Maractus",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "461",
        movelvls = {
            {},
            {},
            {},
            {3, 6, 10, 13, 15, 18, 22, 26, 29, 33, 38, 42, 45, 50, 55, 57},
            {3, 6, 10, 13, 15, 18, 22, 26, 29, 33, 38, 42, 45, 50, 55, 57}
        },
        weight = 28.0
    },
    {
        name = "Dwebble",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.ROCK},
        evolution = "34",
        bst = "325",
        movelvls = {
            {},
            {},
            {},
            {5, 7, 11, 13, 17, 19, 23, 24, 29, 31, 35, 37, 41, 43},
            {5, 7, 11, 13, 17, 19, 23, 24, 29, 31, 35, 37, 41, 43}
        },
        weight = 14.5
    },
    {
        name = "Crustle",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.ROCK},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "475",
        movelvls = {
            {},
            {},
            {},
            {5, 7, 11, 13, 17, 19, 23, 24, 29, 31, 38, 43, 50, 55},
            {5, 7, 11, 13, 17, 19, 23, 24, 29, 31, 38, 43, 50, 55}
        },
        weight = 200.0
    },
    {
        name = "Scraggy",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.FIGHTING},
        evolution = "39",
        bst = "348",
        movelvls = {
            {},
            {},
            {},
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 45, 49, 53},
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 42, 45, 49, 53}
        },
        weight = 11.8
    },
    {
        name = "Scrafty",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.FIGHTING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "488",
        movelvls = {
            {},
            {},
            {},
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 45, 51, 58, 65},
            {5, 9, 12, 16, 20, 23, 27, 31, 34, 38, 45, 51, 58, 65}
        },
        weight = 30.0
    },
    {
        name = "Sigilyph",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "490",
        movelvls = {
            {},
            {},
            {},
            {4, 8, 11, 14, 18, 21, 24, 28, 31, 34, 38, 41, 44, 48, 51},
            {4, 8, 11, 14, 18, 21, 24, 28, 31, 34, 38, 41, 44, 48, 51}
        },
        weight = 14.0
    },
    {
        name = "Yamask",
        type = {PokemonData.POKEMON_TYPES.GHOST, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "34",
        bst = "303",
        movelvls = {
            {},
            {},
            {},
            {5, 9, 13, 17, 21, 25, 29, 33, 33, 37, 41, 45, 49},
            {5, 9, 13, 17, 21, 25, 29, 33, 33, 37, 41, 45, 49}
        },
        weight = 1.5
    },
    {
        name = "Cofagrigus",
        type = {PokemonData.POKEMON_TYPES.GHOST, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "483",
        movelvls = {
            {},
            {},
            {},
            {5, 9, 13, 17, 21, 25, 29, 33, 33, 34, 39, 45, 51, 57},
            {5, 9, 13, 17, 21, 25, 29, 33, 33, 34, 39, 45, 51, 57}
        },
        weight = 76.5
    },
    {
        name = "Tirtouga",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.ROCK},
        evolution = "37",
        bst = "355",
        movelvls = {
            {},
            {},
            {},
            {5, 8, 11, 15, 18, 21, 25, 28, 31, 35, 38, 41, 45, 48, 51},
            {5, 8, 11, 15, 18, 21, 25, 28, 31, 35, 38, 41, 45, 48, 51}
        },
        weight = 16.5
    },
    {
        name = "Carracosta",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.ROCK},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "495",
        movelvls = {
            {},
            {},
            {},
            {5, 8, 11, 15, 18, 21, 25, 28, 31, 35, 40, 45, 51, 56, 61},
            {5, 8, 11, 15, 18, 21, 25, 28, 31, 35, 40, 45, 51, 56, 61}
        },
        weight = 81.0
    },
    {
        name = "Archen",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.FLYING},
        evolution = "37",
        bst = "401",
        movelvls = {
            {},
            {},
            {},
            {5, 8, 11, 15, 18, 21, 25, 28, 31, 35, 38, 41, 45, 48, 51},
            {5, 8, 11, 15, 18, 21, 25, 28, 31, 35, 38, 41, 45, 48, 51}
        },
        weight = 9.5
    },
    {
        name = "Archeops",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "567",
        movelvls = {
            {},
            {},
            {},
            {5, 8, 11, 15, 18, 21, 25, 28, 31, 35, 40, 45, 51, 56, 61},
            {5, 8, 11, 15, 18, 21, 25, 28, 31, 35, 40, 45, 51, 56, 61}
        },
        weight = 32.0
    },
    {
        name = "Trubbish",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "36",
        bst = "329",
        movelvls = {
            {},
            {},
            {},
            {3, 7, 12, 14, 18, 23, 23, 25, 29, 34, 36, 40, 45, 47},
            {3, 7, 12, 14, 18, 23, 23, 25, 29, 34, 36, 40, 45, 47}
        },
        weight = 31.0
    },
    {
        name = "Garbodor",
        type = {PokemonData.POKEMON_TYPES.POISON, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "474",
        movelvls = {
            {},
            {},
            {},
            {3, 7, 12, 14, 18, 23, 23, 25, 29, 34, 39, 46, 54, 59},
            {3, 7, 12, 14, 18, 23, 23, 25, 29, 34, 39, 46, 54, 59}
        },
        weight = 107.3
    },
    {
        name = "Zorua",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "30",
        bst = "330",
        movelvls = {
            {},
            {},
            {},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57}
        },
        weight = 12.5
    },
    {
        name = "Zoroark",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "510",
        movelvls = {
            {},
            {},
            {},
            {5, 9, 13, 17, 21, 25, 29, 30, 34, 39, 44, 49, 54, 59, 64},
            {5, 9, 13, 17, 21, 25, 29, 30, 34, 39, 44, 49, 54, 59, 64}
        },
        weight = 81.1
    },
    {
        name = "Minccino",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.SHINY_STONE,
        bst = "300",
        movelvls = {
            {},
            {},
            {},
            {3, 7, 9, 13, 15, 19, 21, 25, 27, 31, 33, 37, 39, 43, 45, 49},
            {3, 7, 9, 13, 15, 19, 21, 25, 27, 31, 33, 37, 39, 43, 45, 49}
        },
        weight = 5.8
    },
    {
        name = "Cinccino",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "470",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = 7.5
    },
    {
        name = "Gothita",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "32",
        bst = "290",
        movelvls = {
            {},
            {},
            {},
            {3, 7, 10, 14, 16, 19, 24, 25, 28, 31, 33, 37, 40, 46, 48},
            {3, 7, 10, 14, 16, 19, 24, 25, 28, 31, 33, 37, 40, 46, 48}
        },
        weight = 5.8
    },
    {
        name = "Gothorita",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "41",
        bst = "390",
        movelvls = {
            {},
            {},
            {},
            {3, 7, 10, 14, 16, 19, 24, 25, 28, 31, 34, 39, 43, 50, 53},
            {3, 7, 10, 14, 16, 19, 24, 25, 28, 31, 34, 39, 43, 50, 53}
        },
        weight = 18.0
    },
    {
        name = "Gothitelle",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "490",
        movelvls = {
            {},
            {},
            {},
            {3, 7, 10, 14, 16, 19, 24, 25, 28, 31, 34, 39, 45, 54, 59},
            {3, 7, 10, 14, 16, 19, 24, 25, 28, 31, 34, 39, 45, 54, 59}
        },
        weight = 44.0
    },
    {
        name = "Solosis",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "32",
        bst = "290",
        movelvls = {
            {},
            {},
            {},
            {3, 7, 10, 14, 16, 19, 24, 25, 28, 31, 33, 37, 40, 46, 48},
            {3, 7, 10, 14, 16, 19, 24, 25, 28, 31, 33, 37, 40, 46, 48}
        },
        weight = 1.0
    },
    {
        name = "Duosion",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "41",
        bst = "370",
        movelvls = {
            {},
            {},
            {},
            {3, 7, 10, 14, 16, 19, 24, 25, 28, 31, 34, 39, 43, 50, 53},
            {3, 7, 10, 14, 16, 19, 24, 25, 28, 31, 34, 39, 43, 50, 53}
        },
        weight = 8.0
    },
    {
        name = "Reuniclus",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "490",
        movelvls = {
            {},
            {},
            {},
            {3, 7, 10, 14, 16, 19, 24, 25, 28, 31, 34, 39, 41, 45, 54, 59},
            {3, 7, 10, 14, 16, 19, 24, 25, 28, 31, 34, 39, 41, 45, 54, 59}
        },
        weight = 20.1
    },
    {
        name = "Ducklett",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.FLYING},
        evolution = "35",
        bst = "305",
        movelvls = {
            {},
            {},
            {},
            {3, 6, 9, 13, 15, 19, 21, 24, 27, 30, 34, 37, 41, 46},
            {3, 6, 9, 13, 15, 19, 21, 24, 27, 30, 34, 37, 41, 46}
        },
        weight = 5.5
    },
    {
        name = "Swanna",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "473",
        movelvls = {
            {},
            {},
            {},
            {3, 6, 9, 13, 15, 19, 21, 24, 27, 30, 34, 40, 47, 55},
            {3, 6, 9, 13, 15, 19, 21, 24, 27, 30, 34, 40, 47, 55}
        },
        weight = 24.2
    },
    {
        name = "Vanillite",
        type = {PokemonData.POKEMON_TYPES.ICE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "35",
        bst = "305",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 10, 13, 16, 19, 22, 26, 31, 35, 40, 44, 49, 53},
            {4, 7, 10, 13, 16, 19, 22, 26, 31, 35, 40, 44, 49, 53}
        },
        weight = 5.7
    },
    {
        name = "Vanillish",
        type = {PokemonData.POKEMON_TYPES.ICE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "47",
        bst = "395",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 10, 13, 16, 19, 22, 26, 31, 36, 42, 47, 53, 58},
            {4, 7, 10, 13, 16, 19, 22, 26, 31, 36, 42, 47, 53, 58}
        },
        weight = 41.0
    },
    {
        name = "Vanilluxe",
        type = {PokemonData.POKEMON_TYPES.ICE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "535",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 10, 13, 16, 19, 22, 26, 31, 36, 42, 50, 59, 67},
            {4, 7, 10, 13, 16, 19, 22, 26, 31, 36, 42, 50, 59, 67}
        },
        weight = 57.5
    },
    {
        name = "Deerling",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.GRASS},
        evolution = "34",
        bst = "335",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 41, 46, 51},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 41, 46, 51}
        },
        weight = 19.5
    },
    {
        name = "Sawsbuck",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.GRASS},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "475",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 37, 44, 52, 60},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 37, 44, 52, 60}
        },
        weight = 92.5
    },
    {
        name = "Emolga",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "428",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 10, 13, 16, 19, 22, 26, 30, 34, 38, 42, 46, 50},
            {4, 7, 10, 13, 16, 19, 22, 26, 30, 34, 38, 42, 46, 50}
        },
        weight = 5.0
    },
    {
        name = "Karrablast",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.KARRABLAST,
        bst = "315",
        movelvls = {
            {},
            {},
            {},
            {4, 8, 13, 16, 20, 25, 28, 32, 37, 40, 44, 49, 52, 56},
            {4, 8, 13, 16, 20, 25, 28, 32, 37, 40, 44, 49, 52, 56}
        },
        weight = 5.9
    },
    {
        name = "Escavalier",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.STEEL},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "495",
        movelvls = {
            {},
            {},
            {},
            {4, 8, 13, 16, 20, 25, 28, 32, 37, 40, 44, 49, 52, 56},
            {4, 8, 13, 16, 20, 25, 28, 32, 37, 40, 44, 49, 52, 56}
        },
        weight = 33.0
    },
    {
        name = "Foongus",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.POISON},
        evolution = "39",
        bst = "294",
        movelvls = {
            {},
            {},
            {},
            {6, 8, 12, 15, 18, 20, 24, 28, 32, 35, 39, 43, 45, 50},
            {6, 8, 12, 15, 18, 20, 24, 28, 32, 35, 39, 43, 45, 50}
        },
        weight = 1.0
    },
    {
        name = "Amoonguss",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.POISON},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "464",
        movelvls = {
            {},
            {},
            {},
            {6, 8, 12, 15, 18, 20, 24, 28, 32, 35, 43, 49, 54, 62},
            {6, 8, 12, 15, 18, 20, 24, 28, 32, 35, 43, 49, 54, 62}
        },
        weight = 10.5
    },
    {
        name = "Frillish M",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.GHOST},
        evolution = "40",
        bst = "335",
        movelvls = {
            {},
            {},
            {},
            {5, 9, 13, 17, 22, 27, 32, 37, 43, 49, 55, 61},
            {5, 9, 13, 17, 22, 27, 32, 37, 43, 49, 55, 61}
        },
        weight = 33.0
    },
    {
        name = "Jellicent M",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.GHOST},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "480",
        movelvls = {
            {},
            {},
            {},
            {5, 9, 13, 17, 22, 27, 32, 37, 45, 53, 61, 69},
            {5, 9, 13, 17, 22, 27, 32, 37, 45, 53, 61, 69}
        },
        weight = 135.0
    },
    {
        name = "Alomomola",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "470",
        movelvls = {
            {},
            {},
            {},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61}
        },
        weight = 31.6
    },
    {
        name = "Joltik",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.ELECTRIC},
        evolution = "36",
        bst = "319",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 12, 15, 18, 23, 26, 29, 34, 37, 40, 45, 48},
            {4, 7, 12, 15, 18, 23, 26, 29, 34, 37, 40, 45, 48}
        },
        weight = .6
    },
    {
        name = "Galvantula",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.ELECTRIC},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "472",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 12, 15, 18, 23, 26, 29, 34, 40, 46, 54, 60},
            {4, 7, 12, 15, 18, 23, 26, 29, 34, 40, 46, 54, 60}
        },
        weight = 14.3
    },
    {
        name = "Ferroseed",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.STEEL},
        evolution = "40",
        bst = "305",
        movelvls = {
            {},
            {},
            {},
            {6, 9, 14, 18, 21, 26, 30, 35, 38, 43, 47, 52, 55},
            {6, 9, 14, 18, 21, 26, 30, 35, 38, 43, 47, 52, 55}
        },
        weight = 18.8
    },
    {
        name = "Ferrothorn",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.STEEL},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "489",
        movelvls = {
            {},
            {},
            {},
            {6, 9, 14, 18, 21, 26, 30, 35, 38, 40, 46, 53, 61, 67},
            {6, 9, 14, 18, 21, 26, 30, 35, 38, 40, 46, 53, 61, 67}
        },
        weight = 110.0
    },
    {
        name = "Klink",
        type = {PokemonData.POKEMON_TYPES.STEEL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "38",
        bst = "300",
        movelvls = {
            {},
            {},
            {},
            {6, 11, 16, 21, 26, 31, 36, 39, 42, 45, 48, 51, 54, 57},
            {6, 11, 16, 21, 26, 31, 36, 39, 42, 45, 48, 51, 54, 57}
        },
        weight = 21.0
    },
    {
        name = "Klang",
        type = {PokemonData.POKEMON_TYPES.STEEL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "49",
        bst = "440",
        movelvls = {
            {},
            {},
            {},
            {6, 11, 16, 21, 26, 31, 36, 40, 44, 48, 52, 56, 60, 64},
            {6, 11, 16, 21, 26, 31, 36, 40, 44, 48, 52, 56, 60, 64}
        },
        weight = 51.0
    },
    {
        name = "Klinklang",
        type = {PokemonData.POKEMON_TYPES.STEEL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "520",
        movelvls = {
            {},
            {},
            {},
            {6, 11, 16, 21, 25, 31, 36, 40, 44, 48, 54, 60, 66, 72},
            {6, 11, 16, 21, 25, 31, 36, 40, 44, 48, 54, 60, 66, 72}
        },
        weight = 81.0
    },
    {
        name = "Tynamo",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "39",
        bst = "275",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = .3
    },
    {
        name = "Eelektrik",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.THUNDER,
        bst = "405",
        movelvls = {
            {},
            {},
            {},
            {9, 19, 29, 39, 44, 49, 54, 59, 64, 69, 74},
            {9, 19, 29, 39, 44, 49, 54, 59, 64, 69, 74}
        },
        weight = 22.0
    },
    {
        name = "Eelektross",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "515",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = 80.5
    },
    {
        name = "Elgyem",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "42",
        bst = "335",
        movelvls = {
            {},
            {},
            {},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46, 50, 50, 53, 56},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 43, 46, 50, 50, 53, 56}
        },
        weight = 9.0
    },
    {
        name = "Beheeyem",
        type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "485",
        movelvls = {
            {},
            {},
            {},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 45, 50, 56, 58, 63, 68},
            {4, 8, 11, 15, 18, 22, 25, 29, 32, 36, 39, 45, 50, 56, 58, 63, 68}
        },
        weight = 34.5
    },
    {
        name = "Litwick",
        type = {PokemonData.POKEMON_TYPES.GHOST, PokemonData.POKEMON_TYPES.FIRE},
        evolution = "41",
        bst = "275",
        movelvls = {
            {},
            {},
            {},
            {3, 5, 7, 10, 13, 16, 20, 24, 28, 33, 38, 43, 49, 55, 61},
            {3, 5, 7, 10, 13, 16, 20, 24, 28, 33, 38, 43, 49, 55, 61}
        },
        weight = 3.1
    },
    {
        name = "Lampent",
        type = {PokemonData.POKEMON_TYPES.GHOST, PokemonData.POKEMON_TYPES.FIRE},
        evolution = PokemonData.EVOLUTION_TYPES.DUSK,
        bst = "370",
        movelvls = {
            {},
            {},
            {},
            {3, 5, 7, 10, 13, 16, 20, 24, 28, 33, 38, 45, 53, 61, 69},
            {3, 5, 7, 10, 13, 16, 20, 24, 28, 33, 38, 45, 53, 61, 69}
        },
        weight = 13.0
    },
    {
        name = "Chandelure",
        type = {PokemonData.POKEMON_TYPES.GHOST, PokemonData.POKEMON_TYPES.FIRE},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "520",
        movelvls = {
            {},
            {},
            {},
            {},
            {}
        },
        weight = 34.3
    },
    {
        name = "Axew",
        type = {PokemonData.POKEMON_TYPES.DRAGON, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "38",
        bst = "320",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 41, 46, 51, 56, 61},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 41, 46, 51, 56, 61}
        },
        weight = 18.0
    },
    {
        name = "Fraxure",
        type = {PokemonData.POKEMON_TYPES.DRAGON, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "48",
        bst = "410",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 42, 48, 54, 60, 66},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 42, 48, 54, 60, 66}
        },
        weight = 36.0
    },
    {
        name = "Haxorus",
        type = {PokemonData.POKEMON_TYPES.DRAGON, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "540",
        movelvls = {
            {},
            {},
            {},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 42, 50, 58, 66, 74},
            {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 42, 50, 58, 66, 74}
        },
        weight = 105.5
    },
    {
        name = "Cubchoo",
        type = {PokemonData.POKEMON_TYPES.ICE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "37",
        bst = "305",
        movelvls = {
            {},
            {},
            {},
            {5, 9, 13, 17, 21, 25, 29, 33, 36, 41, 45, 49, 53, 57},
            {5, 9, 13, 17, 21, 25, 29, 33, 36, 41, 45, 49, 53, 57}
        },
        weight = 8.5
    },
    {
        name = "Beartic",
        type = {PokemonData.POKEMON_TYPES.ICE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "485",
        movelvls = {
            {},
            {},
            {},
            {5, 9, 13, 17, 21, 25, 29, 33, 36, 37, 41, 45, 53, 59, 66},
            {5, 9, 13, 17, 21, 25, 29, 33, 36, 37, 41, 45, 53, 59, 66}
        },
        weight = 260.0
    },
    {
        name = "Cryogonal",
        type = {PokemonData.POKEMON_TYPES.ICE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "485",
        movelvls = {
            {},
            {},
            {},
            {5, 9, 13, 17, 21, 21, 25, 29, 33, 37, 37, 41, 45, 49, 53, 57, 61},
            {5, 9, 13, 17, 21, 21, 25, 29, 33, 37, 37, 41, 45, 49, 53, 57, 61}
        },
        weight = 148.0
    },
    {
        name = "Shelmet",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.SHELMET,
        bst = "305",
        movelvls = {
            {},
            {},
            {},
            {4, 8, 13, 16, 20, 25, 28, 32, 37, 40, 44, 49, 52, 56},
            {4, 8, 13, 16, 20, 25, 28, 32, 37, 40, 44, 49, 52, 56}
        },
        weight = 7.7
    },
    {
        name = "Accelgor",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "495",
        movelvls = {
            {},
            {},
            {},
            {4, 8, 13, 16, 20, 25, 28, 32, 37, 40, 44, 49, 52, 56},
            {4, 8, 13, 16, 20, 25, 28, 32, 37, 40, 44, 49, 52, 56}
        },
        weight = 25.3
    },
    {
        name = "Stunfisk",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.ELECTRIC},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "471",
        movelvls = {
            {},
            {},
            {},
            {5, 9, 13, 17, 21, 25, 30, 35, 40, 45, 50, 55, 61},
            {5, 9, 13, 17, 21, 25, 30, 35, 40, 45, 50, 55, 61}
        },
        weight = 11.0
    },
    {
        name = "Mienfoo",
        type = {PokemonData.POKEMON_TYPES.FIGHTING, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = "50",
        bst = "350",
        movelvls = {
            {},
            {},
            {},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61}
        },
        weight = 20.0
    },
    {
        name = "Mienshao",
        type = {PokemonData.POKEMON_TYPES.FIGHTING, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "510",
        movelvls = {
            {},
            {},
            {},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 56, 63, 70},
            {5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 56, 63, 70}
        },
        weight = 35.5
    },
    {
        name = "Druddigon",
        type = {PokemonData.POKEMON_TYPES.DRAGON, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "485",
        movelvls = {
            {},
            {},
            {},
            {5, 9, 13, 18, 21, 25, 27, 31, 35, 40, 45, 49, 55, 62},
            {5, 9, 13, 18, 21, 25, 27, 31, 35, 40, 45, 49, 55, 62}
        },
        weight = 139.0
    },
    {
        name = "Golett",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.GHOST},
        evolution = "43",
        bst = "303",
        movelvls = {
            {},
            {},
            {},
            {5, 9, 13, 17, 21, 25, 30, 35, 40, 45, 50, 55},
            {5, 9, 13, 17, 21, 25, 30, 35, 40, 45, 50, 55}
        },
        weight = 92.0
    },
    {
        name = "Golurk",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.GHOST},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "483",
        movelvls = {
            {},
            {},
            {},
            {5, 9, 13, 17, 21, 25, 30, 35, 40, 43, 50, 60, 70},
            {5, 9, 13, 17, 21, 25, 30, 35, 40, 43, 50, 60, 70}
        },
        weight = 330.0
    },
    {
        name = "Pawniard",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.STEEL},
        evolution = "52",
        bst = "340",
        movelvls = {
            {},
            {},
            {},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49, 54, 57, 62},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49, 54, 57, 62}
        },
        weight = 10.2
    },
    {
        name = "Bisharp",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.STEEL},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "490",
        movelvls = {
            {},
            {},
            {},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49, 57, 63, 71},
            {6, 9, 14, 17, 22, 25, 30, 33, 38, 41, 46, 49, 57, 63, 71}
        },
        weight = 70.0
    },
    {
        name = "Bouffalant",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "490",
        movelvls = {
            {},
            {},
            {},
            {6, 11, 16, 21, 26, 31, 36, 41, 46, 51, 56, 61},
            {6, 11, 16, 21, 26, 31, 36, 41, 46, 51, 56, 61}
        },
        weight = 94.6
    },
    {
        name = "Rufflet",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = "54",
        bst = "350",
        movelvls = {
            {},
            {},
            {},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50, 55, 59, 64},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50, 55, 59, 64}
        },
        weight = 10.5
    },
    {
        name = "Braviary",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "510",
        movelvls = {
            {},
            {},
            {},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50, 51, 57, 63, 70},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50, 51, 57, 63, 70}
        },
        weight = 41.0
    },
    {
        name = "Vullaby",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.FLYING},
        evolution = "54",
        bst = "370",
        movelvls = {
            {},
            {},
            {},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50, 55, 59, 64},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50, 55, 59, 64}
        },
        weight = 9.0
    },
    {
        name = "Mandibuzz",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "510",
        movelvls = {
            {},
            {},
            {},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50, 51, 57, 63, 70},
            {5, 10, 14, 19, 23, 28, 32, 37, 41, 46, 50, 51, 57, 63, 70}
        },
        weight = 39.5
    },
    {
        name = "Heatmor",
        type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "484",
        movelvls = {
            {},
            {},
            {},
            {6, 11, 16, 21, 26, 31, 36, 41, 46, 51, 56, 56, 56, 61},
            {6, 11, 16, 21, 26, 31, 36, 41, 46, 51, 56, 56, 56, 61}
        },
        weight = 58.0
    },
    {
        name = "Durant",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.STEEL},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "484",
        movelvls = {
            {},
            {},
            {},
            {6, 11, 16, 21, 26, 31, 36, 41, 46, 51, 56, 61, 66},
            {6, 11, 16, 21, 26, 31, 36, 41, 46, 51, 56, 61, 66}
        },
        weight = 33.0
    },
    {
        name = "Deino",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.DRAGON},
        evolution = "50",
        bst = "300",
        movelvls = {
            {},
            {},
            {},
            {4, 9, 12, 17, 20, 25, 28, 32, 38, 42, 48, 52, 58, 62},
            {4, 9, 12, 17, 20, 25, 28, 32, 38, 42, 48, 52, 58, 62}
        },
        weight = 17.3
    },
    {
        name = "Zweilous",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.DRAGON},
        evolution = "64",
        bst = "420",
        movelvls = {
            {},
            {},
            {},
            {4, 9, 12, 17, 20, 25, 28, 32, 38, 42, 48, 55, 64, 71},
            {4, 9, 12, 17, 20, 25, 28, 32, 38, 42, 48, 55, 64, 71}
        },
        weight = 50.0
    },
    {
        name = "Hydreigon",
        type = {PokemonData.POKEMON_TYPES.DARK, PokemonData.POKEMON_TYPES.DRAGON},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "600",
        movelvls = {
            {},
            {},
            {},
            {4, 9, 12, 17, 20, 25, 28, 32, 38, 42, 48, 55, 68, 79},
            {4, 9, 12, 17, 20, 25, 28, 32, 38, 42, 48, 55, 68, 79}
        },
        weight = 160.0
    },
    {
        name = "Larvesta",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.FIRE},
        evolution = "59",
        bst = "360",
        movelvls = {
            {},
            {},
            {},
            {10, 20, 30, 40, 50, 60, 70, 80, 90, 100},
            {10, 20, 30, 40, 50, 60, 70, 80, 90, 100}
        },
        weight = 28.8
    },
    {
        name = "Volcarona",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.FIRE},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "550",
        movelvls = {
            {},
            {},
            {},
            {10, 20, 30, 40, 50, 59, 60, 70, 80, 90, 100},
            {10, 20, 30, 40, 50, 59, 60, 70, 80, 90, 100}
        },
        weight = 46.0
    },
    {
        name = "Cobalion",
        type = {PokemonData.POKEMON_TYPES.STEEL, PokemonData.POKEMON_TYPES.FIGHTING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "580",
        movelvls = {
            {},
            {},
            {},
            {7, 13, 19, 25, 31, 37, 42, 49, 55, 61, 67, 73},
            {7, 13, 19, 25, 31, 37, 42, 49, 55, 61, 67, 73}
        },
        weight = 250.0
    },
    {
        name = "Terrakion",
        type = {PokemonData.POKEMON_TYPES.ROCK, PokemonData.POKEMON_TYPES.FIGHTING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "580",
        movelvls = {
            {},
            {},
            {},
            {7, 13, 19, 25, 31, 37, 42, 49, 55, 61, 67, 73},
            {7, 13, 19, 25, 31, 37, 42, 49, 55, 61, 67, 73}
        },
        weight = 260.0
    },
    {
        name = "Virizion",
        type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.FIGHTING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "580",
        movelvls = {
            {},
            {},
            {},
            {7, 13, 19, 25, 31, 37, 42, 49, 55, 61, 67, 73},
            {7, 13, 19, 25, 31, 37, 42, 49, 55, 61, 67, 73}
        },
        weight = 200.0
    },
    {
        name = "Tornadus",
        type = {PokemonData.POKEMON_TYPES.FLYING, PokemonData.POKEMON_TYPES.EMPTY},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "580",
        movelvls = {
            {},
            {},
            {},
            {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73, 79, 85},
            {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73, 79, 85}
        },
        weight = 63.0
    },
    {
        name = "Thundurus",
        type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "580",
        movelvls = {
            {},
            {},
            {},
            {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73, 79, 85},
            {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73, 79, 85}
        },
        weight = 61.0
    },
    {
        name = "Reshiram",
        type = {PokemonData.POKEMON_TYPES.DRAGON, PokemonData.POKEMON_TYPES.FIRE},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "680",
        movelvls = {
            {},
            {},
            {},
            {8, 15, 22, 29, 36, 43, 50, 54, 64, 71, 78, 85, 92, 100},
            {8, 15, 22, 29, 36, 43, 50, 54, 64, 71, 78, 85, 92, 100}
        },
        weight = 330.0
    },
    {
        name = "Zekrom",
        type = {PokemonData.POKEMON_TYPES.DRAGON, PokemonData.POKEMON_TYPES.ELECTRIC},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "680",
        movelvls = {
            {},
            {},
            {},
            {8, 15, 22, 29, 36, 43, 50, 54, 64, 71, 78, 85, 92, 100},
            {8, 15, 22, 29, 36, 43, 50, 54, 64, 71, 78, 85, 92, 100}
        },
        weight = 345.0
    },
    {
        name = "Landorus",
        type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.FLYING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "600",
        movelvls = {
            {},
            {},
            {},
            {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73, 79, 85},
            {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73, 79, 85}
        },
        weight = 68.0
    },
    {
        name = "Kyurem",
        type = {PokemonData.POKEMON_TYPES.DRAGON, PokemonData.POKEMON_TYPES.ICE},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "660",
        movelvls = {
            {},
            {},
            {},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85, 92},
            {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85, 92}
        },
        weight = 325.0
    },
    {
        name = "Keldeo",
        type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.FIGHTING},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "580",
        movelvls = {
            {},
            {},
            {},
            {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73},
            {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73}
        },
        weight = 48.5
    },
    {
        name = "Meloetta A",
        type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.PSYCHIC},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "600",
        movelvls = {
            {},
            {},
            {},
            {6, 11, 16, 21, 26, 31, 36, 43, 50, 57, 64, 71, 78, 85},
            {6, 11, 16, 21, 26, 31, 36, 43, 50, 57, 64, 71, 78, 85}
        },
        weight = 6.5
    },
    {
        name = "Genesect",
        type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.STEEL},
        evolution = PokemonData.EVOLUTION_TYPES.NONE,
        bst = "600",
        movelvls = {
            {},
            {},
            {},
            {7, 11, 18, 22, 29, 33, 40, 44, 51, 55, 62, 66, 73, 77},
            {7, 11, 18, 22, 29, 33, 40, 44, 51, 55, 62, 66, 73, 77}
        },
        weight = 82.5
    }
}

PokemonData.TOTAL_POKEMON = #PokemonData.POKEMON

PokemonData.ALTERNATE_FORMS = {
    ["Deoxys"] = {
        cosmetic = false,
        index = 0,
        forms = {
            {
                name = "Deoxys A",
                type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "600",
                movelvls = {
                    {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97},
                    {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97},
                    {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97},
                    {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97},
                    {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97}
                },
                weight = 60.8
            },
            {
                name = "Deoxys D",
                type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "600",
                movelvls = {
                    {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97},
                    {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97},
                    {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97},
                    {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97},
                    {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97}
                },
                weight = 60.8
            },
            {
                name = "Deoxys S",
                type = {PokemonData.POKEMON_TYPES.PSYCHIC, PokemonData.POKEMON_TYPES.EMPTY},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "600",
                movelvls = {
                    {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97},
                    {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97},
                    {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97},
                    {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97},
                    {9, 17, 25, 33, 41, 49, 57, 65, 73, 81, 89, 97}
                },
                weight = 60.8
            }
        }
    },
    ["Wormadam P"] = {
        cosmetic = false,
        index = 0,
        forms = {
            {
                name = "Wormadam S",
                type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.GROUND},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "424",
                movelvls = {
                    {10, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47},
                    {10, 15, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47},
                    {10, 15, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47},
                    {10, 15, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47},
                    {10, 15, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47}
                },
                weight = 6.5
            },
            {
                name = "Wormadam T",
                type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.STEEL},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "424",
                movelvls = {
                    {10, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47},
                    {10, 15, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47},
                    {10, 15, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47},
                    {10, 15, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47},
                    {10, 15, 20, 23, 26, 29, 32, 35, 38, 41, 44, 47}
                },
                weight = 6.5
            }
        }
    },
    ["Shaymin L"] = {
        cosmetic = false,
        index = 0,
        forms = {
            {
                name = "Shaymin S",
                type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.FLYING},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "600",
                movelvls = {
                    {10, 19, 28, 37, 46, 55, 64, 73, 82, 91, 100},
                    {10, 19, 28, 37, 46, 55, 64, 73, 82, 91, 100},
                    {10, 19, 28, 37, 46, 55, 64, 73, 82, 91, 100},
                    {10, 19, 28, 37, 46, 55, 64, 73, 82, 91, 100},
                    {10, 19, 28, 37, 46, 55, 64, 73, 82, 91, 100}
                },
                weight = 2.1
            }
        }
    },
    ["Giratina A"] = {
        cosmetic = false,
        index = 0,
        forms = {
            {
                name = "Giratina O",
                type = {PokemonData.POKEMON_TYPES.GHOST, PokemonData.POKEMON_TYPES.DRAGON},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "680",
                movelvls = {
                    {10, 20, 30, 40, 50, 60, 70, 80, 90},
                    {10, 20, 30, 40, 50, 60, 70, 80, 90},
                    {6, 10, 15, 19, 24, 28, 33, 37, 42, 46},
                    {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 50},
                    {6, 10, 15, 19, 24, 28, 33, 37, 42, 46, 50}
                },
                weight = 750.0
            }
        }
    },
    ["Rotom"] = {
        cosmetic = false,
        index = 0,
        forms = {
            {
                name = "Rotom Heat",
                type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.FIRE},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "520",
                movelvls = {
                    {8, 15, 22, 29, 36, 43, 50},
                    {8, 15, 22, 29, 36, 43, 50},
                    {8, 15, 22, 29, 36, 43, 50},
                    {8, 15, 22, 29, 36, 43, 50, 57, 64},
                    {8, 15, 22, 29, 36, 43, 50, 57, 64}
                },
                weight = .3
            },
            {
                name = "Rotom Wash",
                type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.WATER},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "520",
                movelvls = {
                    {8, 15, 22, 29, 36, 43, 50},
                    {8, 15, 22, 29, 36, 43, 50},
                    {8, 15, 22, 29, 36, 43, 50},
                    {8, 15, 22, 29, 36, 43, 50, 57, 64},
                    {8, 15, 22, 29, 36, 43, 50, 57, 64}
                },
                weight = .3
            },
            {
                name = "Rotom Frost",
                type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.ICE},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "520",
                movelvls = {
                    {8, 15, 22, 29, 36, 43, 50},
                    {8, 15, 22, 29, 36, 43, 50},
                    {8, 15, 22, 29, 36, 43, 50},
                    {8, 15, 22, 29, 36, 43, 50, 57, 64},
                    {8, 15, 22, 29, 36, 43, 50, 57, 64}
                },
                weight = .3
            },
            {
                name = "Rotom Fan",
                type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.FLYING},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "520",
                movelvls = {
                    {8, 15, 22, 29, 36, 43, 50},
                    {8, 15, 22, 29, 36, 43, 50},
                    {8, 15, 22, 29, 36, 43, 50},
                    {8, 15, 22, 29, 36, 43, 50, 57, 64},
                    {8, 15, 22, 29, 36, 43, 50, 57, 64}
                },
                weight = .3
            },
            {
                name = "Rotom Mow",
                type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.GRASS},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "520",
                movelvls = {
                    {8, 15, 22, 29, 36, 43, 50},
                    {8, 15, 22, 29, 36, 43, 50},
                    {8, 15, 22, 29, 36, 43, 50},
                    {8, 15, 22, 29, 36, 43, 50, 57, 64},
                    {8, 15, 22, 29, 36, 43, 50, 57, 64}
                },
                weight = .3
            }
        }
    },
    ["Castform"] = {
        cosmetic = false,
        index = 0,
        forms = {
            {
                name = "Castform F",
                type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.EMPTY},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "420",
                movelvls = {
                    {10, 10, 10, 20, 20, 20, 30},
                    {10, 10, 10, 20, 20, 20, 30},
                    {10, 10, 10, 20, 20, 20, 30},
                    {10, 10, 10, 20, 30, 30, 30, 40, 50, 50, 50},
                    {10, 10, 10, 15, 20, 20, 20, 30, 40, 40, 40}
                },
                weight = 0.8
            },
            {
                name = "Castform R",
                type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "420",
                movelvls = {
                    {10, 10, 10, 20, 20, 20, 30},
                    {10, 10, 10, 20, 20, 20, 30},
                    {10, 10, 10, 20, 20, 20, 30},
                    {10, 10, 10, 20, 30, 30, 30, 40, 50, 50, 50},
                    {10, 10, 10, 15, 20, 20, 20, 30, 40, 40, 40}
                },
                weight = 0.8
            },
            {
                name = "Castform S",
                type = {PokemonData.POKEMON_TYPES.ICE, PokemonData.POKEMON_TYPES.EMPTY},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "420",
                movelvls = {
                    {10, 10, 10, 20, 20, 20, 30},
                    {10, 10, 10, 20, 20, 20, 30},
                    {10, 10, 10, 20, 20, 20, 30},
                    {10, 10, 10, 20, 30, 30, 30, 40, 50, 50, 50},
                    {10, 10, 10, 15, 20, 20, 20, 30, 40, 40, 40}
                },
                weight = 0.8
            }
        }
    },
    ["Basculin R"] = {
        shortenedName = "Basculin",
        cosmetic = true,
        startIndex = 0,
        forms = {
            {
                name = "Basculin B",
                type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "460",
                movelvls = {
                    {},
                    {},
                    {},
                    {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 41, 46, 51, 56},
                    {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 41, 46, 51, 56}
                },
                weight = 18.0
            }
        }
    },
    ["Darmanitan"] = {
        cosmetic = false,
        index = 0,
        forms = {
            {
                name = "Darmanitan Z",
                type = {PokemonData.POKEMON_TYPES.FIRE, PokemonData.POKEMON_TYPES.PSYCHIC},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "540",
                movelvls = {
                    {},
                    {},
                    {},
                    {3, 6, 9, 11, 14, 17, 19, 22, 25, 27, 30, 33, 35, 39, 47, 54},
                    {3, 6, 9, 11, 14, 17, 19, 22, 25, 27, 30, 33, 35, 39, 47, 54}
                },
                weight = 92.9
            }
        }
    },
    ["Meloetta A"] = {
        cosmetic = false,
        index = 0,
        forms = {
            {
                name = "Meloetta P",
                type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FIGHTING},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "600",
                movelvls = {
                    {},
                    {},
                    {},
                    {6, 11, 16, 21, 26, 31, 36, 43, 50, 57, 64, 71, 78, 85},
                    {6, 11, 16, 21, 26, 31, 36, 43, 50, 57, 64, 71, 78, 85}
                },
                weight = 6.5
            }
        }
    },
    ["Kyurem"] = {
        cosmetic = false,
        index = 0,
        forms = {
            {
                name = "Kyurem W",
                type = {PokemonData.POKEMON_TYPES.DRAGON, PokemonData.POKEMON_TYPES.ICE},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "700",
                movelvls = {
                    {},
                    {},
                    {},
                    {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85, 92},
                    {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85, 92}
                },
                weight = 325.0
            },
            {
                name = "Kyurem B",
                type = {PokemonData.POKEMON_TYPES.DRAGON, PokemonData.POKEMON_TYPES.ICE},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "700",
                movelvls = {
                    {},
                    {},
                    {},
                    {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85, 92},
                    {8, 15, 22, 29, 36, 43, 50, 57, 64, 71, 78, 85, 92}
                },
                weight = 325.0
            }
        }
    },
    ["Landorus"] = {
        cosmetic = false,
        index = 0,
        forms = {
            {
                name = "Landorus T",
                type = {PokemonData.POKEMON_TYPES.GROUND, PokemonData.POKEMON_TYPES.FLYING},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "600",
                movelvls = {
                    {},
                    {},
                    {},
                    {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73, 79, 85},
                    {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73, 79, 85}
                },
                weight = 68.0
            }
        }
    },
    ["Burmy P"] = {
        shortenedName = "Burmy",
        cosmetic = true,
        index = 0,
        forms = {
            {
                name = "Burmy S",
                type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.EMPTY},
                evolution = "20",
                bst = "224",
                movelvls = {
                    {10, 20},
                    {10, 15, 20},
                    {10, 15, 20},
                    {10, 15, 20},
                    {10, 15, 20}
                },
                weight = 3.4
            },
            {
                name = "Burmy T",
                type = {PokemonData.POKEMON_TYPES.BUG, PokemonData.POKEMON_TYPES.EMPTY},
                evolution = "20",
                bst = "224",
                movelvls = {
                    {10, 20},
                    {10, 15, 20},
                    {10, 15, 20},
                    {10, 15, 20},
                    {10, 15, 20}
                },
                weight = 3.4
            }
        }
    },
    ["Cherrim O"] = {
        shortenedName = "Cherrim",
        cosmetic = true,
        index = 0,
        forms = {
            {
                name = "Cherrim S",
                type = {PokemonData.POKEMON_TYPES.GRASS, PokemonData.POKEMON_TYPES.EMPTY},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "450",
                movelvls = {
                    {10, 10, 10, 20, 20, 20, 30},
                    {10, 10, 10, 20, 20, 20, 30},
                    {10, 10, 10, 20, 20, 20, 30},
                    {10, 10, 10, 20, 30, 30, 30, 40, 50, 50, 50},
                    {10, 10, 10, 15, 20, 20, 20, 30, 40, 40, 40}
                },
                weight = 9.3
            }
        }
    },
    ["Deerling"] = {
        cosmetic = true,
        shortenedName = "Deerling",
        forms = {
            {
                name = "Deerling",
                type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.GRASS},
                evolution = "34",
                bst = "335",
                movelvls = {
                    {},
                    {},
                    {},
                    {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 41, 46, 51},
                    {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 41, 46, 51}
                },
                weight = 19.5
            },
            {
                name = "Deerling",
                type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.GRASS},
                evolution = "34",
                bst = "335",
                movelvls = {
                    {},
                    {},
                    {},
                    {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 41, 46, 51},
                    {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 41, 46, 51}
                },
                weight = 19.5
            },
            {
                name = "Deerling",
                type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.GRASS},
                evolution = "34",
                bst = "335",
                movelvls = {
                    {},
                    {},
                    {},
                    {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 41, 46, 51},
                    {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 41, 46, 51}
                },
                weight = 19.5
            }
        }
    },
    ["Frillish M"] = {
        shortenedName = "Frillish",
        cosmetic = true,
        index = 0,
        forms = {
            {
                name = "Frillish F",
                type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.GHOST},
                evolution = "40",
                bst = "335",
                movelvls = {
                    {},
                    {},
                    {},
                    {5, 9, 13, 17, 22, 27, 32, 37, 43, 49, 55, 61},
                    {5, 9, 13, 17, 22, 27, 32, 37, 43, 49, 55, 61}
                },
                weight = 33.0
            }
        }
    },
    ["Gastrodon W"] = {
        shortenedName = "Gastrodon",
        cosmetic = true,
        index = 0,
        forms = {
            {
                name = "Gastrodon E",
                type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.GROUND},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "475",
                movelvls = {
                    {2, 4, 7, 11, 16, 22, 29, 41, 54},
                    {2, 4, 7, 11, 16, 22, 29, 41, 54},
                    {2, 4, 7, 11, 16, 22, 29, 41, 54},
                    {2, 4, 7, 11, 16, 22, 29, 41, 54},
                    {2, 4, 7, 11, 16, 22, 29, 41, 54}
                },
                weight = 29.9
            }
        }
    },
    ["Jellicent M"] = {
        shortenedName = "Jellicent",
        cosmetic = true,
        index = 0,
        forms = {
            {
                name = "Jellicent F",
                type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.GHOST},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "480",
                movelvls = {
                    {},
                    {},
                    {},
                    {5, 9, 13, 17, 22, 27, 32, 37, 45, 53, 61, 69},
                    {5, 9, 13, 17, 22, 27, 32, 37, 45, 53, 61, 69}
                },
                weight = 135.0
            }
        }
    },
    ["Keldeo"] = {
        shortenedName = "Keldeo",
        cosmetic = true,
        index = 0,
        forms = {
            {
                name = "Keldeo R",
                type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.FIGHTING},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "580",
                movelvls = {
                    {},
                    {},
                    {},
                    {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73},
                    {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73}
                },
                weight = 48.5
            }
        }
    },
    ["Sawsbuck"] = {
        cosmetic = true,
        shortenedName = "Sawsbuck",
        index = 0,
        forms = {
            {
                name = "Sawsbuck",
                type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.GRASS},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "475",
                movelvls = {
                    {},
                    {},
                    {},
                    {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 37, 44, 52, 60},
                    {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 37, 44, 52, 60}
                },
                weight = 92.5
            },
            {
                name = "Sawsbuck",
                type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.GRASS},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "475",
                movelvls = {
                    {},
                    {},
                    {},
                    {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 37, 44, 52, 60},
                    {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 37, 44, 52, 60}
                },
                weight = 92.5
            },
            {
                name = "Sawsbuck",
                type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.GRASS},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "475",
                movelvls = {
                    {},
                    {},
                    {},
                    {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 37, 44, 52, 60},
                    {4, 7, 10, 13, 16, 20, 24, 28, 32, 36, 37, 44, 52, 60}
                },
                weight = 92.5
            }
        }
    },
    ["Shellos W"] = {
        shortenedName = "Shellos",
        cosmetic = true,
        index = 0,
        forms = {
            {
                name = "Shellos E",
                type = {PokemonData.POKEMON_TYPES.WATER, PokemonData.POKEMON_TYPES.EMPTY},
                evolution = "30",
                bst = "325",
                movelvls = {
                    {2, 4, 7, 11, 16, 22, 29, 37, 46},
                    {2, 4, 7, 11, 16, 22, 29, 37, 46},
                    {2, 4, 7, 11, 16, 22, 29, 37, 46},
                    {2, 4, 7, 11, 16, 22, 29, 37, 46},
                    {2, 4, 7, 11, 16, 22, 29, 37, 46}
                },
                weight = 6.3
            }
        }
    },
    ["Thundurus"] = {
        cosmetic = false,
        index = 0,
        forms = {
            {
                name = "Thundurus T",
                type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.FLYING},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "580",
                movelvls = {
                    {},
                    {},
                    {},
                    {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73, 79, 85},
                    {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73, 79, 85}
                },
                weight = 61.0
            }
        }
    },
    ["Tornadus"] = {
        cosmetic = false,
        index = 0,
        forms = {
            {
                name = "Tornadus T",
                type = {PokemonData.POKEMON_TYPES.FLYING, PokemonData.POKEMON_TYPES.EMPTY},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "580",
                movelvls = {
                    {},
                    {},
                    {},
                    {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73, 79, 85},
                    {7, 13, 19, 25, 31, 37, 43, 49, 55, 61, 67, 73, 79, 85}
                },
                weight = 63.0
            }
        }
    },
    ["Unfezant M"] = {
        shortenedName = "Unfezant",
        cosmetic = true,
        index = 0,
        forms = {
            {
                name = "Unfezant F",
                type = {PokemonData.POKEMON_TYPES.NORMAL, PokemonData.POKEMON_TYPES.FLYING},
                evolution = PokemonData.EVOLUTION_TYPES.NONE,
                bst = "478",
                movelvls = {
                    {},
                    {},
                    {},
                    {4, 8, 11, 15, 18, 23, 27, 33, 38, 44, 49, 55, 60, 66},
                    {4, 8, 11, 15, 18, 23, 27, 33, 38, 44, 49, 55, 60, 66}
                },
                weight = 29.0
            }
        }
    }
}

ItemData = {}

ItemData.ITEMS = {}

ItemData.HEALING_TYPE = MiscUtils.readOnly({CONSTANT = 0, PERCENTAGE = 1})
ItemData.NATURE_SPECIFIC_BERRIES = {
    ["Figy Berry"] = {
        Modest = true,
        Timid = true,
        Calm = true,
        Bold = true
    },
    ["Iapapa Berry"] = {
        Lonely = true,
        Mild = true,
        Gentle = true,
        Hasty = true
    },
    ["Wiki Berry"] = {
        Adamant = true,
        Jolly = true,
        Careful = true,
        Impish = true
    },
    ["Aguav Berry"] = {
        Naughty = true,
        Rash = true,
        Naive = true,
        Lax = true
    },
    ["Mago Berry"] = {
        Brave = true,
        Quiet = true,
        Sassy = true,
        Relaxed = true
    }
}
ItemData.STATUS_ID_SORT_ORDER = {23, 591, 27, 36, 42, 157, 54, 19, 152, 156, 153, 20, 219, 149, 22, 18, 151, 21, 150}
ItemData.STATUS_ITEMS =
    MiscUtils.readOnly(
    {
        [23] = {
            name = "Full Restore",
            status = MiscData.STATUS_TYPE.ALL
        },
        [591] = {
            name = "Casteliacone",
            status = MiscData.STATUS_TYPE.ALL
        },
        [27] = {
            name = "Full Heal",
            status = MiscData.STATUS_TYPE.ALL
        },
        [36] = {
            name = "Heal Powder",
            status = MiscData.STATUS_TYPE.ALL
        },
        [42] = {
            name = "Lava Cookie",
            status = MiscData.STATUS_TYPE.ALL
        },
        [157] = {
            name = "Lum Berry",
            status = MiscData.STATUS_TYPE.ALL
        },
        [54] = {
            name = "Old Gateau",
            status = MiscData.STATUS_TYPE.ALL
        },
        [19] = {
            name = "Burn Heal",
            status = MiscData.STATUS_TYPE.BURN
        },
        [152] = {
            name = "Rawst Berry",
            status = MiscData.STATUS_TYPE.BURN
        },
        [156] = {
            name = "Persim Berry",
            status = MiscData.STATUS_TYPE.CONFUSE
        },
        [153] = {
            name = "Aspear Berry",
            status = MiscData.STATUS_TYPE.FREEZE
        },
        [20] = {
            name = "Ice Heal",
            status = MiscData.STATUS_TYPE.FREEZE
        },
        [219] = {
            name = "Mental Herb",
            status = MiscData.STATUS_TYPE.INFATUATION
        },
        [149] = {
            name = "Cheri Berry",
            status = MiscData.STATUS_TYPE.PARALYZE
        },
        [22] = {
            name = "Paralyze Heal",
            status = MiscData.STATUS_TYPE.PARALYZE
        },
        [18] = {
            name = "Antidote",
            status = MiscData.STATUS_TYPE.POISON
        },
        [151] = {
            name = "Pecha Berry",
            status = MiscData.STATUS_TYPE.POISON
        },
        [21] = {
            name = "Awakening",
            status = MiscData.STATUS_TYPE.SLEEP
        },
        [150] = {
            name = "Chesto Berry",
            status = MiscData.STATUS_TYPE.SLEEP
        }
    }
)
ItemData.HEALING_ID_SORT_ORDER = {
    23,
    24,
    158,
    162,
    208,
    159,
    163,
    161,
    160,
    35,
    25,
    33,
    32,
    31,
    26,
    34,
    30,
    43,
    17,
    504,
    134,
    155
}
ItemData.HEALING_ITEMS =
    MiscUtils.readOnly(
    {
        [23] = {
            name = "Full Restore",
            amount = 100,
            type = ItemData.HEALING_TYPE.PERCENTAGE
        },
        [24] = {
            name = "Max Potion",
            amount = 100,
            type = ItemData.HEALING_TYPE.PERCENTAGE
        },
        [158] = {
            name = "Sitrus Berry",
            amount = 25,
            type = ItemData.HEALING_TYPE.PERCENTAGE
        },
        [162] = {
            name = "Aguav Berry",
            amount = 12.5,
            type = ItemData.HEALING_TYPE.PERCENTAGE
        },
        [208] = {
            name = "Enigma Berry",
            amount = 12.5,
            type = ItemData.HEALING_TYPE.PERCENTAGE
        },
        [159] = {
            name = "Figy Berry",
            amount = 12.5,
            type = ItemData.HEALING_TYPE.PERCENTAGE
        },
        [163] = {
            name = "Iapapa Berry",
            amount = 12.5,
            type = ItemData.HEALING_TYPE.PERCENTAGE
        },
        [161] = {
            name = "Mago Berry",
            amount = 12.5,
            type = ItemData.HEALING_TYPE.PERCENTAGE
        },
        [160] = {
            name = "Wiki Berry",
            amount = 12.5,
            type = ItemData.HEALING_TYPE.PERCENTAGE
        },
        [35] = {
            name = "Energy Root",
            amount = 200,
            type = ItemData.HEALING_TYPE.CONSTANT
        },
        [25] = {
            name = "Hyper Potion",
            amount = 200,
            type = ItemData.HEALING_TYPE.CONSTANT
        },
        [33] = {
            name = "Moomoo Milk",
            amount = 100,
            type = ItemData.HEALING_TYPE.CONSTANT
        },
        [32] = {
            name = "Lemonade",
            amount = 80,
            type = ItemData.HEALING_TYPE.CONSTANT
        },
        [31] = {
            name = "Soda Pop",
            amount = 60,
            type = ItemData.HEALING_TYPE.CONSTANT
        },
        [26] = {
            name = "Super Potion",
            amount = 50,
            type = ItemData.HEALING_TYPE.CONSTANT
        },
        [34] = {
            name = "EnergyPowder",
            amount = 50,
            type = ItemData.HEALING_TYPE.CONSTANT
        },
        [30] = {
            name = "Fresh Water",
            amount = 50,
            type = ItemData.HEALING_TYPE.CONSTANT
        },
        [43] = {
            name = "Berry Juice",
            amount = 20,
            type = ItemData.HEALING_TYPE.CONSTANT
        },
        [17] = {
            name = "Potion",
            amount = 20,
            type = ItemData.HEALING_TYPE.CONSTANT
        },
        [504] = {
            name = "RageCandyBar",
            amount = 20,
            type = ItemData.HEALING_TYPE.CONSTANT
        },
        [134] = {
            name = "Sweet Heart",
            amount = 20,
            type = ItemData.HEALING_TYPE.CONSTANT
        },
        [155] = {
            name = "Oran Berry",
            amount = 10,
            type = ItemData.HEALING_TYPE.CONSTANT
        }
    }
)

ItemData.GEN_4_ITEMS = {
    [1] = {
        name = "Master Ball",
        description = "Catches a wild Pok" .. Chars.accentedE .. "mon every time."
    },
    [2] = {
        name = "Ultra Ball",
        description = "Tries to catch a wild Pokemon. Success rate is 2x."
    },
    [3] = {
        name = "Great Ball",
        description = "Tries to catch a wild Pokemon. Success rate is 1.5x."
    },
    [4] = {
        name = "Poke Ball",
        description = "Tries to catch a wild Pokemon."
    },
    [5] = {
        name = "Safari Ball",
        description = "Tries to catch a wild Pok" ..
            Chars.accentedE .. "mon in the Great Marsh or Safari Zone. Success rate is 1.5x."
    },
    [6] = {
        name = "Net Ball",
        description = "Tries to catch a wild Pokemon. Success rate is 3x for water and bug Pokemon."
    },
    [7] = {
        name = "Dive Ball",
        description = "Tries to catch a wild Pokemon. Success rate is 3.5x when underwater, fishing, or surfing."
    },
    [8] = {
        name = "Nest Ball",
        description = "Tries to catch a wild Pokemon. Success rate is 3.9x for level 1 Pokemon, and drops steadily to 1x at level 30."
    },
    [9] = {
        name = "Repeat Ball",
        description = "Tries to catch a wild Pokemon. Success rate is 3x for previously-caught Pokemon."
    },
    [10] = {
        name = "Timer Ball",
        description = "Tries to catch a wild Pokemon. Success rate increases by 0.1x (Gen V: 0.3x) every turn, to a max of 4x."
    },
    [11] = {
        name = "Luxury Ball",
        description = "Tries to catch a wild Pokemon. Caught Pok" .. Chars.accentedE .. "mon start with 200 happiness."
    },
    [12] = {
        name = "Premier Ball",
        description = "Tries to catch a wild Pokemon."
    },
    [13] = {
        name = "Dusk Ball",
        description = "Tries to catch a wild Pokemon. Success rate is 3.5x at night and in caves."
    },
    [14] = {
        name = "Heal Ball",
        description = "Tries to catch a wild Pokemon. Caught Pok" .. Chars.accentedE .. "mon are immediately healed."
    },
    [15] = {
        name = "Quick Ball",
        description = "Tries to catch a wild Pokemon. Success rate is 4x (Gen V: 5x), but only on the first turn."
    },
    [16] = {
        name = "Cherish Ball",
        description = "Tries to catch a wild Pokemon."
    },
    [17] = {
        name = "Potion",
        description = "Restores 20 HP."
    },
    [18] = {
        name = "Antidote",
        description = "Cures poison."
    },
    [19] = {
        name = "Burn Heal",
        description = "Cures a burn."
    },
    [20] = {
        name = "Ice Heal",
        description = "Cures freezing."
    },
    [21] = {
        name = "Awakening",
        description = "Cures sleep."
    },
    [22] = {
        name = "Paralyze Heal",
        description = "Cures paralysis."
    },
    [23] = {
        name = "Full Restore",
        description = "Restores HP to full and cures any status ailment and confusion."
    },
    [24] = {
        name = "Max Potion",
        description = "Restores HP to full."
    },
    [25] = {
        name = "Hyper Potion",
        description = "Restores 200 HP."
    },
    [26] = {
        name = "Super Potion",
        description = "Restores 50 HP."
    },
    [27] = {
        name = "Full Heal",
        description = "Cures any status ailment and confusion."
    },
    [28] = {
        name = "Revive",
        description = "Revives with half HP."
    },
    [29] = {
        name = "Max Revive",
        description = "Revives with full HP."
    },
    [30] = {
        name = "Fresh Water",
        description = "Restores 50 HP."
    },
    [31] = {
        name = "Soda Pop",
        description = "Restores 60 HP."
    },
    [32] = {
        name = "Lemonade",
        description = "Restores 80 HP."
    },
    [33] = {
        name = "Moomoo Milk",
        description = "Restores 100 HP."
    },
    [34] = {
        name = "Energy Powder",
        description = "Restores 50 HP, but lowers happiness."
    },
    [35] = {
        name = "Energy Root",
        description = "Restores 200 HP, but lowers happiness."
    },
    [36] = {
        name = "Heal Powder",
        description = "Cures any status ailment, but lowers happiness."
    },
    [37] = {
        name = "Revival Herb",
        description = "Revives with full HP, but lowers happiness."
    },
    [38] = {
        name = "Ether",
        description = "Restores 10 PP for one move."
    },
    [39] = {
        name = "Max Ether",
        description = "Restores PP to full for one move."
    },
    [40] = {
        name = "Elixir",
        description = "Restores 10 PP for each move."
    },
    [41] = {
        name = "Max Elixir",
        description = "Restores PP to full for each move."
    },
    [42] = {
        name = "Lava Cookie",
        description = "Cures any status ailment and confusion."
    },
    [43] = {
        name = "Berry Juice",
        description = "Restores 20 HP."
    },
    [44] = {
        name = "Sacred Ash",
        description = "Revives all fainted Pok" .. Chars.accentedE .. "mon with full HP."
    },
    [45] = {
        name = "Hp Up",
        description = "Raises HP effort and happiness."
    },
    [46] = {
        name = "Protein",
        description = "Raises Attack effort and happiness."
    },
    [47] = {
        name = "Iron",
        description = "Raises Defense effort and happiness."
    },
    [48] = {
        name = "Carbos",
        description = "Raises Speed effort and happiness."
    },
    [49] = {
        name = "Calcium",
        description = "Raises Special Attack effort and happiness."
    },
    [50] = {
        name = "Rare Candy",
        description = "Causes a level-up and raises happiness."
    },
    [51] = {
        name = "PP Up",
        description = "Raises a move's max PP by 20%."
    },
    [52] = {
        name = "Zinc",
        description = "Raises Special Defense and happiness."
    },
    [53] = {
        name = "PP Max",
        description = "Raises a move's max PP by 60%."
    },
    [54] = {
        name = "Old Gateau",
        description = "Cures any status ailment and confusion."
    },
    [55] = {
        name = "Guard Spec",
        description = "Prevents stat changes in battle for five turns in battle. Raises happiness."
    },
    [56] = {
        name = "Dire Hit",
        description = "Increases the chance of a critical hit in battle. Raises happiness."
    },
    [57] = {
        name = "X Attack",
        description = "Raises Attack by one stage in battle. Raises happiness."
    },
    [58] = {
        name = "X Defense",
        description = "Raises Defense by one stage in battle. Raises happiness."
    },
    [59] = {
        name = "X Speed",
        description = "Raises Speed by one stage in battle. Raises happiness."
    },
    [60] = {
        name = "X Accuracy",
        description = "Raises accuracy by one stage in battle. Raises happiness."
    },
    [61] = {
        name = "X Sp-atk",
        description = "Raises Special Attack by one stage in battle. Raises happiness."
    },
    [62] = {
        name = "X Sp-def",
        description = "Raises Special Defense by one stage in battle. Raises happiness."
    },
    [63] = {
        name = "Poke Doll",
        description = "Ends a wild battle."
    },
    [64] = {
        name = "Fluffy Tail",
        description = "Ends a wild battle."
    },
    [65] = {
        name = "Blue Flute",
        description = "Cures sleep."
    },
    [66] = {
        name = "Yellow Flute",
        description = "Cures confusion."
    },
    [67] = {
        name = "Red Flute",
        description = "Cures attraction."
    },
    [68] = {
        name = "Black Flute",
        description = "Halves the wild Pok" .. Chars.accentedE .. "mon encounter rate."
    },
    [69] = {
        name = "White Flute",
        description = "Doubles the wild Pok" .. Chars.accentedE .. "mon encounter rate."
    },
    [70] = {
        name = "Shoal Salt",
        description = "No effect. "
    },
    [71] = {
        name = "Shoal Shell",
        description = "No effect. "
    },
    [72] = {
        name = "Red Shard",
        description = "No effect. Can be traded for items or moves."
    },
    [73] = {
        name = "Blue Shard",
        description = "No effect. Can be traded for items or moves."
    },
    [74] = {
        name = "Yellow Shard",
        description = "No effect. Can be traded for items or moves."
    },
    [75] = {
        name = "Green Shard",
        description = "No effect. Can be traded for items or moves."
    },
    [76] = {
        name = "Super Repel",
        description = "For 200 steps, prevents wild encounters of level lower than your party's lead Pokemon."
    },
    [77] = {
        name = "Max Repel",
        description = "For 250 steps, prevents wild encounters of level lower than your party's lead Pokemon."
    },
    [78] = {
        name = "Escape Rope",
        description = "Transports user to the outside entrance of a cave."
    },
    [79] = {
        name = "Repel",
        description = "For 100 steps, prevents wild encounters of level lower than your party's lead Pokemon."
    },
    [80] = {
        name = "Sun Stone",
        description = "Evolves a Cottonee into Whimsicott, a Gloom into Bellossom, a Petilil into Lilligant, or a Sunkern into Sunflora."
    },
    [81] = {
        name = "Moon Stone",
        description = "Evolves a Clefairy into Clefable, a Jigglypuff into Wigglytuff, a Munna into Musharna, a Nidorina into Nidoqueen, a Nidorino into Nidoking, or a Skitty into Delcatty."
    },
    [82] = {
        name = "Fire Stone",
        description = "Evolves an Eevee into Flareon, a Growlithe into Arcanine, a Pansear into Simisear, or a Vulpix into Ninetales."
    },
    [83] = {
        name = "Thunder Stone",
        description = "Evolves an Eelektrik into Eelektross, an Eevee into Jolteon, or a Pikachu into Raichu."
    },
    [84] = {
        name = "Water Stone",
        description = "Evolves an Eevee into Vaporeon, a Lombre into Ludicolo, a Panpour into Simipour, a Poliwhirl into Poliwrath, a Shellder into Cloyster, or a Staryu into Starmie."
    },
    [85] = {
        name = "Leaf Stone",
        description = "Evolves an Exeggcute into Exeggutor, a Gloom into Vileplume, a Nuzleaf into Shiftry, a Pansage into Simisage, or a Weepinbell into Victreebel."
    },
    [86] = {
        name = "Tiny Mushroom",
        description = "Fire Red and Leaf Green: Trade two for prior Level-up moves. Sell for 250 Pokedollars, or to Hungry Maid for 500 Pokedollars."
    },
    [87] = {
        name = "Big Mushroom",
        description = "Fire Red and Leaf Green: Trade for prior Level-up moves. Sell for 2500 Pokedollars, or to Hungry Maid for 5000 Pokedollars."
    },
    [88] = {
        name = "Pearl",
        description = "Sell for 700 Pokedollars, or to Ore Collector for 1400 Pokedollars."
    },
    [89] = {
        name = "Big Pearl",
        description = "Sell for 3750 Pokedollars, or to Ore Collector for 7500 Pokedollars."
    },
    [90] = {
        name = "Stardust",
        description = "Sell for 1000 Pokedollars, or to Ore Collector for 2000 Pokedollars."
    },
    [91] = {
        name = "Star Piece",
        description = "Platinum: Trade for one of each color Shard. Black and White: Trade for PP Up. Sell for 4900 Pokedollars, or to Ore Collector for 9800 Pokedollars."
    },
    [92] = {
        name = "Nugget",
        description = "Sell for 5000 Pokedollars, or to Ore Collector for 10000 Pokedollars."
    },
    [93] = {
        name = "Heart Scale",
        description = "No effect. Can be traded for prior Level-up moves."
    },
    [94] = {
        name = "Honey",
        description = "Used to attract wild Pok" .. Chars.accentedE .. "mon."
    },
    [95] = {
        name = "Growth Mulch",
        description = "Growing time of berries is reduced, but the soil dries out faster."
    },
    [96] = {
        name = "Damp Mulch",
        description = "Growing time of berries is increased, but the soil dries out slower."
    },
    [97] = {
        name = "Stable Mulch",
        description = "Berries stay on the plant for longer than their usual time."
    },
    [98] = {
        name = "Gooey Mulch",
        description = "Berries regrow from dead plants an increased number of times."
    },
    [99] = {
        name = "Root Fossil",
        description = "Can be revived into a Lileep."
    },
    [100] = {
        name = "Claw Fossil",
        description = "Can be revived into an Anorith."
    },
    [101] = {
        name = "Helix Fossil",
        description = "Can be revived into an Omanyte."
    },
    [102] = {
        name = "Dome Fossil",
        description = "Can be revived into a Kabuto."
    },
    [103] = {
        name = "Old Amber",
        description = "Can be revived into an Aerodactyl."
    },
    [104] = {
        name = "Armor Fossil",
        description = "Can be revived into a Shieldon."
    },
    [105] = {
        name = "Skull Fossil",
        description = "Can be revived into a Cranidos."
    },
    [106] = {
        name = "Rare Bone",
        description = "Sell for 5000 Pokedollars, or to Bone Man for 10000 Pokedollars."
    },
    [107] = {
        name = "Shiny Stone",
        description = "Evolves a Minccino into Cinccino, a Roselia into Roserade, or a Togetic into Togekiss."
    },
    [108] = {
        name = "Dusk Stone",
        description = "Evolves a Lampent into Chandelure, a Misdreavus into Mismagius, or a Murkrow into Honchkrow."
    },
    [109] = {
        name = "Dawn Stone",
        description = "Evolves a male Kirlia into Gallade or a female Snorunt into Froslass."
    },
    [110] = {
        name = "Oval Stone",
        description = "Level-up during Day on a Happiny: Holder evolves into Chansey."
    },
    [111] = {
        name = "Odd Keystone",
        description = "Use on the tower on Route 209 to encounter Spiritomb if you have at least 32 Underground greetings."
    },
    [135] = {
        name = "Adamant Orb",
        description = "Boosts the damage from Dialga's Dragon-type and Steel-type moves by 20%."
    },
    [136] = {
        name = "Lustrous Orb",
        description = "Boosts the damage from Palkia's Dragon-type and Water-type moves by 20%."
    },
    [137] = {
        name = "Grass Mail",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [138] = {
        name = "Flame Mail",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [139] = {
        name = "Bubble Mail",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [140] = {
        name = "Bloom Mail",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [141] = {
        name = "Tunnel Mail",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [142] = {
        name = "Steel Mail",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [143] = {
        name = "Heart Mail",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [144] = {
        name = "Snow Mail",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [145] = {
        name = "Space Mail",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [146] = {
        name = "Air Mail",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [147] = {
        name = "Mosaic Mail",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [148] = {
        name = "Brick Mail",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [149] = {
        name = "Cheri Berry",
        description = "Consumed when paralyzed to cure paralysis."
    },
    [150] = {
        name = "Chesto Berry",
        description = "Consumed when asleep to cure sleep."
    },
    [151] = {
        name = "Pecha Berry",
        description = "Consumed when poisoned to cure poison."
    },
    [152] = {
        name = "Rawst Berry",
        description = "Consumed when burned to cure a burn."
    },
    [153] = {
        name = "Aspear Berry",
        description = "Consumed when frozen to cure frozen."
    },
    [154] = {
        name = "Leppa Berry",
        description = "Consumed when a move runs out of PP to restore its PP by 10."
    },
    [155] = {
        name = "Oran Berry",
        description = "Consumed at 1/2 max HP to recover 10 HP."
    },
    [156] = {
        name = "Persim Berry",
        description = "Consumed when confused to cure confusion."
    },
    [157] = {
        name = "Lum Berry",
        description = "Consumed to cure any status condition or confusion."
    },
    [158] = {
        name = "Sitrus Berry",
        description = "Consumed at 1/2 max HP to recover 1/4 max HP."
    },
    [159] = {
        name = "Figy Berry",
        description = "Consumed at 1/2 max HP to restore 1/8 max HP. Confuses Pok" ..
            Chars.accentedE .. "mon that dislike spicy flavor."
    },
    [160] = {
        name = "Wiki Berry",
        description = "Consumed at 1/2 max HP to restore 1/8 max HP. Confuses Pok" ..
            Chars.accentedE .. "mon that dislike dry flavor."
    },
    [161] = {
        name = "Mago Berry",
        description = "Consumed at 1/2 max HP to restore 1/8 max HP. Confuses Pok" ..
            Chars.accentedE .. "mon that dislike sweet flavor."
    },
    [162] = {
        name = "Aguav Berry",
        description = "Consumed at 1/2 max HP to restore 1/8 max HP. Confuses Pok" ..
            Chars.accentedE .. "mon that dislike bitter flavor."
    },
    [163] = {
        name = "Iapapa Berry",
        description = "Consumed at 1/2 max HP to restore 1/8 max HP. Confuses Pok" ..
            Chars.accentedE .. "mon that dislike sour flavor."
    },
    [164] = {
        name = "Razz Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [165] = {
        name = "Bluk Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [166] = {
        name = "Nanab Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [167] = {
        name = "Wepear Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [168] = {
        name = "Pinap Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [169] = {
        name = "Pomeg Berry",
        description = "Drops HP Effort Values by 10 and raises happiness."
    },
    [170] = {
        name = "Kelpsy Berry",
        description = "Drops Attack Effort Values by 10 and raises happiness."
    },
    [171] = {
        name = "Qualot Berry",
        description = "Drops Defense Effort Values by 10 and raises happiness."
    },
    [172] = {
        name = "Hondew Berry",
        description = "Drops Special Attack Effort Values by 10 and raises happiness."
    },
    [173] = {
        name = "Grepa Berry",
        description = "Drops Special Defense Effort Values by 10 and raises happiness."
    },
    [174] = {
        name = "Tamato Berry",
        description = "Drops Speed Effort Values by 10 and raises happiness."
    },
    [175] = {
        name = "Cornn Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [176] = {
        name = "Magost Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [177] = {
        name = "Rabuta Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [178] = {
        name = "Nomel Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [179] = {
        name = "Spelon Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [180] = {
        name = "Pamtre Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [181] = {
        name = "Watmel Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [182] = {
        name = "Durin Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [183] = {
        name = "Belue Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [184] = {
        name = "Occa Berry",
        description = "Consumed when struck by a super-effective Fire-type attack to halve the damage."
    },
    [185] = {
        name = "Passho Berry",
        description = "Consumed when struck by a super-effective Water-type attack to halve the damage."
    },
    [186] = {
        name = "Wacan Berry",
        description = "Consumed when struck by a super-effective Electric-type attack to halve the damage."
    },
    [187] = {
        name = "Rindo Berry",
        description = "Consumed when struck by a super-effective Grass-type attack to halve the damage."
    },
    [188] = {
        name = "Yache Berry",
        description = "Consumed when struck by a super-effective Ice-type attack to halve the damage."
    },
    [189] = {
        name = "Chople Berry",
        description = "Consumed when struck by a super-effective Fighting-type attack to halve the damage."
    },
    [190] = {
        name = "Kebia Berry",
        description = "Consumed when struck by a super-effective Poison-type attack to halve the damage."
    },
    [191] = {
        name = "Shuca Berry",
        description = "Consumed when struck by a super-effective Ground-type attack to halve the damage."
    },
    [192] = {
        name = "Coba Berry",
        description = "Consumed when struck by a super-effective Flying-type attack to halve the damage."
    },
    [193] = {
        name = "Payapa Berry",
        description = "Consumed when struck by a super-effective Psychic-type attack to halve the damage."
    },
    [194] = {
        name = "Tanga Berry",
        description = "Consumed when struck by a super-effective Bug-type attack to halve the damage."
    },
    [195] = {
        name = "Charti Berry",
        description = "Consumed when struck by a super-effective Rock-type attack to halve the damage."
    },
    [196] = {
        name = "Kasib Berry",
        description = "Consumed when struck by a super-effective Ghost-type attack to halve the damage."
    },
    [197] = {
        name = "Haban Berry",
        description = "Consumed when struck by a super-effective Dragon-type attack to halve the damage."
    },
    [198] = {
        name = "Colbur Berry",
        description = "Consumed when struck by a super-effective Dark-type attack to halve the damage."
    },
    [199] = {
        name = "Babiri Berry",
        description = "Consumed when struck by a super-effective Steel-type attack to halve the damage."
    },
    [200] = {
        name = "Chilan Berry",
        description = "Consumed when struck by a Normal-type attack to halve the damage."
    },
    [201] = {
        name = "Liechi Berry",
        description = "Consumed at 1/4 max HP to boost Attack."
    },
    [202] = {
        name = "Ganlon Berry",
        description = "Consumed at 1/4 max HP to boost Defense."
    },
    [203] = {
        name = "Salac Berry",
        description = "Consumed at 1/4 max HP to boost Speed."
    },
    [204] = {
        name = "Petaya Berry",
        description = "Consumed at 1/4 max HP to boost Special Attack."
    },
    [205] = {
        name = "Apicot Berry",
        description = "Consumed at 1/4 max HP to boost Special Defense."
    },
    [206] = {
        name = "Lansat Berry",
        description = "Consumed at 1/4 max HP to boost critical hit ratio by two stages."
    },
    [207] = {
        name = "Starf Berry",
        description = "Consumed at 1/4 max HP to boost a random stat by two stages."
    },
    [208] = {
        name = "Enigma Berry",
        description = "Consumed when struck by a super-effective attack to restore 1/4 max HP."
    },
    [209] = {
        name = "Micle Berry",
        description = "Consumed at 1/4 max HP to give the next move perfect accuracy."
    },
    [210] = {
        name = "Custap Berry",
        description = "Consumed at 1/4 max HP when using a move to go first."
    },
    [211] = {
        name = "Jaboca Berry",
        description = "Consumed to deal 1/8 attacker's max HP when holder is struck by a physical attack."
    },
    [212] = {
        name = "Rowap Berry",
        description = "Consumed to deal 1/8 attacker's max HP when holder is struck by a special attack."
    },
    [213] = {
        name = "BrightPowder",
        description = "Increases the holder's evasion by 1/9 (11 1/9%)."
    },
    [214] = {
        name = "White Herb",
        description = "Resets all lowered stats to normal at end of turn. Consumed after use."
    },
    [215] = {
        name = "Macho Brace",
        description = "Holder gains double effort values from battles, but has halved Speed in battle."
    },
    [216] = {
        name = "Exp Share",
        description = "Half the experience from a battle is split between Pok" .. Chars.accentedE .. "mon holding this item."
    },
    [217] = {
        name = "Quick Claw",
        description = "Holder has a 3/16 (18.75%) chance to move first."
    },
    [218] = {
        name = "Soothe Bell",
        description = "Doubles the happiness earned by the holder."
    },
    [219] = {
        name = "Mental Herb",
        description = "Consumed to cure infatuation. Gen V: Also removes Taunt, Encore, Torment, Disable, and Cursed Body."
    },
    [220] = {
        name = "Choice Band",
        description = "Increases Attack by 50%, but restricts the holder to only one move."
    },
    [221] = {
        name = "King's Rock",
        description = "Damaging moves gain a 10% chance to make their target flinch. Traded on a Poliwhirl: Holder evolves into Politoed. Traded on a Slowpoke: Holder evolves into Slowking."
    },
    [222] = {
        name = "Silver Powder",
        description = "Bug-Type moves from holder do 20% more damage."
    },
    [223] = {
        name = "Amulet Coin",
        description = "Doubles the money earned from a battle. Does not stack with Luck Incense."
    },
    [224] = {
        name = "Cleanse Tag",
        description = "Prevents wild encounters of level lower than your party's lead Pokemon."
    },
    [225] = {
        name = "Soul Dew",
        description = "Raises Latias and Latios's Special Attack and Special Defense by 50%."
    },
    [226] = {
        name = "Deep Sea-tooth",
        description = "Doubles Clamperl's Special Attack. Traded on a Clamperl: Holder evolves into Huntail."
    },
    [227] = {
        name = "Deep Sea-scale",
        description = "Doubles Clamperl's Special Defense. Traded on a Clamperl: Holder evolves into Gorebyss."
    },
    [228] = {
        name = "Smoke Ball",
        description = "Allows the Holder to escape from any wild battle."
    },
    [229] = {
        name = "Everstone",
        description = "Prevents level-based evolution from occuring."
    },
    [230] = {
        name = "Focus Band",
        description = "Holder has 10% chance to survive attacks or self-inflicted damage at 1 HP."
    },
    [231] = {
        name = "Lucky Egg",
        description = "Increases EXP earned in battle by 50%."
    },
    [232] = {
        name = "Scope Lens",
        description = "Raises the holder's critical hit ratio by one stage."
    },
    [233] = {
        name = "Metal Coat",
        description = "Steel-Type moves from holder do 20% more damage."
    },
    [234] = {
        name = "Leftovers",
        description = "Restores 1/16 (6.25%) holder's max HP at the end of each turn."
    },
    [235] = {
        name = "Dragon Scale",
        description = "Traded on a Seadra: Holder evolves into Kingdra."
    },
    [236] = {
        name = "Light Ball",
        description = "Doubles Pikachu's Attack and Special Attack. Breed on Pikachu or Raichu: Pichu Egg will have Volt Tackle."
    },
    [237] = {
        name = "Soft Sand",
        description = "Ground-Type moves from holder do 20% more damage."
    },
    [238] = {
        name = "Hard Stone",
        description = "Rock-Type moves from holder do 20% more damage."
    },
    [239] = {
        name = "Miracle Seed",
        description = "Grass-Type moves from holder do 20% more damage."
    },
    [240] = {
        name = "BlackGlasses",
        description = "Dark-Type moves from holder do 20% more damage."
    },
    [241] = {
        name = "Black Belt",
        description = "Fighting-Type moves from holder do 20% more damage."
    },
    [242] = {
        name = "Magnet",
        description = "Electric-Type moves from holder do 20% more damage."
    },
    [243] = {
        name = "Mystic Water",
        description = "Water-Type moves from holder do 20% more damage."
    },
    [244] = {
        name = "Sharp Beak",
        description = "Flying-Type moves from holder do 20% more damage."
    },
    [245] = {
        name = "Poison Barb",
        description = "Poison-Type moves from holder do 20% more damage."
    },
    [246] = {
        name = "Never Melt-ice",
        description = "Ice-Type moves from holder do 20% more damage."
    },
    [247] = {
        name = "Spell Tag",
        description = "Ghost-Type moves from holder do 20% more damage."
    },
    [248] = {
        name = "Twisted Spoon",
        description = "Psychic-Type moves from holder do 20% more damage."
    },
    [249] = {
        name = "Charcoal",
        description = "Fire-Type moves from holder do 20% more damage."
    },
    [250] = {
        name = "Dragon Fang",
        description = "Dragon-Type moves from holder do 20% more damage."
    },
    [251] = {
        name = "Silk Scarf",
        description = "Normal-Type moves from holder do 20% more damage."
    },
    [252] = {
        name = "Up Grade",
        description = "Traded on a Porygon: Holder evolves into Porygon2."
    },
    [253] = {
        name = "Shell Bell",
        description = "Holder receives 1/8 of the damage it deals when attacking."
    },
    [254] = {
        name = "Sea Incense",
        description = "Water-Type moves from holder do 20% more damage. Breeding: Marill or Azumarill beget an Azurill Egg."
    },
    [255] = {
        name = "Lax Incense",
        description = "Holder's evasion is increased by 10%. Breeding: Wobbuffet begets a Wynaut Egg."
    },
    [256] = {
        name = "Lucky Punch",
        description = "Raises Chansey's critical hit ratio by two stages."
    },
    [257] = {
        name = "Metal Powder",
        description = "Raises Ditto's Defense and Special Defense by 50%. The boost is lost after transforming."
    },
    [258] = {
        name = "Thick Club",
        description = "Doubles Cubone or Marowak's Attack."
    },
    [259] = {
        name = "Stick",
        description = "Raises Farfetch'd's critical hit ratio by two stages."
    },
    [260] = {
        name = "Red Scarf",
        description = "Raises the holder's Coolness while in a contest."
    },
    [261] = {
        name = "Blue Scarf",
        description = "Raises the holder's Beauty while in a contest."
    },
    [262] = {
        name = "Pink Scarf",
        description = "Raises the holder's Cuteness while in a contest."
    },
    [263] = {
        name = "Green Scarf",
        description = "Raises the holder's Smartness while in a contest."
    },
    [264] = {
        name = "Yellow Scarf",
        description = "Raises the holder's Toughness while in a contest."
    },
    [265] = {
        name = "Wide Lens",
        description = "Provides a 1/10 (10%) boost in accuracy to the holder."
    },
    [266] = {
        name = "Muscle Band",
        description = "Boosts the damage of physical moves used by the holder by 10%."
    },
    [267] = {
        name = "Wise Glasses",
        description = "Boosts the damage of special moves used by the holder by 1/10 (10%)."
    },
    [268] = {
        name = "Expert Belt",
        description = "Holder's Super Effective moves do 20% extra damage."
    },
    [269] = {
        name = "Light Clay",
        description = "Light Screen and Reflect used by the holder last 8 rounds instead of 5."
    },
    [270] = {
        name = "Life Orb",
        description = "Holder's moves inflict 30% extra damage, but cost 10% max HP."
    },
    [271] = {
        name = "Power Herb",
        description = "Both turns of a two-turn charge move happen at once. Consumed upon use."
    },
    [272] = {
        name = "Toxic Orb",
        description = "Inflicts Toxic on the holder at the end of the turn. Activates after Poison damage would occur."
    },
    [273] = {
        name = "Flame Orb",
        description = "Inflicts Burn on the holder at the end of the turn. Activates after Burn damage would occur."
    },
    [274] = {
        name = "Quick Powder",
        description = "Doubles Ditto's Speed when held. The boost is lost after transforming."
    },
    [275] = {
        name = "Focus Sash",
        description = "Holder survives any single-hit attack at 1 HP if at max HP, then the item is consumed."
    },
    [276] = {
        name = "Zoom Lens",
        description = "Provides a 1/5 (20%) boost in accuracy if the holder moves after the target."
    },
    [277] = {
        name = "Metronome",
        description = "Consectutive uses of the same attack have a cumulative damage boost of 10%. Maximum 100% boost."
    },
    [278] = {
        name = "Iron Ball",
        description = "Holder's Speed is halved. Negates all Ground-type immunities, and makes Flying-types take neutral damage from Ground-type moves. Arena Trap. Spikes, and Toxic Spikes affect the holder."
    },
    [279] = {
        name = "Lagging Tail",
        description = "Holder moves last in its priority bracket."
    },
    [280] = {
        name = "Destiny Knot",
        description = "Infatuates opposing Pok" .. Chars.accentedE .. "mon when holder is inflicted with infatuation."
    },
    [281] = {
        name = "Black Sludge",
        description = "Poison-type holder recovers 1/16 (6.25%) max HP each turn. Non-Poison-Types take 1/8 (12.5%) max HP damage."
    },
    [282] = {
        name = "Icy Rock",
        description = "Hail by the holder lasts 8 rounds instead of 5."
    },
    [283] = {
        name = "Smooth Rock",
        description = "Sandstorm by the holder lasts 8 rounds instead of 5."
    },
    [284] = {
        name = "Heat Rock",
        description = "Sunny Day by the holder lasts 8 rounds instead of 5."
    },
    [285] = {
        name = "Damp Rock",
        description = "Rain Dance by the holder lasts 8 rounds instead of 5."
    },
    [286] = {
        name = "Grip Claw",
        description = "Holder's multi-turn trapping moves last 5 turns."
    },
    [287] = {
        name = "Choice Scarf",
        description = "Increases Speed by 50%, but restricts the holder to only one move."
    },
    [288] = {
        name = "Sticky Barb",
        description = "Holder takes 1/8 (12.5%) its max HP at the end of each turn. When the holder is hit by a contact move, the attacking Pok" ..
            Chars.accentedE .. "mon takes 1/8 its max HP in damage and receive the item if not holding one."
    },
    [289] = {
        name = "Power Bracer",
        description = "Holder gains 4 Attack effort values, but has halved Speed in battle."
    },
    [290] = {
        name = "Power Belt",
        description = "Holder gains 4 Defense effort values, but has halved Speed in battle."
    },
    [291] = {
        name = "Power Lens",
        description = "Holder gains 4 Special Attack effort values, but has halved Speed in battle."
    },
    [292] = {
        name = "Power Band",
        description = "Holder gains 4 Special Defense effort values, but has halved Speed in battle."
    },
    [293] = {
        name = "Power Anklet",
        description = "Holder gains 4 Speed effort values, but has halved Speed in battle."
    },
    [294] = {
        name = "Power Weight",
        description = "Holder gains 4 HP effort values, but has halved Speed in battle."
    },
    [295] = {
        name = "Shed Shell",
        description = "Holder can bypass all trapping effects and switch out. Multi-turn moves still cannot be switched out of."
    },
    [296] = {
        name = "Big Root",
        description = "Increases HP recovered from draining moves, Ingrain, and Aqua Ring by 3/10 (30%)."
    },
    [297] = {
        name = "Choice Specs",
        description = "Increases Special Attack by 50%, but restricts the holder to only one move."
    },
    [298] = {
        name = "Flame Plate",
        description = "Fire-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Fire."
    },
    [299] = {
        name = "Splash Plate",
        description = "Water-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Water."
    },
    [300] = {
        name = "Zap Plate",
        description = "Electric-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Electric."
    },
    [301] = {
        name = "Meadow Plate",
        description = "Grass-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Grass."
    },
    [302] = {
        name = "Icicle Plate",
        description = "Ice-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Ice."
    },
    [303] = {
        name = "Fist Plate",
        description = "Fighting-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Fighting."
    },
    [304] = {
        name = "Toxic Plate",
        description = "Posion-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Posion."
    },
    [305] = {
        name = "Earth Plate",
        description = "Ground-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Ground."
    },
    [306] = {
        name = "Sky Plate",
        description = "Flying-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Flying."
    },
    [307] = {
        name = "Mind Plate",
        description = "Psychic-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Psychic."
    },
    [308] = {
        name = "Insect Plate",
        description = "Bug-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Bug."
    },
    [309] = {
        name = "Stone Plate",
        description = "Rock-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Rock."
    },
    [310] = {
        name = "Spooky Plate",
        description = "Ghost-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Ghost."
    },
    [311] = {
        name = "Draco Plate",
        description = "Dragon-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Dragon."
    },
    [312] = {
        name = "Dread Plate",
        description = "Dark-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Dark."
    },
    [313] = {
        name = "Iron Plate",
        description = "Steel-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Steel."
    },
    [314] = {
        name = "Odd Incense",
        description = "Psychic-Type moves from holder do 20% more damage. Breeding: Mr. Mime begets a Mime Jr. Egg."
    },
    [315] = {
        name = "Rock Incense",
        description = "Rock-Type moves from holder do 20% more damage. Breeding: Sudowoodo begets a Bonsly Egg."
    },
    [316] = {
        name = "Full Incense",
        description = "Holder moves last in its priority bracket. Breeding: Snorlax begets a Munchlax Egg."
    },
    [317] = {
        name = "Wave Incense",
        description = "Water-Type moves from holder do 20% more damage. Breeding: Mantine begets a Mantyke Egg."
    },
    [318] = {
        name = "Rose Incense",
        description = "Grass-Type moves from holder do 20% more damage. Breeding: Roselia or Roserade beget a Budew Egg."
    },
    [319] = {
        name = "Luck Incense",
        description = "Doubles the money earned from a battle. Does not stack with Amulet Coin. Breeding: Chansey and Blissey beget a Happiny Egg."
    },
    [320] = {
        name = "Pure Incense",
        description = "Prevents wild encounters of level lower than your party's lead Pokemon. Breeding: Chimecho begets a Chingling Egg."
    },
    [321] = {
        name = "Protector",
        description = "Traded on a Rhydon: Holder evolves into Rhyperior."
    },
    [322] = {
        name = "Electirizer",
        description = "Traded on an Electabuzz: Holder evolves into Electivire."
    },
    [323] = {
        name = "Magmarizer",
        description = "Traded on a Magmar: Holder evolves into Magmortar."
    },
    [324] = {
        name = "Dubious Disc",
        description = "Traded on a Porygon2: Holder evolves into Porygon-Z."
    },
    [325] = {
        name = "Reaper Cloth",
        description = "Traded on a Dusclops: Holder evolves into Dusknoir."
    },
    [326] = {
        name = "Razor Claw",
        description = "Raises the holder's critical hit ratio by one stage. Held by a Sneasel while levelling up at night: Holder evolves into Weavile."
    },
    [327] = {
        name = "Razor Fang",
        description = "Damaging moves gain a 10% chance to make their target flinch. Held by a Gligar while levelling up: Holder evolves into Gliscor."
    },
    [328] = {
        name = "TM01",
        description = "Teaches a move to a compatible Pokemon."
    },
    [329] = {
        name = "TM02",
        description = "Teaches a move to a compatible Pokemon."
    },
    [330] = {
        name = "TM03",
        description = "Teaches a move to a compatible Pokemon."
    },
    [331] = {
        name = "TM04",
        description = "Teaches a move to a compatible Pokemon."
    },
    [332] = {
        name = "TM05",
        description = "Teaches a move to a compatible Pokemon."
    },
    [333] = {
        name = "TM06",
        description = "Teaches a move to a compatible Pokemon."
    },
    [334] = {
        name = "TM07",
        description = "Teaches a move to a compatible Pokemon."
    },
    [335] = {
        name = "TM08",
        description = "Teaches a move to a compatible Pokemon."
    },
    [336] = {
        name = "TM09",
        description = "Teaches a move to a compatible Pokemon."
    },
    [337] = {
        name = "TM10",
        description = "Teaches a move to a compatible Pokemon."
    },
    [338] = {
        name = "TM11",
        description = "Teaches a move to a compatible Pokemon."
    },
    [339] = {
        name = "TM12",
        description = "Teaches a move to a compatible Pokemon."
    },
    [340] = {
        name = "TM13",
        description = "Teaches a move to a compatible Pokemon."
    },
    [341] = {
        name = "TM14",
        description = "Teaches a move to a compatible Pokemon."
    },
    [342] = {
        name = "TM15",
        description = "Teaches a move to a compatible Pokemon."
    },
    [343] = {
        name = "TM16",
        description = "Teaches a move to a compatible Pokemon."
    },
    [344] = {
        name = "TM17",
        description = "Teaches a move to a compatible Pokemon."
    },
    [345] = {
        name = "TM18",
        description = "Teaches a move to a compatible Pokemon."
    },
    [346] = {
        name = "TM19",
        description = "Teaches a move to a compatible Pokemon."
    },
    [347] = {
        name = "TM20",
        description = "Teaches a move to a compatible Pokemon."
    },
    [348] = {
        name = "TM21",
        description = "Teaches a move to a compatible Pokemon."
    },
    [349] = {
        name = "TM22",
        description = "Teaches a move to a compatible Pokemon."
    },
    [350] = {
        name = "TM23",
        description = "Teaches a move to a compatible Pokemon."
    },
    [351] = {
        name = "TM24",
        description = "Teaches a move to a compatible Pokemon."
    },
    [352] = {
        name = "TM25",
        description = "Teaches a move to a compatible Pokemon."
    },
    [353] = {
        name = "TM26",
        description = "Teaches a move to a compatible Pokemon."
    },
    [354] = {
        name = "TM27",
        description = "Teaches a move to a compatible Pokemon."
    },
    [355] = {
        name = "TM28",
        description = "Teaches a move to a compatible Pokemon."
    },
    [356] = {
        name = "TM29",
        description = "Teaches a move to a compatible Pokemon."
    },
    [357] = {
        name = "TM30",
        description = "Teaches a move to a compatible Pokemon."
    },
    [358] = {
        name = "TM31",
        description = "Teaches a move to a compatible Pokemon."
    },
    [359] = {
        name = "TM32",
        description = "Teaches a move to a compatible Pokemon."
    },
    [360] = {
        name = "TM33",
        description = "Teaches a move to a compatible Pokemon."
    },
    [361] = {
        name = "TM34",
        description = "Teaches a move to a compatible Pokemon."
    },
    [362] = {
        name = "TM35",
        description = "Teaches a move to a compatible Pokemon."
    },
    [363] = {
        name = "TM36",
        description = "Teaches a move to a compatible Pokemon."
    },
    [364] = {
        name = "TM37",
        description = "Teaches a move to a compatible Pokemon."
    },
    [365] = {
        name = "TM38",
        description = "Teaches a move to a compatible Pokemon."
    },
    [366] = {
        name = "TM39",
        description = "Teaches a move to a compatible Pokemon."
    },
    [367] = {
        name = "TM40",
        description = "Teaches a move to a compatible Pokemon."
    },
    [368] = {
        name = "TM41",
        description = "Teaches a move to a compatible Pokemon."
    },
    [369] = {
        name = "TM42",
        description = "Teaches a move to a compatible Pokemon."
    },
    [370] = {
        name = "TM43",
        description = "Teaches a move to a compatible Pokemon."
    },
    [371] = {
        name = "TM44",
        description = "Teaches a move to a compatible Pokemon."
    },
    [372] = {
        name = "TM45",
        description = "Teaches a move to a compatible Pokemon."
    },
    [373] = {
        name = "TM46",
        description = "Teaches a move to a compatible Pokemon."
    },
    [374] = {
        name = "TM47",
        description = "Teaches a move to a compatible Pokemon."
    },
    [375] = {
        name = "TM48",
        description = "Teaches a move to a compatible Pokemon."
    },
    [376] = {
        name = "TM49",
        description = "Teaches a move to a compatible Pokemon."
    },
    [377] = {
        name = "TM50",
        description = "Teaches a move to a compatible Pokemon."
    },
    [378] = {
        name = "TM51",
        description = "Teaches a move to a compatible Pokemon."
    },
    [379] = {
        name = "TM52",
        description = "Teaches a move to a compatible Pokemon."
    },
    [380] = {
        name = "TM53",
        description = "Teaches a move to a compatible Pokemon."
    },
    [381] = {
        name = "TM54",
        description = "Teaches a move to a compatible Pokemon."
    },
    [382] = {
        name = "TM55",
        description = "Teaches a move to a compatible Pokemon."
    },
    [383] = {
        name = "TM56",
        description = "Teaches a move to a compatible Pokemon."
    },
    [384] = {
        name = "TM57",
        description = "Teaches a move to a compatible Pokemon."
    },
    [385] = {
        name = "TM58",
        description = "Teaches a move to a compatible Pokemon."
    },
    [386] = {
        name = "TM59",
        description = "Teaches a move to a compatible Pokemon."
    },
    [387] = {
        name = "TM60",
        description = "Teaches a move to a compatible Pokemon."
    },
    [388] = {
        name = "TM61",
        description = "Teaches a move to a compatible Pokemon."
    },
    [389] = {
        name = "TM62",
        description = "Teaches a move to a compatible Pokemon."
    },
    [390] = {
        name = "TM63",
        description = "Teaches a move to a compatible Pokemon."
    },
    [391] = {
        name = "TM64",
        description = "Teaches a move to a compatible Pokemon."
    },
    [392] = {
        name = "TM65",
        description = "Teaches a move to a compatible Pokemon."
    },
    [393] = {
        name = "TM66",
        description = "Teaches a move to a compatible Pokemon."
    },
    [394] = {
        name = "TM67",
        description = "Teaches a move to a compatible Pokemon."
    },
    [395] = {
        name = "TM68",
        description = "Teaches a move to a compatible Pokemon."
    },
    [396] = {
        name = "TM69",
        description = "Teaches a move to a compatible Pokemon."
    },
    [397] = {
        name = "TM70",
        description = "Teaches a move to a compatible Pokemon."
    },
    [398] = {
        name = "TM71",
        description = "Teaches a move to a compatible Pokemon."
    },
    [399] = {
        name = "TM72",
        description = "Teaches a move to a compatible Pokemon."
    },
    [400] = {
        name = "TM73",
        description = "Teaches a move to a compatible Pokemon."
    },
    [401] = {
        name = "TM74",
        description = "Teaches a move to a compatible Pokemon."
    },
    [402] = {
        name = "TM75",
        description = "Teaches a move to a compatible Pokemon."
    },
    [403] = {
        name = "TM76",
        description = "Teaches a move to a compatible Pokemon."
    },
    [404] = {
        name = "TM77",
        description = "Teaches a move to a compatible Pokemon."
    },
    [405] = {
        name = "TM78",
        description = "Teaches a move to a compatible Pokemon."
    },
    [406] = {
        name = "TM79",
        description = "Teaches a move to a compatible Pokemon."
    },
    [407] = {
        name = "TM80",
        description = "Teaches a move to a compatible Pokemon."
    },
    [408] = {
        name = "TM81",
        description = "Teaches a move to a compatible Pokemon."
    },
    [409] = {
        name = "TM82",
        description = "Teaches a move to a compatible Pokemon."
    },
    [410] = {
        name = "TM83",
        description = "Teaches a move to a compatible Pokemon."
    },
    [411] = {
        name = "TM84",
        description = "Teaches a move to a compatible Pokemon."
    },
    [412] = {
        name = "TM85",
        description = "Teaches a move to a compatible Pokemon."
    },
    [413] = {
        name = "TM86",
        description = "Teaches a move to a compatible Pokemon."
    },
    [414] = {
        name = "TM87",
        description = "Teaches a move to a compatible Pokemon."
    },
    [415] = {
        name = "TM88",
        description = "Teaches a move to a compatible Pokemon."
    },
    [416] = {
        name = "TM89",
        description = "Teaches a move to a compatible Pokemon."
    },
    [417] = {
        name = "TM90",
        description = "Teaches a move to a compatible Pokemon."
    },
    [418] = {
        name = "TM91",
        description = "Teaches a move to a compatible Pokemon."
    },
    [419] = {
        name = "TM92",
        description = "Teaches a move to a compatible Pokemon."
    },
    [420] = {
        name = "HM01",
        description = "Teaches a move to a compatible Pokemon."
    },
    [421] = {
        name = "HM02",
        description = "Teaches a move to a compatible Pokemon."
    },
    [422] = {
        name = "HM03",
        description = "Teaches a move to a compatible Pokemon."
    },
    [423] = {
        name = "HM04",
        description = "Teaches a move to a compatible Pokemon."
    },
    [424] = {
        name = "HM05",
        description = "Teaches a move to a compatible Pokemon."
    },
    [425] = {
        name = "HM06",
        description = "Teaches a move to a compatible Pokemon."
    },
    [426] = {
        name = "HM07",
        description = "Teaches a move to a compatible Pokemon."
    },
    [427] = {
        name = "HM08",
        description = "Teaches a move to a compatible Pokemon."
    },
    [428] = {
        name = "Explorer Kit",
        description = "Allows visiting the Underground."
    },
    [429] = {
        name = "Loot Sack",
        description = "Carries coal mine loot."
    },
    [430] = {
        name = "Rule Book",
        description = "List of battle types and their rules."
    },
    [431] = {
        name = "Poke Radar",
        description = "Use to track down rare or shiny Pokemon. 50 steps to recharge."
    },
    [432] = {
        name = "Point Card",
        description = "Keeps count of Battle Points earned."
    },
    [433] = {
        name = "Journal",
        description = "Records prior significant activities the player took."
    },
    [434] = {
        name = "Seal Case",
        description = "Stores Seals that can be applied to Poke Ball capsules."
    },
    [435] = {
        name = "Fashion Case",
        description = "Holds Pok" .. Chars.accentedE .. "mon Accessories for use in Contests."
    },
    [436] = {
        name = "Seal Bag",
        description = "Holds ten Seals for Poke Balls."
    },
    [437] = {
        name = "Pal Pad",
        description = "Use to record Friend Codes and check your own."
    },
    [438] = {
        name = "Works Key",
        description = "Grants access to Valley Windworks."
    },
    [439] = {
        name = "Old Charm",
        description = "Trade to Cynthia's grandmother in Celestic Town for HM04 (Surf)."
    },
    [440] = {
        name = "Galactic Key",
        description = "Grants access to Galactic HQ in Veilstone City."
    },
    [441] = {
        name = "Red Chain",
        description = "Used to bind Palkia and Dialga."
    },
    [442] = {
        name = "Town Map",
        description = "Use to see the overworld map."
    },
    [443] = {
        name = "Vs Seeker",
        description = "Allows rebattling of on-screen trainers. 100 steps to recharge."
    },
    [444] = {
        name = "Coin Case",
        description = "Holds coins for the Game Corner."
    },
    [445] = {
        name = "Old Rod",
        description = "Used to catch Pok" .. Chars.accentedE .. "mon in bodies of water."
    },
    [446] = {
        name = "Good Rod",
        description = "Used to catch Pok" .. Chars.accentedE .. "mon in bodies of water."
    },
    [447] = {
        name = "Super Rod",
        description = "Used to catch Pok" .. Chars.accentedE .. "mon in bodies of water."
    },
    [448] = {
        name = "Sprayduck",
        description = "Used to water berries."
    },
    [449] = {
        name = "Poffin Case",
        description = "Holds Poffins."
    },
    [450] = {
        name = "Bicycle",
        description = "Use for fast transit."
    },
    [451] = {
        name = "Suite Key",
        description = "Opens a locked building in the Lakeside Resort."
    },
    [452] = {
        name = "Oaks Letter",
        description = "Allows access to Seabreak path, Flower Paradise, and Shaymin."
    },
    [453] = {
        name = "Lunar Wing",
        description = "Cures sailor's son of nightmares in Canalave City."
    },
    [454] = {
        name = "Member Card",
        description = "Allows access to Newmoon Island and Darkrai."
    },
    [455] = {
        name = "Azure Flute",
        description = "Allows entry into the Hall of Origin. Unreleased."
    },
    [456] = {
        name = "Ss Ticket",
        description = "Ticket for a ship. (RSE: S.S. Tidal LF: S.S. Anne HG: S.S. Aqua)"
    },
    [457] = {
        name = "Contest Pass",
        description = "Allows participation in Pok" .. Chars.accentedE .. "mon Contests."
    },
    [458] = {
        name = "Magma Stone",
        description = "Magma is sealed inside."
    },
    [459] = {
        name = "Parcel",
        description = "Given to the trainer's rival in Jubilife City. Contains Town Maps."
    },
    [460] = {
        name = "Coupon 1",
        description = "The first of three tickets used to obtain a Poketch."
    },
    [461] = {
        name = "Coupon 2",
        description = "The second of three tickets used to obtain a Poketch."
    },
    [462] = {
        name = "Coupon 3",
        description = "The last of three tickets used to obtain a Poketch."
    },
    [463] = {
        name = "Storage Key",
        description = "Grants access to the Team Galactic warehouse in Veilstone City."
    },
    [464] = {
        name = "Secret Potion",
        description = "Used to heal the Ampharos at the top of Olivine Lighthouse."
    },
    [112] = {
        name = "Griseous Orb",
        description = "Boosts the damage from Giratina's Dragon-type and Ghost-type moves by 20%, and transforms it into Origin Forme."
    },
    [465] = {
        name = "Vs Recorder",
        description = "Records wireless, Wi-Fi, or Battle Frontier battles, and stores points."
    },
    [466] = {
        name = "Gracidea",
        description = "Changes an unfrozen Shaymin to Sky Forme in the day."
    },
    [467] = {
        name = "Secret Key",
        description = "Gen IV: The key to Rotom's appliance room. "
    },
    [468] = {
        name = "Apricorn Box",
        description = "Holds Apricorns."
    },
    [470] = {
        name = "Berry Pots",
        description = "Allows portable berry growing."
    },
    [477] = {
        name = "Squirt Bottle",
        description = "Use on Sudowoodo blocking the path on Route 36. Also waters berries."
    },
    [494] = {
        name = "Lure Ball",
        description = "3x effectiveness while fishing. Made from Blu Apricorn."
    },
    [493] = {
        name = "Level Ball",
        description = "Success rate based off of fraction target Pok" ..
            Chars.accentedE .. "mon is of user's Pokemon. Made from Red Apricorn."
    },
    [498] = {
        name = "Moon Ball",
        description = "4x effectiveness on familes of Pok" ..
            Chars.accentedE .. "mon with a Moon Stone evolution. Made from Ylw Apricorn."
    },
    [495] = {
        name = "Heavy Ball",
        description = "Has flat bonus or penalty to catch rate depending on weight class of target. Made from Blk Apricorn."
    },
    [492] = {
        name = "Fast Ball",
        description = "4x effectiveness on Pok" ..
            Chars.accentedE .. "mon with 100 or greater base speed. Made from Wht Apricorn."
    },
    [497] = {
        name = "Friend Ball",
        description = "Caught Pok" .. Chars.accentedE .. "mon start with 200 happiness. Made from Grn Apricorn."
    },
    [496] = {
        name = "Love Ball",
        description = "8x effectiveness on opposite sex, same species targets of the Active Pokemon. Made from Pnk Apricorn."
    },
    [500] = {
        name = "Park Ball",
        description = "Catches Pok" .. Chars.accentedE .. "mon in the Pal Park every time."
    },
    [499] = {
        name = "Sport Ball",
        description = "Tries to catch a Pok" .. Chars.accentedE .. "mon in the Bug-Catching contest in National Park. "
    },
    [485] = {
        name = "Red Apricorn",
        description = "Used to make a Level Ball."
    },
    [487] = {
        name = "Blue Apricorn",
        description = "Used to make a Lure Ball."
    },
    [486] = {
        name = "Yellow Apricorn",
        description = "Used to make a Moon Ball."
    },
    [488] = {
        name = "Green Apricorn",
        description = "Used to make a Friend Ball."
    },
    [489] = {
        name = "Pink Apricorn",
        description = "Used to make a Love Ball."
    },
    [490] = {
        name = "White Apricorn",
        description = "Used to make a Fast Ball."
    },
    [491] = {
        name = "Black Apricorn",
        description = "Used to make a Heavy Ball."
    },
    [471] = {
        name = "Dowsing Machine",
        description = "Use to find hidden items on the field. AKA Itemfinder."
    },
    [504] = {
        name = "RageCandyBar",
        description = "Traded for TM64."
    },
    [534] = {
        name = "Red Orb",
        description = "Summons Groudon to the Embedded Tower."
    },
    [535] = {
        name = "Blue Orb",
        description = "Summons Kyogre to the Embedded Tower."
    },
    [532] = {
        name = "Jade Orb",
        description = "Summons Rayquaza to the Embedded Tower."
    },
    [536] = {
        name = "Enigma Stone",
        description = "S: Summons Latias H: Summons Latios."
    },
    [469] = {
        name = "Unown Report",
        description = "Keeps track of Unown types caught."
    },
    [472] = {
        name = "Blue Card",
        description = "Keeps track of points from Buena's show."
    },
    [473] = {
        name = "Slowpoke Tail",
        description = "A tasty tail that sells for a high price."
    },
    [474] = {
        name = "Clear Bell",
        description = "HS: Allows Kimono-girls to summon Ho-oh. C: Summons Suicune to the Tin Tower."
    },
    [475] = {
        name = "Card Key",
        description = "HS: Opens doors in the Radio Tower. "
    },
    [476] = {
        name = "Basement Key",
        description = "HS: Key to the tunnel under Goldenrod City. "
    },
    [478] = {
        name = "Red Scale",
        description = "Trade to Mr. Pok" .. Chars.accentedE .. "mon for an Exp. Share."
    },
    [479] = {
        name = "Lost Item",
        description = "A Poke Doll lost by the Copycat who lives in Saffron City. Trade for a Pass."
    },
    [480] = {
        name = "Pass",
        description = "Grants access to ride the Magnet Train between Goldenrod City and Saffron City."
    },
    [481] = {
        name = "Machine Part",
        description = "Must be replaced in the Power Plant to power the Magnet Train."
    },
    [482] = {
        name = "Silver Wing",
        description = "Summons Lugia to the Whirl Islands."
    },
    [483] = {
        name = "Rainbow Wing",
        description = "Summons Ho-Oh at the top of the Bell Tower."
    },
    [484] = {
        name = "Mystery Egg",
        description = "Deliver to Professor Elm."
    },
    [502] = {
        name = "Gb Sounds",
        description = "Use to listen to GameBoy era audio."
    },
    [503] = {
        name = "Tidal Bell",
        description = "Allows Kimono-girls to summon Lugia."
    },
    [505] = {
        name = "Data Card-01",
        description = "Records the number of times the trainer has come in first place overall in the Pokeathlon."
    },
    [506] = {
        name = "Data Card-02",
        description = "Records the number of times the trainer has come in last place overall in the Pokeathlon."
    },
    [507] = {
        name = "Data Card-03",
        description = "Records the number of times the trainer's Pok" ..
            Chars.accentedE .. "mon have dashed in the Pokeathlon."
    },
    [508] = {
        name = "Data Card-04",
        description = "Records the number of times the trainer's Pok" ..
            Chars.accentedE .. "mon have jumped in the Pokeathlon."
    },
    [509] = {
        name = "Data Card-05",
        description = "Records the number of times the trainer has come in first in the Pokeathlon Hurdle Dash."
    },
    [510] = {
        name = "Data Card-06",
        description = "Records the number of times the trainer has come in first in the Pokeathlon Relay Run."
    },
    [511] = {
        name = "Data Card-07",
        description = "Records the number of times the trainer has come in first in the Pokeathlon Pennant Capture."
    },
    [512] = {
        name = "Data Card-08",
        description = "Records the number of times the trainer has come in first in the Pokeathlon Block Smash."
    },
    [513] = {
        name = "Data Card-09",
        description = "Records the number of times the trainer has come in first in the Pokeathlon Disc Catch."
    },
    [514] = {
        name = "Data Card-10",
        description = "Records the number of times the trainer has come in first in the Pokeathlon Snow Throw."
    },
    [515] = {
        name = "Data Card-11",
        description = "Records the number of points the trainer has earned in the Pokeathlon."
    },
    [516] = {
        name = "Data Card-12",
        description = "Records the number of times the trainer's Pok" ..
            Chars.accentedE .. "mon have messed up in the Pokeathlon."
    },
    [517] = {
        name = "Data Card-13",
        description = "Records the number of times the trainer's Pok" ..
            Chars.accentedE .. "mon have defeated themselves in the Pokeathlon."
    },
    [518] = {
        name = "Data Card-14",
        description = "Records the number of times the trainer's Pok" ..
            Chars.accentedE .. "mon have tackled in the Pokeathlon."
    },
    [519] = {
        name = "Data Card-15",
        description = "Records the number of times the trainer's Pok" ..
            Chars.accentedE .. "mon have fallen in the Pokeathlon."
    },
    [520] = {
        name = "Data Card-16",
        description = "Records the number of times the trainer has come in first in the Pokeathlon Ring Drop."
    },
    [521] = {
        name = "Data Card-17",
        description = "Records the number of times the trainer has come in first in the Pokeathlon Lamp Jump."
    },
    [522] = {
        name = "Data Card-18",
        description = "Records the number of times the trainer has come in first in the Pokeathlon Circle Push."
    },
    [523] = {
        name = "Data Card-19",
        description = "Records the number of times the trainer has come in first place overall in the Pokeathlon over wirelss."
    },
    [524] = {
        name = "Data Card-20",
        description = "Records the number of times the trainer has come in last place overall in the Pokeathlon over wireless."
    },
    [525] = {
        name = "Data Card-21",
        description = "Records the number of times the trainer has come in first across all Pokeathlon events."
    },
    [526] = {
        name = "Data Card-22",
        description = "Records the number of times the trainer has come in last across all Pokeathlon events."
    },
    [527] = {
        name = "Data Card-23",
        description = "Records the number of times the trainer has switched Pok" ..
            Chars.accentedE .. "mon in the Pokeathlon."
    },
    [528] = {
        name = "Data Card-24",
        description = "Records the number of times the trainer has come in first in the Pokeathlon Goal Roll."
    },
    [529] = {
        name = "Data Card-25",
        description = "Records the number of times the trainer's Pok" ..
            Chars.accentedE .. "mon received prizes in the Pokeathlon."
    },
    [530] = {
        name = "Data Card-26",
        description = "Records the number of times the trainer has instructed Pok" ..
            Chars.accentedE .. "mon in the Pokeathlon."
    },
    [531] = {
        name = "Data Card-27",
        description = "Records the total time spent in the Pokeathlon."
    },
    [533] = {
        name = "Lock Capsule",
        description = "Contains TM95 (Snarl)."
    },
    [501] = {
        name = "Photo Album",
        description = "Stores photos from your adventure."
    }
}

ItemData.GEN_5_ITEMS = {
    [0] = {
        name = "---",
        description = ""
    },
    [1] = {
        name = "Master Ball",
        description = "Catches a wild Pok" .. Chars.accentedE .. "mon every time."
    },
    [2] = {
        name = "Ultra Ball",
        description = "Tries to catch a wild Pokemon. Success rate is 2x."
    },
    [3] = {
        name = "Great Ball",
        description = "Tries to catch a wild Pokemon. Success rate is 1.5x."
    },
    [4] = {
        name = "Poke Ball",
        description = "Tries to catch a wild Pokemon."
    },
    [5] = {
        name = "Safari Ball",
        description = "Tries to catch a wild Pok" ..
            Chars.accentedE .. "mon in the Great Marsh or Safari Zone. Success rate is 1.5x."
    },
    [6] = {
        name = "Net Ball",
        description = "Tries to catch a wild Pokemon. Success rate is 3x for water and bug Pokemon."
    },
    [7] = {
        name = "Dive Ball",
        description = "Tries to catch a wild Pokemon. Success rate is 3.5x when underwater, fishing, or surfing."
    },
    [8] = {
        name = "Nest Ball",
        description = "Tries to catch a wild Pokemon. Success rate is 3.9x for level 1 Pokemon, and drops steadily to 1x at level 30."
    },
    [9] = {
        name = "Repeat Ball",
        description = "Tries to catch a wild Pokemon. Success rate is 3x for previously-caught Pokemon."
    },
    [10] = {
        name = "Timer Ball",
        description = "Tries to catch a wild Pokemon. Success rate increases by 0.1x (Gen V: 0.3x) every turn, to a max of 4x."
    },
    [11] = {
        name = "Luxury Ball",
        description = "Tries to catch a wild Pokemon. Caught Pok" .. Chars.accentedE .. "mon start with 200 happiness."
    },
    [12] = {
        name = "Premier Ball",
        description = "Tries to catch a wild Pokemon."
    },
    [13] = {
        name = "Dusk Ball",
        description = "Tries to catch a wild Pokemon. Success rate is 3.5x at night and in caves."
    },
    [14] = {
        name = "Heal Ball",
        description = "Tries to catch a wild Pokemon. Caught Pok" .. Chars.accentedE .. "mon are immediately healed."
    },
    [15] = {
        name = "Quick Ball",
        description = "Tries to catch a wild Pokemon. Success rate is 4x (Gen V: 5x), but only on the first turn."
    },
    [16] = {
        name = "Cherish Ball",
        description = "Tries to catch a wild Pokemon."
    },
    [17] = {
        name = "Potion",
        description = "Restores 20 HP."
    },
    [18] = {
        name = "Antidote",
        description = "Cures poison."
    },
    [19] = {
        name = "Burn Heal",
        description = "Cures a burn."
    },
    [20] = {
        name = "Ice Heal",
        description = "Cures freezing."
    },
    [21] = {
        name = "Awakening",
        description = "Cures sleep."
    },
    [22] = {
        name = "Paralyze Heal",
        description = "Cures paralysis."
    },
    [23] = {
        name = "Full Restore",
        description = "Restores HP to full and cures any status ailment and confusion."
    },
    [24] = {
        name = "Max Potion",
        description = "Restores HP to full."
    },
    [25] = {
        name = "Hyper Potion",
        description = "Restores 200 HP."
    },
    [26] = {
        name = "Super Potion",
        description = "Restores 50 HP."
    },
    [27] = {
        name = "Full Heal",
        description = "Cures any status ailment and confusion."
    },
    [28] = {
        name = "Revive",
        description = "Revives with half HP."
    },
    [29] = {
        name = "Max Revive",
        description = "Revives with full HP."
    },
    [30] = {
        name = "Fresh Water",
        description = "Restores 50 HP."
    },
    [31] = {
        name = "Soda Pop",
        description = "Restores 60 HP."
    },
    [32] = {
        name = "Lemonade",
        description = "Restores 80 HP."
    },
    [33] = {
        name = "Moomoo Milk",
        description = "Restores 100 HP."
    },
    [34] = {
        name = "Energy Powder",
        description = "Restores 50 HP, but lowers happiness."
    },
    [35] = {
        name = "Energy Root",
        description = "Restores 200 HP, but lowers happiness."
    },
    [36] = {
        name = "Heal Powder",
        description = "Cures any status ailment, but lowers happiness."
    },
    [37] = {
        name = "Revival Herb",
        description = "Revives with full HP, but lowers happiness."
    },
    [38] = {
        name = "Ether",
        description = "Restores 10 PP for one move."
    },
    [39] = {
        name = "Max Ether",
        description = "Restores PP to full for one move."
    },
    [40] = {
        name = "Elixir",
        description = "Restores 10 PP for each move."
    },
    [41] = {
        name = "Max Elixir",
        description = "Restores PP to full for each move."
    },
    [42] = {
        name = "Lava Cookie",
        description = "Cures any status ailment and confusion."
    },
    [43] = {
        name = "Berry Juice",
        description = "Restores 20 HP."
    },
    [44] = {
        name = "Sacred Ash",
        description = "Revives all fainted Pok" .. Chars.accentedE .. "mon with full HP."
    },
    [45] = {
        name = "Hp Up",
        description = "Raises HP effort and happiness."
    },
    [46] = {
        name = "Protein",
        description = "Raises Attack effort and happiness."
    },
    [47] = {
        name = "Iron",
        description = "Raises Defense effort and happiness."
    },
    [48] = {
        name = "Carbos",
        description = "Raises Speed effort and happiness."
    },
    [49] = {
        name = "Calcium",
        description = "Raises Special Attack effort and happiness."
    },
    [50] = {
        name = "Rare Candy",
        description = "Causes a level-up and raises happiness."
    },
    [51] = {
        name = "PP Up",
        description = "Raises a move's max PP by 20%."
    },
    [52] = {
        name = "Zinc",
        description = "Raises Special Defense and happiness."
    },
    [53] = {
        name = "PP Max",
        description = "Raises a move's max PP by 60%."
    },
    [54] = {
        name = "Old Gateau",
        description = "Cures any status ailment and confusion."
    },
    [55] = {
        name = "Guard Spec",
        description = "Prevents stat changes in battle for five turns in battle. Raises happiness."
    },
    [56] = {
        name = "Dire Hit",
        description = "Increases the chance of a critical hit in battle. Raises happiness."
    },
    [57] = {
        name = "X Attack",
        description = "Raises Attack by one stage in battle. Raises happiness."
    },
    [58] = {
        name = "X Defense",
        description = "Raises Defense by one stage in battle. Raises happiness."
    },
    [59] = {
        name = "X Speed",
        description = "Raises Speed by one stage in battle. Raises happiness."
    },
    [60] = {
        name = "X Accuracy",
        description = "Raises accuracy by one stage in battle. Raises happiness."
    },
    [61] = {
        name = "X Sp-atk",
        description = "Raises Special Attack by one stage in battle. Raises happiness."
    },
    [62] = {
        name = "X Sp-def",
        description = "Raises Special Defense by one stage in battle. Raises happiness."
    },
    [63] = {
        name = "Poke Doll",
        description = "Ends a wild battle."
    },
    [64] = {
        name = "Fluffy Tail",
        description = "Ends a wild battle."
    },
    [65] = {
        name = "Blue Flute",
        description = "Cures sleep."
    },
    [66] = {
        name = "Yellow Flute",
        description = "Cures confusion."
    },
    [67] = {
        name = "Red Flute",
        description = "Cures attraction."
    },
    [68] = {
        name = "Black Flute",
        description = "Halves the wild Pok" .. Chars.accentedE .. "mon encounter rate."
    },
    [69] = {
        name = "White Flute",
        description = "Doubles the wild Pok" .. Chars.accentedE .. "mon encounter rate."
    },
    [70] = {
        name = "Shoal Salt",
        description = "No effect. "
    },
    [71] = {
        name = "Shoal Shell",
        description = "No effect. "
    },
    [72] = {
        name = "Red Shard",
        description = "No effect. Can be traded for items or moves."
    },
    [73] = {
        name = "Blue Shard",
        description = "No effect. Can be traded for items or moves."
    },
    [74] = {
        name = "Yellow Shard",
        description = "No effect. Can be traded for items or moves."
    },
    [75] = {
        name = "Green Shard",
        description = "No effect. Can be traded for items or moves."
    },
    [76] = {
        name = "Super Repel",
        description = "For 200 steps, prevents wild encounters of level lower than your party's lead Pokemon."
    },
    [77] = {
        name = "Max Repel",
        description = "For 250 steps, prevents wild encounters of level lower than your party's lead Pokemon."
    },
    [78] = {
        name = "Escape Rope",
        description = "Transports user to the outside entrance of a cave."
    },
    [79] = {
        name = "Repel",
        description = "For 100 steps, prevents wild encounters of level lower than your party's lead Pokemon."
    },
    [80] = {
        name = "Sun Stone",
        description = "Evolves a Cottonee into Whimsicott, a Gloom into Bellossom, a Petilil into Lilligant, or a Sunkern into Sunflora."
    },
    [81] = {
        name = "Moon Stone",
        description = "Evolves a Clefairy into Clefable, a Jigglypuff into Wigglytuff, a Munna into Musharna, a Nidorina into Nidoqueen, a Nidorino into Nidoking, or a Skitty into Delcatty."
    },
    [82] = {
        name = "Fire Stone",
        description = "Evolves an Eevee into Flareon, a Growlithe into Arcanine, a Pansear into Simisear, or a Vulpix into Ninetales."
    },
    [83] = {
        name = "Thunder Stone",
        description = "Evolves an Eelektrik into Eelektross, an Eevee into Jolteon, or a Pikachu into Raichu."
    },
    [84] = {
        name = "Water Stone",
        description = "Evolves an Eevee into Vaporeon, a Lombre into Ludicolo, a Panpour into Simipour, a Poliwhirl into Poliwrath, a Shellder into Cloyster, or a Staryu into Starmie."
    },
    [85] = {
        name = "Leaf Stone",
        description = "Evolves an Exeggcute into Exeggutor, a Gloom into Vileplume, a Nuzleaf into Shiftry, a Pansage into Simisage, or a Weepinbell into Victreebel."
    },
    [86] = {
        name = "Tiny Mushroom",
        description = "Fire Red and Leaf Green: Trade two for prior Level-up moves. Sell for 250 Pokedollars, or to Hungry Maid for 500 Pokedollars."
    },
    [87] = {
        name = "Big Mushroom",
        description = "Fire Red and Leaf Green: Trade for prior Level-up moves. Sell for 2500 Pokedollars, or to Hungry Maid for 5000 Pokedollars."
    },
    [88] = {
        name = "Pearl",
        description = "Sell for 700 Pokedollars, or to Ore Collector for 1400 Pokedollars."
    },
    [89] = {
        name = "Big Pearl",
        description = "Sell for 3750 Pokedollars, or to Ore Collector for 7500 Pokedollars."
    },
    [90] = {
        name = "Stardust",
        description = "Sell for 1000 Pokedollars, or to Ore Collector for 2000 Pokedollars."
    },
    [91] = {
        name = "Star Piece",
        description = "Platinum: Trade for one of each color Shard. Black and White: Trade for PP Up. Sell for 4900 Pokedollars, or to Ore Collector for 9800 Pokedollars."
    },
    [92] = {
        name = "Nugget",
        description = "Sell for 5000 Pokedollars, or to Ore Collector for 10000 Pokedollars."
    },
    [93] = {
        name = "Heart Scale",
        description = "No effect. Can be traded for prior Level-up moves."
    },
    [94] = {
        name = "Honey",
        description = "Used to attract Wild Pok" .. Chars.accentedE .. "mon."
    },
    [95] = {
        name = "Growth Mulch",
        description = "Growing time of berries is reduced, but the soil dries out faster."
    },
    [96] = {
        name = "Damp Mulch",
        description = "Growing time of berries is increased, but the soil dries out slower."
    },
    [97] = {
        name = "Stable Mulch",
        description = "Berries stay on the plant for longer than their usual time."
    },
    [98] = {
        name = "Gooey Mulch",
        description = "Berries regrow from dead plants an increased number of times."
    },
    [99] = {
        name = "Root Fossil",
        description = "Can be revived into a Lileep."
    },
    [100] = {
        name = "Claw Fossil",
        description = "Can be revived into an Anorith."
    },
    [101] = {
        name = "Helix Fossil",
        description = "Can be revived into an Omanyte."
    },
    [102] = {
        name = "Dome Fossil",
        description = "Can be revived into a Kabuto."
    },
    [103] = {
        name = "Old Amber",
        description = "Can be revived into an Aerodactyl."
    },
    [104] = {
        name = "Armor Fossil",
        description = "Can be revived into a Shieldon."
    },
    [105] = {
        name = "Skull Fossil",
        description = "Can be revived into a Cranidos."
    },
    [106] = {
        name = "Rare Bone",
        description = "Sell for 5000 Pokedollars, or to Bone Man for 10000 Pokedollars."
    },
    [107] = {
        name = "Shiny Stone",
        description = "Evolves a Minccino into Cinccino, a Roselia into Roserade, or a Togetic into Togekiss."
    },
    [108] = {
        name = "Dusk Stone",
        description = "Evolves a Lampent into Chandelure, a Misdreavus into Mismagius, or a Murkrow into Honchkrow."
    },
    [109] = {
        name = "Dawn Stone",
        description = "Evolves a male Kirlia into Gallade or a female Snorunt into Froslass."
    },
    [110] = {
        name = "Oval Stone",
        description = "Level-up during Day on a Happiny: Holder evolves into Chansey."
    },
    [111] = {
        name = "Odd Keystone",
        description = "Use on the tower on Route 209 to encounter Spiritomb if you have at least 32 Underground greetings."
    },
    [135] = {
        name = "Adamant Orb",
        description = "Boosts the damage from Dialga's Dragon-type and Steel-type moves by 20%."
    },
    [136] = {
        name = "Lustrous Orb",
        description = "Boosts the damage from Palkia's Dragon-type and Water-type moves by 20%."
    },
    [149] = {
        name = "Cheri Berry",
        description = "Consumed when paralyzed to cure paralysis."
    },
    [150] = {
        name = "Chesto Berry",
        description = "Consumed when asleep to cure sleep."
    },
    [151] = {
        name = "Pecha Berry",
        description = "Consumed when poisoned to cure poison."
    },
    [152] = {
        name = "Rawst Berry",
        description = "Consumed when burned to cure a burn."
    },
    [153] = {
        name = "Aspear Berry",
        description = "Consumed when frozen to cure frozen."
    },
    [154] = {
        name = "Leppa Berry",
        description = "Consumed when a move runs out of PP to restore its PP by 10."
    },
    [155] = {
        name = "Oran Berry",
        description = "Consumed at 1/2 max HP to recover 10 HP."
    },
    [156] = {
        name = "Persim Berry",
        description = "Consumed when confused to cure confusion."
    },
    [157] = {
        name = "Lum Berry",
        description = "Consumed to cure any status condition or confusion."
    },
    [158] = {
        name = "Sitrus Berry",
        description = "Consumed at 1/2 max HP to recover 1/4 max HP."
    },
    [159] = {
        name = "Figy Berry",
        description = "Consumed at 1/2 max HP to restore 1/8 max HP. Confuses Pok" ..
            Chars.accentedE .. "mon that dislike spicy flavor."
    },
    [160] = {
        name = "Wiki Berry",
        description = "Consumed at 1/2 max HP to restore 1/8 max HP. Confuses Pok" ..
            Chars.accentedE .. "mon that dislike dry flavor."
    },
    [161] = {
        name = "Mago Berry",
        description = "Consumed at 1/2 max HP to restore 1/8 max HP. Confuses Pok" ..
            Chars.accentedE .. "mon that dislike sweet flavor."
    },
    [162] = {
        name = "Aguav Berry",
        description = "Consumed at 1/2 max HP to restore 1/8 max HP. Confuses Pok" ..
            Chars.accentedE .. "mon that dislike bitter flavor."
    },
    [163] = {
        name = "Iapapa Berry",
        description = "Consumed at 1/2 max HP to restore 1/8 max HP. Confuses Pok" ..
            Chars.accentedE .. "mon that dislike sour flavor."
    },
    [164] = {
        name = "Razz Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [165] = {
        name = "Bluk Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [166] = {
        name = "Nanab Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [167] = {
        name = "Wepear Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [168] = {
        name = "Pinap Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [169] = {
        name = "Pomeg Berry",
        description = "Drops HP Effort Values by 10 and raises happiness."
    },
    [170] = {
        name = "Kelpsy Berry",
        description = "Drops Attack Effort Values by 10 and raises happiness."
    },
    [171] = {
        name = "Qualot Berry",
        description = "Drops Defense Effort Values by 10 and raises happiness."
    },
    [172] = {
        name = "Hondew Berry",
        description = "Drops Special Attack Effort Values by 10 and raises happiness."
    },
    [173] = {
        name = "Grepa Berry",
        description = "Drops Special Defense Effort Values by 10 and raises happiness."
    },
    [174] = {
        name = "Tamato Berry",
        description = "Drops Speed Effort Values by 10 and raises happiness."
    },
    [175] = {
        name = "Cornn Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [176] = {
        name = "Magost Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [177] = {
        name = "Rabuta Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [178] = {
        name = "Nomel Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [179] = {
        name = "Spelon Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [180] = {
        name = "Pamtre Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [181] = {
        name = "Watmel Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [182] = {
        name = "Durin Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [183] = {
        name = "Belue Berry",
        description = "Used for creating PokeBlocks and Poffins."
    },
    [184] = {
        name = "Occa Berry",
        description = "Consumed when struck by a super-effective Fire-type attack to halve the damage."
    },
    [185] = {
        name = "Passho Berry",
        description = "Consumed when struck by a super-effective Water-type attack to halve the damage."
    },
    [186] = {
        name = "Wacan Berry",
        description = "Consumed when struck by a super-effective Electric-type attack to halve the damage."
    },
    [187] = {
        name = "Rindo Berry",
        description = "Consumed when struck by a super-effective Grass-type attack to halve the damage."
    },
    [188] = {
        name = "Yache Berry",
        description = "Consumed when struck by a super-effective Ice-type attack to halve the damage."
    },
    [189] = {
        name = "Chople Berry",
        description = "Consumed when struck by a super-effective Fighting-type attack to halve the damage."
    },
    [190] = {
        name = "Kebia Berry",
        description = "Consumed when struck by a super-effective Poison-type attack to halve the damage."
    },
    [191] = {
        name = "Shuca Berry",
        description = "Consumed when struck by a super-effective Ground-type attack to halve the damage."
    },
    [192] = {
        name = "Coba Berry",
        description = "Consumed when struck by a super-effective Flying-type attack to halve the damage."
    },
    [193] = {
        name = "Payapa Berry",
        description = "Consumed when struck by a super-effective Psychic-type attack to halve the damage."
    },
    [194] = {
        name = "Tanga Berry",
        description = "Consumed when struck by a super-effective Bug-type attack to halve the damage."
    },
    [195] = {
        name = "Charti Berry",
        description = "Consumed when struck by a super-effective Rock-type attack to halve the damage."
    },
    [196] = {
        name = "Kasib Berry",
        description = "Consumed when struck by a super-effective Ghost-type attack to halve the damage."
    },
    [197] = {
        name = "Haban Berry",
        description = "Consumed when struck by a super-effective Dragon-type attack to halve the damage."
    },
    [198] = {
        name = "Colbur Berry",
        description = "Consumed when struck by a super-effective Dark-type attack to halve the damage."
    },
    [199] = {
        name = "Babiri Berry",
        description = "Consumed when struck by a super-effective Steel-type attack to halve the damage."
    },
    [200] = {
        name = "Chilan Berry",
        description = "Consumed when struck by a Normal-type attack to halve the damage."
    },
    [201] = {
        name = "Liechi Berry",
        description = "Consumed at 1/4 max HP to boost Attack."
    },
    [202] = {
        name = "Ganlon Berry",
        description = "Consumed at 1/4 max HP to boost Defense."
    },
    [203] = {
        name = "Salac Berry",
        description = "Consumed at 1/4 max HP to boost Speed."
    },
    [204] = {
        name = "Petaya Berry",
        description = "Consumed at 1/4 max HP to boost Special Attack."
    },
    [205] = {
        name = "Apicot Berry",
        description = "Consumed at 1/4 max HP to boost Special Defense."
    },
    [206] = {
        name = "Lansat Berry",
        description = "Consumed at 1/4 max HP to boost critical hit ratio by two stages."
    },
    [207] = {
        name = "Starf Berry",
        description = "Consumed at 1/4 max HP to boost a random stat by two stages."
    },
    [208] = {
        name = "Enigma Berry",
        description = "Consumed when struck by a super-effective attack to restore 1/4 max HP."
    },
    [209] = {
        name = "Micle Berry",
        description = "Consumed at 1/4 max HP to boost accuracy of next move by 20%."
    },
    [210] = {
        name = "Custap Berry",
        description = "Consumed at 1/4 max HP when using a move to go first."
    },
    [211] = {
        name = "Jaboca Berry",
        description = "Consumed to deal 1/8 attacker's max HP when holder is struck by a physical attack."
    },
    [212] = {
        name = "Rowap Berry",
        description = "Consumed to deal 1/8 attacker's max HP when holder is struck by a special attack."
    },
    [213] = {
        name = "BrightPowder",
        description = "Increases the holder's evasion by 1/9 (11 1/9%)."
    },
    [214] = {
        name = "White Herb",
        description = "Resets all lowered stats to normal at end of turn. Consumed after use."
    },
    [215] = {
        name = "Macho Brace",
        description = "Holder gains double effort values from battles, but has halved Speed in battle."
    },
    [216] = {
        name = "Exp Share",
        description = "Half the experience from a battle is split between Pok" .. Chars.accentedE .. "mon holding this item."
    },
    [217] = {
        name = "Quick Claw",
        description = "Holder has a 3/16 (18.75%) chance to move first."
    },
    [218] = {
        name = "Soothe Bell",
        description = "Doubles the happiness earned by the holder."
    },
    [219] = {
        name = "Mental Herb",
        description = "Consumed to cure infatuation. Gen V: Also removes Taunt, Encore, Torment, Disable, and Cursed Body."
    },
    [220] = {
        name = "Choice Band",
        description = "Increases Attack by 50%, but restricts the holder to only one move."
    },
    [221] = {
        name = "King's Rock",
        description = "Damaging moves gain a 10% chance to make their target flinch. Traded on a Poliwhirl: Holder evolves into Politoed. Traded on a Slowpoke: Holder evolves into Slowking."
    },
    [222] = {
        name = "Silver Powder",
        description = "Bug-Type moves from holder do 20% more damage."
    },
    [223] = {
        name = "Amulet Coin",
        description = "Doubles the money earned from a battle. Does not stack with Luck Incense."
    },
    [224] = {
        name = "Cleanse Tag",
        description = "Prevents wild encounters of level lower than your party's lead Pokemon."
    },
    [225] = {
        name = "Soul Dew",
        description = "Raises Latias and Latios's Special Attack and Special Defense by 50%."
    },
    [226] = {
        name = "Deep Sea-tooth",
        description = "Doubles Clamperl's Special Attack. Traded on a Clamperl: Holder evolves into Huntail."
    },
    [227] = {
        name = "Deep Sea-scale",
        description = "Doubles Clamperl's Special Defense. Traded on a Clamperl: Holder evolves into Gorebyss."
    },
    [228] = {
        name = "Smoke Ball",
        description = "Allows the Holder to escape from any wild battle."
    },
    [229] = {
        name = "Everstone",
        description = "Prevents level-based evolution from occuring."
    },
    [230] = {
        name = "Focus Band",
        description = "Holder has 10% chance to survive attacks or self-inflicted damage at 1 HP."
    },
    [231] = {
        name = "Lucky Egg",
        description = "Increases EXP earned in battle by 50%."
    },
    [232] = {
        name = "Scope Lens",
        description = "Raises the holder's critical hit ratio by one stage."
    },
    [233] = {
        name = "Metal Coat",
        description = "Steel-Type moves from holder do 20% more damage."
    },
    [234] = {
        name = "Leftovers",
        description = "Restores 1/16 (6.25%) holder's max HP at the end of each turn."
    },
    [235] = {
        name = "Dragon Scale",
        description = "Traded on a Seadra: Holder evolves into Kingdra."
    },
    [236] = {
        name = "Light Ball",
        description = "Doubles Pikachu's Attack and Special Attack. Breed on Pikachu or Raichu: Pichu Egg will have Volt Tackle."
    },
    [237] = {
        name = "Soft Sand",
        description = "Ground-Type moves from holder do 20% more damage."
    },
    [238] = {
        name = "Hard Stone",
        description = "Rock-Type moves from holder do 20% more damage."
    },
    [239] = {
        name = "Miracle Seed",
        description = "Grass-Type moves from holder do 20% more damage."
    },
    [240] = {
        name = "BlackGlasses",
        description = "Dark-Type moves from holder do 20% more damage."
    },
    [241] = {
        name = "Black Belt",
        description = "Fighting-Type moves from holder do 20% more damage."
    },
    [242] = {
        name = "Magnet",
        description = "Electric-Type moves from holder do 20% more damage."
    },
    [243] = {
        name = "Mystic Water",
        description = "Water-Type moves from holder do 20% more damage."
    },
    [244] = {
        name = "Sharp Beak",
        description = "Flying-Type moves from holder do 20% more damage."
    },
    [245] = {
        name = "Poison Barb",
        description = "Poison-Type moves from holder do 20% more damage."
    },
    [246] = {
        name = "Never Melt-ice",
        description = "Ice-Type moves from holder do 20% more damage."
    },
    [247] = {
        name = "Spell Tag",
        description = "Ghost-Type moves from holder do 20% more damage."
    },
    [248] = {
        name = "Twisted Spoon",
        description = "Psychic-Type moves from holder do 20% more damage."
    },
    [249] = {
        name = "Charcoal",
        description = "Fire-Type moves from holder do 20% more damage."
    },
    [250] = {
        name = "Dragon Fang",
        description = "Dragon-Type moves from holder do 20% more damage."
    },
    [251] = {
        name = "Silk Scarf",
        description = "Normal-Type moves from holder do 20% more damage."
    },
    [252] = {
        name = "Up Grade",
        description = "Traded on a Porygon: Holder evolves into Porygon2."
    },
    [253] = {
        name = "Shell Bell",
        description = "Holder receives 1/8 of the damage it deals when attacking."
    },
    [254] = {
        name = "Sea Incense",
        description = "Water-Type moves from holder do 20% more damage. Breeding: Marill or Azumarill beget an Azurill Egg."
    },
    [255] = {
        name = "Lax Incense",
        description = "Holder's evasion is increased by 5%. Breeding: Wobbuffet begets a Wynaut Egg."
    },
    [256] = {
        name = "Lucky Punch",
        description = "Raises Chansey's critical hit ratio by two stages."
    },
    [257] = {
        name = "Metal Powder",
        description = "Raises Ditto's Defense and Special Defense by 50%. The boost is lost after transforming."
    },
    [258] = {
        name = "Thick Club",
        description = "Doubles Cubone or Marowak's Attack."
    },
    [259] = {
        name = "Stick",
        description = "Raises Farfetch'd's critical hit ratio by two stages."
    },
    [260] = {
        name = "Red Scarf",
        description = "Raises the holder's Coolness while in a contest."
    },
    [261] = {
        name = "Blue Scarf",
        description = "Raises the holder's Beauty while in a contest."
    },
    [262] = {
        name = "Pink Scarf",
        description = "Raises the holder's Cuteness while in a contest."
    },
    [263] = {
        name = "Green Scarf",
        description = "Raises the holder's Smartness while in a contest."
    },
    [264] = {
        name = "Yellow Scarf",
        description = "Raises the holder's Toughness while in a contest."
    },
    [265] = {
        name = "Wide Lens",
        description = "Provides a 1/10 (10%) boost in accuracy to the holder."
    },
    [266] = {
        name = "Muscle Band",
        description = "Boosts the damage of physical moves used by the holder by 10%."
    },
    [267] = {
        name = "Wise Glasses",
        description = "Boosts the damage of special moves used by the holder by 1/10 (10%)."
    },
    [268] = {
        name = "Expert Belt",
        description = "Holder's Super Effective moves do 20% extra damage."
    },
    [269] = {
        name = "Light Clay",
        description = "Light Screen and Reflect used by the holder last 8 rounds instead of 5."
    },
    [270] = {
        name = "Life Orb",
        description = "Holder's moves inflict 30% extra damage, but cost 10% max HP."
    },
    [271] = {
        name = "Power Herb",
        description = "Both turns of a two-turn charge move happen at once. Consumed upon use."
    },
    [272] = {
        name = "Toxic Orb",
        description = "Inflicts Toxic on the holder at the end of the turn. Activates after Poison damage would occur."
    },
    [273] = {
        name = "Flame Orb",
        description = "Inflicts Burn on the holder at the end of the turn. Activates after Burn damage would occur."
    },
    [274] = {
        name = "Quick Powder",
        description = "Doubles Ditto's Speed when held. The boost is lost after transforming."
    },
    [275] = {
        name = "Focus Sash",
        description = "Holder survives any single-hit attack at 1 HP if at max HP, then the item is consumed."
    },
    [276] = {
        name = "Zoom Lens",
        description = "Provides a 1/5 (20%) boost in accuracy if the holder moves after the target."
    },
    [277] = {
        name = "Metronome",
        description = "Consectutive uses of the same attack have a cumulative damage boost of 10%. Maximum 100% boost."
    },
    [278] = {
        name = "Iron Ball",
        description = "Holder's Speed is halved. Negates all Ground-type immunities, and makes Flying-types take neutral damage from Ground-type moves. Arena Trap. Spikes, and Toxic Spikes affect the holder."
    },
    [279] = {
        name = "Lagging Tail",
        description = "Holder moves last in its priority bracket."
    },
    [280] = {
        name = "Destiny Knot",
        description = "Infatuates opposing Pok" .. Chars.accentedE .. "mon when holder is inflicted with infatuation."
    },
    [281] = {
        name = "Black Sludge",
        description = "Poison-type holder recovers 1/16 (6.25%) max HP each turn. Non-Poison-Types take 1/8 (12.5%) max HP damage."
    },
    [282] = {
        name = "Icy Rock",
        description = "Hail by the holder lasts 8 rounds instead of 5."
    },
    [283] = {
        name = "Smooth Rock",
        description = "Sandstorm by the holder lasts 8 rounds instead of 5."
    },
    [284] = {
        name = "Heat Rock",
        description = "Sunny Day by the holder lasts 8 rounds instead of 5."
    },
    [285] = {
        name = "Damp Rock",
        description = "Rain Dance by the holder lasts 8 rounds instead of 5."
    },
    [286] = {
        name = "Grip Claw",
        description = "Holder's multi-turn trapping moves last 5 turns."
    },
    [287] = {
        name = "Choice Scarf",
        description = "Increases Speed by 50%, but restricts the holder to only one move."
    },
    [288] = {
        name = "Sticky Barb",
        description = "Holder takes 1/8 (12.5%) its max HP at the end of each turn. When the holder is hit by a contact move, the attacking Pok" ..
            Chars.accentedE .. "mon takes 1/8 its max HP in damage and receive the item if not holding one."
    },
    [289] = {
        name = "Power Bracer",
        description = "Holder gains 4 Attack effort values, but has halved Speed in battle."
    },
    [290] = {
        name = "Power Belt",
        description = "Holder gains 4 Defense effort values, but has halved Speed in battle."
    },
    [291] = {
        name = "Power Lens",
        description = "Holder gains 4 Special Attack effort values, but has halved Speed in battle."
    },
    [292] = {
        name = "Power Band",
        description = "Holder gains 4 Special Defense effort values, but has halved Speed in battle."
    },
    [293] = {
        name = "Power Anklet",
        description = "Holder gains 4 Speed effort values, but has halved Speed in battle."
    },
    [294] = {
        name = "Power Weight",
        description = "Holder gains 4 HP effort values, but has halved Speed in battle."
    },
    [295] = {
        name = "Shed Shell",
        description = "Holder can bypass all trapping effects and switch out. Multi-turn moves still cannot be switched out of."
    },
    [296] = {
        name = "Big Root",
        description = "Increases HP recovered from draining moves, Ingrain, and Aqua Ring by 3/10 (30%)."
    },
    [297] = {
        name = "Choice Specs",
        description = "Increases Special Attack by 50%, but restricts the holder to only one move."
    },
    [298] = {
        name = "Flame Plate",
        description = "Fire-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Fire."
    },
    [299] = {
        name = "Splash Plate",
        description = "Water-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Water."
    },
    [300] = {
        name = "Zap Plate",
        description = "Electric-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Electric."
    },
    [301] = {
        name = "Meadow Plate",
        description = "Grass-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Grass."
    },
    [302] = {
        name = "Icicle Plate",
        description = "Ice-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Ice."
    },
    [303] = {
        name = "Fist Plate",
        description = "Fighting-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Fighting."
    },
    [304] = {
        name = "Toxic Plate",
        description = "Posion-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Posion."
    },
    [305] = {
        name = "Earth Plate",
        description = "Ground-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Ground."
    },
    [306] = {
        name = "Sky Plate",
        description = "Flying-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Flying."
    },
    [307] = {
        name = "Mind Plate",
        description = "Psychic-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Psychic."
    },
    [308] = {
        name = "Insect Plate",
        description = "Bug-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Bug."
    },
    [309] = {
        name = "Stone Plate",
        description = "Rock-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Rock."
    },
    [310] = {
        name = "Spooky Plate",
        description = "Ghost-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Ghost."
    },
    [311] = {
        name = "Draco Plate",
        description = "Dragon-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Dragon."
    },
    [312] = {
        name = "Dread Plate",
        description = "Dark-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Dark."
    },
    [313] = {
        name = "Iron Plate",
        description = "Steel-Type moves from holder do 20% more damage. Changes Arceus's and Judgment's type to Steel."
    },
    [314] = {
        name = "Odd Incense",
        description = "Psychic-Type moves from holder do 20% more damage. Breeding: Mr. Mime begets a Mime Jr. Egg."
    },
    [315] = {
        name = "Rock Incense",
        description = "Rock-Type moves from holder do 20% more damage. Breeding: Sudowoodo begets a Bonsly Egg."
    },
    [316] = {
        name = "Full Incense",
        description = "Holder moves last in its priority bracket. Breeding: Snorlax begets a Munchlax Egg."
    },
    [317] = {
        name = "Wave Incense",
        description = "Water-Type moves from holder do 20% more damage. Breeding: Mantine begets a Mantyke Egg."
    },
    [318] = {
        name = "Rose Incense",
        description = "Grass-Type moves from holder do 20% more damage. Breeding: Roselia or Roserade beget a Budew Egg."
    },
    [319] = {
        name = "Luck Incense",
        description = "Doubles the money earned from a battle. Does not stack with Amulet Coin. Breeding: Chansey and Blissey beget a Happiny Egg."
    },
    [320] = {
        name = "Pure Incense",
        description = "Prevents wild encounters of level lower than your party's lead Pokemon. Breeding: Chimecho begets a Chingling Egg."
    },
    [321] = {
        name = "Protector",
        description = "Traded on a Rhydon: Holder evolves into Rhyperior."
    },
    [322] = {
        name = "Electirizer",
        description = "Traded on an Electabuzz: Holder evolves into Electivire."
    },
    [323] = {
        name = "Magmarizer",
        description = "Traded on a Magmar: Holder evolves into Magmortar."
    },
    [324] = {
        name = "Dubious Disc",
        description = "Traded on a Porygon2: Holder evolves into Porygon-Z."
    },
    [325] = {
        name = "Reaper Cloth",
        description = "Traded on a Dusclops: Holder evolves into Dusknoir."
    },
    [326] = {
        name = "Razor Claw",
        description = "Raises the holder's critical hit ratio by one stage. Held by a Sneasel while levelling up at night: Holder evolves into Weavile."
    },
    [327] = {
        name = "Razor Fang",
        description = "Damaging moves gain a 10% chance to make their target flinch. Held by a Gligar while levelling up: Holder evolves into Gliscor."
    },
    [328] = {
        name = "TM01",
        description = "Teaches a move to a compatible Pokemon."
    },
    [329] = {
        name = "TM02",
        description = "Teaches a move to a compatible Pokemon."
    },
    [330] = {
        name = "TM03",
        description = "Teaches a move to a compatible Pokemon."
    },
    [331] = {
        name = "TM04",
        description = "Teaches a move to a compatible Pokemon."
    },
    [332] = {
        name = "TM05",
        description = "Teaches a move to a compatible Pokemon."
    },
    [333] = {
        name = "TM06",
        description = "Teaches a move to a compatible Pokemon."
    },
    [334] = {
        name = "TM07",
        description = "Teaches a move to a compatible Pokemon."
    },
    [335] = {
        name = "TM08",
        description = "Teaches a move to a compatible Pokemon."
    },
    [336] = {
        name = "TM09",
        description = "Teaches a move to a compatible Pokemon."
    },
    [337] = {
        name = "TM10",
        description = "Teaches a move to a compatible Pokemon."
    },
    [338] = {
        name = "TM11",
        description = "Teaches a move to a compatible Pokemon."
    },
    [339] = {
        name = "TM12",
        description = "Teaches a move to a compatible Pokemon."
    },
    [340] = {
        name = "TM13",
        description = "Teaches a move to a compatible Pokemon."
    },
    [341] = {
        name = "TM14",
        description = "Teaches a move to a compatible Pokemon."
    },
    [342] = {
        name = "TM15",
        description = "Teaches a move to a compatible Pokemon."
    },
    [343] = {
        name = "TM16",
        description = "Teaches a move to a compatible Pokemon."
    },
    [344] = {
        name = "TM17",
        description = "Teaches a move to a compatible Pokemon."
    },
    [345] = {
        name = "TM18",
        description = "Teaches a move to a compatible Pokemon."
    },
    [346] = {
        name = "TM19",
        description = "Teaches a move to a compatible Pokemon."
    },
    [347] = {
        name = "TM20",
        description = "Teaches a move to a compatible Pokemon."
    },
    [348] = {
        name = "TM21",
        description = "Teaches a move to a compatible Pokemon."
    },
    [349] = {
        name = "TM22",
        description = "Teaches a move to a compatible Pokemon."
    },
    [350] = {
        name = "TM23",
        description = "Teaches a move to a compatible Pokemon."
    },
    [351] = {
        name = "TM24",
        description = "Teaches a move to a compatible Pokemon."
    },
    [352] = {
        name = "TM25",
        description = "Teaches a move to a compatible Pokemon."
    },
    [353] = {
        name = "TM26",
        description = "Teaches a move to a compatible Pokemon."
    },
    [354] = {
        name = "TM27",
        description = "Teaches a move to a compatible Pokemon."
    },
    [355] = {
        name = "TM28",
        description = "Teaches a move to a compatible Pokemon."
    },
    [356] = {
        name = "TM29",
        description = "Teaches a move to a compatible Pokemon."
    },
    [357] = {
        name = "TM30",
        description = "Teaches a move to a compatible Pokemon."
    },
    [358] = {
        name = "TM31",
        description = "Teaches a move to a compatible Pokemon."
    },
    [359] = {
        name = "TM32",
        description = "Teaches a move to a compatible Pokemon."
    },
    [360] = {
        name = "TM33",
        description = "Teaches a move to a compatible Pokemon."
    },
    [361] = {
        name = "TM34",
        description = "Teaches a move to a compatible Pokemon."
    },
    [362] = {
        name = "TM35",
        description = "Teaches a move to a compatible Pokemon."
    },
    [363] = {
        name = "TM36",
        description = "Teaches a move to a compatible Pokemon."
    },
    [364] = {
        name = "TM37",
        description = "Teaches a move to a compatible Pokemon."
    },
    [365] = {
        name = "TM38",
        description = "Teaches a move to a compatible Pokemon."
    },
    [366] = {
        name = "TM39",
        description = "Teaches a move to a compatible Pokemon."
    },
    [367] = {
        name = "TM40",
        description = "Teaches a move to a compatible Pokemon."
    },
    [368] = {
        name = "TM41",
        description = "Teaches a move to a compatible Pokemon."
    },
    [369] = {
        name = "TM42",
        description = "Teaches a move to a compatible Pokemon."
    },
    [370] = {
        name = "TM43",
        description = "Teaches a move to a compatible Pokemon."
    },
    [371] = {
        name = "TM44",
        description = "Teaches a move to a compatible Pokemon."
    },
    [372] = {
        name = "TM45",
        description = "Teaches a move to a compatible Pokemon."
    },
    [373] = {
        name = "TM46",
        description = "Teaches a move to a compatible Pokemon."
    },
    [374] = {
        name = "TM47",
        description = "Teaches a move to a compatible Pokemon."
    },
    [375] = {
        name = "TM48",
        description = "Teaches a move to a compatible Pokemon."
    },
    [376] = {
        name = "TM49",
        description = "Teaches a move to a compatible Pokemon."
    },
    [377] = {
        name = "TM50",
        description = "Teaches a move to a compatible Pokemon."
    },
    [378] = {
        name = "TM51",
        description = "Teaches a move to a compatible Pokemon."
    },
    [379] = {
        name = "TM52",
        description = "Teaches a move to a compatible Pokemon."
    },
    [380] = {
        name = "TM53",
        description = "Teaches a move to a compatible Pokemon."
    },
    [381] = {
        name = "TM54",
        description = "Teaches a move to a compatible Pokemon."
    },
    [382] = {
        name = "TM55",
        description = "Teaches a move to a compatible Pokemon."
    },
    [383] = {
        name = "TM56",
        description = "Teaches a move to a compatible Pokemon."
    },
    [384] = {
        name = "TM57",
        description = "Teaches a move to a compatible Pokemon."
    },
    [385] = {
        name = "TM58",
        description = "Teaches a move to a compatible Pokemon."
    },
    [386] = {
        name = "TM59",
        description = "Teaches a move to a compatible Pokemon."
    },
    [387] = {
        name = "TM60",
        description = "Teaches a move to a compatible Pokemon."
    },
    [388] = {
        name = "TM61",
        description = "Teaches a move to a compatible Pokemon."
    },
    [389] = {
        name = "TM62",
        description = "Teaches a move to a compatible Pokemon."
    },
    [390] = {
        name = "TM63",
        description = "Teaches a move to a compatible Pokemon."
    },
    [391] = {
        name = "TM64",
        description = "Teaches a move to a compatible Pokemon."
    },
    [392] = {
        name = "TM65",
        description = "Teaches a move to a compatible Pokemon."
    },
    [393] = {
        name = "TM66",
        description = "Teaches a move to a compatible Pokemon."
    },
    [394] = {
        name = "TM67",
        description = "Teaches a move to a compatible Pokemon."
    },
    [395] = {
        name = "TM68",
        description = "Teaches a move to a compatible Pokemon."
    },
    [396] = {
        name = "TM69",
        description = "Teaches a move to a compatible Pokemon."
    },
    [397] = {
        name = "TM70",
        description = "Teaches a move to a compatible Pokemon."
    },
    [398] = {
        name = "TM71",
        description = "Teaches a move to a compatible Pokemon."
    },
    [399] = {
        name = "TM72",
        description = "Teaches a move to a compatible Pokemon."
    },
    [400] = {
        name = "TM73",
        description = "Teaches a move to a compatible Pokemon."
    },
    [401] = {
        name = "TM74",
        description = "Teaches a move to a compatible Pokemon."
    },
    [402] = {
        name = "TM75",
        description = "Teaches a move to a compatible Pokemon."
    },
    [403] = {
        name = "TM76",
        description = "Teaches a move to a compatible Pokemon."
    },
    [404] = {
        name = "TM77",
        description = "Teaches a move to a compatible Pokemon."
    },
    [405] = {
        name = "TM78",
        description = "Teaches a move to a compatible Pokemon."
    },
    [406] = {
        name = "TM79",
        description = "Teaches a move to a compatible Pokemon."
    },
    [407] = {
        name = "TM80",
        description = "Teaches a move to a compatible Pokemon."
    },
    [408] = {
        name = "TM81",
        description = "Teaches a move to a compatible Pokemon."
    },
    [409] = {
        name = "TM82",
        description = "Teaches a move to a compatible Pokemon."
    },
    [410] = {
        name = "TM83",
        description = "Teaches a move to a compatible Pokemon."
    },
    [411] = {
        name = "TM84",
        description = "Teaches a move to a compatible Pokemon."
    },
    [412] = {
        name = "TM85",
        description = "Teaches a move to a compatible Pokemon."
    },
    [413] = {
        name = "TM86",
        description = "Teaches a move to a compatible Pokemon."
    },
    [414] = {
        name = "TM87",
        description = "Teaches a move to a compatible Pokemon."
    },
    [415] = {
        name = "TM88",
        description = "Teaches a move to a compatible Pokemon."
    },
    [416] = {
        name = "TM89",
        description = "Teaches a move to a compatible Pokemon."
    },
    [417] = {
        name = "TM90",
        description = "Teaches a move to a compatible Pokemon."
    },
    [418] = {
        name = "TM91",
        description = "Teaches a move to a compatible Pokemon."
    },
    [419] = {
        name = "TM92",
        description = "Teaches a move to a compatible Pokemon."
    },
    [420] = {
        name = "HM01",
        description = "Teaches a move to a compatible Pokemon."
    },
    [421] = {
        name = "HM02",
        description = "Teaches a move to a compatible Pokemon."
    },
    [422] = {
        name = "HM03",
        description = "Teaches a move to a compatible Pokemon."
    },
    [423] = {
        name = "HM04",
        description = "Teaches a move to a compatible Pokemon."
    },
    [424] = {
        name = "HM05",
        description = "Teaches a move to a compatible Pokemon."
    },
    [425] = {
        name = "HM06",
        description = "Teaches a move to a compatible Pokemon."
    },
    [428] = {
        name = "Explorer Kit",
        description = "Allows visiting the Underground."
    },
    [429] = {
        name = "Loot Sack",
        description = "Carries coal mine loot."
    },
    [430] = {
        name = "Rule Book",
        description = "List of battle types and their rules."
    },
    [431] = {
        name = "Poke Radar",
        description = "Use to track down rare or shiny Pokemon. 50 steps to recharge."
    },
    [432] = {
        name = "Point Card",
        description = "Keeps count of Battle Points earned."
    },
    [433] = {
        name = "Journal",
        description = "Records prior significant activities the player took."
    },
    [434] = {
        name = "Seal Case",
        description = "Stores Seals that can be applied to Poke Ball capsules."
    },
    [435] = {
        name = "Fashion Case",
        description = "Holds Pok" .. Chars.accentedE .. "mon Accessories for use in Contests."
    },
    [436] = {
        name = "Seal Bag",
        description = "Holds ten Seals for Poke Balls."
    },
    [437] = {
        name = "Pal Pad",
        description = "Use to record Friend Codes and check your own."
    },
    [438] = {
        name = "Works Key",
        description = "Grants access to Valley Windworks."
    },
    [439] = {
        name = "Old Charm",
        description = "Trade to Cynthia's grandmother in Celestic Town for HM04 (Surf)."
    },
    [440] = {
        name = "Galactic Key",
        description = "Grants access to Galactic HQ in Veilstone City."
    },
    [441] = {
        name = "Red Chain",
        description = "Used to bind Palkia and Dialga."
    },
    [442] = {
        name = "Town Map",
        description = "Use to see the overworld map."
    },
    [443] = {
        name = "Vs Seeker",
        description = "Allows rebattling of on-screen trainers. 100 steps to recharge."
    },
    [444] = {
        name = "Coin Case",
        description = "Holds coins for the Game Corner."
    },
    [445] = {
        name = "Old Rod",
        description = "Used to catch Pok" .. Chars.accentedE .. "mon in bodies of water."
    },
    [446] = {
        name = "Good Rod",
        description = "Used to catch Pok" .. Chars.accentedE .. "mon in bodies of water."
    },
    [447] = {
        name = "Super Rod",
        description = "Used to catch Pok" .. Chars.accentedE .. "mon in bodies of water."
    },
    [448] = {
        name = "Sprayduck",
        description = "Used to water berries."
    },
    [449] = {
        name = "Poffin Case",
        description = "Holds Poffins."
    },
    [450] = {
        name = "Bicycle",
        description = "Use for fast transit."
    },
    [451] = {
        name = "Suite Key",
        description = "Opens a locked building in the Lakeside Resort."
    },
    [452] = {
        name = "Oaks Letter",
        description = "Allows access to Seabreak path, Flower Paradise, and Shaymin."
    },
    [453] = {
        name = "Lunar Wing",
        description = "Cures sailor's son of nightmares in Canalave City."
    },
    [454] = {
        name = "Member Card",
        description = "Allows access to Newmoon Island and Darkrai."
    },
    [455] = {
        name = "Azure Flute",
        description = "Allows entry into the Hall of Origin. Unreleased."
    },
    [456] = {
        name = "Ss Ticket",
        description = "Ticket for a ship. (RSE: S.S. Tidal LF: S.S. Anne HG: S.S. Aqua)"
    },
    [457] = {
        name = "Contest Pass",
        description = "Allows participation in Pok" .. Chars.accentedE .. "mon Contests."
    },
    [458] = {
        name = "Magma Stone",
        description = "Magma is sealed inside."
    },
    [459] = {
        name = "Parcel",
        description = "Given to the trainer's rival in Jubilife City. Contains Town Maps."
    },
    [460] = {
        name = "Coupon 1",
        description = "The first of three tickets used to obtain a Poketch."
    },
    [461] = {
        name = "Coupon 2",
        description = "The second of three tickets used to obtain a Poketch."
    },
    [462] = {
        name = "Coupon 3",
        description = "The last of three tickets used to obtain a Poketch."
    },
    [463] = {
        name = "Storage Key",
        description = "Grants access to the Team Galactic warehouse in Veilstone City."
    },
    [464] = {
        name = "Secret Potion",
        description = "Used to heal the Ampharos at the top of Olivine Lighthouse."
    },
    [112] = {
        name = "Griseous Orb",
        description = "Boosts the damage from Giratina's Dragon-type and Ghost-type moves by 20%, and transforms it into Origin Forme."
    },
    [465] = {
        name = "Vs Recorder",
        description = "Records wireless, Wi-Fi, or Battle Frontier battles, and stores points."
    },
    [466] = {
        name = "Gracidea",
        description = "Changes an unfrozen Shaymin to Sky Forme in the day."
    },
    [467] = {
        name = "Secret Key",
        description = "Gen IV: The key to Rotom's appliance room. "
    },
    [468] = {
        name = "Apricorn Box",
        description = "Holds Apricorns."
    },
    [470] = {
        name = "Berry Pots",
        description = "Allows portable berry growing."
    },
    [477] = {
        name = "Squirt Bottle",
        description = "Use on Sudowoodo blocking the path on Route 36. Also waters berries."
    },
    [494] = {
        name = "Lure Ball",
        description = "3x effectiveness while fishing. Made from Blu Apricorn."
    },
    [493] = {
        name = "Level Ball",
        description = "Success rate based off of fraction target Pok" ..
            Chars.accentedE .. "mon is of user's Pokemon. Made from Red Apricorn."
    },
    [498] = {
        name = "Moon Ball",
        description = "4x effectiveness on familes of Pok" ..
            Chars.accentedE .. "mon with a Moon Stone evolution. Made from Ylw Apricorn."
    },
    [495] = {
        name = "Heavy Ball",
        description = "Has flat bonus or penalty to catch rate depending on weight class of target. Made from Blk Apricorn."
    },
    [492] = {
        name = "Fast Ball",
        description = "4x effectiveness on Pok" ..
            Chars.accentedE .. "mon with 100 or greater base speed. Made from Wht Apricorn."
    },
    [497] = {
        name = "Friend Ball",
        description = "Caught Pok" .. Chars.accentedE .. "mon start with 200 happiness. Made from Grn Apricorn."
    },
    [496] = {
        name = "Love Ball",
        description = "8x effectiveness on opposite sex, same species targets of the Active Pokemon. Made from Pnk Apricorn."
    },
    [500] = {
        name = "Park Ball",
        description = "Catches Pok" .. Chars.accentedE .. "mon in the Pal Park every time."
    },
    [499] = {
        name = "Sport Ball",
        description = "Tries to catch a Pok" .. Chars.accentedE .. "mon in the Bug-Catching contest in National Park."
    },
    [485] = {
        name = "Red Apricorn",
        description = "Used to make a Level Ball."
    },
    [486] = {
        name = "Blue Apricorn",
        description = "Used to make a Lure Ball."
    },
    [487] = {
        name = "Yellow Apricorn",
        description = "Used to make a Moon Ball."
    },
    [488] = {
        name = "Green Apricorn",
        description = "Used to make a Friend Ball."
    },
    [489] = {
        name = "Pink Apricorn",
        description = "Used to make a Love Ball."
    },
    [490] = {
        name = "White Apricorn",
        description = "Used to make a Fast Ball."
    },
    [491] = {
        name = "Black Apricorn",
        description = "Used to make a Heavy Ball."
    },
    [471] = {
        name = "Dowsing Machine",
        description = "Use to find hidden items on the field. AKA Itemfinder."
    },
    [504] = {
        name = "RageCandyBar",
        description = "Acts as a Potion."
    },
    [534] = {
        name = "Red Orb",
        description = "Summons Groudon to the Embedded Tower."
    },
    [535] = {
        name = "Blue Orb",
        description = "Summons Kyogre to the Embedded Tower."
    },
    [532] = {
        name = "Jade Orb",
        description = "Summons Rayquaza to the Embedded Tower."
    },
    [536] = {
        name = "Enigma Stone",
        description = "S: Summons Latias H: Summons Latios."
    },
    [469] = {
        name = "Unown Report",
        description = "Keeps track of Unown types caught."
    },
    [472] = {
        name = "Blue Card",
        description = "Keeps track of points from Buena's show."
    },
    [473] = {
        name = "Slowpoke Tail",
        description = "A tasty tail that sells for a high price."
    },
    [474] = {
        name = "Clear Bell",
        description = "HS: Allows Kimono-girls to summon Ho-oh. C: Summons Suicune to the Tin Tower."
    },
    [475] = {
        name = "Card Key",
        description = "HS: Opens doors in the Radio Tower. "
    },
    [476] = {
        name = "Basement Key",
        description = "HS: Key to the tunnel under Goldenrod City. "
    },
    [478] = {
        name = "Red Scale",
        description = "Trade to Mr. Pok" .. Chars.accentedE .. "mon for an Exp. Share."
    },
    [479] = {
        name = "Lost Item",
        description = "A Poke Doll lost by the Copycat who lives in Saffron City. Trade for a Pass."
    },
    [480] = {
        name = "Pass",
        description = "Grants access to ride the Magnet Train between Goldenrod City and Saffron City."
    },
    [481] = {
        name = "Machine Part",
        description = "Must be replaced in the Power Plant to power the Magnet Train."
    },
    [482] = {
        name = "Silver Wing",
        description = "Summons Lugia to the Whirl Islands."
    },
    [483] = {
        name = "Rainbow Wing",
        description = "Summons Ho-Oh at the top of the Bell Tower."
    },
    [484] = {
        name = "Mystery Egg",
        description = "Deliver to Professor Elm."
    },
    [502] = {
        name = "Gb Sounds",
        description = "Use to listen to GameBoy era audio."
    },
    [503] = {
        name = "Tidal Bell",
        description = "Allows Kimono-girls to summon Lugia."
    },
    [505] = {
        name = "Data Card-01",
        description = "Records the number of times the trainer has come in first place overall in the Pokeathlon."
    },
    [506] = {
        name = "Data Card-02",
        description = "Records the number of times the trainer has come in last place overall in the Pokeathlon."
    },
    [507] = {
        name = "Data Card-03",
        description = "Records the number of times the trainer's Pok" ..
            Chars.accentedE .. "mon have dashed in the Pokeathlon."
    },
    [508] = {
        name = "Data Card-04",
        description = "Records the number of times the trainer's Pok" ..
            Chars.accentedE .. "mon have jumped in the Pokeathlon."
    },
    [509] = {
        name = "Data Card-05",
        description = "Records the number of times the trainer has come in first in the Pokeathlon Hurdle Dash."
    },
    [510] = {
        name = "Data Card-06",
        description = "Records the number of times the trainer has come in first in the Pokeathlon Relay Run."
    },
    [511] = {
        name = "Data Card-07",
        description = "Records the number of times the trainer has come in first in the Pokeathlon Pennant Capture."
    },
    [512] = {
        name = "Data Card-08",
        description = "Records the number of times the trainer has come in first in the Pokeathlon Block Smash."
    },
    [513] = {
        name = "Data Card-09",
        description = "Records the number of times the trainer has come in first in the Pokeathlon Disc Catch."
    },
    [514] = {
        name = "Data Card-10",
        description = "Records the number of times the trainer has come in first in the Pokeathlon Snow Throw."
    },
    [515] = {
        name = "Data Card-11",
        description = "Records the number of points the trainer has earned in the Pokeathlon."
    },
    [516] = {
        name = "Data Card-12",
        description = "Records the number of times the trainer's Pok" ..
            Chars.accentedE .. "mon have messed up in the Pokeathlon."
    },
    [517] = {
        name = "Data Card-13",
        description = "Records the number of times the trainer's Pok" ..
            Chars.accentedE .. "mon have defeated themselves in the Pokeathlon."
    },
    [518] = {
        name = "Data Card-14",
        description = "Records the number of times the trainer's Pok" ..
            Chars.accentedE .. "mon have tackled in the Pokeathlon."
    },
    [519] = {
        name = "Data Card-15",
        description = "Records the number of times the trainer's Pok" ..
            Chars.accentedE .. "mon have fallen in the Pokeathlon."
    },
    [520] = {
        name = "Data Card-16",
        description = "Records the number of times the trainer has come in first in the Pokeathlon Ring Drop."
    },
    [521] = {
        name = "Data Card-17",
        description = "Records the number of times the trainer has come in first in the Pokeathlon Lamp Jump."
    },
    [522] = {
        name = "Data Card-18",
        description = "Records the number of times the trainer has come in first in the Pokeathlon Circle Push."
    },
    [523] = {
        name = "Data Card-19",
        description = "Records the number of times the trainer has come in first place overall in the Pokeathlon over wirelss."
    },
    [524] = {
        name = "Data Card-20",
        description = "Records the number of times the trainer has come in last place overall in the Pokeathlon over wireless."
    },
    [525] = {
        name = "Data Card-21",
        description = "Records the number of times the trainer has come in first across all Pokeathlon events."
    },
    [526] = {
        name = "Data Card-22",
        description = "Records the number of times the trainer has come in last across all Pokeathlon events."
    },
    [527] = {
        name = "Data Card-23",
        description = "Records the number of times the trainer has switched Pok" ..
            Chars.accentedE .. "mon in the Pokeathlon."
    },
    [528] = {
        name = "Data Card-24",
        description = "Records the number of times the trainer has come in first in the Pokeathlon Goal Roll."
    },
    [529] = {
        name = "Data Card-25",
        description = "Records the number of times the trainer's Pok" ..
            Chars.accentedE .. "mon received prizes in the Pokeathlon."
    },
    [530] = {
        name = "Data Card-26",
        description = "Records the number of times the trainer has instructed Pok" ..
            Chars.accentedE .. "mon in the Pokeathlon."
    },
    [531] = {
        name = "Data Card-27",
        description = "Records the total time spent in the Pokeathlon."
    },
    [533] = {
        name = "Lock Capsule",
        description = "Contains TM95 (Snarl)."
    },
    [501] = {
        name = "Photo Album",
        description = "Stores photos from your adventure."
    },
    [116] = {
        name = "Douse Drive",
        description = "Grants Genesect a blue, Water-type Techno Blast."
    },
    [117] = {
        name = "Shock Drive",
        description = "Grants Genesect a yellow, Electric-type Techno Blast."
    },
    [118] = {
        name = "Burn Drive",
        description = "Grants Genesect a red, Fire-type Techno Blast."
    },
    [119] = {
        name = "Chill Drive",
        description = "Grants Genesect a white, Ice-type Techno Blast."
    },
    [134] = {
        name = "Sweet Heart",
        description = "Restores 20 HP."
    },
    [137] = {
        name = "Greet Mail",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [138] = {
        name = "Favored Mail",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [139] = {
        name = "Rsvp Mail",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [140] = {
        name = "Thanks Mail",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [141] = {
        name = "Inquiry Mail",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [142] = {
        name = "Like Mail",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [143] = {
        name = "Reply Mail",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [144] = {
        name = "Bridge Mail-s",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [145] = {
        name = "Bridge Mail-d",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [146] = {
        name = "Bridge Mail-t",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [147] = {
        name = "Bridge Mail-v",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [148] = {
        name = "Bridge Mail-m",
        description = "Lets a Trainer write a message and send it via Pok" .. Chars.accentedE .. "mon trade."
    },
    [537] = {
        name = "Prism Scale",
        description = "Traded on a Feebas: Holder evolves into Milotic."
    },
    [538] = {
        name = "Eviolite",
        description = "Holder has 1.5x Defense and Special Defense, as long as it's not fully evolved."
    },
    [539] = {
        name = "Float Stone",
        description = "Holder has 0.5x weight."
    },
    [540] = {
        name = "Rocky Helmet",
        description = "When the holder is hit by a contact move, the attacking Pok" ..
            Chars.accentedE .. "mon takes 1/6 its max HP in damage."
    },
    [541] = {
        name = "Air Balloon",
        description = "Grants immunity to Ground-type moves, Spikes, and Toxic Spikes. Consumed when the holder takes damage from a move."
    },
    [542] = {
        name = "Red Card",
        description = "When the holder takes damage from a move, the opponent switches out for another random party Pokemon. Consumed after use."
    },
    [543] = {
        name = "Ring Target",
        description = "Negates the holder's type immunities. Ability immunities are not removed."
    },
    [544] = {
        name = "Binding Band",
        description = "Doubles the per-turn damage of multi-turn trapping moves."
    },
    [545] = {
        name = "Absorb Bulb",
        description = "Raises the holder's Special Attack by one stage when it takes Water-type damage."
    },
    [546] = {
        name = "Cell Battery",
        description = "Raises the holder's Attack by one stage when it takes Electric-type damage."
    },
    [547] = {
        name = "Eject Button",
        description = "When the holder takes damage from a move, it switches out for a party Pok" ..
            Chars.accentedE .. "mon of the Trainer's choice."
    },
    [548] = {
        name = "Fire Gem",
        description = "When the holder uses a damaging fire-type move, the move has 1.5x power and this item is consumed."
    },
    [549] = {
        name = "Water Gem",
        description = "When the holder uses a damaging water-type move, the move has 1.5x power and this item is consumed."
    },
    [550] = {
        name = "Electric Gem",
        description = "When the holder uses a damaging electric-type move, the move has 1.5x power and this item is consumed."
    },
    [551] = {
        name = "Grass Gem",
        description = "When the holder uses a damaging grass-type move, the move has 1.5x power and this item is consumed."
    },
    [552] = {
        name = "Ice Gem",
        description = "When the holder uses a damaging ice-type move, the move has 1.5x power and this item is consumed."
    },
    [553] = {
        name = "Fighting Gem",
        description = "When the holder uses a damaging fighting-type move, the move has 1.5x power and this item is consumed."
    },
    [554] = {
        name = "Poison Gem",
        description = "When the holder uses a damaging poison-type move, the move has 1.5x power and this item is consumed."
    },
    [555] = {
        name = "Ground Gem",
        description = "When the holder uses a damaging ground-type move, the move has 1.5x power and this item is consumed."
    },
    [556] = {
        name = "Flying Gem",
        description = "When the holder uses a damaging flying-type move, the move has 1.5x power and this item is consumed."
    },
    [557] = {
        name = "Psychic Gem",
        description = "When the holder uses a damaging psychic-type move, the move has 1.5x power and this item is consumed."
    },
    [558] = {
        name = "Bug Gem",
        description = "When the holder uses a damaging bug-type move, the move has 1.5x power and this item is consumed."
    },
    [559] = {
        name = "Rock Gem",
        description = "When the holder uses a damaging rock-type move, the move has 1.5x power and this item is consumed."
    },
    [560] = {
        name = "Ghost Gem",
        description = "When the holder uses a damaging ghost-type move, the move has 1.5x power and this item is consumed."
    },
    [561] = {
        name = "Dragon Gem",
        description = "When the holder uses a damaging dragon-type move, the move has 1.5x power and this item is consumed."
    },
    [562] = {
        name = "Dark Gem",
        description = "When the holder uses a damaging dark-type move, the move has 1.5x power and this item is consumed."
    },
    [563] = {
        name = "Steel Gem",
        description = "When the holder uses a damaging steel-type move, the move has 1.5x power and this item is consumed."
    },
    [564] = {
        name = "Normal Gem",
        description = "When the holder uses a damaging normal-type move, the move has 1.5x power and this item is consumed."
    },
    [565] = {
        name = "Health Wing",
        description = "Increases HP effort by 1."
    },
    [566] = {
        name = "Muscle Wing",
        description = "Increases Attack effort by 1."
    },
    [567] = {
        name = "Resist Wing",
        description = "Increases Defense effort by 1."
    },
    [568] = {
        name = "Genius Wing",
        description = "Increases Special Attack effort by 1."
    },
    [569] = {
        name = "Clever Wing",
        description = "Increases Special Defense effort by 1."
    },
    [570] = {
        name = "Swift Wing",
        description = "Increases Speed effort by 1."
    },
    [571] = {
        name = "Pretty Wing",
        description = "Sell for 100 Pokedollars."
    },
    [572] = {
        name = "Cover Fossil",
        description = "Can be revived into a tirtouga."
    },
    [573] = {
        name = "Plume Fossil",
        description = "Can be revived into a archen."
    },
    [574] = {
        name = "Liberty Pass",
        description = "Allows access to Liberty Garden and Victini."
    },
    [575] = {
        name = "Pass Orb",
        description = "Activates Pass Powers."
    },
    [576] = {
        name = "Dream Ball",
        description = "Catches Pok" .. Chars.accentedE .. "mon found in the Dream World."
    },
    [577] = {
        name = "Poke Toy",
        description = "Ends a wild battle."
    },
    [578] = {
        name = "Prop Case",
        description = "Stores props for the Pok" .. Chars.accentedE .. "mon Musical."
    },
    [579] = {
        name = "Dragon Skull",
        description = "Return to the museum in Nacrene City."
    },
    [580] = {
        name = "Balm Mushroom",
        description = "Sell to Hungry Maid for 25000 Pokedollars."
    },
    [581] = {
        name = "Big Nugget",
        description = "Sell to Ore Collector for 30000 Pokedollars."
    },
    [582] = {
        name = "Pearl String",
        description = "Sell to Ore Collector for 25000 Pokedollars."
    },
    [583] = {
        name = "Comet Shard",
        description = "Sell to Ore Collector for 60000 Pokedollars."
    },
    [584] = {
        name = "Relic Copper",
        description = "Sell to Villa Owner for 1000 Pokedollars."
    },
    [585] = {
        name = "Relic Silver",
        description = "Sell to Villa Owner 5000 Pokedollars."
    },
    [586] = {
        name = "Relic Gold",
        description = "Sell to Villa Owner 10000 Pokedollars."
    },
    [587] = {
        name = "Relic Vase",
        description = "Sell to Villa Owner 50000 Pokedollars."
    },
    [588] = {
        name = "Relic Band",
        description = "Sell to Villa Owner for 100000 Pokedollars."
    },
    [589] = {
        name = "Relic Statue",
        description = "Sell to Villa Owner 200000 Pokedollars."
    },
    [590] = {
        name = "Relic Crown",
        description = "Sell to Villa Owner for 300000 Pokedollars."
    },
    [591] = {
        name = "Casteliacone",
        description = "Cures any status ailment and confusion."
    },
    [592] = {
        name = "Dire Hit-2",
        description = "Raises critical hit rate by two stages in battle. Wonder Launcher only."
    },
    [593] = {
        name = "X Speed-2",
        description = "Raises Speed by two stages in battle. Wonder Launcher only."
    },
    [594] = {
        name = "X Sp-atk-2",
        description = "Raises Special Attack by two stages in battle. Wonder Launcher only."
    },
    [595] = {
        name = "X Sp-def-2",
        description = "Raises Special Defense by two stages in battle. Wonder Launcher only."
    },
    [596] = {
        name = "X Defense-2",
        description = "Raises Defense by two stages in battle. Wonder Launcher only."
    },
    [597] = {
        name = "X Attack-2",
        description = "Raises Attack by two stages in battle. Wonder Launcher only."
    },
    [598] = {
        name = "X Accuracy-2",
        description = "Raises accuracy by two stages in battle. Wonder Launcher only."
    },
    [599] = {
        name = "X Speed-3",
        description = "Raises Speed by three stages in battle. Wonder Launcher only."
    },
    [600] = {
        name = "X Sp-atk-3",
        description = "Raises Special Attack by three stages in battle. Wonder Launcher only."
    },
    [601] = {
        name = "X Sp-def-3",
        description = "Raises Special Defense by three stages in battle. Wonder Launcher only."
    },
    [602] = {
        name = "X Defense-3",
        description = "Raises Defense by three stages in battle. Wonder Launcher only."
    },
    [603] = {
        name = "X Attack-3",
        description = "Raises Attack by three stages in battle. Wonder Launcher only."
    },
    [604] = {
        name = "X Accuracy-3",
        description = "Raises accuracy by three stages in battle. Wonder Launcher only."
    },
    [605] = {
        name = "X Speed-6",
        description = "Raises Speed by six stages in battle. Wonder Launcher only."
    },
    [606] = {
        name = "X Sp-atk-6",
        description = "Raises Special Attack by six stages in battle. Wonder Launcher only."
    },
    [607] = {
        name = "X Sp-def-6",
        description = "Raises Special Defense by six stages in battle. Wonder Launcher only."
    },
    [608] = {
        name = "X Defense-6",
        description = "Raises Defense by six stages in battle. Wonder Launcher only."
    },
    [609] = {
        name = "X Attack-6",
        description = "Raises Attack by six stages in battle. Wonder Launcher only."
    },
    [610] = {
        name = "X Accuracy-6",
        description = "Raises accuracy by six stages in battle. Wonder Launcher only."
    },
    [611] = {
        name = "Ability Urge",
        description = "Forcibly activates a friendly Pokemon's ability."
    },
    [612] = {
        name = "Item Drop",
        description = "Forces a friendly Pok" .. Chars.accentedE .. "mon to drop its held item."
    },
    [613] = {
        name = "Item Urge",
        description = "Forcibly activates a friendly Pokemon's held item."
    },
    [614] = {
        name = "Reset Urge",
        description = "Resets a friendly Pokemon's stat changes."
    },
    [615] = {
        name = "Dire Hit-3",
        description = "Raises critical hit rate by three stages in battle. Wonder Launcher only."
    },
    [616] = {
        name = "Light Stone",
        description = "Summons Reshiram for the final battle against N."
    },
    [617] = {
        name = "Dark Stone",
        description = "Summons Zekrom for the final battle against N."
    },
    [618] = {
        name = "TM93",
        description = "Teaches a move to a compatible Pokemon."
    },
    [619] = {
        name = "TM94",
        description = "Teaches a move to a compatible Pokemon."
    },
    [620] = {
        name = "TM95",
        description = "Teaches a move to a compatible Pokemon."
    },
    [621] = {
        name = "Xtransceiver",
        description = "Makes four-way video calls."
    },
    [622] = {
        name = "God Stone",
        description = "Unknown. Currently unused."
    },
    [623] = {
        name = "Gram 1",
        description = "Part of a sidequest to obtain tm89."
    },
    [624] = {
        name = "Gram 2",
        description = "Part of a sidequest to obtain tm89."
    },
    [625] = {
        name = "Gram 3",
        description = "Part of a sidequest to obtain tm89."
    }
}

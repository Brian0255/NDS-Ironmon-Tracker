AbilityData = {}

AbilityData.ABILITIES = {}
AbilityData.BATTLE_MSGS = {}

AbilityData.ABILITIES_MASTER_LIST = {
    {
        id = 0,
        name = "---",
        description = "",
    },
    {
        id = 1,
        name = Localizations.AbilitiesName.stench,
        description = Localizations.AbilitiesDescription.stench},
    {
        id = 2,
        name = Localizations.AbilitiesName.drizzle,
        description = Localizations.AbilitiesDescription.drizzle},
    {
        id = 3,
        name = Localizations.AbilitiesName.speedBoost,
        description = Localizations.AbilitiesDescription.speedBoost},
    {
        id = 4,
        name = Localizations.AbilitiesName.battleArmor,
        description = Localizations.AbilitiesDescription.battleArmor},
    {
        id = 5,
        name = Localizations.AbilitiesName.sturdy,
        description = Localizations.AbilitiesDescription.sturdy},
    {
        id = 6,
        name = Localizations.AbilitiesName.damp,
        description = Localizations.AbilitiesDescription.damp},
    {
        id = 7,
        name = Localizations.AbilitiesName.limber,
        description = Localizations.AbilitiesDescription.limber},
    {
        id = 8,
        name = Localizations.AbilitiesName.sandVeil,
        description = Localizations.AbilitiesDescription.sandVeil},
    {
        id = 9,
        name = Localizations.AbilitiesName.static,
        description = Localizations.AbilitiesDescription.static},
    {
        id = 10,
        name = Localizations.AbilitiesName.voltAbsorb,
        description = Localizations.AbilitiesDescription.voltAbsorb},
    {
        id = 11,
        name = Localizations.AbilitiesName.waterAbsorb,
        description = Localizations.AbilitiesDescription.waterAbsorb},
    {
        id = 12,
        name = Localizations.AbilitiesName.oblivious,
        description = Localizations.AbilitiesDescription.oblivious},
    {
        id = 13,
        name = Localizations.AbilitiesName.cloudNine,
        description = Localizations.AbilitiesDescription.cloudNine},
    {
        id = 14,
        name = Localizations.AbilitiesName.compoundeyes,
        description = Localizations.AbilitiesDescription.compoundeyes},
    {
        id = 15,
        name = Localizations.AbilitiesName.insomnia,
        description = Localizations.AbilitiesDescription.insomnia},
    {
        id = 16,
        name = Localizations.AbilitiesName.colorChange,
        description = Localizations.AbilitiesDescription.colorChange},
    {
        id = 17,
        name = Localizations.AbilitiesName.immunity,
        description = Localizations.AbilitiesDescription.immunity},
    {
        id = 18,
        name = Localizations.AbilitiesName.flashFire,
        description = Localizations.AbilitiesDescription.flashFire},
    {
        id = 19,
        name = Localizations.AbilitiesName.shieldDust,
        description = Localizations.AbilitiesDescription.shieldDust},
    {
        id = 20,
        name = Localizations.AbilitiesName.ownTempo,
        description = Localizations.AbilitiesDescription.ownTempo},
    {
        id = 21,
        name = Localizations.AbilitiesName.suctionCups,
        description = Localizations.AbilitiesDescription.suctionCups},
    {
        id = 22,
        name = Localizations.AbilitiesName.intimidate,
        description = Localizations.AbilitiesDescription.intimidate},
    {
        id = 23,
        name = Localizations.AbilitiesName.shadowTag,
        description = Localizations.AbilitiesDescription.shadowTag},
    {
        id = 24,
        name = Localizations.AbilitiesName.roughSkin,
        description = Localizations.AbilitiesDescription.roughSkin},
    {
        id = 25,
        name = Localizations.AbilitiesName.wonderGuard,
        description = Localizations.AbilitiesDescription.wonderGuard},
    {
        id = 26,
        name = Localizations.AbilitiesName.levitate,
        description = Localizations.AbilitiesDescription.levitate},
    {
        id = 27,
        name = Localizations.AbilitiesName.effectSpore,
        description = Localizations.AbilitiesDescription.effectSpore},
    {
        id = 28,
        name = Localizations.AbilitiesName.synchronize,
        description = Localizations.AbilitiesDescription.synchronize},
    {
        id = 29,
        name = Localizations.AbilitiesName.clearBody,
        description = Localizations.AbilitiesDescription.clearBody},
    {
        id = 30,
        name = Localizations.AbilitiesName.naturalCure,
        description = Localizations.AbilitiesDescription.naturalCure},
    {
        id = 31,
        name = Localizations.AbilitiesName.lightningrod,
        description = Localizations.AbilitiesDescription.lightningrod},
    {
        id = 32,
        name = Localizations.AbilitiesName.sereneGrace,
        description = Localizations.AbilitiesDescription.sereneGrace},
    {
        id = 33,
        name = Localizations.AbilitiesName.swiftSwim,
        description = Localizations.AbilitiesDescription.swiftSwim},
    {
        id = 34,
        name = Localizations.AbilitiesName.chlorophyll,
        description = Localizations.AbilitiesDescription.chlorophyll},
    {
        id = 35,
        name = Localizations.AbilitiesName.illuminate,
        description = Localizations.AbilitiesDescription.illuminate},
    {
        id = 36,
        name = Localizations.AbilitiesName.trace,
        description = Localizations.AbilitiesDescription.trace},
    {
        id = 37,
        name = Localizations.AbilitiesName.hugePower,
        description = Localizations.AbilitiesDescription.hugePower},
    {
        id = 38,
        name = Localizations.AbilitiesName.poisonPoint,
        description = Localizations.AbilitiesDescription.poisonPoint},
    {
        id = 39,
        name = Localizations.AbilitiesName.innerFocus,
        description = Localizations.AbilitiesDescription.innerFocus},
    {
        id = 40,
        name = Localizations.AbilitiesName.magmaArmor,
        description = Localizations.AbilitiesDescription.magmaArmor},
    {
        id = 41,
        name = Localizations.AbilitiesName.waterVeil,
        description = Localizations.AbilitiesDescription.waterVeil},
    {
        id = 42,
        name = Localizations.AbilitiesName.magnetPull,
        description = Localizations.AbilitiesDescription.magnetPull},
    {
        id = 43,
        name = Localizations.AbilitiesName.soundproof,
        description = Localizations.AbilitiesDescription.soundproof},
    {
        id = 44,
        name = Localizations.AbilitiesName.rainDish,
        description = Localizations.AbilitiesDescription.rainDish},
    {
        id = 45,
        name = Localizations.AbilitiesName.sandStream,
        description = Localizations.AbilitiesDescription.sandStream},
    {
        id = 46,
        name = Localizations.AbilitiesName.pressure,
        description = Localizations.AbilitiesDescription.pressure},
    {
        id = 47,
        name = Localizations.AbilitiesName.thickFat,
        description = Localizations.AbilitiesDescription.thickFat},
    {
        id = 48,
        name = Localizations.AbilitiesName.earlyBird,
        description = Localizations.AbilitiesDescription.earlyBird},
    {
        id = 49,
        name = Localizations.AbilitiesName.flameBody,
        description = Localizations.AbilitiesDescription.flameBody},
    {
        id = 50,
        name = Localizations.AbilitiesName.runAway,
        description = Localizations.AbilitiesDescription.runAway},
    {
        id = 51,
        name = Localizations.AbilitiesName.keenEye,
        description = Localizations.AbilitiesDescription.keenEye},
    {
        id = 52,
        name = Localizations.AbilitiesName.hyperCutter,
        description = Localizations.AbilitiesDescription.hyperCutter},
    {
        id = 53,
        name = Localizations.AbilitiesName.pickup,
        description = Localizations.AbilitiesDescription.pickup},
    {
        id = 54,
        name = Localizations.AbilitiesName.truant,
        description = Localizations.AbilitiesDescription.truant},
    {
        id = 55,
        name = Localizations.AbilitiesName.hustle,
        description = Localizations.AbilitiesDescription.hustle},
    {
        id = 56,
        name = Localizations.AbilitiesName.cuteCharm,
        description = Localizations.AbilitiesDescription.cuteCharm},
    {
        id = 57,
        name = Localizations.AbilitiesName.plus,
        description = Localizations.AbilitiesDescription.plus},
    {
        id = 58,
        name = Localizations.AbilitiesName.minus,
        description = Localizations.AbilitiesDescription.minus},
    {
        id = 59,
        name = Localizations.AbilitiesName.forecast,
        description = Localizations.AbilitiesDescription.forecast},
    {
        id = 60,
        name = Localizations.AbilitiesName.stickyHold,
        description = Localizations.AbilitiesDescription.stickyHold},
    {
        id = 61,
        name = Localizations.AbilitiesName.shedSkin,
        description = Localizations.AbilitiesDescription.shedSkin},
    {
        id = 62,
        name = Localizations.AbilitiesName.guts,
        description = Localizations.AbilitiesDescription.guts},
    {
        id = 63,
        name = Localizations.AbilitiesName.marvelScale,
        description = Localizations.AbilitiesDescription.marvelScale},
    {
        id = 64,
        name = Localizations.AbilitiesName.liquidOoze,
        description = Localizations.AbilitiesDescription.liquidOoze},
    {
        id = 65,
        name = Localizations.AbilitiesName.overgrow,
        description = Localizations.AbilitiesDescription.overgrow},
    {
        id = 66,
        name = Localizations.AbilitiesName.blaze,
        description = Localizations.AbilitiesDescription.blaze},
    {
        id = 67,
        name = Localizations.AbilitiesName.torrent,
        description = Localizations.AbilitiesDescription.torrent},
    {
        id = 68,
        name = Localizations.AbilitiesName.swarm,
        description = Localizations.AbilitiesDescription.swarm},
    {
        id = 69,
        name = Localizations.AbilitiesName.rockHead,
        description = Localizations.AbilitiesDescription.rockHead},
    {
        id = 70,
        name = Localizations.AbilitiesName.drought,
        description = Localizations.AbilitiesDescription.drought},
    {
        id = 71,
        name = Localizations.AbilitiesName.arenaTrap,
        description = Localizations.AbilitiesDescription.arenaTrap},
    {
        id = 72,
        name = Localizations.AbilitiesName.vitalSpirit,
        description = Localizations.AbilitiesDescription.vitalSpirit},
    {
        id = 73,
        name = Localizations.AbilitiesName.whiteSmoke,
        description = Localizations.AbilitiesDescription.whiteSmoke},
    {
        id = 74,
        name = Localizations.AbilitiesName.purePower,
        description = Localizations.AbilitiesDescription.purePower},
    {
        id = 75,
        name = Localizations.AbilitiesName.shellArmor,
        description = Localizations.AbilitiesDescription.shellArmor},
    {
        id = 76,
        name = Localizations.AbilitiesName.airLock,
        description = Localizations.AbilitiesDescription.airLock},
    {
        id = 77,
        name = Localizations.AbilitiesName.tangledFeet,
        description = Localizations.AbilitiesDescription.tangledFeet},
    {
        id = 78,
        name = Localizations.AbilitiesName.motorDrive,
        description = Localizations.AbilitiesDescription.motorDrive},
    {
        id = 79,
        name = Localizations.AbilitiesName.rivalry,
        description = Localizations.AbilitiesDescription.rivalry},
    {
        id = 80,
        name = Localizations.AbilitiesName.steadfast,
        description = Localizations.AbilitiesDescription.steadfast},
    {
        id = 81,
        name = Localizations.AbilitiesName.snowCloak,
        description = Localizations.AbilitiesDescription.snowCloak},
    {
        id = 82,
        name = Localizations.AbilitiesName.gluttony,
        description = Localizations.AbilitiesDescription.gluttony},
    {
        id = 83,
        name = Localizations.AbilitiesName.angerPoint,
        description = Localizations.AbilitiesDescription.angerPoint},
    {
        id = 84,
        name = Localizations.AbilitiesName.unburden,
        description = Localizations.AbilitiesDescription.unburden},
    {
        id = 85,
        name = Localizations.AbilitiesName.heatproof,
        description = Localizations.AbilitiesDescription.heatproof},
    {
        id = 86,
        name = Localizations.AbilitiesName.simple,
        description = Localizations.AbilitiesDescription.simple},
    {
        id = 87,
        name = Localizations.AbilitiesName.drySkin,
        description = Localizations.AbilitiesDescription.drySkin},
    {
        id = 88,
        name = Localizations.AbilitiesName.download,
        description = Localizations.AbilitiesDescription.download},
    {
        id = 89,
        name = Localizations.AbilitiesName.ironFist,
        description = Localizations.AbilitiesDescription.ironFist},
    {
        id = 90,
        name = Localizations.AbilitiesName.poisonHeal,
        description = Localizations.AbilitiesDescription.poisonHeal},
    {
        id = 91,
        name = Localizations.AbilitiesName.adaptability,
        description = Localizations.AbilitiesDescription.adaptability},
    {
        id = 92,
        name = Localizations.AbilitiesName.skillLink,
        description = Localizations.AbilitiesDescription.skillLink},
    {
        id = 93,
        name = Localizations.AbilitiesName.hydration,
        description = Localizations.AbilitiesDescription.hydration},
    {
        id = 94,
        name = Localizations.AbilitiesName.solarPower,
        description = Localizations.AbilitiesDescription.solarPower},
    {
        id = 95,
        name = Localizations.AbilitiesName.quickFeet,
        description = Localizations.AbilitiesDescription.quickFeet},
    {
        id = 96,
        name = Localizations.AbilitiesName.normalize,
        description = Localizations.AbilitiesDescription.normalize},
    {
        id = 97,
        name = Localizations.AbilitiesName.sniper,
        description = Localizations.AbilitiesDescription.sniper},
    {
        id = 98,
        name = Localizations.AbilitiesName.magicGuard,
        description = Localizations.AbilitiesDescription.magicGuard},
    {
        id = 99,
        name = Localizations.AbilitiesName.noGuard,
        description = Localizations.AbilitiesDescription.noGuard},
    {
        id = 100,
        name = Localizations.AbilitiesName.stall,
        description = Localizations.AbilitiesDescription.stall},
    {
        id = 101,
        name = Localizations.AbilitiesName.technician,
        description = Localizations.AbilitiesDescription.technician},
    {
        id = 102,
        name = Localizations.AbilitiesName.leafGuard,
        description = Localizations.AbilitiesDescription.leafGuard},
    {
        id = 103,
        name = Localizations.AbilitiesName.klutz,
        description = Localizations.AbilitiesDescription.klutz},
    {
        id = 104,
        name = Localizations.AbilitiesName.moldBreaker,
        description = Localizations.AbilitiesDescription.moldBreaker},
    {
        id = 105,
        name = Localizations.AbilitiesName.superLuck,
        description = Localizations.AbilitiesDescription.superLuck},
    {
        id = 106,
        name = Localizations.AbilitiesName.aftermath,
        description = Localizations.AbilitiesDescription.aftermath},
    {
        id = 107,
        name = Localizations.AbilitiesName.anticipation,
        description = Localizations.AbilitiesDescription.anticipation},
    {
        id = 108,
        name = Localizations.AbilitiesName.forewarn,
        description = Localizations.AbilitiesDescription.forewarn},
    {
        id = 109,
        name = Localizations.AbilitiesName.unaware,
        description = Localizations.AbilitiesDescription.unaware},
    {
        id = 110,
        name = Localizations.AbilitiesName.tintedLens,
        description = Localizations.AbilitiesDescription.tintedLens},
    {
        id = 111,
        name = Localizations.AbilitiesName.filter,
        description = Localizations.AbilitiesDescription.filter},
    {
        id = 112,
        name = Localizations.AbilitiesName.slowStart,
        description = Localizations.AbilitiesDescription.slowStart},
    {
        id = 113,
        name = Localizations.AbilitiesName.scrappy,
        description = Localizations.AbilitiesDescription.scrappy},
    {
        id = 114,
        name = Localizations.AbilitiesName.stormDrain,
        description = Localizations.AbilitiesDescription.stormDrain},
    {
        id = 115,
        name = Localizations.AbilitiesName.iceBody,
        description = Localizations.AbilitiesDescription.iceBody},
    {
        id = 116,
        name = Localizations.AbilitiesName.solidRock,
        description = Localizations.AbilitiesDescription.solidRock},
    {
        id = 117,
        name = Localizations.AbilitiesName.snowWarning,
        description = Localizations.AbilitiesDescription.snowWarning},
    {
        id = 118,
        name = Localizations.AbilitiesName.honeyGather,
        description = Localizations.AbilitiesDescription.honeyGather},
    {
        id = 119,
        name = Localizations.AbilitiesName.frisk,
        description = Localizations.AbilitiesDescription.frisk},
    {
        id = 120,
        name = Localizations.AbilitiesName.reckless,
        description = Localizations.AbilitiesDescription.reckless},
    {
        id = 121,
        name = Localizations.AbilitiesName.multitype,
        description = Localizations.AbilitiesDescription.multitype},
    {
        id = 122,
        name = Localizations.AbilitiesName.flowerGift,
        description = Localizations.AbilitiesDescription.flowerGift},
    {
        id = 123,
        name = Localizations.AbilitiesName.badDreams,
        description = Localizations.AbilitiesDescription.badDreams},
    {
        id = 124,
        name = Localizations.AbilitiesName.pickpocket,
        description = Localizations.AbilitiesDescription.pickpocket},
    {
        id = 125,
        name = Localizations.AbilitiesName.sheerForce,
        description = Localizations.AbilitiesDescription.sheerForce},
    {
        id = 126,
        name = Localizations.AbilitiesName.contrary,
        description = Localizations.AbilitiesDescription.contrary},
    {
        id = 127,
        name = Localizations.AbilitiesName.unnerve,
        description = Localizations.AbilitiesDescription.unnerve},
    {
        id = 128,
        name = Localizations.AbilitiesName.defiant,
        description = Localizations.AbilitiesDescription.defiant},
    {
        id = 129,
        name = Localizations.AbilitiesName.defeatist,
        description = Localizations.AbilitiesDescription.defeatist},
    {
        id = 130,
        name = Localizations.AbilitiesName.cursedBody,
        description = Localizations.AbilitiesDescription.cursedBody},
    {
        id = 131,
        name = Localizations.AbilitiesName.healer,
        description = Localizations.AbilitiesDescription.healer},
    {
        id = 132,
        name = Localizations.AbilitiesName.friendGuard,
        description = Localizations.AbilitiesDescription.friendGuard},
    {
        id = 133,
        name = Localizations.AbilitiesName.weakArmor,
        description = Localizations.AbilitiesDescription.weakArmor},
    {
        id = 134,
        name = Localizations.AbilitiesName.heavyMetal,
        description = Localizations.AbilitiesDescription.heavyMetal},
    {
        id = 135,
        name = Localizations.AbilitiesName.lightMetal,
        description = Localizations.AbilitiesDescription.lightMetal},
    {
        id = 136,
        name = Localizations.AbilitiesName.multiscale,
        description = Localizations.AbilitiesDescription.multiscale},
    {
        id = 137,
        name = Localizations.AbilitiesName.toxicBoost,
        description = Localizations.AbilitiesDescription.toxicBoost},
    {
        id = 138,
        name = Localizations.AbilitiesName.flareBoost,
        description = Localizations.AbilitiesDescription.flareBoost},
    {
        id = 139,
        name = Localizations.AbilitiesName.harvest,
        description = Localizations.AbilitiesDescription.harvest},
    {
        id = 140,
        name = Localizations.AbilitiesName.telepathy,
        description = Localizations.AbilitiesDescription.telepathy},
    {
        id = 141,
        name = Localizations.AbilitiesName.moody,
        description = Localizations.AbilitiesDescription.moody},
    {
        id = 142,
        name = Localizations.AbilitiesName.overcoat,
        description = Localizations.AbilitiesDescription.overcoat},
    {
        id = 143,
        name = Localizations.AbilitiesName.poisonTouch,
        description = Localizations.AbilitiesDescription.poisonTouch},
    {
        id = 144,
        name = Localizations.AbilitiesName.regenerator,
        description = Localizations.AbilitiesDescription.regenerator},
    {
        id = 145,
        name = Localizations.AbilitiesName.bigPecks,
        description = Localizations.AbilitiesDescription.bigPecks},
    {
        id = 146,
        name = Localizations.AbilitiesName.sandRush,
        description = Localizations.AbilitiesDescription.sandRush},
    {
        id = 147,
        name = Localizations.AbilitiesName.wonderSkin,
        description = Localizations.AbilitiesDescription.wonderSkin},
    {
        id = 148,
        name = Localizations.AbilitiesName.analytic,
        description = Localizations.AbilitiesDescription.analytic},
    {
        id = 149,
        name = Localizations.AbilitiesName.illusion,
        description = Localizations.AbilitiesDescription.illusion},
    {
        id = 150,
        name = Localizations.AbilitiesName.imposter,
        description = Localizations.AbilitiesDescription.imposter},
    {
        id = 151,
        name = Localizations.AbilitiesName.infiltrator,
        description = Localizations.AbilitiesDescription.infiltrator},
    {
        id = 152,
        name = Localizations.AbilitiesName.mummy,
        description = Localizations.AbilitiesDescription.mummy},
    {
        id = 153,
        name = Localizations.AbilitiesName.moxie,
        description = Localizations.AbilitiesDescription.moxie},
    {
        id = 154,
        name = Localizations.AbilitiesName.justified,
        description = Localizations.AbilitiesDescription.justified},
    {
        id = 155,
        name = Localizations.AbilitiesName.rattled,
        description = Localizations.AbilitiesDescription.rattled},
    {
        id = 156,
        name = Localizations.AbilitiesName.magicBounce,
        description = Localizations.AbilitiesDescription.magicBounce},
    {
        id = 157,
        name = Localizations.AbilitiesName.sapSipper,
        description = Localizations.AbilitiesDescription.sapSipper},
    {
        id = 158,
        name = Localizations.AbilitiesName.prankster,
        description = Localizations.AbilitiesDescription.prankster},
    {
        id = 159,
        name = Localizations.AbilitiesName.sandForce,
        description = Localizations.AbilitiesDescription.sandForce},
    {
        id = 160,
        name = Localizations.AbilitiesName.ironBarbs,
        description = Localizations.AbilitiesDescription.ironBarbs},
    {
        id = 161,
        name = Localizations.AbilitiesName.zenMode,
        description = Localizations.AbilitiesDescription.zenMode},
    {
        id = 162,
        name = Localizations.AbilitiesName.victoryStar,
        description = Localizations.AbilitiesDescription.victoryStar},
    {
        id = 163,
        name = Localizations.AbilitiesName.turboblaze,
        description = Localizations.AbilitiesDescription.turboblaze},
    {
        id = 164,
        name = Localizations.AbilitiesName.teravolt,
        description = Localizations.AbilitiesDescription.teravolt}
}

-- Map a battle message id (key) to a list of ability id's (value) that could trigger it
AbilityData.BATTLE_MSGS_MASTER_LIST = {
    -- List: https://github.com/pret/pokeheartgold/blob/448bea8e0692a2affab92739e73e80d9636b7aa0/include/constants/battle_subscript.h
    GEN4 = {
        [12] = {3, 88}, -- 3:Speed Boost, 88:Download -- TODO: Speedboost requires testing (download works)
        --[ 16]  = { 83 }, -- 83:Anger Point, -- TODO: technically works but might false trigger, removing for now
        --[22] = {38}, -- 38:Poison Point, 27:Effect Spore *buggy
        --[18] = {27}, -- 27:Effect Spore
        [25] = {49}, -- 49:Flame Body
        [31] = {9}, -- 9:Static, 27:Effect Spore
        --[106] = {56}, -- 56:Cute Charm *buggy
        [177] = {104}, -- 104:Mold Breaker
        [178] = {10, 11, 87}, -- 10:Volt Absorb, 11:Water Absorb, 87:Dry Skin
        [179] = {18}, -- 18:Flash Fire
        [180] = {31, 114}, -- 31:Lightningrod, 114:Storm Drain
        [181] = {43}, -- 43:Soundproof
        [182] = {78}, -- 78:Motor Drive
        [183] = {2}, -- 2:Drizzle
        [184] = {45}, -- 45:Sand Stream
        [185] = {70}, -- 70:Drought
        [186] = {22}, -- 22:Intimidate
        [187] = {36}, -- 36:Trace
        [188] = {16}, -- 16:Color Change
        [189] = {24}, -- 24:Rough Skin
        [190] = {61}, -- 61:Shed Skin
        [191] = {54}, -- 54:Truant
        [192] = {44, 87}, -- 44:Rain Dish, 87:Dry Skin
        [193] = {106}, -- 106:Aftermath
        [194] = {107}, -- 107:Anticipation
        [195] = {108}, -- 108:Forewarn
        [196] = {112}, -- 112:Slow Start
        -- 7:Limber, 12:Oblivious, 15:Insomnia, 17:Immunity, 20:Own Tempo, 40:Magma Armor, 41:Water Veil, 72:Vital Spirit,
        --Disabled for being buggy
        --[221] = {7, 12, 15, 17, 20, 40, 41, 72},
        [252] = {117}, -- 117:Snow Warning
        [253] = {119}, -- 119:Frisk
        [285] = {46} -- 46:Pressure
    }
    --[[ Ability master list to test for Gen 4
		Static, flame body, pressure, mold breaker, frisk, forewarn, anticipation, anger point,
		poison point, effect spore, insomnia, flash fire, levitate, volt absorb, motor drive,
		water absorb, intimidate, download, hyper cutter, clear body, speed boost, own tempo,
		sturdy, drought, drizzle, snow warning, sand stream, immunity, steadfast, inner focus,
		oblivious, cute charm, aftermath, rough skin, damp, color change, suction cups, wonder guard,
		trace, water veil, soundproof, rain dish, keen eye, truant, slow start, shed skin, poison heal,
		hydration, solar power, ice body, bad dreams, and magic guard

		Other notes:
		Dry Skin doesnt work with rain, Syncrhonize seems tough to trigger on (be careful)
		-Clear body, white smoke, keen eye, hyper cutter all use 2 messages
	]]
}

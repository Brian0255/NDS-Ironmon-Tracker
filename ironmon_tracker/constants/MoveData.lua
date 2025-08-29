MoveData = {}


-- Move categories identify the type of attack a move is: physical, special, or status
MoveData.MOVE_CATEGORIES =
	MiscUtils.readOnly(
		{
			NONE = "NONE",
			PHYSICAL = "PHYSICAL",
			SPECIAL = "SPECIAL",
			STATUS = "STATUS"
		}
	)

MoveData.MOVES = {}

--Mapping of move types to move categories for gens 1-3
MoveData.TYPE_CATEGORIES =
	MiscUtils.readOnly(
		{
			[PokemonData.POKEMON_TYPES.NORMAL] = MoveData.MOVE_CATEGORIES.PHYSICAL,
			[PokemonData.POKEMON_TYPES.FIGHTING] = MoveData.MOVE_CATEGORIES.PHYSICAL,
			[PokemonData.POKEMON_TYPES.FLYING] = MoveData.MOVE_CATEGORIES.PHYSICAL,
			[PokemonData.POKEMON_TYPES.POISON] = MoveData.MOVE_CATEGORIES.PHYSICAL,
			[PokemonData.POKEMON_TYPES.GROUND] = MoveData.MOVE_CATEGORIES.PHYSICAL,
			[PokemonData.POKEMON_TYPES.ROCK] = MoveData.MOVE_CATEGORIES.PHYSICAL,
			[PokemonData.POKEMON_TYPES.BUG] = MoveData.MOVE_CATEGORIES.PHYSICAL,
			[PokemonData.POKEMON_TYPES.GHOST] = MoveData.MOVE_CATEGORIES.PHYSICAL,
			[PokemonData.POKEMON_TYPES.STEEL] = MoveData.MOVE_CATEGORIES.PHYSICAL,
			[PokemonData.POKEMON_TYPES.FIRE] = MoveData.MOVE_CATEGORIES.SPECIAL,
			[PokemonData.POKEMON_TYPES.WATER] = MoveData.MOVE_CATEGORIES.SPECIAL,
			[PokemonData.POKEMON_TYPES.GRASS] = MoveData.MOVE_CATEGORIES.SPECIAL,
			[PokemonData.POKEMON_TYPES.ELECTRIC] = MoveData.MOVE_CATEGORIES.SPECIAL,
			[PokemonData.POKEMON_TYPES.PSYCHIC] = MoveData.MOVE_CATEGORIES.SPECIAL,
			[PokemonData.POKEMON_TYPES.ICE] = MoveData.MOVE_CATEGORIES.SPECIAL,
			[PokemonData.POKEMON_TYPES.DRAGON] = MoveData.MOVE_CATEGORIES.SPECIAL,
			[PokemonData.POKEMON_TYPES.DARK] = MoveData.MOVE_CATEGORIES.SPECIAL
		}
	)

MoveData.EFFECTIVE_DATA = {
	NORMAL = { ROCK = 0.5, GHOST = 0, STEEL = 0.5 },
	FIRE = { FIRE = 0.5, WATER = 0.5, GRASS = 2, ICE = 2, BUG = 2, ROCK = 0.5, DRAGON = 0.5, STEEL = 2 },
	WATER = { FIRE = 2, WATER = 0.5, GRASS = 0.5, GROUND = 2, ROCK = 2, DRAGON = 0.5 },
	GRASS = {
		FIRE = 0.5,
		WATER = 2,
		GRASS = 0.5,
		POISON = 0.5,
		GROUND = 2,
		FLYING = 0.5,
		BUG = 0.5,
		ROCK = 2,
		DRAGON = 0.5,
		STEEL = 0.5
	},
	ELECTRIC = { WATER = 2, GRASS = 0.5, ELECTRIC = 0.5, GROUND = 0, FLYING = 2, DRAGON = 0.5 },
	ICE = { FIRE = 0.5, WATER = 0.5, GRASS = 2, ICE = 0.5, GROUND = 2, FLYING = 2, DRAGON = 2, STEEL = 0.5 },
	FIGHTING = {
		NORMAL = 2,
		ICE = 2,
		POISON = 0.5,
		FLYING = 0.5,
		PSYCHIC = 0.5,
		BUG = 0.5,
		ROCK = 2,
		GHOST = 0,
		DARK = 2,
		STEEL = 2
	},
	POISON = { GRASS = 2, POISON = 0.5, GROUND = 0.5, ROCK = 0.5, GHOST = 0.5, STEEL = 0 },
	GROUND = { FIRE = 2, GRASS = 0.5, ELECTRIC = 2, POISON = 2, FLYING = 0, BUG = 0.5, ROCK = 2, STEEL = 2 },
	FLYING = { GRASS = 2, ELECTRIC = 0.5, FIGHTING = 2, BUG = 2, ROCK = 0.5, STEEL = 0.5 },
	PSYCHIC = { FIGHTING = 2, POISON = 2, PSYCHIC = 0.5, DARK = 0, STEEL = 0.5 },
	BUG = {
		FIRE = 0.5,
		GRASS = 2,
		FIGHTING = 0.5,
		POISON = 0.5,
		FLYING = 0.5,
		PSYCHIC = 2,
		GHOST = 0.5,
		DARK = 2,
		STEEL = 0.5
	},
	ROCK = { FIRE = 2, ICE = 2, FIGHTING = 0.5, GROUND = 0.5, FLYING = 2, BUG = 2, STEEL = 0.5 },
	GHOST = { NORMAL = 0, PSYCHIC = 2, GHOST = 2, DARK = 0.5, STEEL = 0.5 },
	DRAGON = { DRAGON = 2, STEEL = 0.5 },
	DARK = { FIGHTING = 0.5, PSYCHIC = 2, GHOST = 2, DARK = 0.5, STEEL = 0.5 },
	STEEL = { FIRE = 0.5, WATER = 0.5, ICE = 2, ROCK = 2, STEEL = 0.5, ELECTRIC = 0.5 }
}

MoveData.MOVES_MASTER_LIST = {
	{
		--- Empty entry for move ID 0
		id = "---",
		name = "---",
		type = "---",
		power = Graphics.TEXT.NO_POWER,
		pp = Graphics.TEXT.NO_PP,
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.NONE,
		description = ""
	},
	{
		-- Begin Gen 1 Moves
		id = "1",
		name = Localizations.MoveNames.pound,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "40",
		pp = "35",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.pound
		}, {
		id = "2",
		name = Localizations.MoveNames.karateChop,
		type = {
			PokemonData.POKEMON_TYPES.NORMAL,
			PokemonData.POKEMON_TYPES.FIGHTING,
			PokemonData.POKEMON_TYPES.FIGHTING,
			PokemonData.POKEMON_TYPES.FIGHTING,
			PokemonData.POKEMON_TYPES.FIGHTING
		},
		power = "50",
		pp = "25",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.karateChop
	}, {
		id = "3",
		name = Localizations.MoveNames.doubleslap,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "15",
		pp = "10",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.doubleslap
	}, {
		id = "4",
		name = Localizations.MoveNames.cometPunch,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "18",
		pp = "15",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.cometPunch
	}, {
		id = "5",
		name = Localizations.MoveNames.megaPunch,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "80",
		pp = "20",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.megaPunch
	}, {
		id = "6",
		name = Localizations.MoveNames.payDay,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "40",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.payDay
	}, {
		id = "7",
		name = Localizations.MoveNames.firePunch,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "75",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.firePunch
	}, {
		id = "8",
		name = Localizations.MoveNames.icePunch,
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "75",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.icePunch
	}, {
		id = "9",
		name = Localizations.MoveNames.thunderpunch,
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "75",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.thunderpunch
	}, {
		id = "10",
		name = Localizations.MoveNames.scratch,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "40",
		pp = "35",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.scratch
	}, {
		id = "11",
		name = Localizations.MoveNames.vicegrip,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "55",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.vicegrip
	}, {
		id = "12",
		name = Localizations.MoveNames.guillotine,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = "30",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.guillotine
	}, {
		id = "13",
		name = Localizations.MoveNames.razorWind,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "80",
		pp = "10",
		accuracy = { "75", "75", "100", "100", "100" },
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.razorWind
	}, {
		id = "14",
		name = Localizations.MoveNames.swordsDance,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.swordsDance
	}, {
		id = "15",
		name = Localizations.MoveNames.cut,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "50",
		pp = "30",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.cut
	}, {
		id = "16",
		name = Localizations.MoveNames.gust,
		type = {
			PokemonData.POKEMON_TYPES.NORMAL,
			PokemonData.POKEMON_TYPES.FLYING,
			PokemonData.POKEMON_TYPES.FLYING,
			PokemonData.POKEMON_TYPES.FLYING,
			PokemonData.POKEMON_TYPES.FLYING
		},
		power = "40",
		pp = "35",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.gust
	}, {
		id = "17",
		name = Localizations.MoveNames.wingAttack,
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = { "35", "60", "60", "60", "60" },
		pp = "35",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.wingAttack
	}, {
		id = "18",
		name = Localizations.MoveNames.whirlwind,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = { "85", "100", "100", "100", "100" },
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.whirlwind
	}, {
		id = "19",
		name = Localizations.MoveNames.fly,
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = { "70", "70", "70", "90", "90" },
		pp = "15",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.fly
	}, {
		id = "20",
		name = Localizations.MoveNames.bind,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "15",
		pp = "20",
		accuracy = { "75", "75", "75", "75", "85" },
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.bind
	}, {
		id = "21",
		name = Localizations.MoveNames.slam,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "80",
		pp = "20",
		accuracy = "75",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.slam
	}, {
		id = "22",
		name = Localizations.MoveNames.vineWhip,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "35",
		pp = { "10", "10", "10", "15", "15" },
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.vineWhip
	}, {
		id = "23",
		name = Localizations.MoveNames.stomp,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "65",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.stomp
	}, {
		id = "24",
		name = Localizations.MoveNames.doubleKick,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "30",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.doubleKick
	}, {
		id = "25",
		name = Localizations.MoveNames.megaKick,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "120",
		pp = "5",
		accuracy = "75",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.megaKick
	}, {
		id = "26",
		name = Localizations.MoveNames.jumpKick,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = { "70", "70", "70", "85", "100" },
		pp = { "25", "25", "25", "25", "10" },
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.jumpKick
	}, {
		id = "27",
		name = Localizations.MoveNames.rollingKick,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "60",
		pp = "15",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.rollingKick
	}, {
		id = "28",
		name = Localizations.MoveNames.sandattack,
		type = {
			PokemonData.POKEMON_TYPES.NORMAL,
			PokemonData.POKEMON_TYPES.GROUND,
			PokemonData.POKEMON_TYPES.GROUND,
			PokemonData.POKEMON_TYPES.GROUND,
			PokemonData.POKEMON_TYPES.GROUND
		},
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.sandattack
	}, {
		id = "29",
		name = Localizations.MoveNames.headbutt,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "70",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.headbutt
	}, {
		id = "30",
		name = Localizations.MoveNames.hornAttack,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "65",
		pp = "25",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.hornAttack
	}, {
		id = "31",
		name = Localizations.MoveNames.furyAttack,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "15",
		pp = "20",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.furyAttack
	}, {
		id = "32",
		name = Localizations.MoveNames.hornDrill,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = "30",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.hornDrill
	}, {
		id = "33",
		name = Localizations.MoveNames.tackle,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = { "35", "35", "35", "35", "50" },
		pp = "35",
		accuracy = { "95", "95", "95", "95", "100" },
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.tackle
	}, {
		id = "34",
		name = Localizations.MoveNames.bodySlam,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "85",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.bodySlam
	}, {
		id = "35",
		name = Localizations.MoveNames.wrap,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "15",
		pp = "20",
		accuracy = { "85", "85", "85", "85", "90" },
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.wrap
	}, {
		id = "36",
		name = Localizations.MoveNames.takeDown,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "90",
		pp = "20",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.takeDown
	}, {
		id = "37",
		name = Localizations.MoveNames.thrash,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = { "90", "90", "90", "90", "120" },
		pp = { "20", "20", "20", "20", "10" },
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.thrash
	}, {
		id = "38",
		name = Localizations.MoveNames.doubleedge,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = { "100", "120", "120", "120", "120" },
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.doubleedge
	}, {
		id = "39",
		name = Localizations.MoveNames.tailWhip,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.tailWhip
	}, {
		id = "40",
		name = Localizations.MoveNames.poisonSting,
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "15",
		pp = "35",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.poisonSting
	}, {
		id = "41",
		name = Localizations.MoveNames.twineedle,
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "25",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.twineedle
	}, {
		id = "42",
		name = Localizations.MoveNames.pinMissile,
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "14",
		pp = "20",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.pinMissile
	}, {
		id = "43",
		name = Localizations.MoveNames.leer,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.leer
	}, {
		id = "44",
		name = Localizations.MoveNames.bite,
		type = {
			PokemonData.POKEMON_TYPES.NORMAL,
			PokemonData.POKEMON_TYPES.DARK,
			PokemonData.POKEMON_TYPES.DARK,
			PokemonData.POKEMON_TYPES.DARK,
			PokemonData.POKEMON_TYPES.DARK
		},
		power = "60",
		pp = "25",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.bite
	}, {
		id = "45",
		name = Localizations.MoveNames.growl,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.growl
	}, {
		id = "46",
		name = Localizations.MoveNames.roar,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.roar
	}, {
		id = "47",
		name = Localizations.MoveNames.sing,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "55",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.sing
	}, {
		id = "48",
		name = Localizations.MoveNames.supersonic,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "55",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.supersonic
	}, {
		id = "49",
		name = Localizations.MoveNames.sonicboom,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "---",
		pp = "20",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.sonicboom
	}, {
		id = "50",
		name = Localizations.MoveNames.disable,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = { "55", "55", "55", "80", "100" },
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.disable
	}, {
		id = "51",
		name = Localizations.MoveNames.acid,
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "40",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.acid
	}, {
		id = "52",
		name = Localizations.MoveNames.ember,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "40",
		pp = "25",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.ember
	}, {
		id = "53",
		name = Localizations.MoveNames.flamethrower,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "95",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.flamethrower
	}, {
		id = "54",
		name = Localizations.MoveNames.mist,
		type = PokemonData.POKEMON_TYPES.ICE,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.mist
	}, {
		id = "55",
		name = Localizations.MoveNames.waterGun,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "40",
		pp = "25",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.waterGun
	}, {
		id = "56",
		name = Localizations.MoveNames.hydroPump,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "120",
		pp = "5",
		accuracy = "80",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.hydroPump
	}, {
		id = "57",
		name = Localizations.MoveNames.surf,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "95",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.surf
	}, {
		id = "58",
		name = Localizations.MoveNames.iceBeam,
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "95",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.iceBeam
	}, {
		id = "59",
		name = Localizations.MoveNames.blizzard,
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "120",
		pp = "5",
		accuracy = { "90", "70", "70", "70", "70" },
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.blizzard
	}, {
		id = "60",
		name = Localizations.MoveNames.psybeam,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "65",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.psybeam
	}, {
		id = "61",
		name = Localizations.MoveNames.bubblebeam,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "65",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.bubblebeam
	}, {
		id = "62",
		name = Localizations.MoveNames.auroraBeam,
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "65",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.auroraBeam
	}, {
		id = "63",
		name = Localizations.MoveNames.hyperBeam,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "150",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.hyperBeam
	}, {
		id = "64",
		name = Localizations.MoveNames.peck,
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "35",
		pp = "35",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.peck
	}, {
		id = "65",
		name = Localizations.MoveNames.drillPeck,
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "80",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.drillPeck
	}, {
		id = "66",
		name = Localizations.MoveNames.submission,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "80",
		pp = "25",
		accuracy = "80",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.submission
	}, {
		id = "67",
		name = Localizations.MoveNames.lowKick,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = { "50", "50", "WT", "WT", "WT" },
		pp = "20",
		accuracy = { "90", "90", "100", "100", "100" },
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.lowKick
	}, {
		id = "68",
		name = Localizations.MoveNames.counter,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.counter
	}, {
		id = "69",
		name = Localizations.MoveNames.seismicToss,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.seismicToss
	}, {
		id = "70",
		name = Localizations.MoveNames.strength,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.strength
	}, {
		id = "71",
		name = Localizations.MoveNames.absorb,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = 20,
		pp = { "20", "20", "20", "25", "25" },
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.absorb
	}, {
		id = "72",
		name = Localizations.MoveNames.megaDrain,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "40",
		pp = { "10", "10", "10", "15", "15" },
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.megaDrain
	}, {
		id = "73",
		name = Localizations.MoveNames.leechSeed,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.leechSeed
	}, {
		id = "74",
		name = Localizations.MoveNames.growth,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.growth
	}, {
		id = "75",
		name = Localizations.MoveNames.razorLeaf,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "55",
		pp = "25",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.razorLeaf
	}, {
		id = "76",
		name = Localizations.MoveNames.solarbeam,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "120",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.solarbeam
	}, {
		id = "77",
		name = Localizations.MoveNames.poisonpowder,
		type = PokemonData.POKEMON_TYPES.POISON,
		power = Graphics.TEXT.NO_POWER,
		pp = "35",
		accuracy = "75",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.poisonpowder
	}, {
		id = "78",
		name = Localizations.MoveNames.stunSpore,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = "75",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.stunSpore
	}, {
		id = "79",
		name = Localizations.MoveNames.sleepPowder,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "75",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.sleepPowder
	}, {
		id = "80",
		name = Localizations.MoveNames.petalDance,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = { "70", "70", "70", "90", "120" },
		pp = { "20", "20", "20", "20", "10" },
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.petalDance
	}, {
		id = "81",
		name = Localizations.MoveNames.stringShot,
		type = PokemonData.POKEMON_TYPES.BUG,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.stringShot
	}, {
		id = "82",
		name = Localizations.MoveNames.dragonRage,
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = "---",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.dragonRage
	}, {
		id = "83",
		name = Localizations.MoveNames.fireSpin,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = { "15", "15", "15", "15", "35" },
		pp = "15",
		accuracy = { "70", "70", "70", "70", "85" },
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.fireSpin
	}, {
		id = "84",
		name = Localizations.MoveNames.thundershock,
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "40",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.thundershock
	}, {
		id = "85",
		name = Localizations.MoveNames.thunderbolt,
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "95",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.thunderbolt
	}, {
		id = "86",
		name = Localizations.MoveNames.thunderWave,
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.thunderWave
	}, {
		id = "87",
		name = Localizations.MoveNames.thunder,
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "120",
		pp = "10",
		accuracy = "70",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.thunder
	}, {
		id = "88",
		name = Localizations.MoveNames.rockThrow,
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = "50",
		pp = "15",
		accuracy = { "65", "90", "90", "90", "90" },
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.rockThrow
	}, {
		id = "89",
		name = Localizations.MoveNames.earthquake,
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = "100",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.earthquake
	}, {
		id = "90",
		name = Localizations.MoveNames.fissure,
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = "30",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.fissure
	}, {
		id = "91",
		name = Localizations.MoveNames.dig,
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = { "100", "60", "60", "80", "80" },
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.dig
	}, {
		id = "92",
		name = Localizations.MoveNames.toxic,
		type = PokemonData.POKEMON_TYPES.POISON,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = { "85", "85", "85", "85", "90" },
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.toxic
	}, {
		id = "93",
		name = Localizations.MoveNames.confusion,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "50",
		pp = "25",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.confusion
	}, {
		id = "94",
		name = Localizations.MoveNames.psychic,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "90",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.psychic
	}, {
		id = "95",
		name = Localizations.MoveNames.hypnosis,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "60",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.hypnosis
	}, {
		id = "96",
		name = Localizations.MoveNames.meditate,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.meditate
	}, {
		id = "97",
		name = Localizations.MoveNames.agility,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.agility
	}, {
		id = "98",
		name = Localizations.MoveNames.quickAttack,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "40",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.quickAttack
	}, {
		id = "99",
		name = Localizations.MoveNames.rage,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "20",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.rage
	}, {
		id = "100",
		name = Localizations.MoveNames.teleport,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.teleport
	}, {
		id = "101",
		name = Localizations.MoveNames.nightShade,
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.nightShade
	}, {
		id = "102",
		name = Localizations.MoveNames.mimic,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = { "100", "100", Graphics.TEXT.ALWAYS_HITS, Graphics.TEXT.ALWAYS_HITS, Graphics.TEXT.ALWAYS_HITS },
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.mimic
	}, {
		id = "103",
		name = Localizations.MoveNames.screech,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.screech
	}, {
		id = "104",
		name = Localizations.MoveNames.doubleTeam,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.doubleTeam
	}, {
		id = "105",
		name = Localizations.MoveNames.recover,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = { "20", "20", "20", "10", "10" },
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.recover
	}, {
		id = "106",
		name = Localizations.MoveNames.harden,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.harden
	}, {
		id = "107",
		name = Localizations.MoveNames.minimize,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.minimize
	}, {
		id = "108",
		name = Localizations.MoveNames.smokescreen,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.smokescreen
	}, {
		id = "109",
		name = Localizations.MoveNames.confuseRay,
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.confuseRay
	}, {
		id = "110",
		name = Localizations.MoveNames.withdraw,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.withdraw
	}, {
		id = "111",
		name = Localizations.MoveNames.defenseCurl,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.defenseCurl
	}, {
		id = "112",
		name = Localizations.MoveNames.barrier,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.barrier
	}, {
		id = "113",
		name = Localizations.MoveNames.lightScreen,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.lightScreen
	}, {
		id = "114",
		name = Localizations.MoveNames.haze,
		type = PokemonData.POKEMON_TYPES.ICE,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.haze
	}, {
		id = "115",
		name = Localizations.MoveNames.reflect,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.reflect
	}, {
		id = "116",
		name = Localizations.MoveNames.focusEnergy,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.focusEnergy
	}, {
		id = "117",
		name = Localizations.MoveNames.bide,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = { "100", "100", "100", Graphics.TEXT.ALWAYS_HITS, Graphics.TEXT.ALWAYS_HITS },
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.bide
	}, {
		id = "118",
		name = Localizations.MoveNames.metronome,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.metronome
	}, {
		id = "119",
		name = Localizations.MoveNames.mirrorMove,
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.mirrorMove
	}, {
		id = "120",
		name = Localizations.MoveNames.selfdestruct,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = { "130", "200", "200", "200", "200" },
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.selfdestruct
	}, {
		id = "121",
		name = Localizations.MoveNames.eggBomb,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "100",
		pp = "10",
		accuracy = "75",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.eggBomb
	}, {
		id = "122",
		name = Localizations.MoveNames.lick,
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = "20",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.lick
	}, {
		id = "123",
		name = Localizations.MoveNames.smog,
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "20",
		pp = "20",
		accuracy = "70",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.smog
	}, {
		id = "124",
		name = Localizations.MoveNames.sludge,
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "65",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.sludge
	}, {
		id = "125",
		name = Localizations.MoveNames.boneClub,
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = "65",
		pp = "20",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.boneClub
	}, {
		id = "126",
		name = Localizations.MoveNames.fireBlast,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "120",
		pp = "5",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.fireBlast
	}, {
		id = "127",
		name = Localizations.MoveNames.waterfall,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.waterfall
	}, {
		id = "128",
		name = Localizations.MoveNames.clamp,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "35",
		pp = { "10", "10", "10", "10", "15" },
		accuracy = { "75", "75", "75", "75", "85" },
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.clamp
	}, {
		id = "129",
		name = Localizations.MoveNames.swift,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "60",
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.swift
	}, {
		id = "130",
		name = Localizations.MoveNames.skullBash,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "100",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.skullBash
	}, {
		id = "131",
		name = Localizations.MoveNames.spikeCannon,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "20",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.spikeCannon
	}, {
		id = "132",
		name = Localizations.MoveNames.constrict,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "10",
		pp = "35",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.constrict
	}, {
		id = "133",
		name = Localizations.MoveNames.amnesia,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.amnesia
	}, {
		id = "134",
		name = Localizations.MoveNames.kinesis,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "80",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.kinesis
	}, {
		id = "135",
		name = Localizations.MoveNames.softboiled,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.softboiled
	}, {
		id = "136",
		name = Localizations.MoveNames.hiJumpKick,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = { "85", "85", "85", "100", "130" },
		pp = { "20", "20", "20", "20", "10" },
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.hiJumpKick
	}, {
		id = "137",
		name = Localizations.MoveNames.glare,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = { "75", "75", "75", "75", "90" },
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.glare
	}, {
		id = "138",
		name = Localizations.MoveNames.dreamEater,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "100",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.dreamEater
	}, {
		id = "139",
		name = Localizations.MoveNames.poisonGas,
		type = PokemonData.POKEMON_TYPES.POISON,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = { "55", "55", "55", "55", "80" },
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.poisonGas
	}, {
		id = "140",
		name = Localizations.MoveNames.barrage,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "15",
		pp = "20",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.barrage
	}, {
		id = "141",
		name = Localizations.MoveNames.leechLife,
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "20",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.leechLife
	}, {
		id = "142",
		name = Localizations.MoveNames.lovelyKiss,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "75",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.lovelyKiss
	}, {
		id = "143",
		name = Localizations.MoveNames.skyAttack,
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "140",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.skyAttack
	}, {
		id = "144",
		name = Localizations.MoveNames.transform,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.transform
	}, {
		id = "145",
		name = Localizations.MoveNames.bubble,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "20",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.bubble
	}, {
		id = "146",
		name = Localizations.MoveNames.dizzyPunch,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "70",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.dizzyPunch
	}, {
		id = "147",
		name = Localizations.MoveNames.spore,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.spore
	}, {
		id = "148",
		name = Localizations.MoveNames.flash,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = { "70", "70", "70", "100", "100" },
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.flash
	}, {
		id = "149",
		name = Localizations.MoveNames.psywave,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "80",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.psywave
	}, {
		id = "150",
		name = Localizations.MoveNames.splash,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.splash
	}, {
		id = "151",
		name = Localizations.MoveNames.acidArmor,
		type = PokemonData.POKEMON_TYPES.POISON,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.acidArmor
	}, {
		id = "152",
		name = Localizations.MoveNames.crabhammer,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "90",
		pp = "10",
		accuracy = { "85", "85", "85", "85", "90" },
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.crabhammer
	}, {
		id = "153",
		name = Localizations.MoveNames.explosion,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = { "170", "250", "250", "250", "250" },
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.explosion
	}, {
		id = "154",
		name = Localizations.MoveNames.furySwipes,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "18",
		pp = "15",
		accuracy = "80",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.furySwipes
	}, {
		id = "155",
		name = Localizations.MoveNames.bonemerang,
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = "50",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.bonemerang
	}, {
		id = "156",
		name = Localizations.MoveNames.rest,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.rest
	}, {
		id = "157",
		name = Localizations.MoveNames.rockSlide,
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = "75",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.rockSlide
	}, {
		id = "158",
		name = Localizations.MoveNames.hyperFang,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "80",
		pp = "15",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.hyperFang
	}, {
		id = "159",
		name = Localizations.MoveNames.sharpen,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.sharpen
	}, {
		id = "160",
		name = Localizations.MoveNames.conversion,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.conversion
	}, {
		id = "161",
		name = Localizations.MoveNames.triAttack,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "80",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.triAttack
	}, {
		id = "162",
		name = Localizations.MoveNames.superFang,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.superFang
	}, {
		id = "163",
		name = Localizations.MoveNames.slash,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "70",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.slash
	}, {
		id = "164",
		name = Localizations.MoveNames.substitute,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.substitute
	}, {
		id = "165",
		name = Localizations.MoveNames.struggle,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "50",
		pp = { "10", "1", "1", "1", "1" },
		accuracy = { "100", "100", "100", Graphics.TEXT.ALWAYS_HITS, Graphics.TEXT.ALWAYS_HITS },
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.struggle
	}, {
		-- Begin Gen 2 Moves
		id = "166",
		name = Localizations.MoveNames.sketch,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "1",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.sketch
	}, {
		id = "167",
		name = Localizations.MoveNames.tripleKick,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "10",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.tripleKick
	}, {
		id = "168",
		name = Localizations.MoveNames.thief,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "40",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.thief
	}, {
		id = "169",
		name = Localizations.MoveNames.spiderWeb,
		type = PokemonData.POKEMON_TYPES.BUG,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.spiderWeb
	}, {
		id = "170",
		name = Localizations.MoveNames.mindReader,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = { "100", "100", "100", Graphics.TEXT.ALWAYS_HITS, Graphics.TEXT.ALWAYS_HITS },
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.mindReader
	}, {
		id = "171",
		name = Localizations.MoveNames.nightmare,
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.nightmare
	}, {
		id = "172",
		name = Localizations.MoveNames.flameWheel,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "60",
		pp = "25",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.flameWheel
	}, {
		id = "173",
		name = Localizations.MoveNames.snore,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "40",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.snore
	}, {
		id = "174",
		name = Localizations.MoveNames.curse,
		type = {
			PokemonData.POKEMON_TYPES.UNKNOWN,
			PokemonData.POKEMON_TYPES.UNKNOWN,
			PokemonData.POKEMON_TYPES.UNKNOWN,
			PokemonData.POKEMON_TYPES.UNKNOWN,
			PokemonData.POKEMON_TYPES.GHOST
		},
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.curse
	}, {
		id = "175",
		name = Localizations.MoveNames.flail,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "<HP",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.flail
	}, {
		id = "176",
		name = Localizations.MoveNames.conversion2,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.conversion2
	}, {
		id = "177",
		name = Localizations.MoveNames.aeroblast,
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "100",
		pp = "5",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.aeroblast
	}, {
		id = "178",
		name = Localizations.MoveNames.cottonSpore,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = { "85", "85", "85", "85", "100" },
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.cottonSpore
	}, {
		id = "179",
		name = Localizations.MoveNames.reversal,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "<HP",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.reversal
	}, {
		id = "180",
		name = Localizations.MoveNames.spite,
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.spite
	}, {
		id = "181",
		name = Localizations.MoveNames.powderSnow,
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "40",
		pp = "25",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.powderSnow
	}, {
		id = "182",
		name = Localizations.MoveNames.protect,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.protect
	}, {
		id = "183",
		name = Localizations.MoveNames.machPunch,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "40",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.machPunch
	}, {
		id = "184",
		name = Localizations.MoveNames.scaryFace,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = { "90", "90", "90", "90", "100" },
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.scaryFace
	}, {
		id = "185",
		name = Localizations.MoveNames.faintAttack,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "60",
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.faintAttack
	}, {
		id = "186",
		name = Localizations.MoveNames.sweetKiss,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "75",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.sweetKiss
	}, {
		id = "187",
		name = Localizations.MoveNames.bellyDrum,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.bellyDrum
	}, {
		id = "188",
		name = Localizations.MoveNames.sludgeBomb,
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "90",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.sludgeBomb
	}, {
		id = "189",
		name = Localizations.MoveNames.mudslap,
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = "20",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.mudslap
	}, {
		id = "190",
		name = Localizations.MoveNames.octazooka,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "65",
		pp = "10",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.octazooka
	}, {
		id = "191",
		name = Localizations.MoveNames.spikes,
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.spikes
	}, {
		id = "192",
		name = Localizations.MoveNames.zapCannon,
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = { "100", "100", "100", "120", "120" },
		pp = "5",
		accuracy = "50",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.zapCannon
	}, {
		id = "193",
		name = Localizations.MoveNames.foresight,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = { "100", "100", "100", Graphics.TEXT.ALWAYS_HITS, Graphics.TEXT.ALWAYS_HITS },
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.foresight
	}, {
		id = "194",
		name = Localizations.MoveNames.destinyBond,
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.destinyBond
	}, {
		id = "195",
		name = Localizations.MoveNames.perishSong,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.perishSong
	}, {
		id = "196",
		name = Localizations.MoveNames.icyWind,
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "55",
		pp = "15",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.icyWind
	}, {
		id = "197",
		name = Localizations.MoveNames.detect,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.detect
	}, {
		id = "198",
		name = Localizations.MoveNames.boneRush,
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = "25",
		pp = "10",
		accuracy = { "80", "80", "80", "80", "90" },
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.boneRush
	}, {
		id = "199",
		name = Localizations.MoveNames.lockon,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = { "100", "100", "100", Graphics.TEXT.ALWAYS_HITS, Graphics.TEXT.ALWAYS_HITS },
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.lockon
	}, {
		id = "200",
		name = Localizations.MoveNames.outrage,
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = { "90", "90", "90", "120", "120" },
		pp = { "15", "15", "15", "15", "10" },
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.outrage
	}, {
		id = "201",
		name = Localizations.MoveNames.sandstorm,
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.sandstorm
	}, {
		id = "202",
		name = Localizations.MoveNames.gigaDrain,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = { "60", "60", "60", "60", "75" },
		pp = { "5", "5", "5", "10", "10" },
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.gigaDrain
	}, {
		id = "203",
		name = Localizations.MoveNames.endure,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.endure
	}, {
		id = "204",
		name = Localizations.MoveNames.charm,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.charm
	}, {
		id = "205",
		name = Localizations.MoveNames.rollout,
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = "30",
		pp = "20",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.rollout
	}, {
		id = "206",
		name = Localizations.MoveNames.falseSwipe,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "40",
		pp = "40",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.falseSwipe
	}, {
		id = "207",
		name = Localizations.MoveNames.swagger,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.swagger
	}, {
		id = "208",
		name = Localizations.MoveNames.milkDrink,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.milkDrink
	}, {
		id = "209",
		name = Localizations.MoveNames.spark,
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "65",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.spark
	}, {
		id = "210",
		name = Localizations.MoveNames.furyCutter,
		type = PokemonData.POKEMON_TYPES.BUG,
		power = { "10", "10", "10", "10", "20" },
		pp = "20",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.furyCutter
	}, {
		id = "211",
		name = Localizations.MoveNames.steelWing,
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = "70",
		pp = "25",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.steelWing
	}, {
		id = "212",
		name = Localizations.MoveNames.meanLook,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.meanLook
	}, {
		id = "213",
		name = Localizations.MoveNames.attract,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.attract
	}, {
		id = "214",
		name = Localizations.MoveNames.sleepTalk,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.sleepTalk
	}, {
		id = "215",
		name = Localizations.MoveNames.healBell,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.healBell
	}, {
		id = "216",
		name = Localizations.MoveNames.returnMove,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = ">FR",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.returnMove
	}, {
		id = "217",
		name = Localizations.MoveNames.present,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "RNG",
		pp = "15",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.present
	}, {
		id = "218",
		name = Localizations.MoveNames.frustration,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "<FR",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.frustration
	}, {
		id = "219",
		name = Localizations.MoveNames.safeguard,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "25",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.safeguard
	}, {
		id = "220",
		name = Localizations.MoveNames.painSplit,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = { "100", "100", Graphics.TEXT.ALWAYS_HITS, Graphics.TEXT.ALWAYS_HITS, Graphics.TEXT.ALWAYS_HITS },
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.painSplit
	}, {
		id = "221",
		name = Localizations.MoveNames.sacredFire,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "100",
		pp = "5",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.sacredFire
	}, {
		id = "222",
		name = Localizations.MoveNames.magnitude,
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = "RNG",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.magnitude
	}, {
		id = "223",
		name = Localizations.MoveNames.dynamicpunch,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "100",
		pp = "5",
		accuracy = "50",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.dynamicpunch
	}, {
		id = "224",
		name = Localizations.MoveNames.megahorn,
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "120",
		pp = "10",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.megahorn
	}, {
		id = "225",
		name = Localizations.MoveNames.dragonbreath,
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = "60",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.dragonbreath
	}, {
		id = "226",
		name = Localizations.MoveNames.batonPass,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.batonPass
	}, {
		id = "227",
		name = Localizations.MoveNames.encore,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.encore
	}, {
		id = "228",
		name = Localizations.MoveNames.pursuit,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "40",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.pursuit
	}, {
		id = "229",
		name = Localizations.MoveNames.rapidSpin,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "20",
		pp = "40",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.rapidSpin
	}, {
		id = "230",
		name = Localizations.MoveNames.sweetScent,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.sweetScent
	}, {
		id = "231",
		name = Localizations.MoveNames.ironTail,
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = "100",
		pp = "15",
		accuracy = "75",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.ironTail
	}, {
		id = "232",
		name = Localizations.MoveNames.metalClaw,
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = "50",
		pp = "35",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.metalClaw
	}, {
		id = "233",
		name = Localizations.MoveNames.vitalThrow,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "70",
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.vitalThrow
	}, {
		id = "234",
		name = Localizations.MoveNames.morningSun,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.morningSun
	}, {
		id = "235",
		name = Localizations.MoveNames.synthesis,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.synthesis
	}, {
		id = "236",
		name = Localizations.MoveNames.moonlight,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.moonlight
	}, {
		id = "237",
		name = Localizations.MoveNames.hiddenPower,
		type = PokemonData.POKEMON_TYPES.UNKNOWN,
		power = "VAR",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.hiddenPower
	}, {
		id = "238",
		name = Localizations.MoveNames.crossChop,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "100",
		pp = "5",
		accuracy = "80",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.crossChop
	}, {
		id = "239",
		name = Localizations.MoveNames.twister,
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = "40",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.twister
	}, {
		id = "240",
		name = Localizations.MoveNames.rainDance,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.rainDance
	}, {
		id = "241",
		name = Localizations.MoveNames.sunnyDay,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.sunnyDay
	}, {
		id = "242",
		name = Localizations.MoveNames.crunch,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.crunch
	}, {
		id = "243",
		name = Localizations.MoveNames.mirrorCoat,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.mirrorCoat
	}, {
		id = "244",
		name = Localizations.MoveNames.psychUp,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.psychUp
	}, {
		id = "245",
		name = Localizations.MoveNames.extremespeed,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "80",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.extremespeed
	}, {
		id = "246",
		name = Localizations.MoveNames.ancientpower,
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = "60",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.ancientpower
	}, {
		id = "247",
		name = Localizations.MoveNames.shadowBall,
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.shadowBall
	}, {
		id = "248",
		name = Localizations.MoveNames.futureSight,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = { "80", "80", "80", "80", "100" },
		pp = { "15", "15", "15", "15", "10" },
		accuracy = { "90", "90", "90", "90", "100" },
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.futureSight
	}, {
		id = "249",
		name = Localizations.MoveNames.rockSmash,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = { "20", "20", "20", "40", "40" },
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.rockSmash
	}, {
		id = "250",
		name = Localizations.MoveNames.whirlpool,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = { "15", "15", "15", "15", "35" },
		pp = "15",
		accuracy = { "70", "70", "70", "70", "85" },
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.whirlpool
	}, {
		id = "251",
		name = Localizations.MoveNames.beatUp,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = { "10", "10", "10", "10", "VAR" },
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.beatUp
	}, {
		-- Begin Gen 3 Moves
		id = "252",
		name = Localizations.MoveNames.fakeOut,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "40",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.fakeOut
	}, {
		id = "253",
		name = Localizations.MoveNames.uproar,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = { "50", "50", "50", "50", "90" },
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.uproar
	}, {
		id = "254",
		name = Localizations.MoveNames.stockpile,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = { "10", "10", "10", "20", "20" },
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.stockpile
	}, {
		id = "255",
		name = Localizations.MoveNames.spitUp,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.spitUp
	}, {
		id = "256",
		name = Localizations.MoveNames.swallow,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.swallow
	}, {
		id = "257",
		name = Localizations.MoveNames.heatWave,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "100",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.heatWave
	}, {
		id = "258",
		name = Localizations.MoveNames.hail,
		type = PokemonData.POKEMON_TYPES.ICE,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.hail
	}, {
		id = "259",
		name = Localizations.MoveNames.torment,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.torment
	}, {
		id = "260",
		name = Localizations.MoveNames.flatter,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.flatter
	}, {
		id = "261",
		name = Localizations.MoveNames.willowisp,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "75",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.willowisp
	}, {
		id = "262",
		name = Localizations.MoveNames.memento,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.memento
	}, {
		id = "263",
		name = Localizations.MoveNames.facade,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "70",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.facade
	}, {
		id = "264",
		name = Localizations.MoveNames.focusPunch,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "150",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.focusPunch
	}, {
		id = "265",
		name = Localizations.MoveNames.smellingsalt,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "60",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.smellingsalt
	}, {
		id = "266",
		name = Localizations.MoveNames.followMe,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.followMe
	}, {
		id = "267",
		name = Localizations.MoveNames.naturePower,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.naturePower
	}, {
		id = "268",
		name = Localizations.MoveNames.charge,
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.charge
	}, {
		id = "269",
		name = Localizations.MoveNames.taunt,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.taunt
	}, {
		id = "270",
		name = Localizations.MoveNames.helpingHand,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.helpingHand
	}, {
		id = "271",
		name = Localizations.MoveNames.trick,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.trick
	}, {
		id = "272",
		name = Localizations.MoveNames.rolePlay,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.rolePlay
	}, {
		id = "273",
		name = Localizations.MoveNames.wish,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.wish
	}, {
		id = "274",
		name = Localizations.MoveNames.assist,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.assist
	}, {
		id = "275",
		name = Localizations.MoveNames.ingrain,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.ingrain
	}, {
		id = "276",
		name = Localizations.MoveNames.superpower,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "120",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.superpower
	}, {
		id = "277",
		name = Localizations.MoveNames.magicCoat,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.magicCoat
	}, {
		id = "278",
		name = Localizations.MoveNames.recycle,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.recycle
	}, {
		id = "279",
		name = Localizations.MoveNames.revenge,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "60",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.revenge
	}, {
		id = "280",
		name = Localizations.MoveNames.brickBreak,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "75",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.brickBreak
	}, {
		id = "281",
		name = Localizations.MoveNames.yawn,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.yawn
	}, {
		id = "282",
		name = Localizations.MoveNames.knockOff,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "20",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.knockOff
	}, {
		id = "283",
		name = Localizations.MoveNames.endeavor,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.endeavor
	}, {
		id = "284",
		name = Localizations.MoveNames.eruption,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = ">HP",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.eruption
	}, {
		id = "285",
		name = Localizations.MoveNames.skillSwap,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.skillSwap
	}, {
		id = "286",
		name = Localizations.MoveNames.imprison,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.imprison
	}, {
		id = "287",
		name = Localizations.MoveNames.refresh,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.refresh
	}, {
		id = "288",
		name = Localizations.MoveNames.grudge,
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.grudge
	}, {
		id = "289",
		name = Localizations.MoveNames.snatch,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.snatch
	}, {
		id = "290",
		name = Localizations.MoveNames.secretPower,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "70",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.secretPower
	}, {
		id = "291",
		name = Localizations.MoveNames.dive,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = { "60", "60", "60", "80", "80" },
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.dive
	}, {
		id = "292",
		name = Localizations.MoveNames.armThrust,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "15",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.armThrust
	}, {
		id = "293",
		name = Localizations.MoveNames.camouflage,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.camouflage
	}, {
		id = "294",
		name = Localizations.MoveNames.tailGlow,
		type = PokemonData.POKEMON_TYPES.BUG,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.tailGlow
	}, {
		id = "295",
		name = Localizations.MoveNames.lusterPurge,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "70",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.lusterPurge
	}, {
		id = "296",
		name = Localizations.MoveNames.mistBall,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "70",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.mistBall
	}, {
		id = "297",
		name = Localizations.MoveNames.featherdance,
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.featherdance
	}, {
		id = "298",
		name = Localizations.MoveNames.teeterDance,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.teeterDance
	}, {
		id = "299",
		name = Localizations.MoveNames.blazeKick,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "85",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.blazeKick
	}, {
		id = "300",
		name = Localizations.MoveNames.mudSport,
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.mudSport
	}, {
		id = "301",
		name = Localizations.MoveNames.iceBall,
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "30",
		pp = "20",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.iceBall
	}, {
		id = "302",
		name = Localizations.MoveNames.needleArm,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "60",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.needleArm
	}, {
		id = "303",
		name = Localizations.MoveNames.slackOff,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.slackOff
	}, {
		id = "304",
		name = Localizations.MoveNames.hyperVoice,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "90",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.hyperVoice
	}, {
		id = "305",
		name = Localizations.MoveNames.poisonFang,
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "50",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.poisonFang
	}, {
		id = "306",
		name = Localizations.MoveNames.crushClaw,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "75",
		pp = "10",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.crushClaw
	}, {
		id = "307",
		name = Localizations.MoveNames.blastBurn,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "150",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.blastBurn
	}, {
		id = "308",
		name = Localizations.MoveNames.hydroCannon,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "150",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.hydroCannon
	}, {
		id = "309",
		name = Localizations.MoveNames.meteorMash,
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = "100",
		pp = "10",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.meteorMash
	}, {
		id = "310",
		name = Localizations.MoveNames.astonish,
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = "30",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.astonish
	}, {
		id = "311",
		name = Localizations.MoveNames.weatherBall,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "50",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.weatherBall
	}, {
		id = "312",
		name = Localizations.MoveNames.aromatherapy,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.aromatherapy
	}, {
		id = "313",
		name = Localizations.MoveNames.fakeTears,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.fakeTears
	}, {
		id = "314",
		name = Localizations.MoveNames.airCutter,
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "55",
		pp = "25",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.airCutter
	}, {
		id = "315",
		name = Localizations.MoveNames.overheat,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "140",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.overheat
	}, {
		id = "316",
		name = Localizations.MoveNames.odorSleuth,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = { "100", "100", "100", Graphics.TEXT.ALWAYS_HITS, Graphics.TEXT.ALWAYS_HITS },
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.odorSleuth
	}, {
		id = "317",
		name = Localizations.MoveNames.rockTomb,
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = "50",
		pp = "10",
		accuracy = "80",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.rockTomb
	}, {
		id = "318",
		name = Localizations.MoveNames.silverWind,
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "60",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.silverWind
	}, {
		id = "319",
		name = Localizations.MoveNames.metalSound,
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.metalSound
	}, {
		id = "320",
		name = Localizations.MoveNames.grasswhistle,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "55",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.grasswhistle
	}, {
		id = "321",
		name = Localizations.MoveNames.tickle,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.tickle
	}, {
		id = "322",
		name = Localizations.MoveNames.cosmicPower,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.cosmicPower
	}, {
		id = "323",
		name = Localizations.MoveNames.waterSpout,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = ">HP",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.waterSpout
	}, {
		id = "324",
		name = Localizations.MoveNames.signalBeam,
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "75",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.signalBeam
	}, {
		id = "325",
		name = Localizations.MoveNames.shadowPunch,
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = "60",
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.shadowPunch
	}, {
		id = "326",
		name = Localizations.MoveNames.extrasensory,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "80",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.extrasensory
	}, {
		id = "327",
		name = Localizations.MoveNames.skyUppercut,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "85",
		pp = "15",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.skyUppercut
	}, {
		id = "328",
		name = Localizations.MoveNames.sandTomb,
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = { "15", "15", "15", "15", "35" },
		pp = "15",
		accuracy = { "70", "70", "70", "70", "85" },
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.sandTomb
	}, {
		id = "329",
		name = Localizations.MoveNames.sheerCold,
		type = PokemonData.POKEMON_TYPES.ICE,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = "30",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.sheerCold
	}, {
		id = "330",
		name = Localizations.MoveNames.muddyWater,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "95",
		pp = "10",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.muddyWater
	}, {
		id = "331",
		name = Localizations.MoveNames.bulletSeed,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = { "10", "10", "10", "10", "25" },
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.bulletSeed
	}, {
		id = "332",
		name = Localizations.MoveNames.aerialAce,
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "60",
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.aerialAce
	}, {
		id = "333",
		name = Localizations.MoveNames.icicleSpear,
		type = PokemonData.POKEMON_TYPES.ICE,
		power = { "10", "10", "10", "10", "25" },
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.icicleSpear
	}, {
		id = "334",
		name = Localizations.MoveNames.ironDefense,
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.ironDefense
	}, {
		id = "335",
		name = Localizations.MoveNames.block,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.block
	}, {
		id = "336",
		name = Localizations.MoveNames.howl,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.howl
	}, {
		id = "337",
		name = Localizations.MoveNames.dragonClaw,
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.dragonClaw
	}, {
		id = "338",
		name = Localizations.MoveNames.frenzyPlant,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "150",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.frenzyPlant
	}, {
		id = "339",
		name = Localizations.MoveNames.bulkUp,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.bulkUp
	}, {
		id = "340",
		name = Localizations.MoveNames.bounce,
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "85",
		pp = "5",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.bounce
	}, {
		id = "341",
		name = Localizations.MoveNames.mudShot,
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = "55",
		pp = "15",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.mudShot
	}, {
		id = "342",
		name = Localizations.MoveNames.poisonTail,
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "50",
		pp = "25",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.poisonTail
	}, {
		id = "343",
		name = Localizations.MoveNames.covet,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = { "40", "40", "40", "40", "60" },
		pp = "40",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.covet
	}, {
		id = "344",
		name = Localizations.MoveNames.voltTackle,
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "120",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.voltTackle
	}, {
		id = "345",
		name = Localizations.MoveNames.magicalLeaf,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "60",
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.magicalLeaf
	}, {
		id = "346",
		name = Localizations.MoveNames.waterSport,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.waterSport
	}, {
		id = "347",
		name = Localizations.MoveNames.calmMind,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.calmMind
	}, {
		id = "348",
		name = Localizations.MoveNames.leafBlade,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = { "70", "70", "70", "90", "90" },
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.leafBlade
	}, {
		id = "349",
		name = Localizations.MoveNames.dragonDance,
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.dragonDance
	}, {
		id = "350",
		name = Localizations.MoveNames.rockBlast,
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = "25",
		pp = "10",
		accuracy = { "80", "80", "80", "80", "90" },
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.rockBlast
	}, {
		id = "351",
		name = Localizations.MoveNames.shockWave,
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "60",
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.shockWave
	}, {
		id = "352",
		name = Localizations.MoveNames.waterPulse,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "60",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.waterPulse
	}, {
		id = "353",
		name = Localizations.MoveNames.doomDesire,
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = { "120", "120", "120", "120", "140" },
		pp = "5",
		accuracy = { "85", "85", "85", "85", "100" },
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.doomDesire
	}, {
		id = "354",
		name = Localizations.MoveNames.psychoBoost,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "140",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.psychoBoost
	}, {
		id = "355",
		name = Localizations.MoveNames.roost,
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = Graphics.TEXT.ALWAYS_HITS,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.roost
	}, {
		id = "356",
		name = Localizations.MoveNames.gravity,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.gravity
	}, {
		id = "357",
		name = Localizations.MoveNames.miracleEye,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.miracleEye
	}, {
		id = "358",
		name = Localizations.MoveNames.wakeupSlap,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "60",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.wakeupSlap
	}, {
		id = "359",
		name = Localizations.MoveNames.hammerArm,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "100",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.hammerArm
	}, {
		id = "360",
		name = Localizations.MoveNames.gyroBall,
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = "<SP",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.gyroBall
	}, {
		id = "361",
		name = Localizations.MoveNames.healingWish,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.healingWish
	}, {
		id = "362",
		name = Localizations.MoveNames.brine,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "65",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.brine
	}, {
		id = "363",
		name = Localizations.MoveNames.naturalGift,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "BRY",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.naturalGift
	}, {
		id = "364",
		name = Localizations.MoveNames.feint,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = { "50", "50", "50", "50", "30" },
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.feint
	}, {
		id = "365",
		name = Localizations.MoveNames.pluck,
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "60",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.pluck
	}, {
		id = "366",
		name = Localizations.MoveNames.tailwind,
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.tailwind
	}, {
		id = "367",
		name = Localizations.MoveNames.acupressure,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.acupressure
	}, {
		id = "368",
		name = Localizations.MoveNames.metalBurst,
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.metalBurst
	}, {
		id = "369",
		name = Localizations.MoveNames.uturn,
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "70",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.uturn
	}, {
		id = "370",
		name = Localizations.MoveNames.closeCombat,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "120",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.closeCombat
	}, {
		id = "371",
		name = Localizations.MoveNames.payback,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "50",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.payback
	}, {
		id = "372",
		name = Localizations.MoveNames.assurance,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "50",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.assurance
	}, {
		id = "373",
		name = Localizations.MoveNames.embargo,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.embargo
	}, {
		id = "374",
		name = Localizations.MoveNames.fling,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "ITM",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.fling
	}, {
		id = "375",
		name = Localizations.MoveNames.psychoShift,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.psychoShift
	}, {
		id = "376",
		name = Localizations.MoveNames.trumpCard,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "<PP",
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.trumpCard
	}, {
		id = "377",
		name = Localizations.MoveNames.healBlock,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.healBlock
	}, {
		id = "378",
		name = Localizations.MoveNames.wringOut,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = ">HP",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.wringOut
	}, {
		id = "379",
		name = Localizations.MoveNames.powerTrick,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.powerTrick
	}, {
		id = "380",
		name = Localizations.MoveNames.gastroAcid,
		type = PokemonData.POKEMON_TYPES.POISON,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.gastroAcid
	}, {
		id = "381",
		name = Localizations.MoveNames.luckyChant,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.luckyChant
	}, {
		id = "382",
		name = Localizations.MoveNames.meFirst,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.meFirst
	}, {
		id = "383",
		name = Localizations.MoveNames.copycat,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.copycat
	}, {
		id = "384",
		name = Localizations.MoveNames.powerSwap,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.powerSwap
	}, {
		id = "385",
		name = Localizations.MoveNames.guardSwap,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.guardSwap
	}, {
		id = "386",
		name = Localizations.MoveNames.punishment,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "STA",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.punishment
	}, {
		id = "387",
		name = Localizations.MoveNames.lastResort,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = { "130", "130", "130", "130", "140" },
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.lastResort
	}, {
		id = "388",
		name = Localizations.MoveNames.worrySeed,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.worrySeed
	}, {
		id = "389",
		name = Localizations.MoveNames.suckerPunch,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "80",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.suckerPunch
	}, {
		id = "390",
		name = Localizations.MoveNames.toxicSpikes,
		type = PokemonData.POKEMON_TYPES.POISON,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.toxicSpikes
	}, {
		id = "391",
		name = Localizations.MoveNames.heartSwap,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.heartSwap
	}, {
		id = "392",
		name = Localizations.MoveNames.aquaRing,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.aquaRing
	}, {
		id = "393",
		name = Localizations.MoveNames.magnetRise,
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.magnetRise
	}, {
		id = "394",
		name = Localizations.MoveNames.flareBlitz,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "120",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.flareBlitz
	}, {
		id = "395",
		name = Localizations.MoveNames.forcePalm,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "60",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.forcePalm
	}, {
		id = "396",
		name = Localizations.MoveNames.auraSphere,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "90",
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.auraSphere
	}, {
		id = "397",
		name = Localizations.MoveNames.rockPolish,
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.rockPolish
	}, {
		id = "398",
		name = Localizations.MoveNames.poisonJab,
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "80",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.poisonJab
	}, {
		id = "399",
		name = Localizations.MoveNames.darkPulse,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.darkPulse
	}, {
		id = "400",
		name = Localizations.MoveNames.nightSlash,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "70",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.nightSlash
	}, {
		id = "401",
		name = Localizations.MoveNames.aquaTail,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "90",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.aquaTail
	}, {
		id = "402",
		name = Localizations.MoveNames.seedBomb,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.seedBomb
	}, {
		id = "403",
		name = Localizations.MoveNames.airSlash,
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "75",
		pp = "20",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.airSlash
	}, {
		id = "404",
		name = Localizations.MoveNames.xscissor,
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.xscissor
	}, {
		id = "405",
		name = Localizations.MoveNames.bugBuzz,
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "90",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.bugBuzz
	}, {
		id = "406",
		name = Localizations.MoveNames.dragonPulse,
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = "90",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.dragonPulse
	}, {
		id = "407",
		name = Localizations.MoveNames.dragonRush,
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = "100",
		pp = "10",
		accuracy = "75",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.dragonRush
	}, {
		id = "408",
		name = Localizations.MoveNames.powerGem,
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = "70",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.powerGem
	}, {
		id = "409",
		name = Localizations.MoveNames.drainPunch,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = { "60", "60", "60", "60", "75" },
		pp = { "5", "5", "5", "5", "10" },
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.drainPunch
	}, {
		id = "410",
		name = Localizations.MoveNames.vacuumWave,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "40",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.vacuumWave
	}, {
		id = "411",
		name = Localizations.MoveNames.focusBlast,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "120",
		pp = "5",
		accuracy = "70",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.focusBlast
	}, {
		id = "412",
		name = Localizations.MoveNames.energyBall,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "80",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.energyBall
	}, {
		id = "413",
		name = Localizations.MoveNames.braveBird,
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "120",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.braveBird
	}, {
		id = "414",
		name = Localizations.MoveNames.earthPower,
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = "90",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.earthPower
	}, {
		id = "415",
		name = Localizations.MoveNames.switcheroo,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.switcheroo
	}, {
		id = "416",
		name = Localizations.MoveNames.gigaImpact,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "150",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.gigaImpact
	}, {
		id = "417",
		name = Localizations.MoveNames.nastyPlot,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.nastyPlot
	}, {
		id = "418",
		name = Localizations.MoveNames.bulletPunch,
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = "40",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.bulletPunch
	}, {
		id = "419",
		name = Localizations.MoveNames.avalanche,
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "60",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.avalanche
	}, {
		id = "420",
		name = Localizations.MoveNames.iceShard,
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "40",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.iceShard
	}, {
		id = "421",
		name = Localizations.MoveNames.shadowClaw,
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = "70",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.shadowClaw
	}, {
		id = "422",
		name = Localizations.MoveNames.thunderFang,
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "65",
		pp = "15",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.thunderFang
	}, {
		id = "423",
		name = Localizations.MoveNames.iceFang,
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "65",
		pp = "15",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.iceFang
	}, {
		id = "424",
		name = Localizations.MoveNames.fireFang,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "65",
		pp = "15",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.fireFang
	}, {
		id = "425",
		name = Localizations.MoveNames.shadowSneak,
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = "40",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.shadowSneak
	}, {
		id = "426",
		name = Localizations.MoveNames.mudBomb,
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = "65",
		pp = "10",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.mudBomb
	}, {
		id = "427",
		name = Localizations.MoveNames.psychoCut,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "70",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.psychoCut
	}, {
		id = "428",
		name = Localizations.MoveNames.zenHeadbutt,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "80",
		pp = "15",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.zenHeadbutt
	}, {
		id = "429",
		name = Localizations.MoveNames.mirrorShot,
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = "65",
		pp = "10",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.mirrorShot
	}, {
		id = "430",
		name = Localizations.MoveNames.flashCannon,
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = "80",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.flashCannon
	}, {
		id = "431",
		name = Localizations.MoveNames.rockClimb,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "90",
		pp = "20",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.rockClimb
	}, {
		id = "432",
		name = Localizations.MoveNames.defog,
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.defog
	}, {
		id = "433",
		name = Localizations.MoveNames.trickRoom,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.trickRoom
	}, {
		id = "434",
		name = Localizations.MoveNames.dracoMeteor,
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = "140",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.dracoMeteor
	}, {
		id = "435",
		name = Localizations.MoveNames.discharge,
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.discharge
	}, {
		id = "436",
		name = Localizations.MoveNames.lavaPlume,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.lavaPlume
	}, {
		id = "437",
		name = Localizations.MoveNames.leafStorm,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "140",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.leafStorm
	}, {
		id = "438",
		name = Localizations.MoveNames.powerWhip,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "120",
		pp = "10",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.powerWhip
	}, {
		id = "439",
		name = Localizations.MoveNames.rockWrecker,
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = "150",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.rockWrecker
	}, {
		id = "440",
		name = Localizations.MoveNames.crossPoison,
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "70",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.crossPoison
	}, {
		id = "441",
		name = Localizations.MoveNames.gunkShot,
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "120",
		pp = "5",
		accuracy = "70",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.gunkShot
	}, {
		id = "442",
		name = Localizations.MoveNames.ironHead,
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.ironHead
	}, {
		id = "443",
		name = Localizations.MoveNames.magnetBomb,
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = "60",
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.magnetBomb
	}, {
		id = "444",
		name = Localizations.MoveNames.stoneEdge,
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = "100",
		pp = "5",
		accuracy = "80",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.stoneEdge
	}, {
		id = "445",
		name = Localizations.MoveNames.captivate,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.captivate
	}, {
		id = "446",
		name = Localizations.MoveNames.stealthRock,
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.stealthRock
	}, {
		id = "447",
		name = Localizations.MoveNames.grassKnot,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "WT",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.grassKnot
	}, {
		id = "448",
		name = Localizations.MoveNames.chatter,
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "60",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.chatter
	}, {
		id = "449",
		name = Localizations.MoveNames.judgment,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "100",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.judgment
	}, {
		id = "450",
		name = Localizations.MoveNames.bugBite,
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "60",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.bugBite
	}, {
		id = "451",
		name = Localizations.MoveNames.chargeBeam,
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "50",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.chargeBeam
	}, {
		id = "452",
		name = Localizations.MoveNames.woodHammer,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "120",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.woodHammer
	}, {
		id = "453",
		name = Localizations.MoveNames.aquaJet,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "40",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.aquaJet
	}, {
		id = "454",
		name = Localizations.MoveNames.attackOrder,
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "90",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.attackOrder
	}, {
		id = "455",
		name = Localizations.MoveNames.defendOrder,
		type = PokemonData.POKEMON_TYPES.BUG,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.defendOrder
	}, {
		id = "456",
		name = Localizations.MoveNames.healOrder,
		type = PokemonData.POKEMON_TYPES.BUG,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.healOrder
	}, {
		id = "457",
		name = Localizations.MoveNames.headSmash,
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = "150",
		pp = "5",
		accuracy = "80",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.headSmash
	}, {
		id = "458",
		name = Localizations.MoveNames.doubleHit,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "35",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.doubleHit
	}, {
		id = "459",
		name = Localizations.MoveNames.roarOfTime,
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = "150",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.roarOfTime
	}, {
		id = "460",
		name = Localizations.MoveNames.spacialRend,
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = "100",
		pp = "5",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.spacialRend
	}, {
		id = "461",
		name = Localizations.MoveNames.lunarDance,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.lunarDance
	}, {
		id = "462",
		name = Localizations.MoveNames.crushGrip,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = ">HP",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.crushGrip
	}, {
		id = "463",
		name = Localizations.MoveNames.magmaStorm,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "120",
		pp = "5",
		accuracy = { "70", "70", "70", "70", "75" },
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.magmaStorm
	}, {
		id = "464",
		name = Localizations.MoveNames.darkVoid,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "80",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.darkVoid
	}, {
		id = "465",
		name = Localizations.MoveNames.seedFlare,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "120",
		pp = "5",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.seedFlare
	}, {
		id = "466",
		name = Localizations.MoveNames.ominousWind,
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = "60",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.ominousWind
	}, {
		id = "467",
		name = Localizations.MoveNames.shadowForce,
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = "120",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.shadowForce
	}, {
		id = "468",
		name = Localizations.MoveNames.honeClaws,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.honeClaws
	}, {
		id = "469",
		name = Localizations.MoveNames.wideGuard,
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.wideGuard
	}, {
		id = "470",
		name = Localizations.MoveNames.guardSplit,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.guardSplit
	}, {
		id = "471",
		name = Localizations.MoveNames.powerSplit,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.powerSplit
	}, {
		id = "472",
		name = Localizations.MoveNames.wonderRoom,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.wonderRoom
	}, {
		id = "473",
		name = Localizations.MoveNames.psyshock,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "80",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.psyshock
	}, {
		id = "474",
		name = Localizations.MoveNames.venoshock,
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "65",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.venoshock
	}, {
		id = "475",
		name = Localizations.MoveNames.autotomize,
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.autotomize
	}, {
		id = "476",
		name = Localizations.MoveNames.ragePowder,
		type = PokemonData.POKEMON_TYPES.BUG,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.ragePowder
	}, {
		id = "477",
		name = Localizations.MoveNames.telekinesis,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.telekinesis
	}, {
		id = "478",
		name = Localizations.MoveNames.magicRoom,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.magicRoom
	}, {
		id = "479",
		name = Localizations.MoveNames.smackDown,
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = "50",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.smackDown
	}, {
		id = "480",
		name = Localizations.MoveNames.stormThrow,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = { "60", "60", "60", "60", "40" },
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.stormThrow
	}, {
		id = "481",
		name = Localizations.MoveNames.flameBurst,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "70",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.flameBurst
	}, {
		id = "482",
		name = Localizations.MoveNames.sludgeWave,
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "95",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.sludgeWave
	}, {
		id = "483",
		name = Localizations.MoveNames.quiverDance,
		type = PokemonData.POKEMON_TYPES.BUG,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.quiverDance
	}, {
		id = "484",
		name = Localizations.MoveNames.heavySlam,
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = ">WT",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.heavySlam
	}, {
		id = "485",
		name = Localizations.MoveNames.synchronoise,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = { "120", "120", "120", "120", "70" },
		pp = { "10", "10", "10", "10", "15" },
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.synchronoise
	}, {
		id = "486",
		name = Localizations.MoveNames.electroBall,
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = ">SP",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.electroBall
	}, {
		id = "487",
		name = Localizations.MoveNames.soak,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.soak
	}, {
		id = "488",
		name = Localizations.MoveNames.flameCharge,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "50",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.flameCharge
	}, {
		id = "489",
		name = Localizations.MoveNames.coil,
		type = PokemonData.POKEMON_TYPES.POISON,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.coil
	}, {
		id = "490",
		name = Localizations.MoveNames.lowSweep,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = { "65", "65", "65", "65", "60" },
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.lowSweep
	}, {
		id = "491",
		name = Localizations.MoveNames.acidSpray,
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "40",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.acidSpray
	}, {
		id = "492",
		name = Localizations.MoveNames.foulPlay,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "95",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.foulPlay
	}, {
		id = "493",
		name = Localizations.MoveNames.simpleBeam,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.simpleBeam
	}, {
		id = "494",
		name = Localizations.MoveNames.entrainment,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.entrainment
	}, {
		id = "495",
		name = Localizations.MoveNames.afterYou,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.afterYou
	}, {
		id = "496",
		name = Localizations.MoveNames.round,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "60",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.round
	}, {
		id = "497",
		name = Localizations.MoveNames.echoedVoice,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "40",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.echoedVoice
	}, {
		id = "498",
		name = Localizations.MoveNames.chipAway,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "70",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.chipAway
	}, {
		id = "499",
		name = Localizations.MoveNames.clearSmog,
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "50",
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.clearSmog
	}, {
		id = "500",
		name = Localizations.MoveNames.storedPower,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "20",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.storedPower
	}, {
		id = "501",
		name = Localizations.MoveNames.quickGuard,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.quickGuard
	}, {
		id = "502",
		name = Localizations.MoveNames.allySwitch,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.allySwitch
	}, {
		id = "503",
		name = Localizations.MoveNames.scald,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.scald
	}, {
		id = "504",
		name = Localizations.MoveNames.shellSmash,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.shellSmash
	}, {
		id = "505",
		name = Localizations.MoveNames.healPulse,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.healPulse
	}, {
		id = "506",
		name = Localizations.MoveNames.hex,
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = { "65", "65", "65", "65", "50" },
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.hex
	}, {
		id = "507",
		name = Localizations.MoveNames.skyDrop,
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "60",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.skyDrop
	}, {
		id = "508",
		name = Localizations.MoveNames.shiftGear,
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.shiftGear
	}, {
		id = "509",
		name = Localizations.MoveNames.circleThrow,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "60",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.circleThrow
	}, {
		id = "510",
		name = Localizations.MoveNames.incinerate,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = { "60", "60", "60", "60", "30" },
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.incinerate
	}, {
		id = "511",
		name = Localizations.MoveNames.quash,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.quash
	}, {
		id = "512",
		name = Localizations.MoveNames.acrobatics,
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "55",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.acrobatics
	}, {
		id = "513",
		name = Localizations.MoveNames.reflectType,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.reflectType
	}, {
		id = "514",
		name = Localizations.MoveNames.retaliate,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "70",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.retaliate
	}, {
		id = "515",
		name = Localizations.MoveNames.finalGambit,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "HP",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.finalGambit
	}, {
		id = "516",
		name = Localizations.MoveNames.bestow,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.bestow
	}, {
		id = "517",
		name = Localizations.MoveNames.inferno,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "100",
		pp = "5",
		accuracy = "50",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.inferno
	}, {
		id = "518",
		name = Localizations.MoveNames.waterPledge,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = { "80", "80", "80", "80", "50" },
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.waterPledge
	}, {
		id = "519",
		name = Localizations.MoveNames.firePledge,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = { "80", "80", "80", "80", "50" },
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.firePledge
	}, {
		id = "520",
		name = Localizations.MoveNames.grassPledge,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = { "80", "80", "80", "80", "50" },
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.grassPledge
	}, {
		id = "521",
		name = Localizations.MoveNames.voltSwitch,
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "70",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.voltSwitch
	}, {
		id = "522",
		name = Localizations.MoveNames.struggleBug,
		type = PokemonData.POKEMON_TYPES.BUG,
		power = { "50", "50", "50", "50", "30" },
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.struggleBug
	}, {
		id = "523",
		name = Localizations.MoveNames.bulldoze,
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = "60",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.bulldoze
	}, {
		id = "524",
		name = Localizations.MoveNames.frostBreath,
		type = PokemonData.POKEMON_TYPES.ICE,
		power = { "60", "60", "60", "60", "40" },
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.frostBreath
	}, {
		id = "525",
		name = Localizations.MoveNames.dragonTail,
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = "60",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.dragonTail
	}, {
		id = "526",
		name = Localizations.MoveNames.workUp,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.workUp
	}, {
		id = "527",
		name = Localizations.MoveNames.electroweb,
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "55",
		pp = "15",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.electroweb
	}, {
		id = "528",
		name = Localizations.MoveNames.wildCharge,
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "90",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.wildCharge
	}, {
		id = "529",
		name = Localizations.MoveNames.drillRun,
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = "80",
		pp = "10",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.drillRun
	}, {
		id = "530",
		name = Localizations.MoveNames.dualChop,
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = "40",
		pp = "15",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.dualChop
	}, {
		id = "531",
		name = Localizations.MoveNames.heartStamp,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "60",
		pp = "25",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.heartStamp
	}, {
		id = "532",
		name = Localizations.MoveNames.hornLeech,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "75",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.hornLeech
	}, {
		id = "533",
		name = Localizations.MoveNames.sacredSword,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "90",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.sacredSword
	}, {
		id = "534",
		name = Localizations.MoveNames.razorShell,
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "75",
		pp = "10",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.razorShell
	}, {
		id = "535",
		name = Localizations.MoveNames.heatCrash,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = ">WT",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.heatCrash
	}, {
		id = "536",
		name = Localizations.MoveNames.leafTornado,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "65",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.leafTornado
	}, {
		id = "537",
		name = Localizations.MoveNames.steamroller,
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "65",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.steamroller
	}, {
		id = "538",
		name = Localizations.MoveNames.cottonGuard,
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = Localizations.MoveDescriptions.cottonGuard
	}, {
		id = "539",
		name = Localizations.MoveNames.nightDaze,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "85",
		pp = "10",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.nightDaze
	}, {
		id = "540",
		name = Localizations.MoveNames.psystrike,
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "100",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.psystrike
	}, {
		id = "541",
		name = Localizations.MoveNames.tailSlap,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "25",
		pp = "10",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.tailSlap
	}, {
		id = "542",
		name = Localizations.MoveNames.hurricane,
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "120",
		pp = "10",
		accuracy = "70",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.hurricane
	}, {
		id = "543",
		name = Localizations.MoveNames.headCharge,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "120",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.headCharge
	}, {
		id = "544",
		name = Localizations.MoveNames.gearGrind,
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = "50",
		pp = "15",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.gearGrind
	}, {
		id = "545",
		name = Localizations.MoveNames.searingShot,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "100",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.searingShot
	}, {
		id = "546",
		name = Localizations.MoveNames.technoBlast,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "85",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.technoBlast
	}, {
		id = "547",
		name = Localizations.MoveNames.relicSong,
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "75",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.relicSong
	}, {
		id = "548",
		name = Localizations.MoveNames.secretSword,
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "85",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.secretSword
	}, {
		id = "549",
		name = Localizations.MoveNames.glaciate,
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "65",
		pp = "10",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.glaciate
	}, {
		id = "550",
		name = Localizations.MoveNames.boltStrike,
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "130",
		pp = "5",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.boltStrike
	}, {
		id = "551",
		name = Localizations.MoveNames.blueFlare,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "130",
		pp = "5",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.blueFlare
	}, {
		id = "552",
		name = Localizations.MoveNames.fieryDance,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "80",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.fieryDance
	}, {
		id = "553",
		name = Localizations.MoveNames.freezeShock,
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "140",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.freezeShock
	}, {
		id = "554",
		name = Localizations.MoveNames.iceBurn,
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "140",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.iceBurn
	}, {
		id = "555",
		name = Localizations.MoveNames.snarl,
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "55",
		pp = "15",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.snarl
	}, {
		id = "556",
		name = Localizations.MoveNames.icicleCrash,
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "85",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.icicleCrash
	}, {
		id = "557",
		name = Localizations.MoveNames.vcreate,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "180",
		pp = "5",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.vcreate
	}, {
		id = "558",
		name = Localizations.MoveNames.fusionFlare,
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "100",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = Localizations.MoveDescriptions.fusionFlare
	}, {
		id = "559",
		name = Localizations.MoveNames.fusionBolt,
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "100",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = Localizations.MoveDescriptions.fusionBolt
	}
}

MoveData.TOTAL_MOVES = #MoveData.MOVES_MASTER_LIST

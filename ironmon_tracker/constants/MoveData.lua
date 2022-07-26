-- Move categories identify the type of attack a move is: physical, special, or status
MoveData.MOVE_CATEGORIES =
	MiscUtils.readOnly(
	{
		NONE = 0,
		PHYSICAL = 1,
		SPECIAL = 2,
		STATUS = 3
	}
)

--List of pokemon types used to cycle through types when the Hidden Power button is clicked
MoveData.HIDDEN_POWER_TYPE_LIST =
	MiscUtils.readOnly(
	{
		PokemonData.POKEMON_TYPES.NORMAL,
		PokemonData.POKEMON_TYPES.FIGHTING,
		PokemonData.POKEMON_TYPES.FLYING,
		PokemonData.POKEMON_TYPES.POISON,
		PokemonData.POKEMON_TYPES.GROUND,
		PokemonData.POKEMON_TYPES.ROCK,
		PokemonData.POKEMON_TYPES.BUG,
		PokemonData.POKEMON_TYPES.GHOST,
		PokemonData.POKEMON_TYPES.STEEL,
		PokemonData.POKEMON_TYPES.FIRE,
		PokemonData.POKEMON_TYPES.WATER,
		PokemonData.POKEMON_TYPES.GRASS,
		PokemonData.POKEMON_TYPES.ELECTRIC,
		PokemonData.POKEMON_TYPES.PSYCHIC,
		PokemonData.POKEMON_TYPES.ICE,
		PokemonData.POKEMON_TYPES.DRAGON,
		PokemonData.POKEMON_TYPES.DARK
	}
)

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

MoveData.EFFECTIVE_DATA =
	MiscUtils.readOnly(
	{
		NORMAL = {ROCK = 0.5, GHOST = 0, STEEL = 0.5},
		FIRE = {FIRE = 0.5, WATER = 0.5, GRASS = 2, ICE = 2, BUG = 2, ROCK = 0.5, dragon = 0.5, STEEL = 2},
		WATER = {FIRE = 2, WATER = 0.5, GRASS = 0.5, ground = 2, ROCK = 2, dragon = 0.5},
		GRASS = {
			FIRE = 0.5,
			WATER = 2,
			GRASS = 0.5,
			POISON = 0.5,
			ground = 2,
			FLYING = 0.5,
			BUG = 0.5,
			ROCK = 2,
			dragon = 0.5,
			STEEL = 0.5
		},
		ELECTRIC = {WATER = 2, GRASS = 0.5, ELECTRIC = 0.5, ground = 0, FLYING = 2, dragon = 0.5},
		ICE = {FIRE = 0.5, WATER = 0.5, GRASS = 2, ICE = 0.5, ground = 2, FLYING = 2, dragon = 2, STEEL = 0.5},
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
		POISON = {GRASS = 2, POISON = 0.5, ground = 0.5, ROCK = 0.5, GHOST = 0.5, STEEL = 0},
		ground = {FIRE = 2, GRASS = 0.5, ELECTRIC = 2, POISON = 2, FLYING = 0, BUG = 0.5, ROCK = 2, STEEL = 2},
		FLYING = {GRASS = 2, ELECTRIC = 0.5, FIGHTING = 2, BUG = 2, ROCK = 0.5, STEEL = 0.5},
		PSYCHIC = {FIGHTING = 2, POISON = 2, PSYCHIC = 0.5, DARK = 0, STEEL = 0.5},
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
		ROCK = {FIRE = 2, ICE = 2, FIGHTING = 0.5, ground = 0.5, FLYING = 2, BUG = 2, STEEL = 0.5},
		GHOST = {NORMAL = 0, PSYCHIC = 2, GHOST = 2, DARK = 0.5, STEEL = 0.5},
		dragon = {dragon = 2, STEEL = 0.5},
		DARK = {FIGHTING = 0.5, PSYCHIC = 2, GHOST = 2, DARK = 0.5, STEEL = 0.5},
		STEEL = {FIRE = 0.5, WATER = 0.5, ICE = 2, ROCK = 2, STEEL = 0.5, ELECTRIC = 0.5}
	}
)

MoveData.MOVES_MASTER_LIST =
	MiscUtils.readOnly(
	{
		{
			--- Empty entry for move ID 0
			id = "---",
			name = "---",
			type = "---",
			power = "",
			pp = Graphics.TEXT.NO_PP,
			accuracy = "",
			category = MoveData.MOVE_CATEGORIES.NONE
		},
		{
			-- Begin Gen 1 Moves
			id = "1",
			name = "Pound",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "40",
			pp = "35",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "2",
			name = "Karate Chop",
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
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "3",
			name = "DoubleSlap",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "15",
			pp = "10",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "4",
			name = "Comet Punch",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "18",
			pp = "15",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "5",
			name = "Mega Punch",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "80",
			pp = "20",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "6",
			name = "Pay Day",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "40",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "7",
			name = "Fire Punch",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = "75",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "8",
			name = "Ice Punch",
			type = PokemonData.POKEMON_TYPES.ICE,
			power = "75",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "9",
			name = "ThunderPunch",
			type = PokemonData.POKEMON_TYPES.ELECTRIC,
			power = "75",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "10",
			name = "Scratch",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "40",
			pp = "35",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "11",
			name = "ViceGrip",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "55",
			pp = "30",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "12",
			name = "Guillotine",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "5",
			accuracy = "30",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "13",
			name = "Razor Wind",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "80",
			pp = "10",
			accuracy = {"75", "75", "100", "100", "100"},
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "14",
			name = "Swords Dance",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "30",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "15",
			name = "Cut",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "50",
			pp = "30",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "16",
			name = "Gust",
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
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "17",
			name = "Wing Attack",
			type = PokemonData.POKEMON_TYPES.FLYING,
			power = {"35", "60", "60", "60", "60"},
			pp = "35",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "18",
			name = "Whirlwind",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = {"85", "100", "100", "100", "100"},
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "19",
			name = "Fly",
			type = PokemonData.POKEMON_TYPES.FLYING,
			power = {"70", "70", "70", "90", "90"},
			pp = "15",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "20",
			name = "Bind",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "15",
			pp = "20",
			accuracy = {"75", "75", "75", "75", "85"},
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "21",
			name = "Slam",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "80",
			pp = "20",
			accuracy = "75",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "22",
			name = "Vine Whip",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = "35",
			pp = {"10", "10", "10", "15", "15"},
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "23",
			name = "Stomp",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "65",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "24",
			name = "Double Kick",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "30",
			pp = "30",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "25",
			name = "Mega Kick",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "120",
			pp = "5",
			accuracy = "75",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "26",
			name = "Jump Kick",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = {"70", "70", "70", "85", "100"},
			pp = {"25", "25", "25", "25", "10"},
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "27",
			name = "Rolling Kick",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "60",
			pp = "15",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "28",
			name = "Sand-Attack",
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
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "29",
			name = "Headbutt",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "70",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "30",
			name = "Horn Attack",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "65",
			pp = "25",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "31",
			name = "Fury Attack",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "15",
			pp = "20",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "32",
			name = "Horn Drill",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "5",
			accuracy = "30",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "33",
			name = "Tackle",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = {"35", "35", "35", "35", "50"},
			pp = "35",
			accuracy = {"95", "95", "95", "95", "100"},
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "34",
			name = "Body Slam",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "85",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "35",
			name = "Wrap",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "15",
			pp = "20",
			accuracy = {"85", "85", "85", "85", "90"},
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "36",
			name = "Take Down",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "90",
			pp = "20",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "37",
			name = "Thrash",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = {"90", "90", "90", "90", "120"},
			pp = {"20", "20", "20", "20", "10"},
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "38",
			name = "Double-Edge",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = {"100", "120", "120", "120", "120"},
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "39",
			name = "Tail Whip",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "30",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "40",
			name = "Poison Sting",
			type = PokemonData.POKEMON_TYPES.POISON,
			power = "15",
			pp = "35",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "41",
			name = "Twineedle",
			type = PokemonData.POKEMON_TYPES.BUG,
			power = "25",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "42",
			name = "Pin Missile",
			type = PokemonData.POKEMON_TYPES.BUG,
			power = "14",
			pp = "20",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "43",
			name = "Leer",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "30",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "44",
			name = "Bite",
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
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "45",
			name = "Growl",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "40",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "46",
			name = "Roar",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "47",
			name = "Sing",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = "55",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "48",
			name = "Supersonic",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = "55",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "49",
			name = "SonicBoom",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "---",
			pp = "20",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "50",
			name = "Disable",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = {"55", "55", "55", "80", "100"},
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "51",
			name = "Acid",
			type = PokemonData.POKEMON_TYPES.POISON,
			power = "40",
			pp = "30",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "52",
			name = "Ember",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = "40",
			pp = "25",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "53",
			name = "Flamethrower",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = "95",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "54",
			name = "Mist",
			type = PokemonData.POKEMON_TYPES.ICE,
			power = Graphics.TEXT.NO_POWER,
			pp = "30",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "55",
			name = "Water Gun",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = "40",
			pp = "25",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "56",
			name = "Hydro Pump",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = "120",
			pp = "5",
			accuracy = "80",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "57",
			name = "Surf",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = "95",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "58",
			name = "Ice Beam",
			type = PokemonData.POKEMON_TYPES.ICE,
			power = "95",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "59",
			name = "Blizzard",
			type = PokemonData.POKEMON_TYPES.ICE,
			power = "120",
			pp = "5",
			accuracy = {"90", "70", "70", "70", "70"},
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "60",
			name = "Psybeam",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = "65",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "61",
			name = "BubbleBeam",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = "65",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "62",
			name = "Aurora Beam",
			type = PokemonData.POKEMON_TYPES.ICE,
			power = "65",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "63",
			name = "Hyper Beam",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "150",
			pp = "5",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "64",
			name = "Peck",
			type = PokemonData.POKEMON_TYPES.FLYING,
			power = "35",
			pp = "35",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "65",
			name = "Drill Peck",
			type = PokemonData.POKEMON_TYPES.FLYING,
			power = "80",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "66",
			name = "Submission",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "80",
			pp = "25",
			accuracy = "80",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "67",
			name = "Low Kick",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = {"50", "50", "WT", "WT", "WT"},
			pp = "20",
			accuracy = {"90", "90", "100", "100", "100"},
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "68",
			name = "Counter",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "69",
			name = "Seismic Toss",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "70",
			name = "Strength",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "80",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "71",
			name = "Absorb",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = {"20", "20", "20", "25", "25"},
			pp = "25",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "72",
			name = "Mega Drain",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = "40",
			pp = {"10", "10", "10", "15", "15"},
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "73",
			name = "Leech Seed",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "74",
			name = "Growth",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "40",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "75",
			name = "Razor Leaf",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = "55",
			pp = "25",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "76",
			name = "SolarBeam",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = "120",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "77",
			name = "PoisonPowder",
			type = PokemonData.POKEMON_TYPES.POISON,
			power = Graphics.TEXT.NO_POWER,
			pp = "35",
			accuracy = "75",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "78",
			name = "Stun Spore",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = Graphics.TEXT.NO_POWER,
			pp = "30",
			accuracy = "75",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "79",
			name = "Sleep Powder",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = "75",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "80",
			name = "Petal Dance",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = {"70", "70", "70", "90", "120"},
			pp = {"20", "20", "20", "20", "10"},
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "81",
			name = "String Shot",
			type = PokemonData.POKEMON_TYPES.BUG,
			power = Graphics.TEXT.NO_POWER,
			pp = "40",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "82",
			name = "Dragon Rage",
			type = PokemonData.POKEMON_TYPES.DRAGON,
			power = "---",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "83",
			name = "Fire Spin",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = {"15", "15", "15", "15", "35"},
			pp = "15",
			accuracy = {"70", "70", "70", "70", "85"},
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "84",
			name = "ThunderShock",
			type = PokemonData.POKEMON_TYPES.ELECTRIC,
			power = "40",
			pp = "30",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "85",
			name = "Thunderbolt",
			type = PokemonData.POKEMON_TYPES.ELECTRIC,
			power = "95",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "86",
			name = "Thunder Wave",
			type = PokemonData.POKEMON_TYPES.ELECTRIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "87",
			name = "Thunder",
			type = PokemonData.POKEMON_TYPES.ELECTRIC,
			power = "120",
			pp = "10",
			accuracy = "70",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "88",
			name = "Rock Throw",
			type = PokemonData.POKEMON_TYPES.ROCK,
			power = "50",
			pp = "15",
			accuracy = {"65", "90", "90", "90", "90"},
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "89",
			name = "Earthquake",
			type = PokemonData.POKEMON_TYPES.GROUND,
			power = "100",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "90",
			name = "Fissure",
			type = PokemonData.POKEMON_TYPES.GROUND,
			power = Graphics.TEXT.NO_POWER,
			pp = "5",
			accuracy = "30",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "91",
			name = "Dig",
			type = PokemonData.POKEMON_TYPES.GROUND,
			power = {"100", "60", "60", "80", "80"},
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "92",
			name = "Toxic",
			type = PokemonData.POKEMON_TYPES.POISON,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = {"85", "85", "85", "85", "90"},
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "93",
			name = "Confusion",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = "50",
			pp = "25",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "94",
			name = "Psychic",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = "90",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "95",
			name = "Hypnosis",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = "60",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "96",
			name = "Meditate",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "40",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "97",
			name = "Agility",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "30",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "98",
			name = "Quick Attack",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "40",
			pp = "30",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "99",
			name = "Rage",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "20",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "100",
			name = "Teleport",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "101",
			name = "Night Shade",
			type = PokemonData.POKEMON_TYPES.GHOST,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "102",
			name = "Mimic",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = {"100", "100", Graphics.TEXT.PLACEHOLDER, Graphics.TEXT.PLACEHOLDER, Graphics.TEXT.PLACEHOLDER},
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "103",
			name = "Screech",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "40",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "104",
			name = "Double Team",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "105",
			name = "Recover",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = {"20", "20", "20", "10", "10"},
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "106",
			name = "Harden",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "30",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "107",
			name = "Minimize",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "108",
			name = "SmokeScreen",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "109",
			name = "Confuse Ray",
			type = PokemonData.POKEMON_TYPES.GHOST,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "110",
			name = "Withdraw",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = Graphics.TEXT.NO_POWER,
			pp = "40",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "111",
			name = "Defense Curl",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "40",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "112",
			name = "Barrier",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "30",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "113",
			name = "Light Screen",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "30",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "114",
			name = "Haze",
			type = PokemonData.POKEMON_TYPES.ICE,
			power = Graphics.TEXT.NO_POWER,
			pp = "30",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "115",
			name = "Reflect",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "116",
			name = "Focus Energy",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "30",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "117",
			name = "Bide",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = {"100", "100", "100", Graphics.TEXT.PLACEHOLDER, Graphics.TEXT.PLACEHOLDER},
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "118",
			name = "Metronome",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "119",
			name = "Mirror Move",
			type = PokemonData.POKEMON_TYPES.FLYING,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "120",
			name = "Selfdestruct",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = {"130", "200", "200", "200", "200"},
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "121",
			name = "Egg Bomb",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "100",
			pp = "10",
			accuracy = "75",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "122",
			name = "Lick",
			type = PokemonData.POKEMON_TYPES.GHOST,
			power = "20",
			pp = "30",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "123",
			name = "Smog",
			type = PokemonData.POKEMON_TYPES.POISON,
			power = "20",
			pp = "20",
			accuracy = "70",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "124",
			name = "Sludge",
			type = PokemonData.POKEMON_TYPES.POISON,
			power = "65",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "125",
			name = "Bone Club",
			type = PokemonData.POKEMON_TYPES.GROUND,
			power = "65",
			pp = "20",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "126",
			name = "Fire Blast",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = "120",
			pp = "5",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "127",
			name = "Waterfall",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = "80",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "128",
			name = "Clamp",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = "35",
			pp = {"10", "10", "10", "10", "15"},
			accuracy = {"75", "75", "75", "75", "85"},
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "129",
			name = "Swift",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "60",
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "130",
			name = "Skull Bash",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "100",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "131",
			name = "Spike Cannon",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "20",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "132",
			name = "Constrict",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "10",
			pp = "35",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "133",
			name = "Amnesia",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "134",
			name = "Kinesis",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = "80",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "135",
			name = "Softboiled",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "136",
			name = "Hi Jump Kick",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = {"85", "85", "85", "100", "130"},
			pp = {"20", "20", "20", "20", "10"},
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "137",
			name = "Glare",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "30",
			accuracy = {"75", "75", "75", "75", "90"},
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "138",
			name = "Dream Eater",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = "100",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "139",
			name = "Poison Gas",
			type = PokemonData.POKEMON_TYPES.POISON,
			power = Graphics.TEXT.NO_POWER,
			pp = "40",
			accuracy = "55",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "140",
			name = "Barrage",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "15",
			pp = "20",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "141",
			name = "Leech Life",
			type = PokemonData.POKEMON_TYPES.BUG,
			power = "20",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "142",
			name = "Lovely Kiss",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = "75",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "143",
			name = "Sky Attack",
			type = PokemonData.POKEMON_TYPES.FLYING,
			power = "140",
			pp = "5",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "144",
			name = "Transform",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "145",
			name = "Bubble",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = "20",
			pp = "30",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "146",
			name = "Dizzy Punch",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "70",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "147",
			name = "Spore",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "148",
			name = "Flash",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = {"70", "70", "70", "100", "100"},
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "149",
			name = "Psywave",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = "80",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "150",
			name = "Splash",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "40",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "151",
			name = "Acid Armor",
			type = PokemonData.POKEMON_TYPES.POISON,
			power = Graphics.TEXT.NO_POWER,
			pp = "40",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "152",
			name = "Crabhammer",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = "90",
			pp = "10",
			accuracy = {"85", "85", "85", "85", "90"},
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "153",
			name = "Explosion",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = {"170", "250", "250", "250", "250"},
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "154",
			name = "Fury Swipes",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "18",
			pp = "15",
			accuracy = "80",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "155",
			name = "Bonemerang",
			type = PokemonData.POKEMON_TYPES.GROUND,
			power = "50",
			pp = "10",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "156",
			name = "Rest",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "157",
			name = "Rock Slide",
			type = PokemonData.POKEMON_TYPES.ROCK,
			power = "75",
			pp = "10",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "158",
			name = "Hyper Fang",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "80",
			pp = "15",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "159",
			name = "Sharpen",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "30",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "160",
			name = "Conversion",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "30",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "161",
			name = "Tri Attack",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "80",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "162",
			name = "Super Fang",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "163",
			name = "Slash",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "70",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "164",
			name = "Substitute",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "165",
			name = "Struggle",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "50",
			pp = {"10", "1", "1", "1", "1"},
			accuracy = {"100", "100", "100", Graphics.TEXT.PLACEHOLDER, Graphics.TEXT.PLACEHOLDER},
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			-- Begin Gen 2 Moves
			id = "166",
			name = "Sketch",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "1",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "167",
			name = "Triple Kick",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "10",
			pp = "10",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "168",
			name = "Thief",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = "40",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "169",
			name = "Spider Web",
			type = PokemonData.POKEMON_TYPES.BUG,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "170",
			name = "Mind Reader",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "5",
			accuracy = {"100", "100", "100", Graphics.TEXT.PLACEHOLDER, Graphics.TEXT.PLACEHOLDER},
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "171",
			name = "Nightmare",
			type = PokemonData.POKEMON_TYPES.GHOST,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "172",
			name = "Flame Wheel",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = "60",
			pp = "25",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "173",
			name = "Snore",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "40",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "174",
			name = "Curse",
			type = {
				PokemonData.POKEMON_TYPES.UNKNOWN,
				PokemonData.POKEMON_TYPES.UNKNOWN,
				PokemonData.POKEMON_TYPES.UNKNOWN,
				PokemonData.POKEMON_TYPES.UNKNOWN,
				PokemonData.POKEMON_TYPES.GHOST
			},
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "175",
			name = "Flail",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "<HP",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "176",
			name = "Conversion 2",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "30",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "177",
			name = "Aeroblast",
			type = PokemonData.POKEMON_TYPES.FLYING,
			power = "100",
			pp = "5",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "178",
			name = "Cotton Spore",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = Graphics.TEXT.NO_POWER,
			pp = "40",
			accuracy = {"85", "85", "85", "85", "100"},
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "179",
			name = "Reversal",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "<HP",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "180",
			name = "Spite",
			type = PokemonData.POKEMON_TYPES.GHOST,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "181",
			name = "Powder Snow",
			type = PokemonData.POKEMON_TYPES.ICE,
			power = "40",
			pp = "25",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "182",
			name = "Protect",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "183",
			name = "Mach Punch",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "40",
			pp = "30",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "184",
			name = "Scary Face",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = {"90", "90", "90", "90", "100"},
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "185",
			name = "Faint Attack",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = "60",
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "186",
			name = "Sweet Kiss",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = "75",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "187",
			name = "Belly Drum",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "188",
			name = "Sludge Bomb",
			type = PokemonData.POKEMON_TYPES.POISON,
			power = "90",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "189",
			name = "Mud-Slap",
			type = PokemonData.POKEMON_TYPES.GROUND,
			power = "20",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "190",
			name = "Octazooka",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = "65",
			pp = "10",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "191",
			name = "Spikes",
			type = PokemonData.POKEMON_TYPES.GROUND,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "192",
			name = "Zap Cannon",
			type = PokemonData.POKEMON_TYPES.ELECTRIC,
			power = {"100", "100", "100", "120", "120"},
			pp = "5",
			accuracy = "50",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "193",
			name = "Foresight",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "40",
			accuracy = {"100", "100", "100", Graphics.TEXT.PLACEHOLDER, Graphics.TEXT.PLACEHOLDER},
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "194",
			name = "Destiny Bond",
			type = PokemonData.POKEMON_TYPES.GHOST,
			power = Graphics.TEXT.NO_POWER,
			pp = "5",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "195",
			name = "Perish Song",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "5",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "196",
			name = "Icy Wind",
			type = PokemonData.POKEMON_TYPES.ICE,
			power = "55",
			pp = "15",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "197",
			name = "Detect",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = Graphics.TEXT.NO_POWER,
			pp = "5",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "198",
			name = "Bone Rush",
			type = PokemonData.POKEMON_TYPES.GROUND,
			power = "25",
			pp = "10",
			accuracy = {"80", "80", "80", "80", "90"},
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "199",
			name = "Lock-On",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "5",
			accuracy = {"100", "100", "100", Graphics.TEXT.PLACEHOLDER, Graphics.TEXT.PLACEHOLDER},
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "200",
			name = "Outrage",
			type = PokemonData.POKEMON_TYPES.DRAGON,
			power = {"90", "90", "90", "120", "120"},
			pp = {"15", "15", "15", "15", "10"},
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "201",
			name = "Sandstorm",
			type = PokemonData.POKEMON_TYPES.ROCK,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "202",
			name = "Giga Drain",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = {"60", "60", "60", "60", "75"},
			pp = {"5", "5", "5", "10", "10"},
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "203",
			name = "Endure",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "204",
			name = "Charm",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "205",
			name = "Rollout",
			type = PokemonData.POKEMON_TYPES.ROCK,
			power = "30",
			pp = "20",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "206",
			name = "False Swipe",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "40",
			pp = "40",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "207",
			name = "Swagger",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "208",
			name = "Milk Drink",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "209",
			name = "Spark",
			type = PokemonData.POKEMON_TYPES.ELECTRIC,
			power = "65",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "210",
			name = "Fury Cutter",
			type = PokemonData.POKEMON_TYPES.BUG,
			power = {"10", "10", "10", "10", "20"},
			pp = "20",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "211",
			name = "Steel Wing",
			type = PokemonData.POKEMON_TYPES.STEEL,
			power = "70",
			pp = "25",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "212",
			name = "Mean Look",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "5",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "213",
			name = "Attract",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "214",
			name = "Sleep Talk",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "215",
			name = "Heal Bell",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "5",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "216",
			name = "Return",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = ">FR",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "217",
			name = "Present",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "RNG",
			pp = "15",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "218",
			name = "Frustration",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "<FR",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "219",
			name = "Safeguard",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "25",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "220",
			name = "Pain Split",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = {"100", "100", Graphics.TEXT.PLACEHOLDER, Graphics.TEXT.PLACEHOLDER, Graphics.TEXT.PLACEHOLDER},
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "221",
			name = "Sacred Fire",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = "100",
			pp = "5",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "222",
			name = "Magnitude",
			type = PokemonData.POKEMON_TYPES.GROUND,
			power = "RNG",
			pp = "30",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "223",
			name = "DynamicPunch",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "100",
			pp = "5",
			accuracy = "50",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "224",
			name = "Megahorn",
			type = PokemonData.POKEMON_TYPES.BUG,
			power = "120",
			pp = "10",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "225",
			name = "DragonBreath",
			type = PokemonData.POKEMON_TYPES.DRAGON,
			power = "60",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "226",
			name = "Baton Pass",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "40",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "227",
			name = "Encore",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "228",
			name = "Pursuit",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = "40",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "229",
			name = "Rapid Spin",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "20",
			pp = "40",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "230",
			name = "Sweet Scent",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "231",
			name = "Iron Tail",
			type = PokemonData.POKEMON_TYPES.STEEL,
			power = "100",
			pp = "15",
			accuracy = "75",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "232",
			name = "Metal Claw",
			type = PokemonData.POKEMON_TYPES.STEEL,
			power = "50",
			pp = "35",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "233",
			name = "Vital Throw",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "70",
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "234",
			name = "Morning Sun",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "5",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "235",
			name = "Synthesis",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = Graphics.TEXT.NO_POWER,
			pp = "5",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "236",
			name = "Moonlight",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "5",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "237",
			name = "Hidden Power",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "VAR",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "238",
			name = "Cross Chop",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "100",
			pp = "5",
			accuracy = "80",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "239",
			name = "Twister",
			type = PokemonData.POKEMON_TYPES.DRAGON,
			power = "40",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "240",
			name = "Rain Dance",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = Graphics.TEXT.NO_POWER,
			pp = "5",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "241",
			name = "Sunny Day",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = Graphics.TEXT.NO_POWER,
			pp = "5",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "242",
			name = "Crunch",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = "80",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "243",
			name = "Mirror Coat",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "244",
			name = "Psych Up",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "245",
			name = "ExtremeSpeed",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "80",
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "246",
			name = "AncientPower",
			type = PokemonData.POKEMON_TYPES.ROCK,
			power = "60",
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "247",
			name = "Shadow Ball",
			type = PokemonData.POKEMON_TYPES.GHOST,
			power = "80",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "248",
			name = "Future Sight",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = {"80", "80", "80", "80", "100"},
			pp = {"15", "15", "15", "15", "10"},
			accuracy = {"90", "90", "90", "90", "100"},
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "249",
			name = "Rock Smash",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = {"20", "20", "20", "40", "40"},
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "250",
			name = "Whirlpool",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = {"15", "15", "15", "15", "35"},
			pp = "15",
			accuracy = {"70", "70", "70", "70", "85"},
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "251",
			name = "Beat Up",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = "10",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			-- Begin Gen 3 Moves
			id = "252",
			name = "Fake Out",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "40",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "253",
			name = "Uproar",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = {"50", "50", "50", "50", "90"},
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "254",
			name = "Stockpile",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = {"10", "10", "10", "20", "20"},
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "255",
			name = "Spit Up",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "256",
			name = "Swallow",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "257",
			name = "Heat Wave",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = "100",
			pp = "10",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "258",
			name = "Hail",
			type = PokemonData.POKEMON_TYPES.ICE,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "259",
			name = "Torment",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "260",
			name = "Flatter",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "261",
			name = "Will-O-Wisp",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = "75",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "262",
			name = "Memento",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "263",
			name = "Facade",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "70",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "264",
			name = "Focus Punch",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "150",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "265",
			name = "SmellingSalt",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "60",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "266",
			name = "Follow Me",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "267",
			name = "Nature Power",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "268",
			name = "Charge",
			type = PokemonData.POKEMON_TYPES.ELECTRIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "269",
			name = "Taunt",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "270",
			name = "Helping Hand",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "271",
			name = "Trick",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "272",
			name = "Role Play",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "273",
			name = "Wish",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "274",
			name = "Assist",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "275",
			name = "Ingrain",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "276",
			name = "Superpower",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "120",
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "277",
			name = "Magic Coat",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "278",
			name = "Recycle",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "279",
			name = "Revenge",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "60",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "280",
			name = "Brick Break",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "75",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "281",
			name = "Yawn",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "282",
			name = "Knock Off",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = "20",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "283",
			name = "Endeavor",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "284",
			name = "Eruption",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = ">HP",
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "285",
			name = "Skill Swap",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "286",
			name = "Imprison",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "287",
			name = "Refresh",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "288",
			name = "Grudge",
			type = PokemonData.POKEMON_TYPES.GHOST,
			power = Graphics.TEXT.NO_POWER,
			pp = "5",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "289",
			name = "Snatch",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "290",
			name = "Secret Power",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "70",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "291",
			name = "Dive",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = {"60", "60", "60", "80", "80"},
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "292",
			name = "Arm Thrust",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "15",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "293",
			name = "Camouflage",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "294",
			name = "Tail Glow",
			type = PokemonData.POKEMON_TYPES.BUG,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "295",
			name = "Luster Purge",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = "70",
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "296",
			name = "Mist Ball",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = "70",
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "297",
			name = "FeatherDance",
			type = PokemonData.POKEMON_TYPES.FLYING,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "298",
			name = "Teeter Dance",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "299",
			name = "Blaze Kick",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = "85",
			pp = "10",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "300",
			name = "Mud Sport",
			type = PokemonData.POKEMON_TYPES.GROUND,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "301",
			name = "Ice Ball",
			type = PokemonData.POKEMON_TYPES.ICE,
			power = "30",
			pp = "20",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "302",
			name = "Needle Arm",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = "60",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "303",
			name = "Slack Off",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "304",
			name = "Hyper Voice",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "90",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "305",
			name = "Poison Fang",
			type = PokemonData.POKEMON_TYPES.POISON,
			power = "50",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "306",
			name = "Crush Claw",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "75",
			pp = "10",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "307",
			name = "Blast Burn",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = "150",
			pp = "5",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "308",
			name = "Hydro Cannon",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = "150",
			pp = "5",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "309",
			name = "Meteor Mash",
			type = PokemonData.POKEMON_TYPES.STEEL,
			power = "100",
			pp = "10",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "310",
			name = "Astonish",
			type = PokemonData.POKEMON_TYPES.GHOST,
			power = "30",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "311",
			name = "Weather Ball",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "50",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "312",
			name = "Aromatherapy",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = Graphics.TEXT.NO_POWER,
			pp = "5",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "313",
			name = "Fake Tears",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "314",
			name = "Air Cutter",
			type = PokemonData.POKEMON_TYPES.FLYING,
			power = "55",
			pp = "25",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "315",
			name = "Overheat",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = "140",
			pp = "5",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "316",
			name = "Odor Sleuth",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "40",
			accuracy = {"100", "100", "100", Graphics.TEXT.PLACEHOLDER, Graphics.TEXT.PLACEHOLDER},
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "317",
			name = "Rock Tomb",
			type = PokemonData.POKEMON_TYPES.ROCK,
			power = "50",
			pp = "10",
			accuracy = "80",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "318",
			name = "Silver Wind",
			type = PokemonData.POKEMON_TYPES.BUG,
			power = "60",
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "319",
			name = "Metal Sound",
			type = PokemonData.POKEMON_TYPES.STEEL,
			power = Graphics.TEXT.NO_POWER,
			pp = "40",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "320",
			name = "GrassWhistle",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = "55",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "321",
			name = "Tickle",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "322",
			name = "Cosmic Power",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "323",
			name = "Water Spout",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = ">HP",
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "324",
			name = "Signal Beam",
			type = PokemonData.POKEMON_TYPES.BUG,
			power = "75",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "325",
			name = "Shadow Punch",
			type = PokemonData.POKEMON_TYPES.GHOST,
			power = "60",
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "326",
			name = "Extrasensory",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = "80",
			pp = "30",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "327",
			name = "Sky Uppercut",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "85",
			pp = "15",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "328",
			name = "Sand Tomb",
			type = PokemonData.POKEMON_TYPES.GROUND,
			power = {"15", "15", "15", "15", "35"},
			pp = "15",
			accuracy = {"70", "70", "70", "70", "85"},
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "329",
			name = "Sheer Cold",
			type = PokemonData.POKEMON_TYPES.ICE,
			power = Graphics.TEXT.NO_POWER,
			pp = "5",
			accuracy = "30",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "330",
			name = "Muddy Water",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = "95",
			pp = "10",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "331",
			name = "Bullet Seed",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = {"10", "10", "10", "10", "25"},
			pp = "30",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "332",
			name = "Aerial Ace",
			type = PokemonData.POKEMON_TYPES.FLYING,
			power = "60",
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "333",
			name = "Icicle Spear",
			type = PokemonData.POKEMON_TYPES.ICE,
			power = {"10", "10", "10", "10", "25"},
			pp = "30",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "334",
			name = "Iron Defense",
			type = PokemonData.POKEMON_TYPES.STEEL,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "335",
			name = "Block",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "5",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "336",
			name = "Howl",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "40",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "337",
			name = "Dragon Claw",
			type = PokemonData.POKEMON_TYPES.DRAGON,
			power = "80",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "338",
			name = "Frenzy Plant",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = "150",
			pp = "5",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "339",
			name = "Bulk Up",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "340",
			name = "Bounce",
			type = PokemonData.POKEMON_TYPES.FLYING,
			power = "85",
			pp = "5",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "341",
			name = "Mud Shot",
			type = PokemonData.POKEMON_TYPES.GROUND,
			power = "55",
			pp = "15",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "342",
			name = "Poison Tail",
			type = PokemonData.POKEMON_TYPES.POISON,
			power = "50",
			pp = "25",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "343",
			name = "Covet",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = {"40", "40", "40", "40", "60"},
			pp = "40",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "344",
			name = "Volt Tackle",
			type = PokemonData.POKEMON_TYPES.ELECTRIC,
			power = "120",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "345",
			name = "Magical Leaf",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = "60",
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "346",
			name = "Water Sport",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "347",
			name = "Calm Mind",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "348",
			name = "Leaf Blade",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = {"70", "70", "70", "90", "90"},
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "349",
			name = "Dragon Dance",
			type = PokemonData.POKEMON_TYPES.DRAGON,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "350",
			name = "Rock Blast",
			type = PokemonData.POKEMON_TYPES.ROCK,
			power = "25",
			pp = "10",
			accuracy = {"80", "80", "80", "80", "90"},
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "351",
			name = "Shock Wave",
			type = PokemonData.POKEMON_TYPES.ELECTRIC,
			power = "60",
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "352",
			name = "Water Pulse",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = "60",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "353",
			name = "Doom Desire",
			type = PokemonData.POKEMON_TYPES.STEEL,
			power = {"120", "120", "120", "120", "140"},
			pp = "5",
			accuracy = {"85", "85", "85", "85", "100"},
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "354",
			name = "Psycho Boost",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = "140",
			pp = "5",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "355",
			name = "Roost",
			type = PokemonData.POKEMON_TYPES.FLYING,
			power = Graphics.TEXT.PLACEHOLDER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "356",
			name = "Gravity",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "5",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "357",
			name = "Miracle Eye",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "40",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "358",
			name = "Wake-Up Slap",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "70",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "359",
			name = "Hammer Arm",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "100",
			pp = "10",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "360",
			name = "Gyro Ball",
			type = PokemonData.POKEMON_TYPES.STEEL,
			power = "<SPD",
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "361",
			name = "Healing Wish",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "362",
			name = "Brine",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = "65",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "363",
			name = "Natural Gift",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "BRRY",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "364",
			name = "Feint",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = {"50", "50", "50", "50", "30"},
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "365",
			name = "Pluck",
			type = PokemonData.POKEMON_TYPES.FLYING,
			power = "60",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "366",
			name = "Tailwind",
			type = PokemonData.POKEMON_TYPES.FLYING,
			power = Graphics.TEXT.NO_POWER,
			pp = "30",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "367",
			name = "Acupressure",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "30",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "368",
			name = "Metal Burst",
			type = PokemonData.POKEMON_TYPES.STEEL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "369",
			name = "U-turn",
			type = PokemonData.POKEMON_TYPES.BUG,
			power = "70",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "370",
			name = "Close Combat",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "120",
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "371",
			name = "Payback",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = "50",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "372",
			name = "Assurance",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = "50",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "373",
			name = "Embargo",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "374",
			name = "Fling",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = "ITM",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "375",
			name = "Psycho Shift",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "376",
			name = "Trump Card",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "<PP",
			pp = "5",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "377",
			name = "Heal Block",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "378",
			name = "Wring Out",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = ">HP",
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "379",
			name = "Power Trick",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "380",
			name = "Gastro Acid",
			type = PokemonData.POKEMON_TYPES.POISON,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "381",
			name = "Lucky Chant",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "30",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "382",
			name = "Me First",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "383",
			name = "Copycat",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "384",
			name = "Power Swap",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "385",
			name = "Guard Swap",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "386",
			name = "Punishment",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = "STA",
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "387",
			name = "Last Resort",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = {"130", "130", "130", "130", "140"},
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "388",
			name = "Worry Seed",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "389",
			name = "Sucker Punch",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = "80",
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "390",
			name = "Toxic Spikes",
			type = PokemonData.POKEMON_TYPES.POISON,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "391",
			name = "Heart Swap",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "392",
			name = "Aqua Ring",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "393",
			name = "Magnet Rise",
			type = PokemonData.POKEMON_TYPES.ELECTRIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "394",
			name = "Flare Blitz",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = "120",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "395",
			name = "Force Palm",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "60",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "396",
			name = "Aura Sphere",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "90",
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "397",
			name = "Rock Polish",
			type = PokemonData.POKEMON_TYPES.ROCK,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "398",
			name = "Poison Jab",
			type = PokemonData.POKEMON_TYPES.POISON,
			power = "80",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "399",
			name = "Dark Pulse",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = "80",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "400",
			name = "Night Slash",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = "70",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "401",
			name = "Aqua Tail",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = "90",
			pp = "10",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "402",
			name = "Seed Bomb",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = "80",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "403",
			name = "Air Slash",
			type = PokemonData.POKEMON_TYPES.FLYING,
			power = "75",
			pp = "20",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "404",
			name = "X-Scissor",
			type = PokemonData.POKEMON_TYPES.BUG,
			power = "80",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "405",
			name = "Bug Buzz",
			type = PokemonData.POKEMON_TYPES.BUG,
			power = "90",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "406",
			name = "Dragon Pulse",
			type = PokemonData.POKEMON_TYPES.DRAGON,
			power = "90",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "407",
			name = "Dragon Rush",
			type = PokemonData.POKEMON_TYPES.DRAGON,
			power = "100",
			pp = "10",
			accuracy = "75",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "408",
			name = "Power Gem",
			type = PokemonData.POKEMON_TYPES.ROCK,
			power = "70",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "409",
			name = "Drain Punch",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = {"60", "60", "60", "60", "75"},
			pp = {"5", "5", "5", "5", "10"},
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "410",
			name = "Vacuum Wave",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "40",
			pp = "30",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "411",
			name = "Focus Blast",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "120",
			pp = "5",
			accuracy = "70",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "412",
			name = "Energy Ball",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = "80",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "413",
			name = "Brave Bird",
			type = PokemonData.POKEMON_TYPES.FLYING,
			power = "120",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "414",
			name = "Earth Power",
			type = PokemonData.POKEMON_TYPES.GROUND,
			power = "90",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "415",
			name = "Switcheroo",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "416",
			name = "Giga Impact",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "150",
			pp = "5",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "417",
			name = "Nasty Plot",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "418",
			name = "Bullet Punch",
			type = PokemonData.POKEMON_TYPES.STEEL,
			power = "40",
			pp = "30",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "419",
			name = "Avalanche",
			type = PokemonData.POKEMON_TYPES.ICE,
			power = "60",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "420",
			name = "Ice Shard",
			type = PokemonData.POKEMON_TYPES.ICE,
			power = "40",
			pp = "30",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "421",
			name = "Shadow Claw",
			type = PokemonData.POKEMON_TYPES.GHOST,
			power = "70",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "422",
			name = "Thunder Fang",
			type = PokemonData.POKEMON_TYPES.ELECTRIC,
			power = "65",
			pp = "15",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "423",
			name = "Ice Fang",
			type = PokemonData.POKEMON_TYPES.ICE,
			power = "65",
			pp = "15",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "424",
			name = "Fire Fang",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = "65",
			pp = "15",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "425",
			name = "Shadow Sneak",
			type = PokemonData.POKEMON_TYPES.GHOST,
			power = "40",
			pp = "30",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "426",
			name = "Mud Bomb",
			type = PokemonData.POKEMON_TYPES.GROUND,
			power = "65",
			pp = "10",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "427",
			name = "Psycho Cut",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = "70",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "428",
			name = "Zen Headbutt",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = "80",
			pp = "15",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "429",
			name = "Mirror Shot",
			type = PokemonData.POKEMON_TYPES.STEEL,
			power = "65",
			pp = "10",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "430",
			name = "Flash Cannon",
			type = PokemonData.POKEMON_TYPES.STEEL,
			power = "80",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "431",
			name = "Rock Climb",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "90",
			pp = "20",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "432",
			name = "Defog",
			type = PokemonData.POKEMON_TYPES.FLYING,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "433",
			name = "Trick Room",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "5",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "434",
			name = "Draco Meteor",
			type = PokemonData.POKEMON_TYPES.DRAGON,
			power = "140",
			pp = "5",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "435",
			name = "Discharge",
			type = PokemonData.POKEMON_TYPES.ELECTRIC,
			power = "80",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "436",
			name = "Lava Plume",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = "80",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "437",
			name = "Leaf Storm",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = "140",
			pp = "5",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "438",
			name = "Power Whip",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = "120",
			pp = "10",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "439",
			name = "Rock Wrecker",
			type = PokemonData.POKEMON_TYPES.ROCK,
			power = "150",
			pp = "5",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "440",
			name = "Cross Poison",
			type = PokemonData.POKEMON_TYPES.POISON,
			power = "70",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "441",
			name = "Gunk Shot",
			type = PokemonData.POKEMON_TYPES.POISON,
			power = "120",
			pp = "5",
			accuracy = "70",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "442",
			name = "Iron Head",
			type = PokemonData.POKEMON_TYPES.STEEL,
			power = "80",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "443",
			name = "Magnet Bomb",
			type = PokemonData.POKEMON_TYPES.STEEL,
			power = "60",
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "444",
			name = "Stone Edge",
			type = PokemonData.POKEMON_TYPES.ROCK,
			power = "100",
			pp = "5",
			accuracy = "80",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "445",
			name = "Captivate",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "446",
			name = "Stealth Rock",
			type = PokemonData.POKEMON_TYPES.ROCK,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "447",
			name = "Grass Knot",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = "WT",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "448",
			name = "Chatter",
			type = PokemonData.POKEMON_TYPES.FLYING,
			power = "60",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "449",
			name = "Judgment",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "100",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "450",
			name = "Bug Bite",
			type = PokemonData.POKEMON_TYPES.BUG,
			power = "60",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "451",
			name = "Charge Beam",
			type = PokemonData.POKEMON_TYPES.ELECTRIC,
			power = "50",
			pp = "10",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "452",
			name = "Wood Hammer",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = "120",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "453",
			name = "Aqua Jet",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = "40",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "454",
			name = "Attack Order",
			type = PokemonData.POKEMON_TYPES.BUG,
			power = "90",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "455",
			name = "Defend Order",
			type = PokemonData.POKEMON_TYPES.BUG,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "456",
			name = "Heal Order",
			type = PokemonData.POKEMON_TYPES.BUG,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "457",
			name = "Head Smash",
			type = PokemonData.POKEMON_TYPES.ROCK,
			power = "150",
			pp = "5",
			accuracy = "80",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "458",
			name = "Double Hit",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "35",
			pp = "10",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "459",
			name = "Roar of Time",
			type = PokemonData.POKEMON_TYPES.DRAGON,
			power = "150",
			pp = "5",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "460",
			name = "Spacial Rend",
			type = PokemonData.POKEMON_TYPES.DRAGON,
			power = "100",
			pp = "5",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "461",
			name = "Lunar Dance",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "462",
			name = "Crush Grip",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = ">HP",
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "463",
			name = "Magma Storm",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = "120",
			pp = "5",
			accuracy = {"70", "70", "70", "70", "75"},
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "464",
			name = "Dark Void",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = "80",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "465",
			name = "Seed Flare",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = "120",
			pp = "5",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "466",
			name = "Ominous Wind",
			type = PokemonData.POKEMON_TYPES.GHOST,
			power = "60",
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "467",
			name = "Shadow Force",
			type = PokemonData.POKEMON_TYPES.GHOST,
			power = "120",
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "468",
			name = "Hone Claws",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "469",
			name = "Wide Guard",
			type = PokemonData.POKEMON_TYPES.ROCK,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "470",
			name = "Guard Split",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "471",
			name = "Power Split",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "472",
			name = "Wonder Room",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "473",
			name = "Psyshock",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = "80",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "474",
			name = "Venoshock",
			type = PokemonData.POKEMON_TYPES.POISON,
			power = "65",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "475",
			name = "Autotomize",
			type = PokemonData.POKEMON_TYPES.STEEL,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "476",
			name = "Rage Powder",
			type = PokemonData.POKEMON_TYPES.BUG,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "477",
			name = "Telekinesis",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "478",
			name = "Magic Room",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "479",
			name = "Smack Down",
			type = PokemonData.POKEMON_TYPES.ROCK,
			power = "50",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "480",
			name = "Storm Throw",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = {"60", "60", "60", "60", "40"},
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "481",
			name = "Flame Burst",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = "70",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "482",
			name = "Sludge Wave",
			type = PokemonData.POKEMON_TYPES.POISON,
			power = "95",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "483",
			name = "Quiver Dance",
			type = PokemonData.POKEMON_TYPES.BUG,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "484",
			name = "Heavy Slam",
			type = PokemonData.POKEMON_TYPES.STEEL,
			power = ">WT",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "485",
			name = "Synchronoise",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = {"120", "120", "120", "120", "70"},
			pp = {"10", "10", "10", "10", "15"},
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "486",
			name = "Electro Ball",
			type = PokemonData.POKEMON_TYPES.ELECTRIC,
			power = ">SPE",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "487",
			name = "Soak",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "488",
			name = "Flame Charge",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = "50",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "489",
			name = "Coil",
			type = PokemonData.POKEMON_TYPES.POISON,
			power = Graphics.TEXT.NO_POWER,
			pp = "20",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "490",
			name = "Low Sweep",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = {"65", "65", "65", "65", "60"},
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "491",
			name = "Acid Spray",
			type = PokemonData.POKEMON_TYPES.POISON,
			power = "40",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "492",
			name = "Foul Play",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = "95",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "493",
			name = "Simple Beam",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "494",
			name = "Entrainment",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "495",
			name = "After You",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "496",
			name = "Round",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "60",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "497",
			name = "Echoed Voice",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "40",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "498",
			name = "Chip Away",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "70",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "499",
			name = "Clear Smog",
			type = PokemonData.POKEMON_TYPES.POISON,
			power = "50",
			pp = "15",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "500",
			name = "Stored Power",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = "20",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "501",
			name = "Quick Guard",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "502",
			name = "Ally Switch",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "503",
			name = "Scald",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = "80",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "504",
			name = "Shell Smash",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "505",
			name = "Heal Pulse",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "506",
			name = "Hex",
			type = PokemonData.POKEMON_TYPES.GHOST,
			power = {"65", "65", "65", "65", "50"},
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "507",
			name = "Sky Drop",
			type = PokemonData.POKEMON_TYPES.FLYING,
			power = "60",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "508",
			name = "Shift Gear",
			type = PokemonData.POKEMON_TYPES.STEEL,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "509",
			name = "Circle Throw",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "60",
			pp = "10",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "510",
			name = "Incinerate",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = {"60", "60", "60", "60", "30"},
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "511",
			name = "Quash",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "512",
			name = "Acrobatics",
			type = PokemonData.POKEMON_TYPES.FLYING,
			power = "55",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "513",
			name = "Reflect Type",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "514",
			name = "Retaliate",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "70",
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "515",
			name = "Final Gambit",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "HP",
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "516",
			name = "Bestow",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "15",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "517",
			name = "Inferno",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = "100",
			pp = "5",
			accuracy = "50",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "518",
			name = "Water Pledge",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = {"80", "80", "80", "80", "50"},
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "519",
			name = "Fire Pledge",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = {"80", "80", "80", "80", "50"},
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "520",
			name = "Grass Pledge",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = {"80", "80", "80", "80", "50"},
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "521",
			name = "Volt Switch",
			type = PokemonData.POKEMON_TYPES.ELECTRIC,
			power = "70",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "522",
			name = "Struggle Bug",
			type = PokemonData.POKEMON_TYPES.BUG,
			power = {"50", "50", "50", "50", "30"},
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "523",
			name = "Bulldoze",
			type = PokemonData.POKEMON_TYPES.GROUND,
			power = "60",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "524",
			name = "Frost Breath",
			type = PokemonData.POKEMON_TYPES.ICE,
			power = {"60", "60", "60", "60", "40"},
			pp = "10",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "525",
			name = "Dragon Tail",
			type = PokemonData.POKEMON_TYPES.DRAGON,
			power = "60",
			pp = "10",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "526",
			name = "Work Up",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = Graphics.TEXT.NO_POWER,
			pp = "30",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "527",
			name = "Electroweb",
			type = PokemonData.POKEMON_TYPES.ELECTRIC,
			power = "55",
			pp = "15",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "528",
			name = "Wild Charge",
			type = PokemonData.POKEMON_TYPES.ELECTRIC,
			power = "90",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "529",
			name = "Drill Run",
			type = PokemonData.POKEMON_TYPES.GROUND,
			power = "80",
			pp = "10",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "530",
			name = "Dual Chop",
			type = PokemonData.POKEMON_TYPES.DRAGON,
			power = "40",
			pp = "15",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "531",
			name = "Heart Stamp",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = "60",
			pp = "25",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "532",
			name = "Horn Leech",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = "75",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "533",
			name = "Sacred Sword",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "90",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "534",
			name = "Razor Shell",
			type = PokemonData.POKEMON_TYPES.WATER,
			power = "75",
			pp = "10",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "535",
			name = "Heat Crash",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = ">WT",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "536",
			name = "Leaf Tornado",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = "65",
			pp = "10",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "537",
			name = "Steamroller",
			type = PokemonData.POKEMON_TYPES.BUG,
			power = "65",
			pp = "20",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "538",
			name = "Cotton Guard",
			type = PokemonData.POKEMON_TYPES.GRASS,
			power = Graphics.TEXT.NO_POWER,
			pp = "10",
			accuracy = Graphics.TEXT.PLACEHOLDER,
			category = MoveData.MOVE_CATEGORIES.STATUS
		},
		{
			id = "539",
			name = "Night Daze",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = "85",
			pp = "10",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "540",
			name = "Psystrike",
			type = PokemonData.POKEMON_TYPES.PSYCHIC,
			power = "100",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "541",
			name = "Tail Slap",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "25",
			pp = "10",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "542",
			name = "Hurricane",
			type = PokemonData.POKEMON_TYPES.FLYING,
			power = "120",
			pp = "10",
			accuracy = "70",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "543",
			name = "Head Charge",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "120",
			pp = "15",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "544",
			name = "Gear Grind",
			type = PokemonData.POKEMON_TYPES.STEEL,
			power = "50",
			pp = "15",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "545",
			name = "Searing Shot",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = "100",
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "546",
			name = "Techno Blast",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "85",
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "547",
			name = "Relic Song",
			type = PokemonData.POKEMON_TYPES.NORMAL,
			power = "75",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "548",
			name = "Secret Sword",
			type = PokemonData.POKEMON_TYPES.FIGHTING,
			power = "85",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "549",
			name = "Glaciate",
			type = PokemonData.POKEMON_TYPES.ICE,
			power = "65",
			pp = "10",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "550",
			name = "Bolt Strike",
			type = PokemonData.POKEMON_TYPES.ELECTRIC,
			power = "130",
			pp = "5",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "551",
			name = "Blue Flare",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = "130",
			pp = "5",
			accuracy = "85",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "552",
			name = "Fiery Dance",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = "80",
			pp = "10",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "553",
			name = "Freeze Shock",
			type = PokemonData.POKEMON_TYPES.ICE,
			power = "140",
			pp = "5",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "554",
			name = "Ice Burn",
			type = PokemonData.POKEMON_TYPES.ICE,
			power = "140",
			pp = "5",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "555",
			name = "Snarl",
			type = PokemonData.POKEMON_TYPES.DARK,
			power = "55",
			pp = "15",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "556",
			name = "Icicle Crash",
			type = PokemonData.POKEMON_TYPES.ICE,
			power = "85",
			pp = "10",
			accuracy = "90",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "557",
			name = "V-create",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = "180",
			pp = "5",
			accuracy = "95",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		},
		{
			id = "558",
			name = "Fusion Flare",
			type = PokemonData.POKEMON_TYPES.FIRE,
			power = "100",
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.SPECIAL
		},
		{
			id = "559",
			name = "Fusion Bolt",
			type = PokemonData.POKEMON_TYPES.ELECTRIC,
			power = "100",
			pp = "5",
			accuracy = "100",
			category = MoveData.MOVE_CATEGORIES.PHYSICAL
		}
	}
)

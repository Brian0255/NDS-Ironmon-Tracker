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
	NORMAL = {ROCK = 0.5, GHOST = 0, STEEL = 0.5},
	FIRE = {FIRE = 0.5, WATER = 0.5, GRASS = 2, ICE = 2, BUG = 2, ROCK = 0.5, DRAGON = 0.5, STEEL = 2},
	WATER = {FIRE = 2, WATER = 0.5, GRASS = 0.5, GROUND = 2, ROCK = 2, DRAGON = 0.5},
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
	ELECTRIC = {WATER = 2, GRASS = 0.5, ELECTRIC = 0.5, GROUND = 0, FLYING = 2, DRAGON = 0.5},
	ICE = {FIRE = 0.5, WATER = 0.5, GRASS = 2, ICE = 0.5, GROUND = 2, FLYING = 2, DRAGON = 2, STEEL = 0.5},
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
	POISON = {GRASS = 2, POISON = 0.5, GROUND = 0.5, ROCK = 0.5, GHOST = 0.5, STEEL = 0},
	GROUND = {FIRE = 2, GRASS = 0.5, ELECTRIC = 2, POISON = 2, FLYING = 0, BUG = 0.5, ROCK = 2, STEEL = 2},
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
	ROCK = {FIRE = 2, ICE = 2, FIGHTING = 0.5, GROUND = 0.5, FLYING = 2, BUG = 2, STEEL = 0.5},
	GHOST = {NORMAL = 0, PSYCHIC = 2, GHOST = 2, DARK = 0.5, STEEL = 0.5},
	DRAGON = {DRAGON = 2, STEEL = 0.5},
	DARK = {FIGHTING = 0.5, PSYCHIC = 2, GHOST = 2, DARK = 0.5, STEEL = 0.5},
	STEEL = {FIRE = 0.5, WATER = 0.5, ICE = 2, ROCK = 2, STEEL = 0.5, ELECTRIC = 0.5}
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
		name = "Pound",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "40",
		pp = "35",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact."
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
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User's critical hit rate is one level higher when using this move."
	},
	{
		id = "3",
		name = "DoubleSlap",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "15",
		pp = "10",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Hits 2-5 times in one turn. Averages to 3 hits per use."
	},
	{
		id = "4",
		name = "Comet Punch",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "18",
		pp = "15",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Hits 2-5 times in one turn, and averages to 3 hits per use."
	},
	{
		id = "5",
		name = "Mega Punch",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "80",
		pp = "20",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact."
	},
	{
		id = "6",
		name = "Pay Day",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "40",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. After the battle ends, the winner receives five times the user's level in extra money for each time this move was used."
	},
	{
		id = "7",
		name = "Fire Punch",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "75",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 10% chance to burn the target."
	},
	{
		id = "8",
		name = "Ice Punch",
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "75",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 10% chance to freeze the target."
	},
	{
		id = "9",
		name = "ThunderPunch",
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "75",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 10% chance to paralyze the target."
	},
	{
		id = "10",
		name = "Scratch",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "40",
		pp = "35",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact."
	},
	{
		id = "11",
		name = "ViceGrip",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "55",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact."
	},
	{
		id = "12",
		name = "Guillotine",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = "30",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Instantly KOs the target and makes contact. This move's accuracy is 30% plus 1% for each level the user is higher than the target. If the user is a lower level than the target, this move will fail."
	},
	{
		id = "13",
		name = "Razor Wind",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "80",
		pp = "10",
		accuracy = {"75", "75", "100", "100", "100"},
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. User's critical hit rate is one level higher when using this move. User charges for one turn before attacking."
	},
	{
		id = "14",
		name = "Swords Dance",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Attack by two stages."
	},
	{
		id = "15",
		name = "Cut",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "50",
		pp = "30",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact."
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
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = {
			"Inflicts regular damage. If the target is under the effect of Bounce or Fly, this move will hit with double power.",
			"Inflicts regular damage. If the target is under the effect of Bounce or Fly, this move will hit with double power.",
			"Inflicts regular damage. If the target is under the effect of Bounce or Fly, this move will hit with double power.",
			"Inflicts regular damage. If the target is under the effect of Bounce or Fly, this move will hit with double power.",
			"Inflicts regular damage. If the target is under the effect of Bounce, Fly, or Sky Drop, this move will hit with double power."
		}
	},
	{
		id = "17",
		name = "Wing Attack",
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = {"35", "60", "60", "60", "60"},
		pp = "35",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact."
	},
	{
		id = "18",
		name = "Whirlwind",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = {"85", "100", "100", "100", "100"},
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Decreased priority. Switches the target out for another of its trainer's Pok" ..
			Chars.accentedE ..
				"mon selected at random. Doesn't affect Pok" ..
					Chars.accentedE .. "mon with suction cups or under the effect of ingrain."
	},
	{
		id = "19",
		name = "Fly",
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = {"70", "70", "70", "90", "90"},
		pp = "15",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User flies high into the air for one turn, becoming immune to attack, and hits on the second turn. This move cannot be used while gravity is in effect."
	},
	{
		id = "20",
		name = "Bind",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "15",
		pp = "20",
		accuracy = {"75", "75", "75", "75", "85"},
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = {
			"Makes contact. For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"Makes contact. For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"Makes contact. For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"Makes contact. For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"Makes contact. For the next 4-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn."
		}
	},
	{
		id = "21",
		name = "Slam",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "80",
		pp = "20",
		accuracy = "75",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact."
	},
	{
		id = "22",
		name = "Vine Whip",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "35",
		pp = {"10", "10", "10", "15", "15"},
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact."
	},
	{
		id = "23",
		name = "Stomp",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "65",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 30% chance to make the target flinch. Power is doubled against Pok" ..
			Chars.accentedE .. "mon that are minimized."
	},
	{
		id = "24",
		name = "Double Kick",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "30",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Hits twice in one turn."
	},
	{
		id = "25",
		name = "Mega Kick",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "120",
		pp = "5",
		accuracy = "75",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact."
	},
	{
		id = "26",
		name = "Jump Kick",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = {"70", "70", "70", "85", "100"},
		pp = {"25", "25", "25", "25", "10"},
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = {
			"Inflicts regular damage and makes contact. If this move misses, the user takes half the damage it would have dealt. If the move would have no effect, the user takes damage equal to half the target's max HP.",
			"Inflicts regular damage and makes contact. If this move misses, the user takes half the damage it would have dealt. If the move would have no effect, the user takes damage equal to half the target's max HP.",
			"Inflicts regular damage and makes contact. If this move misses, the user takes half the damage it would have dealt. If the move would have no effect, the user takes damage equal to half the target's max HP.",
			"Inflicts regular damage and makes contact. If this move misses, the user takes half the damage it would have dealt. If the move would have no effect, the user takes damage equal to half the target's max HP.",
			"Inflicts regular damage and makes contact. If this move misses, the user takes half its max HP in damage."
		}
	},
	{
		id = "27",
		name = "Rolling Kick",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "60",
		pp = "15",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 30% chance to make the target flinch."
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
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Lowers the target's Accuracy by one stage."
	},
	{
		id = "29",
		name = "Headbutt",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "70",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 30% chance to make the target flinch."
	},
	{
		id = "30",
		name = "Horn Attack",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "65",
		pp = "25",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact."
	},
	{
		id = "31",
		name = "Fury Attack",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "15",
		pp = "20",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Hits 2-5 times in one turn, and averages to 3 hits per use."
	},
	{
		id = "32",
		name = "Horn Drill",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = "30",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Instantly KOs the target and makes contact. This move's accuracy is 30% plus 1% for each level the user is higher than the target. If the user is a lower level than the target, this move will fail."
	},
	{
		id = "33",
		name = "Tackle",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = {"35", "35", "35", "35", "50"},
		pp = "35",
		accuracy = {"95", "95", "95", "95", "100"},
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact."
	},
	{
		id = "34",
		name = "Body Slam",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "85",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 30% chance to paralyze the target."
	},
	{
		id = "35",
		name = "Wrap",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "15",
		pp = "20",
		accuracy = {"85", "85", "85", "85", "90"},
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = {
			"Makes contact. For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"Makes contact. For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"Makes contact. For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"Makes contact. For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"Makes contact. For the next 4-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn."
		}
	},
	{
		id = "36",
		name = "Take Down",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "90",
		pp = "20",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User takes 1/4 the damage it inflicts in recoil."
	},
	{
		id = "37",
		name = "Thrash",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = {"90", "90", "90", "90", "120"},
		pp = {"20", "20", "20", "20", "10"},
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User is forced to attack with this move for 2-3 turns, selected at random. After the last hit, the user becomes confused."
	},
	{
		id = "38",
		name = "Double-Edge",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = {"100", "120", "120", "120", "120"},
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User takes 1/3 the damage it inflicts in recoil."
	},
	{
		id = "39",
		name = "Tail Whip",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Lowers the target's Defense by one stage."
	},
	{
		id = "40",
		name = "Poison Sting",
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "15",
		pp = "35",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. Has a 30% chance to poison the target."
	},
	{
		id = "41",
		name = "Twineedle",
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "25",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. Hits twice in the same turn. Has a 20% chance on each hit to poison the target."
	},
	{
		id = "42",
		name = "Pin Missile",
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "14",
		pp = "20",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. Hits 2-5 times in one turn, and averages to 3 hits per use."
	},
	{
		id = "43",
		name = "Leer",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Lowers the target's Defense by one stage."
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
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 30% chance to make the target flinch."
	},
	{
		id = "45",
		name = "Growl",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Lowers the target's Attack by one stage."
	},
	{
		id = "46",
		name = "Roar",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Decreased priority. Switches the target out for another of its trainer's Pok" ..
			Chars.accentedE .. "mon selected at random. Wild battles end immediately."
	},
	{
		id = "47",
		name = "Sing",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "55",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Puts the target to sleep."
	},
	{
		id = "48",
		name = "Supersonic",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "55",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Confuses the target."
	},
	{
		id = "49",
		name = "SonicBoom",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "---",
		pp = "20",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts exactly 20 damage."
	},
	{
		id = "50",
		name = "Disable",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = {"55", "55", "55", "80", "100"},
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = {
			"Disables the target's last used move, preventing its use for 4-7 turns, selected at random, or until the target leaves the field. Using an item counts as a turn.",
			"Disables the target's last used move, preventing its use for 4-7 turns, selected at random, or until the target leaves the field. Using an item counts as a turn.",
			"Disables the target's last used move, preventing its use for 4-7 turns, selected at random, or until the target leaves the field. Using an item counts as a turn.",
			"Disables the target's last used move, preventing its use for 4-7 turns, selected at random, or until the target leaves the field. Using an item counts as a turn.",
			"Disables the target's last used move, preventing its use for 4 turns, or until the target leaves the field. Using an item counts as a turn."
		}
	},
	{
		id = "51",
		name = "Acid",
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "40",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to lower the target's Special Defense by one stage."
	},
	{
		id = "52",
		name = "Ember",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "40",
		pp = "25",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to burn the target."
	},
	{
		id = "53",
		name = "Flamethrower",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "95",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to burn the target."
	},
	{
		id = "54",
		name = "Mist",
		type = PokemonData.POKEMON_TYPES.ICE,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Pok" ..
			Chars.accentedE ..
				"mon on the user's side of the field are immune to stat-lowering effects for five turns. Guard Swap, Heart Swap, and Power Swap may still be used."
	},
	{
		id = "55",
		name = "Water Gun",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "40",
		pp = "25",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage."
	},
	{
		id = "56",
		name = "Hydro Pump",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "120",
		pp = "5",
		accuracy = "80",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage."
	},
	{
		id = "57",
		name = "Surf",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "95",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. If the target is in the first turn of dive, this move will hit with double power."
	},
	{
		id = "58",
		name = "Ice Beam",
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "95",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to freeze the target."
	},
	{
		id = "59",
		name = "Blizzard",
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "120",
		pp = "5",
		accuracy = {"90", "70", "70", "70", "70"},
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to freeze the target. During hail, this move has perfect accuracy."
	},
	{
		id = "60",
		name = "Psybeam",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "65",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to confuse the target."
	},
	{
		id = "61",
		name = "BubbleBeam",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "65",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to lower the target's Speed by one stage."
	},
	{
		id = "62",
		name = "Aurora Beam",
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "65",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to lower the target's Attack by one stage."
	},
	{
		id = "63",
		name = "Hyper Beam",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "150",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. User loses its next turn to recharge, and cannot attack or switch out during that turn."
	},
	{
		id = "64",
		name = "Peck",
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "35",
		pp = "35",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact."
	},
	{
		id = "65",
		name = "Drill Peck",
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "80",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact."
	},
	{
		id = "66",
		name = "Submission",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "80",
		pp = "25",
		accuracy = "80",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User takes 1/4 the damage it inflicts in recoil."
	},
	{
		id = "67",
		name = "Low Kick",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = {"50", "50", "WT", "WT", "WT"},
		pp = "20",
		accuracy = {"90", "90", "100", "100", "100"},
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Power increases with the target's weight in kilograms, to a maximum of 120."
	},
	{
		id = "68",
		name = "Counter",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Decreased priority and makes contact. Inflicts twice the damage that move did to the user. If there is no eligible target, this move will fail. Type immunity applies, but other type effects are ignored."
	},
	{
		id = "69",
		name = "Seismic Toss",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Makes contact and inflicts damage equal to the user's level. Type immunity applies, but other type effects are ignored."
	},
	{
		id = "70",
		name = "Strength",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact."
	},
	{
		id = "71",
		name = "Absorb",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = 20,
		pp = {"20", "20", "20", "25", "25"},
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Drains half the damage inflicted to heal the user."
	},
	{
		id = "72",
		name = "Mega Drain",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "40",
		pp = {"10", "10", "10", "15", "15"},
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Drains half the damage inflicted to heal the user."
	},
	{
		id = "73",
		name = "Leech Seed",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Plants a seed on the target that drains 1/8 of its max HP at the end of every turn. Has no effect on grass Pok" ..
			Chars.accentedE .. "mon, and Liquid Ooze will cause the user to take damage."
	},
	{
		id = "74",
		name = "Growth",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = {
			"Raises the user's Special Attack by one stage.",
			"Raises the user's Special Attack by one stage.",
			"Raises the user's Special Attack by one stage.",
			"Raises the user's Special Attack by one stage.",
			"Raises the user's Attack and Special Attack by one stage each. During sunny day, raises both stats by two stages."
		}
	},
	{
		id = "75",
		name = "Razor Leaf",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "55",
		pp = "25",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. User's critical hit rate is one level higher when using this move."
	},
	{
		id = "76",
		name = "SolarBeam",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "120",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. User charges for one turn before attacking. During sunny day, the charge turn is skipped."
	},
	{
		id = "77",
		name = "PoisonPowder",
		type = PokemonData.POKEMON_TYPES.POISON,
		power = Graphics.TEXT.NO_POWER,
		pp = "35",
		accuracy = "75",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Poisons the target."
	},
	{
		id = "78",
		name = "Stun Spore",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = "75",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Paralyzes the target."
	},
	{
		id = "79",
		name = "Sleep Powder",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "75",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Puts the target to sleep."
	},
	{
		id = "80",
		name = "Petal Dance",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = {"70", "70", "70", "90", "120"},
		pp = {"20", "20", "20", "20", "10"},
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage and makes contact. User is forced to attack with this move for 2-3 turns, selected at random. After the last hit, the user becomes confused."
	},
	{
		id = "81",
		name = "String Shot",
		type = PokemonData.POKEMON_TYPES.BUG,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Lowers the target's Speed by two stages."
	},
	{
		id = "82",
		name = "Dragon Rage",
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = "---",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts exactly 40 damage."
	},
	{
		id = "83",
		name = "Fire Spin",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = {"15", "15", "15", "15", "35"},
		pp = "15",
		accuracy = {"70", "70", "70", "70", "85"},
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = {
			"For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"For the next 4-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn."
		}
	},
	{
		id = "84",
		name = "ThunderShock",
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "40",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to paralyze the target."
	},
	{
		id = "85",
		name = "Thunderbolt",
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "95",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to paralyze the target."
	},
	{
		id = "86",
		name = "Thunder Wave",
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Paralyzes the target."
	},
	{
		id = "87",
		name = "Thunder",
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "120",
		pp = "10",
		accuracy = "70",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 30% chance to paralyze the target. Has perfect accuracy in the rain, but only 50% accuracy in harsh sunlight."
	},
	{
		id = "88",
		name = "Rock Throw",
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = "50",
		pp = "15",
		accuracy = {"65", "90", "90", "90", "90"},
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage."
	},
	{
		id = "89",
		name = "Earthquake",
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = "100",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. If the target is in the first turn of dig, this move will hit with double power."
	},
	{
		id = "90",
		name = "Fissure",
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = "30",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Instantly KOs the target. This move's accuracy is 30% plus 1% for each level the user is higher than the target. If the user is a lower level than the target, this move will fail."
	},
	{
		id = "91",
		name = "Dig",
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = {"100", "60", "60", "80", "80"},
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Makes contact. User digs underground for one turn, becoming immune to all attacks except for earthquake and magnitude, which hit for double power. User inflicts regular damage next turn."
	},
	{
		id = "92",
		name = "Toxic",
		type = PokemonData.POKEMON_TYPES.POISON,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = {"85", "85", "85", "85", "90"},
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Badly poisons the target."
	},
	{
		id = "93",
		name = "Confusion",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "50",
		pp = "25",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to confuse the target."
	},
	{
		id = "94",
		name = "Psychic",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "90",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to lower the target's Special Defense by one stage."
	},
	{
		id = "95",
		name = "Hypnosis",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "60",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Puts the target to sleep."
	},
	{
		id = "96",
		name = "Meditate",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Attack by one stage."
	},
	{
		id = "97",
		name = "Agility",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Speed by two stages."
	},
	{
		id = "98",
		name = "Quick Attack",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "40",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Increased priority. Inflicts regular damage and makes contact."
	},
	{
		id = "99",
		name = "Rage",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "20",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Every time the user is hit after it uses this move but before its next action, its Attack raises by one stage."
	},
	{
		id = "100",
		name = "Teleport",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Does nothing. Wild battles end immediately."
	},
	{
		id = "101",
		name = "Night Shade",
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts damage equal to the user's level. Type immunity applies, but other type effects are ignored."
	},
	{
		id = "102",
		name = "Mimic",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = {"100", "100", Graphics.TEXT.ALWAYS_HITS, Graphics.TEXT.ALWAYS_HITS, Graphics.TEXT.ALWAYS_HITS},
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = {
			"This move is replaced by the target's last successfully used move, and its PP changes to 5. If Chatter, Metronome, Mimic, Sketch, or Struggle is selected, this move will fail.",
			"This move is replaced by the target's last successfully used move, and its PP changes to 5. If Chatter, Metronome, Mimic, Sketch, or Struggle is selected, this move will fail.",
			"This move is replaced by the target's last successfully used move, and its PP changes to 5. If Chatter, Metronome, Mimic, Sketch, or Struggle is selected, this move will fail.",
			"This move is replaced by the target's last successfully used move, and its PP changes to 5. If Chatter, Metronome, Mimic, Sketch, or Struggle is selected, this move will fail.",
			"This move is replaced by the target's last successfully used move, with full PP. If Chatter, Metronome, Mimic, Sketch, Struggle, or Transform is selected, this move will fail."
		}
	},
	{
		id = "103",
		name = "Screech",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Lowers the target's Defense by two stages."
	},
	{
		id = "104",
		name = "Double Team",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Evasion by one stage."
	},
	{
		id = "105",
		name = "Recover",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = {"20", "20", "20", "10", "10"},
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Heals the user for half its max HP."
	},
	{
		id = "106",
		name = "Harden",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Defense by one stage."
	},
	{
		id = "107",
		name = "Minimize",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = {
			"Raises the user's Evasion by one stage. Stomp has double power against Pok" ..
				Chars.accentedE .. "mon that have used this move since entering the field.",
			"Raises the user's Evasion by one stage. Stomp has double power against Pok" ..
				Chars.accentedE .. "mon that have used this move since entering the field.",
			"Raises the user's Evasion by one stage. Stomp has double power against Pok" ..
				Chars.accentedE .. "mon that have used this move since entering the field.",
			"Raises the user's Evasion by one stage. Stomp has double power against Pok" ..
				Chars.accentedE .. "mon that have used this move since entering the field.",
			"Raises the user's Evasion by two stages. Stomp and Steamroller have double power against Pok" ..
				Chars.accentedE .. "mon that have used this move since entering the field."
		}
	},
	{
		id = "108",
		name = "SmokeScreen",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Lowers the target's Accuracy by one stage."
	},
	{
		id = "109",
		name = "Confuse Ray",
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Confuses the target."
	},
	{
		id = "110",
		name = "Withdraw",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Defense by one stage."
	},
	{
		id = "111",
		name = "Defense Curl",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises user's Defense by one stage. After this move is used, the power of Ice Ball and Rollout are doubled until the user leaves the field."
	},
	{
		id = "112",
		name = "Barrier",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Defense by two stages."
	},
	{
		id = "113",
		name = "Light Screen",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Erects a barrier around the user's side of the field that reduces damage from special attacks by half for five turns. Brick Break or Defog will destroy the barrier."
	},
	{
		id = "114",
		name = "Haze",
		type = PokemonData.POKEMON_TYPES.ICE,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Removes stat, Accuracy, and Evasion modifiers from every Pok" .. Chars.accentedE .. "mon on the field."
	},
	{
		id = "115",
		name = "Reflect",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Erects a barrier around the user's side of the field that reduces damage from physical attacks by half for five turns. Brick Break or Defog will destroy the barrier."
	},
	{
		id = "116",
		name = "Focus Energy",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "User's critical hit rate is two levels higher until it leaves the field. If the user has already used focus energy since entering the field, this move will fail."
	},
	{
		id = "117",
		name = "Bide",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = {"100", "100", "100", Graphics.TEXT.ALWAYS_HITS, Graphics.TEXT.ALWAYS_HITS},
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Increased priority and makes contact. User waits for two turns. On the second turn, the user inflicts twice the damage it accumulated on the last Pok" ..
			Chars.accentedE .. "mon to hit it. Damage inflicted is typeless."
	},
	{
		id = "118",
		name = "Metronome",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = {
			"Selects any move at random and uses it. Moves the user already knows are not eligible. Assist, meta, protection, and reflection moves are also not eligible.",
			"Selects any move at random and uses it. Moves the user already knows are not eligible. Assist, meta, protection, and reflection moves are also not eligible.",
			"Selects any move at random and uses it. Moves the user already knows are not eligible. Assist, meta, protection, and reflection moves are also not eligible.",
			"Selects any move at random and uses it. Moves the user already knows are not eligible. Assist, meta, protection, and reflection moves are also not eligible.",
			"Selects any move at random and uses it. Assist, meta, protection, and reflection moves are not eligible."
		}
	},
	{
		id = "119",
		name = "Mirror Move",
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Uses the last move targeted at the user by a Pok" .. Chars.accentedE .. "mon still on the field."
	},
	{
		id = "120",
		name = "Selfdestruct",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = {"130", "200", "200", "200", "200"},
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = {
			"User faints, even if the attack fails or misses. Inflicts regular damage. Halves the target's Defense for damage calculation.",
			"User faints, even if the attack fails or misses. Inflicts regular damage. Halves the target's Defense for damage calculation.",
			"User faints, even if the attack fails or misses. Inflicts regular damage. Halves the target's Defense for damage calculation.",
			"User faints, even if the attack fails or misses. Inflicts regular damage. Halves the target's Defense for damage calculation.",
			"User faints, even if the attack fails or misses. Inflicts regular damage."
		}
	},
	{
		id = "121",
		name = "Egg Bomb",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "100",
		pp = "10",
		accuracy = "75",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage."
	},
	{
		id = "122",
		name = "Lick",
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = "20",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 30% chance to paralyze the target."
	},
	{
		id = "123",
		name = "Smog",
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "20",
		pp = "20",
		accuracy = "70",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 40% chance to poison the target."
	},
	{
		id = "124",
		name = "Sludge",
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "65",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 30% chance to poison the target."
	},
	{
		id = "125",
		name = "Bone Club",
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = "65",
		pp = "20",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. Has a 10% chance to make the target flinch."
	},
	{
		id = "126",
		name = "Fire Blast",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "120",
		pp = "5",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to burn the target."
	},
	{
		id = "127",
		name = "Waterfall",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 20% chance to make the target flinch."
	},
	{
		id = "128",
		name = "Clamp",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "35",
		pp = {"10", "10", "10", "10", "15"},
		accuracy = {"75", "75", "75", "75", "85"},
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = {
			"Makes contact. For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"Makes contact. For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"Makes contact. For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"Makes contact. For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"Makes contact. For the next 4-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn."
		}
	},
	{
		id = "129",
		name = "Swift",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "60",
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Ignores Accuracy and Evasion modifiers."
	},
	{
		id = "130",
		name = "Skull Bash",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "100",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Raises the user's Defense by one stage. User then charges for one turn before attacking."
	},
	{
		id = "131",
		name = "Spike Cannon",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "20",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. Hits 2-5 times in one turn, and averages to 3 hits per use."
	},
	{
		id = "132",
		name = "Constrict",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "10",
		pp = "35",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 10% chance to lower the target's Speed by one stage."
	},
	{
		id = "133",
		name = "Amnesia",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Special Defense by two stages."
	},
	{
		id = "134",
		name = "Kinesis",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "80",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Lowers the target's Accuracy by one stage."
	},
	{
		id = "135",
		name = "Softboiled",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Heals the user for half its max HP."
	},
	{
		id = "136",
		name = "Hi Jump Kick",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = {"85", "85", "85", "100", "130"},
		pp = {"20", "20", "20", "20", "10"},
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. If this move does not hit the target, the user takes damage equal to half of its max HP rounded down. Gravity disables this move."
	},
	{
		id = "137",
		name = "Glare",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = {"75", "75", "75", "75", "90"},
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Paralyzes the target."
	},
	{
		id = "138",
		name = "Dream Eater",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "100",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Fails if not used on a sleeping Pok" ..
			Chars.accentedE .. "mon. Inflicts regular damage. Drains half the damage inflicted to heal the user."
	},
	{
		id = "139",
		name = "Poison Gas",
		type = PokemonData.POKEMON_TYPES.POISON,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = {"55", "55", "55", "55", "80"},
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Poisons the target."
	},
	{
		id = "140",
		name = "Barrage",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "15",
		pp = "20",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. Hits 2-5 times in one turn. Averages to 3 hits per use."
	},
	{
		id = "141",
		name = "Leech Life",
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "20",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Drains half the damage inflicted to heal the user."
	},
	{
		id = "142",
		name = "Lovely Kiss",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "75",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Puts the target to sleep."
	},
	{
		id = "143",
		name = "Sky Attack",
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "140",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. User charges for one turn before attacking, and critical hit chance is one level higher than normal. Has a 30% chance to make the target flinch."
	},
	{
		id = "144",
		name = "Transform",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "User copies the target's species, weight, type, ability, calculated stats (except HP), and moves. Copied moves will all have 5 PP remaining."
	},
	{
		id = "145",
		name = "Bubble",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "20",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to lower the target's Speed by one stage."
	},
	{
		id = "146",
		name = "Dizzy Punch",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "70",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 20% chance to confuse the target."
	},
	{
		id = "147",
		name = "Spore",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Puts the target to sleep."
	},
	{
		id = "148",
		name = "Flash",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = {"70", "70", "70", "100", "100"},
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Lowers the target's Accuracy by one stage."
	},
	{
		id = "149",
		name = "Psywave",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "80",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = {
			"Inflicts typeless damage between 50% and 150% of the user's level, selected at random in increments of 10%.",
			"Inflicts typeless damage between 50% and 150% of the user's level, selected at random in increments of 10%.",
			"Inflicts typeless damage between 50% and 150% of the user's level, selected at random in increments of 10%.",
			"Inflicts typeless damage between 50% and 150% of the user's level, selected at random in increments of 10%.",
			"Inflicts typeless damage between 50% and 150% of the user's level, selected at random in increments of 1%."
		}
	},
	{
		id = "150",
		name = "Splash",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Makes the user absolutely useless for one turn."
	},
	{
		id = "151",
		name = "Acid Armor",
		type = PokemonData.POKEMON_TYPES.POISON,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Defense by two stages."
	},
	{
		id = "152",
		name = "Crabhammer",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "90",
		pp = "10",
		accuracy = {"85", "85", "85", "85", "90"},
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User's critical hit rate is one level higher when using this move."
	},
	{
		id = "153",
		name = "Explosion",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = {"170", "250", "250", "250", "250"},
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = {
			"User faints, even if the attack fails or misses. Inflicts regular damage. Halves the target's Defense for damage calculation.",
			"User faints, even if the attack fails or misses. Inflicts regular damage. Halves the target's Defense for damage calculation.",
			"User faints, even if the attack fails or misses. Inflicts regular damage. Halves the target's Defense for damage calculation.",
			"User faints, even if the attack fails or misses. Inflicts regular damage. Halves the target's Defense for damage calculation.",
			"User faints, even if the attack fails or misses. Inflicts regular damage."
		}
	},
	{
		id = "154",
		name = "Fury Swipes",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "18",
		pp = "15",
		accuracy = "80",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Hits 2-5 times in one turn, and averages to 3 hits per use."
	},
	{
		id = "155",
		name = "Bonemerang",
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = "50",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. Hits twice in one turn."
	},
	{
		id = "156",
		name = "Rest",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "User falls to sleep and immediately regains all its HP. The user will always wake up after two turns, or one turn with early bird."
	},
	{
		id = "157",
		name = "Rock Slide",
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = "75",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. Has a 30% chance to make the target flinch."
	},
	{
		id = "158",
		name = "Hyper Fang",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "80",
		pp = "15",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 10% chance to make the target flinch."
	},
	{
		id = "159",
		name = "Sharpen",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Attack by one stage."
	},
	{
		id = "160",
		name = "Conversion",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = {
			"User's type changes to the type of one of its moves, selected at random. Only moves with a different type are eligible, and Curse is never eligible.",
			"User's type changes to the type of one of its moves, selected at random. Only moves with a different type are eligible, and Curse is never eligible.",
			"User's type changes to the type of one of its moves, selected at random. Only moves with a different type are eligible, and Curse is never eligible.",
			"User's type changes to the type of one of its moves, selected at random. Only moves with a different type are eligible, and Curse is never eligible.",
			"User's type changes to the type of one of its moves, selected at random. Only moves with a different type are eligible."
		}
	},
	{
		id = "161",
		name = "Tri Attack",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "80",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 20% for an effect to occur, which can then be burn, freeze, or paralysis."
	},
	{
		id = "162",
		name = "Super Fang",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Makes contact. Inflicts typeless damage equal to half the target's remaining HP. Although typeless, this is ineffective against Wonder Guard."
	},
	{
		id = "163",
		name = "Slash",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "70",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User's critical hit rate is one level higher when using this move."
	},
	{
		id = "164",
		name = "Substitute",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Transfers 1/4 the user's max HP into a doll that absorbs damage and causes most negative move effects to fail."
	},
	{
		id = "165",
		name = "Struggle",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "50",
		pp = {"10", "1", "1", "1", "1"},
		accuracy = {"100", "100", "100", Graphics.TEXT.ALWAYS_HITS, Graphics.TEXT.ALWAYS_HITS},
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts typeless regular damage and makes contact. User takes 1/4 its max HP in recoil. Ignores Accuracy and Evasion modifiers."
	},
	{
		-- Begin Gen 2 Moves
		id = "166",
		name = "Sketch",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "1",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Permanently replaces itself with the target's last used move. If that move is chatter or struggle, this move will fail."
	},
	{
		id = "167",
		name = "Triple Kick",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "10",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Makes contact. Inflicts regular damage up to 3 times in the same turn. The second hit has 20 power, and the third hit has 30, for a total of 60. Move stops if any hits miss."
	},
	{
		id = "168",
		name = "Thief",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "40",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. If the target is holding an item and the user is not, the user will permanently take the item. Damage is still inflicted if an item cannot be taken."
	},
	{
		id = "169",
		name = "Spider Web",
		type = PokemonData.POKEMON_TYPES.BUG,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "The target cannot switch out normally. Ignores Accuracy and Evasion modifiers. This effect ends when the user leaves the field."
	},
	{
		id = "170",
		name = "Mind Reader",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = {"100", "100", "100", Graphics.TEXT.ALWAYS_HITS, Graphics.TEXT.ALWAYS_HITS},
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "If the user targets the same target again before the end of the next turn, the move it uses is guaranteed to hit. This move itself also ignores Accuracy and Evasion modifiers."
	},
	{
		id = "171",
		name = "Nightmare",
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Only works on sleeping Pok" ..
			Chars.accentedE ..
				"mon. Gives the target a nightmare, damaging it for 1/4 its max HP every turn. If the target wakes up or leaves the field, this effect ends."
	},
	{
		id = "172",
		name = "Flame Wheel",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "60",
		pp = "25",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 10% chance to burn the target. Frozen Pok" ..
			Chars.accentedE .. "mon may use this move, in which case they will thaw."
	},
	{
		id = "173",
		name = "Snore",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "40",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Only usable if the user is sleeping. Inflicts regular damage. Has a 30% chance to make the target flinch."
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
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "If the user is a ghost: user pays half its max HP to place a curse on the target, damaging it for 1/4 its max HP every turn. Otherwise, it lowers the user's Speed by one stage, and raises its Attack and Defense by one stage each."
	},
	{
		id = "175",
		name = "Flail",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "<HP",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Power varies inversely with the user's proportional remaining HP."
	},
	{
		id = "176",
		name = "Conversion 2",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Changes the user's type to a type either resistant or immune to the last damaging move that hit it. The new type is selected at random and cannot be a type the user already is."
	},
	{
		id = "177",
		name = "Aeroblast",
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "100",
		pp = "5",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. User's critical hit rate is one level higher when using this move."
	},
	{
		id = "178",
		name = "Cotton Spore",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = {"85", "85", "85", "85", "100"},
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Lowers the target's Speed by two stages."
	},
	{
		id = "179",
		name = "Reversal",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "<HP",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Power varies inversely with the user's proportional remaining HP."
	},
	{
		id = "180",
		name = "Spite",
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Lowers the PP of the target's last used move by 4."
	},
	{
		id = "181",
		name = "Powder Snow",
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "40",
		pp = "25",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to freeze the target."
	},
	{
		id = "182",
		name = "Protect",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Increased priority. No moves will hit the user for the remainder of this turn. If the user is last to act this turn, this move will fail."
	},
	{
		id = "183",
		name = "Mach Punch",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "40",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Increased priority. Inflicts regular damage and makes contact."
	},
	{
		id = "184",
		name = "Scary Face",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = {"90", "90", "90", "90", "100"},
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Lowers the target's Speed by two stages."
	},
	{
		id = "185",
		name = "Faint Attack",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "60",
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Ignores Accuracy and Evasion modifiers."
	},
	{
		id = "186",
		name = "Sweet Kiss",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "75",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Confuses the target."
	},
	{
		id = "187",
		name = "Belly Drum",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "User pays half its max HP to raise its Attack to +6 stages. If the user cannot pay the HP cost, this move will fail."
	},
	{
		id = "188",
		name = "Sludge Bomb",
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "90",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 30% chance to poison the target."
	},
	{
		id = "189",
		name = "Mud-Slap",
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = "20",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 100% chance to lower the target's Accuracy by one stage."
	},
	{
		id = "190",
		name = "Octazooka",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "65",
		pp = "10",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 50% chance to lower the target's Accuracy by one stage."
	},
	{
		id = "191",
		name = "Spikes",
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Scatters spikes around the opposing field, which damage opposing Pok" ..
			Chars.accentedE ..
				"mon that enter the field for 1/8 of their max HP. Up to three layers of spikes may be laid down, adding 1/16 more damage for each layer."
	},
	{
		id = "192",
		name = "Zap Cannon",
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = {"100", "100", "100", "120", "120"},
		pp = "5",
		accuracy = "50",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 100% chance to paralyze the target."
	},
	{
		id = "193",
		name = "Foresight",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = {"100", "100", "100", Graphics.TEXT.ALWAYS_HITS, Graphics.TEXT.ALWAYS_HITS},
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Ignores the target's boosted Evasion stages until the target leaves the field. A ghost under this effect takes normal damage from normal and fighting moves."
	},
	{
		id = "194",
		name = "Destiny Bond",
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "If the user faints before its next move, the Pok" ..
			Chars.accentedE .. "mon that fainted it will automatically faint. End-of-turn damage is ignored."
	},
	{
		id = "195",
		name = "Perish Song",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Every Pok" ..
			Chars.accentedE ..
				"mon is given a counter that starts at 3 and decreases by 1 at the end of every turn. When a Pok" ..
					Chars.accentedE .. "mon's counter reaches zero, that Pok" .. Chars.accentedE .. "mon faints."
	},
	{
		id = "196",
		name = "Icy Wind",
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "55",
		pp = "15",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 100% chance to lower the target's Speed by one stage."
	},
	{
		id = "197",
		name = "Detect",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Increased priority. No moves will hit the user for the remainder of this turn. If the user is last to act this turn, this move will fail."
	},
	{
		id = "198",
		name = "Bone Rush",
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = "25",
		pp = "10",
		accuracy = {"80", "80", "80", "80", "90"},
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. Hits 2-5 times in one turn. Averages to 3 hits per use."
	},
	{
		id = "199",
		name = "Lock-On",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = {"100", "100", "100", Graphics.TEXT.ALWAYS_HITS, Graphics.TEXT.ALWAYS_HITS},
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "If the user targets the same target again before the end of the next turn, the move it uses is guaranteed to hit. This move itself also ignores Accuracy and Evasion modifiers."
	},
	{
		id = "200",
		name = "Outrage",
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = {"90", "90", "90", "120", "120"},
		pp = {"15", "15", "15", "15", "10"},
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User is forced to attack with this move for 2-3 turns, selected at random. After the last hit, the user becomes confused."
	},
	{
		id = "201",
		name = "Sandstorm",
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Summons a to a sandstorm for five turns. Pok" ..
			Chars.accentedE ..
				"mon that are not ground, rock, or steel take 1/16 their max HP at the end of every turn. Every rock Pok" ..
					Chars.accentedE .. "mon's Special Defense is raised by 50% for the duration of this effect."
	},
	{
		id = "202",
		name = "Giga Drain",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = {"60", "60", "60", "60", "75"},
		pp = {"5", "5", "5", "10", "10"},
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Drains half the damage inflicted to heal the user."
	},
	{
		id = "203",
		name = "Endure",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Increased priority. The user's HP cannot be lowered below 1 by any means for the remainder of this turn."
	},
	{
		id = "204",
		name = "Charm",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Lowers the target's Attack by two stages."
	},
	{
		id = "205",
		name = "Rollout",
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = "30",
		pp = "20",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User is forced to use this move for five turns. Power doubles every time this move is used in succession to a maximum of 16x. If this move misses, the lock-in ends."
	},
	{
		id = "206",
		name = "False Swipe",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "40",
		pp = "40",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Will not reduce the target's HP below 1."
	},
	{
		id = "207",
		name = "Swagger",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the target's Attack by two stages, then confuses it."
	},
	{
		id = "208",
		name = "Milk Drink",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Heals the user for half its max HP."
	},
	{
		id = "209",
		name = "Spark",
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "65",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 30% chance to paralyze the target."
	},
	{
		id = "210",
		name = "Fury Cutter",
		type = PokemonData.POKEMON_TYPES.BUG,
		power = {"10", "10", "10", "10", "20"},
		pp = "20",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = {
			"Inflicts regular damage and makes contact. Power doubles after every time this move is used, whether consecutively or not, maxing out at 16x. If this move misses, power resets.",
			"Inflicts regular damage and makes contact. Power doubles after every time this move is used, whether consecutively or not, maxing out at 16x. If this move misses, power resets.",
			"Inflicts regular damage and makes contact. Power doubles after every time this move is used, whether consecutively or not, maxing out at 16x. If this move misses, power resets.",
			"Inflicts regular damage and makes contact. Power doubles after every time this move is used, whether consecutively or not, maxing out at 16x. If this move misses, power resets.",
			"Inflicts regular damage and makes contact. Power doubles after every time this move is used consecutively, maxing out at 16x. If this move misses, power resets."
		}
	},
	{
		id = "211",
		name = "Steel Wing",
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = "70",
		pp = "25",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 10% chance to raise the user's Defense one stage."
	},
	{
		id = "212",
		name = "Mean Look",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "The target cannot switch out normally. Ignores Accuracy and Evasion modifiers. This effect ends when the user leaves the field."
	},
	{
		id = "213",
		name = "Attract",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Causes the target to fall in love with the user, giving it a 50% chance to do nothing each turn. If the user and target are the same gender, or either is genderless, this move will fail."
	},
	{
		id = "214",
		name = "Sleep Talk",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Only usable if the user is sleeping. Randomly selects and uses one of the user's other three moves, with some exceptions. Use of the selected move costs 0 PP."
	},
	{
		id = "215",
		name = "Heal Bell",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Removes major status effects and confusion from every Pok" .. Chars.accentedE .. "mon in the user's party."
	},
	{
		id = "216",
		name = "Return",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = ">FR",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Power increases with happiness to a maximum of 102. Power bottoms out at 1."
	},
	{
		id = "217",
		name = "Present",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "RNG",
		pp = "15",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Has a 40% chance to deal 40 damage, 30% chance to deal 80 damage, 10% chance to deal 120 damage, and a 20% chance to heal the target for 1/4 of its max HP."
	},
	{
		id = "218",
		name = "Frustration",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "<FR",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Power increases inversely with happiness, to a maximum of 102. Power bottoms out at 1."
	},
	{
		id = "219",
		name = "Safeguard",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "25",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Protects Pok" ..
			Chars.accentedE ..
				"mon on the user's side of the field from major status effects and confusion for five turns. This effect remains even if the user leaves the field."
	},
	{
		id = "220",
		name = "Pain Split",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = {"100", "100", Graphics.TEXT.ALWAYS_HITS, Graphics.TEXT.ALWAYS_HITS, Graphics.TEXT.ALWAYS_HITS},
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Changes the user's and target's remaining HP to the average of their current remaining HP. Ignores Accuracy and Evasion modifiers."
	},
	{
		id = "221",
		name = "Sacred Fire",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "100",
		pp = "5",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. Has a 50% chance to burn the target. Frozen Pok" ..
			Chars.accentedE .. "mon may use this move, in which case they will thaw."
	},
	{
		id = "222",
		name = "Magnitude",
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = "RNG",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts random damage of 10, 30, 50, 70, 90, 110, or 150 power, with an average of 71. Deals double damage to targets underground."
	},
	{
		id = "223",
		name = "DynamicPunch",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "100",
		pp = "5",
		accuracy = "50",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 100% chance to confuse the target."
	},
	{
		id = "224",
		name = "Megahorn",
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "120",
		pp = "10",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact."
	},
	{
		id = "225",
		name = "DragonBreath",
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = "60",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 30% chance to paralyze the target."
	},
	{
		id = "226",
		name = "Baton Pass",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "User switches out, and the trainer selects a replacement Pok" ..
			Chars.accentedE ..
				"mon from the party. Stat changes, confusion, and persistent move effects are passed along to the replacement Pok" ..
					Chars.accentedE .. "mon."
	},
	{
		id = "227",
		name = "Encore",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = {
			"The next 3-7 (DP) /2-6 (Pt) /4-8 (HGSS) times the target attempts to move, it is forced to repeat its last used move.",
			"The next 3-7 (DP) /2-6 (Pt) /4-8 (HGSS) times the target attempts to move, it is forced to repeat its last used move.",
			"The next 3-7 (DP) /2-6 (Pt) /4-8 (HGSS) times the target attempts to move, it is forced to repeat its last used move.",
			"The next 3-7 (DP) /2-6 (Pt) /4-8 (HGSS) times the target attempts to move, it is forced to repeat its last used move.",
			"The next 3 times the target attempts to move, it is forced to repeat its last used move."
		}
	},
	{
		id = "228",
		name = "Pursuit",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "40",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. If the target attempts to switch out this turn before the user acts, this move hits the target before it leaves and has double power."
	},
	{
		id = "229",
		name = "Rapid Spin",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "20",
		pp = "40",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Removes the effects of leech seed, bind, clamp, fire spin, magma storm, sand tomb, whirlpool, wrap, spikes, toxic spikes, and stealth rock."
	},
	{
		id = "230",
		name = "Sweet Scent",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Lowers the target's Evasion by one stage."
	},
	{
		id = "231",
		name = "Iron Tail",
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = "100",
		pp = "15",
		accuracy = "75",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 30% chance to lower the target's Defense by one stage."
	},
	{
		id = "232",
		name = "Metal Claw",
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = "50",
		pp = "35",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 10% chance to raise the user's Attack one stage."
	},
	{
		id = "233",
		name = "Vital Throw",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "70",
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Decreased priority. Inflicts regular damage and makes contact. Ignores Accuracy and Evasion modifiers."
	},
	{
		id = "234",
		name = "Morning Sun",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Heals the user for half its max HP. In sunny weather, healing is 2/3 max HP, and 1/4 max HP during hail, rain, or sandstorm."
	},
	{
		id = "235",
		name = "Synthesis",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Heals the user for half its max HP. In sunny weather, healing is 2/3 max HP, and 1/4 max HP during hail, rain, or sandstorm."
	},
	{
		id = "236",
		name = "Moonlight",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Heals the user for half its max HP. In sunny weather, healing is 2/3 max HP, and 1/4 max HP during hail, rain, or sandstorm."
	},
	{
		id = "237",
		name = "Hidden Power",
		type = PokemonData.POKEMON_TYPES.UNKNOWN,
		power = "VAR",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Power and type are determined by the user's IVs. Power is always between 30 and 70, with an average of 49.5. Type cannot be normal."
	},
	{
		id = "238",
		name = "Cross Chop",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "100",
		pp = "5",
		accuracy = "80",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User's critical hit rate is one level higher when using this move."
	},
	{
		id = "239",
		name = "Twister",
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = "40",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = {
			"Inflicts regular damage. Has a 20% chance to make each target flinch. If the target is under the effect of Bounce or Fly, this move will hit with double power.",
			"Inflicts regular damage. Has a 20% chance to make each target flinch. If the target is under the effect of Bounce or Fly, this move will hit with double power.",
			"Inflicts regular damage. Has a 20% chance to make each target flinch. If the target is under the effect of Bounce or Fly, this move will hit with double power.",
			"Inflicts regular damage. Has a 20% chance to make each target flinch. If the target is under the effect of Bounce or Fly, this move will hit with double power.",
			"Inflicts regular damage. Has a 20% chance to make each target flinch. If the target is under the effect of Bounce, Fly, or Sky Drop, this move will hit with double power."
		}
	},
	{
		id = "240",
		name = "Rain Dance",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Changes the weather to rain for five turns, during which water moves inflict 50% extra damage, and fire moves inflict half damage."
	},
	{
		id = "241",
		name = "Sunny Day",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Changes the weather to sunshine for five turns, during which fire moves inflict 50% extra damage, and water moves inflict half damage."
	},
	{
		id = "242",
		name = "Crunch",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 20% chance to lower the target's Defense by one stage."
	},
	{
		id = "243",
		name = "Mirror Coat",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Decreased priority. If the user was damaged by a special move, inflicts twice the damage the move did. Type immunity applies, but other type effects are ignored."
	},
	{
		id = "244",
		name = "Psych Up",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Discards the user's stat changes and copies the target's."
	},
	{
		id = "245",
		name = "ExtremeSpeed",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "80",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Increased priority. Inflicts regular damage and makes contact."
	},
	{
		id = "246",
		name = "AncientPower",
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = "60",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to raise all of the user's stats one stage."
	},
	{
		id = "247",
		name = "Shadow Ball",
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 20% chance to lower the target's Special Defense by one stage."
	},
	{
		id = "248",
		name = "Future Sight",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = {"80", "80", "80", "80", "100"},
		pp = {"15", "15", "15", "15", "10"},
		accuracy = {"90", "90", "90", "90", "100"},
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = {
			"Inflicts typeless regular damage at the end of the third turn. This move cannot score a critical hit, and damage is calculated at the time this move is used.",
			"Inflicts typeless regular damage at the end of the third turn. This move cannot score a critical hit, and damage is calculated at the time this move is used.",
			"Inflicts typeless regular damage at the end of the third turn. This move cannot score a critical hit, and damage is calculated at the time this move is used.",
			"Inflicts typeless regular damage at the end of the third turn. This move cannot score a critical hit, and damage is calculated at the time this move is used.",
			"Inflicts regular damage at the end of the third turn. Damage is calculated at the time damage is dealt."
		}
	},
	{
		id = "249",
		name = "Rock Smash",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = {"20", "20", "20", "40", "40"},
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 50% chance to lower the target's Defense by one stage."
	},
	{
		id = "250",
		name = "Whirlpool",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = {"15", "15", "15", "15", "35"},
		pp = "15",
		accuracy = {"70", "70", "70", "70", "85"},
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = {
			"For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"For the next 4-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn."
		}
	},
	{
		id = "251",
		name = "Beat Up",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = {"10", "10", "10", "10", "VAR"},
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = {
			"Inflicts typeless regular damage. Every Pok" ..
				Chars.accentedE ..
					"mon in the user's party, excepting those that have fainted or have a major status effect, attacks the target.",
			"Inflicts typeless regular damage. Every Pok" ..
				Chars.accentedE ..
					"mon in the user's party, excepting those that have fainted or have a major status effect, attacks the target.",
			"Inflicts typeless regular damage. Every Pok" ..
				Chars.accentedE ..
					"mon in the user's party, excepting those that have fainted or have a major status effect, attacks the target.",
			"Inflicts typeless regular damage. Every Pok" ..
				Chars.accentedE ..
					"mon in the user's party, excepting those that have fainted or have a major status effect, attacks the target.",
			"Inflicts regular damage. Every Pok" ..
				Chars.accentedE ..
					"mon in the user's party, excepting those that have fainted or have a major status effect, attacks the target."
		}
	},
	{
		-- Begin Gen 3 Moves
		id = "252",
		name = "Fake Out",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "40",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Increased priority. Inflicts regular damage and makes contact. Causes the target to flinch, and can only be used on the user's first turn after entering the field."
	},
	{
		id = "253",
		name = "Uproar",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = {"50", "50", "50", "50", "90"},
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = {
			"Inflicts regular damage. User is forced to use this move for 2-5 turns, selected at random. All Pok" ..
				Chars.accentedE .. "mon on the field wake up, and none can fall to sleep until the lock-in ends.",
			"Inflicts regular damage. User is forced to use this move for 2-5 turns, selected at random. All Pok" ..
				Chars.accentedE .. "mon on the field wake up, and none can fall to sleep until the lock-in ends.",
			"Inflicts regular damage. User is forced to use this move for 2-5 turns, selected at random. All Pok" ..
				Chars.accentedE .. "mon on the field wake up, and none can fall to sleep until the lock-in ends.",
			"Inflicts regular damage. User is forced to use this move for 2-5 turns, selected at random. All Pok" ..
				Chars.accentedE .. "mon on the field wake up, and none can fall to sleep until the lock-in ends.",
			"Inflicts regular damage. User is forced to use this move for 3 turns. All Pok" ..
				Chars.accentedE .. "mon on the field wake up, and none can fall to sleep until the lock-in ends."
		}
	},
	{
		id = "254",
		name = "Stockpile",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = {"10", "10", "10", "20", "20"},
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Defense and Special Defense by one stage each. Stores energy for use with spit up and swallow. Up to three levels of energy can be stored, and all are lost if the user leaves the field."
	},
	{
		id = "255",
		name = "Spit Up",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Power is equal to 100 times the amount of energy stored by stockpile. Stored energy is consumed, and the user's Defense and Special Defense are reset."
	},
	{
		id = "256",
		name = "Swallow",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Heals the user depending on the amount of energy stored by stockpile: 1/4 its max HP after one use, 1/2 its max HP after two uses, or fully after three uses. Stored energy is consumed, and the user's Defense and Special Defense are reset."
	},
	{
		id = "257",
		name = "Heat Wave",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "100",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to burn the target."
	},
	{
		id = "258",
		name = "Hail",
		type = PokemonData.POKEMON_TYPES.ICE,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Changes the weather to hail for five turns, during which non-ice Pok" ..
			Chars.accentedE .. "mon are damaged for 1/16 their max HP at the end of every turn."
	},
	{
		id = "259",
		name = "Torment",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Prevents the target from attempting to use the same move twice in a row. When the target leaves the field, this effect ends."
	},
	{
		id = "260",
		name = "Flatter",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the target's Special Attack by one stage, then confuses it."
	},
	{
		id = "261",
		name = "Will-O-Wisp",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "75",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Burns the target."
	},
	{
		id = "262",
		name = "Memento",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Lowers the target's Attack and Special Attack by two stages. User faints."
	},
	{
		id = "263",
		name = "Facade",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "70",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. If the user is burned, paralyzed, or poisoned, this move has double power."
	},
	{
		id = "264",
		name = "Focus Punch",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "150",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Decreased priority. Inflicts regular damage and makes contact. If the user takes damage this turn before hitting, this move will fail."
	},
	{
		id = "265",
		name = "SmellingSalt",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "60",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. If the target is paralyzed, this move has double power, and the target is cured of its paralysis."
	},
	{
		id = "266",
		name = "Follow Me",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Increased priority. Until the end of this turn, any moves that opposing Pok" ..
			Chars.accentedE .. "mon target solely at the user's ally will instead target the user."
	},
	{
		id = "267",
		name = "Nature Power",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = {
			"Move depends on the terrain. Building = Tri Attack; Cave/Mountain = Rock Slide; Water = Hydro Pump; Sand/Dirt = Earthquake; Grass = Seed Bomb; Snow = Blizzard; Ice = Ice Beam",
			"Move depends on the terrain. Building = Tri Attack; Cave/Mountain = Rock Slide; Water = Hydro Pump; Sand/Dirt = Earthquake; Grass = Seed Bomb; Snow = Blizzard; Ice = Ice Beam",
			"Move depends on the terrain. Building = Tri Attack; Cave/Mountain = Rock Slide; Water = Hydro Pump; Sand/Dirt = Earthquake; Grass = Seed Bomb; Snow = Blizzard; Ice = Ice Beam",
			"Move depends on the terrain. Building = Tri Attack; Cave/Mountain = Rock Slide; Water = Hydro Pump; Sand/Dirt = Earthquake; Grass = Seed Bomb; Snow = Blizzard; Ice = Ice Beam",
			"Move depends on the terrain. Building = Tri Attack; Cave = Rock Slide; Water = Hydro Pump; Sand/Dirt/Rock = Earthquake; Grass = Seed Bomb; Snow = Blizzard; Ice = Ice Beam; Puddle = Mud Bomb"
		}
	},
	{
		id = "268",
		name = "Charge",
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Special Defense by one stage. If the user uses an electric move next turn, its power will be doubled."
	},
	{
		id = "269",
		name = "Taunt",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = {
			"Target is forced to only use damaging moves for the next 3-5 turns, selected at random. Moves that select other moves not known in advance do not count as damaging.",
			"Target is forced to only use damaging moves for the next 3-5 turns, selected at random. Moves that select other moves not known in advance do not count as damaging.",
			"Target is forced to only use damaging moves for the next 3-5 turns, selected at random. Moves that select other moves not known in advance do not count as damaging.",
			"Target is forced to only use damaging moves for the next 3-5 turns, selected at random. Moves that select other moves not known in advance do not count as damaging.",
			"Target is forced to only use damaging moves for the next 3 turns. Moves that select other moves not known in advance do not count as damaging."
		}
	},
	{
		id = "270",
		name = "Helping Hand",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Increase priority. Boosts the power of the target's moves by 50% until the end of this turn."
	},
	{
		id = "271",
		name = "Trick",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "User and target permanently swap held items. Works even if one of the Pok" ..
			Chars.accentedE .. "mon isn't holding anything."
	},
	{
		id = "272",
		name = "Role Play",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "User's ability is replaced with the target's until the user leaves the field. Ignores Accuracy and Evasion modifiers."
	},
	{
		id = "273",
		name = "Wish",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "At the end of the next turn, user will be healed for half its max HP. If the user is switched out, its replacement will be healed instead for half of the user's max HP."
	},
	{
		id = "274",
		name = "Assist",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Uses a move from another Pok" ..
			Chars.accentedE ..
				"mon in the user's party, both selected at random. Moves from fainted Pok" .. Chars.accentedE .. "mon can be used."
	},
	{
		id = "275",
		name = "Ingrain",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Prevents the user from switching out. User regains 1/16 of its max HP at the end of every turn. If the user was immune to ground attacks, it will now take normal damage from them."
	},
	{
		id = "276",
		name = "Superpower",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "120",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Lowers the user's Attack and Defense by one stage each."
	},
	{
		id = "277",
		name = "Magic Coat",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Increased priority. The first non-damaging move targeting the user this turn that inflicts major status effects, stat changes, or trapping effects will be reflected at its user."
	},
	{
		id = "278",
		name = "Recycle",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = {
			"User recovers the last item consumed by the user or a Pok" ..
				Chars.accentedE ..
					"mon in its position on the field. The item must be used again before it can be recovered by this move again.",
			"User recovers the last item consumed by the user or a Pok" ..
				Chars.accentedE ..
					"mon in its position on the field. The item must be used again before it can be recovered by this move again.",
			"User recovers the last item consumed by the user or a Pok" ..
				Chars.accentedE ..
					"mon in its position on the field. The item must be used again before it can be recovered by this move again.",
			"User recovers the last item consumed by the user or a Pok" ..
				Chars.accentedE ..
					"mon in its position on the field. The item must be used again before it can be recovered by this move again.",
			"User recovers the last item it consumed. The item must be used again before it can be recovered by this move again."
		}
	},
	{
		id = "279",
		name = "Revenge",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "60",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Decreased priority. Inflicts regular damage and makes contact. If the target damaged the user this turn and was the last to do so, this move has double power."
	},
	{
		id = "280",
		name = "Brick Break",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "75",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Makes contact. Destroys any light screen or reflect on the target's side of the field, then inflicts regular damage."
	},
	{
		id = "281",
		name = "Yawn",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Puts the target to sleep at the end of the next turn. Ignores Accuracy and Evasion modifiers. If the target leaves the field, this effect is canceled."
	},
	{
		id = "282",
		name = "Knock Off",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "20",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Target loses its held item."
	},
	{
		id = "283",
		name = "Endeavor",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Makes contact. Inflicts exactly enough damage to lower the target's HP to equal the user's. Type immunity applies, but other type effects are ignored."
	},
	{
		id = "284",
		name = "Eruption",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = ">HP",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Power increases with the user's remaining HP up to a maximum of 150 when the user has full HP."
	},
	{
		id = "285",
		name = "Skill Swap",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "User and target switch abilities. Ignores Accuracy and Evasion modifiers."
	},
	{
		id = "286",
		name = "Imprison",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Prevents any Pok" ..
			Chars.accentedE ..
				"mon on the opposing side of the field from using any move the user knows until the user leaves the field."
	},
	{
		id = "287",
		name = "Refresh",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Removes a burn, paralysis, or poison from the user."
	},
	{
		id = "288",
		name = "Grudge",
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "If the user faints before its next turn, the move that fainted it will have its PP dropped to 0. End-of-turn damage does not trigger this effect."
	},
	{
		id = "289",
		name = "Snatch",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Increased priority. The next time a Pok" ..
			Chars.accentedE ..
				"mon uses a beneficial move on itself or itself and its ally this turn, the user of this move will steal the move and use it itself."
	},
	{
		id = "290",
		name = "Secret Power",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "70",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = {
			"Inflicts regular damage. Has a 30% chance to cause an effect from terrain. Building = paralysis; Desert = -ACC; Cave = flinch; Grass = sleep; Water = -ATK; Snow/Ice = freeze",
			"Inflicts regular damage. Has a 30% chance to cause an effect from terrain. Building = paralysis; Desert = -ACC; Cave = flinch; Grass = sleep; Water = -ATK; Snow/Ice = freeze",
			"Inflicts regular damage. Has a 30% chance to cause an effect from terrain. Building = paralysis; Desert = -ACC; Cave = flinch; Grass = sleep; Water = -ATK; Snow/Ice = freeze",
			"Inflicts regular damage. Has a 30% chance to cause an effect from terrain. Building = paralysis; Desert = -ACC; Cave = flinch; Grass = sleep; Water = -ATK; Snow/Ice = freeze",
			"Inflicts regular damage. Has a 30% chance to cause an effect from terrain. Building = paralysis; Desert = -ACC; Cave = flinch; Grass = sleep; Water = -ATK; Puddle = -SPE; Snow/Ice = freeze"
		}
	},
	{
		id = "291",
		name = "Dive",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = {"60", "60", "60", "80", "80"},
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User dives underwater for one turn, becoming immune to attack, and hits on the second turn."
	},
	{
		id = "292",
		name = "Arm Thrust",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "15",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Hits 2-5 times in one turn, and averages to 3 hits per use."
	},
	{
		id = "293",
		name = "Camouflage",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "User's type changes according to the terrain. Building = normal; Cave = rock; Desert = ground; Grass = grass; Ocean = water; Snow = ice"
	},
	{
		id = "294",
		name = "Tail Glow",
		type = PokemonData.POKEMON_TYPES.BUG,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = {
			"Raises the user's Special Attack by two stages.",
			"Raises the user's Special Attack by two stages.",
			"Raises the user's Special Attack by two stages.",
			"Raises the user's Special Attack by two stages.",
			"Raises the user's Special Attack by three stages."
		}
	},
	{
		id = "295",
		name = "Luster Purge",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "70",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 50% chance to lower the target's Special Defense by one stage."
	},
	{
		id = "296",
		name = "Mist Ball",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "70",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 50% chance to lower the target's Special Attack by one stage."
	},
	{
		id = "297",
		name = "FeatherDance",
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Lowers the target's Attack by two stages."
	},
	{
		id = "298",
		name = "Teeter Dance",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Confuses all targets."
	},
	{
		id = "299",
		name = "Blaze Kick",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "85",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User's critical hit rate is one level higher when using this move. Has a 10% chance to burn the target."
	},
	{
		id = "300",
		name = "Mud Sport",
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = {
			"Electric moves inflict half damage, regardless of target. If the user leaves the field, this effect ends.",
			"Electric moves inflict half damage, regardless of target. If the user leaves the field, this effect ends.",
			"Electric moves inflict half damage, regardless of target. If the user leaves the field, this effect ends.",
			"Electric moves inflict half damage, regardless of target. If the user leaves the field, this effect ends.",
			"Electric moves inflict one-third damage, regardless of target. If the user leaves the field, this effect ends."
		}
	},
	{
		id = "301",
		name = "Ice Ball",
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "30",
		pp = "20",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User is forced to use this move for five turns. Power doubles every time this move is used in succession to a maximum of 16x. If this move misses, the lock-in ends."
	},
	{
		id = "302",
		name = "Needle Arm",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "60",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 30% chance to make the target flinch."
	},
	{
		id = "303",
		name = "Slack Off",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Heals the user for half its max HP."
	},
	{
		id = "304",
		name = "Hyper Voice",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "90",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage."
	},
	{
		id = "305",
		name = "Poison Fang",
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "50",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 30% chance to badly poison the target."
	},
	{
		id = "306",
		name = "Crush Claw",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "75",
		pp = "10",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 50% chance to lower the target's Defense by one stage."
	},
	{
		id = "307",
		name = "Blast Burn",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "150",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. User loses its next turn to recharge, and cannot attack or switch out during that turn."
	},
	{
		id = "308",
		name = "Hydro Cannon",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "150",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. User loses its next turn to recharge, and cannot attack or switch out during that turn."
	},
	{
		id = "309",
		name = "Meteor Mash",
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = "100",
		pp = "10",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 20% chance to raise the user's Attack one stage."
	},
	{
		id = "310",
		name = "Astonish",
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = "30",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 30% chance to make the target flinch."
	},
	{
		id = "311",
		name = "Weather Ball",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "50",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. If a weather move is active, this move has double power, and its type becomes the weather counterpart."
	},
	{
		id = "312",
		name = "Aromatherapy",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Removes major status effects except confusion from every Pok" ..
			Chars.accentedE .. "mon in the user's party."
	},
	{
		id = "313",
		name = "Fake Tears",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Lowers the target's Special Defense by two stages."
	},
	{
		id = "314",
		name = "Air Cutter",
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "55",
		pp = "25",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. User's critical hit rate is one level higher when using this move."
	},
	{
		id = "315",
		name = "Overheat",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "140",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage, then lowers the user's Special Attack by two stages."
	},
	{
		id = "316",
		name = "Odor Sleuth",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = {"100", "100", "100", Graphics.TEXT.ALWAYS_HITS, Graphics.TEXT.ALWAYS_HITS},
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Ignores the target's boosted Evasion stages until the target leaves the field. A ghost under this effect takes damage from normal and fighting moves."
	},
	{
		id = "317",
		name = "Rock Tomb",
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = "50",
		pp = "10",
		accuracy = "80",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. Has a 100% chance to lower the target's Speed by one stage."
	},
	{
		id = "318",
		name = "Silver Wind",
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "60",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to raise all of the user's stats one stage."
	},
	{
		id = "319",
		name = "Metal Sound",
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Lowers the target's Special Defense by two stages."
	},
	{
		id = "320",
		name = "GrassWhistle",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "55",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Puts the target to sleep."
	},
	{
		id = "321",
		name = "Tickle",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Lowers the target's Attack and Defense by one stage."
	},
	{
		id = "322",
		name = "Cosmic Power",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Defense and Special Defense by one stage."
	},
	{
		id = "323",
		name = "Water Spout",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = ">HP",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Power increases with the user's remaining HP, up to a maximum of 150 when the user has full HP."
	},
	{
		id = "324",
		name = "Signal Beam",
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "75",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to confuse the target."
	},
	{
		id = "325",
		name = "Shadow Punch",
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = "60",
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Ignores Accuracy and Evasion modifiers."
	},
	{
		id = "326",
		name = "Extrasensory",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "80",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to make the target flinch."
	},
	{
		id = "327",
		name = "Sky Uppercut",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "85",
		pp = "15",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = {
			"Inflicts regular damage and makes contact. This move can hit Pok" ..
				Chars.accentedE .. "mon under the effect of Bounce or Fly.",
			"Inflicts regular damage and makes contact. This move can hit Pok" ..
				Chars.accentedE .. "mon under the effect of Bounce or Fly.",
			"Inflicts regular damage and makes contact. This move can hit Pok" ..
				Chars.accentedE .. "mon under the effect of Bounce or Fly.",
			"Inflicts regular damage and makes contact. This move can hit Pok" ..
				Chars.accentedE .. "mon under the effect of Bounce or Fly.",
			"Inflicts regular damage and makes contact. This move can hit Pok" ..
				Chars.accentedE .. "mon under the effect of Bounce, Fly, or Sky Drop."
		}
	},
	{
		id = "328",
		name = "Sand Tomb",
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = {"15", "15", "15", "15", "35"},
		pp = "15",
		accuracy = {"70", "70", "70", "70", "85"},
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = {
			"For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"For the next 4-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"For the next 4-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"For the next 4-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"For the next 4-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn."
		}
	},
	{
		id = "329",
		name = "Sheer Cold",
		type = PokemonData.POKEMON_TYPES.ICE,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = "30",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Instantly KOs the target. This move's accuracy is 30% plus 1% for each level the user is higher than the target."
	},
	{
		id = "330",
		name = "Muddy Water",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "95",
		pp = "10",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 30% chance to lower the target's Accuracy by one stage."
	},
	{
		id = "331",
		name = "Bullet Seed",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = {"10", "10", "10", "10", "25"},
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. Hits 2-5 times in one turn, and averages to 3 hits per use."
	},
	{
		id = "332",
		name = "Aerial Ace",
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "60",
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Ignores Accuracy and Evasion modifiers."
	},
	{
		id = "333",
		name = "Icicle Spear",
		type = PokemonData.POKEMON_TYPES.ICE,
		power = {"10", "10", "10", "10", "25"},
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. Hits 2-5 times in one turn, abd averages to 3 hits per use."
	},
	{
		id = "334",
		name = "Iron Defense",
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Defense by two stages."
	},
	{
		id = "335",
		name = "Block",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "The target cannot switch out normally. Ignores Accuracy and Evasion modifiers. This effect ends when the user leaves the field."
	},
	{
		id = "336",
		name = "Howl",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Attack by one stage."
	},
	{
		id = "337",
		name = "Dragon Claw",
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact."
	},
	{
		id = "338",
		name = "Frenzy Plant",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "150",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. User loses its next turn to recharge, and cannot attack or switch out during that turn."
	},
	{
		id = "339",
		name = "Bulk Up",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Attack and Defense by one stage each."
	},
	{
		id = "340",
		name = "Bounce",
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "85",
		pp = "5",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User bounces high into the air for one turn, becoming immune to attack, and hits on the second turn. Has a 30% chance to paralyze the target."
	},
	{
		id = "341",
		name = "Mud Shot",
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = "55",
		pp = "15",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 100% chance to lower the target's Speed by one stage."
	},
	{
		id = "342",
		name = "Poison Tail",
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "50",
		pp = "25",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User's critical hit rate is one level higher when using this move. Has a 10% chance to poison the target."
	},
	{
		id = "343",
		name = "Covet",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = {"40", "40", "40", "40", "60"},
		pp = "40",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. If the target is holding an item and the user is not, the user will permanently take the item. Damage is still inflicted if an item cannot be taken."
	},
	{
		id = "344",
		name = "Volt Tackle",
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "120",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User takes 1/3 the damage it inflicts in recoil. Has a 10% chance to paralyze the target."
	},
	{
		id = "345",
		name = "Magical Leaf",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "60",
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Ignores Accuracy and Evasion modifiers."
	},
	{
		id = "346",
		name = "Water Sport",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = {
			"Fire moves inflict half damage, regardless of target. If the user leaves the field, this effect ends.",
			"Fire moves inflict half damage, regardless of target. If the user leaves the field, this effect ends.",
			"Fire moves inflict half damage, regardless of target. If the user leaves the field, this effect ends.",
			"Fire moves inflict half damage, regardless of target. If the user leaves the field, this effect ends.",
			"Fire moves inflict one-third damage, regardless of target. If the user leaves the field, this effect ends."
		}
	},
	{
		id = "347",
		name = "Calm Mind",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Special Attack and Special Defense by one stage each."
	},
	{
		id = "348",
		name = "Leaf Blade",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = {"70", "70", "70", "90", "90"},
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User's critical hit rate is one level higher when using this move."
	},
	{
		id = "349",
		name = "Dragon Dance",
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Attack and Speed by one stage each."
	},
	{
		id = "350",
		name = "Rock Blast",
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = "25",
		pp = "10",
		accuracy = {"80", "80", "80", "80", "90"},
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. Hits 2-5 times in one turn. Has a 3/8 chance each to hit 2 or 3 times, and a 1/8 chance each to hit 4 or 5 times. Averages to 3 hits per use."
	},
	{
		id = "351",
		name = "Shock Wave",
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "60",
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Ignores Accuracy and Evasion modifiers."
	},
	{
		id = "352",
		name = "Water Pulse",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "60",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 20% chance to confuse the target."
	},
	{
		id = "353",
		name = "Doom Desire",
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = {"120", "120", "120", "120", "140"},
		pp = "5",
		accuracy = {"85", "85", "85", "85", "100"},
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = {
			"Inflicts typeless regular damage at the end of the third turn. This move cannot score a critical hit. Damage is calculated at the time this move is used.",
			"Inflicts typeless regular damage at the end of the third turn. This move cannot score a critical hit. Damage is calculated at the time this move is used.",
			"Inflicts typeless regular damage at the end of the third turn. This move cannot score a critical hit. Damage is calculated at the time this move is used.",
			"Inflicts typeless regular damage at the end of the third turn. This move cannot score a critical hit. Damage is calculated at the time this move is used.",
			"Inflicts regular damage at the end of the third turn. Damage is calculated at the time damage is dealt."
		}
	},
	{
		id = "354",
		name = "Psycho Boost",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "140",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage, then lowers the user's Special Attack by two stages."
	},
	{
		id = "355",
		name = "Roost",
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = Graphics.TEXT.ALWAYS_HITS,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Heals the user for half its max HP. If the user is flying, its flying type is ignored until the end of this turn."
	},
	{
		id = "356",
		name = "Gravity",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = {
			"For five turns, all immunities to ground moves are disabled. For the duration of this effect, the Accuracy of every Pok" ..
				Chars.accentedE .. "mon on the field is multiplied by 5/3. Cancels the effects of Bounce and Fly.",
			"For five turns, all immunities to ground moves are disabled. For the duration of this effect, the Accuracy of every Pok" ..
				Chars.accentedE .. "mon on the field is multiplied by 5/3. Cancels the effects of Bounce and Fly.",
			"For five turns, all immunities to ground moves are disabled. For the duration of this effect, the Accuracy of every Pok" ..
				Chars.accentedE .. "mon on the field is multiplied by 5/3. Cancels the effects of Bounce and Fly.",
			"For five turns, all immunities to ground moves are disabled. For the duration of this effect, the Accuracy of every Pok" ..
				Chars.accentedE .. "mon on the field is multiplied by 5/3. Cancels the effects of Bounce and Fly.",
			"For five turns, all immunities to ground moves are disabled. For the duration of this effect, the Accuracy of every Pok" ..
				Chars.accentedE .. "mon on the field is multiplied by 5/3. Cancels the effects of Bounce, Fly, and Sky Drop."
		}
	},
	{
		id = "357",
		name = "Miracle Eye",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "40",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Ignores the target's boosted Evasion stages until the target leaves the field. A dark Pok" ..
			Chars.accentedE .. "mon under this effect takes normal damage from psychic moves."
	},
	{
		id = "358",
		name = "Wake-Up Slap",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "60",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. If the target is sleeping, this move has double power, and the target wakes up."
	},
	{
		id = "359",
		name = "Hammer Arm",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "100",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Lowers the user's Speed by one stage."
	},
	{
		id = "360",
		name = "Gyro Ball",
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = "<SP",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Power increases with the target's current Speed compared to the user, capped at 150."
	},
	{
		id = "361",
		name = "Healing Wish",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "User faints. Its replacement's HP is fully restored, and any major status effect is removed. If the replacement Pok" ..
			Chars.accentedE ..
				"mon is immediately fainted by a switch-in effect, the next replacement is healed by this move instead."
	},
	{
		id = "362",
		name = "Brine",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "65",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. If the target has less than half its max HP remaining, this move has double power."
	},
	{
		id = "363",
		name = "Natural Gift",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "BRY",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. Power and type are determined by the user's held berry. The berry is consumed. If the user is not holding a berry, this move will fail."
	},
	{
		id = "364",
		name = "Feint",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = {"50", "50", "50", "50", "30"},
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = {
			"Increased priority. Inflicts regular damage. Removes the effects of Detect or Protect from the target before hitting. Fails if the target did not use Detect or Protect.",
			"Increased priority. Inflicts regular damage. Removes the effects of Detect or Protect from the target before hitting. Fails if the target did not use Detect or Protect.",
			"Increased priority. Inflicts regular damage. Removes the effects of Detect or Protect from the target before hitting. Fails if the target did not use Detect or Protect.",
			"Increased priority. Inflicts regular damage. Removes the effects of Detect or Protect from the target before hitting. Fails if the target did not use Detect or Protect.",
			"Increased priority. Inflicts regular damage. Removes the effects of Detect or Protect from the target before hitting."
		}
	},
	{
		id = "365",
		name = "Pluck",
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "60",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. If the target is holding a berry, the user takes the berry and uses it immediately."
	},
	{
		id = "366",
		name = "Tailwind",
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = {
			"For the next three turns, all Pok" ..
				Chars.accentedE ..
					"mon on the user's side of the field have their original Speed doubled. This effect remains if the user leaves the field.",
			"For the next three turns, all Pok" ..
				Chars.accentedE ..
					"mon on the user's side of the field have their original Speed doubled. This effect remains if the user leaves the field.",
			"For the next three turns, all Pok" ..
				Chars.accentedE ..
					"mon on the user's side of the field have their original Speed doubled. This effect remains if the user leaves the field.",
			"For the next three turns, all Pok" ..
				Chars.accentedE ..
					"mon on the user's side of the field have their original Speed doubled. This effect remains if the user leaves the field.",
			"For the next four turns, all Pok" ..
				Chars.accentedE ..
					"mon on the user's side of the field have their original Speed doubled. This effect remains if the user leaves the field."
		}
	},
	{
		id = "367",
		name = "Acupressure",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises one of the target's stats by two stages. The raised stat is chosen at random from any stats that can be raised."
	},
	{
		id = "368",
		name = "Metal Burst",
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Targets the last opposing Pok" ..
			Chars.accentedE ..
				"mon to hit the user with a damaging move this turn. Inflicts 1.5x the damage that move did to the user. Type immunity applies, but other type effects are ignored."
	},
	{
		id = "369",
		name = "U-turn",
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "70",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User immediately switches out, and the trainer selects a replacement Pok" ..
			Chars.accentedE .. "mon from the party."
	},
	{
		id = "370",
		name = "Close Combat",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "120",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Lowers the user's Defense and Special Defense by one stage each."
	},
	{
		id = "371",
		name = "Payback",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "50",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. If the target uses a move, switches out, or the trainer uses an item this turn before this move is used, this move has double power."
	},
	{
		id = "372",
		name = "Assurance",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "50",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. If the target takes damage this turn for any reason before this move is used, this move has double power."
	},
	{
		id = "373",
		name = "Embargo",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Target cannot use its held item and its trainer cannot use items from the bag on it for five turns. If the target leaves the field, this effect ends."
	},
	{
		id = "374",
		name = "Fling",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "ITM",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. Power is determined by the user's held item. The item is consumed. If the user is not holding an item, or its item has no set power, this move will fail."
	},
	{
		id = "375",
		name = "Psycho Shift",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "If the user has a major status effect and the target does not, the user's status is transferred to the target."
	},
	{
		id = "376",
		name = "Trump Card",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "<PP",
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage and makes contact. Power is determined by the PP remaining for this move, after its PP cost is deducted. Ignores Accuracy and Evasion modifiers."
	},
	{
		id = "377",
		name = "Heal Block",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = {
			"For the next five turns, the target may not use any moves that only restore HP. Moves that steal HP may still be used, but will only inflict damage and not heal the target.",
			"For the next five turns, the target may not use any moves that only restore HP. Moves that steal HP may still be used, but will only inflict damage and not heal the target.",
			"For the next five turns, the target may not use any moves that only restore HP. Moves that steal HP may still be used, but will only inflict damage and not heal the target.",
			"For the next five turns, the target may not use any moves that only restore HP. Moves that steal HP may still be used, but will only inflict damage and not heal the target.",
			"For the next five turns, the target may not use any moves that only restore HP. Moves that steal HP may still be used, but will only inflict damage and not heal the target. The target will also not be healed by held items or abilities."
		}
	},
	{
		id = "378",
		name = "Wring Out",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = ">HP",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage and makes contact. Power directly relates to the target's relative remaining HP, up to a maximum of 121."
	},
	{
		id = "379",
		name = "Power Trick",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "The user's original Attack and Defense are swapped."
	},
	{
		id = "380",
		name = "Gastro Acid",
		type = PokemonData.POKEMON_TYPES.POISON,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "The target's ability is disabled as long as it remains on the field."
	},
	{
		id = "381",
		name = "Lucky Chant",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "For five turns, opposing Pok" .. Chars.accentedE .. "mon cannot score critical hits."
	},
	{
		id = "382",
		name = "Me First",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "If the target has selected a damaging move this turn, the user will copy that move and use it against the target, with a 50% increase in power."
	},
	{
		id = "383",
		name = "Copycat",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Uses the last move that was used successfully by any Pok" .. Chars.accentedE .. "mon, including the user."
	},
	{
		id = "384",
		name = "Power Swap",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "User swaps its Attack and Special Attack stat modifiers with the target."
	},
	{
		id = "385",
		name = "Guard Swap",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "User swaps its Defense and Special Defense stat modifiers with the target."
	},
	{
		id = "386",
		name = "Punishment",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "STA",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Power starts at 60 and is increased by 20 for every stage any of the target's stats has been raised, capping at 200. Accuracy and Evasion modifiers do not increase this move's power."
	},
	{
		id = "387",
		name = "Last Resort",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = {"130", "130", "130", "130", "140"},
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. This move can only be used if each of the user's other moves has been used at least once since the user entered the field. If this is the user's only move, this move will fail."
	},
	{
		id = "388",
		name = "Worry Seed",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Changes the target's ability to Insomnia for as long as it remains on the field."
	},
	{
		id = "389",
		name = "Sucker Punch",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "80",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Increased priority. Inflicts regular damage and makes contact. If the target has not selected a damaging move this turn, or if the target has already acted this turn, this move will fail."
	},
	{
		id = "390",
		name = "Toxic Spikes",
		type = PokemonData.POKEMON_TYPES.POISON,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Scatters poisoned spikes around the opposing field, which poison opposing Pok" ..
			Chars.accentedE ..
				"mon that enter the field. A second layer of these spikes may be laid down, in which case Pok" ..
					Chars.accentedE .. "mon will be badly poisoned instead."
	},
	{
		id = "391",
		name = "Heart Swap",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "User swaps its stat modifiers with the target."
	},
	{
		id = "392",
		name = "Aqua Ring",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Restores 1/16 of the user's max HP at the end of each turn. If the user leaves the field, this effect ends."
	},
	{
		id = "393",
		name = "Magnet Rise",
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "For five turns, the user is immune to ground moves."
	},
	{
		id = "394",
		name = "Flare Blitz",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "120",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User takes 1/3 the damage it inflicts in recoil. Has a 10% chance to burn the target. Frozen Pok" ..
			Chars.accentedE .. "mon will thaw if they use this move."
	},
	{
		id = "395",
		name = "Force Palm",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "60",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 30% chance to paralyze the target."
	},
	{
		id = "396",
		name = "Aura Sphere",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "90",
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Ignores Accuracy and Evasion modifiers."
	},
	{
		id = "397",
		name = "Rock Polish",
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Speed by two stages."
	},
	{
		id = "398",
		name = "Poison Jab",
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "80",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 30% chance to poison the target."
	},
	{
		id = "399",
		name = "Dark Pulse",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 20% chance to make the target flinch."
	},
	{
		id = "400",
		name = "Night Slash",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "70",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User's critical hit rate is one level higher when using this move."
	},
	{
		id = "401",
		name = "Aqua Tail",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "90",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact."
	},
	{
		id = "402",
		name = "Seed Bomb",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage."
	},
	{
		id = "403",
		name = "Air Slash",
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "75",
		pp = "20",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 30% chance to make the target flinch."
	},
	{
		id = "404",
		name = "X-Scissor",
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact."
	},
	{
		id = "405",
		name = "Bug Buzz",
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "90",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to lower the target's Special Defense by one stage."
	},
	{
		id = "406",
		name = "Dragon Pulse",
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = "90",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage."
	},
	{
		id = "407",
		name = "Dragon Rush",
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = "100",
		pp = "10",
		accuracy = "75",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 20% chance to make the target flinch."
	},
	{
		id = "408",
		name = "Power Gem",
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = "70",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage."
	},
	{
		id = "409",
		name = "Drain Punch",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = {"60", "60", "60", "60", "75"},
		pp = {"5", "5", "5", "5", "10"},
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Drains half the damage inflicted to heal the user."
	},
	{
		id = "410",
		name = "Vacuum Wave",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "40",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Increased priority. Inflicts regular damage."
	},
	{
		id = "411",
		name = "Focus Blast",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "120",
		pp = "5",
		accuracy = "70",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to lower the target's Special Defense by one stage."
	},
	{
		id = "412",
		name = "Energy Ball",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "80",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to lower the target's Special Defense by one stage."
	},
	{
		id = "413",
		name = "Brave Bird",
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "120",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User takes 1/3 the damage it inflicts in recoil."
	},
	{
		id = "414",
		name = "Earth Power",
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = "90",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to lower the target's Special Defense by one stage."
	},
	{
		id = "415",
		name = "Switcheroo",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "User and target permanently swap held items. Works even if one of the Pok" ..
			Chars.accentedE .. "mon isn't holding anything."
	},
	{
		id = "416",
		name = "Giga Impact",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "150",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User loses its next turn to recharge, and cannot attack or switch out during that turn."
	},
	{
		id = "417",
		name = "Nasty Plot",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Special Attack by two stages."
	},
	{
		id = "418",
		name = "Bullet Punch",
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = "40",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Increased priority. Inflicts regular damage and makes contact."
	},
	{
		id = "419",
		name = "Avalanche",
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "60",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Decreased priority. Inflicts regular damage and makes contact. If the target damaged the user this turn, this move has double power."
	},
	{
		id = "420",
		name = "Ice Shard",
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "40",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Increased priority. Inflicts regular damage."
	},
	{
		id = "421",
		name = "Shadow Claw",
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = "70",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User's critical hit rate is one level higher when using this move."
	},
	{
		id = "422",
		name = "Thunder Fang",
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "65",
		pp = "15",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 10% chance to paralyze the target and a separate 10% chance to make the target flinch."
	},
	{
		id = "423",
		name = "Ice Fang",
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "65",
		pp = "15",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 10% chance to freeze the target and a separate 10% chance to make the target flinch."
	},
	{
		id = "424",
		name = "Fire Fang",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "65",
		pp = "15",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 10% chance to burn the target and a separate 10% chance to make the target flinch."
	},
	{
		id = "425",
		name = "Shadow Sneak",
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = "40",
		pp = "30",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Increased priority. Inflicts regular damage and makes contact."
	},
	{
		id = "426",
		name = "Mud Bomb",
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = "65",
		pp = "10",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 30% chance to lower the target's Accuracy by one stage."
	},
	{
		id = "427",
		name = "Psycho Cut",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "70",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. User's critical hit rate is one level higher when using this move."
	},
	{
		id = "428",
		name = "Zen Headbutt",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "80",
		pp = "15",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 20% chance to make the target flinch."
	},
	{
		id = "429",
		name = "Mirror Shot",
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = "65",
		pp = "10",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 30% chance to lower the target's Accuracy by one stage."
	},
	{
		id = "430",
		name = "Flash Cannon",
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = "80",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to lower the target's Special Defense by one stage."
	},
	{
		id = "431",
		name = "Rock Climb",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "90",
		pp = "20",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 20% chance to confuse the target."
	},
	{
		id = "432",
		name = "Defog",
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Lowers the target's Evasion by one stage. Removes the effects of mist, light screen, reflect, safeguard, spikes, stealth rock, and toxic spikes from the target's side of the field."
	},
	{
		id = "433",
		name = "Trick Room",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "5",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Decreased priority. For five turns, slower Pok" ..
			Chars.accentedE .. "mon will act before faster Pok" .. Chars.accentedE .. "mon. Move priority is not affected."
	},
	{
		id = "434",
		name = "Draco Meteor",
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = "140",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage, then lowers the user's Special Attack by two stages."
	},
	{
		id = "435",
		name = "Discharge",
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 30% chance to paralyze the target."
	},
	{
		id = "436",
		name = "Lava Plume",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 30% chance to burn the target."
	},
	{
		id = "437",
		name = "Leaf Storm",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "140",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage, then lowers the user's Special Attack by two stages."
	},
	{
		id = "438",
		name = "Power Whip",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "120",
		pp = "10",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact."
	},
	{
		id = "439",
		name = "Rock Wrecker",
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = "150",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. User loses its next turn to recharge, and cannot attack or switch out during that turn."
	},
	{
		id = "440",
		name = "Cross Poison",
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "70",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User's critical hit rate is one level higher when using this move. Has a 10% chance to poison the target."
	},
	{
		id = "441",
		name = "Gunk Shot",
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "120",
		pp = "5",
		accuracy = "70",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. Has a 30% chance to poison the target."
	},
	{
		id = "442",
		name = "Iron Head",
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 30% chance to make the target flinch."
	},
	{
		id = "443",
		name = "Magnet Bomb",
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = "60",
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. Ignores Accuracy and Evasion modifiers."
	},
	{
		id = "444",
		name = "Stone Edge",
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = "100",
		pp = "5",
		accuracy = "80",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. User's critical hit rate is one level higher when using this move."
	},
	{
		id = "445",
		name = "Captivate",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Lowers the target's Special Attack by two stages. If the user and target are the same gender, or either is genderless, this move will fail."
	},
	{
		id = "446",
		name = "Stealth Rock",
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Spreads sharp rocks around the opposing field, damaging any Pok" ..
			Chars.accentedE ..
				"mon that enters the field for 1/8 its max HP. This damage is affected by the entering Pok" ..
					Chars.accentedE .. "mon's susceptibility to rock moves."
	},
	{
		id = "447",
		name = "Grass Knot",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "WT",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage and makes contact. Power increases with the target's weight in kilograms, to a maximum of 120."
	},
	{
		id = "448",
		name = "Chatter",
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "60",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = {
			"Inflicts regular damage. Has either a 1%, 11%, or 31% chance to confuse the target, based on the volume of the recording made for this move.",
			"Inflicts regular damage. Has either a 1%, 11%, or 31% chance to confuse the target, based on the volume of the recording made for this move.",
			"Inflicts regular damage. Has either a 1%, 11%, or 31% chance to confuse the target, based on the volume of the recording made for this move.",
			"Inflicts regular damage. Has either a 1%, 11%, or 31% chance to confuse the target, based on the volume of the recording made for this move.",
			"Inflicts regular damage. Has either a 0% or 10% chance to confuse the target, based on the volume of the recording made for this move."
		}
	},
	{
		id = "449",
		name = "Judgment",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "100",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. If the user is holding a plate, this move's type is the type corresponding to that item."
	},
	{
		id = "450",
		name = "Bug Bite",
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "60",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. If the target is holding a berry, the user takes the berry and uses it immediately."
	},
	{
		id = "451",
		name = "Charge Beam",
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "50",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 70% chance to raise the user's Special Attack by one stage."
	},
	{
		id = "452",
		name = "Wood Hammer",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "120",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User takes 1/3 the damage it inflicts in recoil."
	},
	{
		id = "453",
		name = "Aqua Jet",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "40",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Increased priority. Inflicts regular damage and makes contact."
	},
	{
		id = "454",
		name = "Attack Order",
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "90",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. User's critical hit rate is one level higher when using this move."
	},
	{
		id = "455",
		name = "Defend Order",
		type = PokemonData.POKEMON_TYPES.BUG,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Defense and Special Defense by one stage."
	},
	{
		id = "456",
		name = "Heal Order",
		type = PokemonData.POKEMON_TYPES.BUG,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Heals the user for half its max HP."
	},
	{
		id = "457",
		name = "Head Smash",
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = "150",
		pp = "5",
		accuracy = "80",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User takes 1/2 the damage it inflicts in recoil."
	},
	{
		id = "458",
		name = "Double Hit",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "35",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Hits twice in one turn."
	},
	{
		id = "459",
		name = "Roar of Time",
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = "150",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. User loses its next turn to recharge, and cannot attack or switch out during that turn."
	},
	{
		id = "460",
		name = "Spacial Rend",
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = "100",
		pp = "5",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. User's critical hit rate is one level higher when using this move."
	},
	{
		id = "461",
		name = "Lunar Dance",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "User faints. Its replacement's HP and PP are fully restored, and any major status effect is removed."
	},
	{
		id = "462",
		name = "Crush Grip",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = ">HP",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Power directly relates to the target's relative remaining HP, up to a maximum of 121."
	},
	{
		id = "463",
		name = "Magma Storm",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "120",
		pp = "5",
		accuracy = {"70", "70", "70", "70", "75"},
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = {
			"Inflicts regular damage. For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"Inflicts regular damage. For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"Inflicts regular damage. For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"Inflicts regular damage. For the next 2-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn.",
			"Inflicts regular damage. For the next 4-5 turns, the target cannot leave the field and is damaged for 1/16 its max HP at the end of each turn."
		}
	},
	{
		id = "464",
		name = "Dark Void",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = "80",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Puts all adjacent foes to sleep."
	},
	{
		id = "465",
		name = "Seed Flare",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "120",
		pp = "5",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 40% chance to lower the target's Special Defense by two stages."
	},
	{
		id = "466",
		name = "Ominous Wind",
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = "60",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to raise all of the user's stats one stage."
	},
	{
		id = "467",
		name = "Shadow Force",
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = "120",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User vanishes for one turn, becoming immune to attack, and hits on the second turn. Hits the target through Protect and Detect, and removes their effects."
	},
	{
		id = "468",
		name = "Hone Claws",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Attack and Accuracy by one stage."
	},
	{
		id = "469",
		name = "Wide Guard",
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Increased priority. Moves with multiple targets will not hit friendly Pok" ..
			Chars.accentedE .. "mon for the remainder of this turn. If the user is last to act this turn, this move will fail."
	},
	{
		id = "470",
		name = "Guard Split",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Averages the user's unmodified Defense with the target's unmodified Defense; the value becomes the unmodified Defense for both Pok" ..
			Chars.accentedE .. "mon. Unmodified Special Defense is averaged the same way."
	},
	{
		id = "471",
		name = "Power Split",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Averages the user's unmodified Attack with the target's unmodified Attack; the value becomes the unmodified Attack for both Pok" ..
			Chars.accentedE .. "mon. Unmodified Special Attack is averaged the same way."
	},
	{
		id = "472",
		name = "Wonder Room",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Decreased priority. For five turns, every Pok" ..
			Chars.accentedE .. "mon's Defense and Special Defense are swapped."
	},
	{
		id = "473",
		name = "Psyshock",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "80",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Damage calculation always uses the target's Defense, regardless of this move's damage class."
	},
	{
		id = "474",
		name = "Venoshock",
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "65",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. If the target is poisoned, this move has double power."
	},
	{
		id = "475",
		name = "Autotomize",
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Speed by two stages. If successful, reduces the user's weight by 100 kg (minimum 0.1 kg)."
	},
	{
		id = "476",
		name = "Rage Powder",
		type = PokemonData.POKEMON_TYPES.BUG,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Increased priority. Until the end of this turn, any moves that opposing Pok" ..
			Chars.accentedE .. "mon target solely at the user's ally will instead target the user."
	},
	{
		id = "477",
		name = "Telekinesis",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "For three turns, moves used against the target have perfect accuracy, but the target is immune to ground damage. Accuracy of one-hit KO moves is exempt from this effect."
	},
	{
		id = "478",
		name = "Magic Room",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Decreased priority. For five turns, passive effects of held items are ignored, and Pok" ..
			Chars.accentedE .. "mon will not use their held items."
	},
	{
		id = "479",
		name = "Smack Down",
		type = PokemonData.POKEMON_TYPES.ROCK,
		power = "50",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. Removes the target's immunity to ground-type damage. This move will hit targets under the effect of Bounce, Fly, or Sky Drop."
	},
	{
		id = "480",
		name = "Storm Throw",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = {"60", "60", "60", "60", "40"},
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Always scores a critical hit."
	},
	{
		id = "481",
		name = "Flame Burst",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "70",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. If this move successfully hits the target, any Pok" ..
			Chars.accentedE .. "mon adjacent to the target are damaged for 1/16 their max HP."
	},
	{
		id = "482",
		name = "Sludge Wave",
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "95",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage and hits all adjacent Pok" ..
			Chars.accentedE .. "mon. Has 10% chance to poison each target."
	},
	{
		id = "483",
		name = "Quiver Dance",
		type = PokemonData.POKEMON_TYPES.BUG,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Special Attack, Special Defense, and Speed by one stage each."
	},
	{
		id = "484",
		name = "Heavy Slam",
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = ">WT",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. The greater the user's weight compared to the target's, the higher power this move has, to a maximum of 120."
	},
	{
		id = "485",
		name = "Synchronoise",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = {"120", "120", "120", "120", "70"},
		pp = {"10", "10", "10", "10", "15"},
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Only Pok" ..
			Chars.accentedE .. "mon that share a type with the user will take damage from this move."
	},
	{
		id = "486",
		name = "Electro Ball",
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = ">SP",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. The greater the user's Speed compared to the target's, the higher power this move has, to a maximum of 150."
	},
	{
		id = "487",
		name = "Soak",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Changes the target to pure water-type until it leaves the field. If the target has multitype, this move will fail."
	},
	{
		id = "488",
		name = "Flame Charge",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "50",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Raises the user's Speed by one stage."
	},
	{
		id = "489",
		name = "Coil",
		type = PokemonData.POKEMON_TYPES.POISON,
		power = Graphics.TEXT.NO_POWER,
		pp = "20",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Attack, Defense, and Accuracy by one stage each."
	},
	{
		id = "490",
		name = "Low Sweep",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = {"65", "65", "65", "65", "60"},
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Lowers the target's Speed by one stage."
	},
	{
		id = "491",
		name = "Acid Spray",
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "40",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Lowers the target's Special Defense by two stages."
	},
	{
		id = "492",
		name = "Foul Play",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "95",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Damage is calculated using the target's attacking stat rather than the user's."
	},
	{
		id = "493",
		name = "Simple Beam",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Changes the target's ability to Simple. This effect ends when the target leaves battle."
	},
	{
		id = "494",
		name = "Entrainment",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Changes the target's ability to match the user's. This effect ends when the target leaves battle."
	},
	{
		id = "495",
		name = "After You",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "The target will act next this turn, regardless of Speed or move priority."
	},
	{
		id = "496",
		name = "Round",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "60",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. If round has already been used this turn, this move's power is doubled."
	},
	{
		id = "497",
		name = "Echoed Voice",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "40",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Power increases by 40 for each subsequent use, up to a maximum of 200 damage."
	},
	{
		id = "498",
		name = "Chip Away",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "70",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Damage calculation ignores the target's stat modifiers, including Evasion."
	},
	{
		id = "499",
		name = "Clear Smog",
		type = PokemonData.POKEMON_TYPES.POISON,
		power = "50",
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. All of the target's stat modifiers are reset to zero."
	},
	{
		id = "500",
		name = "Stored Power",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "20",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Power increases by 20 for every stage any of the user's stats have been raised."
	},
	{
		id = "501",
		name = "Quick Guard",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Increased priority. Moves with priority greater than 0 will not hit friendly Pok" ..
			Chars.accentedE .. "mon for the remainder of this turn. If the user is last to act this turn, this move will fail."
	},
	{
		id = "502",
		name = "Ally Switch",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Increased priority. User switches position on the field with the friendly Pok" ..
			Chars.accentedE ..
				"mon opposite it. If the user is in the middle position in a triple battle, or there are no other friendly Pok" ..
					Chars.accentedE .. "mon, this move will fail."
	},
	{
		id = "503",
		name = "Scald",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "80",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 30% chance to burn the target."
	},
	{
		id = "504",
		name = "Shell Smash",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Attack, Special Attack, and Speed by two stages each. Lowers the user's Defense and Special Defense by one stage each."
	},
	{
		id = "505",
		name = "Heal Pulse",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Heals the target for half its max HP."
	},
	{
		id = "506",
		name = "Hex",
		type = PokemonData.POKEMON_TYPES.GHOST,
		power = {"65", "65", "65", "65", "50"},
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. If the target has a major status ailment, this move has double power."
	},
	{
		id = "507",
		name = "Sky Drop",
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "60",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User carries the target high into the air for one turn, and on the following turn, the user drops the target to inflict damage. Ineffective on flying types."
	},
	{
		id = "508",
		name = "Shift Gear",
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Attack by one stage and its Speed by two stages."
	},
	{
		id = "509",
		name = "Circle Throw",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "60",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Decreased priority. Inflicts regular damage and makes contact. Switches the target out for another of its trainer's Pok" ..
			Chars.accentedE .. "mon, selected at random."
	},
	{
		id = "510",
		name = "Incinerate",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = {"60", "60", "60", "60", "30"},
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. If the target is holding a berry, it's destroyed and cannot be used in response to this move."
	},
	{
		id = "511",
		name = "Quash",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Forces the target to act last this turn, regardless of Speed or move priority. If the target has already acted this turn, this move will fail."
	},
	{
		id = "512",
		name = "Acrobatics",
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "55",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. If the user has no held item, this move has double power."
	},
	{
		id = "513",
		name = "Reflect Type",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "User's type changes to match the target's."
	},
	{
		id = "514",
		name = "Retaliate",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "70",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. If a friendly Pok" ..
			Chars.accentedE .. "mon fainted on the previous turn, this move has double power."
	},
	{
		id = "515",
		name = "Final Gambit",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "HP",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts damage equal to the user's remaining HP. User faints."
	},
	{
		id = "516",
		name = "Bestow",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "15",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Transfers the user's held item to the target. If the user has no held item, or the target already has a held item, this move will fail."
	},
	{
		id = "517",
		name = "Inferno",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "100",
		pp = "5",
		accuracy = "50",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 100% chance to burn the target."
	},
	{
		id = "518",
		name = "Water Pledge",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = {"80", "80", "80", "80", "50"},
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. If a friendly Pok" ..
			Chars.accentedE ..
				"mon used grass pledge earlier this turn, all opposing Pok" .. Chars.accentedE .. "mon have halved Speed for four turns."
	},
	{
		id = "519",
		name = "Fire Pledge",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = {"80", "80", "80", "80", "50"},
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. If a friendly Pok" ..
			Chars.accentedE ..
				"mon used water pledge earlier this turn, moves used by any friendly Pok" ..
					Chars.accentedE .. "mon have doubled effect chance for four turns."
	},
	{
		id = "520",
		name = "Grass Pledge",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = {"80", "80", "80", "80", "50"},
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. If a friendly Pok" ..
			Chars.accentedE ..
				"mon used fire pledge earlier this turn, all opposing Pok" ..
					Chars.accentedE .. "mon will take 1/8 their max HP in damage at the end of every turn for four turns."
	},
	{
		id = "521",
		name = "Volt Switch",
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "70",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage, then the user immediately switches out, and the trainer selects a replacement Pok" ..
			Chars.accentedE .. "mon from the party."
	},
	{
		id = "522",
		name = "Struggle Bug",
		type = PokemonData.POKEMON_TYPES.BUG,
		power = {"50", "50", "50", "50", "30"},
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 100% chance to lower the target's Special Attack by one stage."
	},
	{
		id = "523",
		name = "Bulldoze",
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = "60",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. Has a 100% chance to lower the target's Speed by one stage."
	},
	{
		id = "524",
		name = "Frost Breath",
		type = PokemonData.POKEMON_TYPES.ICE,
		power = {"60", "60", "60", "60", "40"},
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Always scores a critical hit."
	},
	{
		id = "525",
		name = "Dragon Tail",
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = "60",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Decreased priority. Inflicts regular damage and makes contact. Switches the target out for another of its trainer's Pok" ..
			Chars.accentedE .. "mon, selected at random."
	},
	{
		id = "526",
		name = "Work Up",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = Graphics.TEXT.NO_POWER,
		pp = "30",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Attack and Special Attack by one stage each."
	},
	{
		id = "527",
		name = "Electroweb",
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "55",
		pp = "15",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Lowers the target's Speed by one stage."
	},
	{
		id = "528",
		name = "Wild Charge",
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "90",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User takes 1/4 the damage it inflicts in recoil."
	},
	{
		id = "529",
		name = "Drill Run",
		type = PokemonData.POKEMON_TYPES.GROUND,
		power = "80",
		pp = "10",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User's critical hit rate is one level higher when using this move."
	},
	{
		id = "530",
		name = "Dual Chop",
		type = PokemonData.POKEMON_TYPES.DRAGON,
		power = "40",
		pp = "15",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Hits twice in one turn."
	},
	{
		id = "531",
		name = "Heart Stamp",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "60",
		pp = "25",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 30% chance to make the target flinch."
	},
	{
		id = "532",
		name = "Horn Leech",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "75",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Drains half the damage inflicted to heal the user."
	},
	{
		id = "533",
		name = "Sacred Sword",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "90",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Damage calculation ignores the target's stat modifiers, including Evasion."
	},
	{
		id = "534",
		name = "Razor Shell",
		type = PokemonData.POKEMON_TYPES.WATER,
		power = "75",
		pp = "10",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 50% chance to lower the target's Defense by one stage."
	},
	{
		id = "535",
		name = "Heat Crash",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = ">WT",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. The greater the user's weight compared to the target's, the higher power this move has, to a maximum of 120."
	},
	{
		id = "536",
		name = "Leaf Tornado",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = "65",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 50% chance to lower the target's Accuracy by one stage."
	},
	{
		id = "537",
		name = "Steamroller",
		type = PokemonData.POKEMON_TYPES.BUG,
		power = "65",
		pp = "20",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 30% chance to make the target flinch."
	},
	{
		id = "538",
		name = "Cotton Guard",
		type = PokemonData.POKEMON_TYPES.GRASS,
		power = Graphics.TEXT.NO_POWER,
		pp = "10",
		accuracy = Graphics.TEXT.ALWAYS_HITS,
		category = MoveData.MOVE_CATEGORIES.STATUS,
		description = "Raises the user's Defense by three stages."
	},
	{
		id = "539",
		name = "Night Daze",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "85",
		pp = "10",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 40% chance to lower the target's Accuracy by one stage."
	},
	{
		id = "540",
		name = "Psystrike",
		type = PokemonData.POKEMON_TYPES.PSYCHIC,
		power = "100",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Damage calculation always uses the target's Defense, regardless of this move's damage class."
	},
	{
		id = "541",
		name = "Tail Slap",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "25",
		pp = "10",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Hits 2-5 times in one turn, and averages to 3 hits per use."
	},
	{
		id = "542",
		name = "Hurricane",
		type = PokemonData.POKEMON_TYPES.FLYING,
		power = "120",
		pp = "10",
		accuracy = "70",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 30% chance to confuse the target. Has perfect accuracy in the rain, but only 50% accuracy in harsh sunlight."
	},
	{
		id = "543",
		name = "Head Charge",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "120",
		pp = "15",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. User takes 1/4 the damage it inflicts in recoil."
	},
	{
		id = "544",
		name = "Gear Grind",
		type = PokemonData.POKEMON_TYPES.STEEL,
		power = "50",
		pp = "15",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Hits twice in one turn."
	},
	{
		id = "545",
		name = "Searing Shot",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "100",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 30% chance to burn the target."
	},
	{
		id = "546",
		name = "Techno Blast",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "85",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. If the user is holding a drive, this move's type is the type corresponding to that item."
	},
	{
		id = "547",
		name = "Relic Song",
		type = PokemonData.POKEMON_TYPES.NORMAL,
		power = "75",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 10% chance to put the target to sleep."
	},
	{
		id = "548",
		name = "Secret Sword",
		type = PokemonData.POKEMON_TYPES.FIGHTING,
		power = "85",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Damage calculation uses the target's Defense."
	},
	{
		id = "549",
		name = "Glaciate",
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "65",
		pp = "10",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Lowers the target's Speed by one stage."
	},
	{
		id = "550",
		name = "Bolt Strike",
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "130",
		pp = "5",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Has a 20% chance to paralyze the target."
	},
	{
		id = "551",
		name = "Blue Flare",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "130",
		pp = "5",
		accuracy = "85",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 20% chance to burn the target."
	},
	{
		id = "552",
		name = "Fiery Dance",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "80",
		pp = "10",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 50% chance to raise the user's Special Attack by one stage."
	},
	{
		id = "553",
		name = "Freeze Shock",
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "140",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. Has a 30% chance to paralyze the target. User charges for one turn before attacking."
	},
	{
		id = "554",
		name = "Ice Burn",
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "140",
		pp = "5",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 30% chance to burn the target. User charges for one turn before attacking."
	},
	{
		id = "555",
		name = "Snarl",
		type = PokemonData.POKEMON_TYPES.DARK,
		power = "55",
		pp = "15",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. Has a 100% chance to lower the target's Special Attack by one stage."
	},
	{
		id = "556",
		name = "Icicle Crash",
		type = PokemonData.POKEMON_TYPES.ICE,
		power = "85",
		pp = "10",
		accuracy = "90",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. Has a 30% chance to make the target flinch."
	},
	{
		id = "557",
		name = "V-create",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "180",
		pp = "5",
		accuracy = "95",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage and makes contact. Lowers the user's Defense, Special Defense, and Speed by one stage each."
	},
	{
		id = "558",
		name = "Fusion Flare",
		type = PokemonData.POKEMON_TYPES.FIRE,
		power = "100",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.SPECIAL,
		description = "Inflicts regular damage. If any Pok" ..
			Chars.accentedE .. "mon used Fusion Bolt earlier this turn, this move has double power."
	},
	{
		id = "559",
		name = "Fusion Bolt",
		type = PokemonData.POKEMON_TYPES.ELECTRIC,
		power = "100",
		pp = "5",
		accuracy = "100",
		category = MoveData.MOVE_CATEGORIES.PHYSICAL,
		description = "Inflicts regular damage. If any Pok" ..
			Chars.accentedE .. "mon used Fusion Flare earlier this turn, this move has double power."
	}
}

MoveData.TOTAL_MOVES = #MoveData.MOVES_MASTER_LIST

MiscConstants = {}

MiscConstants.TRACKER_VERSION = "5.1.4"

MiscConstants.BIZHAWK_VERSION = client.getversion()

MiscConstants.UPDATE_NOTES = {
    "-- 5.1.4: Added new bookmark icon on the enemy screen. This allows you to mark a Pok" ..
        Chars.accentedE ..
            "mon for log viewing. Then, when in the log viewer, you can now press a button to show only marked Pok" ..
                Chars.accentedE .. "mon.",
    '-- 5.1.0: Added a randomizer log viewer! You can view this after a run dies or from the "Tracked info" screen.',
    '-- When your run dies, there\'s now a special screen that displays one of a few messages. You can even change these yourself by opening "death_quotes.txt" in the main tracker folder!',
    '-- Any runs past the lab are now tracked! You can also view these from the "Tracked info" screen.',
    '-- Some fun statistics are here! They will only apply to runs past the lab, and you can view them in the "Tracked info" screen.',
    "-- Added early pivot tracking! On early routes, the enemy screen will now show a location icon. Hovering over this shows Pok" ..
        Chars.accentedE .. "mon you've seen, and clicking while hovering shows vanilla data.",
    "-- Added profiles for quickload when generating new roms.",
    "-- Added a way to mark neutral stats.",
    "-- Added a random Pok" ..
        Chars.accentedE .. 'ball selector. You can turn this off if you want in the "Tracker Appearance" screen.',
    "-- The tracker will now keep one autosave per game, instead of only one total.",
    "-- Updated Fighting and Psychic type icons.",
    "-- Fixed eggs being revealed early (thanks Fellshadow).",
    "-- Pok" .. Chars.accentedE .. "mon White 2 is now fully functional.",
    "-- Added gender-specific evos for a few Pok" .. Chars.accentedE .. "mon.",
    "-- Fixed Illusion bug for your own Pok" .. Chars.accentedE .. "mon.",
    "-- Special thanks to the Gen 3 tracker team, Mirasz, PyroMike and Darkeye."
}

MiscConstants.DEFAULT_SETTINGS = {
    appearance = {
        RIGHT_JUSTIFIED_NUMBERS = true,
        SHOW_ACCURACY_AND_EVASION = true,
        RANDOM_BALL_PICKER = true,
        SHOW_POKECENTER_HEALS = false,
        ICON_SET_INDEX = 2,
        BLIND_MODE = false
    },
    controls = {
        CHANGE_VIEW = "Start",
        LOAD_NEXT_SEED = "A B Start Select",
        CYCLE_STAT = "L",
        CYCLE_PREDICTION = "R",
        LOCK_ENEMY = "Select"
    },
    battle = {
        CALCULATE_VARIABLE_DAMAGE = true,
        SHOW_MOVE_EFFECTIVENESS = true,
        SHOW_ACTUAL_ENEMY_PP = true,
        SHOW_1ST_FIGHT_STATS_PLATINUM = true,
        ENABLE_ENEMY_LOCKING = false
    },
    colorScheme = {
        ["Main background color"] = 4278190080,
        ["Top box text color"] = 4294967295,
        ["Bottom box text color"] = 4294967295,
        ["Positive text color"] = 4278255360,
        ["Negative text color"] = 4294901760,
        ["Intermediate text color"] = 4294967040,
        ["Move header text color"] = 4294967295,
        ["Top box border color"] = 4289374890,
        ["Bottom box border color"] = 4289374890,
        ["Top box background color"] = 4280427042,
        ["Bottom box background color"] = 4280427042,
        ["Physical icon color"] = 4294952497,
        ["Special icon color"] = 4286428927,
        ["Gear icon color"] = 4292598747,
        ["Black"] = 4278190080
    },
    colorSettings = {
        ["Color move names by type"] = true,
        ["Draw shadows"] = true,
        ["Draw move type icons"] = false,
        ["Color move type icons"] = false,
        ["Transparent backgrounds"] = false,
        ["Show phys/spec move icons"] = true
    },
    quickLoad = {
        LOAD_TYPE = "GENERATE_ROMS",
        ROMS_FOLDER_PATH = "",
        ROM_PATH = "",
        JAR_PATH = "",
        SETTINGS_PATH = ""
    },
    badgesAppearance = {
        SINGLE_BADGE_ALIGNMENT = "RIGHT",
        DOUBLE_BADGE_ALIGNMENT = "LEFT_AND_RIGHT",
        SHOW_BOTH_BADGES = true,
        SPACER = true,
        PRIMARY_BADGE_SET = "JOHTO"
    },
    automaticUpdates = {
        LAST_DAY_CHECKED = "",
        UPDATE_WAS_DONE = true
    }
}

MiscConstants.DEFAULT_POKEMON = {
    pid = 0,
    alternateForm = 0x0000,
    pokemonID = 0,
    trainerID = 0,
    heldItem = 0,
    friendship = 0,
    ability = 0,
    moves = {},
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
    HP = 0,
    stats = {
        HP = "---",
        ATK = "---",
        DEF = "---",
        SPE = "---",
        SPA = "---",
        SPD = "---"
    },
    isEgg = 0,
    nature = 0,
    encounterType = 0,
    moveIDs = {
        0,
        0,
        0,
        0
    },
    movePPs = {
        "---",
        "---",
        "---",
        "---"
    },
    statStages = {
        ["HP"] = 6,
        ["ATK"] = 6,
        ["DEF"] = 6,
        ["SPE"] = 6,
        ["SPA"] = 6,
        ["SPD"] = 6
    }
}

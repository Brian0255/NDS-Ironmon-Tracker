MiscConstants = {}

MiscConstants.TRACKER_VERSION = "6.0.1"

MiscConstants.BIZHAWK_VERSION = client.getversion()

MiscConstants.UPDATE_NOTES = {
    "-- 6.0.1: Fixed an important Bizhawk 2.8 related error. Sorry!",
    "-- Double battles are now much more functional in Gen 4. Pok" ..
        Chars.accentedE .. "mon will update correctly and you can now view your second mon in battle.",
    "-- Under Battle Settings there is now a Doubles Mode option so that you can show your second Pok" ..
        Chars.accentedE .. "mon outside of battle by pressing START.",
    "-- In a double battle, pressing L/R while viewing your mon will show move effectiveness for the left and right enemy mons, respectively.",
    "-- There is a new Pivots tab in the Log Viewer to see what you could have pivoted to in a run. The Stats tab is now just in the Pok" ..
        Chars.accentedE .. "mon tab.",
    "-- Added a simple animated icon set based on the HeartGold walking sprites.",
    "-- Added a coverage calculator in the Extras section of the tracker settings.",
    "-- Added an on-screen Repel indicator under Tracker Appearance that works similar to Gen 3.",
    "-- Added a timer option under Tracker Appearance. Middle clicking will drag the timer wherever you want it, and clicking it will pause/unpause it.",
    "-- Added a toggle under Tracker Appearance to show nicknames.",
    "-- Favorites can now be changed at any time from the Tracker Setup screen.",
    "-- Favorites will stay on screen until you pick your mon in the lab.",
    "-- Mons with multiple evos such as Eevee will now let you cycle through them correctly when viewing potential evos.",
    "-- Any hoverable thing on screen can be clicked to instantly show it."
}

MiscConstants.DEFAULT_SETTINGS = {
    appearance = {
        AUTO_POKEMON_THEMES = false,
        EXPERIENCE_BAR = true,
        RIGHT_JUSTIFIED_NUMBERS = true,
        SHOW_ACCURACY_AND_EVASION = true,
        RANDOM_BALL_PICKER = true,
        SHOW_POKECENTER_HEALS = false,
        SHOW_NICKNAME = false,
        ICON_SET_INDEX = 2,
        BLIND_MODE = false,
        REPEL_ICON = false
    },
    animatedSprites = {
        FASTER_ANIMATIONS = false,
        CHANGE_DIRECTION = false
    },
    controls = {
        CHANGE_VIEW = "Start",
        LOAD_NEXT_SEED = "A B Start Select",
        CYCLE_STAT = "L",
        CYCLE_PREDICTION = "R",
        LOCK_ENEMY = "Select",
        LEFT_EFFECTIVENESS = "L",
        RIGHT_EFFECTIVENESS = "R"
    },
    battle = {
        AUTO_SWAP_TO_ENEMY = false,
        CALCULATE_VARIABLE_DAMAGE = true,
        SHOW_MOVE_EFFECTIVENESS = true,
        SHOW_ACTUAL_ENEMY_PP = true,
        SHOW_1ST_FIGHT_STATS_PLATINUM = true,
        ENABLE_ENEMY_LOCKING = false,
        DOUBLES_MODE = false
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
    },
    trackedInfo = {
        FAINT_DETECTION = PlaythroughConstants.FAINT_DETECTIONS.ON_FIRST_SLOT_FAINT,
        FIRST_TIME_BW2 = true
    },
    extras = {
        BROWS_ENABLED = false,
        BROWS_FRAMES = 8
    },
    tourneyTracker = {
        ENABLED = false
    },
    coverageCalc = {
        FULLY_EVOLVED_ONLY = false
    },
    timer = {
        ENABLED = false,
        TRANSPARENT = false,
        XPOS = 0,
        YPOS = 180.5
    }
}

MiscConstants.DEFAULT_POKEMON = {
    pid = 0,
    alternateForm = 0x0000,
    experience = 0,
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
    EVs = {
        HP = 0,
        ATK = 0,
        DEF = 0,
        SPE = 0,
        SPA = 0,
        SPD = 0
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

PlaythroughConstants = {}

PlaythroughConstants.PROGRESS = {
    NOWHERE = 0,
    PAST_LAB = 1,
    WON = 2
}

PlaythroughConstants.EMPTY_PAST_RUN_STATISTICS = {
    {
        "Overall Progress",
        {
            {"Past Lab", 0},
            {"1 Badge", 0},
            {"2 Badges", 0},
            {"3 Badges", 0},
            {"4 Badges", 0},
            {"5 Badges", 0},
            {"6 Badges", 0},
            {"7 Badges", 0},
            {"8 Badges", 0},
            {"Won", 0}
        }
    },
    {
        "BST Ranges You Ran",
        {
            {"< 300", 0},
            {"300 - 399", 0},
            {"400 - 499", 0},
            {"500+", 0}
        }
    },
    {
        "BST Ranges You Lost to",
        {
            {"< 300", 0},
            {"300 - 399", 0},
            {"400 - 499", 0},
            {"500+", 0}
        }
    },
    {
        "Types You Ran",
        {}
    },
    {
        "Types You Lost to",
        {}
    },
    {
        "Pok" .. Chars.accentedE .. "mon You Ran",
        {}
    },
    {
        "Pok" .. Chars.accentedE .. "mon You Lost to",
        {}
    },
    {
        "Moves You Had",
        {}
    },
    {
        "Moves Your Enemies Had",
        {}
    },
    {
        "Abilities You Had",
        {}
    },
    {
        "Abilities You Lost to",
        {}
    }
}

PlaythroughConstants.CAUSES = {
    STANDARD = 0,
    WON = 1,
    SHEDINJA = 2,
    IMPOSTER = 3,
    ENEMY_LOWER_BST = 4,
}

PlaythroughConstants.FAINT_DETECTIONS = {
    ON_FIRST_SLOT_FAINT = 0,
    ON_HIGHEST_LEVEL_FAINT = 1,
    ON_ENTIRE_PARTY_FAINT = 2
}

--in case the death quotes file is nil or something dumb like that
PlaythroughConstants.DEFAULT_STANDARD_MESSAGES = {
    "There's always next time...",
    "Some things were just not meant to be.",
    "Oh well.",
    "Could have been worse, I guess. Or not.",
    "Against all odds... you did not triumph.",
    "How unfortunate.",
    "That's just the way it goes sometimes.",
    "You should definitely pick the left ball next attempt.",
    "Having fun yet?",
    "The house always wins.",
    "Anything that can go wrong, will go wrong.",
    "Looks like your luck finally ran out."
}

PlaythroughConstants.RUN_OVER_MESSAGES = {
    [PlaythroughConstants.CAUSES.WON] = {
        exclusive = true,
        messages = {
            "Congratulations!",
            "My god... you actually did it...",
            "I'm speechless.",
            "The end of a long, arduous journey...",
            "On this day, the planets aligned..."
        }
    },
    [PlaythroughConstants.CAUSES.STANDARD] = {
        messages = {}
    },
    [PlaythroughConstants.CAUSES.IMPOSTER] = {
        exclusive = true,
        messages = {
            "Sometimes, you really just can't face yourself.",
            "Looking in the mirror really is that painful.",
            "Dark Link was a lot easier than this...",
            "Does this mean we can ban it now?"
        }
    },
    [PlaythroughConstants.CAUSES.ENEMY_LOWER_BST] = {
        exclusive = true,
        messages = {
            "Sometimes, the weaker triumph.",
            "A surprising outcome.",
            "Miracles really can happen.",
            "I don't think anyone saw that coming.",
            "Huh?",
            "Surely that Pok" .. Chars.accentedE .. "mon had Huge Power.",
        }
    },
    [PlaythroughConstants.CAUSES.SHEDINJA] = {
        exclusive = true,
        messages = {
            "Never feels good to lose to that.",
            "There are over 20 fire moves in the game, and you didn't roll a single one.",
            "It was bound to happen at some point.",
            "The one Pok" .. Chars.accentedE .. "mon you didn't want to see..."
        }
    }
}

function PlaythroughConstants.initializeStandardMessages()
    local quotesFile = Paths.CURRENT_DIRECTORY..Paths.SLASH.."death_quotes.txt"
    PlaythroughConstants.RUN_OVER_MESSAGES[PlaythroughConstants.CAUSES.STANDARD].messages =
        MiscUtils.shallowCopy(PlaythroughConstants.DEFAULT_STANDARD_MESSAGES)

    local newMessages = {}
    local currentIndex = 1
    if FormsUtils.fileExists(quotesFile) then
        newMessages = MiscUtils.readLinesFromFile(quotesFile)
    end
    if newMessages[1] ~= nil then
        PlaythroughConstants.RUN_OVER_MESSAGES[PlaythroughConstants.CAUSES.STANDARD].messages = newMessages
    end
end

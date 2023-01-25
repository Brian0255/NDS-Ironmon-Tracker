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
    SHEDINJA = 1,
    IMPOSTER = 2,
    ENEMY_LOWER_BST = 3,
    WON = 4
}

--in case the death quotes file is nil or something dumb like that
PlaythroughConstants.DEFAULT_STANDARD_MESSAGES = {
    "Did you know? Your lab success rate is %labrate%.",
    "Is this the part where it gets called a skill issue?",
    "There's always next time...",
    "Some things were just not meant to be.",
    "Oh well.",
    "Could have been worse, I guess. Or not.",
    "Against all odds... you did not triumph.",
    "How unfortunate.",
    "Maybe you just didn't believe hard enough.",
    "That's just the way it goes sometimes.",
    "You should definitely pick the left ball next attempt.",
    "Having fun yet?",
    "%totalruns% attempts and counting...",
    "The house always wins.",
    "One day you'll finally push the boulder up that hill.",
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
            "Maybe try winning the coin flip next time.",
            "Dark Link was a lot easier than this...",
            "Does this mean we can ban it now?"
        }
    },
    [PlaythroughConstants.CAUSES.ENEMY_LOWER_BST] = {
        exclusive = true,
        messages = {
            "Sometimes, the weaker triumph.",
            "A surprising outcome.",
            "I don't think anyone saw that coming.",
            "Huh?",
            "How did you let that happen?",
            "Miracles really can happen.",
            "Surely that Pok" .. Chars.accentedE .. "mon had Huge Power.",
            "I'm sorry, I think I need to look away for a second."
        }
    },
    [PlaythroughConstants.CAUSES.SHEDINJA] = {
        exclusive = true,
        messages = {
            "Never feels good to lose to that.",
            "There are over 20 fire moves in the game, and you didn't roll a single one.",
            "Hope you didn't spend too long trying to stall it out.",
            "It was bound to happen at some point.",
            "The one Pok" .. Chars.accentedE .. "mon you didn't want to see..."
        }
    }
}

function PlaythroughConstants.initializeStandardMessages()
    local quotesFile = "death_quotes.txt"
    PlaythroughConstants.RUN_OVER_MESSAGES[PlaythroughConstants.CAUSES.STANDARD].messages =
        MiscUtils.shallowCopy(PlaythroughConstants.DEFAULT_STANDARD_MESSAGES)

    local newMessages = {}
    local currentIndex = 1
    if FormsUtils.fileExists(quotesFile) then
        for line in io.lines(quotesFile) do
            if line ~= "" then
                newMessages[currentIndex] = line
                currentIndex = currentIndex + 1
            end
        end
    end
    if next(newMessages) ~= nil then
        PlaythroughConstants.RUN_OVER_MESSAGES[PlaythroughConstants.CAUSES.STANDARD].messages = newMessages
    end
end

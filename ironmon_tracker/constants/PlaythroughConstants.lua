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
        "Pok" .. MiscConstants.accentedE .. "mon You Ran",
        {}
    },
    {
        "Pok" .. MiscConstants.accentedE .. "mon You Lost to",
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
    LOW_BST = 3,
    ENEMY_LOWER_BST = 4,
    LAB = 5,
    PAST_LAB = 6,
    WON = 7
}

PlaythroughConstants.RUN_OVER_MESSAGES = {
    [PlaythroughConstants.CAUSES.LAB] = {
        exclusive = false,
        messages = {
            "Just one more seed...",
            "Did you know? Your lab success rate is %labrate%.",
            "Oh no! Anyway..."
        }
    },
    [PlaythroughConstants.CAUSES.PAST_LAB] = {
        exclusive = false,
        messages = {
            "The lab was getting a little lonely anyway.",
            "Might be a good time to get up and stretch.",
            "Never get attached.",
        }
    },
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
        messages = {
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
            "Looks like your luck finally ran out.",
        }
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
    [PlaythroughConstants.CAUSES.LOW_BST] = {
        exclusive = false,
        messages = {
            "Doesn't look like that Pok"..MiscConstants.accentedE.."mon was going to make it very far anyway.",
            "Seems like that Pok"..MiscConstants.accentedE.."mon was doomed from the get go.",
            "Looks like that %enemy% did you a favor.",
            "Sometimes you're glad to go back to the lab.",
            "Were you honestly going to try and run that?"
        }
    },
    [PlaythroughConstants.CAUSES.ENEMY_LOWER_BST] = {
        exclusive = true,
        messages = {
            "Sometimes, the weaker triumph.",
            "I'm not sure what happened there.",
            "A surprising outcome.",
            "I don't think anyone saw that coming.",
            "Huh?"
        }
    },
    [PlaythroughConstants.CAUSES.SHEDINJA] = {
        exclusive = true,
        messages = {
            "Never feels good to lose to that.",
            "There are over 20 fire moves in the game, and you rolled 0 of them.",
            "Hope you didn't spend too long trying to stall it out.",
            "It was bound to happen at some point.",
            "The one Pok" .. MiscConstants.accentedE .. "mon you didn't want to see..."
        }
    }
}

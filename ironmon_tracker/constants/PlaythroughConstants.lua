PlaythroughConstants = {}

PlaythroughConstants.PROGRESS = {
    NOWHERE = 0,
    PAST_LAB = 1,
    WON = 2
}

PlaythroughConstants = {}

PlaythroughConstants.PROGRESS = {
    NOWHERE = 0,
    PAST_LAB = 1,
    WON = 2
}

PlaythroughConstants.CAUSES = {
    STANDARD = 0,
    IMPOSTER = 1,
    LOW_BST = 2,
    ENEMY_LOWER_BST = 3,
    SHEDINJA = 4
}

PlaythroughConstants.BEGINNING_TEMPLATES = {
    "Lost to",
    "Died to",
    "Met its untimely demise to",
    "Perished to",
    "Got absolutely rolled by",
    "Met its match from",
    "Fainted from",
    "Ran out of gas against",
    "Took its last breath against",
    "Foughts its last battle against",
    "Got taken out by",
    "Got pummeled by"
}
--[[
PlaythroughConstants.ENDING_TEMPLATES = {
    [PlaythroughConstants.CAUSES.STANDARD] = {
        "Is this the part where it gets called a skill issue?",
        "There's always next time...",
        "Some things were just not meant to be.",
        "Oh well.",
        "Could have been worse, I guess.",
        "Against all odds... you did not triumph.",
        "How unfortunate.",
        "Maybe you just didn't believe hard enough.",
        "That's just the way it goes sometimes.",
        "Never get attached.",
        "The lab was getting a little lonely anyway.",
        "Isn't this fun?",
        "The house always wins.",
    },
    [PlaythroughConstants.CAUSES.IMPOSTER] = {
        "Sometimes, you really just can't face yourself.",
        "Looking in the mirror really is that painful.",
        "Maybe try winning the coin flip next time.",
        "Dark Link was a lot easier than this...",
        "Does this mean we can ban it now?"
    },
    [PlaythroughConstants.CAUSES.LOW_BST] = {
        "Doesn't look like that Pok\233mon was going to make it very far anyway.",
        "Seems like that Pok\233mon was doomed from the get go.",
        "Looks like that %enemy% did you a favor.",
        "Sometimes you're glad to go back to the lab.",
        "It's astonishing that this Pok\233mon even got out of the lab."
    },
    [PlaythroughConstants.CAUSES.ENEMY_LOWER_BST] = {
        "Sometimes, the weaker triumph.",
        "I'm not sure what happened there.",
        "Certainly a surprising outcome."
    },
    [PlaythroughConstants.CAUSES.SHEDINJA] = {
        "Never feels good to lose to that.",
        "There are over 20 fire moves in the game, and you somehow didn't roll a single one.",
        "Hope you didn't spend too long trying to stall it out."
    }
}
PlaythroughConstants.UNIQUE_TEMPLATES = {
    [PlaythroughConstants.CAUSES.SHEDINJA] = "Died to [redacted] with Wonder Guard in %location%."
}
--]]
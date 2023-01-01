local function PastRun(initialDate, initialFaintedPokemon, initialEnemyPokemon, initialLocation, initialBadges, initialProgress)
    local self = {}

    self.FaintingConstants = {}

    self.FaintingConstants.PROGRESS = {
        NOWHERE = 0,
        PAST_LAB = 1,
        WON = 2
    }

    self.FaintingConstants.CAUSES = {
        STANDARD = 0,
        IMPOSTER = 1,
        LOW_BST = 2,
        ENEMY_LOWER_BST = 3,
        SHEDINJA = 4
    }
    self.FaintingConstants.BEGINNING_TEMPLATES = {
        "Lost to",
        "Died to",
        "Met its untimely demise to",
        "Perished to",
        "Got absolutely rolled by",
        "Met its match from",
        "Fainted from",
        "Ran out of gas against",
        "Took its last breathe against",
        "Foughts its last battle with",
        "Got taken out by",
        "Got pummeled by"
    }
    self.FaintingConstants.ENDING_TEMPLATES = {
        [self.FaintingConstants.CAUSES.STANDARD] = {
            "Is this the part where it gets called a skill issue?",
            "There's always next time...",
            "Some things were just not meant to be.",
            "Oh well.",
            "Could have been worse, I guess.",
            "Against all odds... you did not triumph.",
            "How unfortunate.",
            "Maybe you just didn't believe hard enough.",
            "That's just the way it goes sometimes.",
            "Never get attached."
        },
        [self.FaintingConstants.CAUSES.IMPOSTER] = {
            "Sometimes, you really just can't face yourself.",
            "Looking in the mirror really is that painful.",
            "Maybe try winning the coin flip next time.",
            "Dark Link was a lot easier than this...",
            "Does this mean we can ban it now?"
        },
        [self.FaintingConstants.CAUSES.LOW_BST] = {
            "Doesn't look like that Pok\233mon was going to make it very far anyway.",
            "Seems like that Pok\233mon was doomed from the get go.",
            "Looks like that %enemy% did you a favor.",
            "Sometimes you're glad to go back to the lab.",
            "It's astonishing that this Pok\233mon even got out of the lab."
        },
        [self.FaintingConstants.CAUSES.ENEMY_LOWER_BST] = {
            "Sometimes, the weaker triumph.",
            "I'm not sure what happened there.",
            "Certainly a surprising outcome."
        },
        [self.FaintingConstants.CAUSES.SHEDINJA] = {
            "Never feels good to lose to that.",
            "There are over 20 fire moves in the game, and you somehow didn't roll a single one.",
            "Hope you didn't spend too long trying to stall it out."
        }
    }
    self.FaintingConstants.UNIQUE_TEMPLATES = {
        [self.FaintingConstants.CAUSES.SHEDINJA] = "Died to [redacted] with Wonder Guard in %location%."
    }

    local date = initialDate
    local faintedPokemon = initialFaintedPokemon
    local enemyPokemon = initialEnemyPokemon
    local location = initialLocation
    local badges = initialBadges
    local cause
    local description
    local progress = initialProgress
    if progress == nil then progress = self.FaintingConstants.PROGRESS.NOWHERE end

    local function getArticleBeforeName(enemyName)
        local vowels = {
            A = true,
            E = true,
            I = true,
            O = true,
            U = true
        }
        local beforeEnemyName = "a"
        local firstLetter = enemyName:sub(1, 1)
        if vowels[firstLetter] then
            beforeEnemyName = beforeEnemyName .. "n"
        end
        return beforeEnemyName
    end

    function self.randomizeDescription()
        description = ""
        local enemyName = enemyPokemon.name
        local enemyAbility = AbilityData.ABILITIES[enemyPokemon.ability].name
        local totalAddedForSelection = 0
        local endings = {}
        local beginning = MiscUtils.randomTableValue(self.FaintingConstants.BEGINNING_TEMPLATES)
        local middle
        local ending
        local beforeEnemyName = getArticleBeforeName(enemyName)
        middle = " " .. beforeEnemyName .. " " .. enemyName .. " with " .. enemyAbility .. " in " .. location .. ". "
        if cause ~= self.FaintingConstants.CAUSES.STANDARD then
            local potentialEndings = self.FaintingConstants.ENDING_TEMPLATES[cause]
            MiscUtils.combineTables(endings, potentialEndings)
            totalAddedForSelection = #potentialEndings
        end
        local standardEndings =
            MiscUtils.deepCopy(self.FaintingConstants.ENDING_TEMPLATES[self.FaintingConstants.CAUSES.STANDARD])
        for i = totalAddedForSelection + 1, 10, 1 do
            table.insert(endings, MiscUtils.removeRandomTableValue(standardEndings))
        end
        ending = MiscUtils.randomTableValue(endings)
        description = beginning .. middle .. ending
        description = string.gsub(description, "%%enemy%%", enemyName)
    end

    local function figureOutCause()
        local abilityName = AbilityData.ABILITIES[enemyPokemon.ability].name
        local causeMappings = {
            [self.FaintingConstants.CAUSES.SHEDINJA] = function()
                return enemyPokemon.name == "Shedinja"
            end,
            [self.FaintingConstants.CAUSES.IMPOSTER] = function()
                return abilityName == "Imposter"
            end,
            [self.FaintingConstants.CAUSES.LOW_BST] = function()
                return tonumber(faintedPokemon.bst) < 400
            end,
            [self.FaintingConstants.CAUSES.ENEMY_LOWER_BST] = function()
                return (tonumber(faintedPokemon.bst) - tonumber(enemyPokemon.bst)) >= 100
            end
        }
        cause= self.FaintingConstants.CAUSES.STANDARD
        for reason, causeSatisfied in pairs(causeMappings) do
            if causeSatisfied() then
                cause = reason
                --break out early in case of something like you being low BST and losing to Shedinja - Shedinja should override this
                return
            end
        end
    end

    figureOutCause()
    self.randomizeDescription()

    function self.getDescription()
        return description
    end
    
    function self.getDate()
        return date
    end

    function self.getFaintedPokemon()
        return faintedPokemon
    end

    function self.getEnemyPokemon()
        return enemyPokemon
    end

    function self.getLocation()
        return location
    end

    function self.getBadges()
        return badges
    end

    function self.getProgress()
        return progress
    end

    return self
end

return PastRun

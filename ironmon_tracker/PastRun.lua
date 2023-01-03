local function PastRun(initialDate, initialFaintedPokemon, initialEnemyPokemon, initialLocation, initialBadges, initialProgress)
    local self = {}
    local date = initialDate
    local faintedPokemon = initialFaintedPokemon
    local enemyPokemon = initialEnemyPokemon
    local location = initialLocation
    local badges = initialBadges
    local cause
    local description
    local progress = initialProgress
    if progress == nil then progress = FaintingConstants.PROGRESS.NOWHERE end

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
        local beginning = MiscUtils.randomTableValue(FaintingConstants.BEGINNING_TEMPLATES)
        local middle
        local ending
        local beforeEnemyName = getArticleBeforeName(enemyName)
        middle = " " .. beforeEnemyName .. " " .. enemyName .. " with " .. enemyAbility .. " in " .. location .. ". "
        if cause ~= FaintingConstants.CAUSES.STANDARD then
            local potentialEndings = FaintingConstants.ENDING_TEMPLATES[cause]
            MiscUtils.combineTables(endings, potentialEndings)
            totalAddedForSelection = #potentialEndings
        end
        local standardEndings =
            MiscUtils.deepCopy(FaintingConstants.ENDING_TEMPLATES[FaintingConstants.CAUSES.STANDARD])
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
            [FaintingConstants.CAUSES.SHEDINJA] = function()
                return enemyPokemon.name == "Shedinja"
            end,
            [FaintingConstants.CAUSES.IMPOSTER] = function()
                return abilityName == "Imposter"
            end,
            [FaintingConstants.CAUSES.LOW_BST] = function()
                return tonumber(faintedPokemon.bst) < 400
            end,
            [FaintingConstants.CAUSES.ENEMY_LOWER_BST] = function()
                return (tonumber(faintedPokemon.bst) - tonumber(enemyPokemon.bst)) >= 100
            end
        }
        cause= FaintingConstants.CAUSES.STANDARD
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

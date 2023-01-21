local function PastRun(
    initialDate,
    intitialSeconds,
    initialFaintedPokemon,
    initialEnemyPokemon,
    initialLocation,
    initialBadges,
    initialProgress)
    local self = {}

    local function fillPPsAndHP(pokemon)
        for i = 1, 4, 1 do
            pokemon.movePPs[i] = MoveData.MOVES[pokemon.moveIDs[i] + 1].pp
        end
        pokemon.curHP = pokemon.stats.HP
        pokemon.status = 0
    end

    local date = initialDate
    local seconds = intitialSeconds

    local faintedPokemon = initialFaintedPokemon
    local enemyPokemon = initialEnemyPokemon
    fillPPsAndHP(faintedPokemon)
    fillPPsAndHP(enemyPokemon)
    local location = initialLocation
    local badges = initialBadges
    local progress = initialProgress
    local cause
    local description
    if progress == nil then
        progress = PlaythroughConstants.PROGRESS.NOWHERE
    end


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

    local function randomizeDescription()
        description = ""
        local enemyName = enemyPokemon.name
        local enemyAbility = AbilityData.ABILITIES[enemyPokemon.ability + 1].name
        local beginning = MiscUtils.randomTableValue(PlaythroughConstants.BEGINNING_TEMPLATES)
        local ending
        local beforeEnemyName = getArticleBeforeName(enemyName)
        ending = " " .. beforeEnemyName .. " " .. enemyName .. " with " .. enemyAbility .. " in " .. location .. ". "
        description = beginning .. ending
        description = string.gsub(description, "%%enemy%%", enemyName)
    end

    local function figureOutCause()
        local abilityName = AbilityData.ABILITIES[enemyPokemon.ability].name
        local causeMappings = {
            [PlaythroughConstants.CAUSES.SHEDINJA] = function()
                return enemyPokemon.name == "Shedinja"
            end,
            [PlaythroughConstants.CAUSES.IMPOSTER] = function()
                return abilityName == "Imposter"
            end,
            [PlaythroughConstants.CAUSES.LOW_BST] = function()
                return tonumber(faintedPokemon.bst) < 400
            end,
            [PlaythroughConstants.CAUSES.ENEMY_LOWER_BST] = function()
                return (tonumber(faintedPokemon.bst) - tonumber(enemyPokemon.bst)) >= 100
            end
        }
        cause = PlaythroughConstants.CAUSES.STANDARD
        for reason, causeSatisfied in pairs(causeMappings) do
            if causeSatisfied() then
                cause = reason
                --break out early in case of something like you being low BST and losing to Shedinja - Shedinja should override this
                return
            end
        end
    end

    function self.getDescription()
        return description
    end

    function self.getBadgeCount(pastRun)
        local count = 0
        for _, badgeSet in pairs(badges) do
            for _, badge in pairs(badgeSet) do
                if badge == 1 then
                    count = count + 1
                end
            end
        end
        return count
    end

    function self.getDate()
        return date
    end

    function self.getSeconds()
        return seconds
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

    figureOutCause()
    randomizeDescription()

    return self
end

return PastRun

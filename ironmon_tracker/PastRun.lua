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

    local faintedPokemon = MiscUtils.shallowCopy(initialFaintedPokemon)
    local enemyPokemon = MiscUtils.shallowCopy(initialEnemyPokemon)
    fillPPsAndHP(faintedPokemon)
    fillPPsAndHP(enemyPokemon)
    local location = initialLocation
    local badges = initialBadges
    local progress = initialProgress
    local description
    if progress == nil then
        progress = PlaythroughConstants.PROGRESS.NOWHERE
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


    return self
end

return PastRun

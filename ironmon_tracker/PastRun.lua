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

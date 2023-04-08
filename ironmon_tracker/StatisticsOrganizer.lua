StatisticsOrganizer = {}

--[[
my stats calculations are very naive right now, could use this in the future

function math.pearson(a)
    -- compute the mean
    local x1, y1 = 0, 0
    for _, v in pairs(a) do
        x1, y1 = x1 + v[1], y1 + v[2]
    end
    -- compute the coefficient
    x1, y1 = x1 / #a, y1 / #a
    local x2, y2, xy = 0, 0, 0
    for _, v in pairs(a) do
        local tx, ty = v[1] - x1, v[2] - y1
        xy, x2, y2 = xy + tx * ty, x2 + tx * tx, y2 + ty * ty
    end
    return xy / math.sqrt(x2) / math.sqrt(y2)
end

--]]
function StatisticsOrganizer.convertStatsToWeights(stats)
    local weights = {}
    local sum = 0
    for _, value in pairs(stats) do
        sum = sum + value
    end
    for statName, value in pairs(stats) do
        weights[statName] = value / sum
    end
    return weights
end

function StatisticsOrganizer.filterByCondition(dataSet, conditionFunction)
    local newData = {}
    for i, data in pairs(dataSet) do
        if conditionFunction(data) then
            table.insert(newData, data)
        end
    end
    return newData
end

function StatisticsOrganizer.calculateSpreadVariance(stats, statSpreadConstant)
    local totalVariance = 0
    local weights = StatisticsOrganizer.convertStatsToWeights(stats)
    for statName, value in pairs(stats) do
        if statSpreadConstant[statName] ~= 0 then
            totalVariance = totalVariance + math.abs(value - statSpreadConstant[statName])
        end
    end
    return totalVariance
end

local function countTotalWithCondition(dataSet, conditionFunction)
    local count = 0
    for _, info in pairs(dataSet) do
        if conditionFunction(info) then
            count = count + 1
        end
    end
    return count
end

local function sortAttributeCounts(attributeCountList)
    local sortedList = {}
    local keys = {}
    for key, _ in pairs(attributeCountList) do
        table.insert(keys, key)
    end
    table.sort(
        keys,
        function(keyA, keyB)
            if attributeCountList[keyA] == attributeCountList[keyB] then
                return keyA < keyB
            end
            return attributeCountList[keyA] > attributeCountList[keyB]
        end
    )
    for _, key in pairs(keys) do
        table.insert(sortedList, {key, attributeCountList[key]})
    end
    return sortedList
end

--basically for sorting the data by a certain function
function StatisticsOrganizer.createSortedStatistic(dataSet, sortingFunction)
    --Data sets should not be tables inside of tables, otherwise a deep copy will lag.
    local sortedData = MiscUtils.shallowCopy(dataSet)
    table.sort(
        sortedData,
        function(a, b)
            return sortingFunction(a, b)
        end
    )
    return sortedData
end

--counted statistic is something like "how many mons are in the BST range of 400-500"
function StatisticsOrganizer.createCountedStatistic(dataSet, statisticName, conditionFunction, previousCount)
    if previousCount == nil then
        previousCount = 0
    end
    local total = previousCount + countTotalWithCondition(dataSet, conditionFunction)
    return {statisticName, total}
end

--attribute statistic is something like "most common types"
function StatisticsOrganizer.createAttributeStatistic(
    dataSet,
    statisticName,
    attributeReturningFunction,
    previousSortedCounts)
    local counts = {}
    if previousSortedCounts ~= nil then
        for _, entry in pairs(previousSortedCounts) do
            local name, count = entry[1], entry[2]
            counts[name] = count
        end
    end
    for _, data in pairs(dataSet) do
        local attributeValue = attributeReturningFunction(data)
        if type(attributeValue) == "table" then
            for _, value in pairs(attributeValue) do
                if counts[value] == nil then
                    counts[value] = 0
                end
                counts[value] = counts[value] + 1
            end
        else
            if counts[attributeValue] == nil then
                counts[attributeValue] = 0
            end
            counts[attributeValue] = counts[attributeValue] + 1
        end
    end
    return {statisticName, sortAttributeCounts(counts)}
end

local function sumSpecificStats(pokemonStats, statList)
    local total = 0
    for _, statName in pairs(statList) do
        total = total + pokemonStats[statName]
    end
    return total
end

local function createStatBasedStatistic(ids, logPokemon, statList, descending)
    local statistic =
        StatisticsOrganizer.createSortedStatistic(
        ids,
        function(id1, id2)
            local stats1 = logPokemon[id1].stats
            local stats2 = logPokemon[id2].stats
            local sum1 = sumSpecificStats(stats1, statList)
            local sum2 = sumSpecificStats(stats2, statList)
            if descending then
                return sum1 > sum2
            else
                return sum1 < sum2
            end
        end
    )
    local top10 = {}
    for i = 1, 10, 1 do
        if statistic[i] then
            table.insert(top10, statistic[i])
        end
    end
    return top10
end

function StatisticsOrganizer.createLogStatistics(logInfo)
    local logPokemon = logInfo.getPokemon()
    local ids = {}
    for id, pokemon in pairs(logPokemon) do
        table.insert(ids, id)
    end
    local statisticsSets = {
        {"Best Special Attackers", {"SPA", "SPE"}, true},
        {"Best Physical Attackers", {"ATK", "SPE"}, true},
        {"Biggest Special Walls", {"HP", "SPD"}, true},
        {"Best Defensive Tanks", {"HP", "DEF"}, true},
        {"Bulkiest Overall", {"HP", "DEF", "SPD"}, true},
        {"Most Frail", {"HP", "DEF", "SPD"}, false}
    }
    local data = {}
    for _, statisticSet in pairs(statisticsSets) do
        local name, args, descending = statisticSet[1], statisticSet[2], statisticSet[3]
        table.insert(data, {name, createStatBasedStatistic(ids, logPokemon, args, descending)})
    end
    return data
end

local function createStatRankMapping(sortedByStat)
    local pokemonIDToRanking = {}
    for ranking, pokemonID in pairs(sortedByStat) do
        pokemonIDToRanking[pokemonID] = ranking
    end
    return pokemonIDToRanking
end

function StatisticsOrganizer.createLogRankingStatistics(logPokemon, pokemonKeyList)
    local rankings = {}
    local orderedStats = {"HP", "ATK", "DEF", "SPA", "SPD", "SPE"}
    for _, stat in pairs(orderedStats) do
        local statRanking = {
            statName = stat,
            data = {}
        }
        local sortedByStat =
            StatisticsOrganizer.createSortedStatistic(
            pokemonKeyList,
            function(id1, id2)
                return logPokemon[id1].stats[stat] > logPokemon[id2].stats[stat]
            end
        )
        statRanking.data = createStatRankMapping(sortedByStat)
        table.insert(rankings, statRanking)
    end
    return rankings
end

local function createRunProgressStatistic(newPastRun, statisticSet)
    local data = statisticSet[2]
    local progressStats = {}
    table.insert(
        progressStats,
        StatisticsOrganizer.createCountedStatistic(
            {newPastRun},
            "Past Lab",
            function(pastRun)
                return pastRun.getProgress() > 0
            end,
            data[1][2]
        )
    )
    for i = 1, 8, 1 do
        local name = i .. " Badge"
        if i > 1 then
            name = name .. "s"
        end
        table.insert(
            progressStats,
            StatisticsOrganizer.createCountedStatistic(
                {newPastRun},
                name,
                function(pastRun)
                    return pastRun.getBadgeCount() >= i
                end,
                data[i + 1][2]
            )
        )
    end
    table.insert(
        progressStats,
        StatisticsOrganizer.createCountedStatistic(
            {newPastRun},
            "Won",
            function(pastRun)
                return pastRun.getProgress() == 2
            end,
            data[10][2]
        )
    )
    return {statisticSet[1], progressStats}
end

local function createBSTRangeStatistic(newPastRun, forEnemy, statisticSet)
    local BSTRangeStats = {}
    local ranges = {
        {"< 300", 0, 299},
        {"300 - 399", 300, 399},
        {"400 - 499", 400, 499},
        {"500+", 500, 800}
    }
    local data = statisticSet[2]
    for index, rangeInfo in pairs(ranges) do
        local statName, lowEnd, highEnd = rangeInfo[1], rangeInfo[2], rangeInfo[3]
        table.insert(
            BSTRangeStats,
            StatisticsOrganizer.createCountedStatistic(
                {newPastRun},
                statName,
                function(pastRun)
                    local pokemon = pastRun.getFaintedPokemon()
                    if forEnemy then
                        pokemon = pastRun.getEnemyPokemon()
                    end
                    return tonumber(pokemon.bst) >= lowEnd and tonumber(pokemon.bst) <= highEnd
                end,
                data[index][2]
            )
        )
    end
    return {statisticSet[1], BSTRangeStats}
end

local function createPokemonTypeStatistic(newPastRun, forEnemy, statisticSet)
    local title = "Types You Ran"
    if forEnemy then
        title = "Types You Lost to"
    end
    return StatisticsOrganizer.createAttributeStatistic(
        {newPastRun},
        title,
        function(pastRun)
            local types = pastRun.getFaintedPokemon().type
            if forEnemy then
                types = pastRun.getEnemyPokemon().type
            end
            local newTypes = {}
            for i, pokemonType in pairs(types) do
                if pokemonType ~= "" then
                    table.insert(newTypes, MiscUtils.toTitleCase(pokemonType))
                end
            end
            return newTypes
        end,
        statisticSet[2]
    )
end

local function capAt10(statistic)
    local statName, data = statistic[1], statistic[2]
    local newData = {}
    for i = 1, 10, 1 do
        if data[i] then
            newData[i] = data[i]
        end
    end
    return {statName, newData}
end

local function createPokemonNameStatistic(newPastRun, forEnemy, statisticSet)
    local title = "Pok" .. Chars.accentedE .. "mon You Ran"
    if forEnemy then
        title = "Pok" .. Chars.accentedE .. "mon You Lost to"
    end
    return StatisticsOrganizer.createAttributeStatistic(
        {newPastRun},
        title,
        function(pastRun)
            local pokemon = pastRun.getFaintedPokemon()
            if forEnemy then
                pokemon = pastRun.getEnemyPokemon()
            end
            return pokemon.name
        end,
        statisticSet[2]
    )
end

local function createPokemonMovesStatistic(newPastRun, forEnemy, statisticSet)
    local title = "Moves You Had"
    if forEnemy then
        title = "Moves Your Enemies Had"
    end
    return StatisticsOrganizer.createAttributeStatistic(
        {newPastRun},
        title,
        function(pastRun)
            local pokemon = pastRun.getFaintedPokemon()
            if forEnemy then
                pokemon = pastRun.getEnemyPokemon()
            end
            local moveNames = {}
            for _, moveID in pairs(pokemon.moveIDs) do
                table.insert(moveNames, MoveData.MOVES[moveID + 1].name)
            end
            return moveNames
        end,
        statisticSet[2]
    )
end

local function createAbilitiesStatistic(newPastRun, forEnemy, statisticSet)
    local title = "Abilities You Had"
    if forEnemy then
        title = "Abilities Your Enemies Had"
    end
    return StatisticsOrganizer.createAttributeStatistic(
        {newPastRun},
        title,
        function(pastRun)
            local pokemon = pastRun.getFaintedPokemon()
            if forEnemy then
                pokemon = pastRun.getEnemyPokemon()
            end
            return AbilityData.ABILITIES[pokemon.ability + 1].name
        end,
        statisticSet[2]
    )
end

function StatisticsOrganizer.capStatistics(statistics)
    local newStatistics = {}
    for index, statistic in pairs(statistics) do
        newStatistics[index] = capAt10(statistic)
    end
    return newStatistics
end

function StatisticsOrganizer.updateStatisticsWithNewRun(newPastRun, pastRunStatistics, gameName)
    --Analyze a new past run and update the existing statistics.
    --This allows the user to potentially clear out 0 badge past runs without affecting the statistics.
    local progress = pastRunStatistics[1]
    local BSTRangePlayer, BSTRangeEnemy = pastRunStatistics[2], pastRunStatistics[3]
    local playerTypes, enemyTypes = pastRunStatistics[4], pastRunStatistics[5]
    local playerMons, enemyMons = pastRunStatistics[6], pastRunStatistics[7]
    local playerMoves, enemyMoves = pastRunStatistics[8], pastRunStatistics[9]
    local playerAbilities, enemyAbilities = pastRunStatistics[10], pastRunStatistics[11]

    progress = createRunProgressStatistic(newPastRun, progress)
    BSTRangePlayer = createBSTRangeStatistic(newPastRun, false, BSTRangePlayer)
    BSTRangeEnemy = createBSTRangeStatistic(newPastRun, true, BSTRangeEnemy)
    playerTypes = createPokemonTypeStatistic(newPastRun, false, playerTypes)
    enemyTypes = createPokemonTypeStatistic(newPastRun, true, enemyTypes)
    playerMons = createPokemonNameStatistic(newPastRun, false, playerMons)
    enemyMons = createPokemonNameStatistic(newPastRun, true, enemyMons)
    playerMoves = createPokemonMovesStatistic(newPastRun, false, playerMoves)
    enemyMoves = createPokemonMovesStatistic(newPastRun, true, enemyMoves)
    playerAbilities = createAbilitiesStatistic(newPastRun, false, playerAbilities)
    enemyAbilities = createAbilitiesStatistic(newPastRun, true, enemyAbilities)

    pastRunStatistics = {
        progress,
        BSTRangePlayer,
        BSTRangeEnemy,
        playerTypes,
        enemyTypes,
        playerMons,
        enemyMons,
        playerMoves,
        enemyMoves,
        playerAbilities,
        enemyAbilities
    }

    MiscUtils.saveTableToFile("savedData/" .. gameName .. ".statistics", pastRunStatistics)

    return pastRunStatistics
end

function StatisticsOrganizer.loadPastRunStatistics(gameName)
    local pastRunStatistics = MiscUtils.getTableFromFile("savedData/" .. gameName .. ".statistics")
    if pastRunStatistics == nil or pastRunStatistics == "" then
        local statistics = MiscUtils.deepCopy(PlaythroughConstants.EMPTY_PAST_RUN_STATISTICS)
        MiscUtils.saveTableToFile("savedData/" .. gameName .. ".statistics", statistics)
        return statistics
    end
    return pastRunStatistics
end

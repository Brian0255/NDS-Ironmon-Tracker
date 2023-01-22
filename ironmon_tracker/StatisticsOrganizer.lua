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
function StatisticsOrganizer.createCountedStatistic(dataSet, statisticName, conditionFunction)
    local total = countTotalWithCondition(dataSet, conditionFunction)
    return {statisticName, total}
end

--attribute statistic is something like "most common types"
function StatisticsOrganizer.createAttributeStatistic(dataSet, statisticName, attributeReturningFunction)
    local counts = {}
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
        {"Best Physical Hitters", {"ATK", "SPE"}, true},
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

local function createRunProgressStatistic(runHashes, pastRuns)
    local progressStats = {}
    table.insert(
        progressStats,
        StatisticsOrganizer.createCountedStatistic(
            runHashes,
            "Past Lab",
            function(runHash)
                return pastRuns[runHash].getProgress() > 0
            end
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
                runHashes,
                name,
                function(runHash)
                    return pastRuns[runHash].getBadgeCount() >= i
                end
            )
        )
    end
    table.insert(
        progressStats,
        StatisticsOrganizer.createCountedStatistic(
            runHashes,
            "Won",
            function(runHash)
                return pastRuns[runHash].getProgress() == 2
            end
        )
    )
    return progressStats
end

local function createBSTRangeStats(runHashes, pastRuns, forEnemy)
    local BSTRangeStats = {}
    local ranges = {
        {"< 300", 0, 299},
        {"300 - 399", 300, 399},
        {"400 - 499", 400, 499},
        {"500+", 500, 800}
    }
    for _, rangeInfo in pairs(ranges) do
        local statName, lowEnd, highEnd = rangeInfo[1], rangeInfo[2], rangeInfo[3]
        table.insert(
            BSTRangeStats,
            StatisticsOrganizer.createCountedStatistic(
                runHashes,
                statName,
                function(runHash)
                    local run = pastRuns[runHash]
                    local pokemon = run.getFaintedPokemon()
                    if forEnemy then
                        pokemon = run.getEnemyPokemon()
                    end
                    return tonumber(pokemon.bst) >= lowEnd and tonumber(pokemon.bst) <= highEnd
                end
            )
        )
    end
    return BSTRangeStats
end

local function createPokemonTypeStats(pastRuns, runHashes, forEnemy)
    local title = "Types You Ran"
    if forEnemy then
        title = "Types You Lost to"
    end
    return StatisticsOrganizer.createAttributeStatistic(
        runHashes,
        title,
        function(runHash)
            local types = pastRuns[runHash].getFaintedPokemon().type
            if forEnemy then
                types = pastRuns[runHash].getEnemyPokemon().type
            end
            local newTypes = {}
            for i, pokemonType in pairs(types) do
                if pokemonType ~= "" then
                    table.insert(newTypes, MiscUtils.toTitleCase(pokemonType))
                end
            end
            return newTypes
        end
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

function StatisticsOrganizer.createPastRunStatistics(seedLogger)
    local pastRuns = seedLogger.getPastRuns()
    local runHashes = seedLogger.getPastRunHashesNewestFirst()
    local statistics = {}
    table.insert(statistics, {"Overall Progress", createRunProgressStatistic(runHashes, pastRuns)})

    table.insert(statistics, {"BST Ranges You Ran", createBSTRangeStats(runHashes, pastRuns, false)})
    table.insert(statistics, {"BST Ranges You Lost to", createBSTRangeStats(runHashes, pastRuns, true)})

    table.insert(statistics, createPokemonTypeStats(pastRuns, runHashes, false))

    table.insert(statistics, createPokemonTypeStats(pastRuns, runHashes, true))

    table.insert(
        statistics,
        StatisticsOrganizer.createAttributeStatistic(
            runHashes,
            "Pok" .. MiscConstants.accentedE .. "mon You Ran",
            function(runHash)
                return pastRuns[runHash].getFaintedPokemon().name
            end
        )
    )

    table.insert(
        statistics,
        StatisticsOrganizer.createAttributeStatistic(
            runHashes,
            "Pok" .. MiscConstants.accentedE .. "mon You Lost to",
            function(runHash)
                return pastRuns[runHash].getEnemyPokemon().name
            end
        )
    )

    table.insert(
        statistics,
        StatisticsOrganizer.createAttributeStatistic(
            runHashes,
            "Moves You Had",
            function(runHash)
                local pokemon = pastRuns[runHash].getFaintedPokemon()
                local moveNames = {}
                for _, moveID in pairs(pokemon.moveIDs) do
                    table.insert(moveNames, MoveData.MOVES[moveID + 1].name)
                end
                return moveNames
            end
        )
    )

    table.insert(
        statistics,
        StatisticsOrganizer.createAttributeStatistic(
            runHashes,
            "Moves You Lost to",
            function(runHash)
                local pokemon = pastRuns[runHash].getEnemyPokemon()
                local moveNames = {}
                for _, moveID in pairs(pokemon.moveIDs) do
                    table.insert(moveNames, MoveData.MOVES[moveID + 1].name)
                end
                return moveNames
            end
        )
    )

    table.insert(
        statistics,
        StatisticsOrganizer.createAttributeStatistic(
            runHashes,
            "Abilities You Had",
            function(runHash)
                return AbilityData.ABILITIES[pastRuns[runHash].getFaintedPokemon().ability + 1].name
            end
        )
    )

    table.insert(
        statistics,
        StatisticsOrganizer.createAttributeStatistic(
            runHashes,
            "Abilities You Lost to",
            function(runHash)
                return AbilityData.ABILITIES[pastRuns[runHash].getEnemyPokemon().ability + 1].name
            end
        )
    )

    for i, statistic in pairs(statistics) do
        statistics[i] = capAt10(statistic)
    end

    return statistics
end

StatisticsOrganizer = {}

StatisticsOrganizer.STAT_SPREADS = {
    SPECIAL_ATTACKER = {HP = 0, ATK = 255, DEF = 0, SPA = 0, SPD = 0, SPE = 255},
    PHYSICAL_ATTACKER = {HP = 0, ATK = 0.6, DEF = 0, SPA = 0, SPD = 0, SPE = 0.4},
    WALL = {HP = 255, ATK = 0, DEF = 255, SPA = 0, SPD = 255, SPE = 0}
}

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
    local total = countTotalWithCondition(conditionFunction)
    return {statisticName, total}
end

--attribute statistic is something like "most common types"
function StatisticsOrganizer.createAttributeStatistic(dataSet, attributeReturningFunction)
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
    return sortAttributeCounts(counts)
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
    for i = 1,10,1 do
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
        {"Bulkiest Overall", {"HP","DEF","SPD"}, true},
        {"Most Frail", {"HP","DEF","SPD"}, false},
    }
    local data = {}
    for _, statisticSet in pairs(statisticsSets) do
        local name, args, descending = statisticSet[1], statisticSet[2], statisticSet[3]
        table.insert(data, 
            {name, createStatBasedStatistic(ids, logPokemon, args, descending)}
    )
    end
    return data
end

local function StatisticsOrganizer()
    local self = {}
    local pastRuns = {}
    local pastRunKeys = {}

    local function updateKeySet()
        for hash, info in pairs(pastRuns) do
            table.insert(pastRunKeys, hash)
        end
    end

    local function countTotalWithCondition(conditionFunction)
        local count = 0
        for hash, info in pairs(pastRuns) do
            if conditionFunction(info) then
                print(info.getFaintedPokemon().bst)
                count = count + 1
            end
        end
        return count
    end 

    local function sortAttributeCounts(attributeCountList)
        local sortedList = {}
        local keys = {}
        for key, count in pairs(attributeCountList) do
            table.insert(keys,key)
        end
        table.sort(keys, function(keyA,keyB)
            if attributeCountList[keyA] == attributeCountList[keyB] then
                return keyA < keyB
            end
            return attributeCountList[keyA] > attributeCountList[keyB]
        end)
        for _, key in pairs(keys) do
            table.insert(sortedList, {key,attributeCountList[key]})
        end
        return sortedList
    end

    function self.updatePastRuns(newPastRuns)
        pastRuns = newPastRuns
        updateKeySet()
    end

    --counted statistic is something like "how many mons are in the BST range of 400-500"
    function self.createNewCountedStatistic(statisticName, conditionFunction)
        local total = countTotalWithCondition(conditionFunction)
        print(total)
        return {statisticName, total}
    end
    
    --attribute statistic is something like "most common types"
    function self.createNewAttributeStatistic(statisticName, attributeReturningFunction)
        local counts = {}
        for hash, seedInfo in pairs(pastRuns) do
            local attributeValue = attributeReturningFunction(seedInfo)
            if counts[attributeValue] == nil then
                counts[attributeValue] = 0
            end
            counts[attributeValue] = counts[attributeValue] + 1
        end
        local sortedList = sortAttributeCounts(counts)
        for _, thing in pairs(sortedList) do
            print(thing[1], thing[2])
        end
        print(sortedList)
    end
    
    return self
end

return StatisticsOrganizer
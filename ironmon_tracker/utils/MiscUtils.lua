MiscUtils = {}

function MiscUtils.inlineIf(condition, T, F)
    if condition then
        return T
    else
        return F
    end
end

function MiscUtils.readOnly(t)
    local proxy = {}
    local metatable = {
        __index = t,
        __newindex = function()
            error("attempt to update a read-only table", 2)
        end
    }
    setmetatable(proxy, metatable)
    return proxy
end

function MiscUtils.boolToNumber(value)
    return value and 1 or 0
end

function MiscUtils.numberToBool(value)
    if value == 1 then
        return true
    end
    return false
end

function MiscUtils.decreaseTableIndex(index, size)
    return ((index + size - 2) % size) + 1
end

function MiscUtils.increaseTableIndex(index, size)
    return (index % size) + 1
end

function MiscUtils.trimWhitespace(input)
    return input:gsub("^%s*(.-)%s*$", "%1")
end

function MiscUtils.split(s, delimiter, trimWhitespace)
    local result = {}
    for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
        if trimWhitespace then
            match = MiscUtils.trimWhitespace(match)
        end
        table.insert(result, match)
    end
    return result
end

function MiscUtils.sortPokemonIDsByName(ids)
    table.sort(
        ids,
        function(k1, k2)
            return PokemonData.POKEMON[k1 + 1].name < PokemonData.POKEMON[k2 + 1].name
        end
    )
end

function MiscUtils.getSortedKeysByName(dataGroup)
    local ids = {}
    for id, _ in pairs(dataGroup) do
        if id ~= 1 then
            table.insert(ids, id - 1)
        end
    end
    table.sort(
        ids,
        function(k1, k2)
            return dataGroup[k1 + 1].name:lower() < dataGroup[k2 + 1].name:lower()
        end
    )
    return ids
end

function MiscUtils.splitIDsByMaximumPixelLength(ids, dataGroup, maxPixelLength, spacing)
    local sets = {}
    local currentSet = {}
    local currentLength = 0
    for _, id in pairs(ids) do
        local name = dataGroup[id + 1].name
        local addedLength = DrawingUtils.calculateWordPixelLength(name) + spacing
        currentLength = currentLength + addedLength
        if currentLength > maxPixelLength then
            currentLength = addedLength
            table.insert(sets, MiscUtils.deepCopy(currentSet))
            currentSet = {}
        end
        table.insert(currentSet, id)
    end
    if #currentSet ~= 0 then
        table.insert(sets, MiscUtils.deepCopy(currentSet))
    end
    return sets
end

function MiscUtils.shallowCopy(original)
    local copy = {}
    for key, value in pairs(original) do
        copy[key] = value
    end
    return copy
end

function MiscUtils.tableContains(table, value)
    for _, item in pairs(table) do
        if item == value then
            return true
        end
    end
    return false
end

function MiscUtils.mouseInRange(mouseX, mouseY, controlX, controlY, width, height)
    if mouseX >= controlX and mouseX <= controlX + width then
        if mouseY >= controlY and mouseY <= controlY + height then
            return true
        end
    end
    return false
end

function MiscUtils.round(number)
    return math.floor(number + 0.5)
end

function MiscUtils.convertTrainerGroupsToSortedIndices(trainerGroups)
    local sortedIndices = {}
    for groupIndex, trainerGroup in pairs(trainerGroups) do
        local battles = trainerGroup.battles
        for index, battle in pairs(battles) do
            local battleName = battle.name
            --basically for numbering each rival fight, e.g. "Bianca 1", "Bianca 2", etc.
            if trainerGroup.trainerType == TrainerData.TRAINER_TYPES.RIVAL then
                battleName = battleName .. " " .. index
            end
            local imageName = battle.name
            table.insert(
                sortedIndices,
                {
                    ["battleName"] = battleName,
                    ["imageName"] = imageName,
                    ["battle"] = battle,
                    ["groupIndex"] = groupIndex
                }
            )
        end
    end
    table.sort(
        sortedIndices,
        function(entry1, entry2)
            return entry1.battleName < entry2.battleName
        end
    )
    return sortedIndices
end

function MiscUtils.splitTableByNumber(tbl, number)
    local sets = {}
    local currentSet = {}
    for index, val in pairs(tbl) do
        if #currentSet == number then
            table.insert(sets, MiscUtils.deepCopy(currentSet))
            currentSet = {}
        end
        table.insert(currentSet, val)
    end
    if #currentSet ~= 0 then
        table.insert(sets, MiscUtils.deepCopy(currentSet))
    end
    return sets
end

function MiscUtils.runExecuteCommand(command, errorOutput)
    local prependDir = ""
    if Paths.CURRENT_DIRECTORY ~= nil and Paths.CURRENT_DIRECTORY ~= "" then
        prependDir = Paths.CURRENT_DIRECTORY .. "/"
    end

    local tempFile = prependDir .. "ironmon_tracker/commandResult.txt"
    local completeCommand = string.format('%s 1>"%s"', command, tempFile)
    if errorOutput then
        completeCommand = string.format('%s 2>"%s"', completeCommand, errorOutput)
    end
    os.execute(completeCommand)
    if FormsUtils.fileExists(tempFile) then
        return table.concat(MiscUtils.readLinesFromFile(tempFile), "")
    end
    return nil
end

function MiscUtils.deepCopy(o, seen)
    seen = seen or {}
    if o == nil then
        return nil
    end
    if seen[o] then
        return seen[o]
    end

    local no
    if type(o) == "table" then
        no = {}
        seen[o] = no

        for k, v in next, o, nil do
            no[MiscUtils.deepCopy(k, seen)] = MiscUtils.deepCopy(v, seen)
        end
        setmetatable(no, MiscUtils.deepCopy(getmetatable(o), seen))
    else -- number, string, boolean, etc
        no = o
    end
    return no
end

function MiscUtils.randomTableValue(t)
    return t[math.random(#t)]
end

function MiscUtils.removeRandomTableValue(t)
    local randomIndex = math.random(#t)
    local value = t[randomIndex]
    table.remove(t, randomIndex)
    return value
end

function MiscUtils.copyFile(file, destinationPath)
    local fileToCopy = io.open(file, "rb")
    if fileToCopy == nil then
        return
    end
    local destination = io.open(destinationPath, "wb")
    if destination == nil then
        return
    end
    local contents = fileToCopy:read("*a")
    destination:write(contents)

    fileToCopy:close()
    destination:close()
end

function MiscUtils.validPokemonData(pokemonData)
    if pokemonData == nil or next(pokemonData) == nil then
        return false
    end
    --Sometimes the player's pokemon stats are just wildly out of bounds, need a sanity check.
    local STAT_LIMIT = 2000
    local statsToCheck = {
        pokemonData.curHP,
        pokemonData.stats.HP,
        pokemonData.stats.ATK,
        pokemonData.stats.SPE,
        pokemonData.stats.DEF,
        pokemonData.stats.SPD,
        pokemonData.stats.SPA
    }
    for _, stat in pairs(statsToCheck) do
        if stat > STAT_LIMIT then
            return false
        end
    end
    local id = tonumber(pokemonData.pokemonID)
    local heldItem = tonumber(pokemonData.heldItem)
    if id == nil or pokemonData.level > 100 or not AbilityData.ABILITIES[pokemonData.ability+1] then
        return false
    end
    if not PokemonData.POKEMON[id + 1] or heldItem > 650 then
        return false
    end
    for _, move in pairs(pokemonData.moveIDs) do
        if not MoveData.MOVES[move + 1] then
            return false
        end
    end
    return true
end

function MiscUtils.splitStringByAmount(input, amount)
    local result = {}
    local current = 0
    local currentString = ""
    for i = 1, #input, 1 do
        local char = input:sub(i, i)
        currentString = currentString .. char
        current = current + 1
        if current == amount then
            table.insert(result, currentString)
            current = 0
            currentString = ""
        end
    end
    if currentString ~= "" then
        table.insert(result, currentString)
    end
    return result
end

function MiscUtils.combineTables(t1, t2)
    for _, value in pairs(t2) do
        table.insert(t1, value)
    end
end

function MiscUtils.toTitleCase(input)
    return input:sub(1, 1):upper() .. input:sub(2):lower()
end

function MiscUtils.appendStringToFile(fileName, stringData)
    local file = io.open(fileName, "a")
    if file ~= nil then
        file:write(stringData)
        file:close()
    end
end

function MiscUtils.readLinesFromFile(file, allowNewLines)
    local lines = {}

    local file = io.open(file, "r")
    if file == nil then
        return lines
    end

    allowNewLines = allowNewLines or false
    local char = "+"
    if allowNewLines then
        char = "*"
    end
    local fileContents = file:read("*a")
    if fileContents ~= nil and fileContents ~= "" then
        for line in fileContents:gmatch("([^\r\n]" .. char .. ")\r?\n") do
            if line ~= nil then
                table.insert(lines, line)
            end
        end
    end
    file:close()
    return lines
end

local function calculateFluctuatingAtLevel(level)
    if level < 15 then
        return math.floor((level ^ 3 * (((level + 1) / 3) + 24)) / 50)
    elseif level < 36 then
        return math.floor((level ^ 3 * (level + 14)) / 50)
    elseif level < 100 then
        return math.floor((level ^ 3 * ((level / 2) + 32)) / 50)
    end
    return 0
end

function MiscUtils.calculateExperiencePercent(level, currentExperience)
    if currentExperience == 0 then
        return 0
    end
    local nextLevel = level + 1
    local expAtCurrent = calculateFluctuatingAtLevel(level)
    local expAtNextLevel = calculateFluctuatingAtLevel(nextLevel)
    return (currentExperience - expAtCurrent) / (expAtNextLevel - expAtCurrent)
end

function MiscUtils.readStringFromFile(fileName)
    if FormsUtils.fileExists(fileName) then
        local file = io.open(fileName, "r")
        if file == nil then
            return
        end
        local contents = file:read("*a")
        file:close()
        return contents
    end
end

function MiscUtils.writeStringToFile(fileName, input)
    local file = io.open(fileName, "w")
    if file ~= nil then
        file:write(input)
        file:close()
    end
end

function MiscUtils.saveTableToFile(fileName, tableData)
    local file = io.open(fileName, "w")
    if file ~= nil then
        local data = Pickle.pickle(tableData)
        file:write(data)
        file:close()
    end
end

function MiscUtils.getTableFromFile(fileName)
    local file = io.open(fileName, "r")
    if file ~= nil then
        local fileContents = file:read("*a")
        file:close()
        local savedData
        if fileContents ~= nil and fileContents ~= "" then
            savedData = Pickle.unpickle(fileContents)
            return savedData
        end
    end
end

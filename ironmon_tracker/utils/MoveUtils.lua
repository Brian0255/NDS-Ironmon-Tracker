MoveUtils = {}

function MoveUtils.calculateLevelRangeOfMove(levelIndex, learnSet)
    local startLevel = learnSet[levelIndex].level
    local endLevel = 100
    local indexThatReplaces = levelIndex + 4
    if learnSet[indexThatReplaces] then
        local replacementLevel = learnSet[indexThatReplaces].level
        endLevel = replacementLevel - 1
    end
    if endLevel < startLevel then
        endLevel = startLevel
    end
    return "Lv. " .. startLevel .. " - " .. endLevel
end

function MoveUtils.netEffectiveness(move, pkmnData, isEnemy, hiddenPowerType)
    local NO_EFFECT_PAIRINGS = {
        [PokemonData.POKEMON_TYPES.NORMAL] = PokemonData.POKEMON_TYPES.GHOST,
        [PokemonData.POKEMON_TYPES.FIGHTING] = PokemonData.POKEMON_TYPES.GHOST,
        [PokemonData.POKEMON_TYPES.PSYCHIC] = PokemonData.POKEMON_TYPES.DARK,
        [PokemonData.POKEMON_TYPES.GROUND] = PokemonData.POKEMON_TYPES.FLYING,
        [PokemonData.POKEMON_TYPES.GHOST] = PokemonData.POKEMON_TYPES.NORMAL,
        [PokemonData.POKEMON_TYPES.POISON] = PokemonData.POKEMON_TYPES.STEEL
    }
    if move.power == Graphics.TEXT.NO_POWER then
        if move.category ~= MoveData.MOVE_CATEGORIES.STATUS or move.type == PokemonData.POKEMON_TYPES.POISON then
            if NO_EFFECT_PAIRINGS[move.type] then
                local noEffectAgainst = NO_EFFECT_PAIRINGS[move.type]
                if pkmnData.type[1] == noEffectAgainst or pkmnData.type[2] == noEffectAgainst then
                    return 0.0
                end
            end
        end
        return 1.0
    end
    if move.name == "Future Sight" or move.name == "Doom Desire" and move.accuracy == 100 then
        return 1.0
    end
    local effectiveness = 1.0
    for _, type in ipairs(pkmnData["type"]) do
        local moveType = move.type
        if move.name == "Hidden Power" and not isEnemy then
            moveType = hiddenPowerType
        end
        if move.name == "Judgment" and not isEnemy and PokemonData.PLATE_TO_TYPE[tonumber(pkmnData.heldItem)] ~= nil then
            moveType = PokemonData.PLATE_TO_TYPE[tonumber(pkmnData.heldItem)]
        end
        if moveType ~= "---" then
            if MoveData.EFFECTIVE_DATA[moveType][type] ~= nil then
                effectiveness = effectiveness * MoveData.EFFECTIVE_DATA[moveType][type]
            end
        end
    end
    return effectiveness
end

local function getMovesLearnedSince(pokemon)
    local pokemonLevel = pokemon.level
    local movesLearnedSince = {0, 0, 0, 0}
    local movelvls = pokemon.movelvls
    for _, level in pairs(movelvls) do
        for i, move in pairs(pokemon.moves) do
            if level > move.level and level <= pokemonLevel then
                movesLearnedSince[i] = movesLearnedSince[i] + 1
            end
        end
    end
    return movesLearnedSince
end

local function getMoveAgeRanks(pokemon)
    local moveAgeRanks = {1, 1, 1, 1}
    for i, move in pairs(pokemon.moves) do
        for j, compare in pairs(pokemon.moves) do
            if i ~= j then
                if move.level > compare.level then
                    moveAgeRanks[i] = moveAgeRanks[i] + 1
                end
            end
        end
    end
    return moveAgeRanks
end

function MoveUtils.calculateEnemyPPs(enemyPokemon, trackedMoves, showEnemyPP)
    local moveIDs = {}
    local movePPs = {}

    for i, move in pairs(trackedMoves) do
        moveIDs[i] = move.move
        movePPs[i] = MoveData.MOVES[move.move + 1].pp
    end

    if showEnemyPP then
        for i, move in pairs(moveIDs) do
            for j, compare in pairs(enemyPokemon.moveIDs) do
                if move == compare then
                    movePPs[i] = enemyPokemon.movePPs[j]
                    if move == 0 then
                        movePPs[i] = Graphics.TEXT.NO_PP
                    end
                end
            end
        end
    end

    return {
        ["moveIDs"] = moveIDs,
        ["movePPs"] = movePPs
    }
end

function MoveUtils.getStars(pokemon)
    local stars = {"", "", "", ""}
    local ageRanks = getMoveAgeRanks(pokemon)
    local movesLearnedSince = getMovesLearnedSince(pokemon)
    for i, move in pairs(pokemon.moves) do
        if move.level ~= 1 and movesLearnedSince[i] >= ageRanks[i] then
            stars[i] = "*"
        end
    end
    return stars
end

function MoveUtils.getMovesLearned(movelvls, pokemonLevel)
    local markings = {}
    for i, movelvl in pairs(movelvls) do
        markings[movelvl] = (pokemonLevel >= movelvl)
    end
    return markings
end

function MoveUtils.getMoveHeader(pokemon)
    local count = 0
    for _, moveLevel in pairs(pokemon.movelvls) do
        if moveLevel <= pokemon.level then
            count = count + 1
        else
            break
        end
    end
    local extra = ""
    if count ~= #pokemon.movelvls then
        extra = " (" .. pokemon.movelvls[count + 1] .. ")"
    end
    local header = "Moves: " .. count .. "/" .. #pokemon.movelvls .. extra
    return header
end

function MoveUtils.calculateVariableDamage(moveName, movePPs, index, currentPokemon, opposingPokemon, isEnemy, inBattle)
    local lowHPCalcEntry = {
        requirement = not isEnemy,
        calcFunction = function()
            return MoveUtils.calculateLowHPBasedDamage(currentPokemon.curHP, currentPokemon.stats.HP)
        end
    }
    local highHPCalcEntry = {
        requirement = not isEnemy,
        calcFunction = function()
            return MoveUtils.calculateHighHPBasedDamage(currentPokemon.curHP, currentPokemon.stats.HP)
        end
    }
    local weightBasedEntry = {
        requirement = inBattle and opposingPokemon ~= nil,
        calcFunction = function()
            return MoveUtils.calculateWeightBasedDamage(opposingPokemon.weight)
        end
    }
    local weightDifferenceEntry = {
        requirement = inBattle and opposingPokemon ~= nil,
        calcFunction = function()
            return MoveUtils.calculateWeightDifferenceDamage(currentPokemon, opposingPokemon)
        end
    }
    local moveNamesToCalcFunctions = {
        ["Flail"] = lowHPCalcEntry,
        ["Reversal"] = lowHPCalcEntry,
        ["Water Spout"] = highHPCalcEntry,
        ["Eruption"] = highHPCalcEntry,
        ["Trump Card"] = {
            requirement = true,
            calcFunction = function(movePP)
                return MoveUtils.calculateTrumpCardPower(movePP)
            end
        },
        ["Heat Crash"] = weightDifferenceEntry,
        ["Heavy Slam"] = weightDifferenceEntry,
        ["Punishment"] = {
            requirement = inBattle and opposingPokemon ~= nil,
            calcFunction = function()
                return MoveUtils.calculatePunishmentPower(opposingPokemon)
            end
        },
        ["Grass Knot"] = weightBasedEntry,
        ["Low Kick"] = weightBasedEntry
    }
    local entry = moveNamesToCalcFunctions[moveName]
    if entry then
        if moveName ~= "Trump Card" then
            if entry.requirement then
                return entry.calcFunction()
            end
        else
            return entry.calcFunction(movePPs[index])
        end
    end
end

function MoveUtils.calculateEnemyMovesAtLevel(learnSet, level)
    local movesLearned = {}
    for _, moveInfo in pairs(learnSet) do
        local moveID, moveLevel = moveInfo.move, moveInfo.level
        if moveLevel <= level then
            table.insert(movesLearned, moveID)
        end
    end
    if #movesLearned <= 4 then
        return movesLearned
    end
    local movesCurrently = {}
    local totalLearned = #movesLearned
    for i = totalLearned - 3, totalLearned, 1 do
        table.insert(movesCurrently, movesLearned[i])
    end
    return movesCurrently
end

function MoveUtils.getTypeDefensesTable(pokemonData)
    local EFFECTIVENESS_TO_SYMBOL = {
        [4.0] = "4x",
        [2.0] = "2x",
        [0.5] = "0.5x",
        [0.25] = "0.25x",
        [0.0] = "0x"
    }
    local typeDefenses = {
        ["4x"] = {},
        ["2x"] = {},
        ["0.5x"] = {},
        ["0.25x"] = {},
        ["0x"] = {}
    }
    --calculate how strong each type is against us
    for moveType, _ in pairs(MoveData.EFFECTIVE_DATA) do
        local effectiveness = 1.0
        for _, type in pairs(pokemonData.type) do
            if type ~= "" then
                if MoveData.EFFECTIVE_DATA[moveType][type] ~= nil then
                    effectiveness = effectiveness * MoveData.EFFECTIVE_DATA[moveType][type]
                end
            end
        end
        if EFFECTIVENESS_TO_SYMBOL[effectiveness] then
            local symbol = EFFECTIVENESS_TO_SYMBOL[effectiveness]
            table.insert(typeDefenses[symbol], moveType)
        end
    end
    return typeDefenses
end

function MoveUtils.isSTAB(move, pokemon, isEnemy, hiddenPowerType)
    for _, type in pairs(pokemon["type"]) do
        local moveType = move.type
        if move.name == "Hidden Power" and not isEnemy then
            moveType = hiddenPowerType
        end
        if move.name == "Judgment" and not isEnemy and PokemonData.PLATE_TO_TYPE[tonumber(pokemon.heldItem)] ~= nil then
            moveType = PokemonData.PLATE_TO_TYPE[tonumber(pokemon.heldItem)]
        end
        if move.power ~= Graphics.TEXT.NO_POWER and moveType == type then
            return true
        end
    end
    return false
end

function MoveUtils.calculateWeightBasedDamage(weight)
    if weight < 10.0 then
        return "20"
    elseif weight < 25.0 then
        return "40"
    elseif weight < 50.0 then
        return "60"
    elseif weight < 100.0 then
        return "80"
    elseif weight < 200.0 then
        return "100"
    else
        return "120"
    end
end

-- For Flail & Reversal
function MoveUtils.calculateLowHPBasedDamage(currentHP, maxHP)
    local percentHP = (currentHP / maxHP) * 100
    if percentHP < 4.17 then
        return "200"
    elseif percentHP < 10.42 then
        return "150"
    elseif percentHP < 20.83 then
        return "100"
    elseif percentHP < 35.42 then
        return "80"
    elseif percentHP < 68.75 then
        return "40"
    else
        return "20"
    end
end

-- For Water Spout & Eruption
function MoveUtils.calculateHighHPBasedDamage(currentHP, maxHP)
    local basePower = (150 * currentHP) / maxHP
    if basePower < 1 then
        basePower = 1
    end
    local roundedPower = math.floor(basePower + 0.5)
    return tostring(roundedPower)
end

function MoveUtils.calculateTrumpCardPower(movePP)
    movePP = tonumber(movePP)
    local ppToPower = {
        [0] = "0",
        [1] = "200",
        [2] = "80",
        [3] = "60",
        [4] = "50",
        [5] = "40"
    }
    if movePP > 5 then
        movePP = 5
    end
    return ppToPower[movePP]
end

function MoveUtils.calculatePunishmentPower(targetMon)
    local totalIncreasedStats = 0
    local statStages = targetMon.statStages
    if statStages == nil then
        return 60
    end
    for i, stat in pairs(statStages) do
        if stat > 6 then
            totalIncreasedStats = totalIncreasedStats + (stat - 6)
        end
    end
    local newPower = 60 + (20 * totalIncreasedStats)
    if newPower < 60 then
        newPower = 60
    end
    if newPower > 200 then
        newPower = 200
    end
    return newPower
end

function MoveUtils.calculateWringCrushDamage(gen, currentHP, maxHP)
    local basePower = 120 * (currentHP / maxHP)
    local roundedPower = math.floor(basePower + 0.5)
    if gen == 4 then
        roundedPower = roundedPower + 1
    else
        if roundedPower < 1 then
            roundedPower = 1
        end
    end
    return roundedPower
end

function MoveUtils.calculateWeightDifferenceDamage(currentMon, targetMon)
    local currentMonWeight = currentMon.weight
    local targetWeight = targetMon.weight
    local ratio = targetWeight / currentMonWeight
    if ratio <= .2 then
        return "120"
    elseif ratio <= .25 then
        return "100"
    elseif ratio <= .3334 then
        return "80"
    elseif ratio <= .50 then
        return "60"
    else
        return "40"
    end
end

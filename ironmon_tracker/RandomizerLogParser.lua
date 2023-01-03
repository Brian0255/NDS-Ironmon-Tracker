local function LogInfo(initialPokemonList, initialTrainers, initialTMs)
    local self = {}
    local pokemonList = initialPokemonList
    local trainers = initialTrainers
    local TMs = initialTMs
    function self.getPokemon()
        return pokemonList
    end
    function self.getTrainers()
        return trainers
    end
    function self.getTMs()
        return TMs
    end
    return self
end

local function RandomizerLogParser()
    local self = {}

    local moveIDMappings = {}
    local pokemonIDMappings = {}
    local abilityIDMappings = {}
    local itemIDMappings = {}

    local pokemonList = {}
    local trainers = {}
    local TMs = {}

    local function checkForNameReplacement(name)
        if self.LogParserConstants.NAME_REPLACEMENTS[name] then
            return self.LogParserConstants.NAME_REPLACEMENTS[name]
        end
        return name
    end

    local function parseRandomizedEvolutions(lines, lineStart)
        local currentLineIndex = lineStart
        while lines[currentLineIndex] ~= "" do
            local currentLine = lines[currentLineIndex]
            local lineSplit = MiscUtils.split(currentLine, "->", true)
            local pokemonName, evolutionList = lineSplit[1], lineSplit[2]
            pokemonName = checkForNameReplacement(pokemonName)
            local evolutions = {}
            --mr. mime is annoying, take out space after period then re-add it so the split works
            evolutionList = evolutionList:gsub("%. ", "%.")
            for _, evolutionData in pairs(MiscUtils.split(evolutionList, " ", true)) do
                local evolutionName = evolutionData:gsub(",", ""):gsub("%.", "%. ")
                evolutionName = checkForNameReplacement(evolutionName)
                if pokemonIDMappings[evolutionName] then
                    local evolutionID = pokemonIDMappings[evolutionName]
                    table.insert(evolutions, evolutionID)
                end
            end
            local pokemonID = pokemonIDMappings[pokemonName]
            pokemonList[pokemonID].evolutions = evolutions
            currentLineIndex = currentLineIndex + 1
        end
    end

    local function parseTrainers(lines, lineStart)
        local currentLineIndex = lineStart
        while lines[currentLineIndex] ~= "" do
            local currentLine = lines[currentLineIndex]
            local trainerTeam = {}
            local trainer, teamList = currentLine:match("(.*)%) %- (.*)")
            local trainerID = trainer:match("#(%d+)")
            local teamInfo = MiscUtils.split(teamList,",",true)
            for _, pokemonInfo in pairs(teamInfo) do
                local nameAndItem, level = pokemonInfo:match("(.*) Lv(%d+)")
                local nameItemSplit = MiscUtils.split(nameAndItem,"@",true)
                local heldItem = 1
                if nameItemSplit[2] ~= nil then
                    local heldItemName = nameItemSplit[2]
                    if not itemIDMappings[heldItemName] then
                        print(heldItemName)
                    else
                        heldItem = itemIDMappings[heldItemName]
                    end
                end
                local pokemonName = nameItemSplit[1]
                pokemonName = checkForNameReplacement(pokemonName)
                local pokemonID = pokemonIDMappings[pokemonName]
                local pokemon = {
                    ["pokemonID"] = pokemonID,
                    ["level"] = level,
                    ["heldItem"] = heldItem
                }
                table.insert(trainerTeam, pokemon)
            end
            trainers[trainerID] = trainerTeam
            currentLineIndex = currentLineIndex + 1
        end
    end

    local function parsePokemonLevelupMoves(lines, lineStart)
        local currentLineIndex = lineStart
        while lines[currentLineIndex] ~= "" do
            local currentLine = lines[currentLineIndex]
            local lineSplit = MiscUtils.split(currentLine, "->", true)
            local pokemonName = lineSplit[1]:match("%d+%s(.+)")
            pokemonName = checkForNameReplacement(pokemonName)
            local pokemonID = pokemonIDMappings[pokemonName]
            pokemonList[pokemonID].moves = {}
            --next 7 lines are not necessary, they're the base stats (which we grab elsewhere)
            currentLineIndex = currentLineIndex + 7
            while #MiscUtils.split(lines[currentLineIndex], ":", true) == 2 and lines[currentLineIndex] ~= "Egg Moves:" do
                currentLine = lines[currentLineIndex]
                local moveInfo = MiscUtils.split(currentLine, ":", true)
                local level = moveInfo[1]:match("%d+")
                local name = moveInfo[2]
                local id = moveIDMappings[name]
                table.insert(
                    pokemonList[pokemonID].moves,
                    {
                        ["move"] = id,
                        ["level"] = level
                    }
                )
                currentLineIndex = currentLineIndex + 1
            end
            while lines[currentLineIndex] ~= "" do
                currentLineIndex = currentLineIndex + 1
            end
            currentLineIndex = currentLineIndex + 1
        end
    end

    local function parseTMMoves(lines, lineStart)
        local currentLineIndex = lineStart
        while lines[currentLineIndex] ~= "" do
            local currentLine = lines[currentLineIndex]
            local moveName = currentLine:match("[%a%d]+ (.*)")
            local moveID = moveIDMappings[moveName]
            table.insert(TMs, moveID)
            currentLineIndex = currentLineIndex + 1
        end
    end

    local function parseTMCompatibility(lines, lineStart)
        local currentLineIndex = lineStart
        while lines[currentLineIndex] ~= "" do
            local currentLine = lines[currentLineIndex]
            local lineSplit = MiscUtils.split(currentLine, "|", true)
            local pokemonName = lineSplit[1]:match("%d+%s(.+)")
            pokemonName = checkForNameReplacement(pokemonName)
            local pokemonID = pokemonIDMappings[pokemonName]
            table.remove(lineSplit, 1)
            pokemonList[pokemonID].pokemonTMsLearnable = {}
            for index, TMInfo in pairs(lineSplit) do
                pokemonList[pokemonID].pokemonTMsLearnable[index] = (TMInfo ~= "-")
            end
            currentLineIndex = currentLineIndex + 1
        end
    end

    local function parsePokemon(lines, lineStart)
        local currentLineIndex = lineStart + 1
        while (lines[currentLineIndex] ~= nil and lines[currentLineIndex] ~= "") do
            local currentLine = lines[currentLineIndex]
            local pokemonData = MiscUtils.split(currentLine, "|", true)
            local pokemonName = pokemonData[2]
            pokemonName = checkForNameReplacement(pokemonName)
            local pokemonID = pokemonIDMappings[pokemonName]
            local pokemon = pokemonList[pokemonID]
            pokemon.stats = {
                HP = pokemonData[4],
                ATK = pokemonData[5],
                DEF = pokemonData[6],
                SPA = pokemonData[7],
                SPD = pokemonData[8],
                SPE = pokemonData[9]
            }
            local abilityNames = {pokemonData[10], pokemonData[11], pokemonData[12]}
            pokemon.abilities = {}
            for _, abilityName in pairs(abilityNames) do
                if abilityIDMappings[abilityName] ~= nil and abilityName ~= "--" then
                    table.insert(pokemon.abilities, abilityIDMappings[abilityName])
                end
            end
            currentLineIndex = currentLineIndex + 1
        end
    end

    self.LogParserConstants = {
        NAME_REPLACEMENTS = {
            ["Nidoran♀"] = "Nidoran M",
            ["Nidoran♂"] = "Nidoran F",
            ["Burmy"] = "Burmy P",
            ["Wormadam"] = "Wormadam P",
            ["Cherrim"] = "Cherrim O",
            ["Shellos"] = "Shellos W",
            ["Gastrodon"] = "Gastrodon W",
            ["Giratina"] = "Giratina A",
            ["Shaymin"] = "Shaymin L",
            ["Unfezant"] = "Unfezant M",
            ["Basculin"] = "Basculin R",
            ["Basculin-B"] = "Basculin B",
            ["Frillish"] = "Frillish M",
            ["Jellicent"] = "Jellicent M",
            ["Meloetta"] = "Meloetta A",
            ["Deoxys-A"] = "Deoxys A",
            ["Deoxys-D"] = "Deoxys D",
            ["Deoxys-S"] = "Deoxys S",
            ["Wormadam-S"] = "Wormadam S",
            ["Wormadam-T"] = "Wormadam T",
            ["Shaymin-S"] = "Shaymin S",
            ["Giratina-O"] = "Giratina O",
            ["Rotom-H"] = "Rotom Heat",
            ["Rotom-W"] = "Rotom Wash",
            ["Rotom-Fr"] = "Rotom Frost",
            ["Rotom-Fa"] = "Rotom Fan",
            ["Rotom-M"] = "Rotom Mow",
            ["Castform-F"] = "Castform F",
            ["Castform-W"] = "Castform R",
            ["Castform-I"] = "Castform S",
            ["Darmanitan-Z"] = "Darmanitan Z",
            ["Meloetta-P"] = "Meloetta P"
        },
        SECTION_HEADER_TO_PARSE_FUNCTION = {
            ["--Pokemon Base Stats & Types--"] = parsePokemon,
            ["--Pokemon Movesets--"] = parsePokemonLevelupMoves,
            ["--Randomized Evolutions--"] = parseRandomizedEvolutions,
            ["--TM Moves--"] = parseTMMoves,
            ["--TM Compatibility--"] = parseTMCompatibility,
            ["--Trainers Pokemon--"] = parseTrainers
        }
    }

    local function setUpMappings()
        for id, pokemon in pairs(PokemonData.POKEMON) do
            pokemonIDMappings[pokemon.name] = id
            pokemonList[id] = {}
        end
        for _, abilityInfo in pairs(AbilityData.ABILITIES) do
            abilityIDMappings[abilityInfo.name] = abilityInfo.id
        end
        for _, moveInfo in pairs(MoveData.MOVES) do
            moveIDMappings[moveInfo.name] = tonumber(moveInfo.id)
        end
        for id, itemInfo in pairs(ItemData.ITEMS) do
            itemIDMappings[itemInfo.name] = id
        end
    end

    function self.parse(inputFile)
        if MiscUtils.fileExists(inputFile) then
            pokemonList = {}
            trainers = {}
            TMs = {}
            local lines = {}
            for line in io.lines(inputFile) do
                table.insert(lines, line)
            end
            for index, line in pairs(lines) do
                if self.LogParserConstants.SECTION_HEADER_TO_PARSE_FUNCTION[line] then
                    local parseFunction = self.LogParserConstants.SECTION_HEADER_TO_PARSE_FUNCTION[line]
                    parseFunction(lines, index + 1)
                end
            end
            return LogInfo(pokemonList, trainers, TMs)
        end
    end

    setUpMappings()

    return self
end

return RandomizerLogParser

local function LogInfo(
    initialPokemonList,
    initialTrainers,
    initialTMs,
    initialStarterNumber,
    initialMiscInfo,
    initialStarters)
    local self = {}
    local pokemonList = initialPokemonList
    local trainers = initialTrainers
    local TMs = initialTMs
    local starters = initialStarters
    local miscInfo = initialMiscInfo
    local starterNumber = 1

    function self.setStarterNumberFromPlayerPokemonID(id)
        starterNumber = 1
        if starters[id] then
            starterNumber = starters[id]
        end
    end

    function self.getStarterNumber()
        return starterNumber
    end

    function self.getPokemon()
        return pokemonList
    end

    function self.getTrainers()
        return trainers
    end

    function self.getTMs()
        return TMs
    end

    function self.getMappings()
    end

    function self.getMiscInfo()
        return miscInfo
    end

    return self
end

local function RandomizerLogParser(initialProgram)
    local self = {}

    local moveIDMappings = {}
    local pokemonIDMappings = {}
    local abilityIDMappings = {}
    local itemIDMappings = {}

    local program = initialProgram
    local pokemonList = {}
    local trainers = {}
    local TMs = {}
    local starters = {}
    local totalLines

    local function parseRandomizedEvolutions(lines, lineStart)
        local currentLineIndex = lineStart
        while lines[currentLineIndex] ~= "" and currentLineIndex <= totalLines do
            local currentLine = lines[currentLineIndex]
            local lineSplit = MiscUtils.split(currentLine, "->", true)
            local pokemonName, evolutionList = lineSplit[1], lineSplit[2]
            pokemonName = pokemonName:lower()
            local evolutions = {}
            --mr. mime is annoying, take out space after period then re-add it so the split works
            evolutionList = evolutionList:gsub("%. ", ".")
            for _, evolutionData in pairs(MiscUtils.split(evolutionList, " ", true)) do
                local evolutionName = evolutionData:gsub(",", ""):gsub("%.", ". ")
                evolutionName = evolutionName:lower()
                if pokemonIDMappings[evolutionName] then
                    local evolutionID = pokemonIDMappings[evolutionName]
                    table.insert(evolutions, evolutionID)
                end
            end
            local pokemonID = pokemonIDMappings[pokemonName]
            pokemonList[pokemonID].evolutions = evolutions
            currentLineIndex = currentLineIndex + 1
        end
        return true
    end

    local function readPokemonIntoTeam(pokemonInfo, trainerTeam, trainerID)
        local nameAndItem, level = pokemonInfo:match("(.*) Lv(%d+)")
        local nameItemSplit = MiscUtils.split(nameAndItem, "@", true)
        local heldItem = nil
        if nameItemSplit[2] ~= nil then
            local heldItemName = nameItemSplit[2]
            if itemIDMappings[heldItemName] then
                heldItem = itemIDMappings[heldItemName]
            end
        end
        local pokemonName = nameItemSplit[1]
        pokemonName = pokemonName:lower()
        local pokemonID = pokemonIDMappings[pokemonName]
        local pokemon = {
            ["pokemonID"] = pokemonID,
            ["level"] = tonumber(level),
            ["heldItem"] = tonumber(heldItem)
        }
        table.insert(trainerTeam, pokemon)
    end

    local function parseTrainers(lines, lineStart)
        local currentLineIndex = lineStart
        while lines[currentLineIndex] ~= "" and currentLineIndex <= totalLines do
            local currentLine = lines[currentLineIndex]
            local trainerTeam = {}
            local trainer, teamList = currentLine:match("(.*)%).*%- (.*)")
            local trainerID = tonumber(trainer:match("#(%d+)"))
            local teamInfo = MiscUtils.split(teamList, ",", true)
            for _, pokemonInfo in pairs(teamInfo) do
                readPokemonIntoTeam(pokemonInfo, trainerTeam, trainerID)
            end
            if trainerID ~= nil then
                trainers[trainerID] = trainerTeam
            end
            currentLineIndex = currentLineIndex + 1
        end
        return true
    end

    local function parsePokemonLevelupMoves(lines, lineStart)
        local currentLineIndex = lineStart
        while lines[currentLineIndex] ~= "" and currentLineIndex <= totalLines do
            local currentLine = lines[currentLineIndex]
            local lineSplit = MiscUtils.split(currentLine, "->", true)
            local pokemonName = lineSplit[1]:match("%d+%s(.+)")
            pokemonName = pokemonName:lower()
            local pokemonID = pokemonIDMappings[pokemonName]
            pokemonList[pokemonID].moves = {}
            --next 7 lines are not necessary, they're the base stats (which we grab elsewhere)
            currentLineIndex = currentLineIndex + 7
            while #MiscUtils.split(lines[currentLineIndex], ":", true) == 2 and lines[currentLineIndex] ~= "Egg Moves:" and
                currentLineIndex <= totalLines do
                currentLine = lines[currentLineIndex]
                local moveInfo = MiscUtils.split(currentLine, ":", true)
                local level = moveInfo[1]:match("%d+")
                local name = moveInfo[2]
                local id = moveIDMappings[name]
                table.insert(
                    pokemonList[pokemonID].moves,
                    {
                        ["move"] = id,
                        ["level"] = tonumber(level)
                    }
                )
                currentLineIndex = currentLineIndex + 1
            end
            while lines[currentLineIndex] ~= "" and currentLineIndex <= totalLines do
                currentLineIndex = currentLineIndex + 1
            end
            currentLineIndex = currentLineIndex + 1
        end
        return true
    end

    local function parseTMMoves(lines, lineStart)
        local currentLineIndex = lineStart
        while lines[currentLineIndex] ~= "" and currentLineIndex <= totalLines do
            local currentLine = lines[currentLineIndex]
            local moveName = currentLine:match("[%a%d]+ (.*)")
            local moveID = moveIDMappings[moveName]
            table.insert(TMs, moveID)
            currentLineIndex = currentLineIndex + 1
        end
        return true
    end

    local function parseTMCompatibility(lines, lineStart)
        local currentLineIndex = lineStart
        while lines[currentLineIndex] ~= "" and currentLineIndex <= totalLines do
            local currentLine = lines[currentLineIndex]
            local lineSplit = MiscUtils.split(currentLine, "|", true)
            local pokemonName = lineSplit[1]:match("%d+%s(.+)")
            local pokemonID = pokemonIDMappings[pokemonName:lower()]
            table.remove(lineSplit, 1)
            pokemonList[pokemonID].pokemonTMsLearnable = {}
            for index, TMInfo in pairs(lineSplit) do
                pokemonList[pokemonID].pokemonTMsLearnable[index] = (TMInfo ~= "-")
            end
            currentLineIndex = currentLineIndex + 1
        end
        return true
    end

    local function parseMiscInfo(lines)
        return {
            version = lines[1]:match("Randomizer Version: (.*)"),
            seed = lines[2]:match("Random Seed: (%d+)"),
            settingsString = lines[3]:match("Settings String: (.*)")
        }
    end

    local function parsePokemon(lines, lineStart)
        pokemonList = {}
        local currentLineIndex = lineStart + 1
        while (lines[currentLineIndex] ~= nil and lines[currentLineIndex] ~= "" and currentLineIndex <= totalLines) do
            local currentLine = lines[currentLineIndex]
            local pokemonData = MiscUtils.split(currentLine, "|", true)
            local pokemonID = tonumber(pokemonData[1])
            if pokemonID ~= nil then
                local pokemonName = pokemonData[2]
                pokemonName = pokemonName:lower()
                pokemonIDMappings[pokemonName] = pokemonID
                pokemonList[pokemonID] = {}
                local pokemon = pokemonList[pokemonID]
                pokemon.stats = {
                    HP = tonumber(pokemonData[4]),
                    ATK = tonumber(pokemonData[5]),
                    DEF = tonumber(pokemonData[6]),
                    SPA = tonumber(pokemonData[7]),
                    SPD = tonumber(pokemonData[8]),
                    SPE = tonumber(pokemonData[9])
                }
                pokemon.pokemonID = pokemonID
                program.addAdditionalDataToPokemon(pokemon)
                local abilityNames = {pokemonData[10], pokemonData[11], pokemonData[12]}
                pokemon.abilities = {}
                for _, abilityName in pairs(abilityNames) do
                    if abilityIDMappings[abilityName] ~= nil and abilityName ~= "--" then
                        table.insert(pokemon.abilities, abilityIDMappings[abilityName])
                    end
                end
            end
            currentLineIndex = currentLineIndex + 1
        end
        return true
    end

    local function parseMoveInfo(lines, lineStart)
        if lineStart ~= nil then
            moveIDMappings = {}
            --header below section name that we don't care about
            local currentLineIndex = lineStart + 1
            while (lines[currentLineIndex] ~= nil and lines[currentLineIndex] ~= "" and currentLineIndex <= totalLines) do
                local lineInfo = MiscUtils.split(lines[currentLineIndex], "|", true)
                local id, moveName = tonumber(lineInfo[1]), lineInfo[2]
                moveIDMappings[moveName] = id
                currentLineIndex = currentLineIndex + 1
            end
        end
    end

    local function checkGameName(lines, lineStart)
        local name = lines[lineStart]:match("Randomization of (Pokemon [%a%d ]+).* completed.")
        name = MiscUtils.trimWhitespace(name)
        local gameName = program.getGameInfo().NAME
        return gameName == name
    end

    local function parseStarterInfo(lines, lineStart)
        starters = {}
        for i = 0, 2, 1 do
            local starterLine = lines[lineStart + i]
            local number, name = starterLine:match("Set starter (%d+) to (.*)")
            name = name:lower()
            number = tonumber(number)
            starters[pokemonIDMappings[name]] = number
        end
    end

    self.LogParserConstants = {
        SECTION_HEADER_TO_PARSE_FUNCTION = {
            ["--Pokemon Base Stats & Types--"] = parsePokemon,
            ["--Pokemon Movesets--"] = parsePokemonLevelupMoves,
            ["--Randomized Evolutions--"] = parseRandomizedEvolutions,
            ["--TM Moves--"] = parseTMMoves,
            ["--TM Compatibility--"] = parseTMCompatibility,
            ["--Trainers Pokemon--"] = parseTrainers,
            ["--Move Data--"] = parseMoveInfo,
            ["------------------------------------------------------------------"] = checkGameName,
            ["--Random Starters--"] = parseStarterInfo,
            ["--Custom Starters--"] = parseStarterInfo
        },
        PREFERRED_PARSE_ORDER = {
            --game name
            "------------------------------------------------------------------",
            "--Move Data--",
            "--Pokemon Base Stats & Types--",
            "--Pokemon Movesets--",
            "--Randomized Evolutions--",
            "--TM Moves--",
            "--TM Compatibility--",
            "--Trainers Pokemon--",
            "--Random Starters--",
            "--Custom Starters--"
        }
    }

    local function resetPokemon()
        for id, pokemon in pairs(PokemonData.POKEMON) do
            pokemonIDMappings[pokemon.name:lower()] = id
            pokemonList[id] = {}
        end
    end

    local function setUpMappings()
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
        if FormsUtils.fileExists(inputFile) then
            resetPokemon()
            trainers = {}
            TMs = {}
            local lines = MiscUtils.readLinesFromFile(inputFile, true)
            totalLines = #lines
            local sectionHeaderStarts = {}
            local totalFound = 0
            for index, line in pairs(lines) do
                if self.LogParserConstants.SECTION_HEADER_TO_PARSE_FUNCTION[line] and not sectionHeaderStarts[line] then
                    sectionHeaderStarts[line] = index + 1
                    totalFound = totalFound + 1
                    if totalFound == #self.LogParserConstants.PREFERRED_PARSE_ORDER then
                        break
                    end
                end
            end
            for _, sectionName in pairs(self.LogParserConstants.PREFERRED_PARSE_ORDER) do
                local lineStart = sectionHeaderStarts[sectionName]
                if lineStart ~= nil then
                    local parseFunction = self.LogParserConstants.SECTION_HEADER_TO_PARSE_FUNCTION[sectionName]
                    local success = parseFunction(lines, lineStart)
                    if success == false then
                        forms.destroyall()
                        FormsUtils.popupDialog(
                            "Game does not match. Only load logs with the same game as the one you're playing.",
                            250,
                            120,
                            FormsUtils.POPUP_DIALOG_TYPES.WARNING,
                            true
                        )
                        return nil
                    end
                end
            end
            local miscInfo = parseMiscInfo(lines)
            return LogInfo(pokemonList, trainers, TMs, 1, miscInfo, starters)
        end
    end

    setUpMappings()

    return self
end

return RandomizerLogParser

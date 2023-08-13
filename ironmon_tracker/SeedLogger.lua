local function SeedLogger(initialProgram, initialGameName)
    local PastRun = dofile(Paths.FOLDERS.DATA_FOLDER .. "/PastRun.lua")

    local pastRuns = {}
    local self = {}

    local program = initialProgram
    local gameName = initialGameName
    local totalRuns = 0
    local totalRunsPastLab = 0
    local pastHashLogged = nil
    local pastRunKeyList = {}
    local pastRunStatistics

    local encodingConstants = {
        POKEMON_KEY_LIST = {
            "ability",
            "alternateForm",
            "curHP",
            "friendship",
            "heldItem",
            "isEgg",
            "isFemale",
            "level",
            "move1",
            "move2",
            "move3",
            "move4",
            "move1PP",
            "move2PP",
            "move3PP",
            "move4PP",
            "nature",
            "pid",
            "pokemonID",
            "HP",
            "ATK",
            "DEF",
            "SPA",
            "SPD",
            "SPE",
            "status"
        }
    }

    self.SORT_METHODS = {
        NEWEST = 0,
        OLDEST = 1,
        A_TO_Z = 2
    }

    local function figureOutCause(pastRun)
        local faintedPokemon, enemyPokemon = pastRun.getFaintedPokemon(), pastRun.getEnemyPokemon()
        local abilityName = AbilityData.ABILITIES[enemyPokemon.ability + 1].name
        local causeMappings = {
            [PlaythroughConstants.CAUSES.WON] = function()
                return pastRun.getProgress() == 2
            end,
            [PlaythroughConstants.CAUSES.SHEDINJA] = function()
                return enemyPokemon.name == "Shedinja"
            end,
            [PlaythroughConstants.CAUSES.IMPOSTER] = function()
                return abilityName == "Imposter"
            end,
            [PlaythroughConstants.CAUSES.ENEMY_LOWER_BST] = function()
                return (tonumber(faintedPokemon.bst) - tonumber(enemyPokemon.bst)) >= 100
            end
        }
        local cause = PlaythroughConstants.CAUSES.STANDARD
        for reason, causeSatisfied in pairs(causeMappings) do
            if causeSatisfied() then
                cause = reason
                --break out early in case of something like you being low BST and losing to Shedinja - Shedinja should override this\
                break
            end
        end
        return cause
    end

    function self.getRandomRunOverMessage(pastRun)
        local cause = figureOutCause(pastRun)
        local message = ""
        local enemyPokemon = pastRun.getEnemyPokemon()
        local enemyName = enemyPokemon.name
        local endings = {}
        local causeEntry = PlaythroughConstants.RUN_OVER_MESSAGES[cause]

        if cause ~= PlaythroughConstants.CAUSES.STANDARD then
            endings = MiscUtils.shallowCopy(causeEntry.messages)
        end

        local standardEndings = PlaythroughConstants.RUN_OVER_MESSAGES[PlaythroughConstants.CAUSES.STANDARD].messages
        if not causeEntry.exclusive then
            for _, messageToInsert in pairs(standardEndings) do
                table.insert(endings, messageToInsert)
            end
        end

        message = MiscUtils.removeRandomTableValue(endings)
        local labRate = string.format("%.2f", (totalRunsPastLab / totalRuns * 100))
        message = message:gsub("%%enemy%%", enemyName)
        message = message:gsub("%%totalruns%%", totalRuns)
        message = message:gsub("%%labrate%%", labRate .. "%")
        return message
    end

    local function filterPastRunsByBadgeCount(pastRunHashes, badgeCount)
        local newHashes = {}
        for _, hash in pairs(pastRunHashes) do
            local run = pastRuns[hash]
            if run.getBadgeCount() >= badgeCount then
                table.insert(newHashes, hash)
            end
        end
        return newHashes
    end

    function self.getTotalRunsPastLab()
        return totalRunsPastLab
    end

    function self.getTotalRuns()
        return totalRuns
    end

    --convert to comma separated values to save space (pickle will eat space and make past run loading slow)
    local function pokemonToCSV(pokemon)
        local CSV = ""
        for _, key in pairs(encodingConstants.POKEMON_KEY_LIST) do
            if not pokemon[key] then
                print(key)
                return nil
            end
            CSV = CSV .. pokemon[key] .. ","
        end
        CSV = CSV:sub(1, -2) .. "\n"
        return CSV
    end

    local function decodeCSVPokemon(input)
        local pokemonValues = MiscUtils.split(input, ",")
        local pokemon = {}
        for i, value in pairs(pokemonValues) do
            local key = encodingConstants.POKEMON_KEY_LIST[i]
            pokemon[key] = tonumber(value)
        end
        pokemon.moveIDs = {
            pokemon.move1,
            pokemon.move2,
            pokemon.move3,
            pokemon.move4
        }
        pokemon.movePPs = {
            pokemon.move1PP,
            pokemon.move2PP,
            pokemon.move3PP,
            pokemon.move4PP
        }
        pokemon.stats = {
            HP = pokemon.HP,
            ATK = pokemon.ATK,
            DEF = pokemon.DEF,
            SPA = pokemon.SPA,
            SPD = pokemon.SPD,
            SPE = pokemon.SPE
        }
        if not MiscUtils.validPokemonData(pokemon) then
            return nil
        end
		program.addAdditionalDataToPokemon(pokemon)
        return pokemon
    end

    local function decodeCSVBadgeSet(input)
        local badgeValues = MiscUtils.split(input, ",")
        local badges = {}
        for index, badgeValue in pairs(badgeValues) do
            badges[index] = tonumber(badgeValue)
        end
        return badges
    end

    local function badgeSetToCSV(badgeSet)
        local CSV = ""
        for _, badge in pairs(badgeSet) do
            CSV = CSV .. badge .. ","
        end
        CSV = CSV:sub(1, -2) .. "\n"
        return CSV
    end

    local function runToCSV(runHash, pastRun)
        local CSV = "log start\n"
        CSV = CSV .. runHash .. "\n"
        CSV = CSV .. pastRun.getDate() .. "," .. pastRun.getSeconds() .. "\n"
        CSV = CSV .. pokemonToCSV(pastRun.getFaintedPokemon())
        CSV = CSV .. pokemonToCSV(pastRun.getEnemyPokemon())
        local badges = pastRun.getBadges()
        CSV = CSV .. badgeSetToCSV(badges.firstSet)
        CSV = CSV .. badgeSetToCSV(badges.secondSet)
        CSV = CSV .. pastRun.getLocation() .. "\n"
        CSV = CSV .. pastRun.getProgress() .. "\n"
        return CSV
    end

    local function parsePastRunFromLineLocation(lines, lineStart)
        local date, seconds = lines[lineStart]:match("(.*),(.*)")
        seconds = tonumber(seconds)
        local faintedPokemonCSV = lines[lineStart + 1]
        local enemyPokemonCSV = lines[lineStart + 2]
        local badgeSet1CSV = lines[lineStart + 3]
        local badgeSet2CSV = lines[lineStart + 4]
        local location = lines[lineStart + 5]
        local faintedPokemon = decodeCSVPokemon(faintedPokemonCSV)
        local enemyPokemon = decodeCSVPokemon(enemyPokemonCSV)
        if faintedPokemon == nil or enemyPokemon == nil then
            return
        end
        local badgeSet1 = decodeCSVBadgeSet(badgeSet1CSV)
        local badgeSet2 = decodeCSVBadgeSet(badgeSet2CSV)
        local badges = {
            ["firstSet"] = badgeSet1,
            ["secondSet"] = badgeSet2
        }
        local progress = tonumber(lines[lineStart + 6])
        local pastRun = PastRun(date, seconds, faintedPokemon, enemyPokemon, location, badges, progress)
        return pastRun
    end

    local function loadPastRuns()
        pastRuns = {}
        local lines = {}
        local fileName = "savedData/" .. gameName .. ".pastlog"
        local currentRunIndex = 1
        if FormsUtils.fileExists(fileName) then
            lines = MiscUtils.readLinesFromFile(fileName, true)
            if #lines > 0 then
                totalRuns, totalRunsPastLab = string.match(lines[1], "(%d+),(%d+)")
                totalRuns, totalRunsPastLab = tonumber(totalRuns, 10), tonumber(totalRunsPastLab, 10)
                for index, line in pairs(lines) do
                    if line == "log start" then
                        local pastRunHash = lines[index + 1]
                        local pastRun = parsePastRunFromLineLocation(lines, index + 2)
                        if pastRun == nil then
                            return
                        end
                        pastRuns[pastRunHash] = pastRun
                        pastRunKeyList[currentRunIndex] = pastRunHash
                        currentRunIndex = currentRunIndex + 1
                    end
                end
            end
        end
    end

    local function saveRunsToFile()
        local fileName = "savedData/" .. gameName .. ".pastlog"
        local completeRunString = totalRuns .. "," .. totalRunsPastLab .. "\n"
        for runHash, run in pairs(pastRuns) do
            local runCSV = runToCSV(runHash, run)
            completeRunString = completeRunString .. runCSV
        end
        MiscUtils.writeStringToFile(fileName, completeRunString)
    end

    local function sortPastRunKeys(keys, runComparingFunction)
        table.sort(
            keys,
            function(hash1, hash2)
                local pastRun1, pastRun2 = pastRuns[hash1], pastRuns[hash2]
                return runComparingFunction(pastRun1, pastRun2)
            end
        )
    end

    function self.getPastRunStatistics()
        return StatisticsOrganizer.capStatistics(pastRunStatistics)
    end

    function self.getPastRuns()
        return pastRuns
    end

    function self.getPastRunHashesNewestFirst()
        local keys = MiscUtils.shallowCopy(pastRunKeyList)
        local function sortFunction(pastRun1, pastRun2)
            return pastRun1.getSeconds() > pastRun2.getSeconds()
        end
        sortPastRunKeys(keys, sortFunction)
        return keys
    end

    function self.getPastRunHashesOldestFirst()
        local keys = MiscUtils.shallowCopy(pastRunKeyList)
        local function sortFunction(pastRun1, pastRun2)
            return pastRun1.getSeconds() < pastRun2.getSeconds()
        end
        sortPastRunKeys(keys, sortFunction)
        return keys
    end

    function self.getPastRunHashesAToZ()
        local keys = MiscUtils.shallowCopy(pastRunKeyList)
        local function sortFunction(pastRun1, pastRun2)
            return pastRun1.getFaintedPokemon().name < pastRun2.getFaintedPokemon().name
        end
        sortPastRunKeys(keys, sortFunction)
        return keys
    end

    function self.getPastRunHashesSorted(sortMethod, badgeFilter)
        local sortMethodToFunction = {
            [self.SORT_METHODS.A_TO_Z] = self.getPastRunHashesAToZ,
            [self.SORT_METHODS.NEWEST] = self.getPastRunHashesNewestFirst,
            [self.SORT_METHODS.OLDEST] = self.getPastRunHashesOldestFirst
        }
        local pastRunHashes = sortMethodToFunction[sortMethod]()
        return filterPastRunsByBadgeCount(pastRunHashes, badgeFilter)
    end

    function self.getDefaultPastRun()
        return PastRun(
            "",
            0,
            MiscUtils.shallowCopy(MiscConstants.DEFAULT_POKEMON),
            MiscUtils.shallowCopy(MiscConstants.DEFAULT_POKEMON),
            "",
            {
                firstSet = {0, 0, 0, 0, 0, 0, 0, 0},
                secondSet = {0, 0, 0, 0, 0, 0, 0, 0}
            },
            0
        )
    end

    function self.removeNoBadgeRuns()
        local newRuns = {}
        pastRunKeyList = {}
        local currentIndex = 1
        for runHash, run in pairs(pastRuns) do
            if run.getBadgeCount() > 0 then
                newRuns[runHash] = run
                pastRunKeyList[currentIndex] = runHash
                currentIndex = currentIndex + 1
            end
        end
        pastRuns = newRuns
        saveRunsToFile()
    end

    function self.logRun(pastRun)
        totalRuns = totalRuns + 1
        local ROMHash = gameinfo.getromhash()
        if pastHashLogged ~= ROMHash then
            if pastRun.getProgress() > PlaythroughConstants.PROGRESS.NOWHERE then
                totalRunsPastLab = totalRunsPastLab + 1
                if not pastRuns[ROMHash] then
                    pastRuns[ROMHash] = pastRun
                    table.insert(pastRunKeyList, ROMHash)
                    pastHashLogged = ROMHash
                    pastRunStatistics =
                        StatisticsOrganizer.updateStatisticsWithNewRun(
                        pastRun,
                        pastRunStatistics,
                        program.getGameInfo().NAME
                    )
                end
            end
        end
        saveRunsToFile()
    end

    loadPastRuns()
    pastRunStatistics = StatisticsOrganizer.loadPastRunStatistics(program.getGameInfo().NAME)

    return self
end

return SeedLogger

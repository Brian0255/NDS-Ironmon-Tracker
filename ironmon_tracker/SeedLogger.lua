local function SeedLogger(initialProgram)
    local PastRun = dofile(Paths.FOLDERS.DATA_FOLDER .. "/PastRun.lua")

    local pastRuns = {}
    local self = {}

    local program = initialProgram

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
            "status",
            "ability"
        }
    }

    local function getBadgeCount(badges)
        local count = 0
        for _, badgeSet in pairs(badges) do
            for _, badge in pairs(badgeSet) do
                if badge == 1 then
                    count = count + 1
                end
            end
        end
        return count
    end

    local function filterPastRuns(badgeCountFilter)
        local filteredRuns = {}
        if badgeCountFilter == nil then
            badgeCountFilter = 0
        end
        for hash, run in pairs(pastRuns) do
            if getBadgeCount(run.getBadges()) >= badgeCountFilter then
                filteredRuns[hash] = run
            end
        end
        return filteredRuns
    end

    --this function is to save a ton of space in the file with stored runs
    local function pokemonToCSV(pokemon)
        local CSV = ""
        for _, key in pairs(encodingConstants.POKEMON_KEY_LIST) do
            if not pokemon[key] then
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
        CSV = CSV .. pastRun.getDate() .. "\n"
        CSV = CSV .. pokemonToCSV(pastRun.getFaintedPokemon())
        CSV = CSV .. pokemonToCSV(pastRun.getEnemyPokemon())
        local badges = pastRun.getBadges()
        CSV = CSV .. badgeSetToCSV(badges.firstSet)
        CSV = CSV .. badgeSetToCSV(badges.secondSet)
        CSV = CSV .. pastRun.getLocation() .. "\n"
        return CSV
    end

    local function randomizePastRunDescriptions()
        for _, pastRun in pairs(pastRuns) do
            pastRun.randomizeDescription()
            print(pastRun.getDescription())
        end
    end

    local function parsePastRunFromLineLocation(lines, lineStart)
        local date = lines[lineStart]
        local location = lines[lineStart + 5]
        local faintedPokemonCSV = lines[lineStart + 1]
        local enemyPokemonCSV = lines[lineStart + 2]
        local badgeSet1CSV = lines[lineStart + 3]
        local badgeSet2CSV = lines[lineStart + 4]
        local faintedPokemon = decodeCSVPokemon(faintedPokemonCSV)
        local enemyPokemon = decodeCSVPokemon(enemyPokemonCSV)
        local badgeSet1 = decodeCSVBadgeSet(badgeSet1CSV)
        local badgeSet2 = decodeCSVBadgeSet(badgeSet2CSV)
        local badges = {
            ["firstSet"] = badgeSet1,
            ["secondSet"] = badgeSet2
        }
        local pastRun = PastRun(date, faintedPokemon, enemyPokemon, location, badges)
        return pastRun
    end

    local function loadPastRuns()
        pastRuns = {}
        local lines = {}
        for line in io.lines("runs.pastlog") do
            table.insert(lines, line)
        end
        for index, line in pairs(lines) do
            if line == "log start" then
                local pastRunHash = lines[index + 1]
                local pastRun = parsePastRunFromLineLocation(lines, index + 2)
                pastRuns[pastRunHash] = pastRun
            end
        end
        randomizePastRunDescriptions()
        local filter1Badge = filterPastRuns(3)
        for _, run in pairs(filter1Badge) do
            print(run.getDate())
        end
    end

    local function saveRunsToFile()
        --empties the file before beginning appending process
        io.open("runs.pastlog", "w"):close()
        local completeRunString = ""
        for runHash, run in pairs(pastRuns) do
            local runCSV = runToCSV(runHash, run)
            completeRunString = completeRunString .. runCSV
            MiscUtils.appendStringToFile("runs.pastlog", completeRunString)
        end
    end

    function self.logRun(pastRun)
        local ROMHash = gameinfo.getromhash()
        if not pastRuns[ROMHash] then
            pastRuns[ROMHash] = pastRun
            saveRunsToFile()
        end
    end

    loadPastRuns()

    return self
end

return SeedLogger

QuickLoader = {}

local attempts = {
    ["USE_BATCH"] = 0,
    ["GENERATE_ROMS"] = 0
}

local attemptsPaths = {
    ["USE_BATCH"] = nil,
    ["GENERATE_ROMS"] = nil
}


local quickLoadSettings = nil
local romNumber = nil

function QuickLoader.getAttempts()
    return attempts[quickLoadSettings.LOAD_TYPE]
end

local function initAttemptsPaths()
    local romname = gameinfo.getromname()
    local attemptsPath = Paths.CURRENT_DIRECTORY..Paths.SLASH.."attempts"..Paths.SLASH

    local name, digits = romname:match("(.-)(%d+)")
    romNumber = digits
    if name ~= nil and digits ~= nil then
        attemptsPaths["USE_BATCH"] = attemptsPath..name..".txt"
    end

    local settings = FormsUtils.getFileNameFromPath(quickLoadSettings.SETTINGS_PATH:sub(1,-6))
    if settings ~= nil then
        attemptsPaths["GENERATE_ROMS"] = attemptsPath..settings..".txt"
    end
end

local function saveAttempts()
    if attemptsPaths[quickLoadSettings.LOAD_TYPE] == nil then
        return
    end
    local attemptsFile = io.open(attemptsPaths[quickLoadSettings.LOAD_TYPE], "w")
    if attemptsFile ~= nil then
        attemptsFile:write(attempts[quickLoadSettings.LOAD_TYPE])
        attemptsFile:close()
    end
end

local function readAttempts()
    for loadType, _ in pairs(attempts) do
        attempts[loadType] = 0
        local path = attemptsPaths[loadType]
        if path ~= nil then
            local attemptsFile = io.open(path, "r")
            if attemptsFile ~= nil then
                local contents = attemptsFile:read("*a")
                if contents ~= nil and tonumber(contents) ~= nil then
                    attempts[loadType] = tonumber(contents, 10)
                end
                attemptsFile:close()
            else
                if romNumber ~= nil then
                    attempts[loadType] = tonumber(romNumber,10)
                end
            end
        end
    end
end

--should only be called once
function QuickLoader.initialize(newQuickLoadSettings)
    quickLoadSettings = newQuickLoadSettings
    initAttemptsPaths()
    readAttempts()
end

local function incrementAttempts(fileName)
    attempts[quickLoadSettings.LOAD_TYPE] = attempts[quickLoadSettings.LOAD_TYPE]  + 1
    local attemptsFolder = "attempts"..Paths.SLASH
    attemptsPaths[quickLoadSettings.LOAD_TYPE] = attemptsFolder .. fileName .. ".txt"
    saveAttempts()
end

local function createBackupOfLog(romName)
    local backupPath = Paths.CURRENT_DIRECTORY..Paths.SLASH.."savedData"..Paths.SLASH..romName.."_backup.nds.log"
    local romPath = Paths.CURRENT_DIRECTORY..Paths.SLASH..romName
    MiscUtils.copyFile(romPath..".nds.log", backupPath)
end

local function generateROM()
    local paths = {
        ROMPath = quickLoadSettings.ROM_PATH,
        JARPath = quickLoadSettings.JAR_PATH,
        RNQSPath = quickLoadSettings.SETTINGS_PATH
    }
    for name, path in pairs(paths) do
        if not FormsUtils.fileExists(path) or path == "" then
             FormsUtils.displayError("Missing files have been detected for the QuickLoad feature. Please set these in the tracker's settings.")
            return nil
        end
    end
    local currentDirectory = Paths.CURRENT_DIRECTORY
    local rnqsName = FormsUtils.getFileNameFromPath(paths.RNQSPath) or ""
    --take off the .rnqs bit
    local settingsName = rnqsName:sub(1, -6)
    local nextRomName = settingsName .. "_Auto_Randomized.nds"
    nextRomName = nextRomName:gsub(" ","_")
    local nextRomPath = currentDirectory .. Paths.SLASH .. nextRomName
    createBackupOfLog(nextRomName:match("(.*)%.nds"))
    local randomizerCommand =
        string.format(
        'java -Xmx4608M -jar "%s" cli -s "%s" -i "%s" -o "%s" -l',
        paths.JARPath,
        paths.RNQSPath,
        paths.ROMPath,
        nextRomPath
    )
    print("Generating next ROM...")
    local command = randomizerCommand
    MiscUtils.runExecuteCommand(command, "RomGenerationErrorLog.txt")
    client.unpause()

    if not FormsUtils.fileExists(nextRomPath) then
        FormsUtils.displayError('Next ROM failed to generate. Check the "RomGenerationErrorLog" file for more details.')
        return nil
    end

    incrementAttempts(settingsName)

    return {
        name = nextRomName,
        path = nextRomPath
    }
end

local function getNextRomPathFromBatch()
    if quickLoadSettings.ROMS_FOLDER_PATH == nil or quickLoadSettings.ROMS_FOLDER_PATH == "" then
        local message = "ROMS_FOLDER_PATH is not set. Please set this in the tracker's settings."
        FormsUtils.displayError(message)
        return nil
    end

    local romName = gameinfo.getromname()
    local nameWithoutNumbers, newRomNumber = romName:match("(.-)(%d+)")
    newRomNumber = tonumber(newRomNumber,10)

    if newRomNumber == nil then
        local message = "Current ROM does not have any numbers in its name, unable to load next seed."
        FormsUtils.displayError(message)
        return nil
    end

    local nextRomName = romName:gsub(newRomNumber, tostring(newRomNumber + 1))
    local nextRomPath = quickLoadSettings.ROMS_FOLDER_PATH .. Paths.SLASH .. nextRomName .. ".nds"

    local fileCheck = io.open(nextRomPath, "r")
    if fileCheck ~= nil then
        io.close(fileCheck)
    else
        nextRomName = nextRomName:gsub(" ", "_")
        nextRomPath = quickLoadSettings.ROMS_FOLDER_PATH .. Paths.SLASH .. nextRomName .. ".nds"
        fileCheck = io.open(nextRomPath, "r")
        if fileCheck == nil then
            local message = "Unable to locate next ROM file to load."
            FormsUtils.displayError(message)
            return nil
        else
            io.close(fileCheck)
        end
    end

    incrementAttempts(nameWithoutNumbers)

    return {
        name = nextRomName,
        path = nextRomPath
    }
end

function QuickLoader.loadNextRom()
    initAttemptsPaths()
    readAttempts()
    if quickLoadSettings.LOAD_TYPE == "GENERATE_ROMS" then
        return generateROM()
    end
    return getNextRomPathFromBatch()
end

local function onAttemptsSet(newAttempts, UICallback)
    attempts[quickLoadSettings.LOAD_TYPE] = newAttempts
    saveAttempts()
    UICallback()
end

function QuickLoader.openAttemptsEditingWindow(UICallback)
    FormsUtils.createAttemptEditingWindow(attempts[quickLoadSettings.LOAD_TYPE], onAttemptsSet, UICallback)
end
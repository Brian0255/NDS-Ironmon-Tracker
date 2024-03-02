local function TrainerMilestone(initialName, initialTrainerIDs, initialPoints, initialIsRival, initialMapAreas)
    local self = {}

    local name = initialName
    local trainerIDs = initialTrainerIDs
    local points = initialPoints
    local isRival = initialIsRival
    local mapAreas = initialMapAreas

    if isRival == nil then
        isRival = false
    end

    local function checkRivalCompleted(defeatedTrainerList)
        for _, trainerID in pairs(trainerIDs) do
            if defeatedTrainerList[trainerID] then
                return true
            end
        end
        return false
    end

    local function exitedSuccessfully(playerMapID)
        if mapAreas == nil then
            return true
        end
        --if the player is not in any of the maps that make up an area that requires exit, they got out successfully
        return (mapAreas[playerMapID] == nil)
    end

    local function trainersDefeated(defeatedTrainerList)
        if isRival then
            return checkRivalCompleted(defeatedTrainerList)
        end
        for _, trainerID in pairs(trainerIDs) do
            if not defeatedTrainerList[trainerID] then
                return false
            end
        end
        return true
    end

    function self.completed(defeatedTrainerList, playerMapID, _)
        return (trainersDefeated(defeatedTrainerList) and exitedSuccessfully(playerMapID))
    end

    function self.getPoints()
        return points
    end

    function self.getName()
        return name
    end

    return self
end

local function MilestonesMilestone(initialName, initialMilestones, initialPoints)
    local self = {}

    local name = initialName
    local points = initialPoints
    local milestones = initialMilestones

    function self.completed(_, _, completedMilestoneMap)
        for _, milestoneID in pairs(milestones) do
            if not completedMilestoneMap[milestoneID] then
                return false
            end
        end
        return true
    end

    function self.getPoints()
        return points
    end

    function self.getName()
        return name
    end

    return self
end

local function TourneyBonus(initialName, initialPoints)
    local self = {}

    local name = initialName
    local points = initialPoints

    function self.getName()
        return name
    end

    function self.getPoints()
        return points
    end

    return self
end

local function TourneyTracker(initialTracker, initialSettings, initialTourneyTrackerScreen, initialMainScreen)
    local self = {}

    local tracker = initialTracker
    local settings = initialSettings
    local disabled = false
    local mainScreen = initialMainScreen
    local tourneyTrackerScreen = initialTourneyTrackerScreen

    local romHash = gameinfo.getromhash()

    self.DUNGEON_MAP_SETS = {
        SPROUT_TOWER = {
            [110] = true,
            [155] = true,
            [156] = true
        },
        LIGHTHOUSE = {
            [115] = true,
            [220] = true,
            [221] = true,
            [222] = true,
            [223] = true,
            [224] = true,
            [225] = true,
            [446] = true
        },
        ROCKET_HQ = {
            [247] = true,
            [248] = true,
            [249] = true
        },
        RADIO_TOWER = {
            [118] = true,
            [199] = true,
            [112] = true,
            [186] = true,
            [187] = true,
            [188] = true,
            [189] = true,
            [190] = true,
            [447] = true
        }
    }

    self.MILESTONES = {
        TrainerMilestone("Beat Rival 1", {495, 496, 497}, 1, true),
        TrainerMilestone("Beat Sprout Tower", {290}, 1, false, self.DUNGEON_MAP_SETS.SPROUT_TOWER),
        TrainerMilestone("Beat Falkner", {20}, 1),
        TrainerMilestone("Beat Rival 2", {1, 266, 269}, 1, true),
        TrainerMilestone("Beat Bugsy", {21}, 2),
        TrainerMilestone("Beat Whitney", {30}, 1),
        TrainerMilestone("Beat Lighthouse", {212}, 1, false, self.DUNGEON_MAP_SETS.LIGHTHOUSE),
        TrainerMilestone("Full Cleared Lighthouse", {401, 211, 73, 213, 217, 37, 215, 212, 214}, 1),
        TrainerMilestone("Beat Rival 3", {263, 267, 270}, 1, true),
        TrainerMilestone("Beat Morty", {31}, 2),
        TrainerMilestone("Beat Rocket Hideout", {479}, 1, false, self.DUNGEON_MAP_SETS.ROCKET_HQ), --double check ariana is correct since doubles weirdness
        TrainerMilestone("Beat Chuck", {34}, 1),
        TrainerMilestone("Beat Jasmine", {33}, 1),
        TrainerMilestone("Beat Pryce", {32}, 1),
        MilestonesMilestone("Beat Gyms 5/6/7", {12, 13, 14}, 1),
        TrainerMilestone("Beat Rival 4", {271, 288, 289}, 1, true),
        TrainerMilestone("Beat Archer", {485}, 1),
        TrainerMilestone(
            "Full Cleared Radio Tower",
            {
                195,
                193,
                14,
                283,
                228,
                199,
                196,
                197,
                227,
                185,
                198,
                187,
                188,
                186,
                189,
                471,
                190,
                191,
                192,
                472,
                200,
                706,
                487,
                478,
                485
            },
            2
        ),
        TrainerMilestone("Beat Clair", {35}, 3),
        TrainerMilestone("Beat Kimono Girls", {160, 161, 162, 163, 164}, 1),
        TrainerMilestone("Beat Rival 5", {264, 268, 272}, 1, true),
        TrainerMilestone("Beat Will", {245}, 1),
        TrainerMilestone("Beat Koga", {247}, 1),
        TrainerMilestone("Beat Bruno", {418}, 2),
        TrainerMilestone("Beat Karen", {246}, 2),
        TrainerMilestone("Beat Lance", {244}, 3),
        TrainerMilestone("Beat Rival 6", {285, 286, 287}, 1, true),
        TrainerMilestone("Beat Janine", {257}, 1),
        TrainerMilestone("Beat Surge", {255}, 1),
        TrainerMilestone("Beat Misty", {254}, 1),
        TrainerMilestone("Beat Brock", {253}, 1),
        TrainerMilestone("Beat Sabrina", {258}, 1),
        TrainerMilestone("Beat Erika", {256}, 1),
        TrainerMilestone("Beat Blaine", {259}, 2),
        TrainerMilestone("Beat Blue", {261}, 2),
        TrainerMilestone("Beat Red", {260}, 5)
    }

    self.BONUSES = {
        TourneyBonus("Evo Bonus (Lv. 1 - 19)", 2),
        TourneyBonus("Evo Bonus (Lv. 20 - 29)", 3),
        TourneyBonus("Evo Bonus (Lv. 30+)", 5)
    }

    local tourneyScores = {}
    local tourneyScoreMap = {}

    local currentData = nil

    local milestoneMap = {}

    local function convertScoreToLines(index, scoreData, linesToFill)
        local milestones = scoreData.completedMilestoneIDs
        local lastMilestone = "None"
        local lastMilestoneID = -1
        if #milestones > 0 then
            lastMilestoneID = milestones[#milestones]
            lastMilestone = self.MILESTONES[lastMilestoneID].getName()
        end
        local heading = "Seed #" .. index .. " - Last milestone: " .. lastMilestone .. "."
        local fullClearIDs = {[8] = true, [19] = true}
        for _, id in pairs(milestones) do
            if fullClearIDs[id] and id ~= lastMilestoneID then
                heading = heading .. " " .. self.MILESTONES[id].getName() .. "."
            end
        end
        table.insert(linesToFill, heading)
        if #scoreData.completedBonusIDs > 0 then
            local bonusText = "Bonuses:"
            for _, id in pairs(scoreData.completedBonusIDs) do
                bonusText = bonusText .. " " .. self.BONUSES[id].getName() .. ","
            end
            --remove last comma
            bonusText = bonusText:sub(1, -2)
            table.insert(linesToFill, bonusText)
        end
    end

    function self.convertScoresToLines()
        local lines = {}
        for i, score in ipairs(tourneyScores) do
            convertScoreToLines(i, score, lines)
        end
        return lines
    end

    local function createMilestoneIDMap()
        for _, milestoneID in pairs(currentData.completedMilestoneIDs) do
            milestoneMap[milestoneID] = true
        end
    end

    local function checkForOutdatedBonuses(data)
        local bonuses = data.completedBonusIDs
        for _, id in pairs(bonuses) do
            if not self.BONUSES[id] then
                data.completedBonusIDs = {}
                return
            end
        end
    end

    local function createTourneyScoreMap()
        for _, scoreData in pairs(tourneyScores) do
            checkForOutdatedBonuses(scoreData)
            tourneyScoreMap[scoreData.romHash] = {
                completedMilestoneIDs = scoreData.completedMilestoneIDs,
                completedBonusIDs = scoreData.completedBonusIDs
            }
        end
    end

    function self.saveData()
        if disabled or not settings.tourneyTracker.ENABLED then
            return
        end
        local filePath = Paths.CURRENT_DIRECTORY .. Paths.SLASH .. "savedData" .. Paths.SLASH .. "scores.tdata"
        local totalScorePath = Paths.CURRENT_DIRECTORY .. Paths.SLASH .. "savedData" .. Paths.SLASH .. "cumulative_score.txt"
        MiscUtils.saveTableToFile(filePath, tourneyScores)
        MiscUtils.writeStringToFile(totalScorePath, tostring(self.getCumulativePoints()))
    end

    function self.loadData()
        if not settings.tourneyTracker.ENABLED then
            return
        end
        local filePath = Paths.CURRENT_DIRECTORY .. Paths.SLASH .. "savedData" .. Paths.SLASH .. "scores.tdata"
        local data = MiscUtils.getTableFromFile(filePath)
        if data ~= nil then
            tourneyScores = data
        end
        createTourneyScoreMap()
        if not tourneyScoreMap[romHash] then
            local entry = {
                romHash = gameinfo.getromhash(),
                completedMilestoneIDs = {},
                completedBonusIDs = {}
            }
            table.insert(tourneyScores, entry)
            tourneyScoreMap[romHash] = {
                completedMilestoneIDs = entry.completedMilestoneIDs,
                completedBonusIDs = entry.completedBonusIDs
            }
            self.saveData()
        end
        currentData = tourneyScoreMap[romHash]
        createMilestoneIDMap()
    end

    function self.updateMilestones(defeatedTrainerList, playerMapID)
        if disabled or not settings.tourneyTracker.ENABLED or tracker.hasRunEnded() then
            return
        end
        local completedMilestoneIDs = currentData.completedMilestoneIDs
        for id, milestone in pairs(self.MILESTONES) do
            if
                not MiscUtils.tableContains(completedMilestoneIDs, id) and
                    milestone.completed(defeatedTrainerList, playerMapID, milestoneMap) and
                    not tourneyTrackerScreen.isNotifPlaying()
             then
                table.insert(completedMilestoneIDs, id)
                milestoneMap[id] = true
                local points = self.getTotalPoints(currentData)
                mainScreen.updateTourneyPoints(points)
                tourneyTrackerScreen.playMilestoneNotification(self.MILESTONES[id], self.getTotalPoints(currentData), points)
                if tourneyTrackerScreen.isViewingScore() then
                    tourneyTrackerScreen.setUpScoreBreakdown(self)
                end
                self.saveData()
            end
        end
    end

    function self.getTotalBonusPoints(scoreData)
        local total = 0
        for _, id in pairs(scoreData.completedBonusIDs) do
            total = total + self.BONUSES[id].getPoints()
        end
        return total
    end

    function self.getTotalMilestonePoints(scoreData)
        local total = 0
        for _, id in pairs(scoreData.completedMilestoneIDs) do
            total = total + self.MILESTONES[id].getPoints()
        end
        return total
    end

    function self.getTotalPoints(scoreData)
        if scoreData == nil then
            return 0
        end
        return (self.getTotalMilestonePoints(scoreData) + self.getTotalBonusPoints(scoreData))
    end

    function self.getCumulativePoints()
        local total = 0
        for _, scoreData in pairs(tourneyScores) do
            total = total + self.getTotalPoints(scoreData)
        end
        return total
    end

    function self.getTourneyScores()
        return tourneyScores
    end

    function self.clearData()
        local filePath = Paths.CURRENT_DIRECTORY .. Paths.SLASH .. "savedData" .. Paths.SLASH .. "scores.tdata"
        tourneyScores = {}
        tourneyScoreMap = {}
        io.open(filePath, "w"):close()
        disabled = true
        self.loadData()
    end

    self.loadData()
    local points = self.getTotalPoints(currentData)
    mainScreen.updateTourneyPoints(points)

    return self
end

return TourneyTracker

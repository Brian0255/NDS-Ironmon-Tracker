local function Main()
	local self = {}

	dofile("ironmon_tracker/constants/Chars.lua")

	local version = client.getversion()
	--basically checking if older than 2.9
	if tonumber(version:sub(1, 1)) == 2 and tonumber(version:sub(3, 3)) < 9 then
		Chars.accentedE = "\233"
	end

	dofile("ironmon_tracker/utils/FormsUtils.lua")
	dofile("ironmon_tracker/utils/MiscUtils.lua")
	dofile("ironmon_tracker/constants/MiscConstants.lua")

	dofile("ironmon_tracker/constants/Paths.lua")
	dofile(Paths.FOLDERS.DATA_FOLDER .. "/Pickle.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/MiscData.lua")
	dofile(Paths.FOLDERS.DATA_FOLDER .. "/Memory.lua")
	dofile(Paths.FOLDERS.DATA_FOLDER .. "/StatisticsOrganizer.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/Graphics.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/PokemonData.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/LocationData.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/TrainerData.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/GameInfo.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/MemoryAddresses.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/ItemData.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/MoveData.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/AbilityData.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/IconSets.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/PlaythroughConstants.lua")
	dofile(Paths.FOLDERS.DATA_FOLDER .. "/Input.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/DrawingUtils.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/BitUtils.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/MoveUtils.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/IconDrawer.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/MoveUtils.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/ThemeFactory.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/HoverFrameFactory.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/FrameFactory.lua")
	dofile(Paths.FOLDERS.DATA_FOLDER .. "/GameConfigurator.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/UIUtils.lua")
	Graphics.LETTER_PIXEL_LENGTHS[Chars.accentedE] = 4
	Paths.CURRENT_DIRECTORY = MiscUtils.runExecuteCommand("cd")

	local settings
	local program

	local loadNextSeed = false

	function self.displayError(message)
		forms.destroyall()
		FormsUtils.popupDialog(message, 250, 120, FormsUtils.POPUP_DIALOG_TYPES.WARNING, true)
	end

	local function incrementAttempts(settingsName)
		local folder = "attempts\\"
		local attemptsPath = folder .. settingsName .. ".txt"
		local attempts = 0
		local attemptsFile = io.open(attemptsPath, "r")
		if attemptsFile ~= nil then
			attempts = attemptsFile:read("*a")
			if attempts ~= nil and tonumber(attempts) ~= nil then
				attempts = tonumber(attempts)
			end
			attemptsFile:close()
		end
		attempts = attempts + 1
		attemptsFile = io.open(attemptsPath, "w")
		if attemptsFile ~= nil then
			attemptsFile:write(attempts)
			attemptsFile:close()
		end
	end

	local function generateROM()
		local paths = {
			ROMPath = settings.quickLoad.ROM_PATH,
			JARPath = settings.quickLoad.JAR_PATH,
			RNQSPath = settings.quickLoad.SETTINGS_PATH
		}
		for name, path in pairs(paths) do
			if not FormsUtils.fileExists(path) or path == "" then
				self.displayError("Missing files have been detected for the QuickLoad feature. Please set these in the tracker's settings.")
				return nil
			end
		end
		local currentDirectory = Paths.CURRENT_DIRECTORY
		local rnqsName = FormsUtils.getFileNameFromPath(paths.RNQSPath)
		local settingsName = rnqsName:sub(1, -6)
		local nextRomName = settingsName .. "_Auto_Randomized.nds"
		nextRomName = nextRomName:gsub(" ","_")
		local nextRomPath = currentDirectory .. "\\" .. nextRomName
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
			self.displayError('Next ROM failed to generate. Check the "RomGenerationErrorLog" file for more details.')
			return nil
		end

		incrementAttempts(settingsName)

		return {
			name = nextRomName,
			path = nextRomPath
		}
	end

	local function getNextRomPathFromBatch()
		if settings.quickLoad.ROMS_FOLDER_PATH == nil or settings.quickLoad.ROMS_FOLDER_PATH == "" then
			local message = "ROMS_FOLDER_PATH is not set. Please set this in the tracker's settings."
			self.displayError(message)
			return nil
		end

		local romName = gameinfo.getromname()
		local romNumber = romName:match("%d+")

		if romNumber == nil then
			local message = "Current ROM does not have any numbers in its name, unable to load next seed."
			self.displayError(message)
			return nil
		end

		local nextRomName = romName:gsub(romNumber, tostring(romNumber + 1))
		local nextRomPath = settings.quickLoad.ROMS_FOLDER_PATH .. "\\" .. nextRomName .. ".nds"

		local fileCheck = io.open(nextRomPath, "r")
		if fileCheck ~= nil then
			io.close(fileCheck)
		else
			nextRomName = nextRomName:gsub(" ", "_")
			nextRomPath = settings.quickLoad.ROMS_FOLDER_PATH .. "\\" .. nextRomName .. ".nds"
			fileCheck = io.open(nextRomPath, "r")
			if fileCheck == nil then
				local message = "Unable to locate next ROM file to load."
				self.displayError(message)
				return nil
			else
				io.close(fileCheck)
			end
		end

		return {
			name = nextRomName,
			path = nextRomPath
		}
	end

	local function checkForNextSeedCombo()
		if program ~= nil and not program.isInControlsMenu() then
			local check = MiscUtils.split(settings.controls.LOAD_NEXT_SEED, " ")
			local buttons = Input.getJoypad()
			for _, button in pairs(check) do
				if not buttons[button] then
					return false
				end
			end
			return true
		end
	end

	local function loadNext()
		local soundOn = client.GetSoundOn()
		client.SetSoundOn(false)
		local nextRomInfo
		if settings.quickLoad.LOAD_TYPE == "GENERATE_ROMS" then
			nextRomInfo = generateROM()
		else
			nextRomInfo = getNextRomPathFromBatch()
		end
		if nextRomInfo ~= nil then
			local name = nextRomInfo.name
			local path = nextRomInfo.path
			client.closerom()
			print("Loading next ROM: " .. name)
			client.openrom(path)
			if gameinfo.getromname() ~= "Null" then
				client.SetSoundOn(soundOn)
				loadNextSeed = false
				self.run()
			end
		else
			loadNextSeed = false
			self.run()
		end
	end

	local function readSettings()
		local INI = dofile(Paths.FOLDERS.DATA_FOLDER .. "/Inifile.lua")
		local DEFAULT_SETTINGS = MiscUtils.shallowCopy(MiscConstants.DEFAULT_SETTINGS)
		local file = io.open("Settings.ini")
		if file == nil then
			settings = DEFAULT_SETTINGS
		else
			settings = INI.parse("Settings.ini")

			for settingsGroup, options in pairs(DEFAULT_SETTINGS) do
				if not settings[settingsGroup] then
					settings[settingsGroup] = MiscUtils.shallowCopy(options)
				end
				for setting, settingValue in pairs(options) do
					if settings[settingsGroup][setting] == nil then
						settings[settingsGroup][setting] = settingValue
					end
				end
			end
			io.close(file)
			if settings.colorScheme["Default text color"] then
				settings.colorScheme["Top box text color"] = settings.colorScheme["Default text color"]
				settings.colorScheme["Bottom box text color"] = settings.colorScheme["Default text color"]
				settings.colorScheme["Default text color"] = nil
			end
		end
		INI.save("Settings.ini", settings)
	end

	function self.run()
		local loaded = false
		while not loaded do
			if gameinfo.getromname() ~= "Null" then
				loaded = true
			end
			emu.frameadvance()
		end

		console.clear()
		print("\nNDS-Ironmon-Tracker v" .. MiscConstants.TRACKER_VERSION)
		print("NDS ROM detected. Loading...")
		client.SetGameExtraPadding(0, 0, Graphics.SIZES.MAIN_SCREEN_PADDING, 0)
		local Tracker = dofile(Paths.FOLDERS.DATA_FOLDER .. "/Tracker.lua")
		local Program = dofile(Paths.FOLDERS.DATA_FOLDER .. "/Program.lua")
		local tracker = Tracker()
		readSettings()
		PlaythroughConstants.initializeStandardMessages()
		ThemeFactory.setSettings(settings)
		DrawingUtils.setColorScheme(settings.colorScheme)
		DrawingUtils.setColorSettings(settings.colorSettings)
		DrawingUtils.setAppearanceSettings(settings.appearance)
		IconDrawer.setSettings(settings)
		local gameConfiguration = GameConfigurator.initialize()
		if gameConfiguration == nil then
			print("This game is not currently not supported. Terminating Lua script...")
			return false
		end
		tracker.loadData(gameConfiguration.gameInfo.NAME)
		program = Program(tracker, gameConfiguration.memoryAddresses, gameConfiguration.gameInfo, settings)
		ThemeFactory.setSaveFunction(program.saveSettings)
		event.onexit(program.onProgramExit, "onProgramExit")
		while not loadNextSeed do
			program.main()
			loadNextSeed = checkForNextSeedCombo()
			emu.frameadvance()
		end
		loadNext()
	end

	function self.loadNextSeed()
		loadNextSeed = true
	end

	return self
end

return Main

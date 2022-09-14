-- NDS Ironnon Tracker
-- Created by OnlySpaghettiCode, largely based on the Ironmon Tracker by besteon and other contributors

local function Main()
	local self = {}

	if client.getversion == nil or client.getversion() ~= "2.8" then
		print("This version of BizHawk is not supported. Please update to version 2.8 or higher.")
		return
	end

	dofile("ironmon_tracker/constants/Paths.lua")
	dofile(Paths.FOLDERS.DATA_FOLDER .. "/utils/MiscUtils.lua")
	dofile(Paths.FOLDERS.DATA_FOLDER .. "/Pickle.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/MiscData.lua")
	dofile(Paths.FOLDERS.DATA_FOLDER .. "/Memory.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/Graphics.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/PokemonData.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/GameInfo.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/MemoryAddresses.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/ItemData.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/MoveData.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/AbilityData.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/MiscConstants.lua")
	dofile(Paths.FOLDERS.DATA_FOLDER .. "/Input.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/DrawingUtils.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/BitUtils.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/MoveUtils.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/FormsUtils.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/IconDrawer.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/MoveUtils.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/ThemeFactory.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/HoverFrameFactory.lua")
	dofile(Paths.FOLDERS.DATA_FOLDER .. "/GameConfigurator.lua")

	local settings

	local loadNextSeed = false

	local function displayError(message)
		forms.destroyall()
		FormsUtils.popupDialog(message, 250, 120, FormsUtils.POPUP_DIALOG_TYPES.WARNING, true)
	end

	local function generateROM()
		client.pause()
		local paths = {
			ROMPath = settings.quickLoad.ROM_PATH,
			JARPath = settings.quickLoad.JAR_PATH,
			RNQSPath = settings.quickLoad.SETTINGS_PATH
		}
		for name, path in pairs(paths) do
			if not FormsUtils.fileExists(path) or path == "" then
				displayError(
					"Missing files have been detected for the QuickLoad feature. Please set these in the tracker's settings."
				)
				return nil
			end
		end
		local currentDirectory = FormsUtils.getCurrentDirectory()
		local nextRomName = FormsUtils.getFileNameFromPath(paths.ROMPath)
		local nextRomPath = currentDirectory .. "\\"..nextRomName
		local randomizerCommand =
			string.format(
			'java -Xmx4608M -jar "%s" cli -s "%s" -i "%s" -o "%s" -l',
			paths.JARPath,
			paths.RNQSPath,
			paths.ROMPath,
			nextRomPath
		)
		print("Generating next ROM...")
		local pipe = io.popen(randomizerCommand .. " 2>RomGenerationErrorLog.txt")
		if pipe ~= nil then
			local output = pipe:read("*all")
			--print("> " .. output)
		end
		client.unpause()

		if not FormsUtils.fileExists(nextRomPath) then
			displayError('Next ROM failed to generate. Check the "RomGenerationErrorLog" file for more details.')
			return nil
		end

		return {
			name = nextRomName,
			path = nextRomPath
		}
	end

	local function getnextRomPathFromBatch()
		if settings.quickLoad.ROMS_FOLDER_PATH == nil or settings.quickLoad.ROMS_FOLDER_PATH == "" then
			local message = "ROMS_FOLDER_PATH is not set. Please set this in the tracker's settings."
			displayError(message)
			return nil
		end

		local romName = gameinfo.getromname()
		local romNumber = romName:match("%d+")

		if romNumber == nil then
			local message = "Current ROM does not have any numbers in its name, unable to load next seed."
			displayError(message)
			return nil
		end

		local nextRomName = romName:gsub(romNumber, tostring(romNumber + 1))
		local nextRomPath = settings.quickLoad.ROMS_FOLDER_PATH .. "/" .. nextRomName

		local fileCheck = io.open(nextRomPath, "r")
		if fileCheck ~= nil then
			io.close(fileCheck)
		else
			nextRomName = nextRomName:gsub(" ", "_")
			nextRomPath = settings.quickLoad.ROMS_FOLDER_PATH .. "/" .. nextRomName .. ".nds"
			fileCheck = io.open(nextRomPath, "r")
			if fileCheck == nil then
				local message = "Unable to locate next ROM file to load."
				displayError(message)
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
		local check = MiscUtils.split(settings.controls.LOAD_NEXT_SEED, " ")
		local buttons = Input.getJoypad() 
		for _, button in pairs(check) do
			if not buttons[button] then
				return false
			end
		end
		return true
	end

	local function loadNext()
		local soundOn = client.GetSoundOn()
		client.SetSoundOn(false)
		local nextRomInfo
		if settings.quickLoad.LOAD_TYPE == "GENERATE_ROMS" then
			nextRomInfo = generateROM()
		else
			nextRomInfo = getnextRomPathFromBatch()
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
		local file = io.open("Settings.ini")
		assert(file ~= nil)
		settings = INI.parse(file:read("*a"), "memory")
		io.close(file)
		if settings.colorScheme["Default text color"] then
			settings.colorScheme["Top box text color"] = settings.colorScheme["Default text color"]
			settings.colorScheme["Bottom box text color"] = settings.colorScheme["Default text color"]
			settings.colorScheme["Default text color"] = nil
		end
	end

	function self.run()
		local loaded = false
		while not loaded do
			if gameinfo.getromname() ~= "Null" then
				loaded = true
			end
			emu.frameadvance()
		end
		print("\nNDS-Ironmon-Tracker v" .. MiscConstants.TRACKER_VERSION)
		print("NDS ROM detected. Loading...")
		client.SetGameExtraPadding(0, 0, Graphics.SIZES.MAIN_SCREEN_PADDING, 0)
		local gameConfiguration = GameConfigurator.initialize()
		local Tracker = dofile(Paths.FOLDERS.DATA_FOLDER .. "/Tracker.lua")
		local Program = dofile(Paths.FOLDERS.DATA_FOLDER .. "/Program.lua")
		local tracker = Tracker()
		readSettings()
		ThemeFactory.setSettings(settings)
		DrawingUtils.setColorScheme(settings.colorScheme)
		DrawingUtils.setColorSettings(settings.colorSettings)
		DrawingUtils.setAppearanceSettings(settings.appearance)
		IconDrawer.setSettings(settings)
		local mainProgram = Program(tracker, gameConfiguration.memoryAddresses, gameConfiguration.gameInfo, settings)
		event.onexit(mainProgram.onProgramExit, "onProgramExit")
		while not loadNextSeed do
			mainProgram.main()
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

local main = Main()
if main ~= nil then
	main.run()
end

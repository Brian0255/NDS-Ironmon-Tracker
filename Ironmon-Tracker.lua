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
	dofile(Paths.FOLDERS.DATA_FOLDER .. "/Memory.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/Graphics.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/PokemonData.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/GameInfo.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/MemoryAddresses.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/ItemData.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/MoveData.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/AbilityData.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/MiscConstants.lua")

	dofile(Paths.FOLDERS.DATA_FOLDER.."/Input.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/DrawingUtils.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/BitUtils.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/MoveUtils.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/FormsUtils.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/IconDrawer.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/MoveUtils.lua")
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/ThemeFactory.lua")
	dofile(Paths.FOLDERS.DATA_FOLDER .. "/GameConfigurator.lua")

	local loadNextSeed = false

	
	local function loadNext()
		--[[
		userdata.clear()

		if Settings.config.ROMS_FOLDER == nil or Settings.config.ROMS_FOLDER == "" then
			print("ROMS_FOLDER unspecified. Set this in Settings.ini to automatically switch ROM.")
			Main.LoadNextSeed = false
			Main.Run()
			return
		end

		local romname = gameinfo.getromname()
		local romnumber = romname:match("%d+")

		if romnumber == nil then
			print("Current ROM does not have any numbers in its name, unable to load next seed.")
			Main.LoadNextSeed = false
			Main.Run()
		end

		-- Increment to the next ROM and determine its full file path
		local nextromname = romname:gsub(romnumber, tostring(romnumber + 1))
		local nextrompath = Settings.config.ROMS_FOLDER .. "/" .. nextromname .. ".nds"

		-- First try loading the next rom as-is with spaces, otherwise replace spaces with underscores and try again
		local filecheck = io.open(nextrompath, "r")
		if filecheck ~= nil then
			-- This means the file exists, so proceed with opening it.
			io.close(filecheck)
		else
			nextromname = nextromname:gsub(" ", "_")
			nextrompath = Settings.config.ROMS_FOLDER .. "/" .. nextromname .. ".nds"
			filecheck = io.open(nextrompath, "r")
			if filecheck == nil then
				-- This means there doesn't exist a ROM file with spaces or underscores
				print("Unable to locate next ROM file to load.")
				Main.LoadNextSeed = false
				Main.Run()
			else
				io.close(filecheck)
			end
		end

		client.SetSoundOn(false)
		client.closerom()
		print("Loading next ROM: " .. nextromname)
		client.openrom(nextrompath)
		client.SetSoundOn(true)

		if gameinfo.getromname() ~= "Null" then
			Main.LoadNextSeed = false
			Main.Run()
		end--]]
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
		local INI = dofile(Paths.FOLDERS.DATA_FOLDER .. "/Inifile.lua")
		local file = io.open("Settings.ini")
		assert(file ~= nil)
		local settings = INI.parse(file:read("*a"), "memory")
		if settings.colorScheme["Default text color"] then
			settings.colorScheme["Top box text color"] = settings.colorScheme["Default text color"]
			settings.colorScheme["Bottom box text color"] = settings.colorScheme["Default text color"]
			settings.colorScheme["Default text color"] = nil
		end
		ThemeFactory.setSettings(settings)
		DrawingUtils.setColorScheme(settings.colorScheme)
		DrawingUtils.setColorSettings(settings.colorSettings)
		IconDrawer.setSettings(settings)
		io.close(file)
		local mainProgram = Program(tracker, gameConfiguration.memoryAddresses, gameConfiguration.gameInfo, settings)
		event.onexit(mainProgram.onProgramExit, "onProgramExit")
		while not loadNextSeed do
			mainProgram.main()
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
main.run()

-- NDS Ironnon Tracker
-- Created by OnlySpaghettiCode, largely based on the Ironmon Tracker by besteon and other contributors

TRACKER_VERSION = "0.2.1"

-- A frequently used placeholder when a data field is not applicable
PLACEHOLDER = "---" 

-- Check the version of BizHawk that is running
if client.getversion == nil or client.getversion() ~= "2.8" then
	print("This version of BizHawk is not supported. Please update to version 2.8 or higher.")
	-- Bounce out... Don't pass Go! Don't collect $200.
	return
end


-- Get the user settings saved on disk and create the base Settings object
DATA_FOLDER = "ironmon_tracker"
INI = dofile(DATA_FOLDER .. "/Inifile.lua")
Settings = INI.parse("Settings.ini", io)
-- If ROMS_FOLDER is left empty, Inifile.lua doesn't add it to the settings table, resulting in the ROMS_FOLDER 
-- being deleted entirely from Settings.ini if another setting is toggled in the tracker options menu
if Settings.config.ROMS_FOLDER == nil then Settings.config.ROMS_FOLDER = "" end

-- Root folder for the project data and sub scripts


-- Import all scripts before starting the main loop
dofile(DATA_FOLDER .. "/PokemonData.lua")
dofile(DATA_FOLDER .. "/MoveData.lua")
dofile(DATA_FOLDER .. "/Data.lua")
dofile(DATA_FOLDER .. "/Memory.lua")
dofile(DATA_FOLDER .. "/GameSettings.lua")
dofile(DATA_FOLDER .. "/GraphicConstants.lua")
dofile(DATA_FOLDER .. "/Options.lua")
dofile(DATA_FOLDER .. "/Utils.lua")
dofile(DATA_FOLDER .. "/ButtonManager.lua")
dofile(DATA_FOLDER .. "/Input.lua")
dofile(DATA_FOLDER .. "/Drawing.lua")
dofile(DATA_FOLDER .. "/Program.lua")
dofile(DATA_FOLDER .. "/Pickle.lua")
dofile(DATA_FOLDER .. "/Tracker.lua")
dofile(DATA_FOLDER .. "/Decrypter.lua") 
dofile(DATA_FOLDER .. "/ColorPicker.lua") 
dofile(DATA_FOLDER .. "/ColorOptions.lua") 
dofile(DATA_FOLDER .. "/ThemeForms.lua")
dofile(DATA_FOLDER .. "/Images.lua")  

Main = {}
Main.LoadNextSeed = false

-- Main loop
function Main.Run()
	local loaded = false
	Program.state = State.TRACKER
	while not loaded do
		if gameinfo.getromname() ~= "Null" then
			loaded = true
		end
		emu.frameadvance()
	end
	print("\nNDS-Ironmon-Tracker v" .. TRACKER_VERSION)
	print("NDS ROM detected. Loading...")
	Options.buildTrackerOptionsButtons()
	Tracker.Data.inBattle = 0
	GameSettings.initialize()
	GameSettings.initMoveData()
	if GameSettings.gameversion == 0 then
		client.SetGameExtraPadding(0, 0, 0, 0)
		while true do
			gui.text(0, 0, "Lua error: " .. GameSettings.gamename)
			emu.frameadvance()
		end
	else
		Tracker.loadData()
		ButtonManager.initializeBadgeButtons()
		ColorOptions.initializeButtons()
		GraphicConstants.readSettingsColors()
		client.SetGameExtraPadding(0, GraphicConstants.UP_GAP, GraphicConstants.RIGHT_GAP, GraphicConstants.DOWN_GAP)
		gui.defaultTextBackground(0)
		event.onloadstate(Tracker.loadData, "OnLoadState")
		event.onexit(Program.HandleExit, "HandleExit")

		while Main.LoadNextSeed == false do
			Program.main()
			emu.frameadvance()
		end

		Main.LoadNext()
	end
end

function Main.LoadNext()
	userdata.clear()

	if Settings.config.ROMS_FOLDER == nil or Settings.config.ROMS_FOLDER == "" then
		print("ROMS_FOLDER unspecified. Set this in Settings.ini to automatically switch ROM.")
		Main.LoadNextSeed = false
		Main.Run()
		return
	end

	local romname = gameinfo.getromname()

	-- Split the ROM name into its prefix and numerical values
	local romprefix = string.match(romname, '[^0-9]+')
	local romnumber = string.match(romname, '[0-9]+')
	if romprefix == nil then romprefix = "" end

	if romnumber == "" or romnumber == nil then
		print("Current ROM does not have any numbers in its name, unable to load next seed.\nReloaded current ROM: " .. romname)
		Main.LoadNextSeed = false
		Main.Run()
	end

	-- Increment to the next ROM and determine its full file path
	local nextromname = string.format(romprefix .. "%0" .. string.len(romnumber) .. "d", romnumber + 1)
	local nextrompath = Settings.config.ROMS_FOLDER .. "/" .. nextromname .. ".nds"

	-- First try loading the next rom as-is with spaces, otherwise replace spaces with underscores and try again
	local filecheck = io.open(nextrompath,"r")
	if filecheck ~= nil then
		-- This means the file exists, so proceed with opening it.
		io.close(filecheck)
	else
		nextromname = nextromname:gsub(" ", "_")
		nextrompath = Settings.config.ROMS_FOLDER .. "/" .. nextromname .. ".nds"
		filecheck = io.open(nextrompath,"r")
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
	end
end

Main.Run()

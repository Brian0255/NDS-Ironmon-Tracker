-- NDS Ironnon Tracker
-- Created by OnlySpaghettiCode, largely based on the Ironmon Tracker by besteon and other contributors

-- The latest version of the tracker. Should be updated with each PR.
TRACKER_VERSION = "0.0.1"

-- A frequently used placeholder when a data field is not applicable
PLACEHOLDER = "---" -- TODO: Consider moving into a better global constant location? Placed here for now to ensure it is available to all subscripts.

-- Check the version of BizHawk that is running
if string.sub(client.getversion(), 1) ~= "2.8" then
	print("This version of BizHawk is not supported. Please update to version 2.8 or higher.")
	-- Bounce out... Don't pass Go! Don't collect $200.
	return
end

-- Root folder for the project data and sub scripts
DATA_FOLDER = "ironmon_tracker"

-- Get the user settings saved on disk and create the base Settings object
INI = dofile(DATA_FOLDER .. "/Inifile.lua")
Settings = INI.parse("Settings.ini")

-- Import all scripts before starting the main loop
dofile(DATA_FOLDER .. "/PokemonData.lua")
dofile(DATA_FOLDER .. "/MoveData.lua")
dofile(DATA_FOLDER .. "/Data.lua")
dofile(DATA_FOLDER .. "/Memory.lua")
dofile(DATA_FOLDER .. "/GameSettings.lua")
dofile(DATA_FOLDER .. "/GraphicConstants.lua")
dofile(DATA_FOLDER .. "/Options.lua")
dofile(DATA_FOLDER .. "/Utils.lua")
dofile(DATA_FOLDER .. "/Buttons.lua")
dofile(DATA_FOLDER .. "/Input.lua")
dofile(DATA_FOLDER .. "/Drawing.lua")
dofile(DATA_FOLDER .. "/Program.lua")
dofile(DATA_FOLDER .. "/Pickle.lua")
dofile(DATA_FOLDER .. "/Tracker.lua")
dofile(DATA_FOLDER .. "/Decrypter.lua") 

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

	if Settings.config.ROMS_FOLDER == nil then
		print("ROMS_FOLDER unspecified. Set this in Settings.ini to automatically switch ROM.")
		Main.LoadNextSeed = false
		Main.Run()
		return
	end

	client.SetSoundOn(false)
	local romname = gameinfo.getromname()
	client.closerom()

	local rombasename = string.match(romname, '[^0-9]+')
	local romnumber = tonumber(string.match(romname, '[0-9]+')) + 1
	local nextromname = ""
	if rombasename == nil then
		nextromname = Settings.config.ROMS_FOLDER .. "\\" .. romnumber .. ".nds"
	else
		rombasename = rombasename:gsub(" ", "_")
		nextromname = Settings.config.ROMS_FOLDER .. "\\" .. rombasename .. romnumber .. ".nds"
		print(nextromname)
	end

	client.openrom(nextromname)
	client.SetSoundOn(true)

	if gameinfo.getromname() ~= "Null" then
		Main.LoadNextSeed = false
		Main.Run()
	end
end

Main.Run()

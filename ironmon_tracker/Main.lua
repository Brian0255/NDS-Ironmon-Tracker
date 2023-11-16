local function Main()
	local self = {}

	local newerBizhawk = true

	dofile("ironmon_tracker/constants/Chars.lua")

	local version = client.getversion()
	--basically checking if older than 2.9
	if tonumber(version:sub(1, 1)) == 2 and tonumber(version:sub(3, 3)) < 9 then
		newerBizhawk = false
		Chars.accentedE = "\233"
	end

	dofile("ironmon_tracker/utils/FormsUtils.lua")
	dofile("ironmon_tracker/utils/MiscUtils.lua")
	dofile("ironmon_tracker/constants/PlaythroughConstants.lua")
	dofile("ironmon_tracker/constants/MiscConstants.lua")

	dofile("ironmon_tracker/constants/Paths.lua")
	dofile(Paths.FOLDERS.DATA_FOLDER .. "/Pickle.lua")
	dofile(Paths.FOLDERS.DATA_FOLDER .. "/QuickLoader.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/MiscData.lua")
	dofile(Paths.FOLDERS.DATA_FOLDER .. "/Memory.lua")
	dofile(Paths.FOLDERS.DATA_FOLDER .. "/StatisticsOrganizer.lua")
	dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/CharMap.lua")
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
	dofile(Paths.FOLDERS.UTILS_FOLDER .. "/UIUtils.lua")
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
	dofile(Paths.FOLDERS.DATA_FOLDER .. "/RepelDrawer.lua")
	dofile(Paths.FOLDERS.DATA_FOLDER .. "/AnimatedSpriteManager.lua")
	Graphics.LETTER_PIXEL_LENGTHS[Chars.accentedE] = 4

	if Paths.SLASH == "\\" then
		Paths.CURRENT_DIRECTORY = MiscUtils.runExecuteCommand("cd")
	else
		Paths.CURRENT_DIRECTORY = MiscUtils.runExecuteCommand("pwd")
	end

	local settings
	local program
	local tracker

	local loadNextSeed = false

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
		tracker.updatePlaytime(program.getGameInfo().NAME)
		local soundOn = client.GetSoundOn()
		client.SetSoundOn(false)
		local nextRomInfo
		nextRomInfo = QuickLoader.loadNextRom()
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
			client.SetSoundOn(soundOn)
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
		tracker = Tracker()
		readSettings()
		PlaythroughConstants.initializeStandardMessages()
		ThemeFactory.setSettings(settings)
		if newerBizhawk then
			dofile(Paths.FOLDERS.UTILS_FOLDER .. "/NewerLuaRedefines.lua")
		end
		DrawingUtils.initialize(settings)
		DrawingUtils.setAppearanceSettings(settings.appearance)
		IconDrawer.setSettings(settings)
		local gameConfiguration = GameConfigurator.initialize()
		if gameConfiguration == nil then
			print("This game is not currently not supported. Terminating Lua script...")
			return false
		end
		if (gameConfiguration.gameInfo.GEN == 4) then
			dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/EvoDataGen4.lua")
		else
			dofile(Paths.FOLDERS.CONSTANTS_FOLDER .. "/EvoDataGen5.lua")
		end
		tracker.loadData(gameConfiguration.gameInfo.NAME)
		tracker.loadTotalPlaytime(gameConfiguration.gameInfo.NAME)
		QuickLoader.initialize(settings.quickLoad)
		program = Program(tracker, gameConfiguration.memoryAddresses, gameConfiguration.gameInfo, settings)
		local gameInfo = gameConfiguration.gameInfo
		if settings.trackedInfo.FIRST_TIME_BW2 and (gameInfo.NAME == "Pokemon White 2" or gameInfo.NAME == "Pokemon Black 2") then
			settings.trackedInfo.FIRST_TIME_BW2 = false
			program.saveSettings()
			FormsUtils.displayError(
				"It looks like this might be your first time playing " ..
					gameInfo.NAME ..
						". As a friendly reminder, this tracker will not work without the intro patch. If you need it, you can find it in the official IronMON discord. Best of luck!"
			)
		end
		ThemeFactory.setSaveFunction(program.saveSettings)
		ThemeFactory.setPokemonThemeDisablingFunction(program.turnOffPokemonTheme)
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

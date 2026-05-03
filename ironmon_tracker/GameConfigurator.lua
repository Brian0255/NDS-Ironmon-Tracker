GameConfigurator = {}

GameConfigurator.ALTERNATE_FORM_ORDER_GEN4 = {
	"Deoxys",
	"Wormadam P",
	"Giratina A",
	"Shaymin L",
	"Rotom"
	--[[
	"Castform",
	"Basculin R",
	"Darmanitan",
	"Meloetta A",
	"Kyurem",
	"Landorus",
	"Thundurus",
	"Tornadus",
	"Burmy P",
	"Cherrim O",
	"Deerling",
	"Frillish M",
	"Gastrodon W",
	"Jellicent M",
	"Keldeo",
	"Sawsbuck",
	"Shellos W",
	"Unfezant M"
	--]]
}

GameConfigurator.ALTERNATE_FORM_ORDER_GEN5 = {
	"Deoxys",
	"Wormadam P",
	"Shaymin L",
	"Giratina A",
	"Rotom",
	"Castform",
	"Basculin R",
	"Darmanitan",
	"Meloetta A",
	"Kyurem",
	"Landorus",
	"Thundurus",
	"Tornadus",
	"Burmy P",
	"Cherrim O",
	"Deerling",
	"Frillish M",
	"Gastrodon W",
	"Jellicent M",
	"Keldeo",
	"Sawsbuck",
	"Shellos W",
	"Unfezant M"
}

-- Extract Pokemon BST from log files with fallback to default values
function GameConfigurator.extractBSTFromLogs(pokemonMasterListCopy, endIndex, logFilePath)

	local bstLookup = GameConfigurator.parseAllBSTFromLogFile(logFilePath)
	local foundCount = 0
	
	for i = 1, endIndex, 1 do
		local pokemonData = pokemonMasterListCopy[i]
		local pokemonID = i - 1  
		
		if bstLookup[pokemonID] then
			pokemonData.bst = bstLookup[pokemonID]
			foundCount = foundCount + 1
		else
			-- Fallback to original BST if not found in log
			pokemonData.bst = tonumber(pokemonData.bst)
		end
	end
	
	return pokemonMasterListCopy
end

-- Optimized: Parse all Pokemon BST values from log file at once
function GameConfigurator.parseAllBSTFromLogFile(logFilePath)
	if not logFilePath or not FormsUtils.fileExists(logFilePath) then
		print("Log file not found at " .. logFilePath)
		print("Falling back to displaying default BST...")
		return {}
	end
	-- Read and parse the log file once
	local lines = MiscUtils.readLinesFromFile(logFilePath, true)
	if not lines or #lines == 0 then
		return {}
	end
	
	-- Find the Pokemon Base Stats section
	local pokemonSectionStart = nil
	for i, line in pairs(lines) do
		if line == "--Pokemon Base Stats & Types--" then
			pokemonSectionStart = i + 1
			break
		end
	end
	
	if not pokemonSectionStart then
		return {}
	end
	
	-- Parse all Pokemon data at once and build BST lookup table
	local bstLookup = {}
	local currentLineIndex = pokemonSectionStart + 1
	
	while currentLineIndex <= #lines do
		local line = lines[currentLineIndex]
		if not line or line == "" then
			break  -- End of Pokemon section
		end
		
		local pokemonData = MiscUtils.split(line, "|", true)
		local pokemonID = tonumber(pokemonData[1])
		
		if pokemonID then
			-- Extract stats (positions 4-9 based on original parser)
			local hp = tonumber(pokemonData[4])
			local atk = tonumber(pokemonData[5])
			local def = tonumber(pokemonData[6])
			local spa = tonumber(pokemonData[7])
			local spd = tonumber(pokemonData[8])
			local spe = tonumber(pokemonData[9])
			
			if hp and atk and def and spa and spd and spe then
				bstLookup[pokemonID] = hp + atk + def + spa + spd + spe
			end
		end
		currentLineIndex = currentLineIndex + 1
	end
	
	return bstLookup
end

local function trim(s)
	return (s and s:gsub("^%s+", ""):gsub("%s+$", "")) or s
end

function GameConfigurator.parseNameToIdFromLogFile(logFilePath)
	if not logFilePath or not FormsUtils.fileExists(logFilePath) then
		return {}
	end

	local lines = MiscUtils.readLinesFromFile(logFilePath, true)
	if not lines or #lines == 0 then
		return {}
	end

	local headerIdx = nil
	for i, line in ipairs(lines) do
		if line:find("%-%-Pokemon Base Stats %& Types%-%-") or line:find("%-%-Pokemon Base Stats") then
			headerIdx = i
			break
		end
	end
	if not headerIdx then
		return {}
	end

	local j = headerIdx + 2
	local nameToId = {}

	while j <= #lines do
		local line = lines[j]
		if not line or trim(line) == "" then break end
		if line:sub(1, 2) == "--" then break end

		local parts = MiscUtils.split(line, "|", true)
		if #parts >= 2 then
			local num  = tonumber(trim(parts[1]))
			local name = trim(parts[2])
			if num and name and name ~= "" then
				nameToId[name] = num - 1
			end
		end
		j = j + 1
	end

	return nameToId
end

function GameConfigurator.parseStartersFromLogFile(logFilePath, nameToId)
	if not logFilePath or not FormsUtils.fileExists(logFilePath) then
		return {}
	end

	local lines = MiscUtils.readLinesFromFile(logFilePath, true)
	if not lines or #lines == 0 then
		return {}
	end

	local starters = {}

	local sectionIdx = nil
	for i, line in ipairs(lines) do
		if line:find("%-%-Random Starters%-%-") or line:find("%-%-Randomized Starters%-%-") then
			sectionIdx = i
			break
		end
	end

	if sectionIdx then
		for j = sectionIdx + 1, math.min(sectionIdx + 20, #lines) do
			local l = lines[j]
			if not l or trim(l) == "" then break end
			if l:sub(1, 2) == "--" then break end

			local name = l:match("to%s+(.+)$") or l:match(":%s*(%S.*)$")
			if name then
				name = trim(name)
				local id = nameToId[name] + 1
				if id ~= nil then
					table.insert(starters, id)
					if #starters == 3 then break end
				end
			end
		end
	else
		-- Fallback: scan entire file for "Set starter X to NAME"
		for _, l in ipairs(lines) do
			local name = l:match("Set starter%s*%d+%s*to%s*(.+)")
			if name then
				name = trim(name)
				local id = nameToId[name] + 1
				if id ~= nil then
					table.insert(starters, id)
					if #starters == 3 then break end
				end
			end
		end
	end

	return starters
end

function GameConfigurator.initPokemon(gameInfo, logFilePath)
	local endIndex = PokemonData.LAST_INDEX_GEN_4
	if gameInfo.GEN == 5 then
		endIndex = PokemonData.LAST_INDEX_GEN_5
	end
	local pokemon = {}
	local pokemonMasterListCopy = MiscUtils.deepCopy(PokemonData.POKEMON_MASTER_LIST)
	
	if logFilePath then
		-- Extract BST from logs with fallback to default values
		pokemonMasterListCopy = GameConfigurator.extractBSTFromLogs(pokemonMasterListCopy, endIndex, logFilePath)
	end

	for i = 1, endIndex, 1 do
		local pokemonData = pokemonMasterListCopy[i]
		table.insert(pokemon, pokemonData)
	end
	PokemonData.POKEMON = pokemon
	local nameToId = {}
	if logFilePath then
		nameToId = GameConfigurator.parseNameToIdFromLogFile(logFilePath)
		PokemonData.STARTERS = GameConfigurator.parseStartersFromLogFile(logFilePath, nameToId)
	else
		PokemonData.STARTERS = {}
	end

	PokemonData.NAMES_MAPPING = {}
end

function GameConfigurator.initMoveData(gameInfo)
	MoveData.MOVES = {}
	for index, move in pairs(MoveData.MOVES_MASTER_LIST) do
		if gameInfo.GEN == 4 and index == 469 then
			return
		end
		local moveToInsert = {
			id = 1,
			name = "---",
			type = "---",
			power = Graphics.TEXT.NO_POWER,
			pp = Graphics.TEXT.NO_PP,
			accuracy = Graphics.TEXT.ALWAYS_HITS,
			category = MoveData.MOVE_CATEGORIES.NONE
		}
		for name, moveAttribute in pairs(move) do
			if type(moveAttribute) == "table" then
				moveToInsert[name] = moveAttribute[gameInfo.GEN]
			else
				moveToInsert[name] = moveAttribute
			end
		end
		table.insert(MoveData.MOVES, moveToInsert)
	end
end

function GameConfigurator.initAbilityData(gameInfo)
	AbilityData.ABILITIES = {}
	local versionDifferenceIndex = gameInfo.GEN - 3
	for index, info in pairs(AbilityData.ABILITIES_MASTER_LIST) do
		if gameInfo.GEN == 4 and index == 125 then
			break
		end
		AbilityData.ABILITIES[index] = {}
		for key, value in pairs(info) do
			if type(value) == "table" then
				AbilityData.ABILITIES[index][key] = value[versionDifferenceIndex]
			else
				AbilityData.ABILITIES[index][key] = value
			end
		end
	end

	AbilityData.BATTLE_MSGS = {}
	local battleMsgsToCopy
	if gameInfo.GEN == 4 then
		battleMsgsToCopy = AbilityData.BATTLE_MSGS_MASTER_LIST.GEN4
	elseif gameInfo.GEN == 5 then
		battleMsgsToCopy = AbilityData.BATTLE_MSGS_MASTER_LIST.GEN5
	end
	for msgId, abilityIdList in pairs(battleMsgsToCopy or {}) do
		AbilityData.BATTLE_MSGS[msgId] = {}
		for _, abilityId in pairs(abilityIdList) do
			AbilityData.BATTLE_MSGS[msgId][abilityId] = true
		end
	end
end

function GameConfigurator.initAlternateForms(gameInfo)
	local formOrder = GameConfigurator.ALTERNATE_FORM_ORDER_GEN4
	if gameInfo.GEN == 5 then
		formOrder = GameConfigurator.ALTERNATE_FORM_ORDER_GEN5
	end
	local currentIndex = #PokemonData.POKEMON + 1
	for _, baseForm in pairs(formOrder) do
		local formTable = PokemonData.ALTERNATE_FORMS[baseForm]
		formTable.index = currentIndex
		for i, form in pairs(formTable.forms) do
			if baseForm == "Rotom" and gameInfo.GEN == 4 then
				form.type = {PokemonData.POKEMON_TYPES.ELECTRIC, PokemonData.POKEMON_TYPES.GHOST}
			end
			PokemonData.POKEMON[currentIndex] = form
			PokemonData.POKEMON[currentIndex].baseFormData = {
				baseFormName = baseForm,
				alternateFormIndex = i,
				baseFormIndex = formTable.baseIndex
			}
			currentIndex = currentIndex + 1
		end
	end
end

function GameConfigurator.initialize(settings)
	local memdomain = "Main RAM"
	memory.usememorydomain(memdomain)
	local gameCode = Memory.read_u32_le(MemoryAddresses.NDS_CONSTANTS.CARTRIDGE_HEADER + 0x0C)
	if not GameInfo.GAME_INFO[gameCode] then
		FormsUtils.popupDialog(
			"Your ROM is not currently supported by the tracker. Only English NDS ROMs are supported.",
			250,
			100,
			FormsUtils.POPUP_DIALOG_TYPES.WARNING,
			false
		)
		return
	end
	local gameInfo = GameInfo.GAME_INFO[gameCode]
	print(gameInfo.NAME .. " detected.")
	local startingFolder = Paths.CURRENT_DIRECTORY .. Paths.SLASH
	
	if settings.quickLoad.LOAD_TYPE == "USE_BATCH" then
		if settings.quickLoad.ROMS_FOLDER_PATH == nil or settings.quickLoad.ROMS_FOLDER_PATH == "" then
			return
		end
		startingFolder = settings.quickLoad.ROMS_FOLDER_PATH .. Paths.SLASH
	end

	local romName = gameinfo.getromname()	
	-- Replace spaces with underscores for filename 
	local safeRomName = romName:gsub(" ", "_")
	local logPath = startingFolder .. safeRomName .. ".nds.log"

	GameConfigurator.initPokemon(gameInfo, logPath)
	GameConfigurator.initAlternateForms(gameInfo)
	for id, pokemonData in pairs(PokemonData.POKEMON) do
		if id ~= 1 then
			PokemonData.NAMES_MAPPING[pokemonData.name] = id - 1
		end
	end
	GameConfigurator.initMoveData(gameInfo)
	GameConfigurator.initAbilityData(gameInfo)

	if gameInfo.GEN == 5 then
		ItemData.ITEMS = ItemData.GEN_5_ITEMS
	else
		ItemData.ITEMS = ItemData.GEN_4_ITEMS
	end
	return GameConfigurator.initializeMemoryAddresses()
end

local function readVersionPointerOffsets(memoryInfo, addressConfiguration)
	local globalPtr = memoryInfo.GLOBAL_POINTER
	local globalPtrAddr = Memory.read_u32_le(globalPtr)
	--Don't care about the first 2 bytes.
	globalPtrAddr = bit.band(globalPtrAddr, 0xFFFFFF)
	local versionPtr = globalPtrAddr + 0x20
	local versionPtrAddr = Memory.read_u32_le(versionPtr)
	versionPtrAddr = bit.band(versionPtrAddr, 0xFFFFFF)
	for addrName, versionPtrOffset in pairs(memoryInfo.VERSION_POINTER_OFFSETS) do
		addressConfiguration[addrName] = versionPtrAddr + versionPtrOffset
	end
end

function GameConfigurator.initializeMemoryAddresses()
	local gameCode = Memory.read_u32_le(MemoryAddresses.NDS_CONSTANTS.CARTRIDGE_HEADER + 0x0C)
	local gameInfo = GameInfo.GAME_INFO[gameCode]
	local memoryInfo = MemoryAddresses[gameCode]
	local addressConfiguration = {}
	for globalOffsetName, globalAddr in pairs(memoryInfo.GLOBAL) do
		addressConfiguration[globalOffsetName] = globalAddr
	end
	if gameInfo.GEN == 4 then
		readVersionPointerOffsets(memoryInfo, addressConfiguration)
	end
	return {
		["gameInfo"] = gameInfo,
		["memoryAddresses"] = addressConfiguration
	}
end

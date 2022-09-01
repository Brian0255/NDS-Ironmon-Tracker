GameConfigurator = {}

function GameConfigurator.initMoveData(gameInfo)
	for _, move in pairs(MoveData.MOVES_MASTER_LIST) do
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

function GameConfigurator.initAlternateForms()
	local currentIndex = #PokemonData.POKEMON + 1
	for _, formTable in pairs(PokemonData.ALTERNATE_FORMS) do
		formTable.index = currentIndex
		for _, form in pairs(formTable.forms) do
			PokemonData.POKEMON[currentIndex] = form
			currentIndex = currentIndex + 1
		end
	end
end

function GameConfigurator.initialize()
	local memdomain = "Main RAM"
	memory.usememorydomain(memdomain)
	local gameCode = Memory.read_u32_le(MemoryAddresses.NDS_CONSTANTS.CARTRIDGE_HEADER + 0x0C)
	local gameInfo = GameInfo.GAME_INFO[gameCode]
	print(gameInfo.NAME .. " detected.")
	GameConfigurator.initAlternateForms()
	GameConfigurator.initMoveData(gameInfo)

	if gameInfo.gen == 5 then
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
	readVersionPointerOffsets(memoryInfo, addressConfiguration)
	return {
		["gameInfo"] = gameInfo,
		["memoryAddresses"] = addressConfiguration
	}
end

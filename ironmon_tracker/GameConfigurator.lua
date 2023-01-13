GameConfigurator = {}

GameConfigurator.ALTERNATE_FORM_ORDER_GEN4 = {
	"Deoxys","Wormadam P","Giratina A","Shaymin L","Rotom","Castform","Basculin R","Darmanitan","Meloetta A","Kyurem","Landorus","Thundurus","Tornadus","Burmy P",
	"Cherrim O","Deerling","Frillish M","Gastrodon W","Jellicent M","Keldeo","Sawsbuck","Shellos W","Unfezant M"
}

GameConfigurator.ALTERNATE_FORM_ORDER_GEN5 = {
	"Deoxys","Wormadam P","Shaymin L","Giratina A","Rotom","Castform","Basculin R","Darmanitan","Meloetta A","Kyurem","Landorus","Thundurus","Tornadus","Burmy P",
	"Cherrim O","Deerling","Frillish M","Gastrodon W","Jellicent M","Keldeo","Sawsbuck","Shellos W","Unfezant M"
}

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

function GameConfigurator.initAbilityData(gameInfo)
	local versionDifferenceIndex = gameInfo.GEN - 3
	for index, info in pairs(AbilityData.ABILITIES_MASTER_LIST) do
		AbilityData.ABILITIES[index] = {}
		for key, value in pairs(info) do
			if type(value) == "table" then
				AbilityData.ABILITIES[index][key] = value[versionDifferenceIndex]
			else
				AbilityData.ABILITIES[index][key] = value
			end
		end
	end
end

function GameConfigurator.initAlternateForms(gameInfo)
	local formOrder = GameConfigurator.ALTERNATE_FORM_ORDER_GEN4
	if gameInfo.GEN ==5 then
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
				alternateFormIndex = i
			}
			currentIndex = currentIndex + 1
		end
	end
end

function GameConfigurator.initialize()
	local memdomain = "Main RAM"
	memory.usememorydomain(memdomain)
	local gameCode = Memory.read_u32_le(MemoryAddresses.NDS_CONSTANTS.CARTRIDGE_HEADER + 0x0C)
	if not GameInfo.GAME_INFO[gameCode] then
		FormsUtils.popupDialog("Your ROM is not currently supported by the tracker. Only English NDS ROMs are supported.", 250,100, FormsUtils.POPUP_DIALOG_TYPES.WARNING, false)
		return
	end
	if gameCode == GameInfo.VERSION_NUMBER.WHITE2 then
		FormsUtils.popupDialog("Pok\233mon White 2 is not supported currently. Please use a Pok\233mon Black 2 ROM instead.", 250,100, FormsUtils.POPUP_DIALOG_TYPES.WARNING, false)
		return
	end
	local gameInfo = GameInfo.GAME_INFO[gameCode]
	print(gameInfo.NAME .. " detected.")
	GameConfigurator.initAlternateForms(gameInfo)
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

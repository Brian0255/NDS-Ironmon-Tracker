EventData = {
    pokemonNames = {},
    moveNames = {},
    abilityNames = {},
	routeNames = {}
}

function EventData.initializeLookupTables()
	for id, pokemon in ipairs(PokemonData.POKEMON) do
		if (pokemon.name ~= "---") then
			EventData.pokemonNames[id - 1] = pokemon.name:lower()
		end
	end
	for id, move in ipairs(MoveData.MOVES) do
		if (move.name ~= "---") then
			EventData.moveNames[id - 1] = move.name:lower()
		end
	end
	for id, ability in ipairs(AbilityData.ABILITIES) do
		if (ability.name ~= "---") then
			EventData.abilityNames[id - 1] = ability.name:lower()
		end
	end
	local routes = Network.Data.gameInfo.LOCATION_DATA.locations or {}
	for id, route in pairs(routes) do
		EventData.routeNames[id] = (route.name or "Unnamed Route"):lower()
	end
end

-- Helper Functions and Variables

---Searches for a Pokémon by name, finds the best match; returns 0 if no good match
---@param name string?
---@param threshold number? Default threshold distance of 3
---@return number pokemonId
---@return number distance The Levenshtein distance between search word and matched word
local function findPokemonId(name, threshold)
	if name == nil or name == "" then
		return 0, -1
	end
    threshold = threshold or 3

	-- Try and find a name match
	local id, _, distance = NetworkUtils.getClosestWord(name:lower(), EventData.pokemonNames, threshold)
	return id or 0, distance
end

---Searches for a Move by name, finds the best match; returns 0 if no good match
---@param name string?
---@param threshold number? Default threshold distance of 3
---@return number moveId
---@return number distance The Levenshtein distance between search word and matched word
local function findMoveId(name, threshold)
	if name == nil or name == "" then
		return 0, -1
	end
	threshold = threshold or 3

	-- Try and find a name match
	local id, _, distance = NetworkUtils.getClosestWord(name:lower(), EventData.moveNames, threshold)
	return id or 0, distance
end

---Searches for an Ability by name, finds the best match; returns 0 if no good match
---@param name string?
---@param threshold number? Default threshold distance of 3
---@return number abilityId
---@return number distance The Levenshtein distance between search word and matched word
local function findAbilityId(name, threshold)
	if name == nil or name == "" then
		return 0, -1
	end
	threshold = threshold or 3

	-- Try and find a name match
	local id, _, distance = NetworkUtils.getClosestWord(name:lower(), EventData.abilityNames, threshold)
	return id or 0, distance
end

---Searches for a Route by name, finds the best match; returns 0 if no good match
---@param name string?
---@param threshold number? Default threshold distance of 5!
---@return number mapId
---@return number distance The Levenshtein distance between search word and matched word
local function findRouteId(name, threshold)
	if name == nil or name == "" then
		return 0, -1
	end
	threshold = threshold or 5
	-- If the lookup is just a route number, allow it to be searchable
	if tonumber(name) ~= nil then
		name = string.format("route %s", name)
	end
	-- Try and find a name match
	local id, _, distance = NetworkUtils.getClosestWord(name:lower(), EventData.routeNames, threshold)
	return id or 0, distance
end

---Searches for a Pokémon Type by name, finds the best match; returns nil if no match found
---@param name string?
---@param threshold number? Default threshold distance of 3
---@return string? type PokemonData.Type
---@return number distance The Levenshtein distance between search word and matched word
local function findPokemonType(name, threshold)
	if name == nil or name == "" then
		return nil, -1
	end
	threshold = threshold or 3
	local _, type, distance = NetworkUtils.getClosestWord(name:upper(), PokemonData.TYPE_LIST, threshold)
	if not PokemonData.POKEMON_TYPES[type or false] then
		return nil, -1
	end
	return type, distance
end

-- The max # of items to show for any commands that output a list of items (try keep chat message output short)
local MAX_ITEMS = 12
local OUTPUT_CHAR = ">"
local DEFAULT_OUTPUT_MSG = "No info found."

---Returns a response message by combining information into a single string
---@param prefix string? [Optional] Prefixes the response with this header as "HEADER RESPONSE"
---@param infoList table|string? [Optional] A string or list of strings to combine
---@param infoDelimeter string? [Optional] Defaults to " | "
---@return string response Example: "Prefix Info Item 1 | Info Item 2 | Info Item 3"
local function buildResponse(prefix, infoList, infoDelimeter)
	prefix = (prefix or "") ~= "" and (prefix .. " ") or ""
	if not infoList or #infoList == 0 then
		return prefix .. DEFAULT_OUTPUT_MSG
	elseif type(infoList) ~= "table" then
		return prefix .. tostring(infoList)
	else
		return prefix .. table.concat(infoList, infoDelimeter or " | ")
	end
end
local function buildDefaultResponse(input)
	if (input or "") ~= "" then
		return buildResponse()
	else
		return buildResponse(string.format("%s %s", input, OUTPUT_CHAR))
	end
end

local function getPokemonOrDefault(input)
	local id
	if (input or "") ~= "" then
		id = findPokemonId(input) or -2
	else
		local pokemon = Network.Data.program.getPlayerPokemon() or {}
		id = pokemon.pokemonID or -2
	end
	return PokemonData.POKEMON[id + 1], id
end
local function getMoveOrDefault(input)
	if (input or "") ~= "" then
		local id = findMoveId(input) or -2
		return MoveData.MOVES[id + 1], id
	else
		return nil, -1
	end
end
local function getAbilityOrDefault(input)
	local id
	if (input or "") ~= "" then
		id = findAbilityId(input) or -2
	else
		local pokemon = Network.Data.program.getPlayerPokemon() or {}
		if pokemon.pokemonID and PokemonData.POKEMON[pokemon.pokemonID + 1] then
			id = pokemon.ability or -2
		end
	end
	return AbilityData.ABILITIES[id + 1], id
end
local function getRouteIdOrDefault(input)
	if (input or "") ~= "" then
		local id = findRouteId(input)
		return id
	else
		return Network.Data.program.getCurrentMapID() or -1
	end
end

-- Data Calculation Functions

---@param params string?
---@return string response
function EventData.getPokemon(params)
	local pokemon, id = getPokemonOrDefault(params)
	if id <= 0 or not pokemon then
		return buildDefaultResponse(params)
	end

	local info = {}
	local typesText
	if pokemon.type[2] ~= PokemonData.POKEMON_TYPES.EMPTY and pokemon.type[2] ~= pokemon.type[1] then
		typesText = string.format("%s/%s",
			NetworkUtils.firstToUpperEachWord(pokemon.type[1]:lower()),
			NetworkUtils.firstToUpperEachWord(pokemon.type[2]:lower())
		)
	else
		typesText = NetworkUtils.firstToUpperEachWord(pokemon.type[1]:lower())
	end
	local coreInfo = string.format("%s #%03d (%s) BST: %s",
		pokemon.name,
		id,
		typesText,
		pokemon.bst
	)
	table.insert(info, coreInfo)
	local evos
	if type(pokemon.evolution) == "table" then
		evos = table.concat(pokemon.evolution, ", ")
	else
		evos = pokemon.evolution
	end
	table.insert(info, string.format("Evolution: %s", evos))
	local moveLevels = pokemon.movelvls[Network.Data.gameInfo.VERSION_GROUP] or {}
	local moves
	if #moveLevels > 0 then
		moves = table.concat(moveLevels, ", ")
	else
		moves = "None."
	end
	table.insert(info, string.format("Lv. Moves: %s", moves))
	local amountSeen = Network.Data.tracker.getAmountSeen(id) or 0
	if amountSeen > 0 then
		table.insert(info, string.format("Amount seen: %s", amountSeen))
	end
	return buildResponse(OUTPUT_CHAR, info)
end

---@param params string?
---@return string response
function EventData.getBST(params)
	local pokemon, id = getPokemonOrDefault(params)
	if id <= 0 or not pokemon then
		return buildDefaultResponse(params)
	end

	local info = {}
	table.insert(info, string.format("BST: %s", pokemon.bst))
	local prefix = string.format("%s %s", pokemon.name, OUTPUT_CHAR)
	return buildResponse(prefix, info)
end

---@param params string?
---@return string response
function EventData.getWeak(params)
	local pokemon, id = getPokemonOrDefault(params)
	if id <= 0 or not pokemon then
		return buildDefaultResponse(params)
	end

	local info = {}
	local pokemonDefenses = MoveUtils.getTypeDefensesTable(pokemon)
	local weak4x = NetworkUtils.firstToUpperEachWord(table.concat(pokemonDefenses["4x"] or {}, ", "):lower())
	if (weak4x or "") ~= "" then
		table.insert(info, string.format("[4x] %s", weak4x))
	end
	local weak2x = NetworkUtils.firstToUpperEachWord(table.concat(pokemonDefenses["2x"] or {}, ", "):lower())
	if (weak2x or "") ~= "" then
		table.insert(info, string.format("[2x] %s", weak2x))
	end
	local weak05 = NetworkUtils.firstToUpperEachWord(table.concat(pokemonDefenses["0.5x"] or {}, ", "):lower())
	if (weak05 or "") ~= "" then
		table.insert(info, string.format("[0.5x] %s", weak05))
	end
	local weak025 = NetworkUtils.firstToUpperEachWord(table.concat(pokemonDefenses["0.25x"] or {}, ", "):lower())
	if (weak025 or "") ~= "" then
		table.insert(info, string.format("[0.25x] %s", weak025))
	end
	local weak0 = NetworkUtils.firstToUpperEachWord(table.concat(pokemonDefenses["0x"] or {}, ", "):lower())
	if (weak0 or "") ~= "" then
		table.insert(info, string.format("[0x] %s", weak0))
	end
	local typesText
	if pokemon.type[2] ~= PokemonData.POKEMON_TYPES.EMPTY and pokemon.type[2] ~= pokemon.type[1] then
		typesText = string.format("%s/%s",
			NetworkUtils.firstToUpperEachWord(pokemon.type[1]:lower()),
			NetworkUtils.firstToUpperEachWord(pokemon.type[2]:lower())
		)
	else
		typesText = NetworkUtils.firstToUpperEachWord(pokemon.type[1]:lower())
	end

	if #info == 0 then
		table.insert(info, "Has no weaknesses")
	end

	local prefix = string.format("%s (%s) Weaknesses %s", pokemon.name, typesText, OUTPUT_CHAR)
	return buildResponse(prefix, info)
end

---@param params string?
---@return string response
function EventData.getMove(params)
	local move, id = getMoveOrDefault(params)
	if id <= 0 or not move then
		return buildDefaultResponse(params)
	end

	local info = {}
	local makesContact = NetworkUtils.containsText(move.description, "makes contact")
	table.insert(info, string.format("Contact: %s", makesContact and "Yes" or "No"))
	table.insert(info, string.format("PP: %s", move.pp or "---"))
	table.insert(info, string.format("Power: %s", move.power or "---"))
	table.insert(info, string.format("Acc: %s", move.accuracy or "---"))
	table.insert(info, string.format("Move Summary: %s", move.description or "N/A"))
	local prefix = string.format("%s (%s, %s) %s",
		move.name,
		NetworkUtils.firstToUpperEachWord(move.type:lower()),
		NetworkUtils.firstToUpperEachWord(move.category:lower()),
		OUTPUT_CHAR)
	return buildResponse(prefix, info)
end

---@param params string?
---@return string response
function EventData.getAbility(params)
	local ability, id = getAbilityOrDefault(params)
	if id <= 0 or not ability then
		return buildDefaultResponse(params)
	end

	local info = {}
	table.insert(info, string.format("%s: %s", ability.name or "Unknown Ability", ability.description or "N/A"))
	return buildResponse(OUTPUT_CHAR, info)
end

---@param params string?
---@return string response
function EventData.getRoute(params)
	-- Check for optional parameters
	local paramsLower = (params or ""):lower()
	-- local routeFilter
	-- Types of route encounter data, allowing 'option' param to isolate those results:
	-- Walking, Old Rod, Good Rod, Super Rod, Surfing, Rock Smash, Underwater(?)
	-- for key, val in pairs({}) do
	-- 	if NetworkUtils.containsText(paramsLower, val) then
	-- 		-- Only check whole words
	-- 		local replaceWholeWords = "%f[%a]" .. val:lower() .. "%f[%A]"
	-- 		paramsLower = (paramsLower:gsub(replaceWholeWords, ""))
	-- 		routeFilter = key
	-- 		break
	-- 	end
	-- end
	-- If option keywords were removed, trim any whitespace
	-- if routeFilter then
	-- 	-- Removes duplicate, consecutive whitespaces, and leading/trailer whitespaces
	-- 	paramsLower = ((paramsLower:gsub("(%s)%s+", "%1")):gsub("^%s*(.-)%s*$", "%1"))
	-- end

	local routeId = getRouteIdOrDefault(paramsLower)
	local route = Network.Data.gameInfo.LOCATION_DATA.locations[routeId or -1]
	if not route then
		return buildDefaultResponse(params)
	end

	local info = {}
	-- Check for trainers in the route, but only if a specific encounter area wasnt requested
	-- if not routeFilter and route.trainers and #route.trainers > 0 then
	-- 	local defeatedTrainers, totalTrainers = Program.getDefeatedTrainersByLocation(routeId)
	-- 	table.insert(info, string.format("%s: %s/%s", "Trainers defeated", #defeatedTrainers, totalTrainers))
	-- end
	-- Check for wilds in the route
	local encounterArea = Network.Data.gameInfo.LOCATION_DATA.encounters[route.name or false]
	local trackedArea = Network.Data.tracker.getEncounterData(route.name) or {}
	-- if routeFilter then
	-- 	encounterArea = RouteData.EncounterArea[routeFilter] or RouteData.EncounterArea.LAND
	-- else
	-- 	-- Default to the first area type (usually Walking)
	-- 	encounterArea = RouteData.getNextAvailableEncounterArea(routeId, RouteData.EncounterArea.TRAINER)
	-- end
	if encounterArea and encounterArea.vanillaData then
		local wildMonsAndLevels = {}
		for pokemonID, levelList in pairs(trackedArea.encountersSeen or {}) do
			if PokemonData.POKEMON[pokemonID + 1] then
				local monName = PokemonData.POKEMON[pokemonID + 1].name or "---"
				local monWithLevel
				if #levelList == 1 then
					monWithLevel = string.format("%s (Lv.%s)", monName, levelList[1])
				else
					monWithLevel = string.format("%s (Lv.%s-%s)", monName, levelList[1], levelList[#levelList])
				end
				table.insert(wildMonsAndLevels, monWithLevel)
			end
		end
		local wildsText = string.format(
			"Wild Pok" .. Chars.accentedE .. "mon seen: %s/%s",
			#wildMonsAndLevels,
			encounterArea.totalPokemon
		)
		if #wildMonsAndLevels > 0 then
			wildsText = wildsText .. string.format(", %s", table.concat(wildMonsAndLevels, ", "))
		end
		table.insert(info, wildsText)
	end

	local prefix = string.format("%s %s", route.name, OUTPUT_CHAR)
	-- if routeFilter then
	-- 	prefix = string.format("%s: %s %s", route.name, NetworkUtils.firstToUpperEachWord(encounterArea), OUTPUT_CHAR)
	-- else
	-- 	prefix = string.format("%s %s", route.name, OUTPUT_CHAR)
	-- end
	return buildResponse(prefix, info)
end

--- Function not yet implemented
---@param params string?
---@return string response
function EventData.getDungeon(params)
	-- TODO: Implement this function
	if true then return buildDefaultResponse(params) end
	local routeId = getRouteIdOrDefault(params)
	local route = Network.Data.gameInfo.LOCATION_DATA.locations[routeId or -1]
	if not route then
		return buildDefaultResponse(params)
	end

	local info = {}
	-- Check for trainers in the area/route
	-- local defeatedTrainers, totalTrainers
	-- if route.area ~= nil then
	-- 	defeatedTrainers, totalTrainers = Program.getDefeatedTrainersByCombinedArea(route.area)
	-- elseif route.trainers and #route.trainers > 0 then
	-- 	defeatedTrainers, totalTrainers = Program.getDefeatedTrainersByLocation(routeId)
	-- end
	-- if defeatedTrainers and totalTrainers then
	-- 	local trainersText = string.format("%s: %s/%s", "Trainers defeated", #defeatedTrainers, totalTrainers)
	-- 	table.insert(info, trainersText)
	-- end
	local routeName = route.area and route.area.name or route.name
	local prefix = string.format("%s %s", routeName, OUTPUT_CHAR)
	return buildResponse(prefix, info)
end

--- Function not yet implemented
---@param params string?
---@return string response
function EventData.getUnfoughtTrainers(params)
	-- TODO: Implement this function
	if true then return buildDefaultResponse(params) end
	local allowPartialDungeons = NetworkUtils.containsText(params, "dungeon")
	local MAX_AREAS_TO_CHECK = 7

	-- Not implemented
	local function getUnfinishedRouteInfo(trainerId)
		return nil
	end

	local info = {}
	for _, trainerId in ipairs({}) do
		local routeText = getUnfinishedRouteInfo(trainerId)
		if routeText ~= nil then
			table.insert(info, routeText)
		end
		if #info >= MAX_AREAS_TO_CHECK then
			table.insert(info, "...")
			break
		end
	end
	if #info == 0 then
		local reminderText = ""
		if not allowPartialDungeons then
			reminderText = ' (Use param "dungeon" to check partially completed dungeons.)'
		end
		table.insert(info, "All available trainers have been defeated!%s" .. reminderText)
	end

	local prefix = string.format("Unfought Trainers %s", OUTPUT_CHAR)
	return buildResponse(prefix, info, ", ")
end

---@param params string?
---@return string response
function EventData.getPivots(params)
	local info = {}
	for _, routeName in ipairs(Network.Data.gameInfo.LOCATION_DATA.encounterAreaOrder or {}) do
		-- Check for tracked wild encounters in the route
		local trackedArea = Network.Data.tracker.getEncounterData(routeName)
		if trackedArea then
			local pokemonNames = {}
			for pokemonID, _ in pairs(trackedArea.encountersSeen or {}) do
				if PokemonData.POKEMON[pokemonID + 1] then
					table.insert(pokemonNames, PokemonData.POKEMON[pokemonID + 1].name or "---")
				end
			end
			if #pokemonNames > 0 then
				table.insert(info, string.format("%s: %s", routeName, table.concat(pokemonNames, ", ")))
			end
		end
	end
	local prefix = string.format("Pivots %s", OUTPUT_CHAR)
	return buildResponse(prefix, info)
end

---@param params string?
---@return string response
function EventData.getRevo(params)
	local pokemonID, targetEvoId
	if (params or "") ~= "" then
		pokemonID = findPokemonId(params) or -1
		-- If more than one Pokémon name is provided, set the other as the target evo (i.e. "Eevee Vaporeon")
		if pokemonID <= 0 then
			local s = MiscUtils.split(params, " ", true) or {}
			pokemonID = findPokemonId(s[1]) or -1
			targetEvoId = findPokemonId(s[2]) or -1
		end
	else
		local pokemon = Network.Data.program.getPlayerPokemon() or {}
		pokemonID = pokemon.pokemonID or -1
	end

	local evoData = EvoData.EVOLUTIONS[pokemonID] or {}
	-- Use first available target evo, if none specified
	if not targetEvoId or targetEvoId <= 0 then
		targetEvoId = 9999
		for revoId, _ in pairs(evoData) do
			if revoId < targetEvoId then
				targetEvoId = revoId
			end
		end
	end

	local pokemon = PokemonData.POKEMON[pokemonID + 1] or {}
	local revo = evoData[targetEvoId]
	if not revo then
		if pokemon.evolution == PokemonData.EVOLUTION_TYPES.NONE then
			local prefix = string.format("%s Evos %s", pokemon.name or "N/A", OUTPUT_CHAR)
			return buildResponse(prefix, "Does not evolve.")
		else
			return buildDefaultResponse(pokemon.name or params)
		end
	end

	table.sort(revo, function(a,b)
		return a.percent > b.percent or (a.percent == b.percent) and a.id < b.id
	end)

	local info = {}
	local shortenPerc = function(p)
		if p < 0.01 then return "<0.01%"
		elseif p < 0.1 then return string.format("%.2f%%", p)
		else return string.format("%.1f%%", p) end
	end
	local extraMons = 0
	for _, revoMon in ipairs(revo or {}) do
		if #info < MAX_ITEMS then
			local mon = PokemonData.POKEMON[revoMon.id + 1]
			if mon then
				table.insert(info, string.format("%s %s", mon.name, shortenPerc(revoMon.percent)))
			end
		else
			extraMons = extraMons + 1
		end
	end
	if extraMons > 0 then
		table.insert(info, string.format("(+%s more Pok" .. Chars.accentedE .. "mon)", extraMons))
	end
	local prefix = string.format("%s Evos %s", pokemon.name or "N/A", OUTPUT_CHAR)
	return buildResponse(prefix, info, ", ")
end

---@param params string?
---@return string response
function EventData.getCoverage(params)
	local calcFromLead = true
	local onlyFullyEvolved = false
	local moveTypes = {}
	if params ~= nil and params ~= "" then
		-- Remove any list commas
		params = (params:gsub(",%s*", " "))
		for _, word in ipairs(MiscUtils.split(params, " ", true) or {}) do
			if NetworkUtils.containsText(word, "evolve") or NetworkUtils.containsText(word, "fully") then
				onlyFullyEvolved = true
			else
				local moveType = findPokemonType(word)
				if moveType and PokemonData.POKEMON_TYPES[moveType] and moveType ~= "EMPTY" then
					calcFromLead = false
					table.insert(moveTypes, PokemonData.POKEMON_TYPES[moveType])
				end
			end
		end
	end
	local leadPokemon = Network.Data.program.getPlayerPokemon() or {}
	if calcFromLead and leadPokemon.moveIDs then
		for _, moveID in pairs(leadPokemon.moveIDs) do
			if moveID > 0 then
				local moveData = MoveData.MOVES[moveID + 1]
				local moveType = moveData.type
				if moveData.name == "Hidden Power" then
					moveType = Network.Data.tracker.getCurrentHiddenPowerType()
				end
				if moveData.category ~= MoveData.MOVE_CATEGORIES.STATUS and moveData.power ~= "---" then
					if not MiscUtils.tableContains(moveTypes, moveType) then
						table.insert(moveTypes, moveType)
					end
				end
			end
		end
	end
	if #moveTypes == 0 then
		return buildDefaultResponse(params)
	end

	-- Copied most of the below code from CoverageCalcScreen
	local effectivenessTable = {
		[0.0] = { ids = {}, total = 0 },
		[0.25] = { ids = {}, total = 0 },
		[0.5] = { ids = {}, total = 0 },
		[1.0] = { ids = {}, total = 0 },
		[2.0] = { ids = {}, total = 0 },
		[4.0] = { ids = {}, total = 0 }
	}
	local function getMoveEffectivenessAgainstPokemon(moveType, pokemonData)
		local effectiveness = 1.0
		for _, defenseType in pairs(pokemonData.type) do
			if defenseType ~= PokemonData.POKEMON_TYPES.EMPTY and MoveData.EFFECTIVE_DATA[moveType][defenseType] then
				effectiveness = effectiveness * MoveData.EFFECTIVE_DATA[moveType][defenseType]
			end
		end
		if pokemonData.name == "Shedinja" and effectiveness < 2.0 then
			return 0.0
		end
		return effectiveness
	end
	local function calculateMovesAgainstPokemon(moveTypeList, internalId)
		local max = 0.0
		for _, moveType in pairs(moveTypeList) do
			local pokemonData = PokemonData.POKEMON[internalId]
			local effectiveness = getMoveEffectivenessAgainstPokemon(moveType, pokemonData)
			if effectiveness > max then
				max = effectiveness
			end
		end
		table.insert(effectivenessTable[max].ids, internalId)
		effectivenessTable[max].total = effectivenessTable[max].total + 1
	end

	-- Check against all (most) pokemon
	for internalId, pokemon in pairs(PokemonData.POKEMON) do
		local valid = internalId > 1
		if PokemonData.ALTERNATE_FORMS[pokemon.name] and PokemonData.ALTERNATE_FORMS[pokemon.name].cosmetic == true then
			valid = false
		elseif onlyFullyEvolved then
			valid = valid and (pokemon.evolution == PokemonData.EVOLUTION_TYPES.NONE)
		end
		if valid then
			calculateMovesAgainstPokemon(moveTypes, internalId)
		end
	end
	-- Not needed, unless you want to display a list of threats by most resistant
	-- for _, data in pairs(effectivenessTable) do
	-- 	table.sort(data.ids, function(id1, id2)
	-- 		return PokemonData.POKEMON[id1].bst > PokemonData.POKEMON[id2].bst
	-- 	end)
	-- end

	local info = {}
	local multipliers = {}
	for key, _ in pairs(effectivenessTable) do
		table.insert(multipliers, key)
	end
	table.sort(multipliers, function(a,b) return a < b end)
	for _, mult in ipairs(multipliers) do
		local effectiveList = effectivenessTable[mult] or {}
		if effectiveList.total and effectiveList.total > 0 then
			local format = "[%0dx] %s"
			if mult == 0.5 then
				format = "[%0.1fx] %s"
			elseif mult == 0.25 then
				format = "[%0.2fx] %s"
			end
			table.insert(info, string.format(format, mult, effectiveList.total))
		end
	end

	local typesText = NetworkUtils.firstToUpperEachWord(table.concat(moveTypes, ", "):lower())
	local fullyEvoText = onlyFullyEvolved and " Fully Evolved" or ""
	local prefix = string.format("Coverage (%s)%s %s", typesText, fullyEvoText, OUTPUT_CHAR)
	if calcFromLead and PokemonData.POKEMON[leadPokemon.pokemonID + 1] then
		prefix = string.format("%s's %s", PokemonData.POKEMON[leadPokemon.pokemonID + 1].name, prefix)
	end
	return buildResponse(prefix, info, ", ")
end

---@param params string?
---@return string response
function EventData.getHeals(params)
	local displayHP, displayStatus, displayPP, displayBerries
	if (params or "") ~= "" then
		displayHP = NetworkUtils.containsText(params, "hp")
		displayPP = NetworkUtils.containsText(params, "pp")
		displayStatus = NetworkUtils.containsText(params, "status")
		displayBerries = NetworkUtils.containsText(params, "berries")
	end
	-- Default to showing all (except redundant berries)
	if not (displayHP or displayPP or displayStatus or displayBerries) then
		displayHP = true
		displayPP = true
		displayStatus = true
	end

	local info = {}
	local function sortFunc(a,b) return a.value > b.value or (a.value == b.value and a.id < b.id) end
	local function getSortableItem(id, quantity)
		if not ItemData.ITEMS[id or -1] or (quantity or 0) <= 0 then return nil end
		local item = ItemData.HEALING_ITEMS[id] or ItemData.PP_ITEMS[id] or ItemData.STATUS_ITEMS[id] or {}
		local text = ItemData.ITEMS[id].name
		if quantity > 1 then
			text = string.format("%s (%s)", text, quantity)
		end
		local value = item.amount or 0
		if item.type == ItemData.HEALING_TYPE.PERCENTAGE then
			value = value + 1000
		elseif item.type == MiscData.STATUS_TYPE.ALL then -- The really good status items
			value = value + 2
		elseif ItemData.STATUS_ITEMS[id] then -- All other status items
			value = value + 1
		end
		return { id = id, text = text, value = value }
	end
	local function sortAndCombine(label, items)
		table.sort(items, sortFunc)
		local t = {}
		for _, item in ipairs(items) do table.insert(t, item.text) end
		table.insert(info, string.format("[%s] %s", label, table.concat(t, ", ")))
	end
	local healingItems, ppItems, statusItems, berryItems = {}, {}, {}, {}
	for id, quantity in pairs(Network.Data.program.getHealingItems() or {}) do
		local itemInfo = getSortableItem(id, quantity)
		if itemInfo then
			table.insert(healingItems, itemInfo)
			local itemData = ItemData.HEALING_ITEMS[id]
			if displayBerries and itemData and NetworkUtils.containsText(itemData.name, "Berry") then
				table.insert(berryItems, itemInfo)
			end
		end
	end
	for id, quantity in pairs(Network.Data.program.getPPItems() or {}) do
		local itemInfo = getSortableItem(id, quantity)
		if itemInfo then
			table.insert(ppItems, itemInfo)
			local itemData = ItemData.PP_ITEMS[id]
			if displayBerries and itemData and NetworkUtils.containsText(itemData.name, "Berry") then
				table.insert(berryItems, itemInfo)
			end
		end
	end
	for id, quantity in pairs(Network.Data.program.getStatusItems() or {}) do
		local itemInfo = getSortableItem(id, quantity)
		if itemInfo then
			table.insert(statusItems, itemInfo)
			local itemData = ItemData.STATUS_ITEMS[id]
			if displayBerries and itemData and NetworkUtils.containsText(itemData.name, "Berry") then
				table.insert(berryItems, itemInfo)
			end
		end
	end
	if displayHP and #healingItems > 0 then
		sortAndCombine("HP", healingItems)
	end
	if displayPP and #ppItems > 0 then
		sortAndCombine("PP", ppItems)
	end
	if displayStatus and #statusItems > 0 then
		sortAndCombine("Status", statusItems)
	end
	if displayBerries and #berryItems > 0 then
		sortAndCombine("Berries", berryItems)
	end
	local prefix = string.format("Heals %s", OUTPUT_CHAR)
	return buildResponse(prefix, info)
end

--- Function not yet implemented
---@param params string?
---@return string response
function EventData.getTMsHMs(params)
	-- TODO: Implement this function
	if true then return buildDefaultResponse(params) end
	local info = {}
	local prefix = string.format("TMs %s", OUTPUT_CHAR)

	local singleTmLookup
	local displayGym, displayNonGym, displayHM
	if params and (params or "") ~= "" then
		displayGym = NetworkUtils.containsText(params, "gym")
		displayHM = NetworkUtils.containsText(params, "hm")
		singleTmLookup = tonumber(params:match("(%d+)") or "")
	end
	-- Default to showing just tms (gym & other)
	if not displayGym and not displayHM and not singleTmLookup then
		displayGym = true
		displayNonGym = true
	end
	-- local tms, hms = Network.Data.program.getTMsHMsBagItems()

	return buildResponse(prefix, info)
end

---@param params string?
---@return string response
function EventData.getSearch(params)
	local helpResponse = "Search tracked info for a Pok" .. Chars.accentedE .. "mon, move, or ability."
	if (params or "") == "" then
		return buildResponse(params, helpResponse)
	end

	-- Determine if the search is for an ability, move, or pokemon
	local function determineSearchMode(input)
		local searchMode, searchId, closestDistance = nil, -1, 9999
		local tempId, tempDist = findAbilityId(input, 4)
		if (tempId or 0) > 0 and tempDist < closestDistance then
			searchMode = "ability"
			searchId = tempId
			closestDistance = tempDist
			if closestDistance == 0 then -- exact match
				return searchMode, searchId
			end
		end
		tempId, tempDist = findMoveId(input, 4)
		if (tempId or 0) > 0 and tempDist < closestDistance then
			searchMode = "move"
			searchId = tempId
			closestDistance = tempDist
			if closestDistance == 0 then -- exact match
				return searchMode, searchId
			end
		end
		tempId, tempDist = findPokemonId(input, 4)
		if (tempId or 0) > 0 and tempDist < closestDistance then
			searchMode = "pokemon"
			searchId = tempId
			closestDistance = tempDist
			if closestDistance == 0 then -- exact match
				return searchMode, searchId
			end
		end
		return searchMode, searchId
	end

	local searchMode, searchId = determineSearchMode(params)
	if not searchMode then
		local prefix = string.format("%s %s", params, OUTPUT_CHAR)
		return buildResponse(prefix, "Can't find a Pok" .. Chars.accentedE .. "mon, move, or ability with that name.")
	end

	local trackedIds = Network.Data.tracker.getTrackedIDs() or {}

	local info = {}
	if searchMode == "pokemon" then
		local pokemon = PokemonData.POKEMON[searchId + 1]
		if not pokemon or not MiscUtils.tableContains(trackedIds, searchId) then
			return buildDefaultResponse(params)
		end
		-- Tracked Abilities
		local trackedAbilities = {}
		for abilityId, _ in ipairs(Network.Data.tracker.getAbilities(searchId) or {}) do
			if AbilityData.ABILITIES[abilityId + 1] then
				table.insert(trackedAbilities, AbilityData.ABILITIES[abilityId + 1].name)
			end
		end
		if #trackedAbilities > 0 then
			table.insert(info, string.format("Abilities: %s", table.concat(trackedAbilities, ", ")))
		end
		-- Tracked Stat Markings
		local statMarksToAdd = {}
		local trackedStatMarkings = Network.Data.tracker.getStatPredictions(searchId) or {}
		for _, statKey in ipairs({"HP", "ATK", "DEF", "SPA", "SPD", "SPE"}) do
			local markVal = trackedStatMarkings[statKey]
			if markVal > 1 then
				local marking = Graphics.MAIN_SCREEN_CONSTANTS.STAT_PREDICTION_STATES[markVal] or {}
				if marking.text then
					local symbol = string.sub(marking.text, 1, 1)
					if symbol == "_" then
						symbol = "-"
					end
					table.insert(statMarksToAdd, string.format("%s(%s)", statKey:upper(), symbol))
				end
			end
		end
		if #statMarksToAdd > 0 then
			table.insert(info, string.format("Stats: %s", table.concat(statMarksToAdd, ", ")))
		end
		-- Tracked Moves
		local extra = 0
		local trackedMoves = {}
		for _, moveInfo in ipairs(Network.Data.tracker.getMoves(searchId) or {}) do
			local moveId, moveLv = moveInfo.move or 0, moveInfo.level or 0
			if moveId > 0 and moveLv > 0 and MoveData.MOVES[moveId + 1] then
				if #trackedMoves < MAX_ITEMS then
					table.insert(trackedMoves, string.format("%s (Lv.%s)", MoveData.MOVES[moveId + 1].name, moveLv))
				else
					extra = extra + 1
				end
			end
		end
		if #trackedMoves > 0 then
			table.insert(info, string.format("Moves: %s", table.concat(trackedMoves, ", ")))
			if extra > 0 then
				table.insert(info, string.format("(+%s more)", extra))
			end
		end
		-- Tracked Encounters
		local amountSeen = Network.Data.tracker.getAmountSeen(searchId) or 0
		if amountSeen > 0 then
			table.insert(info, string.format("Amount seen: %s", amountSeen))
		end
		-- Tracked Notes
		local trackedNote = Network.Data.tracker.getNote(searchId)
		if trackedNote and trackedNote ~= "" then
			table.insert(info, string.format("Note: %s", trackedNote))
		end
		local prefix = string.format("Tracked %s %s", pokemon.name, OUTPUT_CHAR)
		return buildResponse(prefix, info)
	elseif searchMode == "move" or searchMode == "moves" then
		local move = MoveData.MOVES[searchId + 1]
		if not move then
			return buildDefaultResponse(params)
		end
		local moveId = tonumber(searchId) or 0
		local foundMons = {}
		for _, pokemonID in pairs(trackedIds) do
			for _, trackedMove in ipairs(Network.Data.tracker.getMoves(pokemonID) or {}) do
				if trackedMove.move == moveId and trackedMove.level > 0 then
					local pokemon = PokemonData.POKEMON[pokemonID + 1]
					if pokemon then
						local notes = string.format("%s (Lv.%s)", pokemon.name, trackedMove.level)
						table.insert(foundMons, { id = pokemonID, bst = tonumber(pokemon.bst or "0"), notes = notes})
						break
					end
				end
			end
		end
		table.sort(foundMons, function(a,b) return a.bst > b.bst or (a.bst == b.bst and a.id < b.id) end)
		local extra = 0
		for _, mon in ipairs(foundMons) do
			if #info < MAX_ITEMS then
				table.insert(info, mon.notes)
			else
				extra = extra + 1
			end
		end
		if extra > 0 then
			table.insert(info, string.format("(+%s more Pok" .. Chars.accentedE .. "mon)", extra))
		end
		local prefix = string.format("%s %s %s Pok" .. Chars.accentedE .. "mon:", move.name, OUTPUT_CHAR, #foundMons)
		return buildResponse(prefix, info, ", ")
	elseif searchMode == "ability" or searchMode == "abilities" then
		local ability = AbilityData.ABILITIES[searchId + 1]
		if not ability then
			return buildDefaultResponse(params)
		end
		local foundMons = {}
		for _, pokemonID in pairs(trackedIds) do
			for abilityId, _ in ipairs(Network.Data.tracker.getAbilities(pokemonID) or {}) do
				if abilityId == searchId then
					local pokemon = PokemonData.POKEMON[pokemonID + 1]
					if pokemon then
						table.insert(foundMons, { id = pokemonID, bst = tonumber(pokemon.bst or "0"), notes = pokemon.name })
						break
					end
				end
			end
		end
		if #foundMons == 0 and ability.name then
			-- Try searching through notes for ability names
			for _, pokemonID in pairs(trackedIds) do
				local note = Network.Data.tracker.getNote(pokemonID)
				if note ~= "" and NetworkUtils.containsText(note, ability.name) then
					local pokemon = PokemonData.POKEMON[pokemonID + 1]
					if pokemon then
						table.insert(foundMons, { id = pokemonID, bst = tonumber(pokemon.bst or "0"), notes = pokemon.name })
					end
				end
			end
		end
		table.sort(foundMons, function(a,b) return a.bst > b.bst or (a.bst == b.bst and a.id < b.id) end)
		local extra = 0
		for _, mon in ipairs(foundMons) do
			if #info < MAX_ITEMS then
				table.insert(info, mon.notes)
			else
				extra = extra + 1
			end
		end
		if extra > 0 then
			table.insert(info, string.format("(+%s more Pok" .. Chars.accentedE .. "mon)", extra))
		end
		local prefix = string.format("%s %s %s Pok" .. Chars.accentedE .. "mon:", ability.name, OUTPUT_CHAR, #foundMons)
		return buildResponse(prefix, info, ", ")
	end
	-- Unused
	local prefix = string.format("%s %s", params, OUTPUT_CHAR)
	return buildResponse(prefix, helpResponse)
end

---@param params string?
---@return string response
function EventData.getSearchNotes(params)
	if (params or "") == "" then
		return buildDefaultResponse(params)
	end

	local info = {}
	local foundMons = {}
	for _, pokemonID in ipairs(Network.Data.tracker.getTrackedIDs() or {}) do
		local note = Network.Data.tracker.getNote(pokemonID)
		if note ~= "" and NetworkUtils.containsText(note, params) then
			local pokemon = PokemonData.POKEMON[pokemonID + 1]
			if pokemon then
				table.insert(foundMons, { id = pokemonID, bst = tonumber(pokemon.bst or "0"), notes = pokemon.name })
			end
		end
	end
	table.sort(foundMons, function(a,b) return a.bst > b.bst or (a.bst == b.bst and a.id < b.id) end)
	local extra = 0
	for _, mon in ipairs(foundMons) do
		if #info < MAX_ITEMS then
			table.insert(info, mon.notes)
		else
			extra = extra + 1
		end
	end
	if extra > 0 then
		table.insert(info, string.format("(+%s more Pok" .. Chars.accentedE .. "mon)", extra))
	end
	local prefix = string.format("%s: \"%s\" %s %s Pok" .. Chars.accentedE .. "mon:", "Note", params, OUTPUT_CHAR, #foundMons)
	return buildResponse(prefix, info, ", ")
end

---@param params string?
---@return string response
function EventData.getFavorites(params)
	-- Read favorites directly from file, as they aren't really stored anywhere accessible
	local fileName = "savedData" .. Paths.SLASH .. Network.Data.gameInfo.NAME .. ".faves"
	local favesFromFile = MiscUtils.readStringFromFile(fileName)
	if favesFromFile == nil or favesFromFile == "" then
		return buildDefaultResponse(params)
	end

	local info = {}
	local favesList = MiscUtils.split(favesFromFile, ",", true) or {}
	for i = 1, Network.Data.gameInfo.GEN, 1 do
		local pokemonID = tonumber(favesList[i]) or -2
		local name
		if PokemonData.POKEMON[pokemonID + 1] then
			name = PokemonData.POKEMON[pokemonID + 1].name
		else
			name = "---"
		end
		table.insert(info, string.format("#%s %s", i, name))
	end
	local prefix = string.format("Favorites %s", OUTPUT_CHAR)
	return buildResponse(prefix, info, ", ")
end

---@param params string?
---@return string response
function EventData.getTheme(params)
	local info = {}
	local themeCode = ThemeFactory.getThemeString()
	table.insert(info, themeCode)
	local prefix = string.format("%s %s", "Current Theme", OUTPUT_CHAR)
	return buildResponse(prefix, info)
end

--- Function not yet implemented
---@param params string?
---@return string response
function EventData.getGameStats(params)
	-- NOTE: This datapoint is not implemented
	if true then return buildDefaultResponse(params) end
	local info = {}

	-- Can populate list with some fun statistics. GBA Tracker uses:
	-- PlayTime, TotalAttempts, PCHealCount, NumTrainerBattles, NumWildEncounters
	-- NumPokemonCaught, NumShopPurchases, NumGameSaves, TotalSteps, NumStrugglesUsed

	local prefix = string.format("Game Stats %s", OUTPUT_CHAR)
	return buildResponse(prefix, info)
end

---@param params string?
---@return string response
function EventData.getProgress(params)
	local info = {}

	-- Gym Badges
	local badges = Network.Data.program.getBadges()
	local setsToCheck = { badges.firstSet }
	if Network.Data.gameInfo.NAME == "Pokemon HeartGold" or Network.Data.gameInfo.NAME == "Pokemon SoulSilver" then
		table.insert(setsToCheck, badges.secondSet)
	end
	local badgesObtained, maxBadges = 0, 0
	for _, badgeSet in ipairs(setsToCheck) do
		for _, val in ipairs(badgeSet) do
			if val > 0 then
				badgesObtained = badgesObtained + 1
			end
			maxBadges = maxBadges + 1
		end
	end
	table.insert(info, string.format("Gym badges: %s/%s", badgesObtained, maxBadges))

	-- Trainers Defeated
	-- local totalDefeated, totalTrainers = 0, 0
	-- for mapId, route in pairs(RouteData.Info) do
	-- 	if route.trainers and #route.trainers > 0 then
	-- 		local defeatedTrainers, totalInRoute = Program.getDefeatedTrainersByLocation(mapId, saveBlock1Addr)
	-- 		totalDefeated = totalDefeated + #defeatedTrainers
	-- 		totalTrainers = totalTrainers + totalInRoute
	-- 	end
	-- end
	-- table.insert(info, string.format("Trainers defeated: %s/%s (%0.1f%%)",
	-- 	totalDefeated,
	-- 	totalTrainers,
	-- 	totalDefeated / totalTrainers * 100))

	-- Pokemon seen fully evolved
	local trackedIDs = Network.Data.tracker.getTrackedIDs()
	local fullyEvolvedSeen, fullyEvolvedTotal = 0, 0
	-- local legendarySeen, legendaryTotal = 0, 0  --, Legendary: %s/%s (%0.1f%%)",
	for pokemonID, pokemon in ipairs(PokemonData.POKEMON) do
		if pokemon.evolution == PokemonData.EVOLUTION_TYPES.NONE then
			fullyEvolvedTotal = fullyEvolvedTotal + 1
			if MiscUtils.tableContains(trackedIDs, pokemonID) then -- could be inefficient
				fullyEvolvedSeen = fullyEvolvedSeen + 1
			end
		end
	end
	table.insert(info, string.format("Pok" .. Chars.accentedE .. "mon seen fully evolved: %s/%s (%0.1f%%)",
		fullyEvolvedSeen,
		fullyEvolvedTotal,
		fullyEvolvedSeen / fullyEvolvedTotal * 100))

	local prefix = string.format("Progress %s", OUTPUT_CHAR)
	return buildResponse(prefix, info)
end

---@param params string?
---@return string response
function EventData.getLog(params)
	-- TODO: add "previous" as a parameter; requires storing this information somewhere
	local prefix = string.format("%s %s", "Log", OUTPUT_CHAR)
	local pokemonList = Network.Data.logInfo and Network.Data.logInfo.getPokemon() or {}
	if #pokemonList == 0 then
		return buildResponse(prefix, "This game's log file hasn't been opened yet.")
	end

	local miscInfo = Network.Data.logInfo.getMiscInfo() or {}
	local info = {}
	table.insert(info, string.format("Game: %s", Network.Data.gameInfo.NAME or "N/A"))
	table.insert(info, string.format("Randomizer: %s", miscInfo.version or "N/A"))
	table.insert(info, string.format("Random Seed: %s", miscInfo.seed or "N/A"))
	table.insert(info, string.format("Settings String: %s", miscInfo.settingsString or "N/A"))

	return buildResponse(prefix, info)
end

---@param params string?
---@return string response
function EventData.getBallQueue(params)
	local prefix = string.format("BallQueue %s", OUTPUT_CHAR)

	local info = {}

	local queueSize = 0
	for _, _ in pairs(EventHandler.Queues.BallRedeems.Requests or {}) do
		queueSize = queueSize + 1
	end
	if queueSize == 0 then
		return buildResponse(prefix, "The pick ball queue is empty.")
	end
	table.insert(info, string.format("Size: %s", queueSize))

	local request = EventHandler.Queues.BallRedeems.ActiveRequest
	if request and request.Username then
		table.insert(info, string.format("Current pick: %s - %s", request.Username, request.SanitizedInput or "N/A"))
	end

	return buildResponse(prefix, info)
end

---@param params string?
---@return string response
function EventData.getAbout(params)
	local info = {}
	table.insert(info, string.format("Version: %s", MiscConstants.TRACKER_VERSION))
	table.insert(info, string.format("Game: %s", Network.Data.gameInfo.NAME or "N/A"))
	table.insert(info, string.format("Attempts: %s", Network.Data.seedLogger.getTotalRuns() or 1))
	table.insert(info, string.format("Streamerbot Code: v%s", Network.currentStreamerbotVersion or "N/A"))
	local prefix = string.format("NDS Ironmon Tracker %s", OUTPUT_CHAR)
	return buildResponse(prefix, info)
end

---@param params string?
---@return string response
function EventData.getHelp(params)
	local availableCommands = {}
	for _, event in pairs(EventHandler.Events or {}) do
		if event.Type == EventHandler.EventTypes.Command and event.Command and event.IsEnabled then
			availableCommands[event.Command] = event
		end
	end
	local info = {}
	if params ~= nil and params ~= "" then
		local paramsAsLower = params:lower()
		if paramsAsLower:sub(1, 1) ~= EventHandler.COMMAND_PREFIX then
			paramsAsLower = EventHandler.COMMAND_PREFIX .. paramsAsLower
		end
		local command = availableCommands[paramsAsLower]
		if not command or (command.Help or "") == "" then
			return buildDefaultResponse(params)
		end
		table.insert(info, string.format("%s %s", paramsAsLower, command.Help))
	else
		for commandWord, _ in pairs(availableCommands) do
			table.insert(info, commandWord)
		end
		table.sort(info, function(a,b) return a < b end)
	end
	local prefix = string.format("Tracker Commands %s", OUTPUT_CHAR)
	return buildResponse(prefix, info, ", ")
end
State = {
	TRACKER = "Tracker",
	SETTINGS = "Settings",
	COLOR_CUSTOMIZING = "Color Customizing",
	COLOR_PICKER_DIALOG = "Color Picking Dialog",
}

Program = {
	battleDataFetched = false,
	playerBattleTeamPIDs = {},
	enemyBattleTeamPIDs = {},
	playerMonIndex = 0,
	enemyMonIndex = 0,
	lastValidPlayerBattlePID = -1,
	lastValidEnemyBattlePID = -1,

	GEN5_activePlayerMonPID = 0,
	GEN5_activeEnemyMonPID = 0,

	frameCounter = 0,

	state = State.TRACKER,

	firstBattleComplete = false
}

Program.tracker = {
	movesToUpdate = {},
	abilitiesToUpdate = {},
	itemsToUpdate = {},
}

Program.StatButtonState = {
	hp = 1,
	att = 1,
	def = 1,
	spa = 1,
	spd = 1,
	spe = 1
}

Program.transformedPokemon = {
	isTransformed = false,
	forceSwitch = false,
}

Program.eventCallbacks = {}

function Program.main()
	Input.update()
	if Program.state == State.TRACKER then
		Program.updateTracker()
		if Program.frameCounter == 300 then
			Tracker.saveData()
			Program.frameCounter = 0
		end
		if Tracker.waitFrames == 0 then
			local battleStatus = memory.read_u16_le(GameSettings.battleStatus)

			if battleStatus == 0x2100 or battleStatus == 0x2101 then
				if Tracker.Data.inBattle == 0 then
					--Just started battle.
					Program.battleDataFetched = false
					Program.playerBattleTeamPIDs = {}
					Program.enemyBattleTeamPIDs = {}
					Program.battleDataFetched = Program.tryToFetchBattleData()
				end
				Tracker.Data.inBattle = 1
			else
				if Tracker.Data.inBattle == 1 then
					Program.firstBattleComplete = true
				end
				Tracker.Data.inBattle = 0
			end
			if Tracker.Data.inBattle ~= 1 then
				Tracker.Data.selectedPlayer = 1
			end
			if Tracker.Data.inBattle == 1 and not Program.battleDataFetched then
				Program.battleDataFetched = Program.tryToFetchBattleData()
			end
			local canUpdate = true
			if not Settings.tracker.SHOW_1ST_FIGHT_STATS_IN_PLATINUM
			and Program.firstBattleComplete == false and GameSettings.gamename == "Pokemon Platinum" then
				canUpdate = false
			end
			if canUpdate then
				Program.UpdatePlayerPokemonData()
			end
			Program.UpdateEnemyPokemonData()

			Program.UpdateBagHealingItems()
			Program.checkEnemyPP()
			Program.updateStatStages()
			if Tracker.Data.inBattle == 1 and Tracker.Data.enemyPokemon ~= nil then
				Program.StatButtonState = Tracker.getButtonState()
				Buttons = Program.updateButtons(Program.StatButtonState)
			end
			Drawing.DrawTracker(Tracker.Data.selectedPlayer==2)

			Tracker.waitFrames = 30
		end

		if Tracker.waitFrames > 0 then
			Tracker.waitFrames = Tracker.waitFrames - 1
			Program.frameCounter = Program.frameCounter + 1
		end
	elseif Program.state == State.SETTINGS then
		if Options.redraw then
			Drawing.drawSettings()
			Options.redraw = false
		end
	elseif Program.state == State.COLOR_CUSTOMIZING or Program.state == State.COLOR_PICKER_DIALOG then	
		if Tracker.waitFrames == 0 and ColorOptions.redraw then
			Drawing.drawColorOptions()
			Drawing.DrawTracker(false)
			Tracker.waitFrames = 5
		end
		if Tracker.waitFrames > 0 then
			Tracker.waitFrames = Tracker.waitFrames - 1
		end
	end
	if Program.state == State.COLOR_PICKER_DIALOG then
		client.unpause()
	end
end

function Program.updateTracker()
		-- Update moves in the tracker
		for _, move in ipairs(Program.tracker.movesToUpdate) do
			Tracker.TrackMove(move.pokemonId, move.move, move.level)
		end
		Program.tracker.movesToUpdate = {}

		-- Update abilities in the tracker
		for _, ability in ipairs(Program.tracker.abilitiesToUpdate) do
			Tracker.TrackAbility(ability.pokemonId, ability.abilityId)
		end
		Program.tracker.abilitiesToUpdate = {}

		-- Update items in the tracker
		for _, item in ipairs(Program.tracker.itemsToUpdate) do
			Tracker.TrackItem(item.pokemonId, item.itemId)
		end
		Program.tracker.items = {}

		for _, callback in ipairs(Program.eventCallbacks) do
			callback()
		end
		Program.eventCallbacks = {}
end

function Program.checkEnemyPP()
	if Tracker.Data.inBattle == 1 then
		local target = Tracker.Data.enemyPokemon
		if target ~= nil then
			for i,moveValue in pairs(target.actualMoves) do
				local data = MoveData[moveValue+1]
				local currentPP = target.movePPs[i]
				local maxPP = data.pp
				if data.id ~= "---" then
					if currentPP < tonumber(maxPP) then
						table.insert(Program.tracker.movesToUpdate, { pokemonId = target.pokemonID + 1, move = moveValue+1, level = target.level })
					end
				end
			end
		end
	end	
end

function Program.checkForPlayerTransform()
	local activePID = Program.getPlayerBattleMonPID()
	if Program.enemyBattleTeamPIDs[activePID] ~= nil then
		return true
	end
	return false
end

function Program.getPlayerBattleMonPID()
	local activePID = memory.read_u32_le(GameSettings.playerBattleMonPID)
	if GameSettings.gen == 5 then
		activePID = Program.GEN5_activePlayerMonPID
	end
	if activePID == 0 then
		return memory.read_u32_le(GameSettings.playerBattleBase)
	else
		return activePID
	end
end

function Program.checkForEnemyTransform()
	local activePID = Program.getEnemyBattleMonPID()
	if Program.playerBattleTeamPIDs[activePID] ~= nil then
		return true
	end
	return false
end

function Program.getEnemyBattleMonPID()
	local activePID = memory.read_u32_le(GameSettings.enemyBattleMonPID)
	if GameSettings.gen == 5 then
		activePID = Program.GEN5_activeEnemyMonPID
	end
	if activePID  == 0 then
		return memory.read_u32_le(GameSettings.enemyBase)
	else
		return activePID
	end
end


function Program.tryToFetchBattleData()
	local firstPlayerPID = memory.read_u32_le(GameSettings.playerBattleBase)
	local firstEnemyPID = memory.read_u32_le(GameSettings.enemyBase)
	if firstPlayerPID == 0 or firstEnemyPID == 0 then return false end

	local currentBase = GameSettings.playerBattleBase

	for i = 0,5,1 do
		local pid = memory.read_u32_le(currentBase)
		if pid ~= 0 then
			Program.playerBattleTeamPIDs[pid] = i
		else
			break
		end
		currentBase = currentBase + Decrypter.pokemonDataSize
	end

	currentBase = GameSettings.enemyBase
	for i = 0,5,1 do
		local pid = memory.read_u32_le(currentBase)
		if pid ~= 0 then
			Program.enemyBattleTeamPIDs[pid] = i
		else
			break
		end
		currentBase = currentBase + Decrypter.pokemonDataSize
	end

	return true
end

function Program.HandleExit()
	Drawing.clearGUI()
	forms.destroyall()
end

function Program.UpdatePlayerPokemonData()
	local pokemonaux = Program.getPokemonData({ player = 1, slot = Tracker.Data.selectedSlot })
	if Program.validPokemonData(pokemonaux) then
		Tracker.Data.playerPokemon = pokemonaux
	end
end

function Program.UpdateEnemyPokemonData()
	if Tracker.Data.inBattle == 1 then
		local pokemontarget = Program.getPokemonData({ player = 2, slot = Tracker.Data.targetSlot })
		if Program.validPokemonData(pokemontarget) then
			Tracker.Data.enemyPokemon = pokemontarget
		else
			Tracker.Data.enemyPokemon = nil
		end
		if Tracker.Data.enemyPokemon ~= nil then
			if Tracker.Data.enemyPokemon.pokemonID ~= nil then
				Tracker.Data.enemyPokemon.moves = Tracker.getMoves(Tracker.Data.enemyPokemon.pokemonID + 1)
				Tracker.Data.enemyPokemon.abilities = Tracker.getAbilities(Tracker.Data.enemyPokemon.pokemonID + 1)
			end
		end
	else
		Tracker.Data.enemyPokemon = nil
	end
end

function Program.UpdateBagHealingItems()
	local healingItems = Program.getBagHealingItemsGen4(Tracker.Data.playerPokemon)
	if healingItems ~= nil then
		Tracker.Data.healingItems = healingItems
	end
end

function Program.updateButtons(state)
	local stats = {
		"hp","att","def","spa","spd","spe"
	}
	for i = 1,6,1 do
		local stat = stats[i]
		Buttons[i].text = StatButtonStates[state[stat]]
		Buttons[i].textcolor = StatButtonColors[state[stat]]
	end
	return Buttons
end

function Program.getPokemonData(index)
	if GameSettings.gen == 5 then
		Program.GEN5_checkLastSwitchin()
	end
	if index.player == 1 then 
		return Program.getPokemonDataPlayer()
	else
		return Program.getPokemonDataEnemy()
	end
end

function Program.updateStatStages()
	if Tracker.Data.inBattle == 1 and Program.battleDataFetched then
		if GameSettings.gen == 5 then
			Decrypter.currentBase = GameSettings.statStagesStart
		else
			if Tracker.Data.selectedPlayer == 2 then
				Decrypter.currentBase = GameSettings.statStagesEnemy
			else
				Decrypter.currentBase = GameSettings.statStagesPlayer
			end
		end
		if Tracker.Data.enemyPokemon~= nil and Tracker.Data.playerPokemon ~= nil then
			Tracker.Data.enemyPokemon.statStages = Decrypter.readBattleStatStages(true, Program.enemyMonIndex)
			Tracker.Data.playerPokemon.statStages = Decrypter.readBattleStatStages(false, Program.playerMonIndex)
		end
	end
end

function Program.getPokemonDataPlayer()
	if Tracker.Data.inBattle == 1 and Program.battleDataFetched then 
		local currentBase = GameSettings.playerBattleBase
		local activePID = -1
		local transformed = Program.checkForPlayerTransform()
		if transformed then
			activePID = Program.lastValidPlayerBattlePID
		else
			activePID = Program.getPlayerBattleMonPID()
			Program.lastValidPlayerBattlePID = activePID
		end
		local monIndex = Program.playerBattleTeamPIDs[activePID]
		if monIndex ~= nil then
			Program.playerMonIndex = monIndex
			Decrypter.currentBase = currentBase + monIndex * Decrypter.pokemonDataSize
			return Decrypter.decrypt(false,monIndex,false)
		end
	else
		Decrypter.currentBase = GameSettings.playerBase
		local data = Decrypter.decrypt(true,0,false)
		return data
	end
end

function Program.getPokemonDataEnemy()
	if Tracker.Data.inBattle == 1 
	and memory.read_u16_le(GameSettings.battleStatus) == 0x2101 or memory.read_u16_le(GameSettings.battleStatus) == 0x2100 then
		local currentBase = GameSettings.enemyBase
		local activePID = -1
		local transformed = Program.checkForEnemyTransform()
		if transformed then
			activePID = Program.lastValidEnemyBattlePID
		else
			activePID = Program.getEnemyBattleMonPID()
			Program.lastValidEnemyBattlePID = activePID
		end
		local firstPID = memory.read_u32_le(GameSettings.enemyBase)
		local lastMatchedAddress = 0
		local lastMatchedIndex = 0
		Decrypter.currentBase = currentBase
		for i = 0,5,1 do
			Decrypter.currentBase = currentBase
			firstPID = memory.read_u32_le(currentBase)
			if firstPID == activePID then
				--trainers can have multiple pokes with same PID, need to find first one that is alive
				lastMatchedAddress = currentBase
				lastMatchedIndex = i
				Program.enemyMonIndex = i
				local data = Decrypter.decrypt(false,i,true)
				
				if data ~= nil then
					if next(data) ~= nil then
						if data.curHP > 0 then
							return data
						end
					end
				else
					return nil
				end
			end
			currentBase = currentBase + Decrypter.pokemonDataSize
		end
		if lastMatchedAddress ~= 0 then
			--We found a match but all the enemy's pokemon have fainted, so just use the last match.
			Program.enemyMonIndex = 0
			Decrypter.currentBase = lastMatchedAddress
			return Decrypter.decrypt(false,lastMatchedIndex,true)
		else
			return nil
		end
	end
end

function Program.validPokemonData(pokemonData)
	if pokemonData == nil then return false end
	--Sometimes the player's pokemon stats are just wildly out of bounds(despite having the correct pokemonID), not sure why...
	local STAT_LIMIT = 2000
	local statsToCheck = {
		pokemonData.curHP, pokemonData.maxHP, 
		pokemonData.atk, pokemonData.spe, pokemonData.def, pokemonData.spd, pokemonData.spa
	}
	for _, stat in pairs(statsToCheck) do
		if stat > STAT_LIMIT then return false end
	end
	local id = tonumber(pokemonData["pokemonID"])
	if id ~= nil then
		if id < 0 or id > #PokemonData+1  or pokemonData["heldItem"] < 0 or pokemonData["heldItem"] > #MiscData.item+1 then
			return false
		end
		for i,move in pairs(pokemonData.actualMoves) do
			if move < 0 or move > #MoveData+1 then
				return false
			end
		end
		return true
	end
end

function Program.scanItemsForHeals()
	local healingItems = {}

	local itemStart = Utils.inlineIf(Tracker.Data.inBattle == 1,GameSettings.itemStartBattle,GameSettings.itemStartNoBattle)
	
	--battle can be set a few frames before item bag for battle gets updated, need to check this value as well
	local idAndQuantity = memory.read_u32_le(GameSettings.itemStartBattle)
	local id = bit.band(idAndQuantity,0xFFFF)
	local quantity = bit.band(bit.rshift(idAndQuantity,16),0xFFFF)
	if quantity > 1000 or id > 600 then
		itemStart = GameSettings.itemStartNoBattle
	end
	local addressesToScan = {itemStart}
	if GameSettings.gen == 5 then
		table.insert(addressesToScan,GameSettings.berryBagStart)
	end
	for i,address in pairs(addressesToScan) do
		local currentAddress = address
		local keepScanning = true
		while keepScanning do
			--read 4 bytes at once, should be less expensive than reading 2 sets of 2 bytes..
			local idAndQuantity = memory.read_u32_le(currentAddress)
			local id = bit.band(idAndQuantity,0xFFFF)
			if id ~= 0 then
				local quantity = bit.band(bit.rshift(idAndQuantity,16),0xFFFF)
				healingItems[id] = quantity
				currentAddress = currentAddress + 4
			else
				keepScanning = false
			end
		end
	end
	return healingItems
end

function Program.getBagHealingItemsGen4(pkmn)
	local totals = {
		healing = 0,
		numHeals = 0,
	}
	-- Need a null check before getting maxHP
	if pkmn == nil then
		return totals
	end

	local maxHP = pkmn["maxHP"]
	if maxHP == 0 then
		return totals
	end

	local healingItems = Program.scanItemsForHeals()

	if healingItems ~= nil then
		totals = Program.calculateHealPercent(healingItems,totals,maxHP)
	end
		

	return totals
end

function Program.calculateHealPercent(healingItems,totals, maxHP)
	for id, quantity in pairs(healingItems) do
		local item = MiscData.healingItems_GEN4[id]
		if item ~= nil then
			local healing = 0
			if item.type == HealingType.Constant then
				local percentage = ((item.amount / maxHP) * 100)
				if percentage > 100 then
					percentage = 100
				end
				healing = percentage * quantity
			elseif item.type == HealingType.Percentage then
				healing = item.amount * quantity
			end
			-- Healing is in a percentage compared to the mon's max HP
			totals.healing = totals.healing + healing
			totals.numHeals = totals.numHeals + quantity
		end
	end	
	return totals
end

function Program.GEN5_checkLastSwitchin()
	--In gen 5, there is no active battler PID.
	--Instead, a memory address is updated with the next active mon's PID on switch-in
	--This is for both player/enemy pokemon, they share the same address.
	--So what we do is check this address. If the PID belongs to player/enemy, update accordingly. 

	local lastSwitchAddr = GameSettings.playerBattleMonPID

	local lastSwitchPID = memory.read_u32_le(lastSwitchAddr)
	if Program.playerBattleTeamPIDs[lastSwitchPID] then
		Program.GEN5_activePlayerMonPID = lastSwitchPID
	elseif Program.enemyBattleTeamPIDs[lastSwitchPID] then
		Program.GEN5_activeEnemyMonPID = lastSwitchPID
	end
end
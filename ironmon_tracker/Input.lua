Input = {
	mousetab = {},
	mousetab_prev = {},
	joypad = {},
	noteForm = nil,
}

function Input.update()
	Input.mousetab = input.getmouse()
	if Input.mousetab["Left"] and not Input.mousetab_prev["Left"] then
		local xmouse = Input.mousetab["X"]
		local ymouse = (Input.mousetab["Y"] + 384) /2
		Input.check(xmouse, ymouse)
	end
	Input.mousetab_prev = Input.mousetab

	local joypadButtons = joypad.get()
	-- "Settings.controls.CYCLE_VIEW" pressed
	if joypadButtons[Settings.controls.CYCLE_VIEW] == true and Input.joypad[Settings.controls.CYCLE_VIEW] ~= joypadButtons[Settings.controls.CYCLE_VIEW] then
		if Tracker.Data.inBattle == 1 then
			Tracker.Data.selectedPlayer = (Tracker.Data.selectedPlayer % 2) + 1
			if Tracker.Data.selectedPlayer == 1 then
				Tracker.Data.selectedSlot = 1
				Tracker.Data.targetPlayer = 2
				--Tracker.Data.targetSlot = Memory.readbyte(GameSettings.gBattlerPartyIndexesEnemySlotOne) + 1
			elseif Tracker.Data.selectedPlayer == 2 then
				--local enemySlotOne = Memory.readbyte(GameSettings.gBattlerPartyIndexesEnemySlotOne) + 1
				--Tracker.Data.selectedSlot = enemySlotOne
				Tracker.Data.targetPlayer = 1
				--Tracker.Data.targetSlot = Memory.readbyte(GameSettings.gBattlerPartyIndexesSelfSlotOne) + 1
			end
		end

		Tracker.waitFrames = 0
	end

	-- "Settings.controls.CYCLE_STAT" pressed, display box over next stat
	if joypadButtons[Settings.controls.CYCLE_STAT] == true and Input.joypad[Settings.controls.CYCLE_STAT] ~= joypadButtons[Settings.controls.CYCLE_STAT] then
		Tracker.controller.statIndex = (Tracker.controller.statIndex % 6) + 1
		Tracker.waitFrames = 0
	end

	-- "Settings.controls.NEXT_SEED"
	local allPressed = true
	for button in string.gmatch(Settings.controls.NEXT_SEED, '([^,]+)') do
		if joypadButtons[button] ~= true then
			allPressed = false
		end
	end
	if allPressed == true then
		Main.LoadNextSeed = true
	end

	-- "Settings.controls.CYCLE_PREDICTION" pressed, cycle stat prediction for selected stat
	if joypadButtons[Settings.controls.CYCLE_PREDICTION] == true and Input.joypad[Settings.controls.CYCLE_PREDICTION] ~= joypadButtons[Settings.controls.CYCLE_PREDICTION] then
		Buttons[Tracker.controller.statIndex].onclick()
		Tracker.waitFrames = 0
	end

	Input.joypad = joypadButtons
end

function Input.check(xmouse, ymouse)
	-- Tracker input regions
	if Program.state == State.TRACKER then
		---@diagnostic disable-next-line: deprecated
		for i = 1, table.getn(Buttons), 1 do
			if Buttons[i].visible() then
				if Buttons[i].type == ButtonType.singleButton then
					if Input.isInRange(xmouse, ymouse, Buttons[i].box[1], Buttons[i].box[2], Buttons[i].box[3], Buttons[i].box[4]) then
						Buttons[i].onclick()
						Tracker.waitFrames = 0
					end
				end
			end
		end

		-- settings gear
		if Input.isInRange(xmouse, ymouse, GraphicConstants.SCREEN_WIDTH + 101 - 8, 7, 7, 7) then
			Options.redraw = true
			Program.state = State.SETTINGS
		end

		--note box
		if Input.isInRange(xmouse, ymouse, GraphicConstants.SCREEN_WIDTH + 6, 141, GraphicConstants.RIGHT_GAP - 12, 12) and Input.noteForm == nil then
			Input.noteForm = forms.newform(290, 60, "Note (70 char. max)", function() Input.noteForm = nil end)
			local textBox = forms.textbox(Input.noteForm, Tracker.GetNote(), 200, 20)
			forms.button(Input.noteForm, "Set", function()
				Tracker.SetNote(forms.gettext(textBox))
				forms.destroy(Input.noteForm)
				Input.noteForm = nil
				Tracker.waitFrames = 0
			end, 200, 0)
		end

		-- Settings menu mouse input regions
	elseif Program.state == State.SETTINGS then
		-- Options buttons toggles
		for _, value in pairs(Options.optionsButtons) do
			if Input.isInRange(xmouse, ymouse, value.box[1], value.box[2], GraphicConstants.RIGHT_GAP - (value.box[3] * 2), value.box[4]) then
				value.optionState = value.onClick()
				Options.redraw = true
				Tracker.waitFrames = 0
				INI.save("Settings.ini", Settings)
			end
		end

		-- Roms folder setting
		if Input.isInRange(xmouse, ymouse, Options.romsFolderOption.box[1], Options.romsFolderOption.box[2], GraphicConstants.RIGHT_GAP - (Options.romsFolderOption.box[3] * 2), Options.romsFolderOption.box[4]) then
			-- Use the standard file open dialog to get the roms folder
			local file = forms.openfile(nil, Settings.config.ROMS_FOLDER)
			if file ~= "" then
				-- Since the user had to pick a file, strip out the file name to just get the folder.
				Settings.config.ROMS_FOLDER = string.sub(file, 0, string.match(file, "^.*()\\") - 1)
				INI.save("Settings.ini", Settings)
			end
			Options.redraw = true
			Tracker.waitFrames = 0
		end

		-- Settings close button
		if Input.isInRange(xmouse, ymouse, Options.closeButton.box[1], Options.closeButton.box[2], Options.closeButton.box[3], Options.closeButton.box[4]) then
			Program.state = State.TRACKER
			Tracker.waitFrames = 0
		end
	end
end

--[[
	Checks if a mouse click is within a range and returning true.

	xmouse, ymouse: number -> coordinates of the mouse
	x, y: number -> starting coordinate of the region being tested for clicks
	xregion, yregion -> size of the region being tested from the starting coordinates
]]
function Input.isInRange(xmouse, ymouse, x, y, xregion, yregion)
	if xmouse >= x and xmouse <= x + xregion then
		if ymouse >= y and ymouse <= y + yregion then
			return true
		end
	end
	return false
end

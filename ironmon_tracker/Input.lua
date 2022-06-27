Input = {
	mousetab = {},
	mousetab_prev = {},
	last_keys = {},
	joypad = {},
	noteForm = nil,
	currentColorPicker = nil,
	dialogActive = false,
}

function Input.update()
	if Input.currentColorPicker ~= nil then
		Input.currentColorPicker:handleInput()
	else
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
			if Tracker.Data.inBattle == 1 and Tracker.Data.enemyPokemon ~= nil then
				Buttons[Tracker.controller.statIndex].onclick()
				Tracker.waitFrames = 0
			end
		end

		Input.joypad = joypadButtons
	end
end

function Input.check(xmouse, ymouse)
	if not Input.dialogActive then
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

			--textboxes
			for index, textBox in pairs(ButtonManager.textBoxes) do
				if textBox:visible() then
					if Input.isInRange(xmouse, ymouse, textBox.box[1], textBox.box[2], textBox.box[3], textBox.box[4]) then
						textBox:onClick()
						Tracker.waitFrames = 0
					end
				end
			end

			--badges
			for index, button in pairs(ButtonManager.badgeButtons) do
				if button.visible() then
					if Input.isInRange(xmouse, ymouse, button.box[1], button.box[2], button.box[3], button.box[4]) then
						button:onclick()
						Tracker.waitFrames = 0
					end
				end
			end

			-- settings gear
			if Input.isInRange(xmouse, ymouse, GraphicConstants.SCREEN_WIDTH + 101 - 8, 7, 7, 7) then
				Options.redraw = true
				Program.state = State.SETTINGS
			end

			--note box
			--[[
			local subAmount = Utils.inlineIf(Settings.tracker.SHOW_POKECENTER_HEALS,46,10)
			local charMax = Utils.inlineIf(Settings.tracker.SHOW_POKECENTER_HEALS,18,25)
			if Input.isInRange(xmouse, ymouse, GraphicConstants.SCREEN_WIDTH + 6, 141, GraphicConstants.RIGHT_GAP - subAmount, 12) 
			and Input.noteForm == nil and Tracker.Data.selectedPlayer == 2 then
				Input.noteForm = forms.newform(290, 60, "Note ("..charMax.. " char. max)", function() Input.noteForm = nil end)
				local textBox = forms.textbox(Input.noteForm, Tracker.GetNote(), 200, 20)
				forms.button(Input.noteForm, "Set", function()
					Tracker.SetNote(forms.gettext(textBox))
					forms.destroy(Input.noteForm)
					Input.noteForm = nil
					Tracker.waitFrames = 0
				end, 200, 0)
			end--]]

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

			-- Settings edit colors button
			if Input.isInRange(xmouse, ymouse, Options.openColorOptions.box[1], Options.openColorOptions.box[2], Options.openColorOptions.box[3], Options.openColorOptions.box[4]) then
				Options.openColorOptions.onClick()
				Tracker.waitFrames = 0
			end
		elseif Program.state == State.COLOR_CUSTOMIZING then
			local buttons = ColorOptions.colorButtons
			for _, button in pairs(buttons) do
				local box = button.box
				if Input.isInRange(xmouse,ymouse,box[1],box[2],box[3],box[4]) then
					local colorPicker = ColorPicker.new(button.colorName)
					Program.state = State.COLOR_PICKER_DIALOG
					Input.currentColorPicker = colorPicker
					colorPicker:show()
				end
			end

			buttons = ColorOptions.mainButtons
			for _, button in pairs(buttons) do
				local box = button.box
				if Input.isInRange(xmouse,ymouse,box[1],box[2],box[3],box[4]) then
					button.onclick()
				end
			end
			local box = ColorOptions.toggleMoveColorButton.box
			if Input.isInRange(xmouse,ymouse,box[1],box[2],box[3],box[4]) then
				ColorOptions.toggleMoveColorButton:onclick()
			end
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

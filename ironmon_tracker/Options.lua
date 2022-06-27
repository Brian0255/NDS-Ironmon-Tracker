Options = {}

-- Update drawing the settings page if true
Options.redraw = true

-- Tracks if settings were modified so we know if we need to update Settings.ini or not.
Options.updated = false

-- A button to close the settings page and save the settings if any changes occurred
Options.closeButton = {
	text = "Close",
	box = {
		GraphicConstants.SCREEN_WIDTH + GraphicConstants.RIGHT_GAP - 40,
		GraphicConstants.SCREEN_HEIGHT - 20,
		30,
		11,
	},
	backgroundColor = { "Top box border color", "Top box background color" },
	textColor = "Default text color",
	-- onClick = function(): currently handled in the Input object
}

-- Opens the Color Options interface.
Options.openColorOptions = {
	text = "Edit colors",
	box = {
		GraphicConstants.SCREEN_WIDTH + GraphicConstants.RIGHT_GAP - 94,
		GraphicConstants.SCREEN_HEIGHT - 20,
		48,
		11,
	},
	backgroundColor = { "Top box border color", "Top box background color" },
	textColor = "Default text color",
	onClick = function()
		Program.state = State.COLOR_CUSTOMIZING
		client.SetGameExtraPadding(0, GraphicConstants.UP_GAP, GraphicConstants.RIGHT_GAP+150, GraphicConstants.DOWN_GAP)
		ColorOptions.redraw = true
	end
}

-- Not a visible button, but is used by the Input script to see if clicks occurred on the setting
Options.romsFolderOption = {
	text = "Roms folder: ",
	box = {
		GraphicConstants.SCREEN_WIDTH + 6, -- 6 = GraphicConstants.BORDER_MARGIN + 1
		8, -- 8 = GraphicConstants.BORDER_MARGIN + 3
		8,
		8,
	},
	textColor = "Default text color",
}

-- Stores the options in the Settings.ini file into configurable toggles in the Tracker
Options.optionsButtons = {}

--[[]]
function Options.buildTrackerOptionsButtons()
	-- Used for the position offests.
	local optionIndex = 1
	for key, value in pairs(Settings.tracker) do
		-- All options in Settings.tracker SHOULD be boolean, but we'll verify here for now.
		-- Eventually I want to expand this so that we can do more than just toggles, but let's get this out the door first.
		if value == true or value == false then
			optionIndex = optionIndex + 1
			local button = {
				text = string.sub(key, 1, 1) .. string.sub(string.lower(string.gsub(key, "_", " ")), 2),
				box = {
					GraphicConstants.SCREEN_WIDTH + GraphicConstants.BORDER_MARGIN + 3,
					(optionIndex * 10),
					8,
					8,
				},
				backgroundColor = {0xFF000000, "Top box background color" },
				textColor = "Default text color",
				optionColor = "Positive text color",
				optionState = value,
				-- TODO: Need a better way to internally update the optionState member rather than depending on the caller to save it...
				onClick = function() -- return the updated value to be saved into this button's optionState value
					Settings.tracker[key] = not(Settings.tracker[key])
					return Settings.tracker[key]
				end
			}
			table.insert(Options.optionsButtons, button)
		end
	end
end

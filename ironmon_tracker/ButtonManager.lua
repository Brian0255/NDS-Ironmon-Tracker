ButtonManager = {
	BADGE_GAME_PREFIX = "",
	BADGE_X_POS_START = GraphicConstants.SCREEN_WIDTH+9,
	BADGE_Y_POS = 142,
	BADGE_WIDTH_LENGTH = 16,
	badgeButtons = {},
	textBoxes = {}
}

ButtonType = {
	singleButton = 0,
	-- text : button text
	-- box : total size of the button
	-- backgroundcolor : {1,2} background color
	-- textcolor : text color
	-- onclick : function triggered when the button is clicked.

	badgeButton = 0,
	--visible : condition on when button should be visible
	--box : defines button dimensions
	--state : on or off
	--onclick : function triggered when badge button is clicked
}


StatButtonStates = {
	"",
	"--",
	"+"
}

StatButtonColors = {
	GraphicConstants.layoutColors["Default text color"],
	GraphicConstants.layoutColors["Negative text color"],
	GraphicConstants.layoutColors["Positive text color"]
}

local buttonXOffset = 129

local HiddenPowerState = 0

HiddenPowerButton = {
	type = ButtonType.singleButton,
	visible = function() return Tracker.Data.selectedPlayer == 1 and Utils.playerHasMove("Hidden Power") end,
	text = "Hidden Power",
	box = {
		0,
		0,
		65,
		10
	},
	backgroundcolor = { GraphicConstants.layoutColors["Bottom box border color"], GraphicConstants.layoutColors["Bottom box background color"] },
	textcolor = GraphicConstants.TYPECOLORS[HiddenPowerTypeList[HiddenPowerState+1]],
	onclick = function()
		HiddenPowerState = (HiddenPowerState + 1) % #HiddenPowerTypeList
		local newType = HiddenPowerTypeList[HiddenPowerState + 1]
		HiddenPowerButton.textcolor = GraphicConstants.TYPECOLORS[newType]
		Tracker.Data.currentHiddenPowerType = newType
	end
}

Buttons = {

	{ -- HP button
		type = ButtonType.singleButton,
		visible = function() return Tracker.Data.inBattle == 1 and Tracker.Data.selectedPlayer == 2 end,
		text = "",
		box = {
			GraphicConstants.SCREEN_WIDTH + buttonXOffset,
			9,
			8,
			8
		},
		backgroundcolor = { GraphicConstants.layoutColors["Top box border color"], GraphicConstants.layoutColors["Top box background color"] },
		textcolor = 0xFF00AAFF,
		onclick = function()
			Program.StatButtonState.hp = ((Program.StatButtonState.hp + 1) % 3) + 1
			Buttons[1].text = StatButtonStates[Program.StatButtonState.hp]
			Buttons[1].textcolor = StatButtonColors[Program.StatButtonState.hp]
			Tracker.TrackStatPrediction(Tracker.Data.enemyPokemon.pokemonID, Program.StatButtonState)
		end
	},
	{ -- ATT button
		type = ButtonType.singleButton,
		visible = function() return Tracker.Data.inBattle == 1 and Tracker.Data.selectedPlayer == 2 end,
		text = "",
		box = {
			GraphicConstants.SCREEN_WIDTH + buttonXOffset,
			19,
			8,
			8
		},
		backgroundcolor = { GraphicConstants.layoutColors["Top box border color"], GraphicConstants.layoutColors["Top box background color"] },
		textcolor = 0xFF00AAFF,
		onclick = function()
			Program.StatButtonState.att = ((Program.StatButtonState.att + 1) % 3) + 1
			Buttons[2].text = StatButtonStates[Program.StatButtonState.att]
			Buttons[2].textcolor = StatButtonColors[Program.StatButtonState.att]
			Tracker.TrackStatPrediction(Tracker.Data.enemyPokemon.pokemonID, Program.StatButtonState)
		end
	},
	{ -- DEF button
		type = ButtonType.singleButton,
		visible = function() return Tracker.Data.inBattle == 1 and Tracker.Data.selectedPlayer == 2 end,
		text = "",
		box = {
			GraphicConstants.SCREEN_WIDTH + buttonXOffset,
			29,
			8,
			8
		},
		backgroundcolor = { GraphicConstants.layoutColors["Top box border color"], GraphicConstants.layoutColors["Top box background color"] },
		textcolor = 0xFF00AAFF,
		onclick = function()
			Program.StatButtonState.def = ((Program.StatButtonState.def + 1) % 3) + 1
			Buttons[3].text = StatButtonStates[Program.StatButtonState.def]
			Buttons[3].textcolor = StatButtonColors[Program.StatButtonState.def]
			Tracker.TrackStatPrediction(Tracker.Data.enemyPokemon.pokemonID, Program.StatButtonState)
		end
	},
	{ -- SPA button
		type = ButtonType.singleButton,
		visible = function() return Tracker.Data.inBattle == 1 and Tracker.Data.selectedPlayer == 2 end,
		text = "",
		box = {
			GraphicConstants.SCREEN_WIDTH + buttonXOffset,
			39,
			8,
			8
		},
		backgroundcolor = { GraphicConstants.layoutColors["Top box border color"], GraphicConstants.layoutColors["Top box background color"] },
		textcolor = 0xFF00AAFF,
		onclick = function()
			Program.StatButtonState.spa = ((Program.StatButtonState.spa + 1) % 3) + 1
			Buttons[4].text = StatButtonStates[Program.StatButtonState.spa]
			Buttons[4].textcolor = StatButtonColors[Program.StatButtonState.spa]
			Tracker.TrackStatPrediction(Tracker.Data.enemyPokemon.pokemonID, Program.StatButtonState)
		end
	},
	{ -- SPD button
		type = ButtonType.singleButton,
		visible = function() return Tracker.Data.inBattle == 1 and Tracker.Data.selectedPlayer == 2 end,
		text = "",
		box = {
			GraphicConstants.SCREEN_WIDTH + buttonXOffset,
			49,
			8,
			8
		},
		backgroundcolor = { GraphicConstants.layoutColors["Top box border color"], GraphicConstants.layoutColors["Top box background color"] },
		textcolor = 0xFF00AAFF,
		onclick = function()
			Program.StatButtonState.spd = ((Program.StatButtonState.spd + 1) % 3) + 1
			Buttons[5].text = StatButtonStates[Program.StatButtonState.spd]
			Buttons[5].textcolor = StatButtonColors[Program.StatButtonState.spd]
			Tracker.TrackStatPrediction(Tracker.Data.enemyPokemon.pokemonID, Program.StatButtonState)
		end
	},
	{ -- SPE button
		type = ButtonType.singleButton,
		visible = function() return Tracker.Data.inBattle == 1 and Tracker.Data.selectedPlayer == 2 end,
		text = "",
		box = {
			GraphicConstants.SCREEN_WIDTH + buttonXOffset,
			59,
			8,
			8
		},
		backgroundcolor = { GraphicConstants.layoutColors["Top box border color"], GraphicConstants.layoutColors["Top box background color"] },
		textcolor = 0xFF00AAFF,
		onclick = function()
			Program.StatButtonState.spe = ((Program.StatButtonState.spe + 1) % 3) + 1
			Buttons[6].text = StatButtonStates[Program.StatButtonState.spe]
			Buttons[6].textcolor = StatButtonColors[Program.StatButtonState.spe]
			Tracker.TrackStatPrediction(Tracker.Data.enemyPokemon.pokemonID, Program.StatButtonState)
		end
	},
	{ -- Pokecenter increase
	type = ButtonType.singleButton,
	visible = function() 
		if Settings.tracker.SHOW_POKECENTER_HEALS then
			if not Settings.tracker.SHOW_ACCURACY_AND_EVASION then
				return true
			else
				return Tracker.Data.inBattle == 0
			end
		end
		return false
	end,
	text = "+",
	box = {
		GraphicConstants.SCREEN_WIDTH + 90,
		62,
		8,
		6
	},
	backgroundcolor = "",
	textcolor = GraphicConstants.NEUTRAL,
	onclick = function()
		Tracker.Data.pokecenterCount = Tracker.Data.pokecenterCount + 1
	end
},

{ -- Pokecenter decrease
	type = ButtonType.singleButton,
	visible = function() 
		if Settings.tracker.SHOW_POKECENTER_HEALS then
			if not Settings.tracker.SHOW_ACCURACY_AND_EVASION then
				return true
			else
				return Tracker.Data.inBattle == 0
			end
		end
		return false
	end,
	text = "--",
	box = {
		GraphicConstants.SCREEN_WIDTH + 90,
		70,
		8,
		6
	},
	backgroundcolor = "",
	textcolor = GraphicConstants.NEUTRAL,
	onclick = function()
		Tracker.Data.pokecenterCount = math.max(Tracker.Data.pokecenterCount - 1,0)
	end
},
	HiddenPowerButton
}

function ButtonManager.initializeBadgeButtons()
	ButtonManager.badgeButtons = {}
	for i = 1,8,1 do
		local badgeButton = {
			type = ButtonType.badgeButton,
			visible = function() return Tracker.Data.selectedPlayer == 1 end,
			box = {
				ButtonManager.BADGE_X_POS_START+( (i-1) * (ButtonManager.BADGE_WIDTH_LENGTH + 1) ),
				ButtonManager.BADGE_Y_POS,
				ButtonManager.BADGE_WIDTH_LENGTH,
				ButtonManager.BADGE_WIDTH_LENGTH
			},
			badgeIndex = i,
			state = Tracker.Data.badges[i],
			onclick = function(self)
				Tracker.Data.badges[self.badgeIndex] = (Tracker.Data.badges[self.badgeIndex] + 1) % 2
				self:updateState()
			end,
			updateState = function(self)
				self.state = Tracker.Data.badges[self.badgeIndex]
			end
		}
		table.insert(ButtonManager.badgeButtons,badgeButton)
	end
end

function ButtonManager.updateBadges()
	for i, button in pairs(ButtonManager.badgeButtons) do
		button:updateState()
	end
end

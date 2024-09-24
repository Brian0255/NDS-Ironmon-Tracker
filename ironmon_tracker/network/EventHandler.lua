EventHandler = {
	RewardsExternal = {}, -- A list of external rewards
	Queues = {}, -- A table of lists for each set of processed requests that still need to be fulfilled
	EVENT_SETTINGS_FORMAT = "Event__%s__%s",
	DUPLICATE_COMMAND_COOLDOWN = 6, -- # of seconds

	-- Shared values between server and client
	COMMAND_PREFIX = "!",
}

EventHandler.EventTypes = {
	None = "None",
	Command = "Command", -- For chat commands
	Reward = "Reward", -- For channel rewards (channel point redeem)
	Tracker = "Tracker", -- Trigger off of a change to the Tracker itself
	Game = "Game", -- Trigger off of something in the actual game
}

EventHandler.CoreEventKeys = {
	Start = "TS_Start",
	Stop = "TS_Stop",
	GetRewards = "TS_GetRewardsList",
	UpdateEvents = "TS_UpdateEvents",
}

EventHandler.Events = {
	None = { Key = "None", Type = EventHandler.EventTypes.None, Exclude = true },
}

EventHandler.CommandRoles = {
	Broadcaster = "Broadcaster", -- Allow the one user who is the Broadcaster (always allowed)
	Everyone = "Everyone", -- Allow all users, regardless of other roles selected
	Moderator = "Moderator", -- Allow users that are Moderators
	Vip = "Vip", -- Allow users with VIP
	Subscriber = "Subscriber", -- Allow users that are Subscribers
	Custom = "Custom", -- Allow users that belong to a custom-defined role
	Viewer = "Viewer", -- Unused
}

-- Event object prototypes

EventHandler.IEvent = {
	-- Required unique key
	Key = EventHandler.Events.None.Key,
	-- Required type
	Type = EventHandler.EventTypes.None,
	-- Required display name of the event
	Name = "",
	-- Enable/Disable from triggering
	IsEnabled = true,
	-- Determine what to do with the IRequest, return true if ready to fulfill
	Process = function(self, request) return true end,
	-- Only after fully processed and ready, finish completing the request and return a response message or partial response table
	Fulfill = function(self, request) return "" end,
}
---Creates and returns a new IEvent object
---@param o? table Optional initial object table
---@return table event An IEvent object
function EventHandler.IEvent:new(o)
	o = o or {}
	o.Key = o.Key or EventHandler.Events.None.Key
	o.Type = o.Type or EventHandler.EventTypes.None
	if o.IsEnabled == nil then
		o.IsEnabled = true
	end
	setmetatable(o, self)
	self.__index = self
	return o
end

---Runs additional functions after Network attempts to connect
function EventHandler.onStartup()
	local settingsUpdated = false

	local ballqEvent = EventHandler.Events.CMD_BallQueue or {}
	local ballqRequest = EventHandler.Queues.BallRedeems.ActiveRequest
	if ballqEvent.O_ShowBallQueueOnStartup and ballqRequest ~= nil then
		-- Only show message if it wasn't shown the last startup
		local lasGUID = Network.MetaSettings.network.LastBallQueueGUID or ""
		if lasGUID ~= ballqRequest.GUID then
			EventHandler.triggerEvent("CMD_BallQueue")
			Network.MetaSettings.network.LastBallQueueGUID = ballqRequest.GUID
			settingsUpdated = true
		end
	end

	if settingsUpdated then
		Network.saveSettings()
	end
end

---Clears out existing event info; similar to initialize(), but managed by Network
function EventHandler.reset()
	EventHandler.RewardsExternal = {}
	EventHandler.Queues = {
		BallRedeems = { Requests = {}, },
	}
end

---Checks if the event is of a known event type
---@param event table IEvent
---@return boolean
function EventHandler.isValidEvent(event)
	if not event then return false end
	return EventHandler.Events[event.Key or false] and event.Key ~= EventHandler.Events.None.Key
end

--- Adds an IEvent to the events list; returns true if successful
---@param event table IEvent object (requires: Key, Process, Fulfill)
---@return boolean success
function EventHandler.addNewEvent(event)
	-- Only add new, properly structured  events
	if (event.Key or "") == "" or EventHandler.Events[event.Key] then
		return false
	end
	-- Attempt to auto-detect the event type, based on other properties
	if (event.Type or "") == "" or event.Type == EventHandler.EventTypes.None then
		if event.Command and not event.RewardId then
			event.Type = EventHandler.EventTypes.Command
		elseif event.RewardId and not event.Command then
			event.Type = EventHandler.EventTypes.Reward
		else
			event.Type = EventHandler.EventTypes.None
		end
	end
	EventHandler.Events[event.Key] = event
	EventHandler.loadEventSettings(event)
	return true
end

--- Adds an IEvent to the events list; returns true if successful
---@param eventKey string IEvent.Key
---@param fulfillFunc function Must return a string or a partial Response table { Message="", GlobalVars={} }
---@param name? string (Optional) A descriptive name for the event
---@return boolean success
function EventHandler.addNewGameEvent(eventKey, fulfillFunc, name)
	if (eventKey or "") == "" or type(fulfillFunc) ~= "function" then
		return false
	end
	return EventHandler.addNewEvent(EventHandler.IEvent:new({
		Key = eventKey,
		Type = EventHandler.EventTypes.Game,
		Name = name or eventKey,
		Fulfill = fulfillFunc,
	}))
end

---Internally triggers an event by creating a new Request for it
---@param eventKey string IEvent.Key
---@param input? string
function EventHandler.triggerEvent(eventKey, input)
	local event = EventHandler.Events[eventKey or false]
	if not EventHandler.isValidEvent(event) then
		return
	end
	RequestHandler.addUpdateRequest(RequestHandler.IRequest:new({
		EventKey = eventKey,
		Args = { Input = input },
	}))
end

--- Removes an IEvent from the events list; returns true if successful
---@param eventKey string IEvent.Key
---@return boolean success
function EventHandler.removeEvent(eventKey)
	if not EventHandler.Events[eventKey] then
		return false
	end
	EventHandler.Events[eventKey] = nil
	return true
end

---Returns the IEvent for a given command; or nil if not found
---@param command string Example: !testcommand
---@return table events List of events with matching commands
function EventHandler.getEventsForCommand(command)
	local events = {}
	if (command or "") == "" then
		return events
	end
	if command:sub(1,1) ~= EventHandler.COMMAND_PREFIX then
		command = EventHandler.COMMAND_PREFIX .. command
	end
	command = command:lower()
	for _, event in pairs(EventHandler.Events) do
		if event.Command == command then
			table.insert(events, event)
		end
	end
	return events
end

---Returns the IEvent for a given rewardId; or nil if not found
---@param rewardId string
---@return table events List of events with matching rewards
function EventHandler.getEventsForReward(rewardId)
	local events = {}
	if (rewardId or "") == "" then
		return events
	end
	for _, event in pairs(EventHandler.Events) do
		if event.RewardId == rewardId then
			table.insert(events, event)
		end
	end
	return events
end

---Updates internal Reward events with associated RewardIds and RewardTitles
---@param rewards table
function EventHandler.updateRewardList(rewards)
	-- Unsure if this clear out is necessary yet
	if #rewards > 0 then
		EventHandler.RewardsExternal = {}
	end

	for _, reward in pairs(rewards or {}) do
		if (reward.Id or "") ~= "" and reward.Title then
			EventHandler.RewardsExternal[reward.Id] = reward.Title
		end
	end
	-- Temp disable any Reward events without matching reward ids
	for _, event in pairs(EventHandler.Events) do
		if event.Type == EventHandler.EventTypes.Reward and event.IsEnabled and event.RewardId and not EventHandler.RewardsExternal[event.RewardId] then
			event.IsEnabled = false
		end
	end
end

---Saves a configurable settings attribute for an event to the Settings.ini file
---@param event table IEvent
---@param attribute string The IEvent attribute being saved
function EventHandler.saveEventSetting(event, attribute)
	if not EventHandler.isValidEvent(event) or not attribute then
		return
	end
	local defaultEvent = EventHandler.DefaultEvents[event.Key] or {}
	local key = string.format(EventHandler.EVENT_SETTINGS_FORMAT, event.Key, attribute)
	local value = event[attribute]
	-- Only save if the value isn't empty and it's not the known default value (keep Settings file a bit cleaner)
	if value ~= nil and value ~= defaultEvent[attribute] then
		-- Add MetaSetting (adds it as a new setting in the ini settings file)
		if Network.MetaSettings.network == nil then
			Network.MetaSettings.network = {}
		end
		Network.MetaSettings.network[key] = value
	else
		-- Remove MetaSetting (deletes it from the ini settings file)
		if Network.MetaSettings.network ~= nil then
			Network.MetaSettings.network[key] = nil
		end
	end
	Network.saveSettings()
	event.ConfigurationUpdated = true
end

---Loads all configurable settings for an event from the Settings.ini file
---@param event table IEvent
function EventHandler.loadEventSettings(event)
	if not EventHandler.isValidEvent(event) then
		return false
	end
	local settings = Network.MetaSettings.network or {}
	local anyLoaded = false
	for attribute, existingValue in pairs(event) do
		local key = string.format(EventHandler.EVENT_SETTINGS_FORMAT, event.Key, attribute)
		local value = settings[key]
		if value ~= nil and value ~= existingValue then
			event[attribute] = value
			anyLoaded = true
		end
	end
	-- Disable any rewards without associations defined
	if event.Type == EventHandler.EventTypes.Reward and event.IsEnabled and event.RewardId and event.RewardId == "" then
		event.IsEnabled = false
	end
	event.ConfigurationUpdated = anyLoaded or nil
end

---Checks if any event settings have been modified, and if so notify the external application of the changes
function EventHandler.checkForConfigChanges()
	local modifiedEvents = {}
	for _, event in pairs(EventHandler.Events) do
		if event.ConfigurationUpdated then
			table.insert(modifiedEvents, event)
			event.ConfigurationUpdated = nil
		end
	end
	if #modifiedEvents > 0 then
		RequestHandler.addUpdateRequest(RequestHandler.IRequest:new({
			EventKey = EventHandler.CoreEventKeys.UpdateEvents,
			Args = modifiedEvents
		}))
	end
end

---Queues up a request to be processed at a later time (not immediate), determined by the event
---@param queueKey string The event queue this request will belong to
---@param request table IRequest
---@return boolean success
function EventHandler.queueRequestForLater(queueKey, request)
	local Q = EventHandler.Queues[queueKey]
	if not Q or Q.Requests[request.GUID] then
		return false
	end
	Q.Requests[request.GUID] = request
	-- NOTE: If any screen is displaying the current queue, refresh its list here
	return true
end

---Cancels and removes all active Requests from the requests queue; returns number that were cancelled
---@return number numCancelled
function EventHandler.cancelAllQueues()
	local count = 0
	for _, queue in pairs(EventHandler.Queues or {}) do
		for _, request in pairs(queue.Requests or {}) do
			request.IsCancelled = true
			count = count + 1
		end
		queue.ActiveRequest = nil
		queue.Requests = {}
	end
	return count
end

function EventHandler.addDefaultEvents()
	-- Add these events directly, as they aren't modifiable by the user
	for key, event in pairs(EventHandler.CoreEvents) do
		event.IsEnabled = true
		event.Key = key
		EventHandler.addNewEvent(event)
	end

	-- Make a copy of each default event, such that they can still be referenced without being changed.
	for key, event in pairs(EventHandler.DefaultEvents) do
		event.IsEnabled = true
		event.Key = key
		local eventCopy = MiscUtils.deepCopy(event)
		if eventCopy then
			EventHandler.addNewEvent(eventCopy)
		end
	end
end

function EventHandler.isDuplicateCommandRequest(event, request)
	if event.Type ~= EventHandler.EventTypes.Command then
		return false
	end
	if not request.SanitizedInput then
		RequestHandler.sanitizeInput(request)
	end
	if not event.RecentRequests then
		event.RecentRequests = {}
	elseif event.RecentRequests[request.SanitizedInput] then
		return true
	end
	event.RecentRequests[request.SanitizedInput] = os.time() + EventHandler.DUPLICATE_COMMAND_COOLDOWN
	return false
end

function EventHandler.cleanupDuplicateCommandRequests()
	local currentTime = os.time()
	for _, event in pairs(EventHandler.Events) do
		if event.Type == EventHandler.EventTypes.Command and event.RecentRequests then
			for requestInput, timestamp in pairs(event.RecentRequests) do
				if currentTime > timestamp then
					event.RecentRequests[requestInput] = nil
				end
			end
		end
	end
end

-- Helper functions
local function parseBallChoice(input)
	-- Not implemented
	local keyword = "Random"
	local ballNumber = math.random(3)
	return keyword, ballNumber
end

local function changeStarterFavorite(pokemonName, slotNumber)
	-- Not implemented
	slotNumber = slotNumber or 1
	local originalFaveName = "Bulbasaur"
	local newFaveName = "Ivysaur"
	return string.format("Favorite #%s changed from %s to %s.",
		slotNumber,
		originalFaveName,
		newFaveName)
end

EventHandler.CoreEvents = {
	-- TS_: Tracker Server (Core events that shouldn't be modified)
	[EventHandler.CoreEventKeys.Start] = {
		Type = EventHandler.EventTypes.Tracker,
		Exclude = true,
		Process = function(self, request)
			-- Wait to hear from Streamerbot before fulfilling this request
			return request.Args.Source == RequestHandler.SOURCE_STREAMERBOT
		end,
		Fulfill = function(self, request)
			Network.updateConnectionState(Network.ConnectionState.Established)
			Network.checkVersion(request.Args and request.Args.Version or "")
			RequestHandler.removedExcludedRequests()
			-- NOTE: If any screen is displaying connection status info, add code here to refresh it
			print("Stream Connect: Connected to Streamer.bot")
			return RequestHandler.REQUEST_COMPLETE
		end,
	},
	[EventHandler.CoreEventKeys.Stop] = {
		Type = EventHandler.EventTypes.Tracker,
		Exclude = true,
		Process = function(self, request)
			local ableToStop = Network.CurrentConnection.State >= Network.ConnectionState.Established
			-- Wait to hear from Streamerbot before fulfilling this request
			return ableToStop and request.Args.Source == RequestHandler.SOURCE_STREAMERBOT
		end,
		Fulfill = function(self, request)
			Network.updateConnectionState(Network.ConnectionState.Listen)
			RequestHandler.removedExcludedRequests()
			-- NOTE: If any screen is displaying connection status info, add code here to refresh it
			return RequestHandler.REQUEST_COMPLETE
		end,
	},
	[EventHandler.CoreEventKeys.GetRewards] = {
		Type = EventHandler.EventTypes.Tracker,
		Exclude = true,
		Process = function(self, request)
			-- Wait to hear from Streamerbot before fulfilling this request
			return request.Args.Source == RequestHandler.SOURCE_STREAMERBOT
		end,
		Fulfill = function(self, request)
			EventHandler.updateRewardList(request.Args.Rewards)
			return RequestHandler.REQUEST_COMPLETE
		end,
	},
	[EventHandler.CoreEventKeys.UpdateEvents] = {
		Type = EventHandler.EventTypes.Tracker,
		Exclude = true,
		Fulfill = function(self, request)
			local allowedEvents = {}
			for _, event in pairs(EventHandler.Events) do
				if event.IsEnabled and not event.Exclude then
					if event.Type == EventHandler.EventTypes.Command then
						table.insert(allowedEvents, event.Command:sub(2))
					elseif event.Type == EventHandler.EventTypes.Reward then
						table.insert(allowedEvents, event.RewardId)
					end
				end
			end
			return {
				AdditionalInfo = {
					AllowedEvents = table.concat(allowedEvents, ","),
					CommandRoles = Network.Options["CommandRoles"] or EventHandler.CommandRoles.Everyone,
				},
			}
		end,
	}
}

EventHandler.DefaultEvents = {
	-- CMD_: Chat Commands
	CMD_Pokemon = {
		Type = EventHandler.EventTypes.Command,
		Command = "!pokemon",
		Name = "Pok" .. Chars.accentedE .. "mon Info",
		Help = "name > Displays useful game info for a Pok" .. Chars.accentedE .. "mon.",
		Fulfill = function(self, request) return EventData.getPokemon(request.SanitizedInput) end,
	},
	CMD_BST = {
		Type = EventHandler.EventTypes.Command,
		Command = "!bst",
		Name = "Pok" .. Chars.accentedE .. "mon BST",
		Help = "name > Displays the base stat total (BST) for a Pok" .. Chars.accentedE .. "mon.",
		Fulfill = function(self, request) return EventData.getBST(request.SanitizedInput) end,
	},
	CMD_Weak = {
		Type = EventHandler.EventTypes.Command,
		Command = "!weak",
		Name = "Pok" .. Chars.accentedE .. "mon Weaknesses",
		Help = "name > Displays the weaknesses for a Pok" .. Chars.accentedE .. "mon.",
		Fulfill = function(self, request) return EventData.getWeak(request.SanitizedInput) end,
	},
	CMD_Move = {
		Type = EventHandler.EventTypes.Command,
		Command = "!move",
		Name = "Move Info",
		Help = "name > Displays game info for a move.",
		Fulfill = function(self, request) return EventData.getMove(request.SanitizedInput) end,
	},
	CMD_Ability = {
		Type = EventHandler.EventTypes.Command,
		Command = "!ability",
		Name = "Ability Info",
		Help = "name > Displays game info for a Pok" .. Chars.accentedE .. "mon's ability.",
		Fulfill = function(self, request) return EventData.getAbility(request.SanitizedInput) end,
	},
	CMD_Route = {
		Type = EventHandler.EventTypes.Command,
		Command = "!route",
		Name = "Route Info",
		Help = "name > Displays trainer and wild encounter info for a route or area.",
		Fulfill = function(self, request) return EventData.getRoute(request.SanitizedInput) end,
	},
	-- CMD_Dungeon = {
	-- 	Type = EventHandler.EventTypes.Command,
	-- 	Command = "!dungeon",
	-- 	Name = "Dungeon Info",
	-- 	Help = "name > Displays info about which trainers have been defeated for an area.",
	-- 	Fulfill = function(self, request) return EventData.getDungeon(request.SanitizedInput) end,
	-- },
	-- CMD_Unfought = {
	-- 	Type = EventHandler.EventTypes.Command,
	-- 	Command = "!unfought",
    -- 	Name = "Unfought Trainers",
	-- 	Help = "[dungeon] [sevii]> Displays a list of areas ordered by lowest-level, undefeated trainers. (Add param 'dungeon' to include partially completed dungeons.)",
	-- 	Fulfill = function(self, request) return EventData.getUnfoughtTrainers(request.SanitizedInput) end,
	-- },
	CMD_Pivots = {
		Type = EventHandler.EventTypes.Command,
		Command = "!pivots",
		Name = "Pivots Seen",
		Help = "> Displays known early game wild encounters for an area.",
		Fulfill = function(self, request) return EventData.getPivots(request.SanitizedInput) end,
	},
	CMD_Revo = {
		Type = EventHandler.EventTypes.Command,
		Command = "!revo",
		Name = "Pok" .. Chars.accentedE .. "mon Random Evolutions",
		Help = "name [target-evo] > Displays randomized evolution possibilities for a Pok" .. Chars.accentedE .. "mon, and it's [target-evo] if more than one available.",
		Fulfill = function(self, request) return EventData.getRevo(request.SanitizedInput) end,
	},
	CMD_Coverage = {
		Type = EventHandler.EventTypes.Command,
		Command = "!coverage",
		Name = "Move Coverage Effectiveness",
		Help = "types [fully evolved] > For a list of move types, checks all Pok" .. Chars.accentedE .. "mon matchups (or only [fully evolved]) for effectiveness.",
		Fulfill = function(self, request) return EventData.getCoverage(request.SanitizedInput) end,
	},
	CMD_Heals = {
		Type = EventHandler.EventTypes.Command,
		Command = "!heals",
		Name = "Heals in Bag",
		Help = "[hp pp status berries] > Displays all healing items in the bag, or only those for a specified [category].",
		Fulfill = function(self, request) return EventData.getHeals(request.SanitizedInput) end,
	},
	CMD_TMs = {
		Type = EventHandler.EventTypes.Command,
		Command = "!tms",
		Name = "TM Lookup",
		Help = "[gym hm #] > Displays all TMs in the bag, or only those for a specified [category] or TM #.",
		Fulfill = function(self, request) return EventData.getTMsHMs(request.SanitizedInput) end,
	},
	CMD_Search = {
		Type = EventHandler.EventTypes.Command,
		Command = "!search",
		Name = "Search Tracked Info",
		Help = "searchterms > Search tracked info for a Pok" .. Chars.accentedE .. "mon, move, or ability.",
		Fulfill = function(self, request) return EventData.getSearch(request.SanitizedInput) end,
	},
	CMD_SearchNotes = {
		Type = EventHandler.EventTypes.Command,
		Command = "!searchnotes",
		Name = "Search Notes on Pok" .. Chars.accentedE .. "mon",
		Help = "notes > Displays a list of Pok" .. Chars.accentedE .. "mon with any matching notes.",
		Fulfill = function(self, request) return EventData.getSearchNotes(request.SanitizedInput) end,
	},
	CMD_Favorites = {
		Type = EventHandler.EventTypes.Command,
		Command = "!favorites",
		Name = "Favorite Starters",
		Help = "> Displays the list of favorites used for picking a starter.",
		Fulfill = function(self, request) return EventData.getFavorites(request.SanitizedInput) end,
	},
	CMD_Theme = {
		Type = EventHandler.EventTypes.Command,
		Command = "!theme",
		Name = "Theme Export",
		Help = "name > Displays the name and code string for a Tracker theme.",
		Fulfill = function(self, request) return EventData.getTheme(request.SanitizedInput) end,
	},
	-- CMD_GameStats = {
	-- 	Type = EventHandler.EventTypes.Command,
	-- 	Command = "!gamestats",
	-- 	Name = "Game Stats",
	-- 	Help = "> Displays fun stats for the current game.",
	-- 	Fulfill = function(self, request) return EventData.getGameStats(request.SanitizedInput) end,
	-- },
	CMD_Progress = {
		Type = EventHandler.EventTypes.Command,
		Command = "!progress",
		Name = "Game Progress",
		Help = "> Displays fun progress percentages for the current game.",
		Fulfill = function(self, request) return EventData.getProgress(request.SanitizedInput) end,
	},
	CMD_Log = {
		Type = EventHandler.EventTypes.Command,
		Command = "!log",
		Name = "Log Randomizer Settings",
		Help = "> If the log has been opened, displays shareable randomizer settings from the log for current game.",
		Fulfill = function(self, request) return EventData.getLog(request.SanitizedInput) end,
	},
	-- CMD_BallQueue = {
	-- 	Type = EventHandler.EventTypes.Command,
	-- 	Command = "!ballqueue",
	-- 	Name = "Ball Queue",
	-- 	Help = "> Displays the size of the ball queue and the current pick, if any.",
	-- 	Options = { "O_ShowBallQueueOnStartup", },
	-- 	O_ShowBallQueueOnStartup = false,
	-- 	Fulfill = function(self, request) return EventData.getBallQueue(request.SanitizedInput) end,
	-- },
	CMD_About = {
		Type = EventHandler.EventTypes.Command,
		Command = "!about",
		Name = "About the Tracker",
		Help = "> Displays info about the Ironmon Tracker and game being played.",
		Fulfill = function(self, request) return EventData.getAbout(request.SanitizedInput) end,
	},
	CMD_Help = {
		Type = EventHandler.EventTypes.Command,
		Command = "!help",
		Name = "Command Help",
		Help = "[command] > Displays a list of all commands, or help info for a specified [command].",
		Fulfill = function(self, request) return EventData.getHelp(request.SanitizedInput) end,
	},

	-- CR_: Channel Rewards (Point Redeems)
	CR_PickBallOnce = {
		Type = EventHandler.EventTypes.Reward,
		Name = "Pick Starter Ball (One Try)",
		RewardId = "",
		Options = {
			"O_SendMessage", "O_AutoComplete", "O_RequireChosenMon",
			"O_WordForLeft", "O_WordForMiddle", "O_WordForRight", "O_WordForRandom",
		},
		O_SendMessage = true,
		O_AutoComplete = true,
		O_RequireChosenMon = true,
		O_WordForLeft = "Left",
		O_WordForMiddle = "Mid",
		O_WordForRight = "Right",
		O_WordForRandom = "Random",
		Process = function(self, request)
			-- Not implemented
			return true
		end,
		Fulfill = function(self, request)
			-- Not implemented
			return ""
		end,
	},
	CR_PickBallUntilOut = {
		Type = EventHandler.EventTypes.Reward,
		Name = "Pick Starter Ball (Until Out)",
		RewardId = "",
		Options = {
			"O_SendMessage", "O_AutoComplete", "O_RequireChosenMon",
			"O_WordForLeft", "O_WordForMiddle", "O_WordForRight", "O_WordForRandom",
		},
		O_SendMessage = true,
		O_AutoComplete = true,
		O_RequireChosenMon = true,
		O_WordForLeft = "Left",
		O_WordForMiddle = "Mid",
		O_WordForRight = "Right",
		O_WordForRandom = "Random",
		Process = function(self, request)
			-- Not implemented
			return true
		end,
		Fulfill = function(self, request)
			-- Not implemented
			return ""
		end,
	},
	CR_ChangeFavorite = {
		Type = EventHandler.EventTypes.Reward,
		Name = "Change Starter Favorite: # NAME",
		RewardId = "",
		Options = { "O_SendMessage", "O_AutoComplete", },
		O_SendMessage = true,
		O_AutoComplete = true,
		Fulfill = function(self, request)
			local response = { AdditionalInfo = { AutoComplete = false } }
			if (request.SanitizedInput or "") == "" then
				response.Message = string.format("> Unable to change a favorite, please enter a number (1, 2, or 3) followed by a Pok" .. Chars.accentedE .. "mon name.")
				return response
			end
			local slotNumber, pokemonName = request.SanitizedInput:match("^#?(%d*)%s*(%D.+)")
			local successMsg = changeStarterFavorite(pokemonName, slotNumber)
			if not successMsg then
				response.Message = string.format("%s > Unable to change a favorite, please enter a number (1, 2, or 3) followed by a Pok" .. Chars.accentedE .. "mon name.", request.SanitizedInput)
				return response
			end
			if self.O_SendMessage then
				response.Message = successMsg
			end
			response.AdditionalInfo.AutoComplete = self.O_AutoComplete
			return response
		end,
	},
	CR_ChangeFavoriteOne = {
		Type = EventHandler.EventTypes.Reward,
		Name = "Change Starter Favorite: #1",
		RewardId = "",
		Options = { "O_SendMessage", "O_AutoComplete", },
		O_SendMessage = true,
		O_AutoComplete = true,
		Fulfill = function(self, request)
			local response = { AdditionalInfo = { AutoComplete = false } }
			if (request.SanitizedInput or "") == "" then
				response.Message = string.format("> Unable to change favorite #1, please enter a valid Pok" .. Chars.accentedE .. "mon name.")
				return response
			end
			local successMsg = changeStarterFavorite(request.SanitizedInput, 1)
			if not successMsg then
				response.Message = string.format("%s > Unable to change favorite #1, please enter a valid Pok" .. Chars.accentedE .. "mon name.", request.SanitizedInput)
				return response
			end
			if self.O_SendMessage then
				response.Message = successMsg
			end
			response.AdditionalInfo.AutoComplete = self.O_AutoComplete
			return response
		end,
	},
	CR_ChangeFavoriteTwo = {
		Type = EventHandler.EventTypes.Reward,
		Name = "Change Starter Favorite: #2",
		RewardId = "",
		Options = { "O_SendMessage", "O_AutoComplete", },
		O_SendMessage = true,
		O_AutoComplete = true,
		Fulfill = function(self, request)
			local response = { AdditionalInfo = { AutoComplete = false } }
			if (request.SanitizedInput or "") == "" then
				response.Message = string.format("> Unable to change favorite #2, please enter a valid Pok" .. Chars.accentedE .. "mon name.")
				return response
			end
			local successMsg = changeStarterFavorite(request.SanitizedInput, 2)
			if not successMsg then
				response.Message = string.format("%s > Unable to change favorite #2, please enter a valid Pok" .. Chars.accentedE .. "mon name.", request.SanitizedInput)
				return response
			end
			if self.O_SendMessage then
				response.Message = successMsg
			end
			response.AdditionalInfo.AutoComplete = self.O_AutoComplete
			return response
		end,
	},
	CR_ChangeFavoriteThree = {
		Type = EventHandler.EventTypes.Reward,
		Name = "Change Starter Favorite: #3",
		RewardId = "",
		Options = { "O_SendMessage", "O_AutoComplete", },
		O_SendMessage = true,
		O_AutoComplete = true,
		Fulfill = function(self, request)
			local response = { AdditionalInfo = { AutoComplete = false } }
			if (request.SanitizedInput or "") == "" then
				response.Message = string.format("> Unable to change favorite #3, please enter a valid Pok" .. Chars.accentedE .. "mon name.")
				return response
			end
			local successMsg = changeStarterFavorite(request.SanitizedInput, 3)
			if not successMsg then
				response.Message = string.format("%s > Unable to change favorite #3, please enter a valid Pok" .. Chars.accentedE .. "mon name.", request.SanitizedInput)
				return response
			end
			if self.O_SendMessage then
				response.Message = successMsg
			end
			response.AdditionalInfo.AutoComplete = self.O_AutoComplete
			return response
		end,
	},
	CR_ChangeTheme = {
		Type = EventHandler.EventTypes.Reward,
		Name = "Change Tracker Theme",
		RewardId = "",
		Options = { "O_SendMessage", "O_AutoComplete", "O_Duration", },
		O_SendMessage = true,
		O_AutoComplete = true,
		-- O_Duration = tostring(10 * 60), -- # of seconds
		Fulfill = function(self, request)
			local response = { AdditionalInfo = { AutoComplete = false } }
			if (request.SanitizedInput or "") == "" then
				response.Message = string.format("> Unable to change Tracker Theme, please enter a valid theme code or name.")
				return response
			end
			-- Not implemented
			return ""
		end,
	},
	CR_ChangeLanguage = {
		Type = EventHandler.EventTypes.Reward,
		Name = "Change Tracker Language",
		RewardId = "",
		Options = { "O_SendMessage", "O_AutoComplete", },
		O_SendMessage = true,
		O_AutoComplete = true,
		-- O_Duration = tostring(10 * 60), -- # of seconds
		Fulfill = function(self, request)
			local response = { AdditionalInfo = { AutoComplete = false } }
			if (request.SanitizedInput or "") == "" then
				response.Message = string.format("> Unable to change Tracker language, please enter a valid language name.")
				return response
			end
			-- Not implemented
			return ""
		end,
	},
}

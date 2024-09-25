Network = {
	CurrentConnection = {},
	lastUpdateTime = 0,
	printSuccessfulConnectMsg = true,
	STREAMERBOT_VERSION = "1.0.1", -- Known streamerbot version. Update this value to inform user to update streamerbot code
	TEXT_UPDATE_FREQUENCY = 2, -- # of seconds
	SOCKET_UPDATE_FREQUENCY = 2, -- # of seconds
	HTTP_UPDATE_FREQUENCY = 2, -- # of seconds
	TEXT_INBOUND_FILE = "NDS-Tracker-Requests.json", -- The CLIENT's outbound data file; Tracker is the "Server" and will read requests from this file
	TEXT_OUTBOUND_FILE = "NDS-Tracker-Responses.json", -- The CLIENT's inbound data file; Tracker is the "Server" and will write responses to this file
	SOCKET_SERVER_NOT_FOUND = "Socket server was not initialized",
	FILE_SETTINGS = "NetworkSettings.ini",
	FILE_IMPORT_CODE = "StreamerbotCodeImport.txt",
}

Network.ConnectionTypes = {
	None = "None",
	Text = "Text",

	-- WebSockets WARNING: Bizhawk must be started with command line arguments to enable connections
	-- It must also be a custom/new build of Bizhawk that actually supports asynchronous web sockets (not released yet)
	WebSockets = "WebSockets",

	-- Http WARNING: If Bizhawk is not started with command line arguments to enable connections
	-- Then an internal Bizhawk error will crash the tracker. This cannot be bypassed with pcall() or other exception handling
	-- Consider turning off "AutoConnectStartup" if exploring Http
	Http = "Http",
}

Network.ConnectionState = {
	Closed = 0, -- The server (Tracker) is not currently connected nor trying to connect
	Listen = 1, -- The server (Tracker) is online and trying to connect, waiting for response from a client
	Established = 9, -- Both the server (Tracker) and client are connected; communication is open
}

-- Options related to Network (most unused); gets saved in NetworkSettings.ini
Network.Options = {
	["AutoConnectStartup"] = true,
	["ConnectionType"] = Network.ConnectionTypes.Text,
	["DataFolder"] = "",
	["WebSocketIP"] = "0.0.0.0", -- Localhost: 127.0.0.1
	["WebSocketPort"] = "8080",
	["HttpGet"] = "",
	["HttpPost"] = "",
	["CommandRoles"] = "Everyone", -- A comma-separated list of allowed roles for command events
	["CustomCommandRole"] = "", -- Currently unused, not supported
}

-- In some cases, allow a mismatch between Tracker code and Streamerbot code
-- This simply offers convenience for the end user, such that they aren't forced to update to continue using it
Network.DeprecatedVersions = {
	-- FAKE EXAMPLE: On version 1.0.0 of Streamerbot code, the message cap limit was assumed to be checked by the Tracker, not Streamerbot itself
	-- This override forces the Tracker to check the message cap
	-- ["1.0.0"] = function()
	-- 	RequestHandler.REQUIRES_MESSAGE_CAP = true
	-- end,
}

-- Connection object prototype
Network.IConnection = {
	Type = Network.ConnectionTypes.None,
	State = Network.ConnectionState.Closed,
	UpdateFrequency = -1, -- Number of seconds; 0 or less will prevent scheduled updates
	SendReceive = function(self) end,
	-- Don't override the follow functions
	SendReceiveOnSchedule = function(self, updateFunc)
		if (self.UpdateFrequency or 0) > 0 and (os.time() - Network.lastUpdateTime) >= self.UpdateFrequency then
			updateFunc = updateFunc or self.SendReceive
			if type(updateFunc) == "function" then
				updateFunc(self)
			end
			Network.lastUpdateTime = os.time()
		end
	end,
}
function Network.IConnection:new(o)
	o = o or {}
	setmetatable(o, self)
	self.__index = self
	return o
end

function Network.initialize()
	Network.Data = {}
	Network.iniParser = dofile(Paths.FOLDERS.DATA_FOLDER .. Paths.SLASH .. "Inifile.lua")

	dofile(Paths.FOLDERS.NETWORK_FOLDER .. Paths.SLASH .. "Json.lua")
	dofile(Paths.FOLDERS.NETWORK_FOLDER .. Paths.SLASH .. "EventData.lua")
	dofile(Paths.FOLDERS.NETWORK_FOLDER .. Paths.SLASH .. "EventHandler.lua")
	dofile(Paths.FOLDERS.NETWORK_FOLDER .. Paths.SLASH .. "RequestHandler.lua")
	NetworkUtils.setupJsonLibrary()
	Network.loadSettings()

	-- Clear and reload Event and Request information
	EventHandler.reset()
	RequestHandler.reset()
	EventHandler.addDefaultEvents()
	RequestHandler.loadRequestsData()
	RequestHandler.removedExcludedRequests()

	Network.requiresUpdating = false
	Network.lastUpdateTime = 0
	Network.loadConnectionSettings()
    if Network.Options["AutoConnectStartup"] then
        Network.tryConnect()
    end

end

function Network.delayedStartupActions() -- DEBUG
	EventHandler.onStartup()
end

--- Allow Network access references to various data objects used throughout the software
function Network.linkData(program, tracker, battleHandler, randomizerLogParser)
	if program == nil then
		return
	end
	Network.Data = {
		program = program,
		gameInfo = program.getGameInfo(),
		memoryAddresses = program.getAddresses(),
		tracker = tracker,
		battleHandler = battleHandler,
		seedLogger = program.getSeedLogger(),
		randomizerLogParser = randomizerLogParser,
	}
	EventData.initializeLookupTables()
end

---Returns a message regarding the status of the connection
---@return string
function Network.getConnectionStatusMsg()
	if Network.CurrentConnection.State == Network.ConnectionState.Established then
		return "Online: Connection established."
	elseif Network.CurrentConnection.State == Network.ConnectionState.Listen then
		return "Online: Waiting for connection..."
	else
		return "Offline."
	end
end

--Returns the text color key for the current connection status
---@return string
function Network.getConnectionStatusColor()
	if Network.CurrentConnection.State == Network.ConnectionState.Established then
		return "Positive text color"
	elseif Network.CurrentConnection.State == Network.ConnectionState.Listen then
		return "Intermediate text color"
	else
		return "Negative text color"
	end
end

---Checks current version of the Tracker's Network code against the Streamerbot code version
---@param externalVersion string
function Network.checkVersion(externalVersion)
	externalVersion = externalVersion or "0.0.0"
	Network.currentStreamerbotVersion = externalVersion
	local changeFunc = Network.DeprecatedVersions[externalVersion]
	if type(changeFunc) == "function" then
		changeFunc()
	end

	-- Convert verion strings to numbers such that "05" is less than "8"
	local major1, minor1, patch1 = string.match(Network.STREAMERBOT_VERSION, "(%d+)%.(%d+)%.?(%d*)")
	local major2, minor2, patch2 = string.match(externalVersion, "(%d+)%.(%d+)%.?(%d*)")
	major1 = tonumber(major1 or "") or 0
	major2 = tonumber(major2 or "") or 0
	minor1 = tonumber(minor1 or "") or 0
	minor2 = tonumber(minor2 or "") or 0
	patch1 = tonumber(patch1 or "") or 0
	patch2 = tonumber(patch2 or "") or 0

	-- If tracker code version is newer (greater) than external Streamerbot version, require an update
	Network.requiresUpdating = (major1 * 10000 + minor1 * 100 + patch1) > (major2 * 10000 + minor2 * 100 + patch2)
	if Network.requiresUpdating then
		Network.openUpdateRequiredPrompt()
	end
end

---@return boolean
function Network.isConnected()
	return Network.CurrentConnection.State > Network.ConnectionState.Closed
end

---@return table supportedTypes
function Network.getSupportedConnectionTypes()
	local supportedTypes = {
		Network.ConnectionTypes.Text,
		-- Network.ConnectionTypes.WebSockets, -- Not fully supported
		-- Network.ConnectionTypes.Http, -- Not fully supported
	}
	return supportedTypes
end

function Network.loadConnectionSettings()
	Network.CurrentConnection = Network.IConnection:new()
	if (Network.Options["ConnectionType"] or "") ~= "" then
		Network.changeConnection(Network.Options["ConnectionType"])
	end
end

---Changes the current connection type
---@param connectionType string A Network.ConnectionTypes enum
function Network.changeConnection(connectionType)
	connectionType = connectionType or Network.ConnectionTypes.None
	-- Create or swap to a new connection
	if Network.CurrentConnection.Type ~= connectionType then
		if Network.isConnected() then
			Network.closeConnections()
		end
		Network.CurrentConnection = Network.IConnection:new({ Type = connectionType })
		Network.Options["ConnectionType"] = connectionType
		Network.saveSettings()
	end
end

---Attempts to connect to the network using the current connection
---@return number connectionState The resulting Network.ConnectionState
function Network.tryConnect()
	local C = Network.CurrentConnection or {}
	-- Create or swap to a new connection
	if not C.Type then
		Network.changeConnection(Network.ConnectionTypes.None)
		C = Network.CurrentConnection
	end
	-- Don't try to connect if connection is fully established
	if C.State >= Network.ConnectionState.Established then
		return C.State
	end
	if C.Type == Network.ConnectionTypes.WebSockets then
		if true then return Network.ConnectionState.Closed end -- Not fully supported
		C.UpdateFrequency = Network.SOCKET_UPDATE_FREQUENCY
		C.SendReceive = Network.updateBySocket
		C.SocketIP = Network.Options["WebSocketIP"] or "0.0.0.0"
		C.SocketPort = tonumber(Network.Options["WebSocketPort"] or "") or 0
		local serverInfo
		if C.SocketIP ~= "0.0.0.0" and C.SocketPort ~= 0 then
			comm.socketServerSetIp(C.SocketIP)
			comm.socketServerSetPort(C.SocketPort)
			serverInfo = comm.socketServerGetInfo() or Network.SOCKET_SERVER_NOT_FOUND
			-- Might also test/try 'bool comm.socketServerIsConnected()'
		end
		local ableToConnect = NetworkUtils.containsText(serverInfo, Network.SOCKET_SERVER_NOT_FOUND)
		if ableToConnect then
			C.State = Network.ConnectionState.Listen
			comm.socketServerSetTimeout(500) -- # of milliseconds
		end
	elseif C.Type == Network.ConnectionTypes.Http then
		if true then return Network.ConnectionState.Closed end -- Not fully supported
		C.UpdateFrequency = Network.HTTP_UPDATE_FREQUENCY
		C.SendReceive = Network.updateByHttp
		C.HttpGetUrl = Network.Options["HttpGet"] or ""
		C.HttpPostUrl = Network.Options["HttpPost"] or ""
		if not (C.HttpGetUrl or "") ~= "" then
			-- Necessary for comm.httpTest()
			comm.httpSetGetUrl(C.HttpGetUrl)
		end
		if not (C.HttpPostUrl or "") ~= "" then
			-- Necessary for comm.httpTest()
			comm.httpSetPostUrl(C.HttpPostUrl)
		end
		local result
		if (C.HttpGetUrl or "") ~= "" and C.HttpPostUrl then
			-- See HTTP WARNING at the top of this file
			pcall(function() result = comm.httpTest() or "N/A" end)
		end
		local ableToConnect = NetworkUtils.containsText(result, "done testing")
		if ableToConnect then
			C.State = Network.ConnectionState.Listen
			comm.httpSetTimeout(500) -- # of milliseconds
		end
	elseif C.Type == Network.ConnectionTypes.Text then
		C.UpdateFrequency = Network.TEXT_UPDATE_FREQUENCY
		C.SendReceive = Network.updateByText
		local folder = Network.Options["DataFolder"] or ""
		C.InboundFile = folder .. Paths.SLASH .. Network.TEXT_INBOUND_FILE
		C.OutboundFile = folder .. Paths.SLASH .. Network.TEXT_OUTBOUND_FILE
		local ableToConnect = (folder or "") ~= "" and NetworkUtils.folderExists(folder)
		if ableToConnect then
			C.State = Network.ConnectionState.Listen
		end
	end
	if C.State == Network.ConnectionState.Listen then
		RequestHandler.addUpdateRequest(RequestHandler.IRequest:new({
			EventKey = EventHandler.CoreEventKeys.Start,
		}))
		RequestHandler.addUpdateRequest(RequestHandler.IRequest:new({
			EventKey = EventHandler.CoreEventKeys.GetRewards,
		}))
		RequestHandler.addUpdateRequest(RequestHandler.IRequest:new({
			EventKey = EventHandler.CoreEventKeys.UpdateEvents,
		}))
	end
	return C.State
end

---Updates the current connection state to the one provided
---@param connectionState number a Network.ConnectionState
function Network.updateConnectionState(connectionState)
	Network.CurrentConnection.State = connectionState
end

--- Closes any active connections and saves outstanding Requests
function Network.closeConnections()
	if Network.isConnected() then
		RequestHandler.addUpdateRequest(RequestHandler.IRequest:new({
			EventKey = EventHandler.CoreEventKeys.Stop,
		}))
		Network.CurrentConnection:SendReceive()
		Network.updateConnectionState(Network.ConnectionState.Closed)
	end
	RequestHandler.saveRequestsData()
end

--- Attempts to perform the scheduled network data update
function Network.update()
	if not Network.isConnected() then
		return
	end
	Network.CurrentConnection:SendReceiveOnSchedule()
	RequestHandler.saveRequestsDataOnSchedule()
end

--- The update function used by the "Text" Network connection type
function Network.updateByText()
	local C = Network.CurrentConnection
	if not C.InboundFile or not C.OutboundFile or not NetworkUtils.JsonLibrary then
		return
	end

	EventHandler.checkForConfigChanges()
	local requestsAsJson = NetworkUtils.decodeJsonFile(C.InboundFile)
	RequestHandler.receiveJsonRequests(requestsAsJson)
	RequestHandler.processAllRequests()
	local responses = RequestHandler.getResponses()
	-- Prevent consecutive "empty" file writes
	if #responses > 0 or not C.InboundWasEmpty then
		local success = NetworkUtils.encodeToJsonFile(C.OutboundFile, responses)
		C.InboundWasEmpty = (success == false) -- false if no resulting json data
		RequestHandler.clearAllResponses()
	end
end

--- The update function used by the "Socket" Network connection type
function Network.updateBySocket()
	-- Not implemented. Requires asynchronous compatibility
	if true then return end

	local C = Network.CurrentConnection
	if C.SocketIP == "0.0.0.0" or C.SocketPort == 0 or not NetworkUtils.JsonLibrary then
		return
	end

	EventHandler.checkForConfigChanges()
	local input = ""
	local requestsAsJson = NetworkUtils.JsonLibrary.decode(input) or {}
	RequestHandler.receiveJsonRequests(requestsAsJson)
	RequestHandler.processAllRequests()
	local responses = RequestHandler.getResponses()
	if #responses > 0 then
		local output = NetworkUtils.JsonLibrary.encode(responses) or "[]"
		RequestHandler.clearAllResponses()
	end
end

--- The update function used by the "Http" Network connection type
function Network.updateByHttp()
	-- Not implemented. Requires asynchronous compatibility
	if true then return end

	local C = Network.CurrentConnection
	if (C.HttpGetUrl or "") == "" or (C.HttpPostUrl or "") == "" or not NetworkUtils.JsonLibrary then
		return
	end

	EventHandler.checkForConfigChanges()
	local resultGet = comm.httpGet(C.HttpGetUrl) or ""
	local requestsAsJson = NetworkUtils.JsonLibrary.decode(resultGet) or {}
	RequestHandler.receiveJsonRequests(requestsAsJson)
	RequestHandler.processAllRequests()
	local responses = RequestHandler.getResponses()
	if #responses > 0 then
		local payload = NetworkUtils.JsonLibrary.encode(responses) or "[]"
		local resultPost = comm.httpPost(C.HttpPostUrl, payload)
		RequestHandler.clearAllResponses()
	end
end

function Network.loadSettings()
	Network.MetaSettings = {}
	local filepath = Paths.FOLDERS.NETWORK_FOLDER .. Paths.SLASH .. Network.FILE_SETTINGS
	if not FormsUtils.fileExists(filepath) then
		return
	end

	local settings = Network.iniParser.parse(filepath) or {}
	-- Keep the meta data for saving settings later in a specified order
	Network.MetaSettings = settings

	-- [NETWORK]
	if settings.network ~= nil then
		for key, _ in pairs(Network.Options or {}) do
			local optionValue = settings.network[string.gsub(key, " ", "_")]
			if optionValue ~= nil then
				Network.Options[key] = optionValue
			end
		end
	end
end

function Network.saveSettings()
	local settings = Network.MetaSettings or {}
	settings.network = settings.network or {}

	-- [NETWORK]
	for key, val in pairs(Network.Options or {}) do
		local encodedKey = string.gsub(key, " ", "_")
		settings.network[encodedKey] = val
	end

	local filepath = Paths.FOLDERS.NETWORK_FOLDER .. Paths.SLASH .. Network.FILE_SETTINGS
	Network.iniParser.save(filepath, settings)
end

function Network.getStreamerbotCode()
	local filepath = Paths.FOLDERS.NETWORK_FOLDER .. Paths.SLASH .. Network.FILE_IMPORT_CODE
	return MiscUtils.readStringFromFile(filepath) or ""
end

---Required update check if an update needs total change Streamerbot Code (tracker can only change its own tracker code)
---This requires the user to re-import the StreamerbotCodeImport.txt (which the tracker dev needs to regenerate)
function Network.openUpdateRequiredPrompt()
	local form = forms.newform(350, 150, "Streamerbot Update Required", function()
		client.unpause()
	end)
	local x, y, lineHeight = 20, 20, 20
	local lb1 = forms.label(form, "Streamerbot Tracker Integration code requires an update.", x, y)
	y = y + lineHeight
	local lb2 = forms.label(form, "You must re-import the code to continue using Stream Connect.", x, y)
	y = y + lineHeight
	-- Bottom row buttons
	y = y + 10
	local btn1 = forms.button(form, "Show Me", function()
		forms.destroy(form)
		client.unpause()
		Network.openGetCodeWindow()
	end, 40, y)
	local btn2 = forms.button(form, "Turn Off Stream Connect", function()
		Network.Options["AutoConnectStartup"] = false
		Network.saveSettings()
		Network.closeConnections()
		forms.destroy(form)
		client.unpause()
	end, 150, y)

	-- Autosize form control elements
	forms.setproperty(lb1, "AutoSize", true)
	forms.setproperty(lb2, "AutoSize", true)
	forms.setproperty(btn1, "AutoSize", true)
	forms.setproperty(btn2, "AutoSize", true)
end

---Displays the full import code required to add actions/command triggers to Streamerbot.
---If the external Streamerbot code ever changes, this import code *must* be regenerated via export
function Network.openGetCodeWindow()
	local form = forms.newform(800, 600, "Import to Streamerbot", function()
		client.unpause()
	end)
	local x, y, lineHeight = 20, 15, 20
	local lb1 = forms.label(form, '1. On Streamerbot, click the IMPORT button at the top.', x, y)
	y = y + lineHeight
	local lb2 = forms.label(form, '2. Copy/paste the below code into the top textbox. Click "Import" then "OK".', x, y)
	y = y + lineHeight
	local lb3 = forms.label(form, '3. Restart Streamerbot (this is required).', x, y)
	y = y + lineHeight

	local codeText = Network.getStreamerbotCode()
	local txtbox1 = forms.textbox(form, codeText, 763, 442, "", x - 1, y, true, true, "Vertical")

	local lb4 = forms.label(form, string.format("Streamerbot Code Version: %s", Network.STREAMERBOT_VERSION), x, 530)
	local btn1 = forms.button(form, "Close", function()
		forms.destroy(form)
		client.unpause()
	end, 350, 530)

	-- Autosize form control elements
	forms.setproperty(lb1, "AutoSize", true)
	forms.setproperty(lb2, "AutoSize", true)
	forms.setproperty(lb3, "AutoSize", true)
	forms.setproperty(lb4, "AutoSize", true)
	forms.setproperty(btn1, "AutoSize", true)
end

---Opens an dialog prompt popup to configure Role Permissions used for commands. Several checkboxes
function Network.openCommandRolePermissionsPrompt()
	local form = forms.newform(320, 255, "Edit Command Roles", function()
		client.unpause()
	end)

	local x, y = 20, 15
	local lineHeight = 21
	local commandLabel = string.format("Select user roles that can use Tracker chat commands:")
	local lb1 = forms.label(form, commandLabel, x - 1, y - 1)
	forms.setproperty(lb1, "AutoSize", true)
	y = y + lineHeight

	-- Current role options, from the user settings
	local currentRoles = {}
	for _, roleKey in pairs(MiscUtils.split(Network.Options["CommandRoles"], ",", true) or {}) do
		currentRoles[roleKey] = true
	end
	-- All available role options, in a predefined order
	local orderedRoles = { "Broadcaster", "Moderator", "Vip", "Subscriber", --[["Custom",]] "Everyone" }
	local roleCheckboxes = {}
	local customRoleTextbox

	-- Enable or Disable all non-Everyone roles based on the state of Everyone role being allowed
	local function enableDisableAll()
		local allowEveryone = forms.ischecked(roleCheckboxes["Everyone"])
		for _, roleKey in ipairs(orderedRoles) do
			if roleKey ~= "Everyone" and roleKey ~= "Broadcaster" then
				forms.setproperty(roleCheckboxes[roleKey], "Enabled", not allowEveryone)
			end
		end
		if customRoleTextbox then
			forms.setproperty(customRoleTextbox, "Enabled", not allowEveryone)
		end
	end

	for i, roleKey in ipairs(orderedRoles) do
		local roleLabel = roleKey
		if roleKey == "Custom" then
			roleLabel = "Custom Role:"
			customRoleTextbox = forms.textbox(form, Network.Options["CustomCommandRole"], 120, 19, "", x + 143, y + lineHeight * (i - 1))
		end
		local clickFunc = (roleKey == "Everyone" and enableDisableAll) or nil
		roleCheckboxes[roleKey] = forms.checkbox(form, roleLabel, x, y + lineHeight * (i - 1))
		forms.setproperty(roleCheckboxes[roleKey], "AutoSize", true)
		if clickFunc then
			forms.addclick(roleCheckboxes[roleKey], clickFunc)
		end
		local roleAllowed = currentRoles["Everyone"] ~= nil or currentRoles[roleKey] ~= nil
		forms.setproperty(roleCheckboxes[roleKey], "Checked", roleAllowed)
	end
	forms.setproperty(roleCheckboxes["Broadcaster"], "Checked", true)
	forms.setproperty(roleCheckboxes["Broadcaster"], "Enabled", false)

	enableDisableAll()

	local buttonRowY = y + lineHeight * #orderedRoles + 15
	local btn1 = forms.button(form, "Save", function()
		if forms.ischecked(roleCheckboxes["Everyone"]) then
			Network.Options["CommandRoles"] = EventHandler.CommandRoles.Everyone
		else
			if forms.ischecked(roleCheckboxes["Custom"]) and customRoleTextbox then
				Network.Options["CustomCommandRole"] = forms.gettext(customRoleTextbox) or ""
			else
				Network.Options["CustomCommandRole"] = ""
			end
			local allowedRoles = {}
			for _, roleKey in ipairs(orderedRoles) do
				if forms.ischecked(roleCheckboxes[roleKey]) then
					if roleKey == "Custom" then
						if (Network.Options["CustomCommandRole"] or "") ~= "" then
							table.insert(allowedRoles, Network.Options["CustomCommandRole"])
						end
					else
						table.insert(allowedRoles, EventHandler.CommandRoles[roleKey])
					end
				end
			end
			Network.Options["CommandRoles"] = table.concat(allowedRoles, ",")
		end
		Network.saveSettings()
		RequestHandler.addUpdateRequest(RequestHandler.IRequest:new({
			EventKey = EventHandler.CoreEventKeys.UpdateEvents,
		}))
		forms.destroy(form)
		client.unpause()
	end, 30, buttonRowY)
	local btn2 = forms.button(form, "(Default)", function()
		for _, roleKey in ipairs(orderedRoles) do
			forms.setproperty(roleCheckboxes[roleKey], "Checked", true)
		end
		if customRoleTextbox then
			forms.settext(customRoleTextbox, "")
		end
		enableDisableAll()
	end, 120, buttonRowY)
	local btn3 = forms.button(form, "Cancel", function()
		forms.destroy(form)
		client.unpause()
	end, 210, buttonRowY)

	-- Autosize form control elements
	forms.setproperty(btn1, "AutoSize", true)
	forms.setproperty(btn2, "AutoSize", true)
	forms.setproperty(btn3, "AutoSize", true)
end

-- Not supported

-- [Web Sockets] Streamer.bot Docs
-- https://wiki.streamer.bot/en/Servers-Clients
-- https://wiki.streamer.bot/en/Servers-Clients/WebSocket-Server
-- https://wiki.streamer.bot/en/Servers-Clients/WebSocket-Server/Requests
-- https://wiki.streamer.bot/en/Servers-Clients/WebSocket-Server/Events
-- [Web Sockets] Bizhawk Docs
-- string comm.socketServerGetInfo 		-- returns the IP and port of the Lua socket server
-- bool comm.socketServerIsConnected 	-- socketServerIsConnected
-- string comm.socketServerResponse 	-- Receives a message from the Socket server. Formatted with msg length at start, e.g. "3 ABC"
-- int comm.socketServerSend 			-- sends a string to the Socket server
-- void comm.socketServerSetTimeout 	-- sets the timeout in milliseconds for receiving messages
-- bool comm.socketServerSuccessful 	-- returns the status of the last Socket server action

-- --- Registering an event is required to enable you to listen to events emitted by Streamer.bot:
-- --- https://wiki.streamer.bot/en/Servers-Clients/WebSocket-Server/Events
-- ---@param requestId string Example: "123"
-- ---@param eventSource string Example: "Command"
-- ---@param eventTypes table Example: { "Message", "Whisper" }
-- function Network.registerWebSocketEvent(requestId, eventSource, eventTypes)
-- 	local registerFormat = [[{"request":"Subscribe","id":"%s","events":{"%s":[%s]}}]]
-- 	local requestStr = string.format(registerFormat, requestId, eventSource, table.concat(eventTypes, ","))
-- 	local response = comm.socketServerSend(requestStr)
-- 	-- -1 = failed ?
-- end
-- NDS Ironnon Tracker
-- Created by OnlySpaghettiCode, largely based on the Ironmon Tracker by besteon and other contributors
IronmonTracker = {}
local Main = dofile("ironmon_tracker/Main.lua")
function IronmonTracker.startTracker()
	gui.clearImageCache()
	collectgarbage("collect")
	local main = Main()
	main.run()
end

IronmonTracker.startTracker()
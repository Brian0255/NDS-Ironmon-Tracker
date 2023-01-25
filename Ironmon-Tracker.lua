-- NDS Ironnon Tracker
-- Created by OnlySpaghettiCode, largely based on the Ironmon Tracker by besteon and other contributors
local Main = dofile("ironmon_tracker/Main.lua")
IronmonTracker = {}
function IronmonTracker.startTracker()
	gui.clearImageCache()
	collectgarbage()
	local main = Main()
	main.run()
end

IronmonTracker.startTracker()
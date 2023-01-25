-- NDS Ironnon Tracker
-- Created by OnlySpaghettiCode, largely based on the Ironmon Tracker by besteon and other contributors
IronmonTracker = {}
function IronmonTracker.startTracker()
	local Main = dofile("ironmon_tracker/Main.lua")
	gui.clearImageCache()
	collectgarbage("collect")
	local main = Main()
	main.run()
end

IronmonTracker.startTracker()
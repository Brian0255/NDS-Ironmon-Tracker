Input = {}
local previousJoypad
local previousMouse
local mouse
local controller

function Input.updateMouse()
	previousMouse = mouse
	mouse = input.getmouse()
end

function Input.updateJoypad()
	previousJoypad = controller
	controller = joypad.get()
end

function Input.getMousePosition()
	return {
		x = mouse["X"],
		y = (mouse["Y"] + 384) / 2
	}
end

function Input.getMouse()
	return mouse
end

function Input.getJoypad()
	return controller
end

function Input.getPreviousJoypad()
	return previousJoypad
end

function Input.getScrollWheelChange()
	if mouse ~= nil and previousMouse ~= nil then
		return (mouse["Wheel"] - previousMouse["Wheel"])
	end
	return 0
end

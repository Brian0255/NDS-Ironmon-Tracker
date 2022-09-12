Input = {}
local mouse
local controller
function Input.updateMouse()
	mouse = input.getmouse()
end
function Input.updateJoypad()
	controller = joypad.get()
end
function Input.getMousePosition()
	return {
		x = mouse["X"],
		y = (mouse["Y"]+384)/2
	}
end
function Input.getMouse()
	return mouse
end
function Input.getJoypad()
	return controller
end
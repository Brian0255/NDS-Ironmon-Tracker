Input = {}

function Input.getMousePosition()
	local mouse = input.getmouse()
	return {
		x = mouse["X"],
		y = (mouse["Y"]+384)/2
	}
end
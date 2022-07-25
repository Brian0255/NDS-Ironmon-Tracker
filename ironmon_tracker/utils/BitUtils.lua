function BitUtils.getbits(a, b, d)
	return bit.rshift(a, b) % bit.lshift(1, d)
end

function BitUtils.addhalves(a)
	local b = Utils.getbits(a, 0, 16)
	local c = Utils.getbits(a, 16, 16)
	return b + c
end
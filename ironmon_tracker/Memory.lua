Memory = {}

function Memory.inRange(addr)
	return (0x000000 <= addr and addr <= 0x3FFFFF)
end

function Memory.read_u32_le(addr)
	if Memory.inRange(addr) then
		return memory.read_u32_le(addr)
	else
		return 0x00000000
	end
end

function Memory.read_u16_le(addr)
	if Memory.inRange(addr) then
		return memory.read_u16_le(addr)
	else
		return 0x0000
	end
end

function Memory.read_u8(addr)
	if Memory.inRange(addr) then
		return memory.read_u8(addr)
	else
		return 0x00
	end
end

BitUtils = {}

function BitUtils.getBits(number, start, numberOfBits)
    return bit.rshift(number, start) % bit.lshift(1, numberOfBits)
end

function BitUtils.addhalves(a)
    local b = BitUtils.getbits(a, 0, 16)
    local c = BitUtils.getbits(a, 16, 16)
    return b + c
end

function BitUtils.mult32(num1, num2)
    local num1Shift = bit.rshift(num1, 16)
    local remainderNum1 = num1 % 0x10000

    local num2Shift = bit.rshift(num2, 16)
    local remainderNum2 = num2 % 0x10000

    local remainderBoth = (num1Shift * remainderNum2 + remainderNum1 * num2Shift) % 0x10000
    local remainderProduct = remainderNum1 * remainderNum2
    local result = remainderBoth * 0x10000 + remainderProduct
    return result
end

local function makeInteger(value)
    return math.floor(value)
end

local function initializeBitFunctions()
    bit.band = function(value, amount)
        value = makeInteger(value)
        return value & amount
    end

    bit.rshift = function(value, amount)
        value = makeInteger(value)
        return value >> amount
    end

    bit.lshift = function(value, amount)
        value = makeInteger(value)
        return value << amount
    end

    bit.bxor = function(value, amount)
        value = makeInteger(value)
        return value ~ amount
    end

    bit.bor = function(value, amount)
        value = makeInteger(value)
        return value | amount
    end
end

initializeBitFunctions()
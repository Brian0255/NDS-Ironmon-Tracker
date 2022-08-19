MiscUtils = {}

function MiscUtils.inlineIf(condition, T, F)
    if condition then
        return T
    else
        return F
    end
end

function MiscUtils.readOnly(t)
    local proxy = {}
    local metatable = {
        __index = t,
        __newindex = function()
            error("attempt to update a read-only table", 2)
        end
    }
    setmetatable(proxy, metatable)
    return proxy
end

function MiscUtils.boolToNumber(value)
    return value and 1 or 0
end

function MiscUtils.numberToBool(value)
    if value == 1 then
        return true
    end
    return false
end

function MiscUtils.split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

function MiscUtils.mouseInRange(mouseX, mouseY, controlX, controlY, width, height)
    if mouseX >= controlX and mouseX <= controlX + width then
        if mouseY >= controlY and mouseY <= controlY + height then
            return true
        end
    end
    return false
end
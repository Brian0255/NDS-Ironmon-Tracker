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
    local result = {}
    for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
        table.insert(result,match)
    end
    return result
end

function MiscUtils.tableContains(table,value)
    for _, item in pairs(table) do
        if item == value then
            return true
        end
    end
    return false
end

function MiscUtils.mouseInRange(mouseX, mouseY, controlX, controlY, width, height)
    if mouseX >= controlX and mouseX <= controlX + width then
        if mouseY >= controlY and mouseY <= controlY + height then
            return true
        end
    end
    return false
end

function MiscUtils.clampFramePosition(alignment, position, mainFrame, frameSize)
    if alignment == Graphics.HOVER_ALIGNMENT_TYPE.ALIGN_ABOVE then
        position.y = position.y - frameSize.height
    end
    position.x = math.min(position.x, mainFrame.getPosition().x + mainFrame.getSize().width - frameSize.width - 1)
    position.y = math.max(0, position.y)
end

function MiscUtils.deepCopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[MiscUtils.deepCopy(orig_key)] = MiscUtils.deepCopy(orig_value)
        end
        setmetatable(copy, MiscUtils.deepCopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

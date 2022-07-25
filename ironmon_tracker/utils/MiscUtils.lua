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

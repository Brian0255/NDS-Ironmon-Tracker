local State = {}
State.__index = State

function State.new(state)
    local self = setmetatable({}, State)
    self.state = state
    return self
end

function State:changeState(newState)
    self.state = newState
end

function State:getState()
    return self.state
end

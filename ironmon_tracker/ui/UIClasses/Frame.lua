--Frame inherits from base class Component.
--The only difference is that a frame is a "container" that holds component objects.

local function Frame(
    initialScreen,
    initialParent,
    initialPosition,
    initialSize,
    initialBGColorKey,
    initialBGFillColorKey,
    initialComponents)
    local Component = dofile("Component")

    local self =
        Component(initialScreen, initialParent, initialPosition, initialSize, initialBGColorKey, initialBGFillColorKey)

    local components = initialComponents

    function self.getComponents()
        return components
    end

    return self
end

return Frame

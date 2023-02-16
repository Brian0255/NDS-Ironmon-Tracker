local function ScrollBar(initialFrame, spaceAvailable, initialItemSet)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/cOMPONENT.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local ImageLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageLabel.lua")
    local ImageField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageField.lua")
    local FrameCounter = dofile(Paths.FOLDERS.DATA_FOLDER.."/FrameCounter.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local ScrollEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ScrollEventListener.lua")

    local self = {}
    local eventListeners = {}
    local frameCounters = {}
    local itemSet = initialItemSet
    local space = spaceAvailable
    local scroller
    local limit = #itemSet
    local maxIndex = limit - space + 1
    local currentIndex = 1
    local frame = initialFrame
    local dragging = false
    local scrollBaseY
    local currentAnchorY = nil
    local scrollerX = frame.getSize().width - 6
    local scrollReadingFunction = nil

    local function onScrollerClick()
        dragging = true
        scrollBaseY = scroller.getPosition().y - frame.getPosition().y
        currentAnchorY = Input.getMousePosition().y
    end

    local function updateScrollerSize()
        local verticalSpace = frame.getSize().height
        local percentageTaken = space/limit * verticalSpace
        scroller.resize({width = 5, height = percentageTaken})
    end

    function self.setScrollReadingFunction(newScrollReadingFunction)
        scrollReadingFunction = newScrollReadingFunction
    end

    local function createScroller()
        scroller = TextLabel(
            Component(
                frame,
                Box(
                    {x = scrollerX, y = 0},
                    {
                        width = 0,
                        height = 0
                    },
                    "Top box border color",
                    "Top box border color"
                )
            ),
            TextField(
                "",
                {x = 0, y = 0},
                TextStyle(Graphics.FONT.DEFAULT_FONT_SIZE, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
    end
    local function updateScrollerFromCurrentIndex()
        local maxVerticalRoom = frame.getSize().height - scroller.getSize().height
        local scrollerY = (currentIndex-1)/(maxIndex-1) * maxVerticalRoom 
        scroller.move({x=scrollerX,y=scrollerY})
    end

    local function onMouseUp()
        dragging = false
        updateScrollerFromCurrentIndex()
        scrollReadingFunction()
    end

    function self.setItems(newItems)
        itemSet = newItems
        limit = #itemSet
        maxIndex = limit - space + 1
        currentIndex = 1
        updateScrollerSize()
        updateScrollerFromCurrentIndex()
        scroller.setVisibility(limit > spaceAvailable)
    end

    function self.getViewedItems()
        local items = {}
        for i = currentIndex, currentIndex + space - 1, 1 do
            table.insert(items, itemSet[i])
        end
        return items
    end
    
    local function scrollForward()
        if not dragging then
            currentIndex = math.min(currentIndex + 1,maxIndex)
            updateScrollerFromCurrentIndex()
            scrollReadingFunction()
        end
    end

    local function scrollBackward()
        if not dragging then 
            currentIndex = math.max(1, currentIndex - 1)
            updateScrollerFromCurrentIndex()
            scrollReadingFunction()
        end
    end


    local function updateItemsFromScroller()
        local maxVerticalRoom = frame.getSize().height - scroller.getSize().height
        local distanceMovedDown = scroller.getPosition().y
        local percentange = distanceMovedDown/maxVerticalRoom
        local previousIndex = currentIndex
        currentIndex = math.floor((percentange * (maxIndex-1)) + 1.5) 
        if previousIndex ~= currentIndex then
            updateScrollerFromCurrentIndex()
            scrollReadingFunction()
        end
    end

    local function updateScroller()
        if dragging then
            local mouse = Input.getMouse()
            local currentMouseY = Input.getMousePosition().y
            local difference = scrollBaseY + (currentMouseY - currentAnchorY)
            local maxY = frame.getSize().height - scroller.getSize().height
            difference = math.min(maxY, difference)
            difference = math.max(0, difference)
            scroller.move({x = scrollerX, y = difference})
            updateItemsFromScroller()
        end
    end

    function self.update()
        if scroller.isVisible() then
            for _, frameCounter in pairs(frameCounters) do
                frameCounter.decrement()
            end 
            for _, eventListener in pairs(eventListeners) do
                eventListener.listen()
            end
        end
    end

    createScroller()
    table.insert(eventListeners, ScrollEventListener(frame, scrollForward, nil, Graphics.SCROLL_DIRECTION.DOWN))
    table.insert(eventListeners, ScrollEventListener(frame, scrollBackward, nil, Graphics.SCROLL_DIRECTION.UP))
    eventListeners.mouseClick =  MouseClickEventListener(scroller, onScrollerClick, nil, onMouseUp)
    table.insert(frameCounters, FrameCounter(3,updateScroller))

    return self
end

return ScrollBar
Images = {}

ImageTypes = {
    GEAR = "gear",
    PHYSICAL = "physical",
    SPECIAL = "special"
}

function Images.drawImage(imageType,x,y)
    local imageArray = {}

    if imageType == ImageTypes.GEAR then
        imageArray = Images.getGearArray()
    elseif imageType == ImageTypes.PHYSICAL then
        imageArray = Images.getPhysicalArray()
    elseif imageType == ImageTypes.SPECIAL then
        imageArray = Images.getSpecialArray()
    end

    local shadow = 0x00000000
    if imageType == ImageTypes.PHYSICAL or imageType == ImageTypes.SPECIAL then
        shadow = Drawing.calcShadowColor(GraphicConstants.layoutColors["Bottom box background color"])
    else
        shadow = Drawing.calcShadowColor(GraphicConstants.layoutColors["Top box background color"])
    end
    for rowIndex = 1, #imageArray, 1 do
        for colIndex = 1,#(imageArray[1]) do
            local offsetX = colIndex - 1
            local offsetY = rowIndex - 1
            local color = imageArray[rowIndex][colIndex]
            if color ~= -1 then
                if Settings.ColorSettings.Draw_shadows then gui.drawPixel(x+offsetX+1,y+offsetY+1,shadow) end
                gui.drawPixel(x+offsetX,y+offsetY,color)
            end
        end
    end
end

function Images.getPhysicalArray()
    local c = GraphicConstants.layoutColors["Physical icon color"]
    local x = -1
    local physicalImageArray = {
        {c,x,x,c,x,x,c},
        {x,c,x,c,x,c,x},
        {x,x,c,c,c,x,x},
        {c,c,c,c,c,c,c},
        {x,x,c,c,c,x,x},
        {x,c,x,c,x,c,x},
        {c,x,x,c,x,x,c}
    }
    return physicalImageArray
end

function Images.getSpecialArray()
    local c = GraphicConstants.layoutColors["Special icon color"]
    local x = -1
    local specialImageArray = {
        {x,x,c,c,c,x,x},
        {x,c,x,x,x,c,x},
        {c,x,x,c,x,x,c},
        {c,x,c,x,c,x,c},
        {c,x,x,c,x,x,c},
        {x,c,x,x,x,c,x},
        {x,x,c,c,c,x,x}
    }
    return specialImageArray
end

function Images.getGearArray()
    local c = GraphicConstants.layoutColors["Gear icon color"]
    local x = -1
    local gearImageArray = {
        {x,x,x,c,c,x,x,x},
        {x,c,c,c,c,c,c,x},
        {x,c,c,c,c,c,c,x},
        {c,c,c,x,x,c,c,c},
        {c,c,c,x,x,c,c,c},
        {x,c,c,c,c,c,c,x},
        {x,c,c,c,c,c,c,x},
        {x,x,x,c,c,x,x,x}
    }
    return gearImageArray
end
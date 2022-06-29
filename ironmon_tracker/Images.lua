Images = {
    typeIconImageArray = {}
}

ImageTypes = {
    GEAR = "gear",
    PHYSICAL = "physical",
    SPECIAL = "special",
    STATUS = "status"
}

function Images.drawImage(imageType,x,y)
    local imageArray = {}

    if imageType == ImageTypes.GEAR then
        imageArray = Images.getGearArray()
    elseif imageType == ImageTypes.PHYSICAL then
        imageArray = Images.getPhysicalArray()
    elseif imageType == ImageTypes.SPECIAL then
        imageArray = Images.getSpecialArray()
    elseif imageType == ImageTypes.STATUS then
        imageArray = Images.getStatusArray()
    elseif imageType == ImageTypes.NOTE then
        imageArray = Images.getNoteArray()
    end

    local shadow = 0x00000000
    if imageType == ImageTypes.PHYSICAL or imageType == ImageTypes.SPECIAL or imageType == ImageTypes.STATUS or imageType == ImageTypes.NOTE then
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
                color = GraphicConstants.layoutColors[imageArray[rowIndex][colIndex]]
                if Settings.ColorSettings.Draw_shadows then gui.drawPixel(x+offsetX+1,y+offsetY+1,shadow) end
                gui.drawPixel(x+offsetX,y+offsetY,color)
            end
        end
    end
end

function Images.drawTypeIcon(moveType,x,y)
    if moveType ~= "---" then
        local imageArray = Images.typeIconImageArray[moveType]
        for rowIndex = 1, #imageArray, 1 do
            for colIndex = 1,#(imageArray[1]) do
                local offsetX = colIndex - 1
                local offsetY = rowIndex - 1
                local color = imageArray[rowIndex][colIndex]
                if color ~= -1 then
                    color = GraphicConstants.layoutColors["Default text color"]
                    if Settings.ColorSettings.Color_move_type_icons then 
                        color = GraphicConstants.TYPECOLORS[moveType] 
                    end
                    local shadow = Drawing.calcShadowColor(GraphicConstants.layoutColors["Bottom box background color"])
                    if Settings.ColorSettings.Draw_shadows then
                        gui.drawPixel(x+offsetX+1,y+offsetY+1,shadow)
                    end
                    gui.drawPixel(x+offsetX,y+offsetY,color)
                end
            end
        end
    end
end

function Images.getPhysicalArray()
    local c = "Physical icon color"
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
    local c = "Special icon color"
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
    local c = "Gear icon color"
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


function Images.getStatusArray()
    local c = "Default text color"
    local x = -1
    local statusImageArray = {
        {x,c,c,c,c,c,x},
        {c,c,x,c,c,c,c},
        {c,x,x,c,c,c,c},
        {c,x,x,x,c,c,c},
        {c,x,x,x,x,c,c},
        {c,c,x,x,c,c,c},
        {x,c,c,c,c,c,x}
    }
    return statusImageArray
end

function Images.getNoteArray()
    local c = "Bottom box border color"
    local x = -1
    local noteArray = {
        {x,x,x,x,x,x,x,x,x,c,c},
        {x,x,x,x,x,x,x,x,c,x,c},
        {c,c,c,c,c,c,c,c,c,c,x},
        {c,x,x,x,x,x,x,c,c,x,x},
        {c,x,c,c,c,x,c,x,c,x,x},
        {c,x,x,x,x,x,x,x,c,x,x},
        {c,x,c,c,c,c,c,x,c,x,x},
        {c,x,x,x,x,x,x,x,c,x,x},
        {c,x,c,c,c,c,c,x,c,x,x},
        {c,x,x,x,x,x,x,x,c,x,x},
        {c,c,c,c,c,c,c,c,c,x,x},
    }
    return noteArray
end

function Images.initializeTypeIconArray()
    --Always drawn as the background shaded color, so we just need 1 and -1.
    --c = color, x = blank
    local c = 1
    local x = -1
    Images.typeIconImageArray["fire"] = {
        {x,x,x,c,x,x,x,x},
        {x,x,c,c,x,c,x,x},
        {x,c,x,c,x,c,c,x},
        {c,x,x,x,c,x,x,c},
        {c,x,x,x,x,x,x,c},
        {c,x,x,x,x,x,x,c},
        {x,c,x,x,x,x,c,x},
        {x,x,c,c,c,c,x,x},
    }
    Images.typeIconImageArray["water"] = {
        {x,x,x,c,x,x,x,x,x},
        {x,x,c,x,c,x,x,x,x},
        {x,x,c,x,c,x,x,x,x},
        {x,c,x,x,x,c,x,x,x},
        {x,c,x,x,x,c,x,x,x},
        {x,c,x,x,x,c,x,x,x},
        {x,c,x,x,x,c,x,x,x},
        {x,x,c,c,c,x,x,x,x},
    }
    Images.typeIconImageArray["grass"] = {
        {x,x,x,c,x,x,x,x},
        {x,x,c,x,c,x,x,x},
        {x,c,x,x,x,c,x,x},
        {c,x,x,x,x,x,c,x},
        {c,x,x,x,x,x,c,x},
        {c,x,x,x,x,x,c,x},
        {x,c,c,x,c,c,x,x},
        {x,x,x,c,x,x,x,x},
    }
    Images.typeIconImageArray["electric"] = {
        {x,x,x,c,c,c,x,x},
        {x,x,c,x,x,c,x,x},
        {x,c,x,x,c,c,c,c},
        {c,x,x,x,x,x,x,c},
        {c,c,c,c,c,x,x,c},
        {x,x,x,c,x,x,c,x},
        {x,x,c,x,x,c,x,x},
        {x,x,c,c,c,x,x,x},
    }
    Images.typeIconImageArray["ghost"] = {
        {x,x,c,c,c,x,x,x},
        {x,c,x,x,x,c,x,x},
        {c,x,c,x,c,x,c,x},
        {c,x,x,x,x,x,c,x},
        {c,x,x,x,x,x,c,x},
        {c,x,x,x,x,x,c,x},
        {c,x,c,x,c,x,c,x},
        {x,c,x,c,x,c,x,x},
    }
    Images.typeIconImageArray["bug"] = {
        {x,x,c,x,x,c,x,x},
        {c,x,x,c,c,x,x,c},
        {x,c,c,x,x,c,c,x},
        {x,c,x,x,x,x,c,x},
        {c,c,x,x,x,x,c,c},
        {x,c,x,x,x,x,c,x},
        {x,x,c,x,x,c,x,x},
        {x,c,x,c,c,x,c,x},
    }
    Images.typeIconImageArray["poison"] = {
        {x,c,c,x,x,x,x,x},
        {c,x,x,c,x,x,x,x},
        {c,x,x,c,x,x,c,x},
        {x,c,c,x,x,c,x,c},
        {x,x,x,x,x,x,c,x},
        {x,x,c,c,x,x,x,x},
        {x,c,x,x,c,x,x,x},
        {x,x,c,c,x,x,x,x},
    }
    Images.typeIconImageArray["normal"] = {
        {x,x,c,c,c,c,x,x},
        {x,c,x,x,x,x,c,x},
        {c,x,x,c,c,x,x,c},
        {c,x,c,x,x,c,x,c},
        {c,x,c,x,x,c,x,c},
        {c,x,x,c,c,x,x,c},
        {x,c,x,x,x,x,c,x},
        {x,x,c,c,c,c,x,x},
    }
    Images.typeIconImageArray["dark"] = {
        {x,c,c,x,x,c,c,x},
        {c,x,c,x,x,c,x,c},
        {c,x,x,c,c,x,x,c},
        {c,x,x,x,x,x,x,c},
        {c,x,x,x,x,x,x,c},
        {x,c,x,x,x,x,c,x},
        {x,x,c,c,c,c,x,x},
        {x,x,x,x,x,x,x,x},
    }
    Images.typeIconImageArray["ice"] = {
        {x,x,x,c,x,x,x,x},
        {x,c,x,c,x,c,x,x},
        {x,x,c,x,c,x,x,x},
        {c,c,x,c,x,c,c,x},
        {x,x,c,x,c,x,x,x},
        {x,c,x,c,x,c,x,x},
        {x,x,x,c,x,x,x,x},
        {x,x,x,x,x,x,x,x},
    }
    Images.typeIconImageArray["psychic"] = {
        {x,x,c,c,c,c,x,x},
        {x,c,x,x,x,x,c,x},
        {c,x,x,c,c,x,x,c},
        {c,x,c,x,c,x,x,c},
        {c,x,c,x,x,x,c,x},
        {c,x,x,c,c,c,x,x},
        {x,c,x,x,x,x,x,c},
        {x,x,c,c,c,c,c,x},
    }
    Images.typeIconImageArray["rock"] = {
        {x,x,c,c,c,x,x,x},
        {x,c,x,x,x,c,x,x},
        {x,c,x,x,x,c,c,x},
        {c,x,x,x,c,x,x,c},
        {c,x,x,c,x,x,x,c},
        {c,x,x,c,x,x,x,c},
        {x,c,x,c,x,c,c,x},
        {x,x,c,c,c,x,x,x},
    }
    Images.typeIconImageArray["ground"] = {
        {x,x,x,x,x,x,x,x},
        {x,x,x,c,c,x,x,x},
        {x,x,c,x,x,c,x,x},
        {x,x,c,x,c,c,x,x},
        {x,c,c,c,x,x,c,x},
        {x,c,x,x,x,x,c,x},
        {c,x,x,x,x,x,x,c},
        {c,c,c,c,c,c,c,c},
    }
    --next two are questionable
    Images.typeIconImageArray["steel"] = {
        {x,x,x,x,x,x,x,x},
        {x,c,c,x,c,c,x,x},
        {c,x,x,x,x,x,c,x},
        {c,x,c,c,c,x,c,x},
        {x,x,x,c,x,x,x,x},
        {x,x,x,c,x,x,x,x},
        {x,c,x,x,x,c,x,x},
        {x,x,c,c,c,x,x,x},
    }
    Images.typeIconImageArray["fighting"] = {
        {x,x,x,c,x,c,x,x},
        {x,x,c,x,c,x,c,x},
        {x,c,c,x,c,x,c,x},
        {c,x,c,x,c,x,c,x},
        {c,x,c,x,x,x,c,x},
        {c,x,x,x,x,x,c,x},
        {x,c,x,x,x,x,c,x},
        {x,x,c,c,c,c,x,x},
    }
    Images.typeIconImageArray["dragon"] = {
        {c,x,c,x,x,c,x,c},
        {c,c,c,x,x,c,c,c},
        {c,x,c,c,c,c,x,c},
        {c,x,x,x,x,x,x,c},
        {x,c,x,x,x,x,c,x},
        {x,x,c,x,x,c,x,x},
        {x,x,c,x,x,c,x,x},
        {x,x,x,c,c,x,x,x},
    }
    Images.typeIconImageArray["flying"] = {
        {x,x,c,c,c,c,c,x},
        {x,c,x,x,x,x,x,c},
        {c,x,x,x,c,c,c,c},
        {c,x,x,c,x,x,x,c},
        {c,x,x,x,x,c,c,x},
        {c,x,c,c,c,x,x,x},
        {c,c,x,x,x,x,x,x},
        {c,x,x,x,x,x,x,x}
    }
end
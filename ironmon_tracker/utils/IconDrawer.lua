IconDrawer = {}
local colorSettings = nil
local colorScheme = nil
function IconDrawer.setColorSettings(newColorSettings)
    colorSettings = newColorSettings
end
function IconDrawer.setColorScheme(newColorScheme)
    colorScheme = newColorScheme
end
IconDrawer.ICON_TYPES =
    MiscUtils.readOnly(
    {
        STANDARD = 0,
        MOVE_TYPE = 1
    }
)
local layoutColors = {
    ["black"] = 0xFF000000,
    ["Main background color"] = 0xFF202020,
    ["Default text color"] = 0xFFFFFFFF,
    ["Positive text color"] = 0xFF00FF00,
    ["Negative text color"] = 0xFFFF0000,
    ["Intermediate text color"] = 0xFFFFFF00,
    ["Move header text color"] = 0xFFFFFFFF,
    ["Top box border color"] = 0xFFAAAAAA,
    ["Top box background color"] = 0xFF505050,
    ["Bottom box border color"] = 0xFFAAAAAA,
    ["Bottom box background color"] = 0xFF222222,
    ["Physical icon color"] = 0xFFFFC631,
    ["Special icon color"] = 0xFFFFFFFF,
    ["Gear icon color"] = 0xFFDBDBDB
}
IconDrawer.ICONS =
    MiscUtils.readOnly(
    {
        GEAR = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 1, 1, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 1, 0},
                {0, 1, 1, 1, 1, 1, 1, 0},
                {1, 1, 1, 0, 0, 1, 1, 1},
                {1, 1, 1, 0, 0, 1, 1, 1},
                {0, 1, 1, 1, 1, 1, 1, 0},
                {0, 1, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 1, 1, 0, 0, 0}
            },
            colorKey = "Gear icon color",
            backgroundColorKey = "Top box background color"
        },
        PHYSICAL = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1, 0, 0, 1, 0, 0, 1},
                {0, 1, 0, 1, 0, 1, 0},
                {0, 0, 1, 1, 1, 0, 0},
                {1, 1, 1, 1, 1, 1, 1},
                {0, 0, 1, 1, 1, 0, 0},
                {0, 1, 0, 1, 0, 1, 0},
                {1, 0, 0, 1, 0, 0, 1}
            },
            colorKey = "Physical icon color",
            backgroundColorKey = "Bottom box background color"
        },
        SPECIAL = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 1, 1, 1, 0, 0},
                {0, 1, 0, 0, 0, 1, 0},
                {1, 0, 0, 1, 0, 0, 1},
                {1, 0, 1, 0, 1, 0, 1},
                {1, 0, 0, 1, 0, 0, 1},
                {0, 1, 0, 0, 0, 1, 0},
                {0, 0, 1, 1, 1, 0, 0}
            },
            colorKey = "Special icon color",
            backgroundColorKey = "Bottom box background color"
        },
        NOTE_TOP = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1},
                {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0},
                {1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 0},
                {1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0},
                {1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0},
                {1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0},
                {1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0},
                {1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0},
                {1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        NOTE_BOTTOM = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1},
                {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0},
                {1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 0},
                {1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0},
                {1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0},
                {1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0},
                {1, 0, 1, 1, 1, 1, 1, 0, 1, 0, 0},
                {1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0},
                {1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0}
            },
            colorKey = "Bottom box border color",
            backgroundColorKey = "Bottom box background color"
        },
        --For the type icons, colorKey is nil because it changes based on the user's color settings.
        FIRE = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 1, 0, 1, 0, 0},
                {0, 1, 0, 1, 0, 1, 1, 0},
                {1, 0, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 1},
                {0, 1, 0, 0, 0, 0, 1, 0},
                {0, 0, 1, 1, 1, 1, 0, 0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        WATER = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 0, 1, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0, 1, 0, 0, 0},
                {0, 0, 1, 1, 1, 0, 0, 0, 0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        GRASS = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 1, 0, 0, 0},
                {0, 1, 0, 0, 0, 1, 0, 0},
                {1, 0, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 0, 1, 0},
                {0, 1, 1, 0, 1, 1, 0, 0},
                {0, 0, 0, 1, 0, 0, 0, 0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        ELECTRIC = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 0, 1, 1, 1, 0, 0},
                {0, 0, 1, 0, 0, 1, 0, 0},
                {0, 1, 0, 0, 1, 1, 1, 1},
                {1, 0, 0, 0, 0, 0, 0, 1},
                {1, 1, 1, 1, 1, 0, 0, 1},
                {0, 0, 0, 1, 0, 0, 1, 0},
                {0, 0, 1, 0, 0, 1, 0, 0},
                {0, 0, 1, 1, 1, 0, 0, 0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        GHOST = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 1, 1, 1, 0, 0, 0},
                {0, 1, 0, 0, 0, 1, 0, 0},
                {1, 0, 1, 0, 1, 0, 1, 0},
                {1, 0, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 0, 1, 0},
                {1, 0, 1, 0, 1, 0, 1, 0},
                {0, 1, 0, 1, 0, 1, 0, 0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        BUG = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 1, 0, 0, 1, 0, 0},
                {1, 0, 0, 1, 1, 0, 0, 1},
                {0, 1, 1, 0, 0, 1, 1, 0},
                {0, 1, 0, 0, 0, 0, 1, 0},
                {1, 1, 0, 0, 0, 0, 1, 1},
                {0, 1, 0, 0, 0, 0, 1, 0},
                {0, 0, 1, 0, 0, 1, 0, 0},
                {0, 1, 0, 1, 1, 0, 1, 0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        POISON = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 1, 1, 0, 0, 0, 0, 0},
                {1, 0, 0, 1, 0, 0, 0, 0},
                {1, 0, 0, 1, 0, 0, 1, 0},
                {0, 1, 1, 0, 0, 1, 0, 1},
                {0, 0, 0, 0, 0, 0, 1, 0},
                {0, 0, 1, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 1, 0, 0, 0},
                {0, 0, 1, 1, 0, 0, 0, 0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        NORMAL = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 1, 1, 1, 1, 0, 0},
                {0, 1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 1, 1, 0, 0, 1},
                {1, 0, 1, 0, 0, 1, 0, 1},
                {1, 0, 1, 0, 0, 1, 0, 1},
                {1, 0, 0, 1, 1, 0, 0, 1},
                {0, 1, 0, 0, 0, 0, 1, 0},
                {0, 0, 1, 1, 1, 1, 0, 0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        DARK = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 1, 1, 0, 0, 1, 1, 0},
                {1, 0, 1, 0, 0, 1, 0, 1},
                {1, 0, 0, 1, 1, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 1},
                {0, 1, 0, 0, 0, 0, 1, 0},
                {0, 0, 1, 1, 1, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        ICE = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 1, 0, 1, 0, 0},
                {0, 0, 1, 0, 1, 0, 0, 0},
                {1, 1, 0, 1, 0, 1, 1, 0},
                {0, 0, 1, 0, 1, 0, 0, 0},
                {0, 1, 0, 1, 0, 1, 0, 0},
                {0, 0, 0, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        PSYCHIC = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 1, 1, 1, 1, 0, 0},
                {0, 1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 1, 1, 0, 0, 1},
                {1, 0, 1, 0, 1, 0, 0, 1},
                {1, 0, 1, 0, 0, 0, 1, 0},
                {1, 0, 0, 1, 1, 1, 0, 0},
                {0, 1, 0, 0, 0, 0, 0, 1},
                {0, 0, 1, 1, 1, 1, 1, 0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        ROCK = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 1, 1, 1, 0, 0, 0},
                {0, 1, 0, 0, 0, 1, 0, 0},
                {0, 1, 0, 0, 0, 1, 1, 0},
                {1, 0, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 0, 1},
                {0, 1, 0, 1, 0, 1, 1, 0},
                {0, 0, 1, 1, 1, 0, 0, 0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        GROUND = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 1, 1, 0, 0, 0},
                {0, 0, 1, 0, 0, 1, 0, 0},
                {0, 0, 1, 0, 1, 1, 0, 0},
                {0, 1, 1, 1, 0, 0, 1, 0},
                {0, 1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 0, 0, 1},
                {1, 1, 1, 1, 1, 1, 1, 1}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        STEEL = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 0, 1, 1, 0, 0},
                {1, 0, 0, 0, 0, 0, 1, 0},
                {1, 0, 1, 1, 1, 0, 1, 0},
                {0, 0, 0, 1, 0, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 1, 0, 0},
                {0, 0, 1, 1, 1, 0, 0, 0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        FIGHTING = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 0, 1, 0, 1, 0, 0},
                {0, 0, 1, 0, 1, 0, 1, 0},
                {0, 1, 1, 0, 1, 0, 1, 0},
                {1, 0, 1, 0, 1, 0, 1, 0},
                {1, 0, 1, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 0, 1, 0},
                {0, 1, 0, 0, 0, 0, 1, 0},
                {0, 0, 1, 1, 1, 1, 0, 0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        DRAGON = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {1, 0, 1, 0, 0, 1, 0, 1},
                {1, 1, 1, 0, 0, 1, 1, 1},
                {1, 0, 1, 1, 1, 1, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 1},
                {0, 1, 0, 0, 0, 0, 1, 0},
                {0, 0, 1, 0, 0, 1, 0, 0},
                {0, 0, 1, 0, 0, 1, 0, 0},
                {0, 0, 0, 1, 1, 0, 0, 0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        FLYING = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 1, 1, 1, 1, 1, 0},
                {0, 1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 1, 1, 1, 1},
                {1, 0, 0, 1, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 1, 1, 0},
                {1, 0, 1, 1, 1, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0, 0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        }
    }
)

function IconDrawer.drawIcon(iconName, x, y)
    if IconDrawer.ICONS[iconName] then
        local icon = IconDrawer.ICONS[iconName]
        local iconType = icon.iconType
        local backgroundColorKey = icon.backgroundColorKey
        local shadowColor = DrawingUtils.calcShadowColor(backgroundColorKey)
        local iconArray = icon.imageArray
        local iconColorKey = icon.colorKey
        for rowIndex = 1, #iconArray, 1 do
            for colIndex = 1, #(iconArray[1]) do
                local offsetX = colIndex - 1
                local offsetY = rowIndex - 1
                local shouldColor = (iconArray[rowIndex][colIndex] == 1)
                if shouldColor then
                    local color
                    if iconType == IconDrawer.ICON_TYPES.MOVE_TYPE then
                        if colorSettings.Color_move_type_icons then
                            color = Graphics.TYPE_COLORS[iconName]
                        else
                            color = layoutColors["Bottom box background color"]
                        end
                    else
                        color = layoutColors[iconColorKey]
                    end
                    if colorSettings.Draw_shadows then
                        gui.drawPixel(x + offsetX + 1, y + offsetY + 1, shadowColor)
                    end
                    gui.drawPixel(x + offsetX, y + offsetY, color)
                end
            end
        end
    end
end

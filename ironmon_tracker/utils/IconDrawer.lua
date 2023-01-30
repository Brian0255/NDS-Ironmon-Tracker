IconDrawer = {}
local settings = nil
function IconDrawer.setSettings(newSettings)
    settings = newSettings
end
IconDrawer.ICON_TYPES =
    MiscUtils.readOnly(
    {
        STANDARD = 0,
        MOVE_TYPE = 1,
        STANDARD_NO_SHADOW = 2
    }
)
IconDrawer.ICONS =
    MiscUtils.readOnly(
    {
        GEAR = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,0,1,1,0,0,0},
                {0,1,1,1,1,1,1,0},
                {0,1,1,1,1,1,1,0},
                {1,1,1,0,0,1,1,1},
                {1,1,1,0,0,1,1,1},
                {0,1,1,1,1,1,1,0},
                {0,1,1,1,1,1,1,0},
                {0,0,0,1,1,0,0,0}
            },
            colorKey = "Gear icon color",
            backgroundColorKey = "Top box background color"
        },
        PHYSICAL = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1,0,0,1,0,0,1},
                {0,1,0,1,0,1,0},
                {0,0,1,1,1,0,0},
                {1,1,1,1,1,1,1},
                {0,0,1,1,1,0,0},
                {0,1,0,1,0,1,0},
                {1,0,0,1,0,0,1}
            },
            colorKey = "Physical icon color",
            backgroundColorKey = "Bottom box background color"
        },
        SPECIAL = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,1,1,1,0,0},
                {0,1,0,0,0,1,0},
                {1,0,0,1,0,0,1},
                {1,0,1,0,1,0,1},
                {1,0,0,1,0,0,1},
                {0,1,0,0,0,1,0},
                {0,0,1,1,1,0,0}
            },
            colorKey = "Special icon color",
            backgroundColorKey = "Bottom box background color"
        },
        NOTE_TOP = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,0,0,0,0,0,0,0,1,1},
                {0,0,0,0,0,0,0,0,1,0,1},
                {1,1,1,1,1,1,1,1,1,1,0},
                {1,0,0,0,0,0,0,1,1,0,0},
                {1,0,1,1,1,0,1,0,1,0,0},
                {1,0,0,0,0,0,0,0,1,0,0},
                {1,0,1,1,1,1,1,0,1,0,0},
                {1,0,0,0,0,0,0,0,1,0,0},
                {1,0,1,1,1,1,1,0,1,0,0},
                {1,0,0,0,0,0,0,0,1,0,0},
                {1,1,1,1,1,1,1,1,1,0,0}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        NOTE_BOTTOM = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,0,0,0,0,0,0,0,1,1},
                {0,0,0,0,0,0,0,0,1,0,1},
                {1,1,1,1,1,1,1,1,1,1,0},
                {1,0,0,0,0,0,0,1,1,0,0},
                {1,0,1,1,1,0,1,0,1,0,0},
                {1,0,0,0,0,0,0,0,1,0,0},
                {1,0,1,1,1,1,1,0,1,0,0},
                {1,0,0,0,0,0,0,0,1,0,0},
                {1,0,1,1,1,1,1,0,1,0,0},
                {1,0,0,0,0,0,0,0,1,0,0},
                {1,1,1,1,1,1,1,1,1,0,0}
            },
            colorKey = "Bottom box border color",
            backgroundColorKey = "Bottom box background color"
        },
        --For the type icons,colorKey is nil because it changes based on the user's color settings.
        FIRE = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0,0,0,1,0,0,0,0},
                {0,0,1,1,0,1,0,0},
                {0,1,0,1,0,1,1,0},
                {1,0,0,0,1,0,0,1},
                {1,0,0,0,0,0,0,1},
                {1,0,0,0,0,0,0,1},
                {0,1,0,0,0,0,1,0},
                {0,0,1,1,1,1,0,0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        WATER = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0,0,0,1,0,0,0,0,0},
                {0,0,1,0,1,0,0,0,0},
                {0,0,1,0,1,0,0,0,0},
                {0,1,0,0,0,1,0,0,0},
                {0,1,0,0,0,1,0,0,0},
                {0,1,0,0,0,1,0,0,0},
                {0,1,0,0,0,1,0,0,0},
                {0,0,1,1,1,0,0,0,0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        GRASS = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0,0,0,1,0,0,0,0},
                {0,0,1,0,1,0,0,0},
                {0,1,0,0,0,1,0,0},
                {1,0,0,0,0,0,1,0},
                {1,0,0,0,0,0,1,0},
                {1,0,0,0,0,0,1,0},
                {0,1,1,0,1,1,0,0},
                {0,0,0,1,0,0,0,0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        ELECTRIC = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0,0,0,1,1,1,0,0},
                {0,0,1,0,0,1,0,0},
                {0,1,0,0,1,1,1,1},
                {1,0,0,0,0,0,0,1},
                {1,1,1,1,1,0,0,1},
                {0,0,0,1,0,0,1,0},
                {0,0,1,0,0,1,0,0},
                {0,0,1,1,1,0,0,0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        GHOST = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0,0,1,1,1,0,0,0},
                {0,1,0,0,0,1,0,0},
                {1,0,1,0,1,0,1,0},
                {1,0,0,0,0,0,1,0},
                {1,0,0,0,0,0,1,0},
                {1,0,0,0,0,0,1,0},
                {1,0,1,0,1,0,1,0},
                {0,1,0,1,0,1,0,0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        BUG = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0,0,1,0,0,1,0,0},
                {1,0,0,1,1,0,0,1},
                {0,1,1,0,0,1,1,0},
                {0,1,0,0,0,0,1,0},
                {1,1,0,0,0,0,1,1},
                {0,1,0,0,0,0,1,0},
                {0,0,1,0,0,1,0,0},
                {0,1,0,1,1,0,1,0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        POISON = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0,1,1,0,0,0,0,0},
                {1,0,0,1,0,0,0,0},
                {1,0,0,1,0,0,1,0},
                {0,1,1,0,0,1,0,1},
                {0,0,0,0,0,0,1,0},
                {0,0,1,1,0,0,0,0},
                {0,1,0,0,1,0,0,0},
                {0,0,1,1,0,0,0,0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        NORMAL = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0,0,1,1,1,1,0,0},
                {0,1,0,0,0,0,1,0},
                {1,0,0,1,1,0,0,1},
                {1,0,1,0,0,1,0,1},
                {1,0,1,0,0,1,0,1},
                {1,0,0,1,1,0,0,1},
                {0,1,0,0,0,0,1,0},
                {0,0,1,1,1,1,0,0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        DARK = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0,1,1,0,0,1,1,0},
                {1,0,1,0,0,1,0,1},
                {1,0,0,1,1,0,0,1},
                {1,0,0,0,0,0,0,1},
                {1,0,0,0,0,0,0,1},
                {0,1,0,0,0,0,1,0},
                {0,0,1,1,1,1,0,0},
                {0,0,0,0,0,0,0,0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        ICE = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0,0,0,1,0,0,0,0},
                {0,1,0,1,0,1,0,0},
                {0,0,1,0,1,0,0,0},
                {1,1,0,1,0,1,1,0},
                {0,0,1,0,1,0,0,0},
                {0,1,0,1,0,1,0,0},
                {0,0,0,1,0,0,0,0},
                {0,0,0,0,0,0,0,0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        PSYCHIC = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0,0,0,0,0,0,0,0},
                {0,0,1,1,1,1,0,0},
                {0,1,0,1,1,0,1,0},
                {1,0,1,0,0,1,0,1},
                {1,0,1,0,0,1,0,1},
                {0,1,0,1,1,0,1,0},
                {0,0,1,1,1,1,0,0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        ROCK = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0,0,1,1,1,0,0,0},
                {0,1,0,0,0,1,0,0},
                {0,1,0,0,0,1,1,0},
                {1,0,0,0,1,0,0,1},
                {1,0,0,1,0,0,0,1},
                {1,0,0,1,0,0,0,1},
                {0,1,0,1,0,1,1,0},
                {0,0,1,1,1,0,0,0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        GROUND = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0,0,0,0,0,0,0,0},
                {0,0,0,1,1,0,0,0},
                {0,0,1,0,0,1,0,0},
                {0,0,1,0,1,1,0,0},
                {0,1,1,1,0,0,1,0},
                {0,1,0,0,0,0,1,0},
                {1,0,0,0,0,0,0,1},
                {1,1,1,1,1,1,1,1}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        STEEL = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0,0,0,0,0,0,0,0},
                {0,1,1,0,1,1,0,0},
                {1,0,0,0,0,0,1,0},
                {1,0,1,1,1,0,1,0},
                {0,0,0,1,0,0,0,0},
                {0,0,0,1,0,0,0,0},
                {0,1,0,0,0,1,0,0},
                {0,0,1,1,1,0,0,0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        FIGHTING_2 = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0,0,0,0,0,0,0,0},
                {0,0,0,1,0,1,0,0},
                {0,0,1,0,1,0,1,0},
                {0,1,1,0,1,0,1,0},
                {1,0,1,0,1,0,1,0},
                {1,0,1,0,0,0,1,0},
                {1,0,0,0,0,0,1,0},
                {0,1,0,0,0,0,1,0},
                {0,0,1,1,1,1,0,0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        FIGHTING = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0,1,1,1,1,1,0},
                {1,0,1,0,1,0,1},
                {1,0,1,0,1,0,1},
                {1,0,1,0,1,0,1},
                {0,1,1,1,1,1,1},
                {0,0,0,1,0,0,1},
                {0,0,0,0,1,1,0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        DRAGON = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {1,0,1,0,0,1,0,1},
                {1,1,1,0,0,1,1,1},
                {1,0,1,1,1,1,0,1},
                {1,0,0,0,0,0,0,1},
                {0,1,0,0,0,0,1,0},
                {0,0,1,0,0,1,0,0},
                {0,0,1,0,0,1,0,0},
                {0,0,0,1,1,0,0,0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        FLYING = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0,0,1,1,1,1,1,0},
                {0,1,0,0,0,0,0,1},
                {1,0,0,0,1,1,1,1},
                {1,0,0,1,0,0,0,1},
                {1,0,0,0,0,1,1,0},
                {1,0,1,1,1,0,0,0},
                {1,1,0,0,0,0,0,0},
                {1,0,0,0,0,0,0,0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        SPARKLES = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                {0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0},
                {0,0,0,0,1,0,0,1,0,1,0,0,1,0,0,0},
                {0,0,0,1,0,1,0,0,1,0,0,0,0,0,0,0},
                {0,0,1,0,0,0,1,0,0,0,0,1,0,0,0,0},
                {0,1,0,0,0,0,0,1,0,0,0,1,0,0,0,0},
                {0,0,1,0,0,0,1,0,0,0,1,0,1,0,0,0},
                {0,0,0,1,0,1,0,0,1,1,0,0,0,1,1,0},
                {0,0,0,0,1,0,0,0,0,0,1,0,1,0,0,0},
                {0,1,0,0,1,0,0,0,0,0,0,1,0,0,0,0},
                {0,0,0,0,1,0,0,1,0,0,0,1,0,0,0,0},
                {0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0},
                {0,0,0,0,0,1,1,0,1,1,0,0,0,1,0,0},
                {0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        SWORD = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0},
                {0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0},
                {0,0,0,0,0,0,0,0,0,1,0,0,0,1,0,0},
                {0,0,0,0,0,0,0,0,1,0,0,0,1,0,0,0},
                {0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,0},
                {0,0,1,0,1,0,1,0,0,0,1,0,0,0,0,0},
                {0,0,1,0,1,1,0,0,0,1,0,0,0,0,0,0},
                {0,0,1,0,0,0,0,0,1,0,0,0,0,0,0,0},
                {0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0},
                {0,0,0,1,0,0,0,1,1,0,0,0,0,0,0,0},
                {0,0,1,0,1,1,0,0,0,1,0,0,0,0,0,0},
                {0,1,0,1,0,0,1,1,1,0,0,0,0,0,0,0},
                {0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        CONTROLLER = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0},
                {0,0,0,1,1,1,1,1,1,1,1,1,1,1,0,0},
                {0,0,1,0,0,0,0,0,0,0,0,0,0,0,1,0},
                {0,1,0,0,1,0,0,0,0,0,0,0,1,0,0,1},
                {0,1,0,1,1,1,0,1,0,1,0,1,0,1,0,1},
                {0,1,0,0,1,0,0,0,0,0,0,0,1,0,0,1},
                {0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
                {0,0,1,0,0,0,1,1,1,1,1,0,0,0,1,0},
                {0,0,0,1,1,1,0,0,0,0,0,1,1,1,0,0}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        PENCIL = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0},
                {0,0,0,0,0,0,0,0,0,0,1,0,0,1,0,0},
                {0,0,0,0,0,0,0,0,0,1,1,1,0,0,1,0},
                {0,0,0,0,0,0,0,0,1,0,0,1,1,0,1,0},
                {0,0,0,0,0,0,0,1,0,0,1,0,1,1,0,0},
                {0,0,0,0,0,0,1,0,0,1,0,0,1,0,0,0},
                {0,0,0,0,0,1,0,0,1,0,0,1,0,0,0,0},
                {0,0,0,0,1,0,0,1,0,0,1,0,0,0,0,0},
                {0,0,0,1,0,0,1,0,0,1,0,0,0,0,0,0},
                {0,0,1,1,0,1,0,0,1,0,0,0,0,0,0,0},
                {0,1,0,1,1,0,0,1,0,0,0,0,0,0,0,0},
                {0,1,0,0,1,1,1,0,0,0,0,0,0,0,0,0},
                {0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0},
                {0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        PAINTBRUSH = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0},
                {1,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0},
                {1,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0},
                {0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,0},
                {0,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0},
                {0,0,0,1,0,0,0,1,0,0,0,0,0,0,0,0},
                {0,0,0,0,1,0,0,0,1,0,0,0,0,0,0,0},
                {0,0,0,0,0,1,0,0,1,1,1,1,0,0,0,0},
                {0,0,0,0,0,0,1,1,0,1,0,0,1,0,0,0},
                {0,0,0,0,0,0,0,1,1,0,0,0,0,1,0,0},
                {0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0},
                {0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,0},
                {0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,1},
                {0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,1},
                {0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,0}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        BADGES = {
            HGSS = {
                iconType = IconDrawer.ICON_TYPES.STANDARD,
                imageArray = {
                    {0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0},
                    {0,0,0,0,0,1,1,0,0,1,1,0,0,0,0,0},
                    {0,0,0,1,1,0,0,0,0,0,0,1,1,0,0,0},
                    {0,1,1,0,0,0,0,0,0,0,0,0,0,1,1,0},
                    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
                    {1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
                    {1,1,0,0,0,0,0,0,0,0,0,0,0,0,1,1},
                    {1,0,1,1,0,0,0,1,1,0,0,0,1,1,0,1},
                    {1,0,0,0,1,1,1,0,0,1,1,1,0,0,0,1},
                    {1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,1},
                    {1,0,1,0,0,0,1,0,0,1,0,0,0,1,0,1},
                    {1,0,1,0,1,0,1,0,0,1,0,1,0,1,0,1},
                    {1,0,1,0,1,0,1,0,0,1,0,1,0,1,0,1},
                    {0,1,1,0,1,0,1,0,0,1,0,1,0,1,1,0},
                    {0,0,0,1,1,0,1,0,0,1,0,1,1,0,0,0},
                    {0,0,0,0,0,1,1,0,0,1,1,0,0,0,0,0}
                },
                colorKey = "Top box border color",
                backgroundColorKey = "Top box background color"
            },
            DPPT = {
                iconType = IconDrawer.ICON_TYPES.STANDARD,
                imageArray = {
                    {0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0},
                    {0,0,0,0,1,1,0,0,0,0,1,1,0,0,0,0},
                    {0,0,0,1,0,0,1,1,1,1,0,0,1,0,0,0},
                    {0,0,1,0,1,1,1,1,1,1,1,1,0,1,0,0},
                    {0,1,0,1,1,1,1,1,1,1,1,1,1,0,1,0},
                    {0,1,0,1,1,1,0,0,0,0,1,1,1,0,1,0},
                    {1,0,1,1,1,0,1,1,1,1,0,1,1,1,0,1},
                    {1,0,1,1,0,1,1,1,1,1,1,0,1,1,0,1},
                    {1,0,0,0,0,1,1,1,1,1,1,0,0,0,0,1},
                    {1,0,1,1,0,1,1,1,1,1,1,0,1,1,0,1},
                    {1,0,1,1,1,0,1,1,1,1,0,1,1,1,0,1},
                    {0,1,0,1,1,1,0,0,0,0,1,1,1,0,1,0},
                    {0,1,0,1,1,1,1,1,1,1,1,1,1,0,1,0},
                    {0,0,1,0,1,1,1,1,1,1,1,1,0,1,0,0},
                    {0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0},
                    {0,0,0,0,1,1,1,1,1,1,1,1,0,0,0,0}
                },
                colorKey = "Top box border color",
                backgroundColorKey = "Top box background color"
            },
            BW = {
                iconType = IconDrawer.ICON_TYPES.STANDARD,
                imageArray = {
                    {0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0},
                    {0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,1},
                    {0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,1},
                    {0,0,0,0,0,0,0,0,1,0,0,1,1,0,1,0},
                    {0,0,0,0,0,0,0,0,1,0,1,1,1,0,1,0},
                    {0,0,0,0,0,0,1,1,0,1,1,1,0,1,0,0},
                    {0,0,0,0,0,1,0,0,1,0,1,0,0,1,0,0},
                    {0,0,0,0,0,1,0,1,1,1,0,1,1,0,0,0},
                    {0,0,0,1,1,0,1,1,1,0,1,0,0,0,0,0},
                    {0,0,1,0,0,1,0,1,0,0,1,0,0,0,0,0},
                    {0,0,1,0,1,1,1,0,1,1,0,0,0,0,0,0},
                    {0,1,0,1,1,1,0,1,0,0,0,0,0,0,0,0},
                    {0,1,0,1,1,0,0,1,0,0,0,0,0,0,0,0},
                    {1,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0},
                    {1,0,0,1,1,0,0,0,0,0,0,0,0,0,0,0},
                    {0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0}
                },
                colorKey = "Top box border color",
                backgroundColorKey = "Top box background color"
            },
            BW2 = {
                iconType = IconDrawer.ICON_TYPES.STANDARD,
                imageArray = {
                    {0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0},
                    {0,0,0,0,0,0,0,0,0,0,0,1,0,0,1,0},
                    {0,0,0,0,0,0,0,0,0,0,1,0,1,1,0,1},
                    {0,0,0,0,0,0,0,0,0,1,0,1,1,1,0,1},
                    {0,0,0,0,0,0,0,0,1,0,1,0,1,0,1,0},
                    {0,0,0,0,0,0,0,1,0,1,1,1,0,1,0,0},
                    {0,0,0,0,0,0,1,0,1,1,1,0,1,0,0,0},
                    {0,0,0,0,0,1,0,1,1,1,0,1,0,0,0,0},
                    {0,0,0,0,1,0,1,1,1,0,1,0,0,0,0,0},
                    {0,0,0,1,0,1,1,1,0,1,0,0,0,0,0,0},
                    {0,0,1,0,1,1,1,0,1,0,0,0,0,0,0,0},
                    {0,1,0,1,0,1,0,1,0,0,0,0,0,0,0,0},
                    {1,0,1,1,1,0,1,0,0,0,0,0,0,0,0,0},
                    {1,0,1,1,0,1,0,0,0,0,0,0,0,0,0,0},
                    {0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0},
                    {0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0}
                },
                colorKey = "Top box border color",
                backgroundColorKey = "Top box background color"
            }
        },
        HP_HEALS_ICON = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
               {0,0,1,1,1,1,0,0},
               {0,1,0,0,0,0,1,0},
               {1,0,1,0,0,0,1,0},
               {1,0,1,0,0,1,1,0},
               {0,1,0,0,1,0,1,0},
               {0,1,0,0,1,0,1,0},
               {1,1,0,0,1,0,0,1},
               {1,0,1,1,0,0,0,1},
               {1,0,0,0,0,0,0,1},
               {0,1,1,0,0,0,1,0},
               {0,0,0,1,1,1,0,0}
            },
            colorKey = "Positive text color",
            backgroundColorKey = "Top box background color"
        },
        STATUS_HEALS_ICON = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
              {0,0,0,0,1,1,1,0},
              {0,0,1,1,0,0,0,1},
              {1,1,0,0,0,0,0,1},
              {1,0,0,0,1,0,1,0},
              {1,0,0,1,0,1,0,1},
              {1,0,0,1,0,0,0,1},
              {1,1,1,0,0,0,0,1},
              {1,0,0,0,0,0,0,1},
              {1,0,0,0,0,0,0,1},
              {1,0,0,0,0,0,0,1},
              {0,1,1,1,1,1,1,0}
            },
            colorKey = "Intermediate text color",
            backgroundColorKey = "Top box background color"
        },
        BACKSPACE = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,1,0,0,0,0,0,0},
                {0,1,0,0,0,0,0,0,0},
                {1,1,1,1,1,1,1,1,1},
                {0,1,0,0,0,0,0,0,0},
                {0,0,1,0,0,0,0,0,0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        LIGHTNING_BOLT = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,1,1,1,1,1,1,1,0},
                {0,0,0,0,0,0,1,0,0,0,0,0,0,1,0},
                {0,0,0,0,0,0,1,0,0,0,0,0,1,0,0},
                {0,0,0,0,0,1,0,0,0,0,0,1,0,0,0},
                {0,0,0,0,0,1,0,0,0,0,1,1,1,1,0},
                {0,0,0,0,1,0,0,0,0,0,0,0,0,1,0},
                {0,0,0,0,1,1,1,1,0,0,0,0,1,0,0},
                {0,0,0,0,0,0,0,1,0,0,0,1,0,0,0},
                {0,0,0,0,0,0,1,0,0,0,1,0,0,0,0},
                {0,0,0,0,0,0,1,0,0,1,0,0,0,0,0},
                {0,0,0,0,0,1,0,0,1,0,0,0,0,0,0},
                {0,0,0,0,0,1,0,1,0,0,0,0,0,0,0},
                {0,0,0,0,1,0,1,0,0,0,0,0,0,0,0},
                {0,0,0,0,1,1,0,0,0,0,0,0,0,0,0}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        UPDATER_ICON = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,0},
                {0,0,0,0,0,1,0,0,0,0,1,1,0,0,0,0},
                {0,0,0,0,1,0,0,0,0,0,0,0,1,0,0,0},
                {0,0,0,1,1,0,0,0,0,0,0,0,0,1,0,0},
                {0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0},
                {0,1,0,0,0,0,0,0,0,0,0,0,0,0,1,0},
                {0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1},
                {0,1,0,0,0,0,0,0,1,0,0,0,0,0,0,1},
                {0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0},
                {0,0,0,1,1,1,1,0,1,0,1,1,1,1,0,0},
                {0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,1,0,1,0,1,0,0,0,0,0},
                {0,0,0,0,0,0,0,1,1,1,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        SURVIVAL_HEALS = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,0,1,1,1,1,1,0,0,0},
                {0,0,0,1,0,0,0,1,0,0,0},
                {1,1,1,1,1,1,1,1,1,1,1},
                {1,0,0,0,0,0,0,0,0,0,1},
                {1,0,0,0,0,0,0,0,0,0,1},
                {1,0,0,0,0,1,0,0,0,0,1},
                {1,0,0,0,1,1,1,0,0,0,1},
                {1,0,0,0,0,1,0,0,0,0,1},
                {1,0,0,0,0,0,0,0,0,0,1},
                {1,0,0,0,0,0,0,0,0,0,1},
                {1,1,1,1,1,1,1,1,1,1,1}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        UP_ARROW = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,1,0,0},
                {0,1,0,1,0},
                {1,0,0,0,1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        DOWN_ARROW = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1,0,0,0,1},
                {0,1,0,1,0},
                {0,0,1,0,0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        LEFT_ARROW = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,1},
                {0,1,0},
                {1,0,0},
                {0,1,0},
                {0,0,1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        RIGHT_ARROW = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1,0,0},
                {0,1,0},
                {0,0,1},
                {0,1,0},
                {1,0,0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        LOCKED = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,0,0,0,0,0},
                {0,0,1,1,0,0,0},
                {0,1,0,0,1,0,0},
                {0,1,0,0,1,0,0},
                {1,1,1,1,1,1,0},
                {1,1,1,1,1,1,0},
                {1,1,1,1,1,1,0},
                {1,1,1,1,1,1,0},
                {1,1,1,1,1,1,0},
                {1,1,1,1,1,1,0},
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        UNLOCKED = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,0,0,0,0,0},
                {0,0,1,1,0,0,0},
                {0,1,0,0,1,0,0},
                {0,0,0,0,1,0,0},
                {1,1,1,1,1,1,0},
                {1,0,0,0,0,1,0},
                {1,0,0,0,0,1,0},
                {1,0,0,0,0,1,0},
                {1,0,0,0,0,1,0},
                {1,1,1,1,1,1,0},
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        BOOKMARK_EMPTY = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,1,1,1,1,1,1,0},
                {1,0,0,0,0,0,0,1},
                {1,0,0,0,0,0,0,1},
                {1,0,0,0,0,0,0,1},
                {1,0,0,0,0,0,0,1},
                {1,0,0,0,0,0,0,1},
                {1,0,0,1,1,0,0,1},
                {1,0,1,0,0,1,0,1},
                {1,1,0,0,0,0,1,1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        BOOKMARK_FILLED = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,1,1,1,1,1,1,0},
                {1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1},
                {1,1,1,0,0,1,1,1},
                {1,1,0,0,0,0,1,1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        BOOKMARK_EMPTY_LARGE = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,1,1,1,1,1,1,1,1,1,1,1,0},
                {1,0,0,0,0,0,0,0,0,0,0,0,1},
                {1,0,0,0,0,0,0,0,0,0,0,0,1},
                {1,0,0,0,0,0,0,0,0,0,0,0,1},
                {1,0,0,0,0,0,0,0,0,0,0,0,1},
                {1,0,0,0,0,0,0,0,0,0,0,0,1},
                {1,0,0,0,0,0,0,0,0,0,0,0,1},
                {1,0,0,0,0,0,0,0,0,0,0,0,1},
                {1,0,0,0,0,0,0,0,0,0,0,0,1},
                {1,0,0,0,0,0,1,0,0,0,0,0,1},
                {1,0,0,0,0,1,0,1,0,0,0,0,1},
                {1,0,0,0,1,0,0,0,1,0,0,0,1},
                {1,0,0,1,0,0,0,0,0,1,0,0,1},
                {1,0,1,0,0,0,0,0,0,0,1,0,1},
                {1,1,0,0,0,0,0,0,0,0,0,1,1}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        BOOKMARK_FILLED_LARGE = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,1,1,1,1,1,1,1,1,1,1,1,0},
                {1,1,1,1,1,1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1,1,1,1,1,1,1},
                {1,1,1,1,1,1,0,1,1,1,1,1,1},
                {1,1,1,1,1,0,0,0,1,1,1,1,1},
                {1,1,1,1,0,0,0,0,0,1,1,1,1},
                {1,1,1,0,0,0,0,0,0,0,1,1,1},
                {1,1,0,0,0,0,0,0,0,0,0,1,1}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        POKEBALL = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,1,1,1,1,0,0,0,0,0},
                {0,0,0,0,1,1,0,0,0,0,1,1,0,0,0},
                {0,0,0,1,0,0,0,0,0,0,0,0,1,0,0},
                {0,0,1,0,0,0,0,0,0,0,0,0,1,1,0},
                {0,0,1,0,0,0,0,0,0,0,0,0,0,1,0},
                {0,1,0,0,0,0,0,0,0,0,0,0,0,0,1},
                {0,1,1,1,0,0,0,0,1,1,1,0,0,0,1},
                {0,1,1,1,1,0,0,1,0,0,0,1,0,0,1},
                {0,1,0,0,1,1,1,1,0,0,0,1,1,1,1},
                {0,0,1,0,0,0,1,1,0,0,0,1,0,1,0},
                {0,0,1,0,0,0,0,0,1,1,1,0,0,1,0},
                {0,0,0,1,0,0,0,0,0,0,0,0,1,0,0},
                {0,0,0,0,1,1,0,0,0,0,1,1,0,0,0},
                {0,0,0,0,0,0,1,1,1,1,0,0,0,0,0}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        LEFT_ARROW_LARGE = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,0,0,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,0,0,0,0},
                {0,0,0,0,1,0,0,0,0,0,0},
                {0,0,0,1,0,0,0,0,0,0,0},
                {0,0,1,0,0,0,0,0,0,0,0},
                {0,1,1,1,1,1,1,1,1,1,0},
                {0,0,1,0,0,0,0,0,0,0,0},
                {0,0,0,1,0,0,0,0,0,0,0},
                {0,0,0,0,1,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,0,0,0,0},
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        RIGHT_ARROW_LARGE = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,0,0,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,1,0,0,0,0},
                {0,0,0,0,0,0,0,1,0,0,0},
                {0,0,0,0,0,0,0,0,1,0,0},
                {0,1,1,1,1,1,1,1,1,1,0},
                {0,0,0,0,0,0,0,0,1,0,0},
                {0,0,0,0,0,0,0,1,0,0,0},
                {0,0,0,0,0,0,1,0,0,0,0},
                {0,0,0,0,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,0,0,0,0},
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        LOCATION_ICON_SMALL = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,1,1,1,0},
                {0,1,0,0,0,1},
                {0,1,0,1,0,1},
                {0,1,0,0,0,1},
                {0,0,1,0,1,0},
                {0,0,1,0,1,0},
                {0,0,0,1,0,0},
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        LOCATION_ICON_SMALL_FILLED = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,1,1,1,0},
                {0,1,1,1,1,1},
                {0,1,1,0,1,1},
                {0,1,1,1,1,1},
                {0,1,1,1,1,1},
                {0,0,1,1,1,0},
                {0,0,1,1,1,0},
                {0,0,0,1,0,0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        LOCATION_ICON = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,1,1,1,1,1,0},
                {1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1},
                {1,1,1,0,1,1,1},
                {1,1,1,1,1,1,1},
                {1,1,1,1,1,1,1},
                {0,1,1,1,1,1,0},
                {0,1,1,1,1,1,0},
                {0,0,1,1,1,0,0},
                {0,0,1,1,1,0,0},
                {0,0,0,1,0,0,0}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        SMALL_DOT = {
            iconType = IconDrawer.ICON_TYPES.STANDARD_NO_SHADOW,
            imageArray = {
                {1,1},
                {1,1}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        LARGE_DOT = {
            iconType = IconDrawer.ICON_TYPES.STANDARD_NO_SHADOW,
            imageArray = {
                {0,1,1,0},
                {1,1,1,1},
                {1,1,1,1},
                {0,1,1,0}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        LONG_LEFT_ARROW = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,0,0,0,0,0,0,0,0,0,0,0},
                {0,0,0,0,1,0,0,0,0,0,0,0,0},
                {0,0,0,1,0,0,0,0,0,0,0,0,0},
                {0,0,1,0,0,0,0,0,0,0,0,0,0},
                {0,1,1,1,1,1,1,1,1,1,1,1,1},
                {0,0,1,0,0,0,0,0,0,0,0,0,0},
                {0,0,0,1,0,0,0,0,0,0,0,0,0},
                {0,0,0,0,1,0,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,0,0,0,0,0,0},
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        BIG_X = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,0,0,0,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,0,0,0,0,0},
                {0,0,0,0,1,0,0,0,0,0,1,0},
                {0,0,0,0,0,1,0,0,0,1,0,0},
                {0,0,0,0,0,0,1,0,1,0,0,0},
                {0,0,0,0,0,0,0,1,0,0,0,0},
                {0,0,0,0,0,0,1,0,1,0,0,0},
                {0,0,0,0,0,1,0,0,0,1,0,0},
                {0,0,0,0,1,0,0,0,0,0,1,0},
                {0,0,0,0,0,0,0,0,0,0,0,0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        TM_ICON = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,0,0,2,2,2,2,0,0,0,0},
                {0,0,2,2,1,1,1,1,2,2,0,0},
                {0,2,1,1,1,1,1,1,1,1,2,0},
                {0,2,1,1,1,1,1,1,1,1,2,0},
                {2,1,1,1,1,2,2,1,1,1,1,2},
                {2,1,1,1,2,0,0,2,1,1,1,2},
                {2,1,1,1,2,0,0,2,1,1,1,2},
                {2,1,1,1,1,2,2,1,1,1,1,2},
                {0,2,1,1,1,1,1,1,1,1,2,0},
                {0,2,1,1,1,1,1,1,1,1,2,0},
                {0,0,2,2,1,1,1,1,2,2,0,0},
                {0,0,0,0,2,2,2,2,0,0,0,0}
            },
            colorKey = {"Top box border color", "Top box text color"},
            backgroundColorKey = "Top box background color"
        },
        PAST_RUN_ICON = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,0,0,0,1,1,1,1,1,0,0,0,0,0},
                {0,0,0,1,1,0,0,0,0,0,1,1,0,0,0},
                {0,0,1,0,0,0,0,0,0,0,0,0,1,0,0},
                {0,0,1,0,0,0,0,0,0,0,0,0,1,0,0},
                {0,1,0,0,0,0,0,0,0,0,0,0,0,1,0},
                {0,1,0,1,1,0,0,1,0,1,1,0,0,1,0},
                {0,1,0,1,0,1,0,1,0,1,0,1,0,1,0},
                {0,1,0,1,1,0,0,1,0,1,1,0,0,1,0},
                {0,1,0,1,0,1,0,1,0,1,0,0,0,1,0},
                {0,1,0,1,0,1,0,1,0,1,0,0,0,1,0},
                {0,1,0,0,0,0,0,0,0,0,0,0,0,1,0},
                {0,1,0,0,0,0,0,0,0,0,0,0,0,1,0},
                {1,1,0,0,0,0,0,0,0,0,0,0,0,1,1},
                {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
                {1,0,0,0,0,0,0,0,0,0,0,0,0,0,1},
                {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        STATISTICS_ICON = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},
                {0,1,1,1,1,0,0,0,0,0,0,0,0,0,0,0},
                {0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0},
                {0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0},
                {0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0},
                {0,1,0,0,1,0,0,0,0,0,0,1,1,1,1,0},
                {0,1,0,0,1,0,0,0,0,0,0,1,0,0,1,0},
                {0,1,0,0,1,0,0,0,0,0,0,1,0,0,1,0},
                {0,1,0,0,1,0,1,1,1,1,0,1,0,0,1,0},
                {0,1,0,0,1,0,1,0,0,1,0,1,0,0,1,0},
                {0,1,0,0,1,0,1,0,0,1,0,1,0,0,1,0},
                {0,1,0,0,1,0,1,0,0,1,0,1,0,0,1,0},
                {0,1,0,0,1,0,1,0,0,1,0,1,0,0,1,0},
                {1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1},
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
       TRACKED_INFO_ICON = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,1,1,1,1,1,1,1,1,1},
                {0,1,1,0,0,0,0,0,0,0,1},
                {1,1,1,0,0,0,0,0,0,0,1},
                {1,0,0,0,0,0,0,0,0,0,1},
                {1,0,1,1,1,1,1,1,1,0,1},
                {1,0,0,0,0,0,0,0,0,0,1},
                {1,0,0,0,0,0,0,0,0,0,1},
                {1,0,1,1,1,1,1,1,1,0,1},
                {1,0,0,0,0,0,0,0,0,0,1},
                {1,0,0,0,0,0,0,0,0,0,1},
                {1,0,1,1,1,1,1,1,1,0,1},
                {1,0,0,0,0,0,0,0,0,0,1},
                {1,0,0,0,0,0,0,0,0,0,1},
                {1,1,1,1,1,1,1,1,1,1,1}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        OPEN_LOG_ICON = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0,0,0,0,1,1,1,1,0,0,0,0,0,0,0,0},
                {0,0,1,1,0,0,0,0,1,1,0,0,0,0,0,0},
                {0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0},
                {0,1,0,0,0,0,1,1,0,0,1,0,0,0,0,0},
                {1,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0},
                {1,0,0,0,0,0,0,0,1,0,0,1,0,0,0,0},
                {1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0},
                {1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0},
                {0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0},
                {0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0},
                {0,0,1,1,0,0,0,0,1,1,1,1,0,0,0,0},
                {0,0,0,0,1,1,1,1,0,0,1,1,1,0,0,0},
                {0,0,0,0,0,0,0,0,0,0,0,1,1,1,0,0},
                {0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,0},
                {0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1},
                {0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        F1 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1},
                {1},
                {1},
                {1},
                {1},
                {1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        F2 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1},
                {0},
                {1},
                {0},
                {0},
                {0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        F3 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1},
                {0},
                {1},
                {0},
                {0},
                {0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        F4 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1},
                {0},
                {0},
                {0},
                {0},
                {0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        R1 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1},
                {1},
                {1},
                {1},
                {1},
                {1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        R2 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1},
                {0},
                {0},
                {1},
                {0},
                {0},
                {0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        R3 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1},
                {0},
                {0},
                {1},
                {0},
                {0},
                {0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        R4 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1},
                {0},
                {0},
                {1},
                {1},
                {0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        R5 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0},
                {1},
                {1},
                {0},
                {0},
                {1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        I = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1},
                {1},
                {1},
                {1},
                {1},
                {1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        E1 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1},
                {1},
                {1},
                {1},
                {1},
                {1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        E2 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1},
                {0},
                {1},
                {0},
                {0},
                {1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        E3 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1},
                {0},
                {1},
                {0},
                {0},
                {1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        E4 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1},
                {0},
                {0},
                {0},
                {0},
                {1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        E5 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1},
                {0},
                {0},
                {0},
                {0},
                {1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        N1 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1},
                {1},
                {1},
                {1},
                {1},
                {1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        N2 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0},
                {1},
                {0},
                {0},
                {0},
                {0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        N3 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0},
                {0},
                {1},
                {1},
                {0},
                {0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        N4 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0},
                {0},
                {0},
                {0},
                {1},
                {0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        N5 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1},
                {1},
                {1},
                {1},
                {1},
                {1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        D1 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1},
                {1},
                {1},
                {1},
                {1},
                {1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        D2 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1},
                {0},
                {0},
                {0},
                {0},
                {1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        D3 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1},
                {0},
                {0},
                {0},
                {0},
                {1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        D4 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0},
                {1},
                {0},
                {0},
                {1},
                {0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        D5 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0},
                {0},
                {1},
                {1},
                {0},
                {0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
    }
)

function IconDrawer.drawIcon(iconName, x, y, BGColorKeyOverride, colorKeyOverride)
    local icon
    if IconDrawer.ICONS[iconName] then
        icon = IconDrawer.ICONS[iconName]
    elseif IconDrawer.ICONS.BADGES[iconName] then
        icon = IconDrawer.ICONS.BADGES[iconName]
    end
    if icon ~= nil then
        local iconType = icon.iconType
        local backgroundColorKey = icon.backgroundColorKey
        local shadowColor = DrawingUtils.calcShadowColor(backgroundColorKey)
        if BGColorKeyOverride ~= nil then
            shadowColor = DrawingUtils.calcShadowColor(BGColorKeyOverride)
        end
        local iconArray = icon.imageArray
        for rowIndex = 1,#iconArray, 1 do
            for colIndex = 1,#(iconArray[1]) do
                local offsetX = colIndex - 1
                local offsetY = rowIndex - 1
                local shouldColor = (iconArray[rowIndex][colIndex] >= 1)
                if shouldColor then
                    local iconColorKey = icon.colorKey
                    if type(icon.colorKey) == "table" then
                        iconColorKey = icon.colorKey[iconArray[rowIndex][colIndex]]
                    end
                    if colorKeyOverride ~= nil then
                        iconColorKey = colorKeyOverride
                    end
                    if iconColorKey == "Top box border color" and settings.colorScheme["Top box background color"] == settings.colorScheme["Top box border color"] then
                        iconColorKey = "Top box text color"
                    elseif iconColorKey == "Bottom box border color" and settings.colorScheme["Bottom box background color"] == settings.colorScheme["Bottom box border color"] then
                        iconColorKey = "Bottom box text color"
                    end
                    local color
                    if iconType == IconDrawer.ICON_TYPES.MOVE_TYPE then
                        if settings.colorSettings["Color move type icons"] then
                            color = Graphics.TYPE_COLORS[iconName]
                        else
                            color = settings.colorScheme["Bottom box text color"]
                        end
                    else
                        color = settings.colorScheme[iconColorKey]
                    end
                    if iconType ~= IconDrawer.ICON_TYPES.STANDARD_NO_SHADOW and settings.colorSettings["Draw shadows"] and not settings.colorSettings["Transparent backgrounds"] then
                        gui.drawPixel(x + offsetX + 1,y + offsetY + 1,shadowColor)
                    end
                    gui.drawPixel(x + offsetX, y + offsetY, color)
                end
            end
        end
    end
end

function IconDrawer.drawFriendshipProgress(x, y, progress)
    local iconOrder = {
        "F1","F2","F3","F4","","R1","R2","R3","R4","R5","","I","","E1","E2","E3","E4","","N1","N2","N3","N4","N5","", "D1","D2","D3","D4","D5"
    }
    local totalIcons = #iconOrder
    local currentX = x
    for index, iconName in pairs(iconOrder) do
        if iconName ~= "" then
            local colorKey = "Top box text color"
            if index/totalIcons <= progress then
                colorKey = "Positive text color"
            end
            IconDrawer.drawIcon(iconName, currentX, y, nil, colorKey)
        end
        currentX = currentX + 1
    end
end

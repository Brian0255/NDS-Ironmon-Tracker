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
            colorKey = "Top box text color",
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
        --For the type icons,colorKey is nil because it changes based on the user's color settings.
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
        FIRE_FILLED = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 1, 0, 1, 0, 0},
                {0, 1, 2, 1, 0, 1, 1, 0},
                {1, 2, 3, 2, 1, 2, 2, 1},
                {1, 2, 3, 4, 2, 3, 2, 1},
                {1, 2, 4, 4, 4, 3, 2, 1},
                {0, 1, 3, 4, 4, 3, 1, 0},
                {0, 0, 1, 1, 1, 1, 0, 0}
            },
            colorKey = {0xFFCC4851, 0xFFEA6B44, 0xFFEEA160, 0xFFF8F290},
            backgroundColorKey = "Bottom box background color"
        },
        NORMAL_FILLED = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 1, 1, 1, 1, 0, 0},
                {0, 1, 2, 2, 3, 3, 1, 0},
                {1, 2, 2, 5, 5, 3, 3, 1},
                {1, 2, 5, 0, 0, 6, 3, 1},
                {1, 3, 5, 0, 0, 6, 4, 1},
                {1, 3, 3, 6, 6, 4, 4, 1},
                {0, 1, 3, 3, 4, 4, 1, 0},
                {0, 0, 1, 1, 1, 1, 0, 0}
            },
            colorKey = {0xFF90916A, 0xFFFFFFBC, 0xFFEAEAAD, 0xFFD3D39C, 0xFFACAD80, 0xFF90916B},
            backgroundColorKey = "Bottom box background color"
        },
        FIRE2 = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 4, 4, 4, 4, 0, 0},
                {0, 4, 1, 2, 3, 4, 0, 0},
                {4, 1, 2, 2, 4, 4, 4, 4},
                {4, 1, 2, 2, 2, 2, 3, 4},
                {4, 4, 4, 4, 4, 2, 3, 4},
                {0, 0, 0, 4, 2, 2, 3, 4},
                {0, 0, 4, 2, 2, 3, 4, 0},
                {0, 0, 4, 4, 4, 4, 0, 0}
            },
            colorKey = {0xFFFCE682, 0xFFFBDD59, 0xFFFACC15, 0xFFea8b32},
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
        WATER_FILLED = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 0, 1, 0, 0, 0, 0, 0},
                {0, 0, 1, 2, 1, 0, 0, 0, 0},
                {0, 0, 1, 2, 1, 0, 0, 0, 0},
                {0, 1, 4, 3, 2, 1, 0, 0, 0},
                {0, 1, 4, 3, 2, 1, 0, 0, 0},
                {0, 1, 3, 3, 2, 1, 0, 0, 0},
                {0, 1, 3, 3, 2, 1, 0, 0, 0},
                {0, 0, 1, 1, 1, 0, 0, 0, 0}
            },
            colorKey = {0xFF5379ED, 0xFF56B4EA, 0xFF8CD4FF, 0xFFC6EAFF},
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
        GRASS_FILLED = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 4, 1, 0, 0, 0},
                {0, 1, 3, 4, 5, 1, 0, 0},
                {1, 2, 3, 4, 5, 6, 1, 0},
                {1, 2, 3, 4, 5, 6, 1, 0},
                {1, 2, 3, 4, 5, 6, 1, 0},
                {0, 1, 1, 4, 1, 1, 0, 0},
                {0, 0, 0, 1, 0, 0, 0, 0}
            },
            colorKey = {0xFF5F913E, 0xFFCEFFAD, 0xFFC6F9A4, 0xFFB9EA9A, 0xFFADDB90, 0xFFA3CE88},
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
        ELECTRIC_FILLED = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 4, 4, 4, 4, 0, 0},
                {0, 4, 1, 2, 3, 4, 0, 0},
                {4, 1, 2, 2, 4, 4, 4, 4},
                {4, 1, 2, 2, 2, 2, 3, 4},
                {4, 4, 4, 4, 4, 2, 3, 4},
                {0, 0, 0, 4, 2, 2, 3, 4},
                {0, 0, 4, 2, 2, 3, 4, 0},
                {0, 0, 4, 4, 4, 4, 0, 0}
            },
            colorKey = {0xFFFCE682, 0xFFFBDD59, 0xFFFACC15, 0xFFE19328},
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
        GHOST_FILLED = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 1, 1, 1, 0, 0, 0},
                {0, 1, 3, 4, 5, 1, 0, 0},
                {1, 2, 1, 4, 1, 6, 1, 0},
                {1, 2, 3, 4, 5, 6, 1, 0},
                {1, 2, 3, 4, 5, 6, 1, 0},
                {1, 2, 3, 4, 5, 6, 1, 0},
                {1, 2, 1, 4, 1, 6, 1, 0},
                {0, 1, 0, 1, 0, 1, 0, 0}
            },
            colorKey = {0xFF6F5797, 0xFFD9C6FF, 0xFFD2BAFF, 0xFFC3A3FF, 0xFFB296EA, 0xFFA48AD8},
            --colorKey = {0xFF6F5797, 0xFFC8AAFF, 0xFFBB96FF, 0xFFAF8BEF, 0xFFA081DB, 0xFF8E72C1},
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
        BUG_FILLED = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 1, 0, 0, 1, 0, 0},
                {0, 0, 0, 1, 1, 0, 0, 0},
                {1, 0, 1, 3, 3, 1, 0, 1},
                {0, 1, 2, 3, 3, 4, 1, 0},
                {0, 1, 2, 3, 3, 4, 1, 0},
                {0, 1, 2, 3, 3, 4, 1, 0},
                {0, 0, 1, 3, 3, 1, 0, 0},
                {0, 1, 0, 1, 1, 0, 1, 0}
            },
            colorKey = {0xFF98A81F, 0xFFF1FF8E, 0xFFEBFF56, 0xFFDBEA52},
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
        POISON_FILLED = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 1, 1, 0, 0, 0, 0, 0},
                {1, 3, 4, 2, 0, 0, 0, 0},
                {1, 4, 4, 2, 0, 0, 1, 0},
                {0, 2, 2, 0, 0, 1, 3, 2},
                {0, 0, 0, 0, 0, 0, 2, 0},
                {0, 0, 1, 1, 0, 0, 0, 0},
                {0, 1, 3, 4, 2, 0, 0, 0},
                {0, 0, 2, 2, 0, 0, 0, 0}
            },
            colorKey = {0xFFC850CE, 0xFF8B368E, 0xFFF875FF, 0xFFB247B7},
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
        DARK_FILLED = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 1, 1, 0},
                {1, 2, 1, 0, 0, 1, 6, 1},
                {1, 2, 3, 1, 1, 5, 6, 1},
                {1, 2, 3, 4, 4, 5, 6, 1},
                {1, 2, 3, 4, 4, 5, 6, 1},
                {0, 1, 3, 4, 4, 5, 1, 0},
                {0, 0, 1, 1, 1, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0}
            },
            colorKey = {0xFF6E5848, 0xFFD3A88B, 0xFFC19A7F, 0xFFB59077, 0xFFA5836D, 0xFF997964},
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
        ICE_FILLED = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 0, 1, 1, 0, 0, 0},
                {0, 1, 1, 3, 3, 1, 1, 0},
                {0, 1, 3, 1, 1, 2, 1, 0},
                {1, 3, 1, 2, 2, 1, 4, 1},
                {1, 3, 1, 2, 2, 1, 4, 1},
                {0, 1, 2, 1, 1, 4, 1, 0},
                {0, 1, 1, 4, 4, 1, 1, 0},
                {0, 0, 0, 1, 1, 0, 0, 0}
            },
            colorKey = {0xFF87B7B5, 0xFFE5FFFC, 0xFFF7FFFE, 0xFFD3EAE7},
            backgroundColorKey = "Bottom box background color"
        },
        PSYCHIC = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            --[[
            imageArray = {
                {0,0,0,0,0,0,0,0},
                {0,0,1,1,1,1,0,0},
                {0,1,0,1,1,0,1,0},
                {1,0,1,0,0,1,0,1},
                {1,0,1,0,0,1,0,1},
                {0,1,0,1,1,0,1,0},
                {0,0,1,1,1,1,0,0}
            },
            --]]
            imageArray = {
                {0, 0, 1, 1, 1, 1, 0, 0},
                {0, 1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 1, 1, 0, 0, 1},
                {1, 0, 1, 0, 1, 1, 0, 1},
                {1, 0, 1, 0, 0, 0, 0, 1},
                {1, 0, 0, 1, 1, 1, 1, 0},
                {0, 1, 0, 0, 0, 0, 1, 0},
                {0, 0, 1, 1, 1, 1, 0, 0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        PSYCHIC_FILLED = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 1, 1, 1, 1, 0, 0},
                {0, 1, 3, 3, 2, 2, 1, 0},
                {1, 3, 3, 1, 1, 2, 2, 1},
                {1, 3, 1, 2, 1, 1, 2, 1},
                {1, 2, 1, 2, 2, 2, 4, 1},
                {1, 2, 2, 1, 1, 1, 1, 0},
                {0, 1, 2, 2, 2, 4, 1, 0},
                {0, 0, 1, 1, 1, 1, 0, 0}
            },
            colorKey = {0xFFEF5890, 0xFFFFCCDC, 0xFFFFD6E3, 0xFFFFA3C1},
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
        ROCK_FILLED = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 1, 1, 1, 0, 0, 0},
                {0, 1, 2, 3, 3, 1, 0, 0},
                {0, 1, 2, 3, 3, 1, 1, 0},
                {1, 2, 3, 3, 1, 3, 4, 1},
                {1, 2, 3, 1, 3, 3, 4, 1},
                {1, 2, 3, 1, 3, 3, 4, 1},
                {0, 1, 3, 1, 3, 4, 1, 0},
                {0, 0, 1, 1, 1, 1, 0, 0}
            },
            colorKey = {0xFF89782D, 0xFFC1A93F, 0xFFB5A03B, 0xFFA59136},
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
        GROUND_FILLED = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 1, 1, 0, 0, 0},
                {0, 0, 1, 2, 3, 1, 0, 0},
                {0, 0, 1, 2, 1, 1, 0, 0},
                {0, 1, 1, 1, 4, 3, 1, 0},
                {0, 1, 2, 4, 4, 3, 1, 0},
                {1, 2, 4, 4, 4, 4, 3, 1},
                {1, 1, 1, 1, 1, 1, 1, 1}
            },
            colorKey = {0xFFBC9D4F, 0xFFFFEFCC, 0xFFEAC975, 0xFFffe191},
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
        STEEL_FILLED = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 1, 1, 1, 1, 1, 0, 0},
                {1, 3, 3, 2, 2, 2, 1, 0},
                {1, 3, 1, 1, 1, 2, 1, 0},
                {1, 2, 2, 1, 2, 4, 1, 0},
                {1, 2, 2, 1, 4, 4, 1, 0},
                {0, 1, 2, 4, 4, 1, 0, 0},
                {0, 0, 1, 1, 1, 0, 0, 0}
            },
            colorKey = {0xFF9A9AAD, 0xFFE6E6F7, 0xFFF4F4FF, 0xFFD7D7E2},
            backgroundColorKey = "Bottom box background color"
        },
        FIGHTING_2 = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 0, 0, 0, 0, 0, 0},
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
        FIGHTING = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 1, 1, 1, 1, 1, 0},
                {1, 0, 1, 0, 1, 0, 1},
                {1, 0, 1, 0, 1, 0, 1},
                {1, 0, 1, 0, 1, 0, 1},
                {0, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 1, 0, 0, 1},
                {0, 0, 0, 0, 1, 1, 0}
            },
            colorKey = nil,
            backgroundColorKey = "Bottom box background color"
        },
        FIGHTING_FILLED = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 1, 1, 1, 1, 1, 0},
                {1, 2, 1, 3, 1, 4, 1},
                {1, 2, 1, 3, 1, 4, 1},
                {1, 2, 1, 3, 1, 4, 1},
                {0, 1, 1, 1, 1, 1, 1},
                {0, 0, 0, 1, 5, 5, 1},
                {0, 0, 0, 0, 1, 1, 0}
            },
            colorKey = {0xFFB82A23, 0xFFFFC1C1, 0xFFFFA9A8, 0xFFFF8C8C, 0xFFFF8787},
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
        DRAGON_FILLED = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {1, 0, 1, 0, 0, 1, 0, 1},
                {1, 1, 1, 0, 0, 1, 1, 1},
                {1, 2, 1, 1, 1, 1, 3, 1},
                {1, 2, 4, 4, 4, 4, 3, 1},
                {0, 1, 4, 4, 4, 4, 1, 0},
                {0, 1, 2, 4, 4, 3, 1, 0},
                {0, 0, 1, 4, 4, 1, 0, 0},
                {0, 0, 0, 1, 1, 0, 0, 0}
            },
            colorKey = {0xFF6a2afd, 0xFFC3A9F9, 0xFF986FF2, 0xFFB493FB, 0xFFE20053},
            backgroundColorKey = "Bottom box background color"
        },
        DRAGON_FILLED2 = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {6, 0, 6, 0, 0, 6, 0, 6},
                {6, 6, 6, 0, 0, 6, 6, 6},
                {1, 1, 4, 4, 4, 4, 1, 1},
                {1, 4, 2, 2, 2, 2, 4, 1},
                {0, 1, 3, 2, 2, 3, 1, 0},
                {0, 1, 6, 2, 2, 5, 1, 0},
                {0, 0, 1, 2, 2, 1, 0, 0},
                {0, 0, 0, 5, 5, 0, 0, 0}
            },
            colorKey = {0xFF7131F6, 0xFF9467f8, 0xFFFF0000, 0xFF7F4CF7, 0xFF834EF4, 0xFF5529BC, 0xFF7445E0},
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
        },
        FLYING_FILLED = {
            iconType = IconDrawer.ICON_TYPES.MOVE_TYPE,
            imageArray = {
                {0, 0, 1, 1, 1, 1, 1, 0},
                {0, 1, 2, 2, 3, 3, 3, 1},
                {1, 2, 3, 3, 1, 1, 1, 1},
                {1, 3, 3, 1, 3, 3, 4, 1},
                {1, 3, 3, 3, 4, 1, 1, 0},
                {1, 4, 1, 1, 1, 0, 0, 0},
                {1, 1, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0, 0}
            },
            colorKey = {0xFF6C78CC, 0xFFE0E4FF, 0xFFD1D7FF, 0xFFBFC7FF},
            --colorKey = {0xFF8E7ACC, 0xFFDACCFF, 0xFFCEBAFF, 0xFFC0A8FF },
            backgroundColorKey = "Bottom box background color"
        },
        SPARKLES = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 1, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0},
                {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0},
                {0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        SWORD = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0},
                {0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 1, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        CONTROLLER = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
                {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
                {0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1},
                {0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1},
                {0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1},
                {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {0, 0, 1, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0},
                {0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        PENCIL = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0},
                {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0},
                {0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        PAINTBRUSH = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        BADGES = {
            HGSS = {
                iconType = IconDrawer.ICON_TYPES.STANDARD,
                imageArray = {
                    {0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0},
                    {0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0},
                    {0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0},
                    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                    {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                    {1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1},
                    {1, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 1},
                    {1, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0, 1},
                    {1, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 1},
                    {1, 0, 1, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1},
                    {1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1},
                    {1, 0, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1},
                    {0, 1, 1, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 1, 0},
                    {0, 0, 0, 1, 1, 0, 1, 0, 0, 1, 0, 1, 1, 0, 0, 0},
                    {0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0}
                },
                colorKey = "Top box text color",
                backgroundColorKey = "Top box background color"
            },
            DPPT = {
                iconType = IconDrawer.ICON_TYPES.STANDARD,
                imageArray = {
                    {0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0},
                    {0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0},
                    {0, 0, 0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0},
                    {0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0},
                    {0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0},
                    {0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0},
                    {1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1},
                    {1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1},
                    {1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 1},
                    {1, 0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 0, 1, 1, 0, 1},
                    {1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1},
                    {0, 1, 0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0},
                    {0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0},
                    {0, 0, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0},
                    {0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
                    {0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0}
                },
                colorKey = "Top box text color",
                backgroundColorKey = "Top box background color"
            },
            BW = {
                iconType = IconDrawer.ICON_TYPES.STANDARD,
                imageArray = {
                    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1},
                    {0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 1, 0, 1, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0},
                    {0, 0, 0, 0, 0, 0, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0},
                    {0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0},
                    {0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0},
                    {0, 0, 0, 1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0},
                    {0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0},
                    {0, 0, 1, 0, 1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0},
                    {0, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 1, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
                    {1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
                },
                colorKey = "Top box text color",
                backgroundColorKey = "Top box background color"
            },
            BW2 = {
                iconType = IconDrawer.ICON_TYPES.STANDARD,
                imageArray = {
                    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 0, 1},
                    {0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1},
                    {0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0},
                    {0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0},
                    {0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0},
                    {0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0},
                    {0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0},
                    {0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0},
                    {0, 0, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0},
                    {0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
                    {1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                    {0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
                },
                colorKey = "Top box text color",
                backgroundColorKey = "Top box background color"
            }
        },
        HP_HEALS_ICON = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 1, 1, 1, 1, 0, 0},
                {0, 1, 0, 0, 0, 0, 1, 0},
                {1, 0, 1, 0, 0, 0, 1, 0},
                {1, 0, 1, 0, 0, 1, 1, 0},
                {0, 1, 0, 0, 1, 0, 1, 0},
                {0, 1, 0, 0, 1, 0, 1, 0},
                {1, 1, 0, 0, 1, 0, 0, 1},
                {1, 0, 1, 1, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 1},
                {0, 1, 1, 0, 0, 0, 1, 0},
                {0, 0, 0, 1, 1, 1, 0, 0}
            },
            colorKey = "Positive text color",
            backgroundColorKey = "Top box background color"
        },
        STATUS_HEALS_ICON = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 0, 1, 1, 1, 0},
                {0, 0, 1, 1, 0, 0, 0, 1},
                {1, 1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 1, 0, 1, 0},
                {1, 0, 0, 1, 0, 1, 0, 1},
                {1, 0, 0, 1, 0, 0, 0, 1},
                {1, 1, 1, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 1, 0}
            },
            colorKey = "Intermediate text color",
            backgroundColorKey = "Top box background color"
        },
        BACKSPACE = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 1, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 1, 1, 1},
                {0, 1, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0, 0, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        LIGHTNING_BOLT = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        UPDATER_ICON = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0},
                {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0},
                {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
                {0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1},
                {0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1},
                {0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 1, 1, 1, 1, 0, 1, 0, 1, 1, 1, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        SURVIVAL_HEALS_OLD = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0},
                {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
                {1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1},
                {1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1},
                {1, 2, 2, 2, 2, 1, 2, 2, 2, 2, 1},
                {1, 2, 2, 2, 1, 1, 1, 2, 2, 2, 1},
                {1, 2, 2, 2, 2, 1, 2, 2, 2, 2, 1},
                {1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1},
                {1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1},
                {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
            },
            colorKey = {"Top box border color", "Negative text color"},
            backgroundColorKey = "Top box background color"
        },
        UP_ARROW = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 1, 0, 0},
                {0, 1, 0, 1, 0},
                {1, 0, 0, 0, 1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        DOWN_ARROW = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1, 0, 0, 0, 1},
                {0, 1, 0, 1, 0},
                {0, 0, 1, 0, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        LEFT_ARROW = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 1},
                {0, 1, 0},
                {1, 0, 0},
                {0, 1, 0},
                {0, 0, 1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        RIGHT_ARROW = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {1, 0, 0},
                {0, 1, 0},
                {0, 0, 1},
                {0, 1, 0},
                {1, 0, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        LOCKED = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 1, 1, 0, 0, 0},
                {0, 1, 0, 0, 1, 0, 0},
                {0, 1, 0, 0, 1, 0, 0},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 1, 1, 1, 1, 1, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        UNLOCKED = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 0, 0, 0, 0},
                {0, 0, 1, 1, 0, 0, 0},
                {0, 1, 0, 0, 1, 0, 0},
                {0, 0, 0, 0, 1, 0, 0},
                {1, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 1, 0},
                {1, 1, 1, 1, 1, 1, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        BOOKMARK_EMPTY = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 1, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 1, 1, 0, 0, 1},
                {1, 0, 1, 0, 0, 1, 0, 1},
                {1, 1, 0, 0, 0, 0, 1, 1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        BOOKMARK_FILLED = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 1, 1, 1, 1, 1, 1, 0},
                {1, 1, 1, 1, 1, 1, 1, 1},
                {1, 1, 1, 1, 1, 1, 1, 1},
                {1, 1, 1, 1, 1, 1, 1, 1},
                {1, 1, 1, 1, 1, 1, 1, 1},
                {1, 1, 1, 1, 1, 1, 1, 1},
                {1, 1, 1, 1, 1, 1, 1, 1},
                {1, 1, 1, 0, 0, 1, 1, 1},
                {1, 1, 0, 0, 0, 0, 1, 1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        BOOKMARK_EMPTY_LARGE = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1},
                {1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1},
                {1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        BOOKMARK_FILLED_LARGE = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
                {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
                {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
                {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
                {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
                {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
                {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
                {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
                {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
                {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
                {1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1},
                {1, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1, 1},
                {1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1},
                {1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1},
                {1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        POKEBALL = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0},
                {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0},
                {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
                {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {0, 1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1},
                {0, 1, 1, 1, 1, 0, 0, 1, 0, 0, 0, 1, 0, 0, 1},
                {0, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 1, 1},
                {0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 0, 1, 0},
                {0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 0},
                {0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        LEFT_ARROW_LARGE = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
                {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        RIGHT_ARROW_LARGE = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0},
                {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        LOCATION_ICON_SMALL = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 1, 1, 1, 0},
                {0, 1, 0, 0, 0, 1},
                {0, 1, 0, 1, 0, 1},
                {0, 1, 0, 0, 0, 1},
                {0, 0, 1, 0, 1, 0},
                {0, 0, 1, 0, 1, 0},
                {0, 0, 0, 1, 0, 0}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        LOCATION_ICON_SMALL_FILLED = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 1, 1, 1, 0},
                {0, 1, 1, 1, 1, 1},
                {0, 1, 1, 0, 1, 1},
                {0, 1, 1, 1, 1, 1},
                {0, 1, 1, 1, 1, 1},
                {0, 0, 1, 1, 1, 0},
                {0, 0, 1, 1, 1, 0},
                {0, 0, 0, 1, 0, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        LOCATION_ICON = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 1, 1, 1, 1, 1, 0},
                {1, 1, 1, 1, 1, 1, 1},
                {1, 1, 1, 1, 1, 1, 1},
                {1, 1, 1, 0, 1, 1, 1},
                {1, 1, 1, 1, 1, 1, 1},
                {1, 1, 1, 1, 1, 1, 1},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 1, 1, 1, 1, 1, 0},
                {0, 0, 1, 1, 1, 0, 0},
                {0, 0, 1, 1, 1, 0, 0},
                {0, 0, 0, 1, 0, 0, 0}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        CLOCK = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 1, 1, 1, 1, 1, 0, 0},
                {0, 1, 0, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1, 0, 0, 0, 1},
                {1, 0, 0, 0, 1, 1, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 1},
                {0, 1, 0, 0, 0, 0, 0, 1, 0},
                {0, 0, 1, 1, 1, 1, 1, 0, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        CLOCK_SMALL = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 1, 1, 1, 1, 1, 0, 0},
                {0, 0, 1, 0, 0, 0, 0, 0, 1, 0},
                {0, 1, 0, 0, 0, 1, 0, 0, 0, 1},
                {0, 1, 0, 0, 0, 1, 0, 0, 0, 1},
                {0, 1, 0, 0, 0, 1, 1, 0, 0, 1},
                {0, 1, 0, 0, 0, 0, 0, 0, 0, 1},
                {0, 1, 0, 0, 0, 0, 0, 0, 0, 1},
                {0, 0, 1, 0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 1, 1, 1, 1, 1, 0, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        SMALL_DOT = {
            iconType = IconDrawer.ICON_TYPES.STANDARD_NO_SHADOW,
            imageArray = {
                {1, 1},
                {1, 1}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        LARGE_DOT = {
            iconType = IconDrawer.ICON_TYPES.STANDARD_NO_SHADOW,
            imageArray = {
                {0, 1, 1, 0},
                {1, 1, 1, 1},
                {1, 1, 1, 1},
                {0, 1, 1, 0}
            },
            colorKey = "Top box border color",
            backgroundColorKey = "Top box background color"
        },
        LONG_LEFT_ARROW = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
                {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        BIG_X = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0},
                {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        TM_ICON = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0},
                {0, 0, 2, 2, 1, 1, 1, 1, 2, 2, 0, 0},
                {0, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 0},
                {0, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 0},
                {2, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 2},
                {2, 1, 1, 1, 2, 0, 0, 2, 1, 1, 1, 2},
                {2, 1, 1, 1, 2, 0, 0, 2, 1, 1, 1, 2},
                {2, 1, 1, 1, 1, 2, 2, 1, 1, 1, 1, 2},
                {0, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 0},
                {0, 2, 1, 1, 1, 1, 1, 1, 1, 1, 2, 0},
                {0, 0, 2, 2, 1, 1, 1, 1, 2, 2, 0, 0},
                {0, 0, 0, 0, 2, 2, 2, 2, 0, 0, 0, 0}
            },
            colorKey = {"Top box border color", "Top box text color"},
            backgroundColorKey = "Top box background color"
        },
        PAST_RUN_ICON = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0},
                {0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0},
                {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0},
                {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
                {0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0},
                {0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0},
                {0, 1, 0, 1, 1, 0, 0, 1, 0, 1, 1, 0, 0, 1, 0},
                {0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0},
                {0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 0},
                {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
                {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
                {1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1},
                {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        STATISTICS_ICON = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0},
                {0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0},
                {0, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0},
                {0, 1, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 0, 0, 1, 0},
                {0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0},
                {0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0},
                {0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0},
                {0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0},
                {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        TRACKED_INFO_ICON = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1},
                {0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        OPEN_LOG_ICON = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 1, 1, 0, 0, 1, 0, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
                {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
                {0, 0, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        RESTORE_POINTS_ICON = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0},
                {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
                {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1},
                {0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1},
                {0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1},
                {0, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1},
                {0, 1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 0, 1},
                {0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1},
                {0, 1, 0, 0, 0, 1, 1, 0, 0, 0, 1, 1, 0, 0, 1},
                {0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 1},
                {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
                {0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        TOURNEY_POINTS_ICON = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 2, 2, 2, 2, 2, 0, 3, 3, 3, 3, 3, 0, 0},
                {0, 0, 2, 2, 2, 2, 2, 0, 3, 3, 3, 3, 3, 0, 0},
                {0, 0, 0, 2, 2, 2, 2, 3, 3, 3, 3, 3, 0, 0, 0},
                {0, 0, 0, 2, 2, 2, 2, 3, 3, 3, 3, 3, 0, 0, 0},
                {0, 0, 0, 0, 2, 2, 3, 3, 3, 3, 3, 0, 0, 0, 0},
                {0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0},
                {0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0},
                {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
                {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
                {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0},
                {0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0},
                {0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0}
            },
            colorKey = {"Top box text color", "Shadowed negative text color", "Negative text color"},
            backgroundColorKey = "Top box background color"
        },
        TROPHY_ICON = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0},
                {1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1},
                {1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1},
                {1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1},
                {0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0},
                {0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0},
                {0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        EXTRAS_ICON = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0},
                {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1},
                {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
                {1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
                {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        LOAD_TRACKER_DATA = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0},
                {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0},
                {0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0},
                {1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0},
                {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0},
                {0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0},
                {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0},
                {0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0},
                {0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0}
            },
            colorKey = "Top box text color",
            backgroundColorKey = "Top box background color"
        },
        CLOCK = {
            iconType = IconDrawer.ICON_TYPES.STANDARD,
            imageArray = {
                    { 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0 },
                    { 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0 },
                    { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
                    { 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 0 },
                    { 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1 },
                    { 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1 },
                    { 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 1, 1 },
                    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
                    { 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1 },
                    { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
                    { 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0 },
                    { 0, 0, 1, 1, 0, 0, 1, 0, 0, 1, 1, 0, 0 },
                    {0,0,0,0,1,1,1,1,1,0,0,0,0},
            },
            colorKey = "Top box text color",
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
        }
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
        if iconType == IconDrawer.ICON_TYPES.MOVE_TYPE and settings.colorSettings["Color move type icons"] then
            local newName = iconName .. "_FILLED"
            if IconDrawer.ICONS[newName] then
                iconName = newName
                iconType = IconDrawer.ICON_TYPES.STANDARD
                icon = IconDrawer.ICONS[newName]
            end
        end
        local backgroundColorKey = icon.backgroundColorKey
        local shadowColor = DrawingUtils.calcShadowColor(backgroundColorKey)
        if BGColorKeyOverride ~= nil then
            shadowColor = DrawingUtils.calcShadowColor(BGColorKeyOverride)
        end

        local iconArray = icon.imageArray
        for rowIndex = 1, #iconArray, 1 do
            for colIndex = 1, #(iconArray[1]) do
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
                    if
                        iconColorKey == "Top box border color" and
                            settings.colorScheme["Top box background color"] == settings.colorScheme["Top box border color"]
                     then
                        iconColorKey = "Top box text color"
                    elseif
                        iconColorKey == "Bottom box border color" and
                            settings.colorScheme["Bottom box background color"] ==
                                settings.colorScheme["Bottom box border color"]
                     then
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
                        if settings.colorScheme[iconColorKey] then
                            color = settings.colorScheme[iconColorKey]
                        else
                            color = iconColorKey
                        end
                    end
                    if iconColorKey == "Shadowed negative text color" then
                        color = DrawingUtils.calcShadowColor("Negative text color", true)
                    end
                    if
                        iconType ~= IconDrawer.ICON_TYPES.STANDARD_NO_SHADOW and settings.colorSettings["Draw shadows"] and
                            not settings.colorSettings["Transparent backgrounds"]
                     then
                        gui.drawPixel(x + offsetX + 1, y + offsetY + 1, shadowColor)
                    end
                    gui.drawPixel(x + offsetX, y + offsetY, color)
                end
            end
        end
    end
end

function IconDrawer.drawFriendshipProgress(x, y, progress)
    local iconOrder = {
        "F1",
        "F2",
        "F3",
        "F4",
        "",
        "R1",
        "R2",
        "R3",
        "R4",
        "R5",
        "",
        "I",
        "",
        "E1",
        "E2",
        "E3",
        "E4",
        "",
        "N1",
        "N2",
        "N3",
        "N4",
        "N5",
        "",
        "D1",
        "D2",
        "D3",
        "D4",
        "D5"
    }
    local totalIcons = #iconOrder
    local currentX = x
    for index, iconName in pairs(iconOrder) do
        if iconName ~= "" then
            local colorKey = "Top box text color"
            if index / totalIcons <= progress then
                colorKey = "Positive text color"
            end
            IconDrawer.drawIcon(iconName, currentX, y, nil, colorKey)
        end
        currentX = currentX + 1
    end
end

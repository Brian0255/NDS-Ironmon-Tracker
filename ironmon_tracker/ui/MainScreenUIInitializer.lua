--main screen UI skeleton is in here to reduce bloat
local function MainScreenUIInitializer(ui, gameInfo)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local ImageLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageLabel.lua")
    local ImageField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/ImageField.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local Icon = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Icon.lua")

    local self = {}
    local constants = Graphics.MAIN_SCREEN_CONSTANTS

    function self.initMainFrames()
        ui.frames.hiddenPowerArrowsFrame =
            Frame(
            Box({x = 0, y = 0}, {width = 0, height = 0}, nil, nil),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 0, y = 2}),
            nil
        )
        ui.frames.mainFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = Graphics.SIZES.MAIN_SCREEN_HEIGHT},
                "Main background color",
                nil
            ),
            Layout(
                Graphics.ALIGNMENT_TYPE.HORIZONTAL,
                5,
                {x = Graphics.SIZES.BORDER_MARGIN, y = Graphics.SIZES.BORDER_MARGIN}
            ),
            nil
        )

        ui.frames.mainInnerFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.BORDER_MARGIN, y = Graphics.SIZES.BORDER_MARGIN},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = Graphics.SIZES.MAIN_SCREEN_HEIGHT - 2 * Graphics.SIZES.BORDER_MARGIN
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL),
            ui.frames.mainFrame
        )

        ui.frames.topHalfFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.STAT_INFO_HEIGHT - 1
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL),
            ui.frames.mainInnerFrame
        )

        ui.frames.topLeftFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {width = constants.POKEMON_INFO_WIDTH, height = constants.STAT_INFO_HEIGHT},
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL),
            ui.frames.topHalfFrame
        )
        ui.frames.mainPokemonInfoFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.POKEMON_INFO_WIDTH,
                    height = constants.POKEMON_INFO_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL),
            ui.frames.topLeftFrame
        )
        ui.frames.pokemonImageTypeFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.POKEMON_INFO_X_OFFSET,
                    height = constants.POKEMON_INFO_HEIGHT
                },
                nil,
                nil,
                nil,
                nil,
                nil,
                1
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL),
            ui.frames.mainPokemonInfoFrame
        )
        ui.frames.pokemonInfoFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.POKEMON_INFO_X_OFFSET,
                    height = constants.POKEMON_INFO_HEIGHT
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 1}),
            ui.frames.mainPokemonInfoFrame
        )
        ui.frames.pokemonNameGearFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.POKEMON_INFO_X_OFFSET,
                    height = 9
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL),
            ui.frames.pokemonInfoFrame
        )
        ui.frames.miscInfoFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.POKEMON_INFO_WIDTH,
                    height = constants.STAT_INFO_HEIGHT - constants.POKEMON_INFO_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0),
            ui.frames.topLeftFrame
        )
        ui.frames.healFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.POKEMON_INFO_WIDTH - 21,
                    height = constants.STAT_INFO_HEIGHT - constants.POKEMON_INFO_HEIGHT
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 1}),
            ui.frames.miscInfoFrame
        )
        ui.frames.enemyNoteFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.POKEMON_INFO_WIDTH,
                    height = constants.STAT_INFO_HEIGHT - constants.POKEMON_INFO_HEIGHT
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 4, y = 3}),
            ui.frames.miscInfoFrame,
            false
        )
        ui.frames.accEvaFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 30,
                    height = 0
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = -4, y = 3}),
            ui.frames.miscInfoFrame,
            true
        )
        ui.frames.survivalHealFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 30,
                    height = 0
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 1, {x = -1, y = 1}),
            ui.frames.miscInfoFrame
        )
        ui.frames.tourneyPointsFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 21,
                    height = 22
                }
            ),
            nil,
            ui.frames.miscInfoFrame
        )
        ui.frames.statFrame =
            Frame(
            Box(
                {
                    x = constants.POKEMON_INFO_WIDTH,
                    y = 0
                },
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - constants.POKEMON_INFO_WIDTH -
                        2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.STAT_INFO_HEIGHT
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 0}),
            ui.frames.topHalfFrame
        )
        ui.frames.mainStatsFrame =
            Frame(
            Box(
                {
                    x = constants.POKEMON_INFO_WIDTH,
                    y = 0
                },
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - constants.POKEMON_INFO_WIDTH -
                        2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.STAT_INFO_HEIGHT - 11
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 0, y = 2}),
            ui.frames.statFrame
        )
        ui.frames.moveHeaderFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 80,
                    height = constants.MOVE_HEADER_HEIGHT
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 3, y = 3}),
            ui.frames.mainInnerFrame
        )
        ui.frames.moveInfoFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.MOVE_INFO_HEIGHT - 0.5
                },
                "Bottom box background color",
                "Bottom box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL),
            ui.frames.mainInnerFrame
        )
        ui.frames.badgeFrame1 =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.BADGE_HORIZONTAL_WIDTH,
                    height = constants.BOTTOM_BOX_HEIGHT
                },
                "Bottom box background color",
                "Bottom box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 1, {x = 3, y = 2}),
            ui.frames.mainFrame
        )
        ui.frames.badgeFrame2 =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.BADGE_HORIZONTAL_WIDTH,
                    height = constants.BOTTOM_BOX_HEIGHT
                },
                "Bottom box background color",
                "Bottom box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 1, {x = 3, y = 2}),
            ui.frames.mainFrame
        )
    end

    function self.initMoveInfo()
        ui.moveInfoFrames = {}
        for i = 1, 4, 1 do
            local moveInfoFrame = {}
            local frameName = "move" .. i .. "Frame"
            local nameIconFrameName = "move" .. i .. "NameIconFrame"
            local PPPowAccFrameName = "move" .. i .. "PPPowAccFrame"
            ui.frames[frameName] =
                Frame(
                Box(
                    {
                        x = 0,
                        y = 0
                    },
                    {
                        width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                        height = constants.MOVE_ENTRY_HEIGHT
                    }
                ),
                Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 2, y = 2}),
                ui.frames.moveInfoFrame
            )
            ui.frames[nameIconFrameName] =
                Frame(
                Box(
                    {
                        x = 0,
                        y = 0
                    },
                    {
                        width = 80,
                        height = constants.MOVE_ENTRY_HEIGHT
                    }
                ),
                Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL),
                ui.frames[frameName]
            )
            ui.frames[PPPowAccFrameName] =
                Frame(
                Box(
                    {
                        x = 0,
                        y = 0
                    },
                    {
                        width = 50,
                        height = constants.MOVE_ENTRY_HEIGHT
                    }
                ),
                Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL),
                ui.frames[frameName]
            )
            moveInfoFrame.categoryIcon =
                Icon(
                Component(
                    ui.frames[nameIconFrameName],
                    Box(
                        {
                            x = 0,
                            y = 0
                        },
                        {width = 9, height = 10}
                    )
                ),
                "PHYSICAL",
                {x = 1, y = 2}
            )
            moveInfoFrame.moveTypeIcon =
                Icon(
                Component(
                    ui.frames[nameIconFrameName],
                    Box(
                        {
                            x = 0,
                            y = 0
                        },
                        {width = 10, height = 10}
                    )
                ),
                "DRAGON",
                {x = 1, y = 2}
            )
            moveInfoFrame.moveNameLabel =
                TextLabel(
                Component(
                    ui.frames[nameIconFrameName],
                    Box(
                        {
                            x = 0,
                            y = 0
                        },
                        {width = 70, height = 8}
                    )
                ),
                TextField(
                    "Tail Whip",
                    {x = -1, y = 0},
                    TextStyle(
                        Graphics.FONT.DEFAULT_FONT_SIZE,
                        Graphics.FONT.DEFAULT_FONT_FAMILY,
                        "Bottom box text color",
                        "Bottom box background color"
                    )
                ),
                "Bottom"
            )
            moveInfoFrame.PPLabel =
                TextLabel(
                Component(
                    ui.frames[PPPowAccFrameName],
                    Box(
                        {
                            x = 0,
                            y = 0
                        },
                        {width = 18, height = 10}
                    )
                ),
                TextField(
                    "-1",
                    Graphics.SIZES.DEFAULT_TEXT_OFFSET,
                    TextStyle(
                        Graphics.FONT.DEFAULT_FONT_SIZE,
                        Graphics.FONT.DEFAULT_FONT_FAMILY,
                        "Bottom box text color",
                        "Bottom box background color"
                    ),
                    true,
                    2
                )
            )
            moveInfoFrame.powLabel =
                TextLabel(
                Component(
                    ui.frames[PPPowAccFrameName],
                    Box(
                        {
                            x = 0,
                            y = 0
                        },
                        {width = 21, height = 10}
                    )
                ),
                TextField(
                    "-1",
                    Graphics.SIZES.DEFAULT_TEXT_OFFSET,
                    TextStyle(
                        Graphics.FONT.DEFAULT_FONT_SIZE,
                        Graphics.FONT.DEFAULT_FONT_FAMILY,
                        "Bottom box text color",
                        "Bottom box background color"
                    ),
                    true
                )
            )
            moveInfoFrame.accLabel =
                TextLabel(
                Component(
                    ui.frames[PPPowAccFrameName],
                    Box(
                        {
                            x = 0,
                            y = 0
                        },
                        {width = 10, height = 10}
                    ),
                    true
                ),
                TextField(
                    "-1",
                    Graphics.SIZES.DEFAULT_TEXT_OFFSET,
                    TextStyle(
                        Graphics.FONT.DEFAULT_FONT_SIZE,
                        Graphics.FONT.DEFAULT_FONT_FAMILY,
                        "Bottom box text color",
                        "Bottom box background color"
                    ),
                    true
                )
            )
            table.insert(ui.moveInfoFrames, moveInfoFrame)
        end
    end

    function self.initPokemonInfoControls()
        ui.controls.pokemonImageLabel =
            ImageLabel(
            Component(
                ui.frames.pokemonImageTypeFrame,
                Box({x = 0, y = 0}, {width = 30, height = 28}, nil, nil, nil, nil, nil, 1)
            ),
            ImageField("ironmon_tracker/images/pokemonIcons/1.png", {x = 0, y = -5}, nil)
        )
        ui.controls.pokemonType1 =
            ImageLabel(
            Component(ui.frames.pokemonImageTypeFrame, Box({x = 0, y = -8}, {width = 0, height = 12}, nil, nil)),
            ImageField("", {x = 1, y = 0}, {width = 30, height = 12})
        )
        ui.controls.pokemonType2 =
            ImageLabel(
            Component(ui.frames.pokemonImageTypeFrame, Box({x = 0, y = -8}, {width = 0, height = 14}, nil, nil)),
            ImageField("", {x = 1, y = 0}, {width = 30, height = 12})
        )
        ui.controls.pokemonNameLabel =
            TextLabel(
            Component(ui.frames.pokemonNameGearFrame, Box({x = 0, y = 0}, {width = 56, height = 9})),
            TextField(
                "Gorebyss",
                {x = 0, y = -1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls.gearIcon =
            Icon(
            Component(ui.frames.pokemonNameGearFrame, Box({x = 0, y = 0}, {width = 8, height = 8}, nil, nil)),
            "GEAR",
            {x = 0, y = 2}
        )
        ui.controls.pokemonLevelAndEvo =
            TextLabel(
            Component(
                ui.frames.pokemonInfoFrame,
                Box(
                    {
                        x = 0,
                        y = 0
                    },
                    {width = 50, height = 10},
                    "Top box background color"
                )
            ),
            TextField(
                "Lv. 7 (--)",
                Graphics.SIZES.DEFAULT_TEXT_OFFSET,
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls.pokemonHP =
            TextLabel(
            Component(
                ui.frames.pokemonInfoFrame,
                Box(
                    {
                        x = 0,
                        y = 0
                    },
                    {width = 64, height = 10}
                )
            ),
            TextField(
                "HP: 29/29",
                Graphics.SIZES.DEFAULT_TEXT_OFFSET,
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls.heldItem =
            TextLabel(
            Component(
                ui.frames.pokemonInfoFrame,
                Box(
                    {
                        x = 0,
                        y = 0
                    },
                    {width = 64, height = 10}
                )
            ),
            TextField(
                "---",
                Graphics.SIZES.DEFAULT_TEXT_OFFSET,
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Intermediate text color",
                    "Top box background color"
                )
            )
        )
        ui.controls.abilityDetails =
            TextLabel(
            Component(
                ui.frames.pokemonInfoFrame,
                Box(
                    {
                        x = 0,
                        y = 0
                    },
                    {width = 64, height = 10}
                )
            ),
            TextField(
                "Honey Gather",
                Graphics.SIZES.DEFAULT_TEXT_OFFSET,
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Intermediate text color",
                    "Top box background color"
                )
            )
        )
        ui.frames.infoBottomFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 0,
                    height = 0
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 0, y = 0}),
            ui.frames.pokemonInfoFrame
        )

        ui.frames.bookmarkFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 0,
                    height = 0
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 54, y = 0}),
            ui.frames.infoBottomFrame
        )
        ui.controls.lockIcon =
            Icon(
            Component(
                ui.frames.infoBottomFrame,
                Box(
                    {
                        x = 0,
                        y = 0
                    },
                    {width = 8, height = 9}
                )
            ),
            "UNLOCKED",
            {x = 2, y = 0}
        )

        ui.frames.encounterDataFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 26,
                    height = 10
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 0, y = 0}),
            ui.frames.infoBottomFrame
        )

        ui.controls.bookmarkIcon =
            Icon(
            Component(ui.frames.bookmarkFrame, Box({x = 0, y = 0}, {width = 8, height = 8}, nil, nil)),
            "BOOKMARK_EMPTY",
            {x = 2, y = 1}
        )
        ui.controls.locationIcon =
            Icon(
            Component(ui.frames.encounterDataFrame, Box({x = 0, y = 0}, {width = 8, height = 0}, nil, nil)),
            "LOCATION_ICON_SMALL_FILLED",
            {x = 2, y = 2}
        )
        ui.controls.encountersSeen =
            TextLabel(
            Component(
                ui.frames.encounterDataFrame,
                Box(
                    {
                        x = 0,
                        y = 0
                    },
                    {width = 0, height = 0}
                )
            ),
            TextField(
                "10/14",
                Graphics.SIZES.DEFAULT_TEXT_OFFSET,
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls.moveHeaderLearnedText =
            TextLabel(
            Component(
                ui.frames.moveHeaderFrame,
                Box(
                    {
                        x = 0,
                        y = 0
                    },
                    {width = 80, height = 10}
                )
            ),
            TextField(
                "Moves: 0/0 (0)",
                Graphics.SIZES.DEFAULT_TEXT_OFFSET,
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Move header text color",
                    "Main background color"
                )
            )
        )
        ui.controls.moveHeaderPP =
            TextLabel(
            Component(
                ui.frames.moveHeaderFrame,
                Box(
                    {
                        x = 0,
                        y = 0
                    },
                    {width = 17, height = 10}
                )
            ),
            TextField(
                "PP",
                Graphics.SIZES.DEFAULT_TEXT_OFFSET,
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Move header text color",
                    "Main background color"
                )
            )
        )
        ui.controls.moveHeaderPow =
            TextLabel(
            Component(
                ui.frames.moveHeaderFrame,
                Box(
                    {
                        x = 0,
                        y = 0
                    },
                    {width = 23, height = 10}
                )
            ),
            TextField(
                "Pow",
                Graphics.SIZES.DEFAULT_TEXT_OFFSET,
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Move header text color",
                    "Main background color"
                )
            )
        )
        ui.controls.moveHeaderAcc =
            TextLabel(
            Component(
                ui.frames.moveHeaderFrame,
                Box(
                    {
                        x = 0,
                        y = 0
                    },
                    {width = 25, height = 10}
                )
            ),
            TextField(
                "Acc",
                Graphics.SIZES.DEFAULT_TEXT_OFFSET,
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Move header text color",
                    "Main background color"
                )
            )
        )
    end

    function self.initStatControls()
        local stats = {"HP", "ATK", "DEF", "SPA", "SPD", "SPE"}
        for _, stat in pairs(stats) do
            local frameName = stat .. "Frame"
            ui.frames[frameName] =
                Frame(
                Box(
                    {x = 0, y = 0},
                    {
                        width = 45,
                        height = 10
                    },
                    nil
                ),
                Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 1, y = 0}),
                ui.frames.mainStatsFrame
            )
            local labelName = stat .. "StatName"
            ui.controls[labelName] =
                TextLabel(
                Component(ui.frames[frameName], Box({x = 0, y = 0}, {width = 25, height = 10}, nil, nil, nil)),
                TextField(
                    stat,
                    {x = 0, y = -2},
                    TextStyle(
                        Graphics.FONT.DEFAULT_FONT_SIZE,
                        Graphics.FONT.DEFAULT_FONT_FAMILY,
                        "Top box text color",
                        "Top box background color"
                    )
                )
            )
            local numberLabelName = stat .. "StatNumber"
            ui.controls[numberLabelName] =
                TextLabel(
                Component(ui.frames[frameName], Box({x = 0, y = 0}, {width = 0, height = 0}, nil, nil, nil)),
                TextField(
                    "-1",
                    {x = 0, y = -2},
                    TextStyle(
                        Graphics.FONT.DEFAULT_FONT_SIZE,
                        Graphics.FONT.DEFAULT_FONT_FAMILY,
                        "Top box text color",
                        "Top box background color"
                    ),
                    true
                )
            )
            local predictionLabel = stat .. "StatPrediction"
            ui.controls[predictionLabel] =
                TextLabel(
                Component(
                    ui.frames[frameName],
                    Box(
                        {x = 0, y = 0},
                        {width = 8, height = 8},
                        "Top box background color",
                        "Top box border color",
                        true,
                        "Top box background color"
                    )
                ),
                TextField(
                    "",
                    {x = 0, y = -1},
                    TextStyle(
                        Graphics.FONT.DEFAULT_FONT_SIZE,
                        Graphics.FONT.DEFAULT_FONT_FAMILY,
                        "Top box text color",
                        "Top box background color"
                    )
                )
            )
        end
        ui.frames.BSTFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = 44,
                    height = 11
                },
                "Top box background color",
                "Top box border color",
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 1, y = 0}),
            ui.frames.statFrame
        )
        ui.controls.BST =
            TextLabel(
            Component(ui.frames.BSTFrame, Box({x = 0, y = 0}, {width = 25, height = 10}, nil, nil)),
            TextField(
                "BST",
                Graphics.SIZES.DEFAULT_TEXT_OFFSET,
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls.BSTNumber =
            TextLabel(
            Component(ui.frames.BSTFrame, Box({x = 0, y = 0}, {width = 25, height = 10}, nil, nil)),
            TextField(
                "720",
                Graphics.SIZES.DEFAULT_TEXT_OFFSET,
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                ),
                true
            )
        )
    end

    function self.initBadgeControls()
        ui.badgeControlsSet1 = {}
        ui.badgeControlsSet2 = {}
        local prefix = gameInfo.BADGE_PREFIX
        for i = 1, 8, 1 do
            local badgeControl =
                ImageLabel(
                Component(ui.frames.badgeFrame1, Box({x = 0, y = 0}, {width = 16.3, height = 16}, nil, nil)),
                ImageField("ironmon_tracker/images/icons/" .. prefix .. "_badge" .. i .. "_OFF.png", {x = -1, y = 0})
            )
            table.insert(ui.badgeControlsSet1, badgeControl)
        end
        if gameInfo.GEN == 4 then
            for i = 1, 8, 1 do
                local badgeControl =
                    ImageLabel(
                    Component(ui.frames.badgeFrame2, Box({x = 0, y = 0}, {width = 16.3, height = 16}, nil, nil)),
                    ImageField("ironmon_tracker/images/icons/HGSS_K_badge" .. i .. "_OFF.png", {x = -1, y = 0})
                )
                table.insert(ui.badgeControlsSet2, badgeControl)
            end
        end
    end

    function self.initMiscControls()
        ui.controls.accuracyLabel =
            TextLabel(
            Component(ui.frames.accEvaFrame, Box({x = 0, y = 0}, {width = 0, height = 9}, nil, nil)),
            TextField(
                "ACC",
                {x = 0, y = -2},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls.evasionLabel =
            TextLabel(
            Component(ui.frames.accEvaFrame, Box({x = 0, y = 0}, {width = 0, height = 9}, nil, nil)),
            TextField(
                "EVA",
                {x = 0, y = -2},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls.healsLabel =
            TextLabel(
            Component(ui.frames.healFrame, Box({x = 0, y = 0}, {width = 80, height = 9}, nil, nil)),
            TextField(
                "Heals in bag:",
                {x = 1, y = 0},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls.statusItemsLabel =
            TextLabel(
            Component(ui.frames.healFrame, Box({x = 0, y = 0}, {width = 68, height = 10}, nil, nil)),
            TextField(
                "this is a test",
                {x = 1, y = 0},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls.survivalHealsIcon =
            ImageLabel(
            Component(ui.frames.survivalHealFrame, Box({x = 0, y = 0}, {width = 8, height = 10}, nil, nil)),
            ImageField("ironmon_tracker/images/icons/heart.png", {x = 4, y = 1}, nil)
        )
        ui.frames.survivalHealAmountFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 30,
                    height = 0
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 1, {x = -2, y = 2}),
            ui.frames.survivalHealFrame
        )
        ui.controls.decreaseHealsIcon =
            Icon(
            Component(ui.frames.survivalHealAmountFrame, Box({x = 0, y = 0}, {width = 7, height = 6}, nil, nil)),
            "LEFT_ARROW",
            {x = 2, y = 1}
        )
        ui.controls.survivalHealAmountLabel =
            TextLabel(
            Component(ui.frames.survivalHealAmountFrame, Box({x = 0, y = 0}, {width = 8, height = 8}, nil, nil)),
            TextField(
                "12",
                {x = -2, y = -3},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls.increaseHealsIcon =
            Icon(
            Component(ui.frames.survivalHealAmountFrame, Box({x = 0, y = 0}, {width = 6, height = 6}, nil, nil)),
            "RIGHT_ARROW",
            {x = 2, y = 1}
        )
        ui.controls.trophyImage =
            Icon(
            Component(ui.frames.tourneyPointsFrame, Box({x = 0, y = 2}, {width = 0, height = 0}, nil, nil)),
            "TROPHY_ICON",
            {x = 0, y = 0}
        )
        ui.controls.tourneyPointsLabel =
            TextLabel(
            Component(ui.frames.tourneyPointsFrame, Box({x = 0, y = 0}, {width = 4, height = 0}, nil, nil)),
            TextField(
                "89",
                {x = 6, y = 5},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls.noteIcon =
            Icon(
            Component(ui.frames.enemyNoteFrame, Box({x = 0, y = 0}, {width = 11, height = 16}, nil, nil)),
            "NOTE_TOP",
            {x = 0, y = 2}
        )
        ui.controls.mainNoteLabel =
            TextLabel(
            Component(
                ui.frames.enemyNoteFrame,
                Box({x = 0, y = 0}, {width = constants.POKEMON_INFO_WIDTH, height = 8}, nil, nil)
            ),
            TextField(
                "",
                {x = 1, y = 2},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.frames.noteLabelsFrame =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = constants.POKEMON_INFO_WIDTH - 26,
                    height = constants.STAT_INFO_HEIGHT - constants.POKEMON_INFO_HEIGHT
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 1, {x = 0, y = -2}),
            ui.frames.enemyNoteFrame
        )
        ui.controls.noteLabels = {}
        ui.controls.noteLabels[1] =
            TextLabel(
            Component(ui.frames.noteLabelsFrame, Box({x = 0, y = 0}, {width = 0, height = 8}, nil, nil)),
            TextField(
                "",
                {x = 1, y = 0},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.frames.pastRunLocationAndNote =
            Frame(
            Box(
                {
                    x = 0,
                    y = 0
                },
                {
                    width = 0,
                    height = 0
                }
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 0, y = 0}),
            ui.frames.noteLabelsFrame
        )
        ui.controls.pastRunLocationIcon =
            Icon(
            Component(ui.frames.pastRunLocationAndNote, Box({x = 0, y = 0}, {width = 7, height = 0}, nil, nil)),
            "LOCATION_ICON_SMALL_FILLED",
            {x = 2, y = 2},
            false
        )
        ui.controls.noteLabels[2] =
            TextLabel(
            Component(ui.frames.pastRunLocationAndNote, Box({x = 0, y = 0}, {width = 0, height = 8}, nil, nil)),
            TextField(
                "",
                {x = 1, y = 0},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
    end

    function self.initHiddenPowerArrows()
        ui.controls.leftHiddenPowerLabel =
            TextLabel(
            Component(ui.frames.hiddenPowerArrowsFrame, Box({x = 0, y = 0}, {width = 5, height = 7}, nil, nil, nil)),
            TextField(
                "<",
                {x = -1, y = -1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Bottom box text color",
                    "Bottom box background color"
                )
            )
        )
        ui.controls.rightHiddenPowerLabel =
            TextLabel(
            Component(ui.frames.hiddenPowerArrowsFrame, Box({x = 0, y = 0}, {width = 5, height = 7}, nil, nil, nil)),
            TextField(
                ">",
                {x = -1, y = -1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Bottom box text color",
                    "Bottom box background color"
                )
            )
        )
    end

    function self.initUI()
        self.initMainFrames()
        self.initMoveInfo()
        self.initPokemonInfoControls()
        self.initStatControls()
        self.initBadgeControls()
        self.initMiscControls()
        self.initHiddenPowerArrows()
    end

    return self
end

return MainScreenUIInitializer

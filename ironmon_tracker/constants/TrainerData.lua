TrainerData = {}

TrainerData.TRAINER_TYPES = {
    STANDARD = 0,
    RIVAL = 1,
    GYM_LEADERS = 2
}

TrainerData.TRAINERS = {
    --diamond/pearl
    [0x45414441] = {
        LAB_IDS = {
            [247] = true,
            [248] = true,
            [249] = true
        },
        FINAL_FIGHT_ID = 267,
        IMPORTANT_GROUPS = {
            {
                groupName = "Barry",
                trainerType = TrainerData.TRAINER_TYPES.RIVAL,
                battles = {
                    {location = "Route 203", ids = {248, 249, 247}, iv = 3},
                    {location = "Hearthorne City", ids = {471, 472, 470}, iv = 6},
                    {location = "Pastoria City", ids = {474, 475, 473}, iv = 9},
                    {location = "Canalave City", ids = {477, 478, 476}, iv = 12},
                    {location = "Victory Road", ids = {480, 481, 479}, iv = 24}
                }
            },
            {
                groupName = "Gym Leaders",
                trainerType = TrainerData.TRAINER_TYPES.GYM_LEADERS,
                battles = {
                    {name = "Roark", ids = {246}, badgeNumber = 1, iv = 6},
                    {name = "Gardenia", ids = {315}, badgeNumber = 2, iv = 6},
                    {name = "Maylene", ids = {317}, badgeNumber = 3, iv = 12},
                    {name = "Wake", ids = {316}, badgeNumber = 4, iv = 12},
                    {name = "Fantina", ids = {318}, badgeNumber = 5, iv = 18},
                    {name = "Byron", ids = {250}, badgeNumber = 6, iv = 18},
                    {name = "Candice", ids = {319}, badgeNumber = 7, iv = 24},
                    {name = "Volkner", ids = {320}, badgeNumber = 8, iv = 24}
                }
            },
            {
                groupName = "Elite 4",
                trainerType = TrainerData.TRAINER_TYPES.STANDARD,
                battles = {
                    {name = "Aaron", ids = {261}, iv = 30},
                    {name = "Bertha", ids = {262}, iv = 30},
                    {name = "Flint", ids = {263}, iv = 30},
                    {name = "Lucian", ids = {264}, iv = 30},
                    {name = "Cynthia", ids = {267}, iv = 30}
                }
            }
        }
    },
    --platinum
    [0x45555043] = {
        LAB_IDS = {
            [851] = true,
            [852] = true,
            [850] = true
        },
        FINAL_FIGHT_ID = 267,
        IMPORTANT_GROUPS = {
            {
                groupName = "Barry",
                trainerType = TrainerData.TRAINER_TYPES.RIVAL,
                battles = {
                    {location = "Lab", ids = {851, 852, 850}, iv = 0},
                    {location = "Route 203", ids = {248, 249, 247}, iv = 3},
                    {location = "Hearthorne City", ids = {471, 472, 470}, iv = 6},
                    {location = "Pastoria City", ids = {474, 475, 473}, iv = 9},
                    {location = "Canalave City", ids = {477, 478, 476}, iv = 12},
                    {location = "Victory Road", ids = {480, 481, 479}, iv = 24}
                }
            },
            {
                groupName = "Gym Leaders",
                trainerType = TrainerData.TRAINER_TYPES.GYM_LEADERS,
                battles = {
                    {name = "Roark", ids = {246}, badgeNumber = 1, iv = 6},
                    {name = "Gardenia", ids = {315}, badgeNumber = 2, iv = 6},
                    {name = "Maylene", ids = {317}, badgeNumber = 3, iv = 12},
                    {name = "Wake", ids = {316}, badgeNumber = 4, iv = 12},
                    {name = "Fantina", ids = {318}, badgeNumber = 5, iv = 18},
                    {name = "Byron", ids = {250}, badgeNumber = 6, iv = 18},
                    {name = "Candice", ids = {319}, badgeNumber = 7, iv = 24},
                    {name = "Volkner", ids = {320}, badgeNumber = 8, iv = 24}
                }
            },
            {
                groupName = "Elite 4",
                trainerType = TrainerData.TRAINER_TYPES.STANDARD,
                battles = {
                    {name = "Aaron", ids = {261}, iv = 30},
                    {name = "Bertha", ids = {262}, iv = 30},
                    {name = "Flint", ids = {263}, iv = 30},
                    {name = "Lucian", ids = {264}, iv = 30},
                    {name = "Cynthia", ids = {267}, iv = 30}
                }
            }
        }
    },
    --heartgold/soulsilver
    [0x454B5049] = {
        LAB_IDS = {
            [496] = true,
            [497] = true,
            [495] = true
        },
        FINAL_FIGHT_ID = 260,
        IMPORTANT_GROUPS = {
            {
                groupName = "Silver",
                trainerType = TrainerData.TRAINER_TYPES.RIVAL,
                battles = {
                    {location = "Lab", ids = {496, 497, 495}, iv = 0},
                    {location = "Azalea Town", ids = {266, 269, 1}, iv = 3},
                    {location = "Burned Tower", ids = {267, 270, 263}, iv = 6},
                    {location = "Goldenrod", ids = {289, 271, 288}, iv = 14},
                    {location = "Victory Road", ids = {268, 272, 264}, iv = 19},
                    {location = "Mt. Moon", ids = {286, 287, 285}, iv = 24}
                }
            },
            {
                groupName = "Johto Gyms",
                trainerType = TrainerData.TRAINER_TYPES.GYM_LEADERS,
                battles = {
                    {name = "Falkner", ids = {20}, badgeNumber = 1, iv = 6},
                    {name = "Bugsy", ids = {21}, badgeNumber = 2, iv = 9},
                    {name = "Whitney", ids = {30}, badgeNumber = 3, iv = 12},
                    {name = "Morty", ids = {31}, badgeNumber = 4, iv = 12},
                    {name = "Chuck", ids = {34}, badgeNumber = 5, iv = 18},
                    {name = "Jasmine", ids = {33}, badgeNumber = 6, iv = 18},
                    {name = "Pryce", ids = {32}, badgeNumber = 7, iv = 18},
                    {name = "Clair", ids = {35}, badgeNumber = 8, iv = 24}
                }
            },
            {
                groupName = "Kanto Gyms",
                trainerType = TrainerData.TRAINER_TYPES.GYM_LEADERS,
                battles = {
                    {name = "Brock", ids = {253}, badgeNumber = 1, iv = 24},
                    {name = "Misty", ids = {254}, badgeNumber = 2, iv = 24},
                    {name = "Lt. Surge", ids = {255}, badgeNumber = 3, iv = 24},
                    {name = "Erika", ids = {256}, badgeNumber = 4, iv = 24},
                    {name = "Janine", ids = {257}, badgeNumber = 5, iv = 24},
                    {name = "Sabrina", ids = {258}, badgeNumber = 6, iv = 24},
                    {name = "Blaine", ids = {259}, badgeNumber = 7, iv = 24},
                    {name = "Blue", ids = {261}, badgeNumber = 8, iv = 30}
                }
            },
            {
                groupName = "Elite 4 / Bosses",
                trainerType = TrainerData.TRAINER_TYPES.STANDARD,
                battles = {
                    {name = "Will", ids = {245}, iv = 30},
                    {name = "Koga", ids = {247}, iv = 30},
                    {name = "Bruno", ids = {418}, iv = 30},
                    {name = "Karen", ids = {246}, iv = 30},
                    {name = "Lance", ids = {244}, iv = 30},
                    {name = "Red", ids = {260}, iv = 30},
                    {name = "Petrel", ids = {487}, iv = 12},
                    {name = "Archer", ids = {485}, iv = 24}
                }
            }
        }
    },
    --black
    [0x4F425249] = {
        LAB_IDS = {
            [64] = true
        },
        FINAL_FIGHT_ID = 232,
        IMPORTANT_GROUPS = {
            {
                groupName = "Bianca",
                trainerType = TrainerData.TRAINER_TYPES.RIVAL,
                battles = {
                    {location = "Lab", ids = {59, 60, 61}, iv = 0},
                    {location = "Route 2", ids = {498, 499, 500}, iv = 3},
                    {location = "After Burgh", ids = {507, 508, 509}, iv = 6},
                    {location = "After Clay", ids = {491, 492, 493}, iv = 12},
                    {location = "Pre Tubeline", ids = {494, 495, 496}, iv = 18}
                }
            },
            {
                groupName = "Cheren",
                trainerType = TrainerData.TRAINER_TYPES.RIVAL,
                battles = {
                    {location = "Lab", ids = {53, 54, 55}, iv = 0},
                    {location = "Striaton City", ids = {287, 288, 289}, iv = 3},
                    {location = "Route 3", ids = {56, 57, 58}, iv = 6},
                    {location = "After Burgh", ids = {403, 404, 405}, iv = 9},
                    {location = "After Elesa", ids = {90, 91, 92}, iv = 12},
                    {location = "Route 7", ids = {539, 540, 541}, iv = 24},
                    {location = "Route 10", ids = {588, 589, 590}, iv = 30}
                }
            },
            {
                groupName = "N",
                trainerType = TrainerData.TRAINER_TYPES.RIVAL,
                battles = {
                    {location = "Accumula Town", ids = {64}, iv = 6},
                    {location = "Nacrene City", ids = {65}, iv = 12},
                    {location = "Nimbasa City", ids = {89}, iv = 18},
                    {location = "Chargestone", ids = {218}, iv = 24},
                    {location = "N's Castle", ids = {587}, iv = 30}
                }
            },
            {
                groupName = "Gym Leaders",
                trainerType = TrainerData.TRAINER_TYPES.GYM_LEADERS,
                battles = {
                    --first gym is annoying, there are different gym leaders you fight based on starter choice
                    {
                        {name = "Chili", ids = {11}, badgeNumber = 1, iv = 0},
                        {name = "Cress", ids = {13}, badgeNumber = 1, iv = 0},
                        {name = "Cilan", ids = {12}, badgeNumber = 1, iv = 0}
                    },
                    {name = "Lenora", ids = {21}, badgeNumber = 2, iv = 6},
                    {name = "Burgh", ids = {22}, badgeNumber = 3, iv = 12},
                    {name = "Elesa", ids = {23}, badgeNumber = 4, iv = 12},
                    {name = "Clay", ids = {24}, badgeNumber = 5, iv = 12},
                    {name = "Skyla", ids = {25}, badgeNumber = 6, iv = 12},
                    {name = "Brycen", ids = {131}, badgeNumber = 7, iv = 18},
                    {name = "Drayden", ids = {133}, badgeNumber = 8, iv = 18}
                }
            },
            {
                groupName = "Elite 4",
                trainerType = TrainerData.TRAINER_TYPES.STANDARD,
                battles = {
                    {name = "Shauntal", ids = {228}, iv = 24},
                    {name = "Marshal", ids = {229}, iv = 24},
                    {name = "Grimsley", ids = {230}, iv = 24},
                    {name = "Caitlin", ids = {231}, iv = 24},
                    {name = "N", ids = {587}, iv = 30},
                    {name = "Ghetsis", ids = {232}, iv = 30}
                }
            }
        }
    },
    --white
    [0x4F415249] = {
        LAB_IDS = {
            [64] = true
        },
        FINAL_FIGHT_ID = 232,
        IMPORTANT_GROUPS = {
            {
                groupName = "Bianca",
                trainerType = TrainerData.TRAINER_TYPES.RIVAL,
                battles = {
                    {location = "Lab", ids = {59, 60, 61}, iv = 0},
                    {location = "Route 2", ids = {498, 499, 500}, iv = 3},
                    {location = "After Burgh", ids = {507, 508, 509}, iv = 6},
                    {location = "After Clay", ids = {491, 492, 493}, iv = 12},
                    {location = "Pre Tubeline", ids = {494, 495, 496}, iv = 18}
                }
            },
            {
                groupName = "Cheren",
                trainerType = TrainerData.TRAINER_TYPES.RIVAL,
                battles = {
                    {location = "Lab", ids = {53, 54, 55}, iv = 0},
                    {location = "Striaton City", ids = {287, 288, 289}, iv = 3},
                    {location = "Route 3", ids = {56, 57, 58}, iv = 6},
                    {location = "After Burgh", ids = {403, 404, 405}, iv = 9},
                    {location = "After Elesa", ids = {90, 91, 92}, iv = 12},
                    {location = "Route 7", ids = {539, 540, 541}, iv = 24},
                    {location = "Route 10", ids = {588, 589, 590}, iv = 30}
                }
            },
            {
                groupName = "N",
                trainerType = TrainerData.TRAINER_TYPES.RIVAL,
                battles = {
                    {location = "Accumula Town", ids = {64}, iv = 6},
                    {location = "Nacrene City", ids = {65}, iv = 12},
                    {location = "Nimbasa City", ids = {89}, iv = 18},
                    {location = "Chargestone", ids = {218}, iv = 24},
                    {location = "N's Castle", ids = {587}, iv = 30}
                }
            },
            {
                groupName = "Gym Leaders",
                trainerType = TrainerData.TRAINER_TYPES.GYM_LEADERS,
                battles = {
                    --first gym is annoying, there are different gym leaders you fight based on starter choice
                    {
                        {name = "Chili", ids = {11}, badgeNumber = 1, iv = 0},
                        {name = "Cress", ids = {13}, badgeNumber = 1, iv = 0},
                        {name = "Cilan", ids = {12}, badgeNumber = 1, iv = 0}
                    },
                    {name = "Lenora", ids = {21}, badgeNumber = 2, iv = 6},
                    {name = "Burgh", ids = {22}, badgeNumber = 3, iv = 12},
                    {name = "Elesa", ids = {23}, badgeNumber = 4, iv = 12},
                    {name = "Clay", ids = {24}, badgeNumber = 5, iv = 12},
                    {name = "Skyla", ids = {25}, badgeNumber = 6, iv = 12},
                    {name = "Brycen", ids = {131}, badgeNumber = 7, iv = 18},
                    {name = "Iris", ids = {132}, badgeNumber = 8, iv = 18}
                }
            },
            {
                groupName = "Elite 4",
                trainerType = TrainerData.TRAINER_TYPES.STANDARD,
                battles = {
                    {name = "Shauntal", ids = {228}, iv = 24},
                    {name = "Marshal", ids = {229}, iv = 24},
                    {name = "Grimsley", ids = {230}, iv = 24},
                    {name = "Caitlin", ids = {231}, iv = 24},
                    {name = "N", ids = {586}, iv = 30},
                    {name = "Ghetsis", ids = {232}, iv = 30}
                }
            }
        }
    },
    --black2/white2
    [0x4F455249] = {
        LAB_IDS = {
            [161] = true,
            [162] = true,
            [163] = true
        },
        FINAL_FIGHT_ID = 341,
        IMPORTANT_GROUPS = {
            {
                groupName = "Hugh",
                trainerType = TrainerData.TRAINER_TYPES.RIVAL,
                battles = {
                    {location = "Lab", ids = {161, 162, 163}, iv = 0},
                    {location = "Floccesy Ranch", ids = {166, 167, 168}, iv = 0},
                    {location = "Plasma Frigate", ids = {368, 369, 370}, iv = 30},
                    {location = "Undella Town", ids = {378, 379, 380}, iv = 12},
                    {location = "Victory Road", ids = {684, 685, 686}, iv = 24}
                }
            },
            {
                groupName = "Gym Leaders",
                trainerType = TrainerData.TRAINER_TYPES.GYM_LEADERS,
                battles = {
                    {name = "Cheren", ids = {156}, badgeNumber = 1, iv = 6},
                    {name = "Roxie", ids = {157}, badgeNumber = 2, iv = 6},
                    {name = "Burgh", ids = {154}, badgeNumber = 3, iv = 6},
                    {name = "Elesa", ids = {153}, badgeNumber = 4, iv = 12},
                    {name = "Clay", ids = {158}, badgeNumber = 5, iv = 12},
                    {name = "Skyla", ids = {155}, badgeNumber = 6, iv = 18},
                    {name = "Drayden", ids = {159}, badgeNumber = 7, iv = 18},
                    {name = "Marlon", ids = {160}, badgeNumber = 8, iv = 24}
                }
            },
            {
                groupName = "Elite 4",
                trainerType = TrainerData.TRAINER_TYPES.STANDARD,
                battles = {
                    {name = "Shauntal", ids = {38}, iv = 24},
                    {name = "Marshal", ids = {39}, iv = 24},
                    {name = "Grimsley", ids = {40}, iv = 24},
                    {name = "Caitlin", ids = {41}, iv = 24},
                    {name = "Iris", ids = {341}, iv = 30}
                }
            },
            {
                groupName = "Team Plasma",
                trainerType = TrainerData.TRAINER_TYPES.STANDARD,
                battles = {
                    {name = "Colres", ids = {344}, iv = 24},
                    {name = "Ghetsis", ids = {345}, iv = 24}
                }
            }
        }
    }
}

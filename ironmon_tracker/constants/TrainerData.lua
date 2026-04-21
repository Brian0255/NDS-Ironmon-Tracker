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
                groupNameLocalized = Localizations.TrainersGroupNames.barry,
                trainerType = TrainerData.TRAINER_TYPES.RIVAL,
                battles = {
                    {location = "Route 203", locationLocalized = Localizations.LocationsTrainersDPPt.route203, ids = {248, 249, 247}, iv = 3},
                    {location = "Hearthorne City", locationLocalized = Localizations.LocationsTrainersDPPt.hearthorneCity, ids = {471, 472, 470}, iv = 6},
                    {location = "Pastoria City", locationLocalized = Localizations.LocationsTrainersDPPt.pastoriaCity, ids = {474, 475, 473}, iv = 9},
                    {location = "Canalave City", locationLocalized = Localizations.LocationsTrainersDPPt.canalaveCity, ids = {477, 478, 476}, iv = 12},
                    {location = "Victory Road", locationLocalized = Localizations.LocationsTrainersDPPt.victoryRoad, ids = {480, 481, 479}, iv = 24}
                }
            },
            {
                groupName = "Gym Leaders",
                groupNameLocalized = Localizations.TrainersGroupNames.gymLeaders,
                trainerType = TrainerData.TRAINER_TYPES.GYM_LEADERS,
                battles = {
                    {name = "Roark", nameLocalized = Localizations.TrainersBattles.roark, ids = {246}, badgeNumber = 1, iv = 6},
                    {name = "Gardenia", nameLocalized = Localizations.TrainersBattles.gardenia, ids = {315}, badgeNumber = 2, iv = 6},
                    {name = "Maylene", nameLocalized = Localizations.TrainersBattles.maylene, ids = {317}, badgeNumber = 3, iv = 12},
                    {name = "Wake", nameLocalized = Localizations.TrainersBattles.wake, ids = {316}, badgeNumber = 4, iv = 12},
                    {name = "Fantina", nameLocalized = Localizations.TrainersBattles.fantina, ids = {318}, badgeNumber = 5, iv = 18},
                    {name = "Byron", nameLocalized = Localizations.TrainersBattles.byron, ids = {250}, badgeNumber = 6, iv = 18},
                    {name = "Candice", nameLocalized = Localizations.TrainersBattles.candice, ids = {319}, badgeNumber = 7, iv = 24},
                    {name = "Volkner", nameLocalized = Localizations.TrainersBattles.volkner, ids = {320}, badgeNumber = 8, iv = 24}
                }
            },
            {
                groupName = "Elite 4",
                groupNameLocalized = Localizations.TrainersGroupNames.elite4,
                trainerType = TrainerData.TRAINER_TYPES.STANDARD,
                battles = {
                    {name = "Aaron", nameLocalized = Localizations.TrainersBattles.aaron, ids = {261}, iv = 30},
                    {name = "Bertha", nameLocalized = Localizations.TrainersBattles.bertha, ids = {262}, iv = 30},
                    {name = "Flint", nameLocalized = Localizations.TrainersBattles.flint, ids = {263}, iv = 30},
                    {name = "Lucian", nameLocalized = Localizations.TrainersBattles.lucian, ids = {264}, iv = 30},
                    {name = "Cynthia", nameLocalized = Localizations.TrainersBattles.cynthia, ids = {267}, iv = 30}
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
                groupNameLocalized = Localizations.TrainersGroupNames.barry,
                trainerType = TrainerData.TRAINER_TYPES.RIVAL,
                battles = {
                    {location = "Lab", locationLocalized = Localizations.LocationsTrainersHGSS.lab, ids = {851, 852, 850}, iv = 0},
                    {location = "Route 203", locationLocalized = Localizations.LocationsTrainersDPPt.route203, ids = {248, 249, 247}, iv = 3},
                    {location = "Hearthorne City", locationLocalized = Localizations.LocationsTrainersDPPt.hearthorneCity, ids = {471, 472, 470}, iv = 6},
                    {location = "Pastoria City", locationLocalized = Localizations.LocationsTrainersDPPt.pastoriaCity, ids = {474, 475, 473}, iv = 9},
                    {location = "Canalave City", locationLocalized = Localizations.LocationsTrainersDPPt.canalaveCity, ids = {477, 478, 476}, iv = 12},
                    {location = "Victory Road", locationLocalized = Localizations.LocationsTrainersDPPt.victoryRoad, ids = {480, 481, 479}, iv = 24}
                }
            },
            {
                groupName = "Gym Leaders",
                groupNameLocalized = Localizations.TrainersGroupNames.gymLeaders,
                trainerType = TrainerData.TRAINER_TYPES.GYM_LEADERS,
                battles = {
                    {name = "Roark", nameLocalized = Localizations.TrainersBattles.roark, ids = {246}, badgeNumber = 1, iv = 6},
                    {name = "Gardenia", nameLocalized = Localizations.TrainersBattles.gardenia, ids = {315}, badgeNumber = 2, iv = 6},
                    {name = "Maylene", nameLocalized = Localizations.TrainersBattles.maylene, ids = {317}, badgeNumber = 3, iv = 12},
                    {name = "Wake", nameLocalized = Localizations.TrainersBattles.wake, ids = {316}, badgeNumber = 4, iv = 12},
                    {name = "Fantina", nameLocalized = Localizations.TrainersBattles.fantina, ids = {318}, badgeNumber = 5, iv = 18},
                    {name = "Byron", nameLocalized = Localizations.TrainersBattles.byron, ids = {250}, badgeNumber = 6, iv = 18},
                    {name = "Candice", nameLocalized = Localizations.TrainersBattles.candice, ids = {319}, badgeNumber = 7, iv = 24},
                    {name = "Volkner", nameLocalized = Localizations.TrainersBattles.volkner, ids = {320}, badgeNumber = 8, iv = 24}
                }
            },
            {
                groupName = "Elite 4",
                groupNameLocalized = Localizations.TrainersGroupNames.elite4,
                trainerType = TrainerData.TRAINER_TYPES.STANDARD,
                battles = {
                    {name = "Aaron", nameLocalized = Localizations.TrainersBattles.aaron, ids = {261}, iv = 30},
                    {name = "Bertha", nameLocalized = Localizations.TrainersBattles.bertha, ids = {262}, iv = 30},
                    {name = "Flint", nameLocalized = Localizations.TrainersBattles.flint, ids = {263}, iv = 30},
                    {name = "Lucian", nameLocalized = Localizations.TrainersBattles.lucian, ids = {264}, iv = 30},
                    {name = "Cynthia", nameLocalized = Localizations.TrainersBattles.cynthia, ids = {267}, iv = 30}
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
                groupNameLocalized = Localizations.TrainersGroupNames.silver,
                trainerType = TrainerData.TRAINER_TYPES.RIVAL,
                battles = {
                    {location = "Lab", locationLocalized = Localizations.LocationsTrainersHGSS.lab, ids = {496, 497, 495}, iv = 0},
                    {location = "Azalea Town", locationLocalized = Localizations.LocationsTrainersHGSS.azaleaTown, ids = {266, 269, 1}, iv = 3},
                    {location = "Burned Tower", locationLocalized = Localizations.LocationsTrainersHGSS.burnedTower, ids = {267, 270, 263}, iv = 6},
                    {location = "Goldenrod", locationLocalized = Localizations.LocationsTrainersHGSS.goldenrod, ids = {289, 271, 288}, iv = 14},
                    {location = "Victory Road", locationLocalized = Localizations.LocationsTrainersHGSS.victoryRoad, ids = {268, 272, 264}, iv = 19},
                    {location = "Mt. Moon", locationLocalized = Localizations.LocationsTrainersHGSS.mtMoon, ids = {286, 287, 285}, iv = 24}
                }
            },
            {
                groupName = "Johto Gyms",
                groupNameLocalized = Localizations.TrainersGroupNames.johtoGyms,
                trainerType = TrainerData.TRAINER_TYPES.GYM_LEADERS,
                battles = {
                    {name = "Falkner", nameLocalized = Localizations.TrainersBattles.falkner, ids = {20}, badgeNumber = 1, iv = 6},
                    {name = "Bugsy", nameLocalized = Localizations.TrainersBattles.bugsy, ids = {21}, badgeNumber = 2, iv = 9},
                    {name = "Whitney", nameLocalized = Localizations.TrainersBattles.whitney, ids = {30}, badgeNumber = 3, iv = 12},
                    {name = "Morty", nameLocalized = Localizations.TrainersBattles.morty, ids = {31}, badgeNumber = 4, iv = 12},
                    {name = "Chuck", nameLocalized = Localizations.TrainersBattles.chuck, ids = {34}, badgeNumber = 5, iv = 18},
                    {name = "Jasmine", nameLocalized = Localizations.TrainersBattles.jasmine, ids = {33}, badgeNumber = 6, iv = 18},
                    {name = "Pryce", nameLocalized = Localizations.TrainersBattles.pryce, ids = {32}, badgeNumber = 7, iv = 18},
                    {name = "Clair", nameLocalized = Localizations.TrainersBattles.clair, ids = {35}, badgeNumber = 8, iv = 24}
                }
            },
            {
                groupName = "Kanto Gyms",
                groupNameLocalized = Localizations.TrainersGroupNames.kantoGyms,
                trainerType = TrainerData.TRAINER_TYPES.GYM_LEADERS,
                battles = {
                    {name = "Brock", nameLocalized = Localizations.TrainersBattles.brock, ids = {253}, badgeNumber = 1, iv = 24},
                    {name = "Misty", nameLocalized = Localizations.TrainersBattles.misty, ids = {254}, badgeNumber = 2, iv = 24},
                    {name = "Lt. Surge", nameLocalized = Localizations.TrainersBattles.ltSurge, ids = {255}, badgeNumber = 3, iv = 24},
                    {name = "Erika", nameLocalized = Localizations.TrainersBattles.erika, ids = {256}, badgeNumber = 4, iv = 24},
                    {name = "Janine", nameLocalized = Localizations.TrainersBattles.janine, ids = {257}, badgeNumber = 5, iv = 24},
                    {name = "Sabrina", nameLocalized = Localizations.TrainersBattles.sabrina, ids = {258}, badgeNumber = 6, iv = 24},
                    {name = "Blaine", nameLocalized = Localizations.TrainersBattles.blaine, ids = {259}, badgeNumber = 7, iv = 24},
                    {name = "Blue", nameLocalized = Localizations.TrainersBattles.blue, ids = {261}, badgeNumber = 8, iv = 30}
                }
            },
            {
                groupName = "Elite 4 / Bosses",
                groupNameLocalized = Localizations.TrainersGroupNames.elite4Bosses,
                trainerType = TrainerData.TRAINER_TYPES.STANDARD,
                battles = {
                    {name = "Will", nameLocalized = Localizations.TrainersBattles.will, ids = {245}, iv = 30},
                    {name = "Koga", nameLocalized = Localizations.TrainersBattles.koga, ids = {247}, iv = 30},
                    {name = "Bruno", nameLocalized = Localizations.TrainersBattles.bruno, ids = {418}, iv = 30},
                    {name = "Karen", nameLocalized = Localizations.TrainersBattles.karen, ids = {246}, iv = 30},
                    {name = "Lance", nameLocalized = Localizations.TrainersBattles.lance, ids = {244}, iv = 30},
                    {name = "Red", nameLocalized = Localizations.TrainersBattles.red, ids = {260}, iv = 30},
                    {name = "Petrel", nameLocalized = Localizations.TrainersBattles.petrel, ids = {487}, iv = 12},
                    {name = "Archer", nameLocalized = Localizations.TrainersBattles.archer, ids = {485}, iv = 24}
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
                groupNameLocalized = Localizations.TrainersGroupNames.bianca,
                trainerType = TrainerData.TRAINER_TYPES.RIVAL,
                battles = {
                    {location = "Lab", locationLocalized = Localizations.LocationsTrainersBW.lab, ids = {59, 60, 61}, iv = 0},
                    {location = "Route 2", locationLocalized = Localizations.LocationsTrainersBW.route2, ids = {498, 499, 500}, iv = 3},
                    {location = "After Burgh", locationLocalized = Localizations.LocationsTrainersBW.afterBurgh, ids = {507, 508, 509}, iv = 6},
                    {location = "After Clay", locationLocalized = Localizations.LocationsTrainersBW.afterClay, ids = {491, 492, 493}, iv = 12},
                    {location = "Pre Tubeline", locationLocalized = Localizations.LocationsTrainersBW.preTubeline, ids = {494, 495, 496}, iv = 18}
                }
            },
            {
                groupName = "Cheren",
                groupNameLocalized = Localizations.TrainersGroupNames.cheren,
                trainerType = TrainerData.TRAINER_TYPES.RIVAL,
                battles = {
                    {location = "Lab", locationLocalized = Localizations.LocationsTrainersBW.lab, ids = {53, 54, 55}, iv = 0},
                    {location = "Striaton City", locationLocalized = Localizations.LocationsTrainersBW.striatonCity, ids = {287, 288, 289}, iv = 3},
                    {location = "Route 3", locationLocalized = Localizations.LocationsTrainersBW.route3, ids = {56, 57, 58}, iv = 6},
                    {location = "After Burgh", locationLocalized = Localizations.LocationsTrainersBW.afterBurgh, ids = {403, 404, 405}, iv = 9},
                    {location = "After Elesa", locationLocalized = Localizations.LocationsTrainersBW.afterElesa, ids = {90, 91, 92}, iv = 12},
                    {location = "Route 7", locationLocalized = Localizations.LocationsTrainersBW.route7, ids = {539, 540, 541}, iv = 24},
                    {location = "Route 10", locationLocalized = Localizations.LocationsTrainersBW.route10, ids = {588, 589, 590}, iv = 30}
                }
            },
            {
                groupName = "N",
                groupNameLocalized = Localizations.TrainersGroupNames.n,
                trainerType = TrainerData.TRAINER_TYPES.RIVAL,
                battles = {
                    {location = "Accumula Town", locationLocalized = Localizations.LocationsTrainersBW.accumulaTown, ids = {64}, iv = 6},
                    {location = "Nacrene City", locationLocalized = Localizations.LocationsTrainersBW.nacreneCity, ids = {65}, iv = 12},
                    {location = "Nimbasa City", locationLocalized = Localizations.LocationsTrainersBW.nimbasaCity, ids = {89}, iv = 18},
                    {location = "Chargestone", locationLocalized = Localizations.LocationsTrainersBW.chargeStone, ids = {218}, iv = 24},
                    {location = "N's Castle", locationLocalized = Localizations.LocationsTrainersBW.nCastle, ids = {587}, iv = 30}
                }
            },
            {
                groupName = "Gym Leaders",
                groupNameLocalized = Localizations.TrainersGroupNames.gymLeaders,
                trainerType = TrainerData.TRAINER_TYPES.GYM_LEADERS,
                battles = {
                    --first gym is annoying, there are different gym leaders you fight based on starter choice
                    {
                        {name = "Chili", nameLocalized = Localizations.TrainersBattles.chili, ids = {11}, badgeNumber = 1, iv = 0},
                        {name = "Cress", nameLocalized = Localizations.TrainersBattles.cress, ids = {13}, badgeNumber = 1, iv = 0},
                        {name = "Cilan", nameLocalized = Localizations.TrainersBattles.cilan, ids = {12}, badgeNumber = 1, iv = 0}
                    },
                    {name = "Lenora", nameLocalized = Localizations.TrainersBattles.lenora, ids = {21}, badgeNumber = 2, iv = 6},
                    {name = "Burgh", nameLocalized = Localizations.TrainersBattles.burgh, ids = {22}, badgeNumber = 3, iv = 12},
                    {name = "Elesa", nameLocalized = Localizations.TrainersBattles.elesa, ids = {23}, badgeNumber = 4, iv = 12},
                    {name = "Clay", nameLocalized = Localizations.TrainersBattles.clay, ids = {24}, badgeNumber = 5, iv = 12},
                    {name = "Skyla", nameLocalized = Localizations.TrainersBattles.skyla, ids = {25}, badgeNumber = 6, iv = 12},
                    {name = "Brycen", nameLocalized = Localizations.TrainersBattles.brycen, ids = {131}, badgeNumber = 7, iv = 18},
                    {name = "Drayden", nameLocalized = Localizations.TrainersBattles.drayden, ids = {133}, badgeNumber = 8, iv = 18}
                }
            },
            {
                groupName = "Elite 4",
                groupNameLocalized = Localizations.TrainersGroupNames.elite4,
                trainerType = TrainerData.TRAINER_TYPES.STANDARD,
                battles = {
                    {name = "Shauntal", nameLocalized = Localizations.TrainersBattles.shauntal, ids = {228}, iv = 24},
                    {name = "Marshal", nameLocalized = Localizations.TrainersBattles.marshal, ids = {229}, iv = 24},
                    {name = "Grimsley", nameLocalized = Localizations.TrainersBattles.grimsley, ids = {230}, iv = 24},
                    {name = "Caitlin", nameLocalized = Localizations.TrainersBattles.caitlin, ids = {231}, iv = 24},
                    {name = "N", nameLocalized = Localizations.TrainersBattles.n, ids = {587}, iv = 30},
                    {name = "Ghetsis", nameLocalized = Localizations.TrainersBattles.ghetsis, ids = {232}, iv = 30}
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
                groupNameLocalized = Localizations.TrainersGroupNames.bianca,
                trainerType = TrainerData.TRAINER_TYPES.RIVAL,
                battles = {
                    {location = "Lab", locationLocalized = Localizations.LocationsTrainersBW.lab, ids = {59, 60, 61}, iv = 0},
                    {location = "Route 2", locationLocalized = Localizations.LocationsTrainersBW.route2, ids = {498, 499, 500}, iv = 3},
                    {location = "After Burgh", locationLocalized = Localizations.LocationsTrainersBW.afterBurgh, ids = {507, 508, 509}, iv = 6},
                    {location = "After Clay", locationLocalized = Localizations.LocationsTrainersBW.afterClay, ids = {491, 492, 493}, iv = 12},
                    {location = "Pre Tubeline", locationLocalized = Localizations.LocationsTrainersBW.preTubeline, ids = {494, 495, 496}, iv = 18}
                }
            },
            {
                groupName = "Cheren",
                groupNameLocalized = Localizations.TrainersGroupNames.cheren,
                trainerType = TrainerData.TRAINER_TYPES.RIVAL,
                battles = {
                    {location = "Lab", locationLocalized = Localizations.LocationsTrainersBW.lab, ids = {53, 54, 55}, iv = 0},
                    {location = "Striaton City", locationLocalized = Localizations.LocationsTrainersBW.striatonCity,    ids = {287, 288, 289}, iv = 3},
                    {location = "Route 3", locationLocalized = Localizations.LocationsTrainersBW.route3, ids = {56, 57, 58}, iv = 6},
                    {location = "After Burgh", locationLocalized = Localizations.LocationsTrainersBW.afterBurgh, ids = {403, 404, 405}, iv = 9},
                    {location = "After Elesa", locationLocalized = Localizations.LocationsTrainersBW.afterElesa, ids = {90, 91, 92}, iv = 12},
                    {location = "Route 7", locationLocalized = Localizations.LocationsTrainersBW.route7, ids = {539, 540, 541}, iv = 24},
                    {location = "Route 10", locationLocalized = Localizations.LocationsTrainersBW.route10, ids = {588, 589, 590}, iv = 30}
                }
            },
            {  
                groupName = "N",
                groupNameLocalized = Localizations.TrainersGroupNames.n,
                trainerType = TrainerData.TRAINER_TYPES.RIVAL,
                battles = {
                    {location = "Accumula Town", locationLocalized = Localizations.LocationsTrainersBW.accumulaTown, ids = {64}, iv = 6},
                    {location = "Nacrene City", locationLocalized = Localizations.LocationsTrainersBW.nacreneCity, ids = {65}, iv = 12},
                    {location = "Nimbasa City", locationLocalized = Localizations.LocationsTrainersBW.nimbasaCity, ids = {89}, iv = 18},
                    {location = "Chargestone", locationLocalized = Localizations.LocationsTrainersBW.chargeStone, ids = {218}, iv = 24},
                    {location = "N's Castle", locationLocalized = Localizations.LocationsTrainersBW.nCastle, ids = {587}, iv = 30}
                }
            },
            {
                groupName = "Gym Leaders",
                groupNameLocalized = Localizations.TrainersGroupNames.gymLeaders,
                trainerType = TrainerData.TRAINER_TYPES.GYM_LEADERS,
                battles = {
                    --first gym is annoying, there are different gym leaders you fight based on starter choice
                    {
                        {name = "Chili", nameLocalized = Localizations.TrainersBattles.chili, ids = {11}, badgeNumber = 1, iv = 0},
                        {name = "Cress", nameLocalized = Localizations.TrainersBattles.cress, ids = {13}, badgeNumber = 1, iv = 0},
                        {name = "Cilan", nameLocalized = Localizations.TrainersBattles.cilan, ids = {12}, badgeNumber = 1, iv = 0}
                    },
                    {name = "Lenora", nameLocalized = Localizations.TrainersBattles.lenora, ids = {21}, badgeNumber = 2, iv = 6},
                    {name = "Burgh", nameLocalized = Localizations.TrainersBattles.burgh, ids = {22}, badgeNumber = 3, iv = 12},
                    {name = "Elesa", nameLocalized = Localizations.TrainersBattles.elesa, ids = {23}, badgeNumber = 4, iv = 12},
                    {name = "Clay", nameLocalized = Localizations.TrainersBattles.clay, ids = {24}, badgeNumber = 5, iv = 12},
                    {name = "Skyla", nameLocalized = Localizations.TrainersBattles.skyla, ids = {25}, badgeNumber = 6, iv = 12},
                    {name = "Brycen", nameLocalized = Localizations.TrainersBattles.brycen, ids = {131}, badgeNumber = 7, iv = 18},
                    {name = "Iris", nameLocalized = Localizations.TrainersBattles.iris, ids = {132}, badgeNumber = 8, iv = 18}
                }
            },
            {
                groupName = "Elite 4",
                groupNameLocalized = Localizations.TrainersGroupNames.elite4,
                trainerType = TrainerData.TRAINER_TYPES.STANDARD,
                battles = {
                    {name = "Shauntal", nameLocalized = Localizations.TrainersBattles.shauntal, ids = {228}, iv = 24},
                    {name = "Marshal", nameLocalized = Localizations.TrainersBattles.marshal, ids = {229}, iv = 24},
                    {name = "Grimsley", nameLocalized = Localizations.TrainersBattles.grimsley, ids = {230}, iv = 24},
                    {name = "Caitlin", nameLocalized = Localizations.TrainersBattles.caitlin, ids = {231}, iv = 24},
                    {name = "N", nameLocalized = Localizations.TrainersBattles.n, ids = {586}, iv = 30},
                    {name = "Ghetsis", nameLocalized = Localizations.TrainersBattles.ghetsis, ids = {232}, iv = 30}
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
                groupNameLocalized = Localizations.TrainersGroupNames.hugh,
                trainerType = TrainerData.TRAINER_TYPES.RIVAL,
                battles = {
                    {location = "Lab", locationLocalized = Localizations.LocationsTrainersBW2.lab, ids = {161, 162, 163}, iv = 0},
                    {location = "Floccesy Ranch", locationLocalized = Localizations.LocationsTrainersBW2.floccessyRanch, ids = {166, 167, 168}, iv = 0},
                    {location = "Plasma Frigate", locationLocalized = Localizations.LocationsTrainersBW2.plasmaFrigate, ids = {368, 369, 370}, iv = 30},
                    {location = "Undella Town", locationLocalized = Localizations.LocationsTrainersBW2.undellaTown, ids = {378, 379, 380}, iv = 12},
                    {location = "Victory Road", locationLocalized = Localizations.LocationsTrainersBW2.victoryRoad, ids = {684, 685, 686}, iv = 24}
                }
            },
            {
                groupName = "Gym Leaders",
                groupNameLocalized = Localizations.TrainersGroupNames.gymLeaders,
                trainerType = TrainerData.TRAINER_TYPES.GYM_LEADERS,
                battles = {
                    {name = "Cheren", nameLocalized = Localizations.TrainersBattles.cheren, ids = {156}, badgeNumber = 1, iv = 6},
                    {name = "Roxie", nameLocalized = Localizations.TrainersBattles.roxie, ids = {157}, badgeNumber = 2, iv = 6},
                    {name = "Burgh", nameLocalized = Localizations.TrainersBattles.burgh, ids = {154}, badgeNumber = 3, iv = 6},
                    {name = "Elesa", nameLocalized = Localizations.TrainersBattles.elesa, ids = {153}, badgeNumber = 4, iv = 12},
                    {name = "Clay", nameLocalized = Localizations.TrainersBattles.clay, ids = {158}, badgeNumber = 5, iv = 12},
                    {name = "Skyla", nameLocalized = Localizations.TrainersBattles.skyla, ids = {155}, badgeNumber = 6, iv = 18},
                    {name = "Drayden", nameLocalized = Localizations.TrainersBattles.drayden, ids = {159}, badgeNumber = 7, iv = 18},
                    {name = "Marlon", nameLocalized = Localizations.TrainersBattles.marlon, ids = {160}, badgeNumber = 8, iv = 24}
                }
            },
            {
                groupName = "Elite 4",
                groupNameLocalized = Localizations.TrainersGroupNames.elite4,
                trainerType = TrainerData.TRAINER_TYPES.STANDARD,
                battles = {
                    {name = "Shauntal", nameLocalized = Localizations.TrainersBattles.shauntal, ids = {38}, iv = 24},
                    {name = "Marshal", nameLocalized = Localizations.TrainersBattles.marshal, ids = {39}, iv = 24},
                    {name = "Grimsley", nameLocalized = Localizations.TrainersBattles.grimsley, ids = {40}, iv = 24},
                    {name = "Caitlin", nameLocalized = Localizations.TrainersBattles.caitlin, ids = {41}, iv = 24},
                    {name = "Iris", nameLocalized = Localizations.TrainersBattles.iris, ids = {341}, iv = 30}
                }
            },
            {
                groupName = "Team Plasma",
                groupNameLocalized = Localizations.TrainersGroupNames.teamPlasma,
                trainerType = TrainerData.TRAINER_TYPES.STANDARD,
                battles = {
                    {name = "Colres", nameLocalized = Localizations.TrainersBattles.colres, ids = {344}, iv = 24},
                    {name = "Ghetsis", nameLocalized = Localizations.TrainersBattles.ghetsis, ids = {345}, iv = 24}
                }
            }
        }
    }
}

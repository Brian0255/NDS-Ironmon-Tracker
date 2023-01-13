TrainerData = {}

TrainerData.TRAINER_TYPES = {
    STANDARD = 0,
    RIVAL = 1
}

TrainerData.TRAINERS = {
    --black
    [0x4F425249] = {
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
                trainerType = TrainerData.TRAINER_TYPES.STANDARD,
                battles = {
                    --first gym is annoying, there are different gym leaders you fight based on starter choice
                    {
                        {name = "Chili", ids = {11}, badgeNumber = 1, iv = 0},
                        {name = "Cilan", ids = {12}, badgeNumber = 1, iv = 0},
                        {name = "Cress", ids = {13}, badgeNumber = 1, iv = 0}
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
    }
}

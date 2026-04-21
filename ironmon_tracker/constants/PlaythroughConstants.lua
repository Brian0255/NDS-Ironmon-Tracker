PlaythroughConstants = {}

PlaythroughConstants.PROGRESS = {
    NOWHERE = 0,
    PAST_LAB = 1,
    WON = 2
}

PlaythroughConstants.EMPTY_PAST_RUN_STATISTICS = {
    {
        Localizations.Playthrough.overallProgress,
        {
            {"Past Lab", 0},
            {"1 Badge", 0},
            {"2 Badges", 0},
            {"3 Badges", 0},
            {"4 Badges", 0},
            {"5 Badges", 0},
            {"6 Badges", 0},
            {"7 Badges", 0},
            {"8 Badges", 0},
            {"Won", 0}
        }
    },
    {
        "BST Ranges You Ran",
        {
            {"< 300", 0},
            {"300 - 399", 0},
            {"400 - 499", 0},
            {"500+", 0}
        }
    },
    {
        "BST Ranges You Lost to",
        {
            {"< 300", 0},
            {"300 - 399", 0},
            {"400 - 499", 0},
            {"500+", 0}
        }
    },
    {
        "Types You Ran",
        {}
    },
    {
        "Types You Lost to",
        {}
    },
    {
        "Pok" .. Chars.accentedE .. "mon You Ran",
        {}
    },
    {
        "Pok" .. Chars.accentedE .. "mon You Lost to",
        {}
    },
    {
        "Moves You Had",
        {}
    },
    {
        "Moves Your Enemies Had",
        {}
    },
    {
        "Abilities You Had",
        {}
    },
    {
        "Abilities You Lost to",
        {}
    }
}

PlaythroughConstants.CAUSES = {
    STANDARD = 0,
    WON = 1,
    SHEDINJA = 2,
    IMPOSTER = 3,
    ENEMY_LOWER_BST = 4,
}

PlaythroughConstants.FAINT_DETECTIONS = {
    ON_FIRST_SLOT_FAINT = 0,
    ON_HIGHEST_LEVEL_FAINT = 1,
    ON_ENTIRE_PARTY_FAINT = 2
}

--in case the death quotes file is nil or something dumb like that
PlaythroughConstants.DEFAULT_STANDARD_MESSAGES = {
    Localizations.Playthrough.thereIsAlwaysNextTime,
    Localizations.Playthrough.someThingsWereJustNotMeantToBe,
    Localizations.Playthrough.ohWell,
    Localizations.Playthrough.couldHaveBeenWorse,
    Localizations.Playthrough.againstAllOddsYouDidNotTriumph,
    Localizations.Playthrough.howUnfortunate,
    Localizations.Playthrough.thatIsJustTheWayItGoesSometimes,
    Localizations.Playthrough.youShouldDefinitelyPickTheLeftBallNextAttempt,
    Localizations.Playthrough.havingFunYet,
    Localizations.Playthrough.theHouseAlwaysWins,
    Localizations.Playthrough.anythingThatCanGoWrongWillGoWrong,
    Localizations.Playthrough.looksLikeYourLuckFinallyRanOut
}

PlaythroughConstants.RUN_OVER_MESSAGES = {
    [PlaythroughConstants.CAUSES.WON] = {
        exclusive = true,
        messages = {
            Localizations.Playthrough.congratulations,
            Localizations.Playthrough.myGodYouActuallyDidIt,
            Localizations.Playthrough.imSpeechless,
            Localizations.Playthrough.theEndOfALongArduousJourney,
            Localizations.Playthrough.onThisDayThePlanetsAligned
        }
    },
    [PlaythroughConstants.CAUSES.STANDARD] = {
        messages = {}
    },
    [PlaythroughConstants.CAUSES.IMPOSTER] = {
        exclusive = true,
        messages = {
            Localizations.Playthrough.sometimesYouJustCantFaceYourself,
            Localizations.Playthrough.lookingInTheMirrorReallyIsThatPainful,
            Localizations.Playthrough.darkLinkWasALotEasierThanThis,
            Localizations.Playthrough.doesThisMeanWeCanBanItNow
        }
    },
    [PlaythroughConstants.CAUSES.ENEMY_LOWER_BST] = {
        exclusive = true,
        messages = {
            Localizations.Playthrough.sometimesTheWeakerTriumph,
            Localizations.Playthrough.aSurprisingOutcome,
            Localizations.Playthrough.miraclesReallyCanHappen,
            Localizations.Playthrough.iDontThinkAnyoneSawThatComing,
            Localizations.Playthrough.huh,
            Localizations.Playthrough.surelyThatPokemonHadHugePower
        }
    },
    [PlaythroughConstants.CAUSES.SHEDINJA] = {
        exclusive = true,
        messages = {
            Localizations.Playthrough.neverFeelsGoodToLoseToThat,
            Localizations.Playthrough.thereAreOver20FireMovesInTheGameAndYouDidntRollASingleOne,
            Localizations.Playthrough.itWasBoundToHappenAtSomePoint,
            Localizations.Playthrough.theOnePokemonYouDidntWantToSee
        }
    }
}

function PlaythroughConstants.initializeStandardMessages()
    local quotesFile = Paths.CURRENT_DIRECTORY..Paths.SLASH.."death_quotes.txt"
    PlaythroughConstants.RUN_OVER_MESSAGES[PlaythroughConstants.CAUSES.STANDARD].messages =
        MiscUtils.shallowCopy(PlaythroughConstants.DEFAULT_STANDARD_MESSAGES)

    local newMessages = {}
    local currentIndex = 1
    if FormsUtils.fileExists(quotesFile) then
        newMessages = MiscUtils.readLinesFromFile(quotesFile)
    end
    if newMessages[1] ~= nil then
        PlaythroughConstants.RUN_OVER_MESSAGES[PlaythroughConstants.CAUSES.STANDARD].messages = newMessages
    end
end

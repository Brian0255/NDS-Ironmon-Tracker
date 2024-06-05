local function UpdaterScreen(initialSettings, initialTracker, initialProgram)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local FrameCounter = dofile(Paths.FOLDERS.DATA_FOLDER.."/FrameCounter.lua")
    local settings = initialSettings
    local tracker = initialTracker
    local program = initialProgram
    local constants = {
        MAIN_HEIGHT_UPDATE_AVAILABLE = 114,
        MAIN_HEIGHT_NO_UPDATE = 112,
        MAIN_TEXT_LABEL_HEIGHT = 14,
        GO_BACK_FRAME_HEIGHT = 24,
        BUTTON_HEIGHT = 16,
        RELEASE_NOTES_BUTTON_WIDTH = 86,
        INSTALL_IGNORE_BUTTON_WIDTH = 38,
        INSTALL_IGNORE_BUTTON_HEIGHT = 16,
        MAIN_BUTTONS_FRAME_HEIGHT = 26,
        UPDATE_INFO_HEIGHT_NO_UPDATE = 60,
        UPDATE_INFO_HEIGHT_UPDATE = 86
    }
    local errored = false
    local newestVersionString = ""
    local ui = {}
    local frameCounters = {}
    local eventListeners = {}
    local self = {}


    local function reset()
        ui.controls.ignoreButton.setVisibility(true)
        ui.controls.installButton.setVisibility(true)
        ui.controls.releaseNotesButton.setVisibility(true)
        ui.frames.updateInfoFrame.setLayoutPadding({x=26,y=5})
        self.setAsUpdateAvailable(newestVersionString)
    end

    local function onGoBackClick()
        if not errored then
            program.setCurrentScreens({program.UI_SCREENS.MAIN_OPTIONS_SCREEN})
            program.drawCurrentScreens()
        else
            reset()
        end
    end

    local function restartTracker()
        IronmonTracker.startTracker()
        frameCounters["trackerRestart"] = nil
    end

    local function onOpenReleaseNotesClick()
        local releaseNotesURL = "https://github.com/Brian0255/NDS-Ironmon-Tracker/releases/latest"
        os.execute(string.format('start "" "%s"', releaseNotesURL))
    end

    local function finalizeUpdate(success)
        -- Remove the frame counters so they won't trigger again
        frameCounters["trackerUpdatePrepare"] = nil
        frameCounters["trackerUpdateTryInstall"] = nil

        -- Then display a success or fail message on screen
        if success then
            settings.automaticUpdates.UPDATE_WAS_DONE = true
            program.saveSettings()
            ui.controls.topTextLabel1.setText("Update successful! The Tracker")
            ui.controls.topTextLabel2.setText("will now restart in 3 seconds.")
            frameCounters["trackerRestart"] = FrameCounter(200, restartTracker, nil, true)
        else
            ui.frames.mainFrame.resize({width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = constants.MAIN_HEIGHT_NO_UPDATE})
            ui.frames.updateInfoFrame.resize({width = Graphics.SIZES.MAIN_SCREEN_WIDTH-2*Graphics.SIZES.BORDER_MARGIN, height = constants.UPDATE_INFO_HEIGHT_NO_UPDATE})
            ui.controls.topTextLabel1.setText("Error updating, please try again.")
            ui.controls.topTextLabel2.setText("")
            ui.frames.goBackFrame.setVisibility(true)
            errored = true
        end
        program.drawCurrentScreens()
    end

    local function onInstallClick()
        ui.controls.ignoreButton.setVisibility(false)
        ui.controls.installButton.setVisibility(false)
        ui.controls.releaseNotesButton.setVisibility(false)
        ui.frames.updateInfoFrame.setLayoutPadding({x=4,y=3})
        ui.controls.topTextLabel1.setText("Installing update, please wait...")
        ui.controls.topTextLabel2.setText("Do not close the tracker.")
        program.drawCurrentScreens()

        -- Setup delayed function calls to properly clear image caches, then update later when safe
        frameCounters["trackerUpdatePrepare"] = FrameCounter(50, program.prepareForUpdate, nil, true)
        frameCounters["trackerUpdateTryInstall"] = FrameCounter(120, program.tryToInstallUpdate, finalizeUpdate, true)
    end

    local function onIgnoreClick()
        program.setCurrentScreens({program.UI_SCREENS.MAIN_SCREEN})
        program.drawCurrentScreens()
    end

    local function initTextControls()
        ui.controls.topTextLabel1 =
            TextLabel(
            Component(
                ui.frames.updateInfoFrame,
                Box({x = 0, y = 0}, {width = 40, height = constants.MAIN_TEXT_LABEL_HEIGHT})
            ),
            TextField(
                "No update available.",
                {x = 0, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls.topTextLabel2 =
            TextLabel(
            Component(
                ui.frames.updateInfoFrame,
                Box({x = 0, y = 0}, {width = 40, height = constants.MAIN_TEXT_LABEL_HEIGHT + 2})
            ),
            TextField(
                "Current version: " .. MiscConstants.TRACKER_VERSION,
                {x = 0, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
    end

    local function initMainButtons()
        ui.frames.installIgnoreFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.BORDER_MARGIN, y = Graphics.SIZES.BORDER_MARGIN},
                {
                    width = 0,
                    height = constants.MAIN_BUTTONS_FRAME_HEIGHT
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 10, {x = 0, y = 2}),
            ui.frames.updateInfoFrame
        )
        ui.controls.releaseNotesButton =
            TextLabel(
            Component(
                ui.frames.updateInfoFrame,
                Box(
                    {x = 0, y = 0},
                    {width = constants.RELEASE_NOTES_BUTTON_WIDTH, height = constants.BUTTON_HEIGHT},
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            TextField(
                "View Release Notes",
                {x = 3, y = 2},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls.ignoreButton =
            TextLabel(
            Component(
                ui.frames.installIgnoreFrame,
                Box(
                    {x = 0, y = 0},
                    {width = constants.INSTALL_IGNORE_BUTTON_WIDTH, height = constants.BUTTON_HEIGHT},
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            TextField(
                "Ignore",
                {x = 5, y = 3},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls.installButton =
            TextLabel(
            Component(
                ui.frames.installIgnoreFrame,
                Box(
                    {x = 0, y = 0},
                    {width = constants.INSTALL_IGNORE_BUTTON_WIDTH, height = constants.BUTTON_HEIGHT},
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            TextField(
                "Install",
                {x = 6, y = 3},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
    end

    local function initUI()
        ui.controls = {}
        ui.frames = {}
        ui.frames.mainFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = constants.MAIN_HEIGHT},
                "Main background color",
                nil
            ),
            Layout(
                Graphics.ALIGNMENT_TYPE.VERTICAL,
                0,
                {x = Graphics.SIZES.BORDER_MARGIN, y = Graphics.SIZES.BORDER_MARGIN}
            ),
            nil
        )
        ui.controls.topHeading =
            TextLabel(
            Component(
                ui.frames.mainFrame,
                Box(
                    {x = 5, y = 5},
                    {width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN, height = 18},
                    "Top box background color",
                    "Top box border color",
                    false
                )
            ),
            TextField(
                "Tracker Updates",
                {x = 25, y = 1},
                TextStyle(13, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        ui.frames.updateInfoFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.BORDER_MARGIN, y = Graphics.SIZES.BORDER_MARGIN},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.UPDATE_INFO_HEIGHT_UPDATE
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 26, y = 5}),
            ui.frames.mainFrame
        )
        initTextControls()
        initMainButtons()
        ui.frames.goBackFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.GO_BACK_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 95, y = 5}),
            ui.frames.mainFrame
        )
        ui.controls.goBackButton =
            TextLabel(
            Component(
                ui.frames.goBackFrame,
                Box(
                    {x = 0, y = 0},
                    {width = 40, height = 14},
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            TextField(
                "Go back",
                {x = 3, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        table.insert(eventListeners, MouseClickEventListener(ui.controls.goBackButton, onGoBackClick))
        table.insert(eventListeners, MouseClickEventListener(ui.controls.installButton, onInstallClick))
        table.insert(eventListeners, MouseClickEventListener(ui.controls.ignoreButton, onIgnoreClick))
        table.insert(eventListeners, MouseClickEventListener(ui.controls.releaseNotesButton, onOpenReleaseNotesClick))
    end

    function self.setAsNoUpdate()
        errored = false
        ui.controls.topTextLabel1.setText("No update available.")
        ui.controls.topTextLabel2.setText("Current version: " .. MiscConstants.TRACKER_VERSION)
        ui.frames.installIgnoreFrame.setVisibility(false)
        ui.frames.goBackFrame.setVisibility(true)
        ui.frames.mainFrame.resize({width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = constants.MAIN_HEIGHT_NO_UPDATE})
        ui.frames.updateInfoFrame.resize(
            {
                width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                height = constants.UPDATE_INFO_HEIGHT_NO_UPDATE
            }
        )
    end

    function self.setAsUpdateAvailable(newVersion)
        newestVersionString = newVersion
        errored = false
        ui.controls.topTextLabel1.setText("New update available!")
        ui.controls.topTextLabel2.setText("Latest version: " .. newVersion)
        ui.frames.installIgnoreFrame.setVisibility(true)
        ui.frames.goBackFrame.setVisibility(false)
        ui.frames.mainFrame.resize(
            {width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = constants.MAIN_HEIGHT_UPDATE_AVAILABLE}
        )
        ui.frames.updateInfoFrame.resize(
            {
                width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                height = constants.UPDATE_INFO_HEIGHT_UPDATE
            }
        )
    end

    function self.runEventListeners()
        for _, eventListener in pairs(eventListeners) do
            eventListener.listen()
        end
        for _, counter in pairs(frameCounters) do
            counter.decrement()
        end
    end

    function self.show()
        ui.frames.mainFrame.show()
    end

    initUI()

    return self
end

return UpdaterScreen

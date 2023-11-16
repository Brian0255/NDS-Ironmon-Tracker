local function TrackerSetupScreen(initialSettings, initialTracker, initialProgram)
    local Frame = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Frame.lua")
    local Box = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Box.lua")
    local Component = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Component.lua")
    local TextLabel = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextLabel.lua")
    local TextField = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextField.lua")
    local TextStyle = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/TextStyle.lua")
    local Layout = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/Layout.lua")
    local MouseClickEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/MouseClickEventListener.lua")
    local JoypadEventListener = dofile(Paths.FOLDERS.UI_BASE_CLASSES .. "/JoypadEventListener.lua")
    local settings = initialSettings
    local tracker = initialTracker
    local program = initialProgram
    local currentButtonWaiting = {
        button = nil,
        settingKey = nil,
        previousText = ""
    }
    local constants = {
        ORDERED_CONTROL_KEYS = {
            "CHANGE_VIEW",
            "CYCLE_STAT",
            "CYCLE_PREDICTION",
            "LOCK_ENEMY"
        },
        MAIN_FRAME_HEIGHT = 211,
        CONTROL_EDIT_FRAME_HEIGHT = 159,
        TEXT_HEADER_HEIGHT = 18,
        BIND_BUTTON_FRAME_HEIGHT = 14,
        LOAD_NEXT_FRAME_HEIGHT = 54,
        CONTROL_LABEL_WIDTH = 64,
        CONTROL_VALUE_WIDTH = 26,
        BIND_BUTTON_WIDTH = 30,
        BIND_BUTTON_HEIGHT = 14,
        ADD_BUTTON_WIDTH = 54,
        CLEAR_BUTTON_WIDTH = 32
    }
    local ui = {}
    local eventListeners = {}
    local self = {}

    local function onJoypadPress(params)
        if eventListeners["currentButtonWaiter"] == nil then
            return
        end
        local button = params.button
        local settingToChange = params.settingToChange
        local additive = params.additive
        if not additive then
            settings.controls[settingToChange] = button
        else
            local combo = settings.controls[settingToChange]
            if combo == nil or combo == "" then
                settings.controls[settingToChange] = button
            else
                local buttons = MiscUtils.split(combo, " ")
                if not MiscUtils.tableContains(buttons, button) then
                    settings.controls[settingToChange] = combo .. " " .. button
                end
            end
        end
        eventListeners["currentButtonWaiter"] = nil
        ui.controls[settingToChange .. "Value"].setText(settings.controls[settingToChange]:gsub(" ", "   "))
        currentButtonWaiting.button.setText(currentButtonWaiting.previousText)
        currentButtonWaiting.button = nil
        program.saveSettings()
        program.drawCurrentScreens()
    end

    local function onGoBackClick()
        program.setCurrentScreens({program.UI_SCREENS.MAIN_OPTIONS_SCREEN})
        program.drawCurrentScreens()
    end

    local function onBindButtonClick(controlName)
        if currentButtonWaiting.button ~= nil then
            currentButtonWaiting.button.setText(currentButtonWaiting.previousText)
        end
        ui.controls[controlName .. "BindButton"].setText("  ...")
        program.drawCurrentScreens()
        eventListeners["currentButtonWaiter"] =
            JoypadEventListener(settings, "ANY", onJoypadPress, {settingToChange = controlName, additive = false})
        currentButtonWaiting.button = ui.controls[controlName .. "BindButton"]
        currentButtonWaiting.previousText = "Bind"
        currentButtonWaiting.settingKey = controlName
    end

    local function onAddButtonClick()
        if currentButtonWaiting.button ~= nil then
            currentButtonWaiting.button.setText(currentButtonWaiting.previousText)
        end
        ui.controls.nextSeedAddButton.setText("        ...")
        program.drawCurrentScreens()
        eventListeners["currentButtonWaiter"] =
            JoypadEventListener(settings, "ANY", onJoypadPress, {settingToChange = "LOAD_NEXT_SEED", additive = true})
        currentButtonWaiting.button = ui.controls.nextSeedAddButton
        currentButtonWaiting.previousText = "Add button"
        currentButtonWaiting.settingKey = "LOAD_NEXT_SEED"
    end

    local function onClearNextSeedCombo()
        settings.controls.LOAD_NEXT_SEED = ""
        ui.controls.LOAD_NEXT_SEEDValue.setText("")
        program.drawCurrentScreens()
    end

    local function onGeneralClick()
        --basically a click anywhere to undo the binding action
        if eventListeners["currentButtonWaiter"] then
            eventListeners["currentButtonWaiter"] = nil
            currentButtonWaiting.button.setText(currentButtonWaiting.previousText)
            currentButtonWaiting.button = nil
            program.drawCurrentScreens()
        end
    end

    local function createButtonBindingRow(parentFrame, controlName)
        local bindFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN, y = 0},
                {width = 0, height = constants.BIND_BUTTON_FRAME_HEIGHT},
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, Graphics.SIZES.BORDER_MARGIN, {x = 5, y = 0}),
            parentFrame
        )
        local settingNameLabel =
            TextLabel(
            Component(
                bindFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.CONTROL_LABEL_WIDTH,
                        height = constants.BIND_BUTTON_HEIGHT
                    },
                    nil,
                    nil,
                    false
                )
            ),
            TextField(
                controlName:sub(1, 1) .. controlName:sub(2):lower():gsub("_", " ") .. ":",
                {x = 0, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls[controlName .. "Value"] =
            TextLabel(
            Component(
                bindFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.CONTROL_VALUE_WIDTH,
                        height = constants.BIND_BUTTON_HEIGHT
                    },
                    nil,
                    nil,
                    false
                )
            ),
            TextField(
                settings.controls[controlName],
                {x = 0, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls[controlName .. "BindButton"] =
            TextLabel(
            Component(
                bindFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.BIND_BUTTON_WIDTH,
                        height = constants.BIND_BUTTON_HEIGHT
                    },
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            TextField(
                "Bind",
                {x = 5, y = 2},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        table.insert(
            eventListeners,
            MouseClickEventListener(ui.controls[controlName .. "BindButton"], onBindButtonClick, controlName)
        )
    end

    local function initControlEditingUI()
        ui.frames.controlEditFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.CONTROL_EDIT_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, Graphics.SIZES.BORDER_MARGIN, {x = 0, y = Graphics.SIZES.BORDER_MARGIN}),
            ui.frames.mainFrame
        )
        table.insert(eventListeners, MouseClickEventListener(ui.frames.controlEditFrame, onGeneralClick))
        for _, settingKey in pairs(constants.ORDERED_CONTROL_KEYS) do
            if settingKey ~= "LOAD_NEXT_SEED" then
                createButtonBindingRow(ui.frames.controlEditFrame, settingKey)
            end
        end
        local loadNextSeedFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = constants.LOAD_NEXT_FRAME_HEIGHT
                },
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = 5, y = 5}),
            ui.frames.controlEditFrame
        )
        ui.controls.loadNextSeedLabel =
            TextLabel(
            Component(
                loadNextSeedFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.CONTROL_VALUE_WIDTH,
                        height = constants.BIND_BUTTON_HEIGHT
                    },
                    nil,
                    nil,
                    false
                )
            ),
            TextField(
                "Start New Run:",
                {x = 0, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.controls["LOAD_NEXT_SEEDValue"] =
            TextLabel(
            Component(
                loadNextSeedFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.CONTROL_VALUE_WIDTH,
                        height = constants.BIND_BUTTON_HEIGHT + 2
                    },
                    nil,
                    nil,
                    false
                )
            ),
            TextField(
                settings.controls.LOAD_NEXT_SEED:gsub(" ", "   "),
                {x = 0, y = 1},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        ui.frames.nextSeedAddClearFrame =
            Frame(
            Box({x = 0, y = 0}, {width = 30, height = 30}, nil, nil),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 5, {x = 0, y = 0}),
            loadNextSeedFrame
        )
        ui.controls.nextSeedAddButton =
            TextLabel(
            Component(
                ui.frames.nextSeedAddClearFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.ADD_BUTTON_WIDTH,
                        height = constants.BIND_BUTTON_HEIGHT
                    },
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            TextField(
                "Add button",
                {x = 5, y = 2},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        table.insert(eventListeners, MouseClickEventListener(ui.controls.nextSeedAddButton, onAddButtonClick))
        local clearButton =
            TextLabel(
            Component(
                ui.frames.nextSeedAddClearFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = constants.CLEAR_BUTTON_WIDTH,
                        height = constants.BIND_BUTTON_HEIGHT
                    },
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            TextField(
                "Clear",
                {x = 5, y = 2},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        table.insert(eventListeners, MouseClickEventListener(clearButton, onClearNextSeedCombo))
    end

    local function initFavoritesEditingButton()
        local favoritesFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 10, height = 24},
                "Top box background color",
                "Top box border color"
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 5, y = 5}),
            ui.frames.mainFrame
        )
        local favoritesButton =
            TextLabel(
            Component(
                favoritesFrame,
                Box(
                    {x = 0, y = 0},
                    {
                        width = 64,
                        height = constants.BIND_BUTTON_HEIGHT
                    },
                    "Top box background color",
                    "Top box border color",
                    true,
                    "Top box background color"
                )
            ),
            TextField(
                "Edit Favorites",
                {x = 5, y = 2},
                TextStyle(
                    Graphics.FONT.DEFAULT_FONT_SIZE,
                    Graphics.FONT.DEFAULT_FONT_FAMILY,
                    "Top box text color",
                    "Top box background color"
                )
            )
        )
        table.insert(
            eventListeners,
            MouseClickEventListener(favoritesButton, program.openScreen, program.UI_SCREENS.TITLE_SCREEN)
        )
    end

    local function initUI()
        ui.controls = {}
        ui.frames = {}
        ui.frames.mainFrame =
            Frame(
            Box(
                {x = Graphics.SIZES.SCREEN_WIDTH, y = 0},
                {width = Graphics.SIZES.MAIN_SCREEN_WIDTH, height = constants.MAIN_FRAME_HEIGHT},
                "Main background color",
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.VERTICAL, 0, {x = Graphics.SIZES.BORDER_MARGIN, y = Graphics.SIZES.BORDER_MARGIN}),
            nil
        )
        ui.controls.mainHeading =
            TextLabel(
            Component(
                ui.frames.mainFrame,
                Box(
                    {x = 5, y = 5},
                    {
                        width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                        height = constants.TEXT_HEADER_HEIGHT
                    },
                    "Top box background color",
                    "Top box border color",
                    false
                )
            ),
            TextField(
                "Tracker Setup",
                {x = 30, y = 1},
                TextStyle(13, Graphics.FONT.DEFAULT_FONT_FAMILY, "Top box text color", "Top box background color")
            )
        )
        initFavoritesEditingButton()
        initControlEditingUI()
        ui.frames.goBackFrame =
            Frame(
            Box(
                {x = 0, y = 0},
                {
                    width = Graphics.SIZES.MAIN_SCREEN_WIDTH - 2 * Graphics.SIZES.BORDER_MARGIN,
                    height = 0
                },
                nil,
                nil
            ),
            Layout(Graphics.ALIGNMENT_TYPE.HORIZONTAL, 0, {x = 95, y = 0}),
            ui.frames.controlEditFrame
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
    end

    function self.runEventListeners()
        for _, eventListener in pairs(eventListeners) do
            eventListener.listen()
        end
    end

    function self.show()
        ui.frames.mainFrame.show()
    end

    initUI()
    return self
end

return TrackerSetupScreen

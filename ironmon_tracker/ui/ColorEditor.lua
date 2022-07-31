local ColorEditor = {}
ColorEditor.__index = ColorEditor

function ColorEditor:show()
    local colors = self.mainSettings:getColors()
    local drawShadows = self.mainSettings:shouldShadow()
    --Main rectangle
    gui.drawRectangle(
        Graphics.SIZES.SCREEN_WIDTH + self.X_OFFSET,
        0,
        Graphics.SIZES.RIGHT_GAP,
        326,
        0x00000000,
        colors.mainBackgroundColor
    )

    local rightEdge = Graphics.SIZES.RIGHT_GAP - (2 * Graphics.SIZES.BORDER_MARGIN)
    local bottomEdge = Graphics.SIZES.SCREEN_HEIGHT - (2 * Graphics.SIZES.BORDER_MARGIN)

    -- Color options view
    gui.drawRectangle(
        Graphics.SIZES.SCREEN_WIDTH + Graphics.SIZES.BORDER_MARGIN + self.X_OFFSET,
        Graphics.SIZES.BORDER_MARGIN,
        rightEdge,
        bottomEdge + 166,
        colors["Bottom box border color"],
        colors["Bottom box background color"]
    )

    -- Color options top rectangle
    gui.drawRectangle(
        Graphics.SIZES.SCREEN_WIDTH + Graphics.SIZES.BORDER_MARGIN + self.X_OFFSET,
        Graphics.SIZES.BORDER_MARGIN,
        rightEdge,
        28,
        colors["Bottom box border color"],
        colors["Bottom box background color"]
    )

    -- Color options bottom rectangle
    gui.drawRectangle(
        Graphics.SIZES.SCREEN_WIDTH + Graphics.SIZES.BORDER_MARGIN + self.X_OFFSET,
        Graphics.SIZES.BORDER_MARGIN + 244,
        rightEdge,
        44,
        colors["Bottom box border color"],
        colors["Bottom box background color"]
    )

    for _, button in pairs(self.mainButtons) do
        local box = button.box
        gui.drawRectangle(
            box[1],
            box[2],
            box[3],
            box[4],
            colors[button.backgroundColor[1]],
            colors[button.backgroundColor[2]]
        )
        DrawingUtils.drawText(
            box[1] + 3,
            box[2],
            button.text,
            colors["Default text color"],
            nil,
            drawShadows,
            colors["Bottom box background color"]
        )
    end

    for _, button in pairs(self.colorButtons) do
        local box = button.box
        gui.drawEllipse(box[1], box[2], box[3], box[4], 0xFF000000, colors[button.backgroundColor[2]])
        DrawingUtils.drawText(
            box[1] + 12,
            box[2] - 1,
            button.text,
            colors["Default text color"],
            nil,
            drawShadows,
            colors["Bottom box background color"]
        )
    end
end

local function onImportThemeClick()
    ThemeFactory.createImportThemeForm()
end

local function onExportThemeClick()
    ThemeFactory.createExportThemeForm()
end

local function onLoadClick()
    ThemeFactory.createLoadThemeForm()
end

local function onSaveClick()
    ThemeFactory.createSaveThemeForm()
end

local function onRestoreDefaultsClick(self)
    ThemeFactory.createDefaultConfirmDialog()
    self.inputState:changeState(States.INPUT.IGNORE_INPUT)
end

local function onCloseClick(self)
    client.SetGameExtraPadding(0, Graphics.SIZES.UP_GAP, Graphics.SIZES.RIGHT_GAP, Graphics.SIZES.DOWN_GAP)
    self.programState:changeState(States.PROGRAM.MAIN_OPTIONS)
end

local function createColorButton(self, index, colorName, colorValue)
    --Color button consists of the button and the text.
    local colorButton = {
        text = colorName,
        colorName = colorName,
        color = colorValue,
        box = {
            self.constants.COLOR_OPTION_BOX_X + self.constants.BUTTON_MARGIN,
            self.constants.COLOR_BUTTON_Y_START + index * (self.constants.COLOR_BUTTON_HEIGHT_WIDTH + 2),
            self.constants.COLOR_BUTTON_HEIGHT_WIDTH,
            self.constants.COLOR_BUTTON_HEIGHT_WIDTH
        },
        backgroundColor = {"Bottom box border color", colorName}
    }
    return colorButton
end

local function initializeMainButtons(self)
    self.loadButton = {
        text = "Load theme",
        box = {
            self.constants.COLOR_OPTION_BOX_X + self.constants.BUTTON_MARGIN + 67,
            self.constants.COLOR_OPTION_BOX_Y + self.constants.BUTTON_MARGIN,
            54,
            self.constants.BUTTON_HEIGHT
        },
        backgroundColor = {"Bottom box border color", "Bottom box background color"},
        onclick = onLoadClick
    }
    self.saveButton = {
        text = "Save theme",
        box = {
            self.constants.COLOR_OPTION_BOX_X + self.constants.BUTTON_MARGIN + 3,
            self.constants.COLOR_OPTION_BOX_Y + self.constants.BUTTON_MARGIN,
            54,
            self.constants.BUTTON_HEIGHT
        },
        backgroundColor = {"Bottom box border color", "Bottom box background color"},
        onclick = onSaveClick
    }
    self.restoreDefaults = {
        text = "Restore Defaults",
        box = {
            self.constants.COLOR_OPTION_BOX_X + self.constants.BUTTON_MARGIN,
            self.constants.COLOR_OPTION_BOX_Y + self.constants.COLOR_OPTION_HEIGHT - 6,
            73,
            self.constants.BUTTON_HEIGHT
        },
        backgroundColor = {"Bottom box border color", "Bottom box background color"},
        onclick = onRestoreDefaultsClick
    }
    self.loadThemeStringButton = {
        text = "Import theme string",
        box = {
            self.constants.COLOR_OPTION_BOX_X + self.constants.BUTTON_MARGIN,
            self.constants.COLOR_OPTION_BOX_Y + self.constants.COLOR_OPTION_HEIGHT - 34,
            86,
            self.constants.BUTTON_HEIGHT
        },
        backgroundColor = {"Bottom box border color", "Bottom box background color"},
        onclick = onImportThemeClick
    }
    self.exportThemeStringButton = {
        text = "Export theme string",
        box = {
            self.constants.COLOR_OPTION_BOX_X + self.constants.BUTTON_MARGIN,
            self.constants.COLOR_OPTION_BOX_Y + self.constants.COLOR_OPTION_HEIGHT - 50,
            86,
            self.constants.BUTTON_HEIGHT
        },
        backgroundColor = {"Bottom box border color", "Bottom box background color"},
        onclick = onExportThemeClick
    }
    self.closeButton = {
        text = "Close",
        box = {
            self.constants.COLOR_OPTION_BOX_X + self.constants.BUTTON_MARGIN + 91,
            self.constants.COLOR_OPTION_BOX_Y + self.constants.COLOR_OPTION_HEIGHT - 6,
            29,
            self.constants.BUTTON_HEIGHT
        },
        backgroundColor = {"Bottom box border color", "Bottom box background color"},
        onclick = onCloseClick
    }
    self.mainButtons = {
        self.loadButton,
        self.saveButton,
        self.presetButton,
        self.restoreDefaults,
        self.closeButton,
        self.loadThemeStringButton,
        self.exportThemeStringButton
    }
end

local function initializeColorButtons(self)
    local colors = self.colors
    local orderedKeys = Graphics.THEME_COLOR_KEYS_ORDERED
    local i = 0
    for _, colorName in ipairs(orderedKeys) do
        local colorValue = colors[colorName]
        local colorButton = createColorButton(self, i, colorName, colorValue)
        table.insert(self.colorButtons, colorButton)
        i = i + 1
    end
end

local function initializeToggleButtons(self)
    local Y_START = 178
    local i = 0
    for _, settingName in pairs(self.constants.COLOR_SETTINGS_ORDERED_KEYS) do
        local value = self.colorSettings[settingName]
        local newButton = {
            text = settingName:gsub("_", " "),
            box = {
                self.constants.COLOR_OPTION_BOX_X + self.constants.BUTTON_MARGIN + 1,
                self.constants.COLOR_OPTION_BOX_Y + Y_START + (10 * i),
                8,
                8
            },
            backgroundColor = {"Bottom box border color", "Bottom box background color"},
            textColor = "Default text color",
            optionColor = "Positive text color",
            optionState = value,
            onclick = function()
                self.colorSettings[settingName] = not (self.colorSettings[settingName])
                self.optionState = not (self.optionState)
                self.redraw = true
                self:show()
                self.mainSettings:save()
            end
        }
        table.insert(self.toggleButtons, newButton)
        i = i + 1
    end
end

local function initializeButtons(self)
    initializeColorButtons(self)
    initializeMainButtons(self)
    initializeToggleButtons(self)
end

function ColorEditor.new(programState, inputState, mainSettings)
    local self = setmetatable({}, ColorEditor)
    self.programState = programState
    self.inputState = inputState
    self.mainSettings = mainSettings
    self.colorSettings = mainSettings:getColorSettings()
    self.input = input
    self.colorButtons = {}
    self.toggleButtons = {}
    self.loadButton = nil
    self.saveButton = nil
    self.importThemeStringButton = nil
    self.exportThemeStringButton = nil
    self.presetButton = nil
    self.restoreDefaults = nil
    self.closeButton = nil
    self.toggleMoveColorButton = nil
    self.mainButtons = nil
    self.constants = {
        X_OFFSET = 150,
        COLOR_OPTION_BOX_X = Graphics.SIZES.SCREEN_WIDTH + Graphics.SIZES.BORDER_MARGIN + 150,
        COLOR_OPTION_BOX_Y = Graphics.SIZES.BORDER_MARGIN,
        COLOR_OPTION_HEIGHT = Graphics.SIZES.SCREEN_HEIGHT - (2 * Graphics.SIZES.BORDER_MARGIN) + 152,
        COLOR_OPTION_WIDTH = Graphics.SIZES.RIGHT_GAP - (2 * Graphics.SIZES.BORDER_MARGIN),
        BUTTON_MARGIN = 8,
        BUTTON_HEIGHT = 12,
        COLOR_BUTTON_HEIGHT_WIDTH = 9,
        COLOR_BUTTON_Y_START = 40,
        COLOR_SETTINGS_ORDERED_KEYS = {
            "Color_move_names_by_type",
            "Draw_shadows",
            "Draw_move_type_icons",
            "Color_move_type_icons",
            "Transparent_backgrounds",
            "Show_phys/spec_move_icons"
        }
    }
    initializeButtons(self)
    return self
end

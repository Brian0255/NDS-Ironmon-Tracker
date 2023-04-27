local function PokemonThemeManager(initialSettings, initialProgram)
    local self = {}
    local settings = initialSettings
    local program = initialProgram
    local currentPokemonID = -1
    local defaultColorScheme = nil
    local defaultColorSettings = nil
    local active = settings.appearance["AUTO_POKEMON_THEMES"]

    local function formatPokemonTheme(readData)
        local colorSettings = readData.colorSettings
        colorSettings["Color move names by type"] = false
        colorSettings["Draw shadows"] = true
        colorSettings["Draw move type icons"] = true
        colorSettings["Color move type icons"] = true
        colorSettings["Transparent backgrounds"] = false
        colorSettings["Show phys/spec move icons"] = true

        local colors = readData.colorScheme

        local colorsToCheck = {"Top box text color", "Bottom box text color"}

        for _, colorToCheck in pairs(colorsToCheck) do
            if colors[colorToCheck] == Graphics.THEME_COLORS.WHITE then
                if colorToCheck == "Top box text color" then
                    colors["Positive text color"] = Graphics.THEME_COLORS.LIGHT_POSITIVE
                    colors["Negative text color"] = Graphics.THEME_COLORS.LIGHT_NEGATIVE
                end
            end
            if colors[colorToCheck] == Graphics.THEME_COLORS.BLACK then
                if colorToCheck == "Top box text color" then
                    colors["Positive text color"] = Graphics.THEME_COLORS.DARK_POSITIVE
                    colors["Negative text color"] = Graphics.THEME_COLORS.DARK_NEGATIVE
                end
            end
        end

        colors["Gear icon color"] = colors["Top box text color"]
        colors["Physical icon color"] = colors["Bottom box text color"]
        colors["Special icon color"] = colors["Bottom box text color"]

    end

    local function readCurrentPokemonID()
        if not PokemonData.POKEMON[currentPokemonID + 1] then
            return
        end
        local theme = PokemonData.POKEMON[currentPokemonID + 1].theme
        if theme ~= nil then
            local readData = ThemeFactory.readThemeString(theme, false)
            formatPokemonTheme(readData)
            MiscUtils.copyTableIntoAnother(readData.colorSettings, settings.colorSettings)
            MiscUtils.copyTableIntoAnother(readData.colorScheme, settings.colorScheme)
        end
    end

    local function updateDefaults()
        defaultColorScheme = MiscUtils.deepCopy(settings.colorScheme)
        defaultColorSettings = MiscUtils.deepCopy(settings.colorSettings)
    end

    local function undoPokemonTheme()
        MiscUtils.copyTableIntoAnother(defaultColorSettings, settings.colorSettings)
        MiscUtils.copyTableIntoAnother(defaultColorScheme, settings.colorScheme)
        settings.colorScheme["Alternate positive text color"] = nil
        settings.colorScheme["Alternate negative text color"] = nil
    end

    local function updateBasedOnState(toggled)
        if settings.appearance["AUTO_POKEMON_THEMES"] then
            readCurrentPokemonID()
        else
            if toggled then
                undoPokemonTheme()
            end
        end
    end

    function self.toggleActive()
        --[[
        settings.appearance["AUTO_POKEMON_THEMES"] = not settings.appearance["AUTO_POKEMON_THEMES"]
        if settings.appearance["AUTO_POKEMON_THEMES"] then
            updateDefaults()
        end
        --]]
    end

    function self.getDefaults()
        return {
            colorScheme = defaultColorScheme,
            colorSettings = defaultColorSettings
        }
    end

    function self.turnOff()
        if settings.appearance["AUTO_POKEMON_THEMES"] then
            settings.appearance["AUTO_POKEMON_THEMES"] = false
            active = false
        end
        updateDefaults()
    end

    function self.update(newPokemonID)
        local settingWasToggled = (active ~= settings.appearance["AUTO_POKEMON_THEMES"])
        if (newPokemonID ~= nil and newPokemonID ~= currentPokemonID) or settingWasToggled then
            currentPokemonID = newPokemonID or currentPokemonID
            if settingWasToggled and settings.appearance["AUTO_POKEMON_THEMES"] then
                updateDefaults()
            end
            updateBasedOnState(settingWasToggled)
        end
        active = settings.appearance["AUTO_POKEMON_THEMES"]
    end

    updateDefaults()

    return self
end

return PokemonThemeManager

LocalizationsLoader = {}

-- Helper: shallow recursive merge
local function merge(base, override)
    local result = {}
    for k, v in pairs(base) do
        if type(v) == "table" and type(override[k]) == "table" then
            result[k] = merge(v, override[k])
        else
            result[k] = override[k] ~= nil and override[k] or v
        end
    end
    -- also add any extra keys from override that don't exist in base
    for k, v in pairs(override) do
        if result[k] == nil then
            result[k] = v
        end
    end
    return result
end

-- Store the current language for reference
local _currentLanguage = nil

-- Initialize the localizations with a specific language
function LocalizationsLoader.initialize(language)
    -- Default to English if no language specified
    language = language or "English"
    _currentLanguage = language
    
    -- Load English as the fallback
    local english = dofile(Paths.FOLDERS.LOCALIZATIONS_FOLDER .. "/English.lua")
    
    -- If requesting English, just return it directly
    if language == "English" then
        Localizations = english
        return
    end
    
    -- Try to load the target language
    local success, localized = pcall(dofile, Paths.FOLDERS.LOCALIZATIONS_FOLDER .. "/" .. language .. ".lua")
    
    if success then
        -- Merge target language over English (fallback to English for missing keys)
        Localizations = merge(english, localized)
    else
        -- If the language file doesn't exist, fall back to English
        Localizations = english
        _currentLanguage = "English"
    end
end

-- Reinitialize with a new language (useful for runtime language changes)
function LocalizationsLoader.setLanguage(language)
    LocalizationsLoader.initialize(language)
end

-- Get the currently loaded language name
function LocalizationsLoader.getCurrentLanguage()
    return _currentLanguage or "English"
end

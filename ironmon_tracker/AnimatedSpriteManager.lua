AnimatedSpriteManager = {}

local direction = 0
local offset = 0
local currentSpriteFrame = 0

local pokemonImages = {}

local absolutelyHugeMassiveSprites = {
    ["Arceus"] = true,
    ["Dialga"] = true,
    ["Giratina A"] = true,
    ["Giratina O"] = true,
    ["Groudon"] = true,
    ["Ho-Oh"] = true,
    ["Kyogre"] = true,
    ["Lugia"] = true,
    ["Palkia"] = true,
    ["Rayquaza"] = true,
    ["Regigigas"] = true,
    ["Wailord"] = true,
    ["Steelix"] = true,
    ["Ferrothorn"] = true,
    ["Reuniclus"] = true
}
--problematic: tornadus T, thundurus T

local function updateImages()
    for label, pokemonID in pairs(pokemonImages) do
        local name = PokemonData.POKEMON[pokemonID + 1].name
        local width, height = 32, 32
        label.setOffset({x = 1, y = -4})
        if absolutelyHugeMassiveSprites[name] then
            width, height = 64, 64
            label.setOffset({x = -16, y = -36})
        end

        label.setImageRegionSize({["width"] = width, ["height"] = height})
        label.setImageRegionOffset({x = width * currentSpriteFrame, y = width * 2})
    end
end
function AnimatedSpriteManager.addPokemonImage(pokemonImage, pokemonID)
    pokemonImages[pokemonImage] = pokemonID
    updateImages()
end

function AnimatedSpriteManager.update()
    currentSpriteFrame = (currentSpriteFrame + 1) % 4
    updateImages()
end

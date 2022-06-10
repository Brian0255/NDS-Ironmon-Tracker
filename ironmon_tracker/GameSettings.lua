GameSettings = {
	--3265629915
	playerBase = 0x27C330,--0x27C330,--0x27C330,
	playerBattleBase = 0x2CAD20, --0x2CAD20,
	enemyBase = 0x2CB2F0,
	playerBattleMonPID = 0x2C6104,--0x2A1E28,--0x2C6104,
	enemyBattleMonPID = 0x2C61C4,
	battleStatus = 0x246F48,
	itemStartNoBattle = 0x27CDFC,
	itemStartBattle = 0x2C2D60,
	trainerID = 0x27C300,

--[[	playerBase = 0x2349B4,
	playerBattleBase = 0x26A234,
	activeBattleMonPID = 0x2A7E70,

	BASE_SEARCH_START = 0x27C200,
	BASE_SEARCH_VALUE = 0xE97E0000,--]]
	game = 0,
	gamename = "",
	gen = 0,
}

VERSIONS = {
    'red-blue',
    'yellow',
    'gold-silver',
    'crystal',
    'ruby-sapphire',
    'emerald',
    'firered-leafgreen',
    'diamond-pearl',
    'platinum',
    'heartgold-soulsilver',
    'black-white',
    'colosseum',
    'xd',
    'black-2-white-2',
    'x-y',
    'omega-ruby-alpha-sapphire',
    'sun-moon',
    'ultra-sun-ultra-moon',
}

VERSION_TO_GEN_NUMBER = {
    ["red-blue"] = 1,
    yellow = 1,
    ["gold-silver"] = 2,
    crystal = 2,
    ["ruby-sapphire"] = 3,
    emerald = 3,
    ["firered-leafgreen"] = 3,
    ["diamond-pearl"] = 4,
    platinum = 4,
    ["heartgold-soulsilver"] = 4,
    ["black-white"] = 5,
    colosseum = 3,
    xd = 3,
    ["black-2-white-2"] = 5,
    ["x-y"] = 6,
    ["omega-ruby-alpha-sapphire"]= 6,
    ["sun-moon"] = 7,
    ["ultra-sun-ultra-moon"] = 7,
}


function GameSettings.initMoveData()
	for _,move in pairs(MoveDataMasterList) do
		local moveToInsert = {
			id = "---",
			name = "---",
			type = "---",
			power = "",
			pp = NOPP,
			accuracy = "",
			category = MoveCategories.NONE,
		}
		for name, moveAttribute in pairs(move) do
			if type(moveAttribute) == "table" then
				moveToInsert[name] = moveAttribute[GameSettings.gen]
			else
				moveToInsert[name] = moveAttribute
			end
		end
		table.insert(MoveData,moveToInsert)
	end
end

function GameSettings.initialize()
	--[[local val = Decrypter.find4ByteValueAddr(GameSettings.BASE_SEARCH_START,GameSettings.BASE_SEARCH_VALUE,400)
	local oldBase = GameSettings.playerBase
	GameSettings.playerBase = val - 0x08
	local diff = GameSettings.playerBase - oldBase
	print(diff)
	print(GameSettings.playerBase)
	
	GameSettings.playerBattleBase = GameSettings.playerBattleBase + diff
	GameSettings.enemyBase = GameSettings.enemyBase + diff
	GameSettings.playerBattleMonPID = GameSettings.playerBattleMonPID + diff
	GameSettings.enemyBattleMonPID = GameSettings.enemyBattleMonPID + diff
	GameSettings.itemStartNoBattle = GameSettings.itemStartNoBattle + diff
	GameSettings.itemStartBattle = GameSettings.itemStartBattle + diff--]]

	GameSettings.game = 10
	GameSettings.gamename = VERSIONS[GameSettings.game]
	GameSettings.versiongroup = 10
	GameSettings.gen = VERSION_TO_GEN_NUMBER[GameSettings.gamename]
	Decrypter.init()
	local alternateStart = 496
	for i,pokemon in pairs(Gen4AlternateForms) do
		PokemonData[i+alternateStart] = pokemon
	end
end

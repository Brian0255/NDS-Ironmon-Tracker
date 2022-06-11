GameSettings = {
	playerBase = 0,
	playerBattleBase = 0, 
	enemyBase = 0,
	playerBattleMonPID = 0,
	enemyBattleMonPID = 0,
	battleStatus = 0,
	itemStartNoBattle = 0,
	itemStartBattle = 0,
	statStagesPlayer = 0,
	statStagesEnemy = 0,
	versiongroup = 0,
	gamename = "",
	gen = 0,
}

function GameSettings.setAsHeartGoldSoulSilver()
	GameSettings.playerBase = 0x27C330
	GameSettings.playerBattleBase = 0x2CAD20
	GameSettings.enemyBase = 0x2CB2F0
	GameSettings.playerBattleMonPID = 0x2C6104
	GameSettings.enemyBattleMonPID = 0x2C61C4
	GameSettings.battleStatus = 0x246F48
	GameSettings.itemStartNoBattle = 0x27CDFC
	GameSettings.itemStartBattle = 0x2C2D60
	GameSettings.statStagesPlayer = 0x2C60B4
	GameSettings.statStagesEnemy = 0x2C6174
end

function GameSettings.setAsPlatinum()
	GameSettings.playerBase = 0x27E24C
	GameSettings.playerBattleBase = 0x2C9A44
	GameSettings.enemyBase = 0x2C9FF4
	GameSettings.playerBattleMonPID = 0x2C57B8
	GameSettings.enemyBattleMonPID = 0x2C5878
	GameSettings.battleStatus = 0x24A55A
	GameSettings.itemStartNoBattle = 0x27ecf8
	GameSettings.itemStartBattle = 0x2C2454
	GameSettings.statStagesPlayer = 0x2C5768
	GameSettings.statStagesEnemy = 0x2C5828
end

function GameSettings.setAsDiamondPearl()
	GameSettings.playerBase = 0x26D5AC
	GameSettings.playerBattleBase = 0x2B9AD8
	GameSettings.enemyBase = 0x2BA088
	GameSettings.playerBattleMonPID = 0x2B58E8
	GameSettings.enemyBattleMonPID = 0x2B59A8
	GameSettings.battleStatus = 0x23BB38
	GameSettings.itemStartNoBattle = 0x26E054
	GameSettings.itemStartBattle = 0x2B276C
	GameSettings.statStagesPlayer = 0x2B5898
	GameSettings.statStagesEnemy = 0x2B5958
end

GameSettings.VERSIONS = {
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

GameSettings.VERSION_TO_GEN_NUMBER = {
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

GameSettings.GAMECODE_TO_VERSION_GROUP = {
	[0x45415041] = 8,
	[0x45414441] = 8,
	[0x45555043] = 9,
	[0x454B5049] = 10,
	[0x45475049] = 10,
}

GameSettings.GAMECODE_TO_GAME_NAME = {
	[0x45415041] = "Pokemon Pearl",
	[0x45414441] = "Pokemon Diamond",
	[0x45555043] = "Pokemon Platinum",
	[0x454B5049] = "Pokemon HeartGold",
	[0x45475049] = "Pokemon SoulSilver",
}


GameSettings.CARTRIDGE_HEADER = 0x3FFE00

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
	local gameCode = memory.read_u32_le(GameSettings.CARTRIDGE_HEADER+0x0C)
	GameSettings.versiongroup = GameSettings.GAMECODE_TO_VERSION_GROUP[gameCode]
	GameSettings.gamename = GameSettings.GAMECODE_TO_GAME_NAME[gameCode]
	local versionName = GameSettings.VERSIONS[GameSettings.versiongroup]
	GameSettings.gen = GameSettings.VERSION_TO_GEN_NUMBER[versionName]
	print(GameSettings.gen)

	print(GameSettings.gamename.. " detected.")

	if GameSettings.versiongroup == 8 then 
		GameSettings.setAsDiamondPearl()
	elseif GameSettings.versiongroup == 9 then 
		GameSettings.setAsPlatinum()
	elseif GameSettings.versiongroup == 10 then 
		GameSettings.setAsHeartGoldSoulSilver()
	end

	Decrypter.init()
	local alternateStart = 496
	for i,pokemon in pairs(Gen4AlternateForms) do
		PokemonData[i+alternateStart] = pokemon
	end
end

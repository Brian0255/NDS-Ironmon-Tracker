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
	activeMonIndex = 0,
	curHPBattlePlayer = nil,
	maxHPBattlePLayer = nil,
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

function GameSettings.setAsBlack()
	GameSettings.playerBase = 0x2349B4
	GameSettings.playerBattleBase = 0x26A794
	GameSettings.enemyBase = 0x26B254
	GameSettings.playerBattleMonPID = 0x2a7e14
	GameSettings.enemyBattleMonPID = 0x2A7E14
	GameSettings.battleStatus = 0x1D0798
	GameSettings.itemStartNoBattle = 0x234784
	GameSettings.itemStartBattle = 0x234784
	GameSettings.statStagesStart = 0x26D7A0
	GameSettings.statStagesEnemy = 0x26D9C4
	GameSettings.maxHPBattlePlayer = 0x26D6B2
	GameSettings.curHPBattlePlayer = 0x26D6B4
	GameSettings.totalMonsParty = 0x2349B0
	GameSettings.berryBagStart = 0x234844
end

function GameSettings.setAsWhite()
	GameSettings.playerBase = 0x2349B4+0x20
	GameSettings.playerBattleBase = 0x26A794+0x20
	GameSettings.enemyBase = 0x26B254+0x20
	GameSettings.playerBattleMonPID = 0x2a7e14+0x20
	GameSettings.enemyBattleMonPID = 0x2A7E14+0x20
	GameSettings.battleStatus = 0x1D0798+0x20
	GameSettings.itemStartNoBattle = 0x234784+0x20
	GameSettings.itemStartBattle = 0x234784+0x20
	GameSettings.statStagesStart = 0x26D7A0+0x20
	GameSettings.statStagesEnemy = 0x26D9C4+0x20
	GameSettings.maxHPBattlePlayer = 0x26D6B2+0x20
	GameSettings.curHPBattlePlayer = 0x26D6B4+0x20
	GameSettings.totalMonsParty = 0x2349B0+0x20
	GameSettings.berryBagStart = 0x234844+0x20
end

function GameSettings.setAsBlack2()
	GameSettings.playerBase = 0x21E42C
	GameSettings.playerBattleBase = 0x257db4
	GameSettings.enemyBase = 0x258874 
	GameSettings.playerBattleMonPID = 0x2968D4
	GameSettings.enemyBattleMonPID = 0x2968D4
	GameSettings.battleStatus = 0x1B5138
	GameSettings.itemStartNoBattle = 0x21E1FC
	GameSettings.itemStartBattle = 0x21E1FC
	GameSettings.statStagesStart = 0x25B320
	GameSettings.maxHPBattlePlayer = 0x25B232
	GameSettings.curHPBattlePlayer = 0x25B234
	GameSettings.totalMonsParty = 0x21E428
	GameSettings.berryBagStart =  0x21E2BC
	--002E8688
end

function GameSettings.setAsWhite2()
	GameSettings.playerBase = 0x21E42C+0x80
	GameSettings.playerBattleBase = 0x257db4+0x80
	GameSettings.enemyBase = 0x258DD4 +0x80
	GameSettings.playerBattleMonPID = 0x2968D4+0x80
	GameSettings.enemyBattleMonPID = 0x2968D4+0x80
	GameSettings.battleStatus = 0x1Bc9f2
	GameSettings.itemStartNoBattle = 0x21E1FC+0x80
	GameSettings.itemStartBattle = 0x21E1FC+0x80
	GameSettings.statStagesStart = 0x25B320+0x80
	GameSettings.maxHPBattlePlayer = 0x25B232+0x80
	GameSettings.curHPBattlePlayer = 0x25B234+0x80
	GameSettings.totalMonsParty = 0x21E428+0x80
	GameSettings.berryBagStart =  0x21E2BC+0x80
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
    'black-2-white-2',
}

GameSettings.VERSION_TO_GEN_NUMBER = {
    ["red-blue"] = 1,
    ["yellow"] = 1,
    ["gold-silver"] = 2,
    ["crystal"] = 2,
    ["ruby-sapphire"] = 3,
    ["emerald"] = 3,
    ["firered-leafgreen"] = 3,
    ["diamond-pearl"] = 4,
    ["platinum"] = 4,
    ["heartgold-soulsilver"] = 4,
    ["black-white"] = 5,
    ["black-2-white-2"] = 5,
}

GameSettings.GAMECODE_TO_VERSION_GROUP = {
	[0x45415041] = 8,
	[0x45414441] = 8,
	[0x45555043] = 9,
	[0x454B5049] = 10,
	[0x45475049] = 10,
	[0x4F425249] = 11,
	[0x4F415249] = 11,
	[0x4F455249] = 12,
	[0x4F445249] = 12,
}

GameSettings.GAMECODE_TO_GAME_NAME = {
	[0x45415041] = "Pokemon Pearl",
	[0x45414441] = "Pokemon Diamond",
	[0x45555043] = "Pokemon Platinum",
	[0x454B5049] = "Pokemon HeartGold",
	[0x45475049] = "Pokemon SoulSilver",
	[0x4F425249] = "Pokemon Black",
	[0x4F415249] = "Pokemon White",
	[0x4F455249] = "Pokemon Black 2",
	[0x4F445249] = "Pokemon White 2",
}

GameSettings.GAMECODE_TO_BADGE_PREFIX = {
	[0x45415041] = "DPPT",
	[0x45414441] = "DPPT",
	[0x45555043] = "DPPT",
	[0x454B5049] = "HGSS",
	[0x45475049] = "HGSS",
	[0x4F425249] = "BW",
	[0x4F415249] = "BW",
	[0x4F455249] = "BW2",
	[0x4F445249] = "BW2",
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
	local memdomain = "Main RAM"
    memory.usememorydomain(memdomain)
	local gameCode = memory.read_u32_le(GameSettings.CARTRIDGE_HEADER+0x0C)
	GameSettings.versiongroup = GameSettings.GAMECODE_TO_VERSION_GROUP[gameCode]
	GameSettings.gamename = GameSettings.GAMECODE_TO_GAME_NAME[gameCode]
	ButtonManager.BADGE_GAME_PREFIX = GameSettings.GAMECODE_TO_BADGE_PREFIX[gameCode]
	local versionName = GameSettings.VERSIONS[GameSettings.versiongroup]
	GameSettings.gen = GameSettings.VERSION_TO_GEN_NUMBER[versionName]

	print(GameSettings.gamename.. " detected.")

	if GameSettings.versiongroup == 8 then 
		GameSettings.setAsDiamondPearl()
	elseif GameSettings.versiongroup == 9 then 
		GameSettings.setAsPlatinum()
	elseif GameSettings.versiongroup == 10 then 
		GameSettings.setAsHeartGoldSoulSilver()
	elseif GameSettings.versiongroup == 11 then 
		if GameSettings.gamename == "Pokemon White" then
			GameSettings.setAsWhite()
		else
			GameSettings.setAsBlack()
		end
	elseif GameSettings.versiongroup == 12 then 
		if GameSettings.gamename == "Pokemon White 2" then
			GameSettings.setAsWhite2()
		else
			GameSettings.setAsBlack2()
		end
	end

	if GameSettings.gen == 5 then
		MiscData.item = MiscData.items_gen5
	else
		MiscData.item = MiscData.items_gen4
	end
	Decrypter.init()
end

local configSpine = {
	--小丑
	clown = {
		--动作基本配置
		cFile = "spine/BOSS_clown/BOSS_clown.json", --配置文件路径
		pFile = "spine/BOSS_clown/BOSS_clown.atlas", --plist文件路径
		iFile = "spine/BOSS_clown/BOSS_clown.png", --img文件路径

		--动作列表 {轨道索引, 动作名, 是否循环}
		victory = {0, "siwang", false,}, --游戏胜利,小丑死亡
		fail = {0, "shengli", false,}, --游戏失败,小丑得以
		idel = {0, "changgui_1", true,},
		dizziness = {0, "changgui_2", true,},
		attack = {0, "gongji", false,},
		hrut = {0, "shouji_1", false,},
	},
};

return configSpine;
--骨骼动画配置
local configParticle = {
	--关卡激活
	cpActivate = {
		life = 2.0,
		cFile = "particle/jihuoguanka.plist", --配置文件路径
		iFile = "particle/xuanzhongguanka.png", --img文件路径
	},

	--头像所在关卡
	cpHead = {
		cFile = "particle/xuanzhongguanka.plist", --配置文件路径
		iFile = "particle/xuanzhongguanka.png", --img文件路径
	},

	--星星奖励 流星
	starReward = {
		cFile = "particle/sheliuxing.plist", --配置文件路径
		iFile = "particle/sheliuxing.png", --img文件路径
	},

	--红色方块消除粒子
	cube_del_1 = {
		life = 0.6,
		cFile = "particle/R/baozha_hongse.plist", --配置文件路径
		iFile = "particle/R/hongse_BZ.png", --img文件路径
	},

	--橙色方块消除粒子
	cube_del_2 = {
		life = 0.6,
		cFile = "particle/chense/baozha_chense.plist", --配置文件路径
		iFile = "particle/chense/baozha_chense.png", --img文件路径
	},
	
	--黄色方块消除粒子
	cube_del_3 = {
		life = 0.6,
		cFile = "particle/huangse/baozha_huangse.plist", --配置文件路径
		iFile = "particle/huangse/huangse_BZ.png", --img文件路径
	},
	
	--绿色方块消除粒子
	cube_del_4 = {
		life = 0.6,
		cFile = "particle/lvse/baozha_lvse.plist", --配置文件路径
		iFile = "particle/lvse/lvse_BZ.png", --img文件路径
	},

	--蓝色方块消除粒子
	cube_del_5 = {
		life = 0.6,
		cFile = "particle/lanse/baozha_lanse.plist", --配置文件路径
		iFile = "particle/lanse/lanse_BZ.png", --img文件路径
	},

	--紫色方块消除粒子
	cube_del_6 = {
		life = 0.6,
		cFile = "particle/zise/baozha_zise.plist", --配置文件路径
		iFile = "particle/zise/zise_BZ.png", --img文件路径
	},

	--胜利后的彩带
	colourBar = {
		life = 3.0,
		cFile = "particle/caidai/caidai.plist",
		iFile = "particle/caidai/caidai.png",
	},

	--金猪破碎
	goldPigBreak = {
		life = 0.6, 
		cFile = "particle/goldpig_breke/goldpig_breke.plist",
		iFile = "particle/goldpig_breke/goldpig_breke.plist",
	},
};

return configParticle;
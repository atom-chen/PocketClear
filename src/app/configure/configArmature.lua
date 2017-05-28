--骨骼动画配置
local configArmature = {
	--火星闪屏
	-- marsSplash = {
	-- 	--动作列表
	-- 	logo = {duration = -1, loop = 0, },

	-- 	--动作基本配置
	-- 	id = "logo",
	-- 	cFile = "armature/logo_gugedonghua/logo_gugedonghua.xml", --配置文件路径
	-- 	pFile = "armature/logo_gugedonghua/logo_gugedonghua.plist", --plist文件路径
	-- 	iFile = "armature/logo_gugedonghua/logo_gugedonghua.png", --img文件路径
	-- },

	--登陆界面
	login = {
		--动作列表
		login001 = {duration = -1, loop = -1, post = "login002"},
		login002 = {duration = -1, loop = -1,},
		
		--动作基本配置
		id = "login",
		cFile = "armature/login/login.csb", --配置文件路径
	},

	--游戏logo
	logo = {
		--动作列表
		LOGO02 = {duration = -1, loop = -1, },

		--动作基本配置
		id = "LOGO",
		cFile = "armature/LOGO/LOGO.csb", --配置文件路径
	},

	--登陆按钮
	loginBtn = {
		--动作列表
		play1 = {duration = -1, loop = -1, },

		--动作基本配置
		id = "play",
		cFile = "armature/play/play.csb", --配置文件路径
	},

	--三星动画
	star = {
		SLJMxingxing1 = {duration = -1, loop = -1,},
		SLJMxingxing2 = {duration = -1, loop = -1,},
		SLJMxingxing3 = {duration = -1, loop = -1,},

		guanka1xing = {duration = -1, loop = -1,},
		guanka2xing = {duration = -1, loop = -1,},
		guanka3xing = {duration = -1, loop = -1,},
		
		id = "SLJMxingxing",
		cFile = "armature/SLJMxingxing/SLJMxingxing.ExportJson",
	},

	--关卡中的头像
	head = {
		touxiang = {duration = -1, loop = -1,},

		id = "guankatexiao",
		cFile = "armature/guankatexiao/guankatexiao.csb",
	},

	--关卡锁
	cpLock = {
		appear = {duration = -1, loop = -1, post = "normal",},
		normal = {duration = -1, loop = -1,},
		disappear = {duration = -1, loop = -1,},
		
		id = "clouds",
		cFile = "armature/clouds/clouds.csb",
	},

	--界面icon
	icon = {
		--动作列表
		hongbao = {duration = -1, loop = -1, },
		qihuanlvcheng = {duration = -1, loop = -1, },
		haohualibaonormal = {duration = -1, loop = -1, },
		qiandaonormal = {duration = -1, loop = -1, },
		tousurexian = {duration = -1, loop = -1, },
		shangdian = {duration = -1, loop = -1, },
		shezhi = {duration = -1, loop = -1, },
		nohongbao = {duration = -1, loop = -1, },
		gonggao = {duration = -1, loop = -1, },

		huodong = {duration = -1, loop = -1, }, --社区
		huodongtishi = {duration = -1, loop = -1, }, --社区提示
		HDdianji = {duration = -1, loop = -1, }, --社区点击

		xinshouzuanshi = {duration = -1, loop = -1, },
		yimaoqian = {duration = -1, loop = -1, },
		yiyuanqian = {duration = -1, loop = -1, },
		zhizunlibao = {duration = -1, loop = -1, },
		haohualibao = {duration = -1, loop = -1, },
		VIPzuanshidalibao = {duration = -1, loop = -1, },
		bumaitili = {duration = -1, loop = -1, },
		mianfeizuanshi = {duration = -1, loop = -1, },
		xingyunzhuanpan = {duration = -1, loop = -1, },
		shuangbeijinbi = {duration = -1, loop = -1, },

		fanpai = {duration = -1, loop = -1, },
		fanpailingqu = {duration = -1, loop = -1, },
		fanpaitishi = {duration = -1, loop = -1, },

		--动作基本配置
		id = "jiemiantubiao",
		cFile = "armature/jiemiantubiao/jiemiantubiao.csb", --csb文件路径
		pFile = "armature/jiemiantubiao/jiemiantubiao0.plist", --plist文件路径
		iFile = "armature/jiemiantubiao/jiemiantubiao0.png", --img文件路径
	},

	--抽红包
	chouhongbao = {
		chouhongbao = {duration = -1, loop = -1, },
		hongbaoshou = {duration = -1, loop = -1, },
		tanhongbao = {duration = -1, loop = -1, },

		id = "chouhongbao",
		cFile = "armature/chouhongbao/chouhongbao.csb", --csb文件路径
		pFile = "armature/chouhongbao/chouhongbao0.plist", --plist文件路径
		iFile = "armature/chouhongbao/chouhongbao0.png", --img文件路径
	},

	--星星 新奖励
	newReward = {
		xinjiangli = {duration = -1, loop = -1, },
		jijiangtuichu = {duration = -1, loop = -1, },

		--动作基本配置
		id = "xinjiangli",
		cFile = "armature/xinjiangli/xinjiangli.csb", --csb文件路径
		pFile = "armature/xinjiangli/xinjiangli0.plist", --plist文件路径
		iFile = "armature/xinjiangli/xinjiangli0.png", --img文件路径
	},

	--翻牌特效
	flipBrand = {
		UI_side01 = {duration = -1, loop = -1,},
		btnside = {duration = -1, loop = 1,},

		id = "UI_side01",
		cFile = "armature/UI_side01/UI_side01.ExportJson",
	},

	--格子传送特效
	grid_t = {
		CS_down = {duration = -1, loop = -1,},
		CS_up = {duration = -1, loop = -1,},

		id = "effect01",
		cFile = "armature/effect01/effect01.csb", --csb文件路径
		pFile = "armature/effect01/effect010.plist", --plist文件路径
		iFile = "armature/effect01/effect010.png", --img文件路径
	},

	--倒霉熊
	backkom = {
		GRUNdaiji = {duration = -1, loop = -1,}, --待机
		GRUNqingzhu01 = {duration = -1, loop = -1,}, --欢呼
		GRUNshibai = {duration = -1, loop = -1,}, --失败
		GRUNshengli = {duration = -1, loop = -1,}, --胜利

		id = "JSDH02",
		cFile = "armature/JSDH02/JSDH02.csb", --csb文件路径
	},

	--棋盘格特效动画
	cbEffect = {
		--倒霉熊combo喝彩
		good = {duration = -1, loop = -1,}, --2次combo
		great = {duration = -1, loop = -1,}, --3次combo
		amazing = {duration = -1, loop = -1,}, --4次combo
		excellent = {duration = -1, loop = -1,}, --5次combo
		unbelievable = {duration = -1, loop = -1,}, --6次combo or 以上

		runchupin = {duration = -1, loop = -1,}, --触屏

		--炸弹, 导弹生成特效
		runyizhixiao = {duration = -1, loop = -1,},
		runLxiao = {duration = -1, loop = -1,},
		runTxiao = {duration = -1, loop = -1,},

		--炸弹，导弹爆炸特效
		runshuxiang = {duration = -1, loop = -1,},
		runhengxiang = {duration = -1, loop = -1,},
		runshizi = {duration = -1, loop = -1,},
		-- runzhadanshengcheng = {duration = -1, loop = -1,},
		
		jiesuanshanguang = {duration = -1, loop = -1,}, --省里面板后面转圈特效
		bonustime = {duration = -1, loop = -1,}, --闯关成功

		g321go = {duration = -1, loop = -1,}, --时间关卡倒计时
		shanguang01 = {duration = -1, loop = -1,}, --分数星星激活的时候播放特效

		id = "zhujiemian001",
		cFile = "armature/zhujiemian001/zhujiemian001.csb",
	},
	
	--蜥蜴
	lizard = {
		G2RUNjiesuanqingz = {duration = -1, loop = -1,}, --结算庆祝
		
		id = "JSDH03",
		cFile = "armature/JSDH03/JSDH03.csb",
	},
	
	--获得星星
	starActivate = {
		shanguang01 = {duration = -1, loop = -1,}, --激活闪光

		id = "huodexingxing",
		cFile = "armature/huodexingxing/huodexingxing.ExportJson",
	},
	
	--boss攻击前置特效
	attackPre = {
		bosstexiao = {duration = -1, loop = -1,}, --激活闪光
		
		id = "bosstexiao",
		cFile = "armature/bosstexiao/bosstexiao.csb",
	},

	--小锤敲击动画
	hammer = {
		chuizi_DH = {duration = -1, loop = -1,}, --锤击动画

		id = "daoju",
		cFile = "armature/daoju/daoju.csb",
	},

	--加五步道具提醒
	actionStep = {
		jia5buchuxian = {duration = -1, loop = -1,}, --锤击动画
		jia5bunormal = {duration = -1, loop = -1,}, --锤击动画

		id = "jia5bu",
		cFile = "armature/jia5bu/jia5bu.csb",
	},

	--加30秒道具提醒
	actionTime = {
		jia30miaochuxian = {duration = -1, loop = -1,}, --锤击动画
		jia30miaonormal = {duration = -1, loop = -1,}, --锤击动画

		id = "jia30miao",
		cFile = "armature/jia30miao/jia30miao.csb",
	},

	--引导小手
	guideHand = {
		shou = {duration = -1, loop = -1,}, --小手点击
		
		id = "xinshoudonghua",
		cFile = "armature/xinshoudonghua/xinshoudonghua.csb",
	},

	--道具奖励展示
	itemReward = {
		jianglitishi = {duration = -1, loop = -1,},
		
		id = "mianfeizuanshi",
		cFile = "armature/mianfeizuanshi/mianfeizuanshi.ExportJson",
	},

	--==============================================
	--					元素
	--==============================================
	--炸弹
	bomb = {
		--state为某个状态的开始帧
		bomb1 = {duration = -1, loop = -1,},
		bomb2 = {duration = -1, loop = -1,},
		bomb4 = {duration = -1, loop = -1,},
		
		id = "element",
		cFile = "armature/element/element.csb", --csb文件路径
	},
	
	--宝石障碍
	gemstone = {
		--state为某个状态的开始帧
		baoshi01 = {duration = -1, loop = -1, state={normal=11, delete=0,},},
		baoshi02 = {duration = -1, loop = -1, state={normal=11, delete=0,},},
		baoshi03 = {duration = -1, loop = -1, state={normal=11, delete=0,},},
		baoshi04 = {duration = -1, loop = -1, state={normal=11, delete=0,},},

		id = "duochengbaoshi",
		cFile = "armature/duochengbaoshi/duochengbaoshi.csb", --csb文件路径
	},
	
	--玻璃罩子
	glass = {
		ice1 = {duration = -1, loop = -1,},
		ice2 = {duration = -1, loop = -1,},

		id = "ice",
		cFile = "armature/ice/ice.csb",
	},
	
	--牢笼
	cage = {
		box_wood = {duration = -1, loop = -1,},
		box_iron = {duration = -1, loop = -1,},

		id = "laolong",
		cFile = "armature/laolong/laolong.csb",
	},
	
	--奖杯
	cup = {
		goldclick = {duration = -1, loop = -1,},

		id = "SJ_jiangbei",
		cFile = "armature/SJ_jiangbei/SJ_jiangbei.csb",
	},

	--沥青
	pitch = {
		daiji = {duration = -1, loop = -1,},
		xiadaoshang = {duration = -1, loop = -1,},
		shangdaoxia = {duration = -1, loop = -1,},
		youdaozuo = {duration = -1, loop = -1,},
		zuodaoyou = {duration = -1, loop = -1,},
		baopo = {duration = -1, loop = -1,},
		
		id = "liqing",
		cFile = "armature/liqing/liqing.csb",
	},

	--金猪
	goldPig = {
		glodpig = {duration = -1, loop = -1,},
		
		id = "glodpig",
		cFile = "armature/glodpig/glodpig.csb",
	},
	
	--石中戒
	stoneRing = {
		have01 = {duration = -1, loop = -1,}, --初始状态
		have02 = {duration = -1, loop = -1,},
		have03 = {duration = -1, loop = -1,},
		have04 = {duration = -1, loop = -1,},

		noting01 = {duration = -1, loop = -1,}, --初始状态
		noting02 = {duration = -1, loop = -1,},
		noting03 = {duration = -1, loop = -1,},

		id = "jiezi",
		cFile = "armature/jiezi/jiezi.csb",
	},

	--福袋
	luckyBag = {
		fudai = {duration = -1, loop = -1,},
		fudaibaozha = {duration = -1, loop = -1,},
		
		id = "fudai",
		cFile = "armature/fudai/fudai.csb",
	},

	--颜色制造机
	colorMachine = {
		secaizhizao_1 = {duration = -1, loop = -1,},
		secaizhizao_2 = {duration = -1, loop = -1,},
		secaizhizao_3 = {duration = -1, loop = -1,},
		
		id = "secaizhizao",
		cFile = "armature/secaizhizao/secaizhizao.csb",
	},

	--蛋糕
	cake = {
		cake01 = {duration = -1, loop = -1,},
		cake02 = {duration = -1, loop = -1,},
		cake03 = {duration = -1, loop = -1,},
		cake04 = {duration = -1, loop = -1,},
		cake05 = {duration = -1, loop = -1,},
		cake06 = {duration = -1, loop = -1,},
		cake07 = {duration = -1, loop = -1,},

		id = "cake",
		cFile = "armature/cake/cake.csb",
	},
};

return configArmature;
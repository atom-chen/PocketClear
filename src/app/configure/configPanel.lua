--面板配置
local configPanel = {
	--关卡信息面板
	levelInfo = {
		cFile = "texture/levelInfo.csb",
		iFile = "texture/levelInfo.png",
		pFile = "texture/levelInfo.plist",

		--进入
		enter = {
			--进入动画
			action = {
				"moveEaseElasticOutEnter",
				DIR.CLOCK_12,
			},

			--进入音效
			sound = {
				configAudio.sound_2,
			},
		},

		--退出
		exit = {
			--退出动画
			action = {
				"moveExit",
				DIR.CLOCK_6,
			},

			--退出音效
			sound = {
				configAudio.sound_2,
			},
		},
	},
	
	taskCue = {
		cFile = "texture/taskCue.csb",
		
		shieldMask = true,

		enter = {
			--进入动画
			action = {
				"moveEaseElasticOutEnter",
				DIR.CLOCK_9,
			},

			--进入音效
			sound = {
				configAudio.sound_2,
			},
		},

		exit = {
			--退出动画
			action = {
				"moveExit",
				DIR.CLOCK_3,
			},

			--退出音效
			sound = {
				configAudio.sound_2,
			},
		},
	},

	--星星奖励
	starReward = {
		cFile = "texture/starReward.csb",
		iFile = "texture/starReward.png",
		pFile = "texture/starReward.plist", 
	},

	--投诉热线
	complain = {
		cFile = "texture/complain.csb",

		enter = {
			--进入动画
			action = {
				"moveEaseElasticOutEnter",
				DIR.CLOCK_9,
			},

			--进入音效
			sound = {
				configAudio.sound_2,
			},
		},
		
		exit = {
			--退出动画
			action = {
				"moveExit",
				DIR.CLOCK_3,
			},

			--退出音效
			sound = {
				configAudio.sound_2,
			},
		},
	},

	--签到
	signIn = {
		cFile = "texture/singIn.csb",
		iFile = "texture/singIn.png",
		pFile = "texture/singIn.plist", 
	},

	--体力
	power = {
		cFile = "texture/power.csb",
		iFile = "texture/power.png",
		pFile = "texture/power.plist", 
	},

	--商店
	shop = {
		cFile = "texture/shop.csb",
		iFile = "texture/shop.png",
		pFile = "texture/shop.plist", 
	},

	--购买道具界面
	CPBuyItem = {
		cFile = "texture/CPBuyItem.csb",
		iFile = "texture/CPBuyItem.png",
		pFile = "texture/CPBuyItem.plist", 

		shieldMask = true,
	},

	--礼包界面
	point = {
		--背景面板的透明度
		pellucidity = 80,
	},
	
	--设置与暂停
	pause = {
		cFile = "texture/pause.csb",
		iFile = "texture/pause.png",
		pFile = "texture/pause.plist", 
	},

	--胜利界面
	victory = {
		cFile = "texture/victory.csb",
		iFile = "texture/victory.png",
		pFile = "texture/victory.plist", 

		enter = {
			--进入动画
			action = {
				"moveEaseElasticOutEnter",
				DIR.CLOCK_12,
			},

			--进入音效
			sound = {
				configAudio.sound_2,
			},
		},
		
		exit = {
			--退出动画
			action = {
				"moveExit",
				DIR.CLOCK_6,
			},

			--退出音效
			sound = {
				configAudio.sound_2,
			},
		},
	},

	--失败界面
	fail = {
		cFile = "texture/fail.csb",
		iFile = "texture/fail.png",
		pFile = "texture/fail.plist", 
		
		enter = {
			--进入动画
			action = {
				"moveEaseElasticOutEnter",
				DIR.CLOCK_12,
			},

			--进入音效
			sound = {
				configAudio.sound_2,
			},
		},
		
		exit = {
			--退出动画
			action = {
				"moveExit",
				DIR.CLOCK_6,
			},

			--退出音效
			sound = {
				configAudio.sound_2,
			},
		},
	},

	--倒霉熊奇幻之旅
	trip = {
		cFile = "texture/trip.csb",
		iFile = "texture/trip.png",
		pFile = "texture/trip.plist", 
	},

	--欢迎礼包
	welcomeGift = {
		cFile = "texture/welcomeGift.csb",
		iFile = "texture/welcomeGift.png",
		pFile = "texture/welcomeGift.plist", 
	},

	--引导
	guide = {
		shieldMask = true,
	},

	--红包
	redPacket = {
		iFile = "texture/redPacket.png",
		pFile = "texture/redPacket.plist", 
	},

	--免费金币
	freeCoin = {
		
	},

	--转盘
	wheel = {
		cFile = "texture/wheel.csb",
		iFile = "texture/wheel.png",
		pFile = "texture/wheel.plist", 
	},

	--分享
	share = {
		cFile = "texture/share.csb",
		iFile = "texture/wheel.png",
		pFile = "texture/wheel.plist", 
	},

	--comment
	comment = {
		cFile = "texture/comment.csb",
		iFile = "texture/comment.png",
		pFile = "texture/comment.plist", 
	},
	
	--fiveStep
	fiveStep = {
		cFile = "texture/fiveStep.csb",
		iFile = "texture/fiveStep.png",
		pFile = "texture/fiveStep.plist", 
	},

	--fullPower
	fullPower = {
		cFile = "texture/fullPower.csb",
		iFile = "texture/fullPower.png",
		pFile = "texture/fullPower.plist", 
	},
	
	--cpGift
	cpGift = {
		cFile = "texture/CPGift.csb",
		iFile = "texture/CPGift.png",
		pFile = "texture/CPGift.plist", 
	},

	--payment
	payment = {
		cFile = "texture/payment.csb",
		iFile = "texture/payment.png",
		pFile = "texture/payment.plist", 
	},

	--payment
	showItemReward = {
		cFile = "texture/showItemReward.csb",
	},
	
	--======================================
	--				弹出框
	--======================================
	--金币不足
	msgBox_NoCoin = {
		type = MSGBOX.NOTENOUGH_CURRENCY, --弹出框类型
		content = MSGCONTENT.NOTENOUGH_CURRENCY, --弹出框内容
		subType = MSGCURRENCY.COIN, --余额不足子类型
		
		enter = {
			--进入动画
			action = {
				"moveEaseElasticOutEnter",
				DIR.CLOCK_9,
			},

			--进入音效
			sound = {
				configAudio.sound_2,
			},
		},
		
		exit = {
			--退出动画
			action = {
				"moveExit",
				DIR.CLOCK_3,
			},

			--退出音效
			sound = {
				configAudio.sound_2,
			},
		},

		--背景面板的透明度
		pellucidity = 80,
	},
	--钻石不足
	msgBox_NoDiamond = {
		type = MSGBOX.NOTENOUGH_CURRENCY, --弹出框类型
		content = MSGCONTENT.NOTENOUGH_CURRENCY, --弹出框内容
		subType = MSGCURRENCY.DIAMOND, --余额不足子类型
		
		enter = {
			--进入动画
			action = {
				"moveEaseElasticOutEnter",
				DIR.CLOCK_9,
			},

			--进入音效
			sound = {
				configAudio.sound_2,
			},
		},
		
		exit = {
			--退出动画
			action = {
				"moveExit",
				DIR.CLOCK_3,
			},

			--退出音效
			sound = {
				configAudio.sound_2,
			},
		},
		--背景面板的透明度
		pellucidity = 80,
	},
	--购买成功
	msgBox_BuySccess = {
		type = MSGBOX.NORMAL, --弹出框类型
		content = MSGCONTENT.BUYSUCCESS, --弹出框内容
		
		-- enter = {
		-- 	--进入动画
		-- 	action = {
		-- 		"moveEaseElasticOutEnter",
		-- 		DIR.CLOCK_9,
		-- 	},

		-- 	--进入音效
		-- 	sound = {
		-- 		configAudio.sound_2,
		-- 	},
		-- },
		
		-- exit = {
		-- 	--退出动画
		-- 	action = {
		-- 		"moveExit",
		-- 		DIR.CLOCK_3,
		-- 	},

		-- 	--退出音效
		-- 	sound = {
		-- 		configAudio.sound_2,
		-- 	},
		-- },

		--背景面板的透明度
		pellucidity = 80,
	},
	
	--体力已满
	msgBox_PowerFull = {
		type = MSGBOX.NORMAL, --弹出框类型
		content = MSGCONTENT.POWERFULL, --弹出框内容
		
		enter = {
			--进入动画
			action = {
				"moveEaseElasticOutEnter",
				DIR.CLOCK_9,
			},

			--进入音效
			sound = {
				configAudio.sound_2,
			},
		},
		
		exit = {
			--退出动画
			action = {
				"moveExit",
				DIR.CLOCK_3,
			},

			--退出音效
			sound = {
				configAudio.sound_2,
			},
		},

		--背景面板的透明度
		pellucidity = 80,
	},

	--下载视频获得双倍奖励
	msgBox_VideoReward = {
		type = MSGBOX.NORMAL, --弹出框类型
		content = MSGCONTENT.VIDEOAD_DOUBLE_REWARD, --弹出框内容

		bg = "msgBox/fenxiangshiping.png",
		shieldCloseBtn = true,
		contentOffset = cc.p(0, -120),
		sureBtnOffset = cc.p(0, -120),

		enter = {
			--进入动画
			action = {
				"moveEaseElasticOutEnter",
				DIR.CLOCK_9,
			},

			--进入音效
			sound = {
				configAudio.sound_2,
			},
		},
		
		exit = {
			--退出动画
			action = {
				"moveExit",
				DIR.CLOCK_3,
			},

			--退出音效
			sound = {
				configAudio.sound_2,
			},
		},

		--背景面板的透明度
		pellucidity = 80,
	},

	--加五步体验提示
	msgBox_FiveStep = {
		type = MSGBOX.NORMAL, --弹出框类型
		content = MSGCONTENT.FIVESTEP, --弹出框内容

		bg = "msgBox/fenxiangshiping.png",
		shieldCloseBtn = true,
		contentOffset = cc.p(0, -120),
		sureBtnOffset = cc.p(0, -120),

		enter = {
			--进入动画
			action = {
				"moveEaseElasticOutEnter",
				DIR.CLOCK_9,
			},

			--进入音效
			sound = {
				configAudio.sound_2,
			},
		},
		
		exit = {
			--退出动画
			action = {
				"moveExit",
				DIR.CLOCK_3,
			},

			--退出音效
			sound = {
				configAudio.sound_2,
			},
		},

		--背景面板的透明度
		pellucidity = 80,
	},
};

return configPanel;
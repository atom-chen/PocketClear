local configGuide = {
	--关卡引导索引顺序对应关卡当前索引
	--信息面板引导索引顺序对应当前关卡索引+1000
	--道具面板引导索引顺序对应当前关卡索引+2000

	--关卡1新手引导
	[1] = {
		[1] = {
			root = "main",
			des={path="image/guide/dianji2ge.png", pos=cc.p(0, -330),  scale = 0.8,}, 
			hlArea = {{name="Cube74",}, {name="Cube75",},},
			clickArea={{name="Cube75",},},
		},

		[2] = {
			delay = 1.2,
		},

		[3] = {
			root = "main",
			des={path="image/guide/BC_genduotangguo.png", pos=cc.p(0, 260), scale = 0.7, }, 
			hlArea = {{name="Cube65",}, {name="Cube66",}, {name="Cube56",}, {name="Cube57",},},
			clickArea={{name="Cube57",},},
		},
		
		[4] = {
			delay = 1.2,
		},

		[5] = {
			root = "main",
			des={path="image/guide/zaiwancheng.png", pos=cc.p(0, -80),}, 
			hlArea = {{name="taskCon",}, {name="action",},},
		},
	},

	[2] = {
		[1] = {
			des={path="image/guide/sigeyanse.png", pos=cc.p(0, 280), scale = 0.75,}, 
			root = "main",
			hlArea = {{name="Cube46",}, {name="Cube47",}, {name="Cube48",}, {name="Cube49",}, {name="Cube50",}, {name="Cube58",}, },
			clickArea={{name="Cube50",}, },
		},
		
		[2] = {
			delay = 1.5,
		},
		[3] = {
			des={path="image/guide/xiaochuyihang.png", pos=cc.p(0, -250), scale = 0.8, }, 
			root = "main",
			hlArea = {{name="Cube49",},},
			clickArea={{name="Cube49",},},
		},
		
		[4] = {
			delay = 1.5,
		},

		[5] = {
			des={path="image/guide/xiaochushupai.png", pos=cc.p(0, 150), scale = 0.9, }, 
			root = "main",
			hlArea = {{name="Cube38",}, {name="Cube29",}, {name="Cube20",}, {name="Cube11",}, {name="Cube2",}, {name="Cube21",},},
			clickArea={{name="Cube21",},},
		},
	},

	[3] = {
		[1] = {
			des={path="image/guide/Lxing.png", pos=cc.p(0, -300), scale = 0.83,}, 
			root = "main",
			hlArea = {{name="Cube75",}, {name="Cube66",},{name="Cube57",},{name="Cube58",},{name="Cube59",},{name="Cube60",},{name="Cube68",},},
			clickArea={{name="Cube60",}, },
			jumpBtn={orientation=1,},
		},

		[2] = {
			delay = 1.8,
		},

		[3] = {
			
			root = "main",
			hlArea = {{name="Cube59",},},
			clickArea={{name="Cube59",},},
		},

		[4] = {
			delay = 1.8,
		},

		[5] = {
			des={path="image/guide/Txing.png", pos=cc.p(0, 100),}, 
			root = "main",
			hlArea = {{name="Cube31",}, {name="Cube32",}, {name="Cube33",}, {name="Cube22",}, {name="Cube23",}, {name="Cube24",}, {name="Cube14",}, {name="Cube5",},},
			clickArea={{name="Cube24",}, },
		},

		[6] = {
			delay = 1.8,
		},

		[7] = {
			des={path="image/guide/gezhongxingzhuang.png", pos=cc.p(0, -20),},
		},
		
		[8] = {
			des={path="image/guide/shoujisucai.png", pos=cc.p(0, -80),}, 
			root = "main",
			hlArea = {{name="taskCon",},  {name="action",},}
		}
	},

	[5] = {
	
		[1] = {
			des={path="image/guide/chiqiaokeli.png", pos=cc.p(0, 100), scale = 0.8, }, 
			root = "main",
			hlArea = {{name="Cube20",}, {name="Cube19",},{name="Cube29",},},
			clickArea={{name="Cube20",}, },
		},

		[2] = {
			delay = 2,
		},

		[3] = {
			des={path="image/guide/shouji6ge.png", pos=cc.p(0, 100), scale = 0.9, }, 
			root = "main",
			hlArea = {{name="taskCon",},  },
		},
	},
	
	[7] = {
	
		[1] = {
			des={path="image/guide/afeichuxian.png", pos=cc.p(0, -63), }, 
			root = "main",
			hlArea = {{name="taskCon",},  },
		},
	},
	
	[9] = {
		[1] = {
			des={path="image/guide/tangguodongzhu.png", pos=cc.p(0, 30),}, 
			root = "main",
			hlArea = {{name="Cube21",}, {name="Cube20",},},
			clickArea={{name="Cube21",},},
		},

		[2] = {
			delay = 1.5,
		},

		[3] = {
			des={path="image/guide/liangjingjing.png", pos=cc.p(0, 0),}, 
			root = "main",
			hlArea = {{name="taskCon",},  },
		},
	},

	[10] = {
		[1] = {
			des={path="image/guide/BC_xiaomuchui.png", pos=cc.p(0, 30),}, 
			root = "main",
			hlArea = {{name="itemCon2",},},
			clickArea={{name="itemCon2",},},
			give={{id=29, num=1,},},
			jumpBtn={orientation=9,},
		},

		[2] = {
			root = "main",
			hlArea = {{name="Cube49",},},
			clickArea={{name="Cube49",},},
		},

		[3] = {
			delay = 1.8,
		},

		[4] = {
			des={path="image/guide/BC_songlianggemuchui.png", pos=cc.p(0, 0),},
			give={{id=29, num=2,},},
		},
	},
	
	[12] = {
	
		[1] = {
			des={path="image/guide/bingqiling.png", pos=cc.p(0, -50), scale = 0.8, }, 
			root = "main",
			hlArea = {{name="Cube73",}, },
		},

		[2] = {
			root = "main",
			hlArea = {{name="Cube10",}, {name="Cube19",},},
			clickArea={{name="Cube10",}, },
		},

		[3] = {
			delay = 1.8,
		},

		[4] = {
			root = "main",
			hlArea = {{name="Cube1",},},
			clickArea={{name="Cube1",},},
		},

		[5] = {
			delay = 1.8,
		},
	},

	[13] = {
		[1] = {
			des={path="image/guide/BC_chongxinbailie.png", pos=cc.p(0, -150),}, 
			root = "main",
			hlArea = {{name="itemCon1",},},
			jumpBtn={orientation=9,},
		},
	},

	[15] = {
		[1] = {
			des={path="image/guide/BC_afeiyouchuxian.png", pos=cc.p(0, 0),},
		},

		[2] = {
			root = "main",
			des={path="image/guide/BC_dayunafei.png", pos=cc.p(0, 200),},
			hlArea = {{name="Cube47",}, {name="Cube48",},{name="Cube38",},{name="Cube39",},{name="Cube29",},{name="Cube30",},},
			clickArea={{name="Cube30",}, },
		},

		[3] = {
			delay = 2,
		},

		[4] = {
			des={path="image/guide/BC_bunengzhizao.png", pos=cc.p(0, -100),}, 
			root = "main",
		},
	},
	
	--第十七关倒计时引导
	[17] = {
		[1] = {
			root = "main",
			des={path="image/guide/duoduohecheng.png", pos=cc.p(0, -300), scale = 0.8, },
			hlArea = {{name="action",},},
		},
	},

	[18] = {
		[1] = {
			root = "main",
			des={path="image/guide/Godpig_xinshou.png", pos=cc.p(0, -300),}, 
			hlArea = {{name="Cube47",},},
			clickArea={{name="Cube47",},},
		},
	},

	[20] = {
		[1] = {
			root = "main",
			des={path="image/guide/BC_tangguohezixiaochu.png", pos=cc.p(0, 120),},
			hlArea = {{name="Cube32",}, {name="Cube31",},},
			clickArea={{name="Cube32",}, },
		},

		[2] = {
			delay = 1.2,
		},

		[3] = {
			des={path="image/guide/BC_shoujitangguohezi.png", pos=cc.p(0, 30),}, 
			root = "main",
			hlArea = {{name="taskCon",},},
		},
	},

	[22] = {
		[1] = {
			des={path="image/guide/BC_shiyongcaihongtang.png", pos=cc.p(0, 50),}, 
			root = "main",
			hlArea = {{name="itemCon4",},},
			clickArea={{name="itemCon4",},},
			give = {{id=25, num=1,},},
		},
		
		[2] = {
			root = "main",
			hlArea = {{name="Cube29",},},
			clickArea={{name="Cube29",},},
		},

		[3] = {
			delay = 2,
		},

		[4] = {
			des={path="image/guide/BC_songyigecaihongtang.png", pos=cc.p(0, 30),}, 
			root = "main",
			give = {{id=25, num=2,},},
		},
	},
	
	[27] = {
		[1] = {
			des={path="image/guide/BC_tongguanshenqi.png", pos=cc.p(0, -120), scale = 0.7,}, 
			root = "main",
			hlArea = {{name="itemCon3",},},
			clickArea={{name="itemCon3",},},
			give = {{id=30, num=1,},},
		},

		[2] = {
			root = "main",
			hlArea = {{name="Cube40",},},
			clickArea={{name="Cube40",},},
		},

		[3] = {
			root = "main",
			hlArea = {{name="Cube40",},},
			clickArea={{name="Cube40",},},
		},

		[4] = {
			delay = 2,
		},

		[5] = {
			des={path="image/guide/BC_zaisong2gezhadan.png", pos=cc.p(0, 0),},
			give = {{id=30, num=2,},},
		},
	},

	[30] = {
		[1] = {
			des={path="image/guide/BC_huandiaozise.png", pos=cc.p(0, -300), scale = 0.7,}, 
			root = "main",
			hlArea = {{name="Cube57",},{name="Cube58",},{name="Cube59",},{name="Cube49",},{name="Cube40",},},
			give = {{id=26, num=1,},},
		},

		[2] = {
			des={path="image/guide/BC_dianjihuanse.png", pos=cc.p(0, -130), scale = 0.7,}, 
			root = "main",
			hlArea = {{name="itemCon5",},},
			clickArea={{name="itemCon5",},},
		},

		[3] = {
			des={path="image/guide/BC_dianjihuansetangguo.png", pos=cc.p(0, -300), scale = 0.7,}, 
			root = "main",
			hlArea = {{name="Cube49",},},
			clickArea={{name="Cube49",},},
			give = {{id=26, num=2,},},
		},
	},

	[34] = {
		[1] = {
			root = "main",
			des={path="image/guide/jiezixinshou.png", pos=cc.p(0, -200),}, 
			hlArea = {{name="Cube67",},{name="Cube68",},},
			clickArea={{name="Cube68",},},
		},

		[2] = {
			root = "main",
			hlArea = {{name="Cube59",},{name="Cube60",},},
			clickArea={{name="Cube60",},},
		},

		[3] = {
			root = "main",
			hlArea = {{name="Cube57",},{name="Cube66",},},
			clickArea={{name="Cube57",},},
		},
	},

	[42] = {
		[1] = {
			root = "main",
			des={path="image/guide/cake_xinshou.png", pos=cc.p(0, -200),}, 
			hlArea = {{name="Cube55",},{name="Cube56",},},
			clickArea={{name="Cube56",},},
		},

		[2] = {
			root = "main",
			hlArea = {{name="Cube38",},{name="Cube47",},},
			clickArea={{name="Cube38",},},
		},

		[3] = {
			root = "main", 
			hlArea = {{name="Cube28",},{name="Cube37",},},
			clickArea={{name="Cube28",},},
		},
	},

	[112] = {
		[1] = {
			root = "main",
			des={path="image/guide/yansezhizaoji_xinshou.png", pos=cc.p(0, 200),}, 
			hlArea = {{name="Cube39",},{name="Cube40",},},
			clickArea={{name="Cube40",},},
		},

		[2] = {
			root = "main",
			hlArea = {{name="Cube56",},{name="Cube47",},},
			clickArea={{name="Cube47",},},
		},

		[3] = {
			root = "main",
			hlArea = {{name="Cube20",},{name="Cube29",},},
			clickArea={{name="Cube20",},},
		},
	},

	[135] = {
		[1] = {
			root = "main",
			des={path="image/guide/fudai_xinshou.png", pos=cc.p(0, -100),}, 
			hlArea = {{name="Cube3",},{name="Cube4",},{name="Cube5",},},
			clickArea={{name="Cube5",},},
		},
	},

	--第九关信息面板购买道具+3步
	[1009] = {
		[1] = {
			root = "selectLevel",
			des = {path="image/guide/BC_jia3bu.png", pos=cc.p(0, 150),},
			hlArea = {{name="itemCon1",},},
			clickArea={{name="itemCon1",},},
			give = {{id=1, num=100,},},
		};
	},
	
	--第十三关购买道具 刷新
	[1013] = {
		[1] = {
			root = "selectLevel", 
			des = {path="image/guide/BC_chongxinbailie.png", pos=cc.p(0, 150),},
			hlArea = {{name="itemCon3",},},
			clickArea={{name="itemCon3",},},
			give = {{id=1, num=180,},},
		};
	},

	--第二十一关道具购买 爆炸与直线
	[1021] = {
		[1] = {
			root = "selectLevel", 
			des = {path="image/guide/BC_zhadanyuzhixian.png", pos=cc.p(0, 150),},
			hlArea = {{name="itemCon2",},},
			clickArea={{name="itemCon2",},},
			give = {{id=1, num=300,},},
		};
	},
	
	--新手任务引导
	[3001] = {
		[1] = {
			root = "selectLevel",
			clickArea = {{name="magicTrip",},},
			hlArea = {{name="magicTrip",},},
		},

		[2] = {
				delay = 0.5,
			},

		[3] = {
			root = "selectLevel",
			des={path="image/guide/RW_renwujiangli.png", pos=cc.p(0, 0), scale = 0.8, },
		},
	},

	--==================================
	--关卡选择界面引导图标点击
	--==================================
	--解锁签到
	[10006] = {
		[1] = {
			root = "selectLevel",
			des={path="image/guide/qiandao_xinshou.png", pos=cc.p(0, -80),}, 
			hlArea = {{name="signIn",},},
			clickArea={{name="signIn", offsetPos=cc.p(100, 60),},},
		},

		[2] = {
			delay = 1.0,
		},

		[3] = {
			root = "selectLevel",
			hlArea = {{name="getBtn",},},
			clickArea={{name="getBtn", offsetPos=cc.p(80, 20),},},
			jumpBtn={shield=true,},
		},
	},

	--解锁奇幻之旅
	[10007] = {
		[1] = {
			root = "selectLevel",
			des={path="image/guide/qihuanlvcheng_xinshou.png", pos=cc.p(0, -180),}, 
			hlArea = {{name="magicTrip",},},
			clickArea={{name="magicTrip", offsetPos=cc.p(100, 60),},},
		},

		[2] = {
			delay = 1.0,
		},

		[3] = {
			root = "selectLevel", 
			hlArea = {{name="getBtn",},},
			clickArea={{name="getBtn", offsetPos=cc.p(100, 0),},},
		},
	},
	
	--解锁星级奖励
	[10010] = {
		[1] = {
			root = "selectLevel",
			des={path="image/guide/xingxingjiangli_xinshou.png", pos=cc.p(0, -240),}, 
			hlArea = {{name="starReward",},},
			clickArea={{name="starReward", offsetPos=cc.p(100, 60),},},
		},

		[2] = {
			delay = 1.0,
		},

		[3] = {
			root = "selectLevel", 
			hlArea = {{name="getBtn",},},
			clickArea={{name="getBtn", offsetPos=cc.p(100, 0),},},
		},
	},
	
	--转盘解锁
	[10014] = {
		[1] = {
			root = "selectLevel",
			des={path="image/guide/zaiwancheng.png", pos=cc.p(0, -80),}, 
			hlArea = {{name="wheel",},},
			clickArea={{name="wheel", offsetPos=cc.p(100, 60),},},
		},

		[2] = {
			delay = 1.0,
		},

		[3] = {
			root = "selectLevel", 
			hlArea = {{name="diamondBtn",},},
			clickArea={{name="diamondBtn", offsetPos=cc.p(100, 0),},},
		},
	},

	--第一次转盘操作完成后,引导他看视频继续转盘
	[20014] = {
		[1] = {
			root = "selectLevel", 
			des={path="image/guide/zaiwancheng.png", pos=cc.p(0, -80),}, 
			hlArea = {{name="adBtn",},},
			clickArea={{name="adBtn", offsetPos=cc.p(100, 0),},},
			jumpBtn={shield=true,},
		},
	},

	--解锁翻牌
	[10020] = {
		[1] = {
			root = "selectLevel",
			des={path="image/guide/fanpaijiangli_xinshou.png", pos=cc.p(0, 140),}, 
			hlArea = {{name="flipBrand",},},
			clickArea={{name="flipBrand", offsetPos=cc.p(100, 60),},},
		},
	},
};

return configGuide;
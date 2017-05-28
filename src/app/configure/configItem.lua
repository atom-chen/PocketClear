local configItem = {
	[1]   = {id=1, name="金币属性", 	 type="基础属性", icon="texture/common/item_12.png", title="texture/common/font_SC_jinbi.png",}, --玩家拥有金币属性
	[2]   = {id=2, name="钻石属性", 	 type="基础属性", icon="texture/common/zhuanshi.png",}, --玩家拥有钻石属性
	[3]   = {id=3, name="星级属性", 	 type="基础属性", }, --玩家拥有星星属性
	[4]   = {id=4, name="体力属性", 	 type="基础属性", icon="texture/common/img_cp_power.png",}, --玩家拥有体力属性
	[5]   = {id=5, name="分数属性", 	 type="基础属性", }, --玩家拥有总分数属性
	
	-- [11]  = {id=11, name="金币", 	 type="基础道具", coin=100, diamond=100,  title="", icon="texture/common/item_12.png", des="",}, --金币道具
	-- [12]  = {id=12, name="钻石", 	 type="基础道具", coin=100, diamond=100,  title="", icon="texture/common/zhuanshi.png", des="",}, --钻石道具
	-- [13]  = {id=13, name="体力",     type="基础道具", coin=100, diamond=100,  title="", icon="texture/common/img_cp_power.png", des="",}, --体力道具
	
	[20]  = {id=20, name="小体力瓶", type="基础道具", coin=180, 	diamond=30,  title="texture/common/font_xiaotili.png",   		icon="texture/common/item_1.png", des="texture/common/font_huifu5dian.png",}, 
	[21]  = {id=21, name="大体力瓶", type="基础道具", coin=900, 	diamond=150, title="texture/common/font_datili.png", 	  		icon="texture/common/item_2.png", des="texture/common/font_huifu30dian.png",}, 
	[22]  = {id=22, name="加五步", 	 type="基础道具", coin=300, 	diamond=50,  title="texture/common/font_jiawubu.png", 	  		icon="texture/common/item_6.png", des="texture/common/font_zengjia.png",}, 
	[23]  = {id=23, name="刷新", 	 type="基础道具", coin=180, 	diamond=30,  title="texture/common/font_shuaxin.png", 			icon="texture/common/item_8.png", des="texture/common/font_chongxinpailie.png",}, 
	[24]  = {id=24, name="时光机", 	 type="基础道具", coin=300, 	diamond=50,  title="texture/common/font_shiguangji.png", 		icon="texture/common/item_7.png", des="texture/common/font_zengjia30miao.png",}, 
	[25]  = {id=25, name="彩虹糖", 	 type="基础道具", coin=510, 	diamond=85,  title="texture/common/font_caihongtang.png",  	icon="texture/common/item_3.png", des="texture/common/font_shuoming.png",},
	[26]  = {id=26, name="换色刷", 	 type="基础道具", coin=300, 	diamond=50,  title="texture/common/font_huanseshua.png", 		icon="texture/common/item_5.png", des="texture/common/font_huanse.png",}, 
	[27]  = {id=27, name="横向消除", type="基础道具", coin=120, 	diamond=20,  title="", 					  					icon="texture/common/item_2.png", des="",}, 
	[28]  = {id=28, name="竖向消除", type="基础道具", coin=120, 	diamond=20,  title="", 					  					icon="texture/common/item_2.png", des="",}, 
	[29]  = {id=29, name="小木槌", 	 type="基础道具", coin=180, 	diamond=30,  title="texture/common/font_bobantang.png", 		icon="texture/common/item_9.png", des="texture/common/font_xiaochuzhiding.png",}, 
	[30]  = {id=30, name="糖果炸弹", type="基础道具", coin=420, 	diamond=70,  title="texture/common/font_tangguozhadan.png", 	icon="texture/common/item_4.png", des="texture/common/font_xiaochu33.png",}, 
	
	[31]  = {id=31, name="480金币",  type="基础道具", coin=600, 	diamond=100,  title="texture/common/font_3wanjinbi.png",  		icon="texture/common/item_15.png", des="", pack={{id=1, num=480,},},}, --3W金币道具
	[32]  = {id=32, name="1920金币", type="基础道具", coin=1800, 	diamond=288,  title="texture/common/font_10wanjinbi.png", 		icon="texture/common/item_16.png", des="", pack={{id=1, num=1920,},},}, --10W金币道具
	
	[33]  = {id=33, name="加3步",    	type="临时道具", coin=100, diamond=16, title="", icon="texture/common/item_13.png", des="",}, 
	[34]  = {id=34, name="爆炸与直线",  type="临时道具", coin=300, diamond=50, title="", icon="texture/common/item_14.png", des="",}, 
	[35]  = {id=35, name="加15秒",    	type="临时道具", coin=100, diamond=16, title="", icon="texture/common/item_17.png", des="",}, 
	
	[36]  = {id=36, name="钻石转盘1-2次门票",    	type="临时道具", diamond=20, 	title="", icon="texture/common/item_17.png", des="",}, 
	[37]  = {id=37, name="钻石转盘3-4次门票",    	type="临时道具", diamond=40, 	title="", icon="texture/common/item_17.png", des="",}, 
	[38]  = {id=38, name="钻石转盘4次以后门票",    	type="临时道具", diamond=60, 	title="", icon="texture/common/item_17.png", des="",},
	[39]  = {id=39, name="钻石转盘0次门票",    		type="临时道具", diamond=0,		title="", icon="texture/common/item_17.png", des="",}, 
	[40]  = {id=40, name="补满体力",    			type="基础道具", diamond=150, 	title="", icon="texture/common/item_17.png", des="",}, 
	
	--rmb支付
	-- [101] = {id=101, name_p="freshDiamond", 	name="新手钻石礼包",		point=1,  rmb=0.1, 	repeatBuy=false, type="礼包", title="", icon="", des="", poster="image/shop_xinshouzuanshi.png",				pack={{id=2, num=100,},},},
	[102] = {id=102, name_p="doubleCoin", 		name="永久双倍金币",		point="xiong001",  rmb=18, 	repeatBuy=false, type="礼包", title="", icon="", des="", poster="image/shop_shuangbeijinbi.png", 				}, 
	[103] = {id=103, name_p="diamond_1", 		name="经典钻石礼包",		point="xiong007",  rmb=6, 	repeatBuy=true,  type="礼包", title="texture/common/font_SC_zhuanshi.png", icon="texture/common/zhuanshi.png", 	des="", poster="image/.png", 	pack={{id=2, num=60,},},}, 
	[104] = {id=104, name_p="diamond_2", 		name="超值钻石礼包",		point="xiong008",  rmb=18, 	repeatBuy=true,  type="礼包", title="texture/common/font_SC_zhuanshi.png", icon="texture/common/SC_zuanshi02.png", des="", poster="image/.png", 	pack={{id=2, num=180,}, {id=2, num=40,},},}, 
	[105] = {id=105, name_p="diamond_3", 		name="豪华钻石礼包",		point="xiong009",  rmb=128, repeatBuy=true,  type="礼包", title="texture/common/font_SC_zhuanshi.png", icon="texture/common/SC_zuanshi03.png", des="", poster="image/.png", 	pack={{id=2, num=1280,}, {id=2, num=520,},},}, 
	[106] = {id=106, name_p="firstRecharge", 	name="首充大礼包",			point="xiong006",  rmb=1, 	repeatBuy=false, type="礼包", title="", icon="", des="", poster="image/shop_shouchonglibao.png", 				pack={{id=30, num=3,}, {id=29, num=3,}, {id=21, num=1,},},}, 
	[107] = {id=107, name_p="luxuryGift", 		name="豪华大礼包",			point="xiong002",  rmb=12, 	repeatBuy=true,  type="礼包", title="", icon="", des="", poster="image/shop_haohualibao.png", 					pack={{id=30, num=6,}, {id=29, num=6,}, {id=20, num=6,}, {id=1, num=200,},},}, 
	[108] = {id=108, name_p="extreme", 			name="至尊大礼包",			point="xiong003",  rmb=30, 	repeatBuy=false, type="礼包", title="", icon="", des="", poster="image/shop_zhizhunlibao.png", 					pack={{id=25, num=10,}, {id=30, num=10,}, {id=29, num=10,}, {id=20, num=10,}, {id=1, num=500,},},}, 
	[109] = {id=109, name_p="flipBrand", 		name="全部奖励",			point="xiong004",  rmb=6, 	repeatBuy=true,  type="礼包", title="", icon="", des="", poster="image/.png", 									}, 
	[110] = {id=110, name_p="bearGift", 		name="倒霉熊的礼物",		point="xiong005",  rmb=18, 	repeatBuy=false, type="礼包", title="", icon="", des="", poster="image/.png", 									pack={{id=25, num=6,}, {id=26, num=6,}, {id=30, num=6,}, {id=29, num=6,}, {id=2, num=88,},},}, 
	-- [111] = {id=111, name_p="vipDiamond", 	name="VIP钻石大礼包",		point=11, rmb=15, 	repeatBuy=true,  type="礼包", title="", icon="", des="", poster="image/.png", 									pack={{id=2, num=1950,},},}, --
	-- [112] = {id=112, name_p="fullPower", 	name="补满体力",			point=12, rmb=15, 	repeatBuy=true,  type="礼包", title="", icon="", des="", poster="image/.png", 									},
	-- [113] = {id=113, name_p="fiveStep", 		name="加5步",				point=13, rmb=5, 	repeatBuy=true,  type="礼包", title="", icon="", des="", poster="image/.png", 									},
	[114] = {id=114, name_p="coinSmall", 		name="一小袋金币",			point="xiong010", rmb=6, 	repeatBuy=true,  type="礼包", title="texture/common/font_SC_jinbi.png", icon="texture/common/item_15.png", des="", poster="image/.png", 		pack={{id=1, num=480,},},}, 
	[115] = {id=115, name_p="coinBig", 			name="一大袋金币",			point="xiong011", rmb=30, 	repeatBuy=true,  type="礼包", title="texture/common/font_SC_jinbi.png", icon="texture/common/item_16.png", des="", poster="image/.png", 		pack={{id=1, num=1800,}, {id=1, num=120,},},}, 
	
	--临时活动
	[200] = {id=200, timebar=3600, name="欢迎礼包", type="免费活动", title="texture/common/font_tangguozhadan.png", icon="texture/common/item_4.png", des="texture/common/font_xiaochu33.png", pack={{id=2, num=68}, {id=1, num=288}, {id=20, num=5},},}, 
	
	--红包
	[201] = {id=201, timebar=300, name="红包1", type="免费活动", title="", 	icon="", des="", pack={{id=2, num={min=5, 	max=10,},},},}, 
	[202] = {id=202, timebar=300, name="红包2", type="免费活动", title="", 	icon="", des="", pack={{id=2, num={min=8, 	max=15,},},},}, 
	[203] = {id=203, timebar=600, name="红包3", type="免费活动", title="", 	icon="", des="", pack={{id=2, num={min=10, max=25,},},},}, 
	[204] = {id=204, timebar=900, name="红包4", type="免费活动", title="", 	icon="", des="", pack={{id=2, num={min=20, max=35,},},},},
	[205] = {id=205, timebar=1200, name="红包5", type="免费活动", title="", 	icon="", des="", pack={{id=2, num={min=30, max=45,},},},},
	[206] = {id=206, timebar=1800, name="红包6", type="免费活动", title="", 	icon="", des="", pack={{id=2, num={min=40, max=55,},},},},
	
	--免费钻石奖励
	[220] = {id=220, name="免费金币", type="免费活动", title="", 	icon="", des="", pack={{id=1, num={min=50, max=100,},},},}, 
	[221] = {id=221, name="免费钻石", type="免费活动", title="", 	icon="", des="", pack={{id=2, num={min=10, max=30,},},},}, 
	[222] = {id=222, name="免费金币", type="免费活动", title="", 	icon="", des="", pack={{id=1, num={min=100, max=200,},},},}, 
	[223] = {id=223, name="免费钻石", type="免费活动", title="", 	icon="", des="", pack={{id=2, num={min=30, max=50,},},},}, 
};

return configItem;
local configPoint = {
	--======================================================
	--					   基础面板配置
	--======================================================

	panel = {
		["102"] = 	{texture="image/gift_shuangbeijinbi.png",},--双倍金币 --doubleCoin

		["103"] = 	{texture=nil,},--豪华钻石1--diamond_1
		["104"] = 	{texture=nil,},--豪华钻石1 --diamond_2
		["105"] = 	{texture="image/gift_haohuazuanshi.png",},--豪华钻石3 --diamond_3

		["106"] = 	{texture="image/gift_shouchonglibao.png",}, --首充大礼包 --firstRecharge
		["107"] = 	{texture="image/gift_haohualibao.png",},--豪华大礼包 --luxuryGift
		["108"] = 	{texture="image/gift_zhizunlibao.png",},--至尊礼包 --extreme
		["109"] = 	{texture=nil, }, --翻牌 --flipBrand
		["110"] = 	{texture="image/gift_xiongdeliwu.png",},--倒霉熊的礼物 --bearGift
		
		["114"] = 	{texture=nil,}, --小金币 --coinSmall
		["115"] = 	{texture="image/gift_dadaijinbi.png",}, --大金币 --coinBig
	},
	
	--======================================================
	--					   营销皮肤
	--======================================================
	--关闭按钮: cb_pos_offset(关闭按钮坐标偏移), cb_scale(关闭按钮的缩放)
	--购买按钮: bb_pos_offset(购买按钮坐标偏移), bb_scale(购买按钮的缩放), bb_font(购买按钮字体),
	--资费提示: cue_pos_offset(资费提示坐标偏移), cue_scale(资费提示的缩放), cue_color(资费提示颜色), cue_hide(是否隐藏)
	
	--白包皮肤
	skin0 = {
		["102"] = 	{cb_pos_offset=cc.p(260, 134), bb_pos_offset=cc.p(-130, -390), cue_pos_offset=cc.p(0, -320), },--双倍金币 --doubleCoin

		["103"] = 	{cb_pos_offset=cc.p(260, 134), bb_pos_offset=cc.p(0, -150), cue_pos_offset=cc.p(80, -85), },--豪华钻石1--diamond_1
		["104"] = 	{cb_pos_offset=cc.p(260, 134), bb_pos_offset=cc.p(0, -150), cue_pos_offset=cc.p(80, -85), },--豪华钻石1 --diamond_2
		["105"] = 	{cb_pos_offset=cc.p(260, 134), bb_pos_offset=cc.p(0, -150), cue_pos_offset=cc.p(90, -85), },--豪华钻石3 --diamond_3
		
		["106"] = 	{cb_pos_offset=cc.p(300, 210), bb_pos_offset=cc.p(0, -420), cue_pos_offset=cc.p(0, -320), }, --首充大礼包 --firstRecharge
		["107"] = 	{cb_pos_offset=cc.p(310, 210), bb_pos_offset=cc.p(0, -440), cue_pos_offset=cc.p(0, -350), },--豪华大礼包 --luxuryGift
		["108"] = 	{cb_pos_offset=cc.p(280, 330), bb_pos_offset=cc.p(0, -340), cue_pos_offset=cc.p(0, -260), },--至尊礼包 --extreme
		["109"] = 	{cb_pos_offset=cc.p(300, 360), bb_pos_offset=cc.p(-150, -320), cue_pos_offset=cc.p(0, -275), }, --翻牌 --flipBrand
		["110"] = 	{cb_pos_offset=cc.p(280, 330), bb_pos_offset=cc.p(0, -340), cue_pos_offset=cc.p(0, -250), },--倒霉熊的礼物 --bearGift
		
		["114"] = 	{cb_pos_offset=cc.p(260, 134), bb_pos_offset=cc.p(0, -150), cue_pos_offset=cc.p(70, -85), }, --小金币 --coinSmall
		["115"] = 	{cb_pos_offset=cc.p(260, 134), bb_pos_offset=cc.p(0, -150), cue_pos_offset=cc.p(70, -85), }, --大金币 --coinBig
	},

	--确认+叉叉
	skin1 = {
		["102"] = 	{cb_pos_offset=cc.p(-260, 134), cb_scale= 0.6, bb_pos_offset=cc.p(-130, -390), bb_scale= 1.3, bb_font="texture/common/font_queding.png", cue_pos_offset=cc.p(0, -320), cue_scale= 0.7, cue_color=cc.c4b(125, 125, 125, 200), },--双倍金币 --doubleCoin

		["103"] = 	{cb_pos_offset=cc.p(-260, 134), cb_scale= 0.6, bb_pos_offset=cc.p(0, -150), bb_scale= 1.3, bb_font="texture/common/font_queding.png", cue_pos_offset=cc.p(80, -85), cue_scale= 0.7, cue_color=cc.c4b(125, 125, 125, 200), },--豪华钻石1--diamond_1
		["104"] = 	{cb_pos_offset=cc.p(-260, 134), cb_scale= 0.6, bb_pos_offset=cc.p(0, -150), bb_scale= 1.3, bb_font="texture/common/font_queding.png", cue_pos_offset=cc.p(80, -85), cue_scale= 0.7, cue_color=cc.c4b(125, 125, 125, 200), },--豪华钻石1 --diamond_2
		["105"] = 	{cb_pos_offset=cc.p(-260, 134), cb_scale= 0.6, bb_pos_offset=cc.p(0, -150), bb_scale= 1.3, bb_font="texture/common/font_queding.png", cue_pos_offset=cc.p(80, -85), cue_scale= 0.7, cue_color=cc.c4b(125, 125, 125, 200), },--豪华钻石3 --diamond_3

		["106"] = 	{cb_pos_offset=cc.p(-300, 210), cb_scale= 0.6, bb_pos_offset=cc.p(0, -420), bb_scale= 1.3, bb_font="texture/common/font_queding.png", cue_pos_offset=cc.p(0, -320), cue_scale= 0.7, cue_color=cc.c4b(125, 125, 125, 200), }, --首充大礼包 --firstRecharge
		["107"] = 	{cb_pos_offset=cc.p(-310, 210), cb_scale= 0.6, bb_pos_offset=cc.p(0, -440), bb_scale= 1.3, bb_font="texture/common/font_queding.png", cue_pos_offset=cc.p(0, -350), cue_scale= 0.7, cue_color=cc.c4b(125, 125, 125, 200), },--豪华大礼包 --luxuryGift
		["108"] = 	{cb_pos_offset=cc.p(-280, 330), cb_scale= 0.6, bb_pos_offset=cc.p(0, -340), bb_scale= 1.3, bb_font="texture/common/font_queding.png", cue_pos_offset=cc.p(0, -260), cue_scale= 0.7, cue_color=cc.c4b(125, 125, 125, 200), },--至尊礼包 --extreme
		["109"] = 	{cb_pos_offset=cc.p(-300, 360), cb_scale= 0.6, bb_pos_offset=cc.p(-150, -350), bb_scale= 1.3, bb_font="texture/common/font_queding.png", cue_pos_offset=cc.p(0, -275), cue_scale= 0.7, cue_color=cc.c4b(125, 125, 125, 200), }, --翻牌 --flipBrand
		["110"] = 	{cb_pos_offset=cc.p(-280, 330), cb_scale= 0.6, bb_pos_offset=cc.p(0, -340), bb_scale= 1.3, bb_font="texture/common/font_queding.png", cue_pos_offset=cc.p(0, -250), cue_scale= 0.7, cue_color=cc.c4b(125, 125, 125, 200), },--倒霉熊的礼物 --bearGift
		
		["114"] = 	{cb_pos_offset=cc.p(-260, 134), cb_scale= 0.6, bb_pos_offset=cc.p(0, -150), bb_scale= 1.3, bb_font="texture/common/font_queding.png", cue_pos_offset=cc.p(70, -85), cue_scale= 0.7, cue_color=cc.c4b(125, 125, 125, 200), },--小金币 --coinSmall
		["115"] = 	{cb_pos_offset=cc.p(-260, 134), cb_scale= 0.6, bb_pos_offset=cc.p(0, -150), bb_scale= 1.3, bb_font="texture/common/font_queding.png", cue_pos_offset=cc.p(70, -85), cue_scale= 0.7, cue_color=cc.c4b(125, 125, 125, 200), },--大金币 --coinBig
	},
	
	--购买+叉叉
	skin2 = {
		["102"] = 	{cb_pos_offset=cc.p(-260, 134), cb_scale= 0.6, bb_pos_offset=cc.p(-130, -390), bb_scale= 1.3, cue_pos_offset=cc.p(0, -320), cue_scale= 0.7, cue_color=cc.c4b(125, 125, 125, 200), },--双倍金币 --doubleCoin

		["103"] = 	{cb_pos_offset=cc.p(-260, 134), cb_scale= 0.6, bb_pos_offset=cc.p(0, -150), bb_scale= 1.3, cue_pos_offset=cc.p(80, -85), cue_scale= 0.7, cue_color=cc.c4b(125, 125, 125, 200), },--豪华钻石1--diamond_1
		["104"] = 	{cb_pos_offset=cc.p(-260, 134), cb_scale= 0.6, bb_pos_offset=cc.p(0, -150), bb_scale= 1.3, cue_pos_offset=cc.p(80, -85), cue_scale= 0.7, cue_color=cc.c4b(125, 125, 125, 200), },--豪华钻石1 --diamond_2
		["105"] = 	{cb_pos_offset=cc.p(-260, 134), cb_scale= 0.6, bb_pos_offset=cc.p(0, -150), bb_scale= 1.3, cue_pos_offset=cc.p(80, -85), cue_scale= 0.7, cue_color=cc.c4b(125, 125, 125, 200), },--豪华钻石3 --diamond_3

		["106"] = 	{cb_pos_offset=cc.p(-300, 210), cb_scale= 0.6, bb_pos_offset=cc.p(0, -420), bb_scale= 1.3, cue_pos_offset=cc.p(0, -320), cue_scale= 0.7, cue_color=cc.c4b(125, 125, 125, 200), }, --首充大礼包 --firstRecharge
		["107"] = 	{cb_pos_offset=cc.p(-310, 210), cb_scale= 0.6, bb_pos_offset=cc.p(0, -440), bb_scale= 1.3, cue_pos_offset=cc.p(0, -350), cue_scale= 0.7, cue_color=cc.c4b(125, 125, 125, 200), },--豪华大礼包 --luxuryGift
		["108"] = 	{cb_pos_offset=cc.p(-280, 330), cb_scale= 0.6, bb_pos_offset=cc.p(0, -340), bb_scale= 1.3, cue_pos_offset=cc.p(0, -260), cue_scale= 0.7, cue_color=cc.c4b(125, 125, 125, 200), },--至尊礼包 --extreme
		["109"] = 	{cb_pos_offset=cc.p(-300, 360), cb_scale= 0.6, bb_pos_offset=cc.p(-150, -318), bb_scale= 1.3, cue_pos_offset=cc.p(0, -275), cue_scale= 0.7, cue_color=cc.c4b(125, 125, 125, 200), }, --翻牌 --flipBrand
		["110"] = 	{cb_pos_offset=cc.p(-280, 330), cb_scale= 0.6, bb_pos_offset=cc.p(0, -340), bb_scale= 1.3, cue_pos_offset=cc.p(0, -250), cue_scale= 0.7, cue_color=cc.c4b(125, 125, 125, 200), },--倒霉熊的礼物 --bearGift
		
		["114"] = 	{cb_pos_offset=cc.p(-260, 134), cb_scale= 0.6, bb_pos_offset=cc.p(0, -150), bb_scale= 1.3, cue_pos_offset=cc.p(70, -85), cue_scale= 0.7, cue_color=cc.c4b(125, 125, 125, 200), },--小金币 --coinSmall
		["115"] = 	{cb_pos_offset=cc.p(-260, 134), cb_scale= 0.6, bb_pos_offset=cc.p(0, -150), bb_scale= 1.3, cue_pos_offset=cc.p(70, -85), cue_scale= 0.7, cue_color=cc.c4b(125, 125, 125, 200), },--大金币 --coinBig
	},
	
	--确认+叉叉+资费隐藏
	skin4 = {
		["102"] = 	{cb_pos_offset=cc.p(-260, 134), cb_scale= 0.6, bb_pos_offset=cc.p(-130, -390), bb_scale= 1.3, bb_font="texture/common/font_lingqu.png",  cue_hide=true,},--双倍金币 --doubleCoin

		["103"] = 	{cb_pos_offset=cc.p(-260, 134), cb_scale= 0.6, bb_pos_offset=cc.p(0, -150), bb_scale= 1.3, bb_font="texture/common/font_lingqu.png",  cue_hide=true,},--豪华钻石1--diamond_1
		["104"] = 	{cb_pos_offset=cc.p(-260, 134), cb_scale= 0.6, bb_pos_offset=cc.p(0, -150), bb_scale= 1.3, bb_font="texture/common/font_lingqu.png",  cue_hide=true,},--豪华钻石1 --diamond_2
		["105"] = 	{cb_pos_offset=cc.p(-260, 134), cb_scale= 0.6, bb_pos_offset=cc.p(0, -150), bb_scale= 1.3, bb_font="texture/common/font_lingqu.png",  cue_hide=true,},--豪华钻石3 --diamond_3

		["106"] = 	{cb_pos_offset=cc.p(-300, 210), cb_scale= 0.6, bb_pos_offset=cc.p(0, -420), bb_scale= 1.3, bb_font="texture/common/font_lingqu.png",  cue_hide=true,}, --首充大礼包 --firstRecharge
		["107"] = 	{cb_pos_offset=cc.p(-310, 210), cb_scale= 0.6, bb_pos_offset=cc.p(0, -440), bb_scale= 1.3, bb_font="texture/common/font_lingqu.png",  cue_hide=true,},--豪华大礼包 --luxuryGift
		["108"] = 	{cb_pos_offset=cc.p(-280, 330), cb_scale= 0.6, bb_pos_offset=cc.p(0, -340), bb_scale= 1.3, bb_font="texture/common/font_lingqu.png",  cue_hide=true,},--至尊礼包 --extreme
		["109"] = 	{cb_pos_offset=cc.p(-300, 360), cb_scale= 0.6, bb_pos_offset=cc.p(-150, -318), bb_scale= 1.3, bb_font="texture/common/font_lingqu.png",  cue_hide=true,}, --翻牌 --flipBrand
		["110"] = 	{cb_pos_offset=cc.p(-280, 330), cb_scale= 0.6, bb_pos_offset=cc.p(0, -340), bb_scale= 1.3, bb_font="texture/common/font_lingqu.png",  cue_hide=true,},--倒霉熊的礼物 --bearGift
		
		["114"] = 	{cb_pos_offset=cc.p(-260, 134), cb_scale= 0.6, bb_pos_offset=cc.p(0, -150), bb_scale= 1.3, bb_font="texture/common/font_lingqu.png",  cue_hide=true,},--小金币 --coinSmall
		["115"] = 	{cb_pos_offset=cc.p(-260, 134), cb_scale= 0.6, bb_pos_offset=cc.p(0, -150), bb_scale= 1.3, bb_font="texture/common/font_lingqu.png",  cue_hide=true,},--大金币 --coinBig
	},
	
	--======================================================
	--					   礼包触发点
	--======================================================
	loginGift = {110, 107, 106,}, --倒霉熊礼物, 豪华大礼包, 首充大礼包,
	coinAddBtn = {102, 115,}, --永久双倍金币, 一大袋金币
	diamondAddBtn = {105,}, --豪华钻石礼包
	notenoughCoin = {115,}, --一大袋金币
	notenoughDiamond = {105,}, --豪华钻石礼包,
	notenoughItem = {110, 108,}, --倒霉熊礼物, 至尊大礼包
	gameFailGift = {110, 108, "insertAD",}, --倒霉熊礼物, 至尊大礼包,
	gameWinGift = {110, 108, "insertAD",}, --倒霉熊礼物, 至尊大礼包,
	selectLevelBoxGift = {110, 108, "insertAD",}, --倒霉熊礼物, 至尊大礼包,
	gameBoxGift = {110, 108,}, --倒霉熊礼物, 至尊大礼包,
	wheelDiamondEndGift = {"insertAD",},
};

return configPoint;
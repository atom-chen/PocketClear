local configMsg = {
	--levelInfo
	levelInfo_deductPower = 1,
	levelInfo_cancelBuy = 2,

	--starReward
	starReward_get = 40, --领取奖励

	--power
	power_use = 60, --使用体力瓶
	power_buy = 61, --购买体力瓶

	--CPBuyItem
	CPBuyItem_modifyNum = 80,
	CPBuyItem_buy = 81,

	--cue_NotJewel
	cue_NotJewel = 100,
	
	--shop
	shop_buy = 120, --商店购买

	--singIn
	signIn_sign = 140, --签到

	--selectLevel
	-- selectLevel_flipBrandEnergy = 160,
	selectLevel_countDown = 161,
	selectLevel_addReward = 162,
	selectLevel_welcomeGift = 163,

	--pause
	pause_voiceFlag = 180,
	pause_main = 180, --主界面暂停

	--point
	point_buy = 200, --购买道具
	point_addItem = 201, --添加道具
	point_buySuccess = 202, --礼包购买成功(通知算则关卡界面,图标重新布局)

	--backkom trip
	trip_get = 220, --获取任务道具
	trip_reset = 221, --重置任务
	trip_newTask = 222, --出发新任务

	--guide
	guide_jump = 240, --跳过新手引导

	--free coin
	freeCoin_get = 260, --领取免费金币

	--main
	main_touch = 320, --触摸棋盘格
	main_onDrop = 321, --元素掉落
	main_smallDropEnd = 322, --掉落结束

	main_updateAction = 323, --更新行动力
	main_increaseAction = 324, --增加行动力
	
	main_lineAndBomb = 325, --炸弹与直线
	main_increaseTempItem = 326, --增加临时道具
	main_useItem = 327, --使用道具
	
	main_bonustime = 328, --bonustime
	main_bonustimeExplode = 329, --bonustime引爆
	main_bonustimeAction = 330, --bonustime扣步数

	main_scheduler = 331, --时间关卡倒计时
	main_actionOver = 332, --行动力消耗完
	
	main_roleState = 333, --角色状态改变
	main_roleRoundEnd = 334, --一轮结束角色操作
	main_bossHit = 335, --boss受击

	main_reset = 336, --棋盘格元素重排
	main_resetEnd = 337, --棋盘格重排后自动合成

	main_itemUsingOnoff = 338, --道具使用中
	main_unlock = 339, --棋盘格解锁

	main_failFiveStep = 340, --失败加5步or加30秒

	main_afterUseColorBrush = 341, --使用换色刷

	main_countDown = 342, --主场景倒计时
	main_noneOpCue = 343, --长时间无操作提示

	main_settle = 344, --结算本关分数
	main_bigDropEnd = 345, --掉落结束之后
	main_roundEnd = 346, --本轮结束

	--redPacket
	redSetDiamond = 361, --抽红包的钻石
	redGetDiamond = 362, --领取红包

	--wheel
	wheelDraw_diamond = 380, --转盘钻石抽取
	wheelDraw_ad = 381, --转盘视频广告抽取
	wheelRefresh = 382, --转盘上的道具刷新
	wheelCDComplete = 383, --转盘广告冷却结束

	--comment
	comment = 400, --评论
	
	--fiveStep
	fiveStep_diamond = 420, --钻石购买加五步
	fiveStep_ad = 421, --广告购买加五步

	--share
	share = 440, --分享

	--freeDiamond
	-- freeDiamond = 460, --免费钻石抽取

	--fullPower
	fullPower = 480, --补满体力

	--cpGift
	cpGift = 500, --关卡奖励
	
	--data update
	data_update = 2000,

	--data count
	dataCount_level = 3000, --设置玩家等级
	dataCount_startLevel = 3001, --进入关卡
	dataCount_finishLevel = 3002, --通过关卡
	dataCount_failLevel = 3003, --未通过关卡
	dataCount_exchange = 3004, --记录玩家交易兑换货币的情况
	dataCount_payVirtualMoney = 3005, --玩家支付货币兑换虚拟币
	dataCount_payVirtualItem = 3006, --玩家支付货币购买道具
	dataCount_buyVirtualItem = 3007, --玩家使用虚拟币购买道具
	dataCount_useVirtualItem = 3008, --道具消耗统计
	dataCount_bonusVirtualMoney = 3009, --玩家获虚拟币奖励
	dataCount_bonusVirtualItem = 3010, --玩家获道具奖励
	dataCount_customEvent = 3011, --自定义事件
};

return configMsg;
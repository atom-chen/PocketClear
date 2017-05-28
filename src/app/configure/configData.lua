--type:"Integer", "Bool", "Float", "Double", "String"
local configData = {
	{name="recoverEndTime",	type="Integer", default=0,}, --体力恢复满的结束时间
	
	--道具列表 self.item={[id]={num=x,}, ...}
	{name="item", 			type="Table", 	default=nil, sub={{name="num",     type="Integer", default=0,}, --道具数量
															  {name="buyTime", type="Integer", default=0,}, --购买次数
															  {name="timebar", type="Integer", default=0,},},}, --时效结束点
	{name="firstGameTime", 	type="Integer", default=0,}, --第一次进入游戏的时间
	{name="curDay", 		type="Integer", default=0,}, --登陆的时候,记录当前是第几天
	{name="maxCP", 			type="Integer", default=0,}, --当前通关数
	{name="checkPoint", 	type="Table", 	default=nil, sub={{name="star", type="Integer", default=0,}, 
															  {name="score", type="Integer", default=0,}, 
															  {name="isGetCPGift", type="Bool", default=false,},},}, --玩家通过关卡信息{[cpIndex]={star=x, score=x,}, ...}
	
	{name="guideIndex", 		type="String", 	default=nil,}, --新手引导主ID
	
	{name="singInIndex", 	 	type="Integer", default=0,}, --签到天数;
	{name="singInTime", 	 	type="Integer", default=0,}, --签到间隔时间;
	
	{name="starRewardIndex",	type="Integer",	default=0,}, --领取星级奖励的索引;
	
	--各个任务的存档数据;
	{name="tripTask",		    type="Table",	default=nil, sub={{name="startTime", type="Integer", default=-1,}, --开始时间
																  {name="endTime",  type="Integer", default=-1,}, --结束时间
																  {name="complete", type="Bool",    default=false,}, --是否完成
																  {name="get",      type="Bool",    default=false,},},}, --是否领取奖励
	
	-- {name="musicFlag", 			type="Bool", 	default=true,}, --音乐
	-- {name="soundFlag", 			type="Bool", 	default=true,}, --音效
	
	{name="redIndex",			  type="Integer",	default=1,}, --当前红包的档位;
	
	{name="wheelDiamondCount", 	  type="Integer",    default=0, dayReset=true,}, --记录转盘钻石抽奖次数
	{name="wheelADCount", 		  type="Integer", 	 default=0, dayReset=true,}, --记录转盘观看视频抽奖次数
	{name="wheelAD_CD", 		  type="Integer", 	 default=0,}, --广告抽奖的冷却时间

	{name="shareFlag", 		  	  type="Bool",	 	 default=false, dayReset=true,}, --分享标记
	{name="commentFlag", 		  type="Bool",	 	 default=false,}, --评论标记
	{name="fiveStepVideoCueCount", type="Integer", 	 default=0,}, --五步视频提示计数
	{name="flipBrandEnergy", 	  type="Integer",    default=0,}, --翻牌能量值
};

return configData;
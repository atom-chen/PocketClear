--转盘配置
local configWheel = {
	--在转盘上显示几率, 在转盘上抽取几率, 道具ID, 道具数量
	{id=20, num=2, showProb=30, drawProb=50,}, --小体力瓶
	{id=21, num=1, 	showProb=50, drawProb=10,}, --大体力瓶
	{id=22, num=2, 	showProb=34, drawProb=36,}, --加五步
	{id=23, num=2, 	showProb=50, drawProb=40,}, --刷新
	{id=24, num=1, 	showProb=34, drawProb=50,}, --时光机
	{id=25, num=1, 	showProb=40, drawProb=5,}, --彩虹糖
	{id=26, num=2, 	showProb=30, drawProb=22,}, --换色刷
	{id=29, num=2, 	showProb=34, drawProb=40,}, --小木槌
	{id=30, num=1, showProb=50, drawProb=5,}, --糖果炸弹
};

return configWheel;
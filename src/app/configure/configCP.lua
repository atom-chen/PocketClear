local configCP = {
	[1] = 
	{	
		consume = 5, --消耗体力
		
		--关卡信息界面道具栏 (道具id)
		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},
		
		stars = {50, 100, 150,}, --三星分数
		
		--元素几率
		elementProb = {
			--默认元素几率,必须配置项
			--如果没有配置对应几率, 则使用改项
			default = {
				{type="1@1@2", prob=7,},
				{type="1@1@4", prob=5,},
				{type="1@1@3", prob=30,},
				{type="1@1@5", prob=5,},
			},

			--棋盘格初始化几率,可缺省
			init = {
				
			},

			--掉落几率,可缺省
			drop = {

			},
			
			--帽子产出几率,可缺省
			hat = {
				
			},
		},
		
		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=18,
		},
		
		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@3", num=18,},
			},
		},
		
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=5,}, 
			{id=4, num=5},
		},
	},

	[2] = 
	{	
		consume = 5, --消耗体力

		--关卡信息界面道具栏 (道具id)
		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},

		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, limit=3, helper=true,},
		},
		
		stars = {50, 100, 150,},

		--元素几率
		elementProb = {
			--默认元素几率,必须配置项
			--如果没有配置对应几率, 则使用改项
			default = {
				{type="1@1@1", prob=10,},
				{type="1@1@4", prob=10,},
				{type="1@1@3", prob=20,},
				{type="1@1@6", prob=18,},
			},

		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=25,
		},
		
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@3", num=18,},
			},
		},

		--首次通关奖励 (道具id, 道具数量)
		firstReward = {
			{id=20, num=200,},
			{id=21, num=5,},
		},

		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=5,}, 
			{id=4, num=5},
		},
	},
	
	[3] = 
	{
		consume = 5, --消耗体力

		--关卡信息界面道具栏 (道具id)
		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},

		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, limit=3, helper=true,},
		},
		
		stars = {1000, 2000, 2500,}, --三星分数
		
		--元素几率
		elementProb = {
			--默认元素几率,必须配置项
			--如果没有配置对应几率, 则使用改项
			default = {
				{type="1@1@5", prob=6,},
				{type="1@1@4", prob=12,},
				{type="1@1@3", prob=12,},
				{type="1@1@6", prob=6,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=25,
		},
		
		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@3", num=30,},
				{type="1@1@4", num=30,},
			},
		},
		
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=5,}, 
			{id=4, num=5},
		},
	},
	
	[4] = 
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {2000, 3000, 4000,}, --三星分数

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
				{type="1@1@2", prob=23,},
				{type="1@1@5", prob=25,},
				{type="1@1@3", prob=5,},
				{type="1@1@6", prob=4,},
				{type="1@1@1", prob=3,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=20,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@2", num=25,},
				{type="1@1@5", num=25,},
			},
		},

		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=5,}, 
			{id=4, num=5},
		},
	},
	
	[5] = 
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {2000, 2500, 3000,}, --三星分数

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@1", prob=10,},
			{type="1@1@5", prob=10,},
			{type="1@1@3", prob=14,},
			{type="1@1@6", prob=10,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="5@0", num=6,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=5,}, 
			{id=4, num=5},
		},

		--关卡是否被锁住
		--lock = {time=3600, diamond=30, star=15,},
	},
	
	[6] = 
	{	
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {2000, 3000, 3500,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@5", prob=10,},
			{type="1@1@3", prob=20,},
			{type="1@1@6", prob=22,},
			{type="1@1@4", prob=15,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@3", num=15,},
				{type="1@1@6", num=15,},
				{type="5@0", num=6,},
			},
		},

		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=5,}, 
			{id=4, num=5},
		},
	},
	
	[7] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 2000, 3000,}, --三星分数

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@5", prob=26,},
			{type="1@1@2", prob=25,},
			{type="1@1@6", prob=12,},
			{type="1@1@4", prob=10,},
			{type="1@1@1", prob=20,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=25,
		},

		--任务 (类型, 约束下限)
		task = {
			type=3,
			name="clown", --boss名字

			hp=60, --boss血量
			defense=20, --一次性被攻击至眩晕的元素个数
			recover=2, --恢复清醒状态所需要的回合数

			atk = {
				space=4,
				num=1,
				element={
					{type="5@3",},
				},
			},
			
			hitElement = {
				{type="1@1@2",},
				{type="1@1@5",},
				{type="1@1@1",},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=5,}, 
			{id=4, num=5},
		},
	},
	
	[8] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 2000, 4000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=10,},
			{type="1@1@3", prob=27,},
			{type="1@1@2", prob=26,},
			{type="1@1@1", prob=24,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@3", num=25,},
				{type="1@1@2", num=25,},
				{type="1@1@1", num=25,},
			},
		},
		
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=5,}, 
			{id=4, num=5},
		},

		--关卡礼包
		cpGift = {
			id=29, num=2, value=60,
		},
	},
	
	[9] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {3000, 8000, 19000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@5", prob=15,},
			{type="1@1@2", prob=13,},
			{type="1@1@6", prob=15,},
			{type="1@1@4", prob=45,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=32,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@4", num=60,},
				{type="12@0", num=14,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=5,}, 
			{id=4, num=5},
		},
	},
	
	[10] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 3500, 10000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=28,},
			{type="1@1@3", prob=10,},
			{type="1@1@2", prob=10,},
			{type="1@1@1", prob=12,},
			{type="1@1@5", prob=35,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=32,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=34,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=5,}, 
			{id=4, num=5},
		},
	},
	
	[11] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 3500, 10000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=12,},
			{type="1@1@3", prob=12,},
			{type="1@1@2", prob=10,},
			{type="1@1@1", prob=40,},
			{type="1@1@4", prob=14,},
			{type="1@1@5", prob=10,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=43,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="5@0", num=13,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=5,}, 
			{id=4, num=5},
		},
	},
	
	[12] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 2000, 4000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=18,},
			{type="1@1@1", prob=16,},
			{type="1@1@3", prob=13,},
			{type="1@1@2", prob=30,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=25,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="2@1", num=2, action={9, },},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=5,}, 
			{id=4, num=5},
		},
	},
	
	[13] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 2000, 4000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=20,},
			{type="1@1@3", prob=10,},
			{type="1@1@5", prob=20,},
			{type="1@1@4", prob=40,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=25,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="2@1", num=3, action={10, 17},},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=5,}, 
			{id=4, num=5},
		},
	},
	
	[14] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1200, 2500, 6000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=10,},
			{type="1@1@3", prob=10,},
			{type="1@1@2", prob=24,},
			{type="1@1@4", prob=35,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=32,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="2@1", num=4, action={10, 17, 26,},},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=5,}, 
			{id=4, num=5},
		},
	},
	
	[15] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {2500, 6500, 8500,},--三星分数

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=16,},
			{type="1@1@3", prob=16,},
			{type="1@1@2", prob=26,},
			{type="1@1@4", prob=35,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
		task = {
			type=3,
			name="clown", --boss名字

			hp=80, --boss血量
			defense=6, --一次性被攻击至眩晕的元素个数
			recover=2, --恢复清醒状态所需要的回合数

			atk = {
				space=4,
				num=1,
				element={
					{type="5@3",},
				},
			},
			
			hitElement = {
				{type="1@1@2",},
				{type="1@1@4",},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=5,}, 
			{id=4, num=5},
		},
	},
	
	[16] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 9000, 13000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=15,},
			{type="1@1@3", prob=15,},
			{type="1@1@2", prob=28,},
			{type="1@1@4", prob=30,},
			
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=1,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=5,}, 
			{id=4, num=5},
		},
	},
	
	[17] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=24, },
		},

		stars = {11000, 12000, 18000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@3", prob=29,},
			{type="1@1@2", prob=24,},
			{type="1@1@4", prob=10,},
			{type="1@1@5", prob=15,},
			{type="1@1@1", prob=10,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=2,
			limit=80,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=2,
			limit=9000, 
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=5,}, 
			{id=4, num=5},
		},
	},
	
	[18] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 3500, 10000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
				{type="1@1@3", prob=12,},
				{type="1@1@2", prob=10,},
				{type="1@1@4", prob=30,},
				{type="1@1@5", prob=14,},
				{type="1@1@1", prob=10,},
			},
			
			 --掉落几率,可缺省
			drop = {
	            {type="1@1@3", prob=12,},
				{type="1@1@2", prob=10,},
				{type="1@1@4", prob=30,},
				{type="1@1@5", prob=14,},
				{type="1@1@1", prob=10,},
	            {type="3", prob=7,},
			},
		},


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=28,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="3", num=6,},
				
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=5,}, 
			{id=4, num=5},
		},
	},
	
	[19] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {4000, 6000, 22000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=12,},
			{type="1@1@3", prob=12,},
			{type="1@1@2", prob=18,},
			{type="1@1@4", prob=30,},
			{type="1@1@5", prob=12,},
			
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=38,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=1,},
				{type="3", num=1,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=5,}, 
			{id=4, num=5},
		},
	},
	
	[20] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {3000, 5000, 10000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=12,},
			{type="1@1@2", prob=12,},
			{type="1@1@4", prob=18,},
			{type="1@1@5", prob=30,},
			{type="1@1@1", prob=12,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=32,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="13@0", num=14,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[21] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {2000, 8000, 10000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=16,},
			{type="1@1@2", prob=16,},
			{type="1@1@4", prob=28,},
			{type="1@1@5", prob=35,},
			{type="1@1@1", prob=12,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=41,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=27,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[22] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {3000, 8000, 20000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=20,},
			{type="1@1@3", prob=29,},
			{type="1@1@2", prob=31,},
			{type="1@1@4", prob=19,},
			{type="1@1@5", prob=17,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=35,
		},

		--任务 (类型, 约束下限)
		task = {
			type=3,
			name="clown", --boss名字

			hp=100, --boss血量
			defense=6, --一次性被攻击至眩晕的元素个数
			recover=2, --恢复清醒状态所需要的回合数

			atk = {
				space=4,
				num=2,
				element={
					{type="5@3",},
					{type="13@1",},
				},
			},
			
			hitElement = {
				{type="1@1@3",},
				{type="1@1@2",},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[23] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 8000, 13000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@3", prob=23,},
			{type="1@1@2", prob=23,},
			{type="1@1@4", prob=27,},
			{type="1@1@5", prob=16,},
			{type="1@1@1", prob=11,},
		},

		drop = {
	            {type="1@1@3", prob=23,},
				{type="1@1@2", prob=23,},
				{type="1@1@4", prob=27,},
				{type="1@1@5", prob=14,},
				{type="1@1@1", prob=11,},
	            {type="3", prob=5,},
			},
		},

		

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=26,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				  {type="3", num=5,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[24] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {3000, 8000, 20000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=23,},
			{type="1@1@3", prob=17,},
			{type="1@1@2", prob=15,},
			{type="1@1@4", prob=14,},
			{type="1@1@5", prob=12,},
			
		},
		
		drop = {
	        {type="1@1@6", prob=25,},
			{type="1@1@3", prob=17,},
			{type="1@1@2", prob=15,},
			{type="1@1@4", prob=14,},
			{type="1@1@5", prob=12,},
			{type="3", prob=5,},
			},
		},



		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=28,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="3", num=4,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[25] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {2000, 5100, 7200,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=25,},
			{type="1@1@3", prob=26,},
			{type="1@1@2", prob=27,},
			{type="1@1@4", prob=10,},
			{type="1@1@5", prob=25,},
			{type="1@1@1", prob=10,},
			},
		},


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=28,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@3", num=20,},
				{type="1@1@2", num=20,},
				{type="1@1@5", num=20,},
				{type="1@1@6", num=20,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[26] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 8000, 13000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=15,},
			{type="1@1@3", prob=30,},
			{type="1@1@2", prob=22,},
			{type="1@1@5", prob=22,},
			{type="1@1@1", prob=15,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=22,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="3", num=2},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[27] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {2000, 5000, 13000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=5,},
			{type="1@1@3", prob=26,},
			{type="1@1@2", prob=20,},
			{type="1@1@4", prob=20,},
			{type="1@1@5", prob=16,},
			{type="1@1@1", prob=30,},
			},
		},


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=28,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=45,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[28] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {3000, 8000, 13000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=21,},
			{type="1@1@3", prob=21,},
			{type="1@1@2", prob=15,},
			{type="1@1@4", prob=17,},
			{type="1@1@1", prob=17,},
		},
		
		drop = {
	        {type="1@1@6", prob=21,},
			{type="1@1@3", prob=21,},
			{type="1@1@2", prob=15,},
			{type="1@1@4", prob=17,},
			{type="1@1@1", prob=17,},
	            {type="3", prob=6,},
			},
		},



		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=26,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="3", num=6,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[29] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {5000, 12000, 18000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=12,},
			{type="1@1@3", prob=14,},
			{type="1@1@2", prob=18,},
			{type="1@1@4", prob=15,},
			{type="1@1@1", prob=32,},
			},
		},


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=26,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@1", num=60,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[30] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {5000, 12000, 18000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=18,},
			{type="1@1@3", prob=19,},
			{type="1@1@4", prob=31,},
			{type="1@1@5", prob=27,},
			{type="1@1@1", prob=25,},
			},
		},


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=32,
		},

		--任务 (类型, 约束下限)
		task = {
			type=3,
			name="clown", --boss名字

			hp=100, --boss血量
			defense=6, --一次性被攻击至眩晕的元素个数
			recover=2, --恢复清醒状态所需要的回合数

			atk = {
				space=4,
				num=3,
				element={
					{type="5@3",},
					{type="13@1",},
				},
			},
			
			hitElement = {
				{type="1@1@1",},
				{type="1@1@4",},
				{type="1@1@5",},
				-- {type="1@1@5",},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[31] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1200, 4000, 20000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=16,},
			{type="1@1@3", prob=19,},
			{type="1@1@2", prob=14,},
			{type="1@1@4", prob=23,},
			{type="1@1@5", prob=28,},
			},
		},


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="2@1", num=3, action={10, 16, },},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[32] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=24, },
		},

		stars = {8500, 9500, 25000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=16,},
			{type="1@1@3", prob=19,},
			{type="1@1@2", prob=14,},
			{type="1@1@4", prob=23,},
			{type="1@1@5", prob=28,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=2,
			limit=60,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=2,
			limit=7500, 
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[33] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 3500, 18000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=12,},
			{type="1@1@3", prob=24,},
			{type="1@1@2", prob=32,},
			{type="1@1@4", prob=12,},
			{type="1@1@5", prob=20,},
			},
		},


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=40,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=36,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[34] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {3000, 10000, 20000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=20,},
			{type="1@1@2", prob=22,},
			{type="1@1@4", prob=28,},
			{type="1@1@5", prob=23,},
			{type="1@1@1", prob=8,},
                        
			},
            },


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=33,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="11@0@1", num=5,},
				
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[35] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 8000, 13000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=14,},
			{type="1@1@3", prob=31,},
			{type="1@1@2", prob=24,},
			{type="1@1@5", prob=7,},
			{type="1@1@1", prob=24,},
			},
		},


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="11@0@1", num=4,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[36] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1200, 3000, 7500,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=30,},
			{type="1@1@3", prob=19,},
			{type="1@1@4", prob=13,},
			{type="1@1@5", prob=28,},
			{type="1@1@1", prob=22,},
			},
		},


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=24,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="11@0@1", num=1,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[37] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {5000, 13000, 18000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=18,},
			{type="1@1@3", prob=19,},
			{type="1@1@4", prob=31,},
			{type="1@1@5", prob=27,},
			{type="1@1@1", prob=25,},
			},
		},


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
		task = {
			type=3,
			name="clown", --boss名字

			hp=14, --boss血量
			defense=6, --一次性被攻击至眩晕的元素个数
			recover=2, --恢复清醒状态所需要的回合数

			atk = {
				space=4,
				num=3,
				element={
					{type="5@3",},
				},
			},
			
			hitElement = {
				{type="5@0",},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[38] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1200, 3000, 7500,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=25,},
			{type="1@1@3", prob=28,},
			{type="1@1@4", prob=23,},
			{type="1@1@5", prob=21,},
			{type="1@1@2", prob=25,},
			},
		},


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=38,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@2", num=33,},
				{type="1@1@3", num=33,},
				{type="11@0@1", num=1,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[39] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {800, 5000, 10000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=19,},
			{type="1@1@3", prob=20,},
			{type="1@1@4", prob=18,},
			{type="1@1@5", prob=20,},
			{type="1@1@2", prob=20,},
			},
		},


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=35,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@2", num=35,},
				{type="1@1@3", num=35,},
				{type="11@0@1", num=2,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[40] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 8000, 15000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=19,},
			{type="1@1@3", prob=20,},
			{type="1@1@4", prob=18,},
			{type="1@1@5", prob=20,},
			{type="1@1@1", prob=20,},
			},
		},


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=36,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="2@1", num=4, action={12, 20, 26,},},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[41] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 15000, 20000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=15,},
			{type="1@1@3", prob=22,},
			{type="1@1@2", prob=22,},
			{type="1@1@4", prob=20,},
			{type="1@1@5", prob=20,},
			{type="1@1@1", prob=20,},
			},
		},


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=28,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=41,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[42] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 2000, 4000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@3", prob=24,},
			{type="1@1@2", prob=14,},
			{type="1@1@4", prob=24,},
			{type="1@1@5", prob=13,},
			{type="1@1@1", prob=28,},
			},
		},


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=16,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="15@0", num=4,},
				
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[43] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=24, },
		},

		stars = {15000, 16000, 30095,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=12,},
			{type="1@1@3", prob=18,},
			{type="1@1@2", prob=30,},
			{type="1@1@4", prob=23,},
			{type="1@1@1", prob=23,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=2,
			limit=70,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=2,
			limit=13000, 
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[44] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {3000, 15000, 18000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=10,},
			{type="1@1@3", prob=25,},
			{type="1@1@4", prob=35,},
			{type="1@1@5", prob=15,},
			{type="1@1@1", prob=32,},
			},
		},


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=39,
		},

		--任务 (类型, 约束下限)
		task = {
			type=3,
			name="clown", --boss名字

			hp=8, --boss血量
			defense=6, --一次性被攻击至眩晕的元素个数
			recover=2, --恢复清醒状态所需要的回合数

			atk = {
				space=8,
				num=2,
				element={
					{type="15@6",},
					
				},
			},
			
			hitElement = {
				{type="15@0",},
				
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[45] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 7000, 10000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@2", prob=18,},
			{type="1@1@4", prob=23,},
			{type="1@1@5", prob=18,},
			{type="1@1@1", prob=18,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=35,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="15@0", num=6,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[46] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {6000, 18000, 22000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=18,},
			{type="1@1@3", prob=11,},
			{type="1@1@2", prob=25,},
			{type="1@1@4", prob=26,},
			
			
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="15@0", num=14,},
				
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[47] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 10000, 15000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=29,},
			{type="1@1@5", prob=41,},
			{type="1@1@1", prob=29,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=15,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=10,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[48] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 20000, 25000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=16,},
			{type="1@1@2", prob=16,},
			{type="1@1@4", prob=10,},
			{type="1@1@5", prob=12,},
			{type="1@1@1", prob=32,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=46,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=12,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[49] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 12000, 15000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=14,},
			{type="1@1@3", prob=17,},
			{type="1@1@2", prob=20,},
			{type="1@1@4", prob=8,},
			{type="1@1@5", prob=17,},
			{type="1@1@1", prob=30,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=22,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="11@0@1", num=2,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=10,}, 
			{id=4, num=5},
		},
	},
	
	[50] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 13000, 15000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=17,},
			{type="1@1@3", prob=15,},
			{type="1@1@2", prob=28,},
			{type="1@1@4", prob=10,},
			{type="1@1@5", prob=18,},
			{type="1@1@1", prob=15,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=19,},
				{type="15@0", num=7,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=20,}, 
			{id=4, num=5},
		},
	},
	
	[51] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 10000, 13000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=18,},
			{type="1@1@3", prob=31,},
			{type="1@1@4", prob=20,},
			{type="1@1@5", prob=27,},
			{type="1@1@2", prob=21,},
			},
		},


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=38,
		},

		--任务 (类型, 约束下限)
		task = {
			type=3,
			name="clown", --boss名字

			hp=100, --boss血量
			defense=6, --一次性被攻击至眩晕的元素个数
			recover=2, --恢复清醒状态所需要的回合数

			atk = {
				space=5,
				num=4,
				element={
					{type="5@3",},
					{type="13@1",},
				},
			},
			
			hitElement = {
				{type="1@1@3",},
				{type="1@1@5",},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=20,}, 
			{id=4, num=5},
		},
	},
	
	[52] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 12000, 15000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@3", prob=17,},
			{type="1@1@2", prob=22,},
			{type="1@1@4", prob=18,},
			{type="1@1@5", prob=20,},
			{type="1@1@1", prob=16,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="2@1", num=3, action={10, 15,},},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=20,}, 
			{id=4, num=5},
		},
	},
	
	[53] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {3000, 10000, 14000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=20,},
			{type="1@1@2", prob=28,},
			{type="1@1@4", prob=16,},
			{type="1@1@5", prob=18,},
			{type="1@1@1", prob=23,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=25,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=20,},
				{type="15@0", num=6,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=20,}, 
			{id=4, num=5},
		},
	},
	
	[54] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 2000, 5000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=15,},
			{type="1@1@2", prob=19,},
			{type="1@1@4", prob=24,},
			{type="1@1@5", prob=15,},
			{type="1@1@1", prob=10,},
			{type="1@1@3", prob=20,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=40,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="11@0@1", num=2,},
				{type="1@1@6", num=20,},
				{type="1@1@5", num=20,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=20,}, 
			{id=4, num=5},
		},
	},
	
	[55] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 20000, 24425,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@3", prob=22,},
			{type="1@1@2", prob=20,},
			{type="1@1@4", prob=22,},
			{type="1@1@1", prob=26,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=20,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="30@1", num=10,},
				
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=20,}, 
			{id=4, num=5},
		},
	},
	
	[56] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 2000, 5000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=22,},
			{type="1@1@3", prob=15,},
			{type="1@1@2", prob=25,},
			{type="1@1@4", prob=22,},
			{type="1@1@5", prob=14,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=35,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=31,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=20,}, 
			{id=4, num=5},
		},
	},
	
	[57] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 10000, 12000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=17,},
			{type="1@1@2", prob=13,},
			{type="1@1@4", prob=10,},
			{type="1@1@5", prob=18,},
			{type="1@1@1", prob=15,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=24,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="2@1", num=3, action={10, 16,},},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=20,}, 
			{id=4, num=5},
		},
	},
	
	[58] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 5690, 7000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=18,},
			{type="1@1@3", prob=19,},
			{type="1@1@4", prob=31,},
			{type="1@1@5", prob=27,},
			{type="1@1@2", prob=25,},
			},
		},


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=38,
		},

		--任务 (类型, 约束下限)
		task = {
			type=3,
			name="clown", --boss名字

			hp=15, --boss血量
			defense=6, --一次性被攻击至眩晕的元素个数
			recover=2, --恢复清醒状态所需要的回合数

			atk = {
				space=5,
				num=2,
				element={
					--{type="5@3",},
					{type="13@1",},
				},
			},
			
			hitElement = {
				{type="13@0",},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=20,}, 
			{id=4, num=5},
		},
	},
	
	[59] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=24, },
		},

		stars = {16000, 20000, 25000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@3", prob=25,},
			{type="1@1@2", prob=11,},
			{type="1@1@4", prob=17,},
			{type="1@1@5", prob=17,},
			{type="1@1@1", prob=25,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=2,
			limit=90,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=2,
			limit=16000, 
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=20,}, 
			{id=4, num=5},
		},
	},
	
	[60] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 6000, 8000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=22,},
			{type="1@1@3", prob=19,},
			{type="1@1@2", prob=17,},
			{type="1@1@4", prob=32,},
			{type="1@1@1", prob=17,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=28,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="5@0", num=14,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=20,}, 
			{id=4, num=5},
		},
	},
	
	[61] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 7000, 12000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=15,},
			{type="1@1@3", prob=15,},
			{type="1@1@2", prob=21,},
			{type="1@1@4", prob=15,},
			{type="1@1@1", prob=10,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=40,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=43,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=20,}, 
			{id=4, num=5},
		},
	},
	
	[62] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 8000, 9000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@3", prob=14,},
			{type="1@1@2", prob=16,},
			{type="1@1@4", prob=25,},
			{type="1@1@5", prob=21,},
			{type="1@1@1", prob=23,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=25,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@5", num=25,},
				{type="1@1@4", num=25,},
				{type="1@1@2", num=25,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=20,}, 
			{id=4, num=5},
		},
	},
	
	[63] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 9000, 11500,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=17,},
			{type="1@1@3", prob=17,},
			{type="1@1@2", prob=23,},
			{type="1@1@4", prob=15,},
			{type="1@1@5", prob=28,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=25,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=16, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=20,}, 
			{id=4, num=5},
		},
	},
	
	[64] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 9000, 11500,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=15,},
			{type="1@1@3", prob=16,},
			{type="1@1@2", prob=35,},
			{type="1@1@4", prob=15,},
			{type="1@1@1", prob=25,},
	    },

	    drop = {
	        {type="1@1@6", prob=15,},
			{type="1@1@3", prob=16,},
			{type="1@1@2", prob=35,},
			{type="1@1@4", prob=15,},
			{type="1@1@1", prob=25,},
	            {type="3", prob=4,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=25,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="30@1", num=5, },
				{type="30@2", num=5, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=20,}, 
			{id=4, num=5},
		},
	},
	
	[65] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 8500, 9500,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=30,},
			{type="1@1@3", prob=19,},
			{type="1@1@4", prob=25,},
			{type="1@1@5", prob=25,},
			{type="1@1@2", prob=27,},
			},
		},


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=38,
		},

		--任务 (类型, 约束下限)
		task = {
			type=3,
			name="clown", --boss名字

			hp=100, --boss血量
			defense=6, --一次性被攻击至眩晕的元素个数
			recover=2, --恢复清醒状态所需要的回合数

			atk = {
				space=5,
				num=3,
				element={
					{type="13@1",},
				},
			},
			
			hitElement = {
				{type="1@1@6",},
				{type="1@1@2",},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=20,}, 
			{id=4, num=5},
		},
	},
	
	[66] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 7500, 9000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=16,},
			{type="1@1@3", prob=25,},
			{type="1@1@2", prob=16,},
			{type="1@1@4", prob=15,},
			{type="1@1@5", prob=6,},
			{type="1@1@1", prob=24,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=35,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=17, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=20,}, 
			{id=4, num=5},
		},
	},
	
	[67] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 9000, 11000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=29,},
			{type="1@1@2", prob=35,},
			{type="1@1@4", prob=20,},
			{type="1@1@5", prob=14,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="2@1", num=6, action={10, 15, 19, 23, 27, },},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=20,}, 
			{id=4, num=5},
		},
	},
	
	[68] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 6000, 8000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=20,},
			{type="1@1@3", prob=23,},
			{type="1@1@2", prob=9,},
			{type="1@1@4", prob=20,},
			{type="1@1@5", prob=11,},
			{type="1@1@1", prob=16,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=40,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=23, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=20,}, 
			{id=4, num=5},
		},
	},
	
	[69] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 8000, 10000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=20,},
			{type="1@1@3", prob=32,},
			{type="1@1@2", prob=21,},
			{type="1@1@5", prob=17,},
			{type="1@1@1", prob=16,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=32,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=41, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=20,}, 
			{id=4, num=5},
		},
	},
	
	[70] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=24, },
		},

		stars = {10000, 20000, 25800,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@3", prob=14,},
			{type="1@1@2", prob=24,},
			{type="1@1@4", prob=20,},
			{type="1@1@5", prob=13,},
			{type="1@1@1", prob=13,},
			{type="1@1@6", prob=15,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=2,
			limit=90,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=2,
			limit=10000, 
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=30,}, 
			{id=4, num=5},
		},
	},
	
	[71] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 8000, 10000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=13,},
			{type="1@1@3", prob=28,},
			{type="1@1@2", prob=30,},
			{type="1@1@5", prob=15,},
			{type="1@1@4", prob=16,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=40,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=28, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=30,}, 
			{id=4, num=5},
		},
	},
	
	[72] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 15000, 20580,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=25,},
			{type="1@1@3", prob=18,},
			{type="1@1@4", prob=20,},
			{type="1@1@5", prob=25,},
			{type="1@1@2", prob=20,},
			},
		},


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=40,
		},

		--任务 (类型, 约束下限)
		task = {
			type=3,
			name="clown", --boss名字

			hp=126, --boss血量
			defense=6, --一次性被攻击至眩晕的元素个数
			recover=2, --恢复清醒状态所需要的回合数

			atk = {
				space=5,
				num=3,
				element={
					{type="5@3",},
					{type="13@1",},
				},
			},
			
			hitElement = {
				{type="1@1@2",},
				{type="1@1@6",},
				{type="1@1@5",},
				-- {type="1@1@5",},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=30,}, 
			{id=4, num=5},
		},
	},
	
	[73] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 6000, 7000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=25,},
			{type="1@1@2", prob=25,},
			{type="1@1@5", prob=24,},
			{type="1@1@4", prob=28,},
			{type="1@1@1", prob=16,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=16,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@4", num=20, },
				{type="1@1@2", num=20, },
				{type="1@1@5", num=20, },
				{type="1@1@6", num=20, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=30,}, 
			{id=4, num=5},
		},
	},
	
	[74] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 8000, 9000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=28,},
			{type="1@1@2", prob=25,},
			{type="1@1@5", prob=21,},
			{type="1@1@4", prob=25,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=17,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=16, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=30,}, 
			{id=4, num=5},
		},
	},
	
	[75] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 6600, 8000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=24,},
			{type="1@1@2", prob=18,},
			{type="1@1@5", prob=18,},
			{type="1@1@4", prob=21,},
			{type="1@1@3", prob=18,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=41,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=27, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=30,}, 
			{id=4, num=5},
		},
	},
	
	[76] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 12000, 22000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@2", prob=21,},
			{type="1@1@5", prob=15,},
			{type="1@1@4", prob=34,},
			{type="1@1@3", prob=28,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=25,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=28, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=30,}, 
			{id=4, num=5},
		},
	},
	
	[77] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=24, },
		},

		stars = {18000, 30000, 45000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@3", prob=15,},
			{type="1@1@2", prob=25,},
			{type="1@1@4", prob=24,},
			{type="1@1@1", prob=18,},
			{type="1@1@6", prob=17,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=2,
			limit=90,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=2,
			limit=18000, 
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=30,}, 
			{id=4, num=5},
		},
	},
	
	[78] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 16000, 18000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=25,},
			{type="1@1@2", prob=16,},
			{type="1@1@4", prob=25,},
			{type="1@1@5", prob=25,},
			{type="1@1@3", prob=20,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=35,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="2@1", num=3, action={15, 23,},},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=30,}, 
			{id=4, num=5},
		},
	},
	
	[79] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 8000, 9500,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=30,},
			{type="1@1@2", prob=28,},
			{type="1@1@4", prob=23,},
			{type="1@1@5", prob=25,},
			{type="1@1@1", prob=25,},
			},
		},


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=31,
		},

		--任务 (类型, 约束下限)
		task = {
			type=3,
			name="clown", --boss名字

			hp=100, --boss血量
			defense=6, --一次性被攻击至眩晕的元素个数
			recover=2, --恢复清醒状态所需要的回合数

			atk = {
				space=5,
				num=2,
				element={
					{type="5@3",},
					{type="13@1",},
				},
			},
			
			hitElement = {
				{type="1@1@6",},
				{type="1@1@2",},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=30,}, 
			{id=4, num=5},
		},
	},
	
	[80] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 8000, 11000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=17,},
			{type="1@1@2", prob=19,},
			{type="1@1@5", prob=4,},
			{type="1@1@4", prob=30,},
			{type="1@1@1", prob=15,},
			{type="1@1@3", prob=25,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=35,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=21, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=30,}, 
			{id=4, num=5},
		},
	},
	
	[81] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 9000, 15000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@2", prob=20,},
			{type="1@1@5", prob=16,},
			{type="1@1@4", prob=19,},
			{type="1@1@1", prob=19,},
			{type="1@1@3", prob=15,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=22,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="5@0", num=13, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=30,}, 
			{id=4, num=5},
		},
	},
	
	[82] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 7605, 9500,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=30,},
			{type="1@1@5", prob=16,},
			{type="1@1@4", prob=23,},
			{type="1@1@1", prob=19,},
			{type="1@1@3", prob=15,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=29,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=33, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=30,}, 
			{id=4, num=5},
		},
	},
	
	[83] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 8000, 11000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=25,},
			{type="1@1@5", prob=16,},
			{type="1@1@4", prob=19,},
			{type="1@1@3", prob=19,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=35,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=8, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=30,}, 
			{id=4, num=5},
		},
	},
	
	[84] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 12000, 19000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=20,},
			{type="1@1@5", prob=18,},
			{type="1@1@4", prob=19,},
			{type="1@1@3", prob=19,},
			{type="1@1@2", prob=20,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=21, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=30,}, 
			{id=4, num=5},
		},
	},
	
	[85] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 10000, 14000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=20,},
			{type="1@1@5", prob=18,},
			{type="1@1@4", prob=19,},
			{type="1@1@3", prob=19,},
			{type="1@1@2", prob=20,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=40,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="5@0", num=14, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=30,}, 
			{id=4, num=5},
		},
	},
	
	[86] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 10000, 12000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=25,},
			{type="1@1@2", prob=25,},
			{type="1@1@4", prob=23,},
			{type="1@1@5", prob=25,},
			{type="1@1@1", prob=25,},
			{type="1@1@3", prob=20,},
			},
		},


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=29,
		},

		--任务 (类型, 约束下限)
		task = {
			type=3,
			name="clown", --boss名字

			hp=13, --boss血量
			defense=6, --一次性被攻击至眩晕的元素个数
			recover=2, --恢复清醒状态所需要的回合数

			atk = {
				space=5,
				num=2,
				element={
					{type="5@3",},
				},
			},
			
			hitElement = {
				{type="5@0",},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=30,}, 
			{id=4, num=5},
		},
	},
	
	[87] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 8000, 11000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=19,},
			{type="1@1@5", prob=20,},
			{type="1@1@6", prob=19,},
			{type="1@1@3", prob=19,},
			{type="1@1@2", prob=23,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=32,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=14, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=30,}, 
			{id=4, num=5},
		},
	},
	
	[88] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 15000, 22325,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=25,},
			{type="1@1@5", prob=16,},
			{type="1@1@6", prob=19,},
			{type="1@1@3", prob=19,},
			{type="1@1@2", prob=23,},
			{type="1@1@1", prob=5,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=32,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="5@0", num=21, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=30,}, 
			{id=4, num=5},
		},
	},
	
	[89] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 8000, 11000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=25,},
			{type="1@1@6", prob=16,},
			{type="1@1@3", prob=19,},
			{type="1@1@2", prob=19,},
			{type="1@1@1", prob=23,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=35,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=12, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=30,}, 
			{id=4, num=5},
		},
	},
	
	[90] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 16000, 18000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@2", prob=25,},
			{type="1@1@4", prob=16,},
			{type="1@1@5", prob=25,},
			{type="1@1@3", prob=25,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=28,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="2@1", num=4, action={8, 12, 16,},},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	
	[91] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 3000, 7000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=25,},
			{type="1@1@5", prob=16,},
			{type="1@1@3", prob=19,},
			{type="1@1@2", prob=19,},
			{type="1@1@1", prob=23,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=22,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=16, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	
	[92] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 9000, 12740,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=29,},
			{type="1@1@5", prob=16,},
			{type="1@1@3", prob=19,},
			{type="1@1@2", prob=19,},
			{type="1@1@6", prob=23,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=37,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=36, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	
	[93] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 6000, 8000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=25,},
			{type="1@1@2", prob=25,},
			{type="1@1@5", prob=23,},
			{type="1@1@1", prob=25,},
			{type="1@1@3", prob=25,},
			},
		},


		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
		task = {
			type=3,
			name="clown", --boss名字

			hp=29, --boss血量
			defense=6, --一次性被攻击至眩晕的元素个数
			recover=2, --恢复清醒状态所需要的回合数

			atk = {
				space=5,
				num=1,
				element={
					{type="5@1",},
				},
			},
			
			hitElement = {
				{type="5@0",},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	
	[94] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 14000, 16000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=15,},
			{type="1@1@2", prob=16,},
			{type="1@1@4", prob=25,},
			{type="1@1@5", prob=27,},
			{type="1@1@3", prob=18,},
			{type="1@1@1", prob=19,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=40,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="2@1", num=3, action={15, 25, },},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	
	[95] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=24, },
		},

		stars = {22000, 25000, 40000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@3", prob=29,},
			{type="1@1@2", prob=24,},
			{type="1@1@4", prob=13,},
			{type="1@1@5", prob=20,},
			{type="1@1@1", prob=11,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=2,
			limit=80,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=2,
			limit=15000, 
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	
	[96] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 9000, 11000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=19,},
			{type="1@1@5", prob=15,},
			{type="1@1@1", prob=26,},
			{type="1@1@2", prob=19,},
			{type="1@1@6", prob=23,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=33,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=24, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	
	[97] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 8000, 11000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=25,},
			{type="1@1@5", prob=16,},
			{type="1@1@1", prob=19,},
			{type="1@1@2", prob=19,},
			{type="1@1@6", prob=23,},
			{type="1@1@3", prob=22,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=25,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="5@0", num=14, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	
	[98] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 12000, 18000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@6", prob=25,},
			{type="1@1@2", prob=16,},
			{type="1@1@4", prob=25,},
			{type="1@1@5", prob=25,},
			{type="1@1@3", prob=20,},
			{type="1@1@1", prob=20,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=25,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="2@1", num=4, action={10, 15, 20, },},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	
	[99] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 20000, 28000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=25,},
			{type="1@1@5", prob=16,},
			{type="1@1@1", prob=19,},
			{type="1@1@2", prob=19,},
			{type="1@1@6", prob=23,},
			{type="1@1@3", prob=22,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=35,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=21, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	
	[100] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 12000, 20000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=22,},
			{type="1@1@5", prob=16,},
			{type="1@1@2", prob=19,},
			{type="1@1@3", prob=19,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=28,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=22, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},

	[101] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 12000, 36280,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=22,},
			{type="1@1@5", prob=16,},
			{type="1@1@1", prob=19,},
			{type="1@1@6", prob=19,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=28,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=24, },
			},
		},

		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},

		
	},
	
	[102] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 12000, 36280,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@1", prob=22,},
			{type="1@1@3", prob=16,},
			{type="1@1@5", prob=15,},
			{type="1@1@6", prob=18,},
			{type="1@1@4", prob=20,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=28,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="5@0", num=22, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	
	[103] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 12000, 36280,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@1", prob=22,},
			{type="1@1@3", prob=16,},
			{type="1@1@4", prob=15,},
			{type="1@1@5", prob=18,},
			{type="1@1@6", prob=20,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=25,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=35, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	
	[104] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 12000, 36280,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@1", prob=22,},
			{type="1@1@3", prob=16,},
			{type="1@1@5", prob=15,},
			{type="1@1@6", prob=18,},
			{type="1@1@4", prob=18,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=38,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=9, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	
	[105] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=24, },
		},

		stars = {1000, 16000, 35000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=22,},
			{type="1@1@5", prob=16,},
			{type="1@1@1", prob=15,},
			{type="1@1@2", prob=18,},
			
			{type="1@1@3", prob=10,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=2,
			limit=70,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=2,
			limit=15000, 
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	
	[106] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 12000, 36280,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=22,},
			{type="1@1@3", prob=16,},
			{type="1@1@5", prob=15,},
			{type="1@1@6", prob=18,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=32,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="2@1", num=2, action={20, },},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	
	[107] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 12000, 36280,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@1", prob=22,},
			{type="1@1@3", prob=16,},
			{type="1@1@5", prob=15,},
			{type="1@1@6", prob=18,},
			{type="1@1@2", prob=20,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=28,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=22,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	
	[108] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 12000, 36280,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@1", prob=22,},
			{type="1@1@3", prob=16,},
			{type="1@1@5", prob=15,},
			{type="1@1@6", prob=18,},
			{type="1@1@2", prob=20,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=28,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=38,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	
	[109] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 12000, 36280,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=22,},
			{type="1@1@3", prob=16,},
			{type="1@1@5", prob=15,},
			{type="1@1@6", prob=18,},
			{type="1@1@2", prob=20,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=26,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=18,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	
	[110] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 20000, 35000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=22,},
			{type="1@1@3", prob=16,},
			{type="1@1@5", prob=15,},
			{type="1@1@6", prob=18,},
			{type="1@1@2", prob=20,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=25,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="2@1", num=4, action={10, 15, 20, },},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	
	[111] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 12000, 36280,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=22,},
			{type="1@1@3", prob=16,},
			{type="1@1@5", prob=15,},
			{type="1@1@6", prob=18,},
			{type="1@1@2", prob=20,},
			{type="1@1@1", prob=20,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=34,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=36, },
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
       [112] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 12000, 20000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=15,},
			{type="1@1@5", prob=15,},
			{type="1@1@6", prob=10,},
			{type="1@1@2", prob=18,},
			
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=26,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@1", num=20,},
				{type="1@1@3", num=10,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
       [113] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 9000, 15000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=20,},
			{type="1@1@5", prob=8,},
			{type="1@1@6", prob=8,},
			{type="1@1@2", prob=20,},
                        {type="1@1@3", prob=20,},
			
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=32,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@1", num=15,},
				{type="1@1@2", num=50,},
                                {type="1@1@3", num=50,},
                                {type="1@1@4", num=50,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
      [114] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 7000, 10000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=25,},
			{type="1@1@1", prob=8,},
			{type="1@1@6", prob=8,},
			{type="1@1@2", prob=8,},
            {type="1@1@3", prob=25,},
			{type="1@1@5", prob=10,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=32,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@5", num=45,},
				{type="1@1@4", num=40,},
                                {type="1@1@3", num=40,},
                            },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	   [115] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 5500, 8500,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=25,},
			{type="1@1@1", prob=8,},
		 	{type="1@1@2", prob=8,},
            {type="1@1@3", prob=25,},
			{type="1@1@5", prob=18,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@6", num=25,},
				{type="1@1@3", num=40,},
            
                            },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	[116] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 7000, 9500,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=13,},
			{type="1@1@1", prob=18,},
		 	{type="1@1@2", prob=18,},
            {type="1@1@3", prob=15,},
			
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@1", num=45,},
				{type="1@1@2", num=40,},
				{type="5@0", num=2,},

            
                            },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
		[117] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 10000, 12000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@5", prob=13,},
			{type="1@1@1", prob=18,},
		 	{type="1@1@2", prob=25,},
            {type="1@1@3", prob=15,},
			
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@5", num=25,},
				{type="1@1@4", num=25,},
				

            
                            },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
		[118] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 12000, 14000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@5", prob=18,},
			{type="1@1@1", prob=17,},
		 	{type="1@1@2", prob=22,},
            {type="1@1@6", prob=22,},
			
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@1", num=45,},
				
				

            
        },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
		[119] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 12000, 15000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=20,},
			{type="1@1@1", prob=13,},
		 	{type="1@1@2", prob=22,},
            {type="1@1@6", prob=22,},
			
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@2", num=45,},
				{type="1@1@4", num=45,},
				{type="5@0", num=9,},
				

            
          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
			[120] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 12000, 15000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@3", prob=20,},
			{type="1@1@1", prob=18,},
		 	{type="1@1@2", prob=22,},
            {type="1@1@6", prob=22,},
			
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
	task = {
			type=3,
			name="clown", --boss名字

			hp=100, --boss血量
			defense=12, --一次性被攻击至眩晕的元素个数
			recover=2, --恢复清醒状态所需要的回合数

			atk = {
				space=4,
				num=1,
				element={
					{type="3",},
				},
			},
			
			hitElement = {
				{type="1@1@4",},
				
				
   
          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
[121] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 7000, 10000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=17,},
			{type="1@1@1", prob=18,},
		 	{type="1@1@2", prob=22,},
            {type="1@1@5", prob=18,},
            
			
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@3", num=33,},
				{type="1@1@4", num=37,},
				{type="1@1@2", num=37,},
				

            
          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
[122] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 7000, 10000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=17,},
			{type="1@1@1", prob=18,},
		 	{type="1@1@2", prob=22,},
            {type="1@1@5", prob=18,},
            {type="1@1@3", prob=18,},
            
			
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="11@0@1", num=3,},
		
				

            
          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	[123] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 7000, 10000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=17,},
			{type="1@1@1", prob=18,},
		 	{type="1@1@2", prob=20,},
            {type="1@1@5", prob=15,},
            {type="1@1@6", prob=20,},
            
			
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=33,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@3", num=20,},
				{type="1@1@4", num=35,},
				{type="1@1@2", num=35,},
		
				

          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
[124] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 9000, 11000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=17,},
			{type="1@1@3", prob=22,},
		 	{type="1@1@2", prob=20,},
            {type="1@1@5", prob=15,},
            {type="1@1@6", prob=10,},
            
			
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=33,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@3", num=30,},
				{type="1@1@2", num=30,},
				{type="1@1@1", num=35,},
		
				

          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	[125] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 13500, 17000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@1", prob=20,},
			{type="1@1@3", prob=20,},
		 	{type="1@1@2", prob=25,},
            {type="1@1@5", prob=18,},
            
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=35,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@6", num=32,},
				{type="1@1@4", num=50,},
				{type="1@1@2", num=60,},
		
				

          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
		[126] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 8500, 12000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@1", prob=22,},
			{type="1@1@3", prob=22,},
		 	{type="1@1@2", prob=14,},
            {type="1@1@4", prob=25,},
            {type="1@1@6", prob=18,},
            
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=35,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="11@0@1", num=3,},
				{type="1@1@6", num=50,},
				{type="1@1@3", num=50,},
		
				

          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
		[127] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 9000, 12000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@3", prob=20,},
			{type="1@1@1", prob=18,},
		 	{type="1@1@2", prob=22,},
            {type="1@1@5", prob=16,},
			{type="1@1@4", prob=20,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=32,
		},

		--任务 (类型, 约束下限)
	task = {
			type=3,
			name="clown", --boss名字

			hp=55, --boss血量
			defense=5, --一次性被攻击至眩晕的元素个数
			recover=2, --恢复清醒状态所需要的回合数

			atk = {
				space=7,
				num=2,
				element={
					{type="5@1",},
				},
			},
			
			hitElement = {
				{type="1@1@6",},
				
				
   
          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
		[128] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 10000, 14000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@1", prob=15,},
			{type="1@1@2", prob=16,},
            {type="1@1@5", prob=25,},
            {type="1@1@6", prob=22,},
            
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=28,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="5@0", num=12,},
				{type="1@1@6", num=50,},
				{type="1@1@5", num=100,},
		
				

          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	[129] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 12000, 15000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@1", prob=17,},
			{type="1@1@2", prob=25,},
            {type="1@1@4", prob=9,},
            {type="1@1@3", prob=22,},
            {type="1@1@6", prob=15,},
            
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=40,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="5@0", num=34,},
				
		
				

          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	[130] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 12000, 15000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@1", prob=17,},
			{type="1@1@2", prob=25,},
            {type="1@1@4", prob=9,},
            {type="1@1@3", prob=22,},
            {type="1@1@5", prob=15,},
            
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=34,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="11@0@1", num=2,},
				{type="1@1@2", num=60,},
				{type="1@1@3", num=60,},
				
		
				

          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	[131] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 9000, 12000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@1", prob=18,},
			{type="1@1@2", prob=18,},
            {type="1@1@4", prob=20,},
            {type="1@1@3", prob=18,},
            {type="1@1@5", prob=22,},
            
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=31,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="5@0", num=7,},
				{type="1@1@4", num=45,},
				{type="1@1@5", num=45,},
				
		
				

          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	[132] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 9000, 12000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@1", prob=13,},
			{type="1@1@2", prob=12,},
            {type="1@1@4", prob=25,},
            {type="1@1@3", prob=15,},
            {type="1@1@5", prob=24,},
            
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=25,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@4", num=50,},
				{type="1@1@5", num=50,},
					

          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	[133] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 9000, 12000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@2", prob=20,},
            {type="1@1@4", prob=10,},
            {type="1@1@3", prob=25,},
            {type="1@1@5", prob=14,},
            
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=32,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@1", num=40,},
				{type="11@0@1", num=6,},
					

          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
		terminal = true,
	},
		[134] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {3000, 15000, 23000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@3", prob=28,},
			{type="1@1@1", prob=13,},
		 	{type="1@1@2", prob=25,},
           
			{type="1@1@4", prob=15,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=23,
		},

		--任务 (类型, 约束下限)
	task = {
			type=3,
			name="clown", --boss名字

			hp=300, --boss血量
			defense=30, --一次性被攻击至眩晕的元素个数
			recover=2, --恢复清醒状态所需要的回合数

			atk = {
				space=6,
				num=5,
				element={
					{type="13@1",},
					{type="5@3",},
				},
			},
			
			hitElement = {
				{type="1@1@1",},
				{type="1@1@2",},
				{type="1@1@3",},
                {type="1@1@4",},
          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	[135] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 9000, 12000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@2", prob=17,},
            {type="1@1@4", prob=20,},
            {type="1@1@6", prob=18,},
            {type="1@1@1", prob=14,},
            {type="1@1@5", prob=17,},
            
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=37,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=30,},
				
					

          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
		},
        [136] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 9000, 12000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@2", prob=17,},
            {type="1@1@4", prob=20,},
            {type="1@1@6", prob=18,},
            {type="1@1@1", prob=23,},
            {type="1@1@5", prob=17,},
            
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=37,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="3", num=8,},
				{type="5@0", num=13,},
				{type="1@1@1", num=50,},
				
					

          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
		},
		 [137] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 9000, 12000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@2", prob=17,},
            {type="1@1@4", prob=20,},
            {type="1@1@6", prob=18,},
            {type="1@1@1", prob=23,},
            {type="1@1@5", prob=17,},
            
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=38,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="11@0@1", num=6,},
				
				
				
					

          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
		},
		 [138] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 9000, 11000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@2", prob=15,},
            {type="1@1@4", prob=20,},
            {type="1@1@6", prob=18,},
            {type="1@1@3", prob=23,},
            {type="1@1@5", prob=17,},
            
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=35,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=10,},
				
				
				
					

          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
		},
		[139] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 9000, 11000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@2", prob=15,},
            {type="1@1@4", prob=21,},
            {type="1@1@6", prob=10,},
            {type="1@1@1", prob=24,},
            {type="1@1@5", prob=13,},
            
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=31,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@3", num=30,},
				{type="1@1@1", num=50,},
				{type="1@1@4", num=50,},
				
					

          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
		},
		[140] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 12000, 14000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@2", prob=14,},
			{type="1@1@3", prob=11,},
			{type="1@1@5", prob=23,},
			{type="1@1@4", prob=20,},
			{type="1@1@1", prob=21,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="2@1", num=3, action={10, 17},},
				{type="1@1@6", num=65,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	[141] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {3000, 15000, 23000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@3", prob=28,},
			{type="1@1@1", prob=13,},
		 	{type="1@1@2", prob=25,},
           
			{type="1@1@5", prob=15,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=27,
		},

		--任务 (类型, 约束下限)
	task = {
			type=3,
			name="clown", --boss名字

			hp=110, --boss血量
			defense=12, --一次性被攻击至眩晕的元素个数
			recover=2, --恢复清醒状态所需要的回合数

			atk = {
				space=6,
				num=2,
				element={
					{type="13@1",},
					{type="5@3",},
				},
			},
			
			hitElement = {
				
                {type="1@1@4",},
          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	[142] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 9000, 11000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@2", prob=23,},
            {type="1@1@4", prob=21,},
            {type="1@1@6", prob=10,},
            {type="1@1@1", prob=15,},
            {type="1@1@5", prob=13,},
            
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=31,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@3", num=10,},
				{type="1@1@2", num=50,},
				{type="1@1@4", num=50,},
				

				},
		 	},
		 			--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	[143] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 9000, 11000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@2", prob=23,},
            {type="1@1@4", prob=21,},
            {type="1@1@6", prob=10,},
            {type="1@1@1", prob=15,},
            {type="1@1@3", prob=13,},
            
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=31,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@5", num=40,},
				{type="12@0", num=8,},
				
				

				},
		 	},
		 			--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	[144] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 8000, 10000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@2", prob=23,},
            {type="1@1@5", prob=21,},
            {type="1@1@6", prob=10,},
            {type="1@1@1", prob=9,},
            {type="1@1@3", prob=13,},
            
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=33,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@1", num=55,},
				{type="5@0", num=8,},
				
				

				},
		 	},
		 			--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	[145] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 10000, 13000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@2", prob=23,},
            {type="1@1@5", prob=21,},
            {type="1@1@6", prob=10,},
            {type="1@1@1", prob=12,},
            {type="1@1@3", prob=13,},
            
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=33,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@2", num=60,},
				{type="12@0", num=16,},
				
				

				},
		 	},
		 			--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	[146] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 14000, 18000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@2", prob=25,},
            {type="1@1@5", prob=23,},
            {type="1@1@6", prob=10,},
            {type="1@1@1", prob=8,},
            {type="1@1@3", prob=13,},
            
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=31,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@2", num=90,},
				{type="1@1@5", num=90,},
				{type="1@1@4", num=15,},
				

				},
		 	},
		 			--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	[147] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {3000, 14000, 18000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@2", prob=20,},
            {type="1@1@5", prob=12,},
            {type="1@1@6", prob=13,},
            {type="1@1@1", prob=21,},
            {type="1@1@3", prob=15,},
            
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=31,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="1@1@2", num=50,},
				{type="1@1@1", num=50,},
				{type="5@0", num=10,},
				

				},
		 	},
		 			--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	[148] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {3000, 17000, 23000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@3", prob=23,},
			
		 	{type="1@1@6", prob=19,},
            {type="1@1@4", prob=20,},
			{type="1@1@5", prob=15,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=39,
		},

		--任务 (类型, 约束下限)
	task = {
			type=3,
			name="clown", --boss名字

			hp=12, --boss血量
			defense=12, --一次性被攻击至眩晕的元素个数
			recover=2, --恢复清醒状态所需要的回合数

			atk = {
				space=8,
				num=3,
				element={
					{type="5@2",},
					
				},
			},
			
			hitElement = {
				
                {type="11@0@1",},
          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	[149] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {1000, 13000, 15000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@2", prob=25,},
            {type="1@1@5", prob=23,},
            {type="1@1@6", prob=10,},
            {type="1@1@1", prob=8,},
            {type="1@1@3", prob=13,},
            
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=31,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="3", num=9,},
				{type="1@1@5", num=60,},
				{type="5@0", num=26,},
				

				},
		 	},
		 			--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
},
[150] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {3000, 8000, 10000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=21,},
			{type="1@1@1", prob=19,},
			
			{type="1@1@2", prob=23,},
			{type="1@1@6", prob=17,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=25,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="2@1", num=4,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	[151] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {3000, 11000, 15000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=21,},
			{type="1@1@1", prob=19,},
			
			{type="1@1@2", prob=23,},
			{type="1@1@6", prob=17,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=28,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="5@0", num=16,},
				{type="1@1@6", num=40,},
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	[152] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {3000, 12000, 15000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=22,},
			{type="1@1@1", prob=20,},
			
			{type="1@1@2", prob=25,},
			{type="1@1@6", prob=13,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=33,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="3", num=15,},
				
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	[153] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {5000, 12000, 14000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=20,},
			{type="1@1@5", prob=20,},
			{type="1@1@3", prob=17,},
			{type="1@1@2", prob=14,},
			{type="1@1@6", prob=13,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=30,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="11@0@1", num=8,},
				
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
	[154] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {5000, 12000, 15000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@4", prob=21,},
			{type="1@1@5", prob=17,},
			{type="1@1@3", prob=25,},
			{type="1@1@2", prob=18,},
			
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=28,
		},

		--任务 (类型, 约束下限)
		task = {
			name="bear",
			type=1,
			limit={
				{type="12@0", num=8,},
				
			},
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},
[155] =  
	{
		consume = 5, --消耗体力

		useItem_l = {
			{id=33, },
			{id=34, },
			{id=23, },
		},
		
		--三消界面道具栏 (道具id, 限制数量)
		useItem = {
			{id=23, }, 
			{id=29, limit=3,},
			{id=30, limit=3,}, 
			{id=25, limit=3,},
			{id=26, limit=3,},
			{id=22, },
		},

		stars = {3000, 10000, 15000,},

		--三消界面掉落元素 (掉落元素, 几率)
		elementProb = {
			default = {
			{type="1@1@1", prob=23,},
			{type="1@1@3", prob=21,},
		 	{type="1@1@6", prob=19,},
            {type="1@1@4", prob=9,},
			{type="1@1@5", prob=15,},
			},
		},

		--行动力 (类型, 约束上限)
		action = {
			type=1,
			limit=39,
		},

		--任务 (类型, 约束下限)
	task = {
			type=3,
			name="clown", --boss名字

			hp=100, --boss血量
			defense=12, --一次性被攻击至眩晕的元素个数
			recover=2, --恢复清醒状态所需要的回合数

			atk = {
				space=7,
				num=3,
				element={
					{type="5@1",},
					
				},
			},
			
			hitElement = {
				
                {type="1@1@4",},
          },
		},
		--通关奖励 (道具id, 道具数量)
		reward = {
			{id=1, num=40,}, 
			{id=4, num=5},
		},
	},



}
return configCP;

local configShop = {
	--超级套餐
	[1] = {
		--永久双倍礼包
		{102, function()
			require("app.context.contextPoint")
				:create(102);
		end},

		--首充大礼包
		{106, function()
			require("app.context.contextPoint")
				:create(106);
		end},

		--豪华礼包
		{107, function()
			require("app.context.contextPoint")
				:create(107);
		end},
		
		--至尊大礼包
		{108, function()
			require("app.context.contextPoint")
				:create(108);
		end},
	};

	--道具
	[2] = {
		--道具id, 道具原价
		{20, 280},
		{21, 280},
		{29, 380},
		{22, 480},

		{23,},
		{24,},
		{25,},
		{26,},

		{}, --占格子
		{}, --占格子
		{}, --占格子
		{30,},
	};

	--钻石
	[3] = {
		--道具id, 道具图标缩放
		{103, 1.0,},
		{104, 0.8,},
		{105, 0.8,},
		{114, 0.7,},
		{115, 0.7,},
	};

	--我的道具
	[4] = {

	};
};

return configShop;
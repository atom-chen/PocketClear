local configAccountingData = {
	["randomNum"] = {[20] = "1@3", [21] = "1@3", [22] = "1@2", [23] = "1@2", [24] = "1@2", 
					 	 [25] = "1@2", [26] = "1@2", [29] = "1@2", [30] = "1@2",},

	[2] = 
	{
		items = {
				type={20, 21, 22, 23, 24, 25, 26, 29, 30,}, --道具
				prob={130, 20, 40, 120, 60, 30, 120, 70, 30,}, --抽取概率
				--显示概率是抽取概率的逆序
		},
	},
};

return configAccountingData;
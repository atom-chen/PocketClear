local configElement = {
	--====================================================
	--格子
	--====================================================
	["0"] = {
		name = "Grid",
		motion = ELEMENT_MOTION.UNMOVE,
		viewLayer = ELEMENT_VIEW_LAYER.GRID,
		layer = ELEMENT_LAYER.GRID,
		occupyGrid = 1,

		view = {
			createFunc = function ()
				return ccui.ImageView:create("texture/main/grid.png", 1);
			end,

			--非激活格子
			-- [0] = function ()				
			-- end,

			--激活格子
			-- ["1"] = function ()
			-- end,

			--产生格子
			-- ["2"] = function ()
			-- end,
			
			--传送格子
			["3"] = function (grid)
				ccs.Armature:create("grid_t")
						:addTo(grid)
						:centerTo(grid, cc.p(0, 50))
						:play("CS_up");
				return grid;
			end,

			--收集格子
			["4"] = function (grid)
				display.newSprite("#texture/main/grid_collect.png")
				   :addTo(grid)
				   :centerTo(grid, cc.p(0, -56));
				return grid;
			end,
		},
	},

	--====================================================
	--方块
	--====================================================
	["1"] = {
		name = "Cube",
		motion = ELEMENT_MOTION.MOVE,
		viewLayer = ELEMENT_VIEW_LAYER.OCCUPY,
		layer = ELEMENT_LAYER.OCCUPY,
		occupyGrid = 1,

		view = {
			createFunc = function ()
				-- return display.newSprite();
				return ccui.ImageView:create();
			end,

			--红色普通方块
			["1@1"] = function (sprite)
				-- sprite:setSpriteFrame("texture/common/colorbox_red.png");
				-- return sprite;
				sprite:loadTexture("texture/common/colorbox_red.png", 1);
				return sprite;
			end,
			
			--橙色普通方块
			["1@2"] = function (sprite)
				-- sprite:setSpriteFrame("texture/common/colorbox_orange.png");
				-- return sprite;
				sprite:loadTexture("texture/common/colorbox_orange.png", 1);
				return sprite;
			end,

			--黄色普通方块
			["1@3"] = function (sprite)
				-- sprite:setSpriteFrame("texture/common/colorbox_yellow.png");
				-- return sprite;
				sprite:loadTexture("texture/common/colorbox_yellow.png", 1);
				return sprite;
			end,

			--绿色普通方块
			["1@4"] = function (sprite)
				-- sprite:setSpriteFrame("texture/common/colorbox_green.png");
				-- return sprite;
				sprite:loadTexture("texture/common/colorbox_green.png", 1);
				return sprite;
			end,

			--蓝色普通方块
			["1@5"] = function (sprite)
				-- sprite:setSpriteFrame("texture/common/colorbox_blue.png");
				-- return sprite;
				sprite:loadTexture("texture/common/colorbox_blue.png", 1);
				return sprite;
			end,

			--紫色普通方块
			["1@6"] = function (sprite)
				-- sprite:setSpriteFrame("texture/common/colorbox_purple.png");
				-- return sprite;
				sprite:loadTexture("texture/common/colorbox_purple.png", 1);
				return sprite;
			end,
		},

		--合成炸弹配置
		composition = {
			--L型
			--1
			--2
			--3 4 5
			{
				type=3, 
				shape={90, "runLxiao"},
				offsets={
					{cc.p(0, -2), cc.p(0, 0), cc.p(0, -1), cc.p(1, -2), cc.p(2, -2),},
					{cc.p(0, -1), cc.p(0, 0), cc.p(0, 1), cc.p(1, -1), cc.p(2, -1),},
					{cc.p(0, 0), cc.p(0, 1), cc.p(0, 2), cc.p(1, 0), cc.p(2, 0),},
					{cc.p(-1, 0), cc.p(0, 0), cc.p(-1, 1), cc.p(-1, 2), cc.p(1, 0),},
					{cc.p(-2, 0), cc.p(0, 0), cc.p(-1, 0), cc.p(-2, 1), cc.p(-2, 2),},
				},
			},

			--3 2 1
			--4
			--5
			{
				type=3, 
				shape={180, "runLxiao"},
				offsets={
					{cc.p(-2, 0), cc.p(0, 0), cc.p(-1, 0), cc.p(-2, -1), cc.p(-2, -2),},
					{cc.p(-1, 0), cc.p(0, 0), cc.p(1, 0), cc.p(-1, -1), cc.p(-1, -2),},
					{cc.p(0, 0), cc.p(1, 0), cc.p(2, 0), cc.p(0, -1), cc.p(0, -2),},
					{cc.p(0, 1), cc.p(0, -1), cc.p(0, 0), cc.p(1, 1), cc.p(2, 1),},
					{cc.p(0, 2),  cc.p(0, 0), cc.p(0, 1), cc.p(1, 2), cc.p(2, 2),},
				},
			},

			--1 2 3
			--    4
			--    5
			{
				type=3,
				shape={-90, "runLxiao"},
				offsets={
					{cc.p(2, 0), cc.p(0, 0), cc.p(1, 0), cc.p(2, -1), cc.p(2, -2),},
					{cc.p(1, 0), cc.p(0, 0), cc.p(-1, 0), cc.p(1, -1), cc.p(1, -2),},
					{cc.p(0, 0), cc.p(-1, 0), cc.p(-2, 0), cc.p(0, -1), cc.p(0, -2),},
					{cc.p(0, 1), cc.p(0, 0), cc.p(0, -1), cc.p(-1, 1), cc.p(-2, 1),},
					{cc.p(0, 2), cc.p(0, 0), cc.p(0, 1), cc.p(-1, 2), cc.p(-2, 2),},
				},
			},

			--    5
			--	  4
			--1 2 3
			{
				type=3, 
				shape={0, "runLxiao"},
				offsets={
					{cc.p(2, 0), cc.p(0, 0), cc.p(1, 0), cc.p(2, 1), cc.p(2, 2),},
					{cc.p(1, 0), cc.p(0, 0), cc.p(-1, 0), cc.p(1, 1), cc.p(1, 2),},
					{cc.p(0, 0), cc.p(-1, 0), cc.p(-2, 0), cc.p(0, 1), cc.p(0, 2),},
					{cc.p(0, -1), cc.p(0, 0), cc.p(0, 1), cc.p(-1, -1), cc.p(-2, -1),},
					{cc.p(0, -2), cc.p(0, 0), cc.p(0, -1), cc.p(-1, -2), cc.p(-2, -2),},
				},
			},
			
			--T型
			--1 2 3
			--  4
			--  5
			{
				type=3, 
				shape={0, "runTxiao"},
				offsets={
					{cc.p(1, -1), cc.p(0, 0), cc.p(1, 0), cc.p(2, 0), cc.p(1, -2),},
					{cc.p(-1, 0), cc.p(0, 0), cc.p(1, 0), cc.p(0, -1), cc.p(0, -2),},
					{cc.p(-1, -1), cc.p(0, 0), cc.p(-1, 0), cc.p(-2, 0), cc.p(-1, -2),},
					{cc.p(0, 0), cc.p(0, -1), cc.p(0, 1), cc.p(-1, 1), cc.p(1, 1),},
					{cc.p(0, 1), cc.p(0, 0), cc.p(0, 2), cc.p(-1, 2), cc.p(1, 2),},
				},
			},

			--  5
			--  4
			--1 2 3
			{
				type=3, 
				shape={180, "runTxiao"},
				offsets={
					{cc.p(1, 1), cc.p(0, 0), cc.p(1, 0), cc.p(2, 0), cc.p(1, 2),},
					{cc.p(0, 1), cc.p(0, 0), cc.p(-1, 0), cc.p(1, 0), cc.p(0, 2),},
					{cc.p(-1, 1), cc.p(-1, 0), cc.p(0, 0), cc.p(-2, 0), cc.p(-1, 2),},
					{cc.p(0, 0), cc.p(0, 1), cc.p(0, -1), cc.p(-1, -1), cc.p(1, -1),},
					{cc.p(0, -1), cc.p(0, 0), cc.p(0, -2), cc.p(-1, -2), cc.p(1, -2),},
				},
			},

			--    4
			--1 2 3  
			--    5
			{
				type=3, 
				shape={90, "runTxiao"},
				offsets={
					{cc.p(1, 0), cc.p(0, 0), cc.p(2, 0), cc.p(2, 1), cc.p(2, -1),},
					{cc.p(0, 0), cc.p(-1, 0), cc.p(1, 0), cc.p(1, 1), cc.p(1, -1),},
					{cc.p(-1, 0), cc.p(-2, 0), cc.p(0, 0), cc.p(0, 1), cc.p(0, -1),},
					{cc.p(-1, -1), cc.p(-2, -1), cc.p(0, -1), cc.p(0, 0), cc.p(0, -2),},
					{cc.p(-1, 1), cc.p(-2, 1), cc.p(0, 1), cc.p(0, 2), cc.p(0, 0),},
				},
			},

			--1
			--2 4 5
			--3
			{
				type=3, 
				shape={-90, "runTxiao"},
				offsets={
					{cc.p(1, -1), cc.p(0, 0), cc.p(0, -1), cc.p(0, -2), cc.p(2, -1),},
					{cc.p(1, 0), cc.p(0, 1), cc.p(0, 0), cc.p(0, -1), cc.p(2, 0),},
					{cc.p(1, 1), cc.p(0, 2), cc.p(0, 1), cc.p(0, 0), cc.p(2, 1),},
					{cc.p(0, 0), cc.p(-1, 1), cc.p(0, -1), cc.p(-1, -1), cc.p(0, 1),},
					{cc.p(0, -1), cc.p(-2, 1), cc.p(-2, -1), cc.p(0, -2), cc.p(0, 0),},
				},
			},

			--横
			--1 2 3 4
			{
				type=1, 
				shape={0, "runyizhixiao"},
				offsets={
					{cc.p(0, 0), cc.p(1, 0), cc.p(2, 0), cc.p(3, 0),},
					{cc.p(-1, 0), cc.p(0, 0), cc.p(1, 0), cc.p(2, 0),},
					{cc.p(-2, 0), cc.p(-1, 0), cc.p(0, 0), cc.p(1, 0),},
					{cc.p(-3, 0), cc.p(-2, 0), cc.p(-1, 0), cc.p(0, 0),},
				},
			},

			--竖
			--4
			--3
			--2
			--1
			{
				type=2, 
				shape={90, "runyizhixiao"},
				offsets={
					{cc.p(0, 0), cc.p(0, 1), cc.p(0, 2), cc.p(0, 3),},
					{cc.p(0, -1), cc.p(0, 0), cc.p(0, 1), cc.p(0, 2),},
					{cc.p(0, -2), cc.p(0, -1), cc.p(0, 0), cc.p(0, 1),},
					{cc.p(0, -3), cc.p(0, -2), cc.p(0, -1), cc.p(0, 0),},
				},
			},
		},
	},

	--====================================================
	--收集
	--====================================================
	["2"] = {
		name = "Collect",
		motion = ELEMENT_MOTION.MOVE,
		viewLayer = ELEMENT_VIEW_LAYER.OCCUPY,
		layer = ELEMENT_LAYER.OCCUPY,
		occupyGrid = 1,
		
		view = {
			createFunc = function ()
				display.getRunningScene():loadArmature(configArmature["cup"].cFile);
				return ccs.Armature:create("cup");
			end,
			
			["1"] = function(armature)
				armature:play("goldclick");
				return armature;
			end,
		},
	},

	--====================================================
	--金猪
	--====================================================
	["3"] = {
		name = "GoldPig",
		motion = ELEMENT_MOTION.MOVE,
		viewLayer = ELEMENT_VIEW_LAYER.OCCUPY,
		layer = ELEMENT_LAYER.OCCUPY,
		occupyGrid = 1,
		
		view = {
			createFunc = function ()
				display.getRunningScene():loadArmature(configArmature["goldPig"].cFile);
				return ccs.Armature:create("goldPig");
			end,
		},
	},

	--====================================================
	--宝石障碍
	--====================================================
	["5"] = {
		name = "Gemstone",
		motion = ELEMENT_MOTION.BLOCK,
		viewLayer = ELEMENT_VIEW_LAYER.OCCUPY,
		layer = ELEMENT_LAYER.OCCUPY,
		occupyGrid = 1,
		
		view = {
			createFunc = function ()
				display.getRunningScene():loadArmature(configArmature["gemstone"].cFile);
				return ccs.Armature:create("gemstone");
			end,

			--0层宝石
			["0"] = function (armature)
				local animationName = "baoshi04";
				local stateIni = configArmature["gemstone"][animationName].state;
				armature:play(animationName)
						:gotoAndPlay(stateIni["normal"]);
				return armature;
			end,

			--1层宝石
			["1"] = function (armature)
				local animationName = "baoshi03";
				local stateIni = configArmature["gemstone"][animationName].state;
				armature:play(animationName)
						:gotoAndPlay(stateIni["normal"]);
				return armature;
			end,
			
			--2层宝石
			["2"] = function (armature)
				local animationName = "baoshi02";
				local stateIni = configArmature["gemstone"][animationName].state;
				armature:play(animationName)
						:gotoAndPlay(stateIni["normal"]);
				return armature;
			end,

			--3层宝石
			["3"] = function (armature)
				local animationName = "baoshi01";
				local stateIni = configArmature["gemstone"][animationName].state;
				armature:play(animationName)
						:gotoAndPlay(stateIni["normal"]);
				return armature;
			end,
		},
	},

	--====================================================
	--沥青
	--====================================================
	["6"] = {
		name = "Pitch",
		motion = ELEMENT_MOTION.BLOCK,
		viewLayer = ELEMENT_VIEW_LAYER.OCCUPY,
		layer = ELEMENT_LAYER.OCCUPY,
		occupyGrid = 1,

		view = {
			createFunc = function ()
				display.getRunningScene():loadArmature(configArmature["pitch"].cFile);
				return ccs.Armature:create("pitch")
								   :play("daiji");
			end,
		},
	},

	--====================================================
	--颜色制造机
	--====================================================
	["10"] = {
		name = "ColorMachine",
		motion = ELEMENT_MOTION.UNMOVE,
		viewLayer = ELEMENT_VIEW_LAYER.OCCUPY,
		layer = ELEMENT_LAYER.OCCUPY,
		occupyGrid = 1,

		view = {
			createFunc = function ()
				display.getRunningScene():loadArmature(configArmature["colorMachine"].cFile);
				return ccs.Armature:create("colorMachine");
			end,

			--0层宝石
			["0"] = function (armature)
				armature:play("secaizhizao_1");
				return armature;
			end,

			--1层宝石
			["1"] = function (armature)
				armature:play("secaizhizao_2");
				return armature;
			end,
			
			--2层宝石
			["2"] = function (armature)
				armature:play("secaizhizao_3");
				return armature;
			end,
		},
	},

	--====================================================
	--石中戒子
	--====================================================
	["11"] = {
		name = "StoneTreasure",
		motion = ELEMENT_MOTION.UNMOVE,
		viewLayer = ELEMENT_VIEW_LAYER.OCCUPY,
		layer = ELEMENT_LAYER.OCCUPY,
		occupyGrid = 1,

		view = {
			createFunc = function ()
				display.getRunningScene():loadArmature(configArmature["stoneRing"].cFile);
				return ccs.Armature:create("stoneRing");
			end,

			--有宝物0层
			["0@1"] = function (armature)
				armature:play("have04");
				return armature;
			end,

			--有宝物1层
			["1@1"] = function (armature)
				armature:play("have03");
				return armature;
			end,
			
			--有宝物2层
			["2@1"] = function (armature)
				armature:play("have02");
				return armature;
			end,

			--有宝物3层
			["3@1"] = function (armature)
				armature:play("have01");
				return armature;
			end,

			--无宝物1层
			["1@0"] = function (armature)
				armature:play("noting03");
				return armature;
			end,

			--无宝物2层
			["2@0"] = function (armature)
				armature:play("noting02");
				return armature;
			end,

			--无宝物3层
			["3@0"] = function (armature)
				armature:play("noting01");
				return armature;
			end,
		},
	},

	--====================================================
	--玻璃罩子
	--====================================================
	["12"] = {
		name = "Glass",
		motion = ELEMENT_MOTION.UNMOVE,
		viewLayer = ELEMENT_VIEW_LAYER.MASK,
		layer = ELEMENT_LAYER.MASK,
		occupyGrid = 1,

		view = {
			createFunc = function ()
				display.getRunningScene():loadArmature(configArmature["glass"].cFile);
				return ccs.Armature:create("glass");
			end,

			--0层
			["0"] = function (armature)
				armature:play("ice1");
				return armature;
			end,

			--1层
			["1"] = function (armature)
				armature:play("ice1");
				return armature;
			end,
			
			--2层
			["2"] = function (armature)
				armature:play("ice2");
				return armature;
			end,
		},
	},

	--====================================================
	--牢笼
	--====================================================	
	["13"] = {
		name = "Cage",
		motion = ELEMENT_MOTION.BLOCK,
		viewLayer = ELEMENT_VIEW_LAYER.DECORATE,
		layer = ELEMENT_LAYER.DECORATE,
		occupyGrid = 1,
		
		view = {
			createFunc = function ()
				display.getRunningScene():loadArmature(configArmature["cage"].cFile);
				return ccs.Armature:create("cage");
			end,

			--0层
			["0"] = function (armature)
				armature:play("box_wood");
				return armature;
			end,

			--1层
			["1"] = function (armature)
				armature:play("box_wood");
				return armature;
			end,
			
			--2层
			["2"] = function (armature)
				armature:play("box_iron");
				return armature;
			end,
		},
	},

	--====================================================
	--福袋
	--====================================================
	["14"] = {
		name = "LuckyBag",
		motion = ELEMENT_MOTION.MOVE,
		viewLayer = ELEMENT_VIEW_LAYER.OCCUPY,
		layer = ELEMENT_LAYER.OCCUPY,
		occupyGrid = 1,
		
		view = {
			createFunc = function ()
				display.getRunningScene():loadArmature(configArmature["luckyBag"].cFile);
				return ccs.Armature:create("luckyBag")
								   :play("fudai");
			end,
		},
	},

	--====================================================
	--蛋糕
	--====================================================
	["15"] = {
		name = "Cake",
		motion = ELEMENT_MOTION.UNMOVE,
		viewLayer = ELEMENT_VIEW_LAYER.OCCUPY,
		layer = ELEMENT_LAYER.OCCUPY,
		occupyGrid = 1,
		
		view = {
			createFunc = function ()
				display.getRunningScene():loadArmature(configArmature["cake"].cFile);
				return ccs.Armature:create("cake");
			end,

			--0层宝石
			["0"] = function (armature)
				armature:play("cake07");
				return armature;
			end,

			--1层宝石
			["1"] = function (armature)
				armature:play("cake06");
				return armature;
			end,
			
			--2层宝石
			["2"] = function (armature)
				armature:play("cake05");
				return armature;
			end,

			--3层宝石
			["3"] = function (armature)
				armature:play("cake04");
				return armature;
			end,

			--4层宝石
			["4"] = function (armature)
				armature:play("cake03");
				return armature;
			end,

			--5层宝石
			["5"] = function (armature)
				armature:play("cake02");
				return armature;
			end,

			--6层宝石
			["6"] = function (armature)
				armature:play("cake01");
				return armature;
			end,
		},
	},

	--====================================================
	--导弹or炸弹
	--====================================================
	["30"] = {
		name = "Bomb",
		motion = ELEMENT_MOTION.MOVE,
		viewLayer = ELEMENT_VIEW_LAYER.OCCUPY,
		layer = ELEMENT_LAYER.OCCUPY,
		occupyGrid = 1,

		view = {
			createFunc = function ()
				return ccs.Armature:create("bomb");
			end,

			--横线导弹
			["1"] = function (armature)
				armature:play("bomb1");
				return armature;
			end,
			
			--竖向导弹
			["2"] = function (armature)
				armature:play("bomb2");
				return armature;
			end,
			
			--范围炸弹
			["3"] = function (armature)
				armature:play("bomb4");
				return armature;
			end,
		},

		explode = {
			["1"] = {
				cc.p(0, 0), 
				cc.p(-1, 0), cc.p(1, 0), 
				cc.p(-2, 0), cc.p(2, 0), 
				cc.p(-3, 0), cc.p(3, 0), 
				cc.p(-4, 0), cc.p(4, 0), 
				cc.p(-5, 0), cc.p(5, 0), 
				cc.p(-6, 0), cc.p(6, 0), 
				cc.p(-7, 0), cc.p(7, 0), 
				cc.p(-8, 0), cc.p(8, 0), 
			},

			["2"] = {
				cc.p(0, 0), 
				cc.p(0, -1), cc.p(0, 1), 
				cc.p(0, -2), cc.p(0, 2), 
				cc.p(0, -3), cc.p(0, 3), 
				cc.p(0, -4), cc.p(0, 4), 
				cc.p(0, -5), cc.p(0, 5), 
				cc.p(0, -6), cc.p(0, 6), 
				cc.p(0, -7), cc.p(0, 7), 
				cc.p(0, -8), cc.p(0, 8), 
			},

			["3"] = {
				cc.p(0, 0), 
				cc.p(1, 0), cc.p(2, 0), 
				cc.p(-1, 0), cc.p(-2, 0), 
				cc.p(0, 1), cc.p(0, 2), 
				cc.p(-1, 1), cc.p(1, 1), 
				cc.p(0, -1), cc.p(0, -2), 
				cc.p(-1, -1), cc.p(1, -1), 
			},			
		},
	},	
};

return configElement;
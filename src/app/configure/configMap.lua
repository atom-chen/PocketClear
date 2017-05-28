local configMap = {
	file = "tiledMap/HBX_guanka001.tmx",

	num = 2, --渲染地图单元数量

	bg = {
		num = 2,
		path = {
			"tiledMap/guanka002.png",
			"tiledMap/guanka003.png",
			"tiledMap/guanka004.png",
			"tiledMap/guanka005.png",
			"tiledMap/guanka006.png",
			"tiledMap/guanka007.png",
			"tiledMap/guanka008.png",
			"tiledMap/guanka009.png",
			"tiledMap/guanka010.png",
			"tiledMap/guanka011.png",
			"tiledMap/guanka012.png",
			"tiledMap/guanka013.png",
			"tiledMap/guanka014.png",
			"tiledMap/guanka015.png",
			"tiledMap/guanka016.png",
		},
	},
	
	cp = {
		num = 12,
		openUI = "levelInfo",
	},

	cpLock = {
		num = 1,
	},

	cpGift = {
		num = 3,
	},

	createThing = {"bg", "cp", "cpLock", "cpGift",}, --创建对象池
	
	-- lastBg = {0,} --如果最后一幅地图不满一个单元格子的大小
};

return configMap;
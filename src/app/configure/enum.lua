cc.exports.DIR = {
	CLOCK_1 = 1,
	CLOCK_2 = 2,
	CLOCK_3 = 3,
	CLOCK_4 = 4,
	CLOCK_5 = 5,
	CLOCK_6 = 6,
	CLOCK_7 = 7,
	CLOCK_8 = 8,
	CLOCK_9 = 9,
	CLOCK_10 = 10,
	CLOCK_11 = 11,
	CLOCK_12 = 12,
};

cc.exports.DIRVEC = {
	cc.p(math.cos(math.rad(60)), math.sin(math.rad(60))), --1
	cc.p(math.cos(math.rad(30)), math.sin(math.rad(30))), --2
	cc.p(math.cos(math.rad(0)), math.sin(math.rad(0))),	  --3
	cc.p(math.cos(math.rad(-30)), math.sin(math.rad(-30))), --4
	cc.p(math.cos(math.rad(-60)), math.sin(math.rad(-60))), --5
	cc.p(math.cos(math.rad(-90)), math.sin(math.rad(-90))), --6
	cc.p(math.cos(math.rad(-120)), math.sin(math.rad(-120))), --7
	cc.p(math.cos(math.rad(-150)), math.sin(math.rad(-150))), --8
	cc.p(math.cos(math.rad(-180)), math.sin(math.rad(-180))), --9
	cc.p(math.cos(math.rad(-210)), math.sin(math.rad(-210))), --10
	cc.p(math.cos(math.rad(-240)), math.sin(math.rad(-240))), --11
	cc.p(math.cos(math.rad(-270)), math.sin(math.rad(-270))), --12
};

cc.exports.PACKAGE = {
	WHITE = 1,
	GRAY = 2,
	BLACK = 3,
};

cc.exports.ACTION = {
	STEP = 1,
	TIME = 2,	
};

cc.exports.TASK = {
	COLLECT = 1,
	SCORE = 2,
	BOSS = 3,
};

--枚举名字对应道具ID
cc.exports.PROPERTY = {
	COIN = 1,
	DIAMOND = 2,
	STAR = 3,
	POWER = 4,
	SCORE = 5,
};

cc.exports.SHOP = {
	MEAL = 1,	
	ITEM = 2,
	MONEY = 3,
	MYITEM = 4,
	MAX = 5,
};

--=========================================
--				 三消元素
--=========================================
cc.exports.ELEMENT_MOTION = {
	UNMOVE = 0, --不移动
	MOVE = 1, --可移动元素
	BLOCK = 2, --障碍元素
};

cc.exports.ELEMENT_VIEW_LAYER = {
	GRID = 0, --格子层
	EXPLORE = 1, --探索层(小熊)
	OCCUPY = 2, --占格层(其余元素)
	DECORATE = 3, --装饰层(牢笼)
	MASK = 4, --遮罩层(塑料薄膜)
	MAX = 5,
};

cc.exports.ELEMENT_LAYER = {
	GRID = 0, --格子层(必须存在)
	EXPLORE = 1, --探索层
	MASK = 2, --遮罩层(塑料薄膜)
	OCCUPY = 3, --占格层(其余元素)
	DECORATE = 4, --装饰层(牢笼)
	MAX = 5,
};

cc.exports.ELEMENT = {
	--格子:只用配置隔断格子(0@down),
	--     其余格子代码检查地图配置自动生成
	GRID = "0", 
	
	--方块:
	--普通方块配置(1@1@color)
	--宝石方块配置(1@2@color)
	--定时方块配置(1@3@step@color)
	--魔法帽子配置(1@4@color)
	CUBE = "1", 
	COLLECT = "2", --收集 (2@shape)
	GOLDPIG = "3", --金猪(3)
	BALL = "4", --巧克力球(4)
	GEMSTONE = "5", --宝石(多层)(5@layer)（策划理解的巧克力）
	PITCH = "6", --沥青(6)
	CHOCOLATE = "7", --巧克力(多层)(7@layer)
	WINDMILL = "8", --风车(8@shpae)
	BOSS = "9", --BOSS(9@name@width@height@hp)
	COLORMACHINE = "10", --颜色制造机(10@color@num@layer@maxlayer)
	STONETREASURE = "11", --石块中的宝物(多层)(11@layer@1(有宝物) or 11@layer@0(没有宝物))
	GLASS = "12", --玻璃(多层)(12@layer)
	CAGE = "13", --牢笼(13@layer)
	LUCKYBAG = "14", --福袋(14@type@num) type: 5_layer, ...;
	CAKE = "15", --蛋糕

	--横向导弹(带颜色)(30@1@color)
	--竖向导弹(带颜色)(30@2@color)
	--范围炸弹(带颜色)(30@3@color)
	--同色炸弹(带颜色)(30@4@color)
	--导弹+范围炸弹(带颜色)(30@5@color)
	--范围炸弹+范围炸弹(带颜色)(30@6@color)
	--导弹+同色炸弹(带颜色)(30@7@color)
	--炸弹+同色炸弹(带颜色)(30@8@color)
	BOMB = "30",
	
	BACKKOM = "40", --倒霉熊,探索发现(40@width@height)
};

cc.exports.GRID = {
	UNACTIVE = "0", --非激活格子
	ACTIVE = "1", --激活格子
	CREATE = "2", --创建格子
	CUTOFF = "3", --隔断格子
	COLLECT = "4", --收集格子
};

cc.exports.COLOR = {
	RED = "1", --红
	ORANGE = "2", --橙
	YELLOW = "3", --黄
	GREEN = "4", --绿
	BLUE = "5", --蓝
	PURPLE = "6", --紫
};

cc.exports.TIER = {
	_0 = "0", --0层
	_1 = "1", --1层
	_2 = "2", --2层
	_3 = "3", --3层
	_4 = "4", --4层
};

cc.exports.WIDTH = {
	_2 = "2", --2格宽度
	_4 = "4", --4格宽度
	_6 = "6", --6格宽度
};

cc.exports.HEIGHT = {
	_2 = "2", --2格高度
	_4 = "4", --4格高度
	_6 = "6", --6格高度	
};

cc.exports.CUBE = {
	NORMAL = "1", --普通方块
	GEM = "2", --宝石方块
	SCHEDULER = "3", --定时器方块
	HAT = "4", --帽子
};

cc.exports.BOMB = {
	MISSILE_H = "1", --横向炸弹
	MISSILE_V = "2", --竖向炸弹
	BOMB = "3", --范围炸弹
};

cc.exports.SHAPE = {
	_1 = "1", --形态1
	_2 = "2", --形态2
	_3 = "3", --形态3
	_4 = "4", --形态4
};

cc.exports.ELEMENT_OP = {
	DEL = 1,
	CREATE = 2,
	UPDATE = 3,
};

--===============================游戏状态
cc.exports.CPSTATE = {
	NULL = 0,
	GAMEING = 1,
	BONUSTIME = 2,
	VICTORY = 3,
	FAIL = 4,
};

--===============================支付方式
cc.exports.PAYMENT = {
	COIN = "Coin", --金币支付
	DIAMOND = "Diamond", --钻石支付
	SMS = "SMS", --短信支付
	WECHAT = "wechat", --微信支付
	APPLEPAY = "applepay", --苹果支付
};

cc.exports.PAYRESULT = {
	SUCCESS = 0,
	NOTENOUGH_COIN = 1,
	NOTENOUGH_DIAMOND = 2,
	NOTENOUGH_RMB = 3,	
};

--===============================弹出框
cc.exports.MSGBOX = {
	NORMAL = "Normal", --普通弹出框
	NOTENOUGH_CURRENCY = "Currency", --货币不够
};

cc.exports.MSGCONTENT = {
	BUYSUCCESS = "msgBox/font_daojuchakan.png", --购买成功
	NOTENOUGH_CURRENCY = "msgBox/font_dduibuqi.png", --货币不够
	POWERFULL = "msgBox/font_tiliyiman.png", --体力已满
	VIDEOAD_DOUBLE_REWARD = "msgBox/shipingtishi02.png", --观看视频获得双倍奖励
	FIVESTEP = "msgBox/jiesuhoufangshiping.png", --加五步体验提示
};

cc.exports.MSGCURRENCY = {
	COIN = "msgBox/font_buzu_jinbi.png", --金币不够
	DIAMOND = "msgBox/font_buzu_zuanshi.png", --钻石不够
};

-- =================设置界面
cc.exports.PAUSE = {
	SELECTLEVEL = 1, --关卡选择界面
	MAIN = 2, --游戏界面
};

-- =================
cc.exports.COUNTEVENTS = {
	_1 = "1", --复活（加5步）按钮的点击次数
	_2 = "2", --复活中视频复活按钮的点击次数
	_3 = "3", --首页免费钻石按钮点击次数
	_4 = "4", --幸运转轮页面抽奖按钮点击次数
	_5 = "5", --幸运转轮页面免费抽奖按钮点击次数
	_6 = "6", --道具商店中钻石道具的购买次数（是否可以？）
	_7 = "7", --游戏页面钻石道具的购买次数（是否可以？）
	_8 = "8", --所有金币道具用户购买次数
};
local ElementM = class("ElementM");

function ElementM:ctor(key, ini)
	local array = string.split(key, "@");
	self.type = table.remove(array, 1);
	
	self.name = ini.name;
	self.viewRect = nil; --显示区域
	self.viewLayer = ini.viewLayer or 0;
	self.layer = ini.layer or 0;
	self.motion = ini.motion or ELEMENT_MOTION.MOVE;
	self.occupyGrid = ini.occupyGrid or 1;

	self.createData = nil; --当前元素转变为目标元素数据
	
	 --一个通用的key,不带动态的属性的。
	 --比如,小熊不带宽高属性,
	 --boss不带宽高血量,
	 --造色器不带数量,
	 --如果有特殊的情在子类的oncreate重新赋值
	self.key = key;
	
	if (self.onCreate) then
		self:onCreate(unpack(array));
	end
end

function ElementM:dector()
	self.viewLayer = nil;
	self.layer = nil;
	self.motion = nil;
	self.occupyGrid = nil;
	
	if (self.onDelete) then
		self:onDelete();
	end
end

function ElementM:get(key)
	return self[key];
end

function ElementM:setCoord(index)
	self.index = index; --一维坐标
	local cbIni = golbal.chessBoard; --二位坐标
	self.coord = cc.p(index%cbIni.width, math.floor(index/cbIni.width));
	return self;
end

return ElementM;
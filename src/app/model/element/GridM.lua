local ElementM = require("app.model.element.ElementM");

local GridM = class("GridM", ElementM);

function GridM:onCreate(subType, pointToIndex)
	self.subType = subType; --格子类型
	self.pointToIndex = pointToIndex; --指向格子
	self.viewKey = subType; --视图key值

	--该格子是否激活
	self.active = false; 

	--元素列表
	--self.elements = {[layer] = element};
	-- self.elements = nil;
end

function GridM:onDelete()
	self.index = nil;
	self.coord = nil;
	
	self.subType = nil;
	self.pointToIndex = nil;
	
	self.active = false;
	self.elements = nil;
end

return GridM;
local ElemetnV = require("app.view.element.ElementV");

local GridV = class("GridV", ElemetnV);

function GridV:onCreate()
	
end

function GridV:onDelete()
	
end

function GridV:updateShape()
	return self;
end

function GridV:updateLayer()
	self:setLocalZOrder(self.M:get("viewLayer"));
	return self;
end

return GridV;
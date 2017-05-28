local ElementM = require("app.model.element.ElementM");

local CubeM = class("CubeM", ElementM);

function CubeM:onCreate(subType, ...)
	local args = {...};

	self.subType = subType or CUBE.NORMAL; --子类
	self.color = args[1] or COLOR.RED; --颜色
	self.viewKey = self.subType .. "@" .. self.color; --视图key值
	if (CUBE.SCHEDULER == subType) then
		self.step = args[2]; --步数
	end
end

function CubeM:onDelete()
	self.color = nil;
	self.viewKey = nil;
	self.step = nil;
end

function CubeM:bombCheck()
	return true;
end

function CubeM:del()
	return true;
end

function CubeM:changeColor(key)
	self.key = key;

	local array = string.split(key, "@");
	self.color = array[3];
	self.viewKey = array[2] .. "@" .. array[3];
end

return CubeM;
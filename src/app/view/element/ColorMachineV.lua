local ElemetnV = require("app.view.element.ElementV");
local ColorMachineV = class("ColorMachineV", ElemetnV);

function ColorMachineV:onCreate()
	
end

function ColorMachineV:onDelete()
	
end

function ColorMachineV:updateShape()
	local ini = configElement[self.M:get("type")];
	local method = ini.view[tostring(self.M:get("tier"))];
	if (nil ~= method) then
		method(self);
	end
	
	local color = tonumber(self.M:get("color"));
	local index = {1, 0, 2, 4, 3, 5};
	self:getBone("zzcolorb"):changeDisplayWithIndex(index[color], true);
	
	-- 0 <-> 橙色
	-- 1 <-> 红色
	-- 2 <-> 黄色
	-- 3 <-> 蓝色
	-- 4 <-> 绿色
	-- 5 <-> 紫色
	return self;
end

return ColorMachineV;
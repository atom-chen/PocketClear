local ElementM = require("app.model.element.ElementM");

local ColorMachineM = class("ColorMachineM", ElementM);

--(10@color@num@layer@maxlayer)
function ColorMachineM:onCreate(color, num, tier, maxTier)
	self.color = color or COLOR.RED;
	self.num = tonumber(num) or 3;
	self.tier = tonumber(tier) or 0;
	self.maxTier = tonumber(maxTier) or 3;
	self.viewKey = self.tier; --视图key值
end

function ColorMachineM:onDelete()
	self.color = nil;
	self.num = nil;
	self.tier = nil;
	self.maxTier = nil;
	self.viewKey = nil; --视图key值
end

function ColorMachineM:aroundCheck()
	if (self.tier >= self.maxTier) then
		self.tier = self.maxTier;
		return true;
	end
	
	self.tier = self.tier + 1;
	if (self.tier == self.maxTier) then
		self.createData = {self.type, {self.color, self.num,}};
	end
	return true;
end

function ColorMachineM:reset()
	if (self.tier == self.maxTier) then
		self.tier = 0;
		self.createData = nil;
		return true;
	end
	return false;
end

return ColorMachineM;
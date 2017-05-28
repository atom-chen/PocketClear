local ElementM = require("app.model.element.ElementM");

local CakeM = class("CakeM", ElementM);

function CakeM:onCreate(tier)
	self.tier = tier or 3;
	self.viewKey = self.tier; --视图key值
end

function CakeM:onDelete()
	self.tier = nil;
	self.viewKey = nil;
end

function CakeM:aroundCheck()
	return true;
end

function CakeM:bombCheck()
	return  true;
end

function CakeM:del()
	local result = false;

	self.tier = self.tier - 1;
	if (self.tier <= 0) then
		self.tier = 0;
		result = true;
	end
	
	self.key = self.type .. "@" .. self.tier;
	self.viewKey = self.tier;

	return result;
end

return CakeM;
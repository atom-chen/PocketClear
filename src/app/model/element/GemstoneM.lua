local ElementM = require("app.model.element.ElementM");

local GemstoneM = class("GemstoneM", ElementM);

function GemstoneM:onCreate(tier)
	self.tier = tier or 3;
	self.viewKey = self.tier; --视图key值
end

function GemstoneM:onDelete()
	self.tier = nil;
	self.viewKey = nil;
end

function GemstoneM:aroundCheck()
	return true;
end

function GemstoneM:bombCheck()
	return  true;
end

function GemstoneM:del()
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

return GemstoneM;
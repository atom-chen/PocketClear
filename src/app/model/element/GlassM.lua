local ElementM = require("app.model.element.ElementM");
local GlassM = class("GlassM", ElementM);

function GlassM:onCreate(tier)
	self.tier = tier or 2;
	self.viewKey = self.tier; --视图key值
end

function GlassM:onDelete()
	self.tier = nil;
	self.viewKey = nil;
end

function GlassM:del()
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

function GlassM:otherLayerCheck()
	return true;
end

return GlassM;
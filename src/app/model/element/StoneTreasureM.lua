local ElementM = require("app.model.element.ElementM");

local StoneTreasureM = class("StoneTreasureM", ElementM);

function StoneTreasureM:onCreate(tier, treasure)
	self.tier = tier or 3;
	self.treasure = treasure or 1;
	self.viewKey = self.tier .. "@" .. self.treasure; --视图key值
end

function StoneTreasureM:onDelete()
	self.tier = nil;
	self.treasure = nil;
	self.viewKey = nil;
end

function StoneTreasureM:aroundCheck()
	return true;
end

function StoneTreasureM:bombCheck()
	return  true;
end

function StoneTreasureM:del()
	local result = false;
	
	self.tier = self.tier - 1;
	if (self.tier <= 0) then
		self.tier = 0;
		result = true;
	end
	
	self.viewKey = self.tier .. "@" .. self.treasure;
	self.key = self.type .. "@" .. self.viewKey;
	return result;
end

return StoneTreasureM;
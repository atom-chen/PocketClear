local ElementM = require("app.model.element.ElementM");
local CageM = class("CageM", ElementM);

function CageM:onCreate(tier)
	self.tier = tier or 1;
	self.viewKey = self.tier; --视图key值
end

function CageM:onDelete()
	self.tier = nil;
	self.viewKey = nil;
end

function CageM:del()
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

-- function CageM:aroundCheck(src, dst)
-- 	if (src:get("type")~=dst:get("type")) then
-- 		return false;
-- 	end

-- 	if (src:get("color")~=dst:get("color")) then
-- 		return false;
-- 	end

-- 	return true;
-- end

function CageM:bombCheck()
	return true;
end

return CageM;
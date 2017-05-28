local ElementM = require("app.model.element.ElementM");
local LuckyBagM = class("LuckyBagM", ElementM);

function LuckyBagM:onCreate(eType, num)
	self.eType = eType or "1";
	self.num = num or 1;
	self.viewKey = self.type; --视图key值
end

function LuckyBagM:onDelete()
	self.eType = nil;
	self.num = nil;
	self.viewKey = nil; --视图key值
end

function LuckyBagM:del()
	return true;
end

function LuckyBagM:roundDel(grid)
	if (GRID.COLLECT==grid:get("subType")) then
		return true;
	end
	return false;
end

return LuckyBagM;
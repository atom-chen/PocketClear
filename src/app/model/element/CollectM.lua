local ElementM = require("app.model.element.ElementM");
local CollectM = class("CollectM", ElementM);

function CollectM:onCreate(shape)
	self.shape = shape or "1";
	self.viewKey = self.shape; --视图key值
end

function CollectM:onDelete()
	self.tier = nil;
	self.viewKey = nil;
end

function CollectM:del()
	return true;
end

function CollectM:roundDel(grid)
	if (GRID.COLLECT==grid:get("subType")) then
		return true;
	end
	return false;
end

return CollectM;
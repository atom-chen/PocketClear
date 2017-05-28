local ElementM = require("app.model.element.ElementM");

local BombM = class("BombM", ElementM);

function BombM:onCreate(subType)
	if (nil == subType) then
		local list = {};
		for k, v in pairs(BOMB) do
			table.insert(list, v);
		end
		subType = list[math.random(1, #list)];
	end

	self.subType = subType;
	-- self.color = color;
	self.viewKey = subType; --视图key值
end

function BombM:onDelete()
	self.subType = nil;
	-- self.color = nil;
	self.viewKey = nil;
end

function BombM:bombCheck()
	return true;
end

function BombM:del()
	return true;
end

return BombM;
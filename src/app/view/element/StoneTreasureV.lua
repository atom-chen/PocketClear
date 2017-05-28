local ElemetnV = require("app.view.element.ElementV");

local StoneTreasureV = class("StoneTreasureV", ElemetnV);

function StoneTreasureV:onCreate()
	
end

function StoneTreasureV:onDelete()
	
end

function StoneTreasureV:updateShape()
	local ini = configElement[self.M:get("type")];
	ini.view[tostring(self.M:get("viewKey"))](self);
	return self;
end

return StoneTreasureV;
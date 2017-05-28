local ElemetnV = require("app.view.element.ElementV");

local GemstoneV = class("GemstoneV", ElemetnV);

function GemstoneV:onCreate()
	
end

function GemstoneV:onDelete()
	
end

function GemstoneV:updateShape()
	local ini = configElement[self.M:get("type")];
	ini.view[tostring(self.M:get("tier"))](self);
	return self;
end

return GemstoneV;
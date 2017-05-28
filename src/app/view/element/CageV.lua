local ElemetnV = require("app.view.element.ElementV");
local CageV = class("CageV", ElemetnV);

function CageV:onCreate()
	
end

function CageV:onDelete()
	
end

function CageV:updateShape()
	local ini = configElement[self.M:get("type")];
	ini.view[tostring(self.M:get("tier"))](self);
	return self;
end

return CageV;
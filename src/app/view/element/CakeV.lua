local ElemetnV = require("app.view.element.ElementV");

local CakeV = class("CakeV", ElemetnV);

function CakeV:onCreate()
	
end

function CakeV:onDelete()
	
end

function CakeV:updateShape()
	local ini = configElement[self.M:get("type")];
	ini.view[tostring(self.M:get("tier"))](self);
	return self;
end

return CakeV;
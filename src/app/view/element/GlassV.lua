local ElemetnV = require("app.view.element.ElementV");
local GlassV = class("GlassV", ElemetnV);

function GlassV:onCreate()
	
end

function GlassV:onDelete()
	
end

function GlassV:updateShape()
	local ini = configElement[self.M:get("type")];
	ini.view[tostring(self.M:get("tier"))](self);
	return self;
end

return GlassV;
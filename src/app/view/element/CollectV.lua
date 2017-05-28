local ElemetnV = require("app.view.element.ElementV");
local CollectV = class("CollectV", ElemetnV);

function CollectV:onCreate()
	
end

function CollectV:onDelete()
	
end

function CollectV:updateShape()
	local ini = configElement[self.M:get("type")];
	ini.view[tostring(self.M:get("shape"))](self);
	return self;
end

return CollectV;
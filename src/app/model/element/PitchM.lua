local ElementM = require("app.model.element.ElementM");
local PitchM = class("PitchM", ElementM);

function PitchM:onCreate()
	self.viewKey = self.type;
end

function PitchM:onDelete()
	self.viewKey = nil;
end

function PitchM:del()
	return true;
end

function PitchM:aroundCheck(element)
	if (ELEMENT.CUBE == element:get("type")) then
		return true;
	else
		return false;
	end
end

function PitchM:bombCheck()
	return  true;
end

return PitchM;
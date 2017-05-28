local ElementM = require("app.model.element.ElementM");
local GoldPigM = class("GoldPigM", ElementM);

function GoldPigM:onCreate()
	self.viewKey = self.type;
end

function GoldPigM:onDelete()
	self.viewKey = nil;
end

function GoldPigM:del()
	return true;
end

function GoldPigM:bombCheck()
	return  true;
end

return GoldPigM;
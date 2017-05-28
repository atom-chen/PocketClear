local welcomeGiftM = class("welcomeGiftM", require("app.model.model"));

function welcomeGiftM:onCreate()
	self:addCustomEvent(configMsg.welcomeGift_addItem, function(event)
		self:addItem(200, 1);
		self:modifyDataByKey({"item", 200, "buyTime"}, 1);
		event._usedata();
	end);
end

function welcomeGiftM:onDelete()
	
end

return welcomeGiftM;
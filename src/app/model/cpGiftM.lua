local cpGiftM = class("cpGiftM", require("app.model.model"));

function cpGiftM:onCreate(levelIndex)
	self:addCustomEvent(configMsg.cpGift, function(event)
		local cpGift = configCP[levelIndex].cpGift;
		local itemData = configItem[cpGift.id];
		self:addItem(cpGift.id, cpGift.num);
		self:setDataByKey({"checkPoint", levelIndex, "isGetCPGift"}, true);
		
		event._usedata();
	end);
end

function cpGiftM:onDelete()
	
end

return cpGiftM;
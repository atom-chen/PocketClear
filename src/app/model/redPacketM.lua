local redPacketM = class("redPacketM", require("app.model.model"));

function redPacketM:onCreate()
    --抽红包
	self:addCustomEvent(configMsg.redSetDiamond, function(event)
		local redIndex = self:getDataByKey("redIndex");
		local itemID = configRedData[redIndex];
		local itemData = configItem[itemID];

		self.id = itemData.pack[1].id;
		self.num = math.random(itemData.pack[1].num.min, itemData.pack[1].num.max);
		event._usedata(self.num);
	end);
	
	--领取红包
	self:addCustomEvent(configMsg.redGetDiamond, function(event)
		self:addItem(self.id, self.num);

		local curRedIndex = self:getDataByKey("redIndex")+1;
		self:setDataByKey("redIndex", curRedIndex);
		local curItemID = configRedData[curRedIndex];
		if (nil ~= curItemID) then
			self:setDataByKey({"item", curItemID, "timebar"}, os.time()+configItem[curItemID].timebar);
		end
	end);
end

function redPacketM:onDelete()
end

return redPacketM;
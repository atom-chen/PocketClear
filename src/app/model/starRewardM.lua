local starRewardM = class("starRewardM", require("app.model.model"));

function starRewardM:onCreate()
	self:addCustomEvent(configMsg.starReward_get, function(event)
		local index, callBack = unpack(event._usedata);
		
		local data = configStarReward[index];
		for i=1, #data.items do
			local itemID, itemNum = data.items[i].id, data.items[i].num;
			self:addItem(itemID, itemNum);
		end

		--设置星级奖励领取索引
		self:setDataByKey("starRewardIndex", index);

		--视图回调
		callBack();
	end);
end

function starRewardM:onDelete()
	
end

return starRewardM;
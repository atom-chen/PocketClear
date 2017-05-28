local CPBuyItemM = class("CPBuyItemM", require("app.model.model"));

function CPBuyItemM:onCreate(id)
	self.id = id;
	self.num = 1; --当前购买道具数量

	--修改购买道具数量
	self:addCustomEvent(configMsg.CPBuyItem_modifyNum, function(event)
		local modifyValue, callBack = unpack(event._usedata);
		
		--修改数量
		self.num = self.num + modifyValue;
		if (self.num < 1) then
			self.num = 1;
			return;
		end
		
		--回调
		callBack(self.num);
	end);

	--注册购买道具消息
	self:addCustomEvent(configMsg.CPBuyItem_buy, function(event)
        golbal.buyWithDiamond(self.id, self.num, function(result)
        	if (PAYRESULT.SUCCESS == result) then
        		self:addItem(self.id, self.num);
			end
        end);
	end);
end

function CPBuyItemM:onDelete()
	
end

return CPBuyItemM;
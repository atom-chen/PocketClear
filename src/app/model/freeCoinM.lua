local freeCoinM = class("freeCoinM", require("app.model.model"));

function freeCoinM:onCreate()
	self.freeCoin = math.random(100, 200);

	--领取金币
	self:addCustomEvent(configMsg.freeCoin_get, function(event)
		self:addItem(1, self.freeCoin);
		event._usedata();
	end);
end

function freeCoinM:onDelete()
	
end

return freeCoinM;
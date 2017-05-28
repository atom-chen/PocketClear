local powerM = class("powerM", require("app.model.model"));

function powerM:onCreate()
	self:addCustomEvent(configMsg.power_use, function(event)
		local id, callBack = unpack(event._usedata);

		local curPower = self:getDataByKey(golbal.power());
		if (curPower >= golbal.powerLimit) then
			callBack("fail");
			return;
		end
		
		self:addPowerByItem(id);
		callBack("success");
	end);
	
	self:addCustomEvent(configMsg.power_buy, function(event)
		local id, callback = unpack(event._usedata);
  		golbal.buyWithDiamond(id, 1, function(result)
  			if (PAYRESULT.SUCCESS == result) then
  				self:addItem(id, 1);
  				callback();
			end
  		end);
	end);
end

function powerM:onDelete()
	
end

return powerM;
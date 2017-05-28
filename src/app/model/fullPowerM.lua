local fullPowerM = class("fullPowerM", require("app.model.model"));

function fullPowerM:onCreate()
	self:addCustomEvent(configMsg.fullPower, function(event)
		golbal.buyWithDiamond(40, 1, function(result)			
			if (PAYRESULT.SUCCESS == result) then
				self:addItem(4, golbal.powerLimit);
			end
			event._usedata(result);
		end, true);
	end);
end

function fullPowerM:onDelete()
	
end

return fullPowerM;
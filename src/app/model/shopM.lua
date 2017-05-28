local shopM = class("shopM", require("app.model.model"));

function shopM:onCreate()
	self:addCustomEvent(configMsg.shop_buy, function(event)
		require("app.model.pointM")
			:create()
			:pay(event._usedata, function(object)
				object:delete();
			end);
	end);
end

function shopM:onDelete()
	
end

return shopM;
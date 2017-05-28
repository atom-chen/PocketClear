local shareM = class("shareM", require("app.model.model"));

function shareM:onCreate()
	self:addCustomEvent(configMsg.share, function(event)
		local call = event._usedata;

		--苹果分享
		golbal.lua2oc("Adapter", "wechatShare", {call=function()
			local id = math.random(20, 30);
			self:setDataByKey("shareFlag", true);
			self:addItem(id, 1);
			call(id, 1);
		end});
	end);
end

function shareM:onDelete()
	
end

return shareM;
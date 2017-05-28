local UIPanel = require("cocos.framework.extends.UIPanel");

local welcomeGiftV = class("welcomeGiftV", UIPanel);

function welcomeGiftV:onCreate()
	local counter = 1;
	while (true) do
		local icon = self:seekNodeByName("icon" .. counter);
		if (nil == icon) then
			break;
		end

		counter = counter + 1;
		local num = icon:seekNodeByName("num")
		num:setString(":" .. num:getString());
	end

	self:seekNodeByName("getBtn")
		:setPressedActionEnabled(true)
		:onTouch(function(event)
			if ("ended" == event.name) then
				self:sendCustomEvent(configMsg.welcomeGift_addItem, function()
					self:close();
				end);
			end
		end);
end

function welcomeGiftV:onDelete()
	
end

return welcomeGiftV;
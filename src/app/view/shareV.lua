local panel = require("cocos.framework.extends.UIPanel");
local shareV = class("shareV", panel);

function shareV:onCreate(successCall)
	self:seekNodeByName("closeBtn")
		:setPressedActionEnabled(true)
		:onTouch(function(event)
			if ("ended" == event.name) then
				self:close();
			end
		end);
		
	self:seekNodeByName("shareBtn")
		:setPressedActionEnabled(true)
		:onTouch(function(event)
			if ("ended" == event.name) then
				self:sendCustomEvent(configMsg.share, function(id, num)
					--分享成功
					if (nil ~= successCall) then
						successCall(id, num);
					end
					self:close();
				end);
			end
		end);
end

function shareV:onDelete()
	
end

return shareV;
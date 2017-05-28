local fullPowerV = class("fullPowerV", require("cocos.framework.extends.UIPanel"));

function fullPowerV:onCreate()
	--设置关闭按钮
	self:seekNodeByName("closeBtn")
		:onTouch(function(event)
			if ("ended" == event.name) then
				self:close();
			end
		end);
		
	--设置再来一次按钮
	self:seekNodeByName("buyBtn")
		:onTouch(function(event)
			if ("ended" == event.name) then
				self:sendCustomEvent(configMsg.fullPower, function(result)
	    			if (PAYRESULT.SUCCESS == result) then
		        		self:close();
					end
	    		end);
			end
		end);

	--设置道具钻石消耗
	local itemData = configItem[40];
	self:seekNodeByName("diamond")
		:setString(itemData.diamond);
end

function fullPowerV:onDelete()
end

return fullPowerV;
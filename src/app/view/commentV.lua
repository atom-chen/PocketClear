local panel = require("cocos.framework.extends.UIPanel");
local commentV = class("commentV", panel);

function commentV:onCreate(call)
	self.call = call;

	self:seekNodeByName("closeBtn")
		:setPressedActionEnabled(true)
		:onTouch(function(event)
			if ("ended" == event.name) then
				self:close();
			end
		end);
	
	--"以后再说"按钮
	self:seekNodeByName("btn1")
		:setPressedActionEnabled(true)
		:onTouch(function(event)
			if ("ended" == event.name) then
				self:close();
			end
		end);

	--"吐槽"按钮
	self:seekNodeByName("btn2")
		:setPressedActionEnabled(true)
		:onTouch(function(event)
			if ("ended" == event.name) then
				self:sendCustomEvent(configMsg.comment, function()
					golbal.lua2oc("Adapter", "iapComment");
				end);
				self:close();
			end
		end);
		
	--"五星"按钮
	self:seekNodeByName("btn3")
		:setPressedActionEnabled(true)
		:onTouch(function(event)
			if ("ended" == event.name) then
				self:sendCustomEvent(configMsg.comment, function()
					golbal.lua2oc("Adapter", "iapComment");
				end);
				self:close();
			end
		end);
		
	if (0==self.M:getDataByKey({"onoff", "sneakSkin"})) then
		self:seekNodeByName("des")
			:hide();
	end
end

function commentV:onDelete()
	if (nil ~= self.call) then
		self.call();
	end
end

return commentV;
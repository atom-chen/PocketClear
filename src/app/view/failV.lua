local UIPanel = require("cocos.framework.extends.UIPanel");
local ContextScene = require("app.context.contextScene");
local ContextPanel = require("app.context.contextPanel");

local failV = class("failV", UIPanel);

function failV:onCreate()
	local cpIndex = self.M:getDataByKey("cpIndex");

	--设置关闭按钮
	self:seekNodeByName("closeBtn")
		:onTouch(function(event)
			if ("ended" == event.name) then
				self:close();
				ContextScene:create("selectLevel");
			end
		end);
		
	--设置再来一次按钮
	self:seekNodeByName("againBtn")
		:onTouch(function(event)
			if ("ended" == event.name) then
				self:close();
				ContextPanel:create("levelInfo", cpIndex);
			end
		end);
		
	--设置关卡索引
	self:seekNodeByName("cpIndex")
		:setString(cpIndex);
end

function failV:onDelete()
	
end

return failV;
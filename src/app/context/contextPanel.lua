 local contextPanel = class("contextPanel");
local fileInst = cc.FileUtils:getInstance();

function contextPanel:ctor(name, ...)
	local targetPlatform = cc.Application:getInstance():getTargetPlatform();
	if (cc.PLATFORM_OS_WINDOWS == targetPlatform) then
		package.loaded["app.view." .. name .. "V"] = nil;
	end
	
	--加载面板M文件
	local path = "app/model/" .. name .. "M" .. luaPostfix;
	if (fileInst:isFileExist(path)) then
		self.M = require(path):create(name, ...);
	end
	
	self.V = require("app.view." .. name .. "V")
					:create(name)
					:setModel(self.M)
					:initialize(...)
					:addTo(display.getRunningScene():getLayer("panelLayer"));
end

function contextPanel:getV()
	return self.V;
end

function contextPanel:getM()
	return self.M;
end

return contextPanel;
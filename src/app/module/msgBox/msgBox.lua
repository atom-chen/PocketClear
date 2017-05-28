local msgBox = class("msgBox");

function msgBox:ctor(config, ...)
	local panelName = "msgBox_" .. config.type;
	
	local targetPlatform = cc.Application:getInstance():getTargetPlatform();
	if (cc.PLATFORM_OS_WINDOWS == targetPlatform) then
		package.loaded["app.module.msgBox.msgBox_Normal"] = nil;
		package.loaded["app.module.msgBox." .. panelName] = nil;
	end
	
	self.inst = require("app.module.msgBox." .. panelName)
						:create(panelName)
						:setConfig(config)
						:initialize(...)
						:addTo(display.getRunningScene():getLayer("msgBoxLayer"));
end

return msgBox;
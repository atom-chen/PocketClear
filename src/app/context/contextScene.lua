local contextScene = class("contextScene");
local fileInst = cc.FileUtils:getInstance();

function contextScene:ctor(name, ...)
	local curScene = display.getRunningScene();
	if (nil ~= curScene) then
		curScene.M:delete();
		curScene.M = nil;
	end

	--加载场景M文件
	local path = "app/model/" .. name .. "M" .. luaPostfix;
	if (fileInst:isFileExist(path)) then
		self.M = require(path):create(name, ...);
	end
	
	--加载场景V文件
	self.V = require("app.view." .. name .. "V")
					:create()
					:init(name, self.M)
					:showWithScene();
end

return contextScene;
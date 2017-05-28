
local MyApp = class("MyApp")

local ContextScene = require("app.context.contextScene");

function MyApp:ctor()
    math.randomseed(os.time())

    if CC_SHOW_FPS then
        cc.Director:getInstance():setDisplayStats(true);
    end
end

function MyApp:run()
	--加载配置数据
	require("app.configure.init");
	
	cc.exports.dataCount = require("app.module.dataCount.dataCount"):create(golbal.dataCountType); --数据统计
	cc.exports.dataCenter = require("app.module.dataCenter." .. golbal.dataCenterType):create(); --存盘数据来源

	cc.exports.luaPostfix = ".lua";
	if (cc.PLATFORM_OS_ANDROID==cc.Application:getInstance():getTargetPlatform()) then
		cc.exports.luaPostfix = ".luac";
	end

	--起始场景
	local sceneName, args = unpack(golbal.startScene);
	local method = self["enter" .. sceneName];
	if (nil ~= method) then
		method(self, args);
	end
end

function MyApp:enterlogin(args)
	ContextScene:create("login");
end

function MyApp:enterselectLevel(args)
	ContextScene:create("selectLevel");
end

function MyApp:entermain(args)
	ContextScene:create("main", unpack(args));
end

return MyApp

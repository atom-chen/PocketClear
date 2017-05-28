local contextGuide = class("contextGuide");
local ContextPanel = require("app.context.contextPanel");

function contextGuide:ctor(mStep, sStep)
	local mainIni = configGuide[mStep];
	if (nil == mainIni) then
		return;
	end
	
	local subIni = mainIni[sStep];
	if (nil == subIni) then
		return;
	end
	
	--当前关卡有没有跑过新手引导
	local lastStep = #mainIni+1;
	local m, s = dataCenter:getDataByKey({"guideIndex", mStep, lastStep});
	if (nil~=m)and(nil~=s) then
		return;
	end
	
	ContextPanel:create("guide", mStep, sStep);
end

return contextGuide;
local ContextScene = require("app.context.contextScene");

local loginV = class("loginV", cc.Scene);

--火星闪屏->登录界面
function loginV:onCreate()
	local count, layerArr = 1, {};
	while (true) do
		local createFunc = loginV["layer" .. count];
		if ( nil == createFunc) then
			break;
		end
        
		table.insert(layerArr, createFunc(self));
		count = count + 1;
	end
	
    self.mLayer = cc.LayerMultiplex:new()
    				:addTo(self)
    				:initWithLayers(layerArr)
    				:setLayer(1);
end

function loginV:onDelete()
    
end

function loginV:layer1()
	local layer1 = cc.Layer:create();
	-- local armature = ccs.Armature:create("marsSplash")
	-- 							 :addTo(layer1)
	-- 							 :centerTo(layer1, cc.p(-160, 440))
	-- 							 :play("logo", function (armature)
	-- 							 	armature:delete();
	-- 							 	self.mLayer:setLayer(1);
	-- 							 end);
	return layer1;
end

function loginV:layer2()
	local armatureArr = {};
	local layer2 = cc.Layer:create();

	local loginA = ccs.Armature:create("login")
							   :addTo(layer2)
							   :centerTo(layer2, cc.p(20, -4))
							   :play("login001");
	table.insert(armatureArr, loginA);

    local logoA = ccs.Armature:create("logo")
    						  :addTo(layer2)
    						  :centerTo(layer2, cc.p(0, 400))
    						  :hide()
    						  :delayCall(0.5, function (node)
    						  	node:show()
    						  		:play("LOGO02");
    						  end);
    table.insert(armatureArr, logoA);
    
    local loginBtnA = ccs.Armature:create("loginBtn")
        						  :addTo(layer2)
        						  :centerTo(layer2, cc.p(0, -500))
        						  :hide()
        						  :delayCall(0.7, function (node)
        						  	node:show()
        						  		:play("play1");
        						  end)
        						  :onTouchOne(function (node)
        						  	if (self.M:getDataByKey("firstEnterGameFlag")) then
                                        ContextScene:create("main", 1);
        						  	else
        						  		ContextScene:create("selectLevel");
        						  	end
                                    audio.playSound(unpack(configAudio.sound_1));
        						  end);
    table.insert(armatureArr, loginBtnA);
	return layer2;
end

return loginV;
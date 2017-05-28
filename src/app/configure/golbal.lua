local golbal = {
	--=========================================
	--				   数据
	--=========================================

	--数据来源
	dataCenterType = "dataFromXml",

	--数据统计
	dataCountType = "Adapter",

	--起始场景
	startScene = {
		"selectLevel", --场景名字
		{143,},
	},
	
	lightFullMap = false, --是否点亮全底图
	powerLimit = 30, --体力上限
	recoverPower = 480, --一点体力的恢复时间
	signInSpacing = 86400, --签到间隔
	flipBrandEnergy = 10, --抽取翻牌的能量值
	passCPDefaultFlipBrandEnergy = 1, --默认能量值
	
	noneOpCueLTime = 10, --无操作提示首次时间
	noneOpCueSTime = 3, --无操作提示时间
	
	--提高前期关卡留存措施
	directBegin = 2, --在该关之前一直连玩
	welcomeGiftTriggerCP = 2, --欢迎礼包触发关卡
	firstChargeTriggerCP = 30, --首充大礼包触发关卡
	signInTriggerCP = 6, --签到解锁关卡
	wheelTriggerCP = 2, --转盘解锁关卡
	flipBrandTriggerCP = 20, --翻牌解锁关卡
	
	--棋盘格相关配置
	chessBoard = {
		width = 9, --棋盘格最大宽度
		height = 9, --棋盘格最大高度
		maxLayer = 3, --棋盘格每格最大层数
		
		pixW = 79, --棋盘格的像素宽
		pixH = 79, --棋盘格的像素高
		pixO = 112, --棋盘格斜线距离
		
		minCubeDelNum = 2, --最小方块消除数量
	},

	--=========================================
	--				   函数
	--=========================================
	--获取属性对应的Key值
	coin = function ()
		return clone({"item", 1, "num"});
	end,
	diamond = function ()
		return clone({"item", 2, "num"});
	end,
	star = function ()
		return clone({"item", 3, "num"});
	end,
	power = function ()
		return clone({"item", 4, "num"});
	end,
	score = function ()
		return clone({"item", 5, "num"});
	end,
	
	--根据key值创建一个元素
	createElement = function(key)
		local firstSplit = string.find(key, "@");
		local elementType, viewKey = nil, nil;
		if (nil ~= firstSplit) then
			elementType = string.sub(key, 1, firstSplit-1);
			viewKey = string.sub(key, firstSplit+1);
		else
			elementType = key;
		end

		local elementIni = configElement[elementType];
		if (nil == elementIni) then
			return;
		end

		--创建函数
		local createFunc = elementIni.view.createFunc;
		if (nil == viewKey) then
			return createFunc();
		else
			return elementIni.view[viewKey](createFunc());
		end
	end,
	
	--定时器
	scheduler = function(call, interval, bPaused)
		local scheduler = cc.Director:getInstance():getScheduler()
    	local id = scheduler:scheduleScriptFunc(call, interval, bPaused);
    	return id;
	end,

	--销毁定时器
	removeScheduler = function(id)
		cc.Director:getInstance():getScheduler()
				   :unscheduleScriptEntry(id);
	end,
	
	--金币购买
	buyWithCoin = function(id, num, successCall)
		local itemData = configItem[id];
		local consume = itemData.coin;
		local payment = require("app.module.payment.payment")
								:create(PAYMENT.COIN)
								:pay(consume, function(result)
									if (result == PAYRESULT.SUCCESS) then --购买成功
										if (successCall) then
											successCall();
										end
									elseif (result == PAYRESULT.NOTENOUGH_COIN) then --购买失败
										require("app.module.msgBox.msgBox")
												:create(configPanel.msgBox_NoCoin, 	--type
														function(msgBox) 			--sure call
															--打开商城购买金币
															require("app.context.contextPanel")
																:create("shop", SHOP.MONEY)
																:getV()
																:registerCloseCallback(function()
																	require("app.context.contextPoint")
																		:create("notenoughCoin");
																end);
														end);
									end
								end);
	end,
	
	--钻石购买
	buyWithDiamond = function(id, num, call, shieldSuccessMsgBox)--successCall, failCall)
		local payment = require("app.module.payment.payment")
							:create(PAYMENT.DIAMOND)
							:pay(id, num, function(result)
								call(result);
								if (result == PAYRESULT.SUCCESS) then
									--购买成功弹出框
									if (not shieldSuccessMsgBox) then
										require("app.module.msgBox.msgBox")
	                                        :create(configPanel.msgBox_BuySccess);
	                                end

	                                --数据统计
									local itemData = configItem[id];
									golbal.sendCustomEvent(configMsg.dataCount_buyVirtualItem, {itemData.name .. "@钻石", num, itemData.diamond,});

									--统计游戏三消界面购买道具次数
									if ("main"==display.getRunningScene():getName()) then
										golbal.sendCustomEvent(configMsg.dataCount_customEvent, {COUNTEVENTS._7,});
									end
								elseif (result == PAYRESULT.NOTENOUGH_DIAMOND) then
									--钻石不足弹出框
									require("app.module.msgBox.msgBox")
										:create(configPanel.msgBox_NoDiamond, --type
												function(msgBox)			  --sure call
													local shopPanel = display.getRunningScene()
																			 :getPanelByName("shop");
													if (nil ~= shopPanel) then
														shopPanel:setLabels(SHOP.MONEY);
													else
														local inst = require("app.context.contextPanel")
																		:create("shop", SHOP.MONEY);
														shopPanel = inst:getV();
													end

													shopPanel:registerCloseCallback(function()
														require("app.context.contextPoint")
															:create("notenoughDiamond");
													end);
												end);
								end
							end);
	end,
	
	--话费购买
	buyWithCurrency = function(itemID, call)
		local callPayment = function(payType)
			require("app.module.payment.payment")
				:create(PAYMENT.SMS)
				:pay(itemID, payType, function(result)
					--弹出框
					if ("success" == result) then
						require("app.module.msgBox.msgBox")
							:create(configPanel.msgBox_BuySccess);

						--数据统计
						local itemData = configItem[itemID];
						golbal.sendCustomEvent(configMsg.dataCount_payVirtualItem, {itemData.rmb, 1, itemData.name, 1, 0});
						
						--统计钻石购买次数
						if (103==itemID)or(104==itemID)or(105==itemID) then
							golbal.sendCustomEvent(configMsg.dataCount_customEvent, {COUNTEVENTS._6,});
						end
					end
					
					call(result);
				end);
		end
		
		local ok, isAllowWeChatPay = golbal.lua2oc("Adapter", "isAllowWeChatPay");
		local payType = dataCenter:getDataByKey({"onoff", "payType"});
		if (ok) and (1 == payType) 
			and ("success"==isAllowWeChatPay) then
			require("app.context.contextPanel")
				:create("payment", function(payType)
					callPayment(payType);
				end);
		else
			callPayment(PAYMENT.APPLEPAY);
		end
	end,

	--视频广告
	playVideoAD = function(call)
		audio.setMusicVolume(0);
		audio.setSoundsVolume(0);
		--支付回调 result: look or download
		local function paySuccess(result)
			audio.setMusicVolume(1);
			audio.setSoundsVolume(1);
			if ("uncomplete" ~= result) then
				if (nil ~= call) then
					call(result);
				end
			end
		end
		
		local targetPlatform = cc.Application:getInstance():getTargetPlatform();
		if (cc.PLATFORM_OS_ANDROID == targetPlatform) then

		elseif (cc.PLATFORM_OS_IPHONE==targetPlatform) 
			or (cc.PLATFORM_OS_IPAD==targetPlatform) then
			golbal.lua2oc("Adapter", "showVungle", {call=paySuccess,});
		else
			paySuccess("look");
		end
	end,
	
	--插屏广告
	playInsertAD = function(call)
		--支付回调 result: look or download
		local function paySuccess(result)
			if (nil ~= call) then
				call(result);
			end
		end
		
		local targetPlatform = cc.Application:getInstance():getTargetPlatform();
		if (cc.PLATFORM_OS_ANDROID == targetPlatform) then
			
		elseif (cc.PLATFORM_OS_IPHONE==targetPlatform) 
			or (cc.PLATFORM_OS_IPAD==targetPlatform) then
			golbal.lua2oc("Adapter", "ShowAdviewInterstitial");
		else
			paySuccess();
		end
	end,

	--时间格式化
	formatTime = function(time, align)
	    local format = nil;
	    time = time or 0;
	    if(time > 3600) then
	        if (align) then
	            format = "%02d:%02d:%02d";
	        else
	            format = "%d:%d:%d";
	        end
	        return string.format(format, math.floor(time/3600), math.floor(time/60)%60, (time%60)%60);
	    elseif (time > 60) then 
	        if (align) then
	            format = "%02d:%02d";
	        else
	            format = "%d:%d";
	        end
	        return string.format(format, math.floor(time/60)%60, (time%60)%60);
	    else
	        if (align) then
	            format = "%02d:%02d";
	        else
	            format = "%d:%d";
	        end
	        return string.format(format, math.floor(time/60)%60, (time%60)%60);
	    end
	end,
	
	--宝箱掉落
	dropBox = function(call)
		local srcPos = cc.p(CC_DESIGN_RESOLUTION.width/4*3, CC_DESIGN_RESOLUTION.height/5*4);
		local dstPos = cc.p(CC_DESIGN_RESOLUTION.width/2, CC_DESIGN_RESOLUTION.height/5*2);
		
		local img_box = ccui.ImageView:create()
							:addTo(display.getRunningScene():getLayer("msgBoxLayer"))
							:setName("chests")
							:loadTexture("texture/common/libao.png", 1)
							:setPosition(srcPos)
							:setScale(0.4);

		local spawnActions, motionTime = {}, 1.0; --并发动作表
		local poses = cc.getPosesInArc(srcPos, dstPos); --弧形动作
		poses[2] = cc.p(poses[2].x-300, poses[2].y);
		local spline = cc.CardinalSplineBy:create(motionTime, poses, 0);
		local easeSpline = cc.EaseInOut:create(spline, 1.0);
		table.insert(spawnActions, easeSpline);
		local rotate = cc.RotateBy:create(motionTime, -720); --旋转动作
		table.insert(spawnActions, rotate);
		local scale = cc.ScaleTo:create(motionTime, 1.4); --缩放动作
		table.insert(spawnActions, scale);
		
		local actions = {}; --动作表
		table.insert(actions, cc.Spawn:create(spawnActions));
		table.insert(actions, cc.CallFunc:create(function()
			img_box:setTouchEnabled(true)
				   :onTouch(function(event)
						if ("ended" == event.name) then
							img_box:removeFromParent(true);
							require("app.context.contextPanel")
								:create("freeCoin")
								:getV()
								:registerCloseCallback(call);
						end
					end);

			require("app.tool.actionTime")
				:create(img_box, "buttonBreathe4")
				:play(0, 30);
		end));
		img_box:runAction(cc.Sequence:create(actions));
	end,

	--lua调用java
	lua2java = function(class, method, args, sigs)
		local targetPlatform = cc.Application:getInstance():getTargetPlatform();
		if (cc.PLATFORM_OS_ANDROID ~= targetPlatform) then
			return;
		end
		
		local luaj = require "cocos.cocos2d.luaj";
		local ok, ret = luaj.callStaticMethod("org/cocos2dx/lua/" .. class, method, args, sigs);
		return ok, ret;
	end,

	--lua调用oc
	lua2oc = function(class, method, args)
		local targetPlatform = cc.Application:getInstance():getTargetPlatform();
		if (cc.PLATFORM_OS_IPHONE~=targetPlatform) 
			and (cc.PLATFORM_OS_IPAD~=targetPlatform) then
			if (nil~=args)and(nil~=args.call) then
				args.call();
			end
			return;
		end
		
		local luaoc = require "cocos.cocos2d.luaoc";
		local ok, ret = luaoc.callStaticMethod(class, method, args);
		return ok, ret;
	end,

	sendCustomEvent = function(msg, data)
	    local event = cc.EventCustom:new(msg);
	    event._usedata = data;
	    cc.Director:getInstance():getEventDispatcher():dispatchEvent(event);
	end, 
	
	addCustomEvent = function(obj, msg, method)
	    local listener = cc.EventListenerCustom:create(msg, method);
	    if (nil == listener) then
	        return;
	    end
	    
	    if (nil == obj.customEventListeners) then
	        obj.customEventListeners = {};
	    end
	    table.insert(obj.customEventListeners, listener);

	    cc.Director:getInstance()
	    		   :getEventDispatcher()
	    		   :addEventListenerWithFixedPriority(listener, #obj.customEventListeners);
	end,

	effectFly = function(dstControlName, opControl, actionEndFunc)
		if (nil == opControl) then
			return;
		end

		local dstControl = display.getRunningScene():seekNodeByName(dstControlName);
		if (nil == dstControl) then
			return;
		end

		local curScene = display.getRunningScene();
		if (nil == curScene) then
			return;
		end

		opControl:setScale(1.5)
				 :addTo(curScene)
				 :centerTo(curScene);
				 
		local dstControlPos = dstControl:convertToWorldSpaceAR(cc.p(0, 0));
		opControl:runAction(cc.Sequence:create(
							cc.ScaleTo:create(0.2, 1.0), 
							cc.EaseInOut:create(cc.MoveTo:create(0.6, dstControlPos), 4), 
							cc.CallFunc:create(function()
								opControl:removeFromParent(true);
								if (nil ~= actionEndFunc) then
									actionEndFunc();
								end
							end)));
	end,

	isShowIconAtSelectLevel = function ()
		if (0 == dataCenter:getDataByKey({"onoff", "sneakSkin"})) then
			return false;
		end

		if (0 == dataCenter:getDataByKey({"onoff", "slIconEnable"})) then
			return false;
		end
		return true;
	end,
};

--======================================
--                 ktplay
--======================================
-- cc.exports.kt_showIcon = function(args)
-- 	local curScene = display.getRunningScene();
-- 	if (nil~=curScene)
-- 		and("selectLevel"==curScene:getName()) then
-- 		curScene:setKTPlayIcon(true);
-- 	end
-- end

-- cc.exports.kt_hideIcon = function(args)
-- 	local curScene = display.getRunningScene();
-- 	if (nil~=curScene)
-- 		and("selectLevel"==curScene:getName()) then
-- 		curScene:setKTPlayIcon(false);
-- 	end
-- end

cc.exports.kt_getRewards = function(items)
	local curScene = display.getRunningScene();
	local items = string.split(items, "@");
	for i=1, #items do
		local id, name, num = unpack(string.split(items[i], "#"));
		curScene.M:addItem(tonumber(id), tonumber(num));
	end
end

return golbal;
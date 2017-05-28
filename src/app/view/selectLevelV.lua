local SelectLevelV = class("SelectLevelV", cc.Scene);
local ContextPanel = require("app.context.contextPanel");

function SelectLevelV:onCreate()
	--地图实例
	self.map = require("app.module.map.tiledMapCustom")
					  :create(self.M)
					  :addTo(self.bgLayer)
					  :setLocalZOrder(-1);
	
	self:setIcons(); --设置图标
	self:updateall(); --更新属性
	self:setPowerState(); --更新体力状态
	
	--监控金币, 钻石, 体力, 星星数改变
	self:addCustomEvent(configMsg.data_update, function(event)
		if ("table" == type(event._usedata)) then
			local key, id = unpack(event._usedata);
			if ("item" ~= key) then
				return;
			end
			
			if (id > #self.configure.updateProperty) then
				return;
			end

			self:updateProperty(self.configure.updateProperty[id]);
		else
			local method = self["update" .. event._usedata];
			if (nil ~= method) then
				method(self);
			end
		end
	end);
	
	--监控星际奖励已经领取
	self:addCustomEvent(configMsg.starReward_get, function(event)
		local starValueCtr = self:seekNodeByName("starCon")
								 :seekNodeByName("value");
		self:updatestar(starValueCtr, self.M:getDataByKey(golbal.star()));
	end);
	
	--监控奇幻之旅奖励已经领取
	self:addCustomEvent(configMsg.trip_get, function(event)
		self:updatemagicTrip();
	end);	
	
	--监控欢迎礼包领取
	self:addCustomEvent(configMsg.welcomeGift_addItem, function(event)
		--抬高体力属性控件
		local topCon = self:seekNodeByName("top")
						   :setLocalZOrder(2000);
		local mask = ccui.Layout:create()
						:setTouchEnabled(true)
						:setBackGroundColorType(1)
						:setBackGroundColor(cc.c3b(0, 0, 0))
						:setBackGroundColorOpacity(120)
						:setContentSize(display.size)
						:addTo(topCon)
						:move(0, -1140)
						:setLocalZOrder(9);
		local powerCon = topCon:seekNodeByName("powerCon")
			  				   :setLocalZOrder(10);

		--无线体力动画
		local motionTime, ghostID = 1.6, nil;
		local coinConPos = cc.p(topCon:seekNodeByName("coinCon"):getPosition());
		local startPos = cc.p(coinConPos.x, coinConPos.y-display.size.height/2.0);
		local endPos = cc.pAdd(cc.p(powerCon:seekNodeByName("value"):getPosition()), cc.p(10, 64));

		local spawnActions = {}; --并发动作表
		local poses = cc.getPosesInArc(startPos, endPos); --弧形动作
		poses[2] = cc.p(poses[2].x+200, poses[2].y);
		local spline = cc.CardinalSplineBy:create(motionTime, poses, 0);
		table.insert(spawnActions, cc.EaseInOut:create(spline, 1.0));
		table.insert(spawnActions, cc.RotateBy:create(motionTime, -360)); --旋转动作
		table.insert(spawnActions, cc.ScaleTo:create(motionTime, 0.4)); --缩放动作
		
		local actions = {}; --动作表
		table.insert(actions, cc.Spawn:create(spawnActions));
		table.insert(actions, cc.CallFunc:create(function(node)
			if (nil ~= ghostID) then
				self:removeSchedulerByID(ghostID);
				ghostID = nil;
			end

			node:removeSelf();
			mask:removeSelf();
			
			--无线体力生效消息
			self:sendCustomEvent(configMsg.selectLevel_welcomeGift, function()
				self:setPowerState();
			end);

			--礼包完毕，移动头像
			self.map:headMove(golbal.welcomeGiftTriggerCP, true);
		end));
		local powerImg = ccui.ImageView:create()
							:loadTexture("texture/common/img_wuxiantilitubiao.png", 1)
							:addTo(topCon)
							:setLocalZOrder(10)
							:move(startPos)
							:runAction(cc.Sequence:create(actions));
	end);
	
	--监控礼包购买成功
	self:addCustomEvent(configMsg.point_buySuccess, function(event)
		self:setIcons();
	end);
	
	--监听关卡礼包是否领取
	self:addCustomEvent(configMsg.cpGift, function(event)
		self.map:setcpGift(nil, self.M:getDataByKey("maxCP")+1);
	end);
end

function SelectLevelV:onDelete()
end

function SelectLevelV:onLoadingEnd()
	--地图loading结束
	self.map:onLoadingEnd();

	--关卡奖励
	self:passCPReward();
	
	--欢迎礼包
	local maxIndex = self.M:getDataByKey("maxCP");
	local curCPIndex = self.M:getDataByKey("curCP");
	-- if (nil == curCPIndex) then --登陆场景进入
	-- 	if (not self.M:isSign()) then
	-- 		ContextPanel:create("signIn");
	-- 	else
	-- 		require("app.context.contextPoint")
	-- 			:create("loginGift");
	-- 	end
	-- else

	if (nil ~= curCPIndex) then
		local isPopWelcome = false;
		local passIndex = self.M:getDataByKey("passCPIndex");
		if (golbal.welcomeGiftTriggerCP==passIndex)
			and(maxIndex==passIndex) then
			local buyTime = self.M:getDataByKey({"item", 200, "buyTime"});
			if (buyTime<1) then
				isPopWelcome = true;
				ContextPanel:create("welcomeGift");
			end
		end

		if (not isPopWelcome) then
			require("app.context.contextPoint")
				:create("selectLevelBox");
		end
	end
end

function SelectLevelV:step(dt)
	--体力恢复时间更新
	local arr = {};
	table.insert(arr, dt);
	table.insert(arr, function(time)
		if (0 == time) then
			self:setPowerState();
		end

		local timerCon = self:seekNodeByName("timerCon");
		if (nil == time) then
			timerCon:hide();
		else
			timerCon:seekNodeByName("timer")
					:show()
					:setString(golbal.formatTime(time, true));
		end
	end);
	table.insert(arr, function(time)
		--添加红包倒计时
		local redPacketIcon = self:seekNodeByName("redPacket");
		
		--设置红包倒计时
		if (nil == time) then
			redPacketIcon:hide();
		else
			local redPacketTime = redPacketIcon:seekNodeByName("redtime");
			local redPacketGetIcon = redPacketIcon:seekNodeByName("getRedpacket");
			if (time <= 0) then
				redPacketTime:hide();
				redPacketGetIcon:show();
			else
				redPacketTime:show()
					   		 :setString(golbal.formatTime(time, true));
				redPacketGetIcon:hide();
			end
		end
	end);
	self:sendCustomEvent(configMsg.selectLevel_countDown, arr);
end

--===============================================
--					 更新属性
--===============================================
function SelectLevelV:updateall()
	for i=1, #self.configure.updateProperty do
		self:updateProperty(self.configure.updateProperty[i]);
	end
end

function SelectLevelV:updateProperty(property)
	property = clone(property);
	local key, datakey, func = unpack(property); --属性Key值, 对应控件执行函数

	--获取属性值
	local value = self.M:getDataByKey(datakey);
	if (nil == value) then
		return;
	end
	
	--获取控件
	local propertyCon = self:seekNodeByName(key .. "Con");
	if (nil == propertyCon) then
		return;
	end

	if (nil ~= func) then
		propertyCon:setTouchEnabled(true)
				   :onTouch(function(event)
				   		if ("ended" == event.name) then
				   			func();
				   		end
				   end);
	end

	--更新方法
	local valueCtr = propertyCon:seekNodeByName("value");
	local updateMethod = self["update" .. key];
	if (nil == updateMethod) then
		valueCtr:setString(value);
	else
		updateMethod(self, valueCtr, value);
	end
end

function SelectLevelV:updatepower(ctr, value)
	ctr:setString(value .. ":" .. golbal.powerLimit);
end

function SelectLevelV:updatestar(ctr, value)
	local starRewardIndex = self.M:getDataByKey("starRewardIndex");
	local data = configStarReward[starRewardIndex+1];
	ctr:setString(value .. ":" .. data.stars);

	--生成星级奖励提示
	local starCon = self:seekNodeByName("starCon");
	local starCue = starCon:seekNodeByName("starCue");
	if (nil == starCue) then
		starCue = display.newSprite("#texture/selectLevel/hongsetishi.png")
						 :move(90, 100)
						 :addTo(starCon)
						 :setName("starCue")
						 :hide();
	end

	--是否展示奖励提示
	if (value >= data.stars) then
		starCue:show();
	else
		starCue:hide();
	end
end

function SelectLevelV:updatemagicTrip()
	local isShowCue = false;
	local trips = self.M:getDataByKey({"tripTask"});
	for i=1, #trips do
		local isComplete, isGet = trips[i].complete, trips[i].get;
		if (isComplete)and(not isGet) then
			isShowCue = true;
			break;
		end
	end

	--生成星级奖励提示
	local magicTripCon = self:seekNodeByName("magicTripCon");
	local magicTripCue = magicTripCon:seekNodeByName("magicTripCue");
	if (nil == magicTripCue) then
		magicTripCue = display.newSprite("#texture/selectLevel/hongsetishi.png")
						 :move(110, 110)
						 :addTo(magicTripCon)
						 :setName("magicTripCue")
						 :hide();
	end

	--是否展示奖励提示
	if (isShowCue) then
		magicTripCue:show();
	else
		magicTripCue:hide();
	end
end

function SelectLevelV:updateflipBrandEnergy()
	local icon = self:seekNodeByName("flipBrand");
	self:setIcon_flipBrand(icon);
end

--===============================================
--			   选择关卡界面图标
--===============================================
--图标通用设置
function SelectLevelV:setIcons()
	local root = self:seekNodeByName("root");
	local groupIDMap = {}; --组号显示映时表{[groupID]=visible,}
	
	for i=1, #self.configure.icons do
		local oF, s, l = unpack(self.configure.icons[i]); --起点,间隔,图标列表
		local o = oF(root);
		repeat
			if (nil==o)or(nil==l)or(nil==next(l)) then
				break;
			end

			for j=1, #l do
				local iconName, armatureName, itemID, isVisible, touchFunc = l[j].name, l[j].name_a, l[j].giftID, l[j].isVisible, l[j].opfunc;
				repeat
					--不可见图标
					if (nil==isVisible)or(not isVisible()) then
						break;
					end
					
					--一次性礼包渲染判断
					if (nil ~= itemID) then
						local itemData = configItem[itemID];
						if (not itemData.repeatBuy) then
							--检测不可重复购买礼包是否已经购买
							if (self.M:getDataByKey({"item", itemID, "buyTime"}) >= 1) then
								local icon = root:seekNodeByName(iconName);
								if (nil~=icon) then
									icon:hide();
								end
								break;
							end
						end
					end

					local con = root:seekNodeByName(iconName);
					if (nil == con) then
						con = ccui.Layout:create()
								:setName(iconName)
								:addTo(root)
								:setTouchEnabled(true)
								:onTouch(function(event)
									if ("ended" == event.name) then
										touchFunc(event.target);
									end
								end);

						local armature = ccs.Armature:create("icon")
											 :setName("armature")
											 :addTo(con)
											 :play(armatureName);

						con:setContentSize(armature:getContentSize());
						armature:centerTo(con);

						--特定icon一些额外的特殊设置
						local method = self["setIcon_" .. iconName];
						if (nil ~= method) then
							if (not method(self, con)) then
								break;
							end
						end
					end

					con:move(o.x, o.y);
					o = cc.pAdd(s, o);
				until true
			end
		until true
	end
end

--星星奖励图标特殊设置
function SelectLevelV:setIcon_starReward(icon)
	local con = ccui.Layout:create()
						   :setName("starCon")
						   :setContentSize(icon:getContentSize())
						   :addTo(icon);

	ccui.TextAtlas:create(configNumber._5)
				  :setName("value")
				  :addTo(con)
				  :centerTo(con);
	return true;
end

--奇幻之旅图标特殊设置
function SelectLevelV:setIcon_magicTrip(icon)
	ccui.Layout:create()
			   :setName("magicTripCon")
			   :setContentSize(icon:getContentSize())
			   :addTo(icon);
	return true;
end

--设置红包
function SelectLevelV:setIcon_redPacket(icon)
	ccui.TextAtlas:create(configNumber._1)
			  :setName("redtime")
			  :setScale(0.75)
			  :addTo(icon)
			  :centerTo(icon, cc.p(0, -70));

	ccui.ImageView:create("texture/common/font_qianghongbaoziti.png", 1)
				  :setName("getRedpacket")
				  :hide()
				  :addTo(icon)
				  :centerTo(icon, cc.p(0, -70));
				  
	local redIndex = self.M:getDataByKey("redIndex");
	if (nil == configRedData[redIndex]) then
		icon:hide();
		return false;
	else
		return true;
	end
end

--设置ktplay图标
function SelectLevelV:setKTPlayIcon(isVisible)
	for i=1, #self.configure.icons do
		local _, _, l = unpack(self.configure.icons[i]); --起点,间隔,图标列表
		if (nil~=l)and(nil~=next(l)) then
			for j=1, #l do 
				if ("community" == l[j].name) then
					l[j].visible = isVisible;
				end
			end
		end
	end

	self:seekNodeByName("root")
		:seekNodeByName("community")
		:hide();
		
	self:setIcons();
end

--设置翻牌图标
function SelectLevelV:setIcon_flipBrand(icon)
	if (nil == icon) then
		return;
	end

	local armature = icon:seekNodeByName("armature");
	local percent = self.M:getDataByKey("flipBrandEnergy")/golbal.flipBrandEnergy;
	if (percent >= 1.0) then
		armature:play("fanpailingqu");
		percent = 1.0;
	else
		armature:play("fanpai");
	end

	local bar = icon:seekNodeByName("bar");
	if (nil == bar) then
		local barCon = display.newSprite("#texture/selectLevel/jdt_di.png")
						  :setName("barCon")
		   				  :centerTo(icon, cc.p(0, -70));

		bar = ccui.LoadingBar:create()
				:centerTo(barCon)
				:setName("bar")
				:loadTexture("texture/selectLevel/jdt.png", 1)
	end
	bar:setPercent(percent*100);
	return true;
end

--===============================================
--			   		关卡交互
--===============================================
function SelectLevelV:passCPReward()
	local passCPIndex = self.M:getDataByKey("passCPIndex");
	if (nil == passCPIndex) then
		return;
	end

	--增加通关奖励
	self:sendCustomEvent(configMsg.selectLevel_addReward, passCPIndex);

	--通关奖励表现
	local dstPoses = {};
	local offsetPos = cc.p(display.getRunningScene():getLayer("panelLayer"):getPosition());
	table.insert(dstPoses, cc.pSub(self:seekNodeByName("coinCon"):convertToWorldSpace(cc.p(120, 10)), offsetPos));
	table.insert(dstPoses, cc.pSub(self:seekNodeByName("powerCon"):convertToWorldSpace(cc.p(120, 10)), offsetPos));

	local rewards = clone(configCP[passCPIndex].reward);
	self:addScheduler(function(dt, id)
		local reward = table.remove(rewards);
		if (nil == reward) then
			self:removeSchedulerByID(id);
			return;
		end
		
		local itemData = configItem[reward.id];

		-- 获得奖励动作
		local height, jumpArray = 210, {};
		for i=1, 3 do
            table.insert(jumpArray, cc.JumpBy:create(0.5, cc.p(60, 0), height, 1));
            height = height -70;
        end
        
		local array = {};
		table.insert(array, cc.Spawn:create(cc.Sequence:create(jumpArray), cc.ScaleTo:create(1.5, 1.0)));
		table.insert(array, cc.EaseIn:create(cc.MoveTo:create(1.5, table.remove(dstPoses)), 3));
        table.insert(array, cc.CallFunc:create(function(node)
        	node:removeSelf();
        end));

		ccui.ImageView:create()
			:loadTexture(itemData.icon, 1)
			:addTo(self:getLayer("panelLayer"))
			:centerTo(self:getLayer("panelLayer"))
			:runAction(cc.Sequence:create(array));
	end, 0.5, false);
end

--设置体力状态(无限体力or正常体力)
function SelectLevelV:setPowerState()
	local infinitTime = self.M:getDataByKey({"item", 200, "timebar"});
	local powerIcon = nil;

	local powerCon = self:seekNodeByName("powerCon");
	local icon = powerCon:seekNodeByName("icon")
						 :ignoreContentAdaptWithSize(true);
	if (infinitTime > 0) then
		icon:loadTexture("texture/selectLevel/img_wuxiantiliicon.png", 1);
		powerCon:seekNodeByName("infinitValue")
				:show();
		powerCon:seekNodeByName("value")
				:hide();
		powerCon:seekNodeByName("timerCon")
				:show()
				:seekNodeByName("font")
				:ignoreContentAdaptWithSize(true)
				:loadTexture("texture/selectLevel/font_renwuhoujiesui.png", 1);
	else
		icon:loadTexture("texture/common/img_cp_power.png", 1);
		powerCon:seekNodeByName("infinitValue")
				:hide();
		powerCon:seekNodeByName("value")
				:show();
		powerCon:seekNodeByName("timerCon")
				:seekNodeByName("font")
				:loadTexture("texture/selectLevel/font_jia1.png", 1);
	end
end

return SelectLevelV;
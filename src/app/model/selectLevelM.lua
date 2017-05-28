local selectLevelM = class("selectLevelM", require("app.model.model"));

function selectLevelM:onCreate(cpIndex, isOpenLevelInfoUi)
	self.passCPIndex = cpIndex; --通关的索引
	self.isOpenLevelInfoUi = isOpenLevelInfoUi; --是否打开下一关信息界面
	
	self.counter = 0; --倒计时计数器
	self.powerRcoverTime = 0; --体力恢复倒计时
	self.infinitPowerFlag = false; --欢迎礼包无线体力标志
	
	--红包倒计时
	local itemID = configRedData[self:getDataByKey("redIndex")];
	if (nil == itemID) then
		self.redRcoverTime = nil;
	else
		self.redRcoverTime = self:getDataByKey({"item", itemID, "timebar"})-os.time();
	end
	
	self:powerCounter();
	self:initCustomEvent();
end

function selectLevelM:initCustomEvent()
	--设置体力倒计时
	self:addCustomEvent(configMsg.selectLevel_countDown, function(event)
		local dt, powerCall, redPacketCall = unpack(event._usedata);
		
		self.counter = self.counter + dt;
		if (self.counter < 1) then
			return;
		end
		self.counter = 0;
		
		--体力倒计时更新
		repeat
			if (not self.infinitPowerFlag) then
				local curPower = self:getDataByKey(golbal.power());
				if (curPower >= golbal.powerLimit) then
					powerCall(nil); --隐藏体力恢复倒计时显示
					break;
				end
			end
			
			self.powerRcoverTime = self.powerRcoverTime - 1;
			if (self.powerRcoverTime <= 0) then
				if (self.infinitPowerFlag) then
					self:setDataByKey({"item", 200, "timebar"}, 0);
					self.infinitPowerFlag = false;
				else
					self.powerRcoverTime = golbal.recoverPower;
					self:modifyDataByKey(golbal.power(), 1); --更新体力值
				end
			end
			
			powerCall(self.powerRcoverTime); --刷新界面
		until true

		--红包倒计时
		repeat
			if (nil ~= self.redRcoverTime) then
				self.redRcoverTime = self.redRcoverTime - 1;
			end
			redPacketCall(self.redRcoverTime);
		until true
	end);
	
	--闯关成功添加奖励
	self:addCustomEvent(configMsg.selectLevel_addReward, function(event)
		local rewards = configCP[event._usedata].reward;
		for i=1, #rewards do
			local id, num = rewards[i].id, rewards[i].num;
			if (1 == id) then
				--检测双倍金币奖励
				if (self:getDataByKey({"item", 102, "buyTime"}) >= 1) then
					num = num * 2;
				end
			end
			self:addItem(id, num);
		end
		
		--添加1点翻拍能量值
		if (self.passCPIndex == self:getDataByKey("maxCP")) then
			self:modifyDataByKey("flipBrandEnergy", golbal.passCPDefaultFlipBrandEnergy);
		end
	end);

	--欢迎礼包
	self:addCustomEvent(configMsg.selectLevel_welcomeGift, function(event)
		--设置欢迎礼包的结束时间
		self:setDataByKey({"item", 200, "timebar"}, os.time()+configItem[200].timebar);
		self:powerCounter();
		event._usedata();
	end);
	
	--监控抢红包
	self:addCustomEvent(configMsg.redGetDiamond, function(event)
		local redIndex = self:getDataByKey("redIndex");
		local itemID = configRedData[redIndex];
		if (nil == itemID) then
			self.redRcoverTime = nil;
		else
			self.redRcoverTime = self:getDataByKey({"item", itemID, "timebar"})-os.time();
		end
	end);
end

function selectLevelM:powerCounter()
	--计算离开选择关卡场景的时间恢复体力值
	local curPower, curTime, remainTime = 0, os.time(), 0;
	local infinitPowerEndTime = self:getDataByKey({"item", 200, "timebar"});
	if (0~=infinitPowerEndTime) then
		if (curTime >= infinitPowerEndTime) then
			self:setDataByKey({"item", 200, "timebar"}, 0);
		else
			remainTime = infinitPowerEndTime-curTime;
		end
	end

	if (0 == remainTime) then
		--当没有无限体力时间
		--or无限体力时间失效时进入该逻辑
		local endTime = self:getDataByKey("recoverEndTime");
		if (curTime >= endTime) then
			--已经恢复满
			curPower = golbal.powerLimit;
		else
			--恢复一部分体力
			remainTime = endTime - curTime;
			local unrecoverPower = math.ceil(remainTime/golbal.recoverPower);
			curPower = golbal.powerLimit - unrecoverPower;
			self.powerRcoverTime = (remainTime)%golbal.recoverPower;
		end
		self:setDataByKey(golbal.power(), curPower);
	else
		self.infinitPowerFlag = true;
		self.powerRcoverTime = remainTime;
	end
end

return selectLevelM;
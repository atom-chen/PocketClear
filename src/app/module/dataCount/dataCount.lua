local dataCount = class("dataCount", require("app.model.model"));

function dataCount:ctor(pType)
	self.pType = pType;

	local targetPlatform = cc.Application:getInstance():getTargetPlatform();
	if (cc.PLATFORM_OS_ANDROID==targetPlatform) then
		self:lua2android();
	elseif (cc.PLATFORM_OS_IPHONE==targetPlatform) 
		or (cc.PLATFORM_OS_IPAD==targetPlatform) then
		self:lua2oc();
	else
	end
end

function dataCount:lua2android()
	
end

function dataCount:lua2oc(method, args)
	--设置玩家等级
	self:addCustomEvent(configMsg.dataCount_level, function(event)
		local level = unpack(event._usedata);
		local ok, ret = golbal.lua2oc(self.pType, "setUserLevelId", {level=level,});

		if (DEBUG > 0) then
			print(string.format("dataCount_level---[%d]", level));
		end
	end);
	
	--进入关卡
	self:addCustomEvent(configMsg.dataCount_startLevel, function(event)
		local level = unpack(event._usedata);
		local ok, ret = golbal.lua2oc(self.pType, "startLevel", {level=level,});

		if (DEBUG > 0) then
			print(string.format("dataCount_startLevel---[%d]", level));
		end
	end);

	--通过关卡
	self:addCustomEvent(configMsg.dataCount_finishLevel, function(event)
		local level = unpack(event._usedata);
		local ok, ret = golbal.lua2oc(self.pType, "finishLevel", {level=level,});

		if (DEBUG > 0) then
			print(string.format("dataCount_finishLevel---[%d]", level));
		end
	end);

	--未通过关卡
	self:addCustomEvent(configMsg.dataCount_failLevel, function(event)
		local level = unpack(event._usedata);
		local ok, ret = golbal.lua2oc(self.pType, "failLevel", {level=level,});

		if (DEBUG > 0) then
			print(string.format("dataCount_failLevel---[%d]", level));
		end
	end);

	--记录玩家交易兑换货币的情况
	self:addCustomEvent(configMsg.dataCount_exchange, function(event)
		-- /** 记录玩家交易兑换货币的情况
		--  @param currencyAmount 现金或等价物总额
		--  @param currencyType 为ISO4217定义的3位字母代码，如CNY,USD等（如使用其它自定义等价物作为现金，可使￼用ISO4217中未定义的3位字母组合传入货币类型）￼
		--  @param virtualAmount 虚拟币数量
		--  @param channel 支付渠道
		--  @param orderId 交易订单ID
		--  @return void
		--  */

		local orderId, currencyAmount, currencyType, virtualAmount, channel = unpack(event._usedata);
		local args = {orderId=orderId, currencyAmount=currencyAmount, currencyType=currencyType, virtualAmount=virtualAmount, channel=channel,};
		local ok, ret = golbal.lua2oc(self.pType, "exchange", args);

		if (DEBUG > 0) then
			print(string.format("dataCount_exchange---[%s]", orderId));
		end
	end);

	--玩家支付货币兑换虚拟币
	self:addCustomEvent(configMsg.dataCount_payVirtualMoney, function(event)
		-- /** 玩家支付货币兑换虚拟币.
		--  @param cash 真实货币数量
		--  @param source 支付渠道
		--  @param coin 虚拟币数量
		--  @return void
		--  */
		
		local cash, source, coin = unpack(event._usedata);
		local args = {cash=cash, source=source, coin=coin,};
		local ok, ret = golbal.lua2oc(self.pType, "payVirtualMoney", args);

		if (DEBUG > 0) then
			print(string.format("dataCount_exchange---[%s]", orderId));
		end
	end);

	--玩家支付货币购买道具
	self:addCustomEvent(configMsg.dataCount_payVirtualItem, function(event)
		-- /** 玩家支付货币购买道具.
		--  @param cash 真实货币数量
		--  @param source 支付渠道
		--  @param item 道具名称
		--  @param amount 道具数量
		--  @param price 道具单价
		--  @return void
		--  */
		
		local cash, source, item, amount, price = unpack(event._usedata);
		local args = {cash=cash, source=source, item=item, amount=amount, price=price,};
		local ok, ret = golbal.lua2oc(self.pType, "payVirtualItem", args);

		if (DEBUG > 0) then
			print(string.format("dataCount_payVirtualItem---[%s]", item));
		end
	end);

	--玩家使用虚拟币购买道具
	self:addCustomEvent(configMsg.dataCount_buyVirtualItem, function(event)
		-- /** 玩家使用虚拟币购买道具
		--  @param item 道具名称
		--  @param amount 道具数量
		--  @param price 道具单价
		--  @return void
		--  */

		local item, amount, price = unpack(event._usedata);
		local args = {item=item, amount=amount, price=price,};
		local ok, ret = golbal.lua2oc(self.pType, "buyVirtualItem", args);

		if (DEBUG > 0) then
			print(string.format("dataCount_buyVirtualItem---[%s]", item));
		end
	end);

	--道具消耗统计
	self:addCustomEvent(configMsg.dataCount_useVirtualItem, function(event)
		-- /** 玩家使用虚拟币购买道具
		--  @param item 道具名称
		--  @param amount 道具数量
		--  @param price 道具单价
		--  @return void
		--  */

		local item, amount, price = unpack(event._usedata);
		local args = {item=item, amount=amount, price=price,};
		local ok, ret = golbal.lua2oc(self.pType, "useVirtualItem", args);

		if (DEBUG > 0) then
			print(string.format("dataCount_useVirtualItem---[%s]", item));
		end
	end);

	--玩家获虚拟币奖励
	self:addCustomEvent(configMsg.dataCount_bonusVirtualMoney, function(event)
		-- /** 玩家获虚拟币奖励
		--  @param coin 虚拟币数量
		--  @param source 奖励方式
		--  @return void
		--  */
		
		local coin, source = unpack(event._usedata);
		local args = {coin=coin, source=source,};
		local ok, ret = golbal.lua2oc(self.pType, "bonusVirtualMoney", args);

		if (DEBUG > 0) then
			print(string.format("dataCount_useVirtualItem---[%s]", source));
		end
	end);
	
	--玩家获道具奖励
	self:addCustomEvent(configMsg.dataCount_bonusVirtualItem, function(event)
		-- /** 玩家获道具奖励
		--  @param item 道具名称
		--  @param amount 道具数量
		--  @param price 道具单价
		--  @param source 奖励方式
		--  @return void
		--  */

		local item, amount, price, source = unpack(event._usedata);
		local args = {item=item, amount=amount, price=price, source=source,};
		local ok, ret = golbal.lua2oc(self.pType, "bonusVirtualItem", args);

		if (DEBUG > 0) then
			print(string.format("dataCount_bonusVirtualItem---[%s]", item));
		end
	end);

	--自定义事件
	self:addCustomEvent(configMsg.dataCount_customEvent, function(event)
		-- /** 玩家获道具奖励
		--  @param item 道具名称
		--  @param amount 道具数量
		--  @param price 道具单价
		--  @param source 奖励方式
		--  @return void
		--  */
		
		local eventID = unpack(event._usedata);
		local args = {eventID=eventID,};
		local ok, ret = golbal.lua2oc(self.pType, "event", args);

		if (DEBUG > 0) then
			print(string.format("dataCount_customEvent---[%s]", eventID));
		end
	end);
end

return dataCount;

local Data = class("Data");

function Data:ctor()
	self.propertyMap = {};
	for i=1, #configData do
		local name = configData[i].name;
		local datatype = configData[i].type;
		local default = configData[i].default;
		
		self[name] = default;
		self.propertyMap[name] = {};
		self.propertyMap[name].type = datatype;
		self.propertyMap[name].default = default;
		
		if (configData[i].sub) then
			self.propertyMap[name].sub = {};
			for j=1, #configData[i].sub do
				local sub = configData[i].sub[j];
				self.propertyMap[name].sub[sub.name] = {};
				self.propertyMap[name].sub[sub.name].type = sub.type;
				self.propertyMap[name].sub[sub.name].default = sub.default;
			end
		end
	end
	
	--设置当前关卡
	self.curCP = nil;

	--设置在线开关
	self:iniOnoff();
	
	if (self.onCreate) then
		self:onCreate();
	end
end

function Data:iniOnoff(str)
	self.onoff = {
		ChannelID = "naked", 
		VersionType	= 0, 
		VersionCode	= 0, 
		payType	= 0, 
		wechatDiscount = 0,
		sneakSkin = 0, 
		doubleCoin = 0, 
		doubleCoinHand = 0, 
		firstRecharge = 0, 
		firstRechargeHand = 0, 
		luxuryGift = 0, 
		luxuryGiftHand = 0, 
		extreme = 0, 
		extremeHand = 0, 
		flipBrand = 0, 
		flipBrandHand = 0, 
		bearGift = 0, 
		bearGiftHand = 0, 
		vipDiamond = 0, 
		vipDiamondHand = 0, 
		coinBig = 0, 
		coinBigHand = 0, 
		diamond_3 = 0, 
		diamond_3Hand = 0, 
		slIconEnable = 0,
		signIn = 0,
		loginGift = 0,
		coinAddBtn = 0, 
		diamondAddBtn = 0, 
		notenoughCoin = 0, 
		notenoughDiamond = 0, 
		notenoughItem = 0, 
		gameFail = 0, 
		gameFailLevel = 0, 
		gameFailGift = 0, 
		gameWin = 0, 
		gameWinLevel = 0, 
		gameWinGift = 0, 
		selectLevelBox = 0, 
		selectLevelBoxProb = 0, 
		selectLevelBoxGift = 0, 
		gameBox = 0, 
		gameBoxProb = 0, 
		gameBoxLevel = 0, 
		gameBoxGift = 0, 
		wheelDiamondEnd = 0,
		wheelDiamondEndPro = 0,
		wheelDiamondEndGift = 0,
	};

	local id = nil;
	id = golbal.scheduler(function(dt)
		local ok, res = nil, nil;
		local targetPlatform = cc.Application:getInstance():getTargetPlatform();
		if (cc.PLATFORM_OS_ANDROID == targetPlatform) then
			-- ok, res = golbal.lua2java(golbal.dataCountType, "getOnlineParam", {}, "()Ljava/lang/String;");
		elseif (cc.PLATFORM_OS_IPHONE==targetPlatform) 
			or (cc.PLATFORM_OS_IPAD==targetPlatform) then
			ok, res = golbal.lua2oc(golbal.dataCountType, "getParam", {key="Trigger",});
		end
		
		if (ok) then
			if (nil~=res)and(0~=string.len(res)) then --取值失败, 继续
				golbal.removeScheduler(id);
				if ("error" ~= res) then --网络断开
					local onoff = json.decode(res);
					if (0 ~= onoff.sneakSkin) then
						self.onoff = onoff;
					end
				end
			end
		end
	end, 0, false);
end

--=============================================
--			单字段数据set, get操作
--=============================================
function Data:getDataByKey(key)
	if (nil == key) then
		return;
	end
	
	--判断是否有自定义获取方法->N:判断是否该单字段->N:返回空
	--							Y:获取, 返回		Y:获取, 返回
	local firstkey = nil;
	if ("string" == type(key)) then
		firstkey = key;
	else
		firstkey = table.remove(key, 1);
	end

	local method = self["get" .. firstkey];
	if (nil ~= method) then
		return method(self, unpack(key));
	else
		return self[firstkey];
	end
end

function Data:setDataByKey(key, value)
	if (nil == key) then
		return;
	end
	
	--判断是否有自定义设置方法->N:判断是否该单字段->N:返回空
	--							Y:设置, 返回		Y:设置, 返回
	local firstkey = nil;
	if ("string" == type(key)) then
		firstkey = key;
	else
		firstkey = table.remove(key, 1);
	end
	
	local method = self["set" .. firstkey];
	if (nil ~= method) then
		table.insert(key, value);
		method(self, unpack(key));
	else
		if ("guideIndex"~=key) then
			self[key] = value; --设置数据
		end
		self:persistent(key, value); --设置值以后对数据进行持久化
	end
end

function Data:modifyDataByKey(key, modify)
	if (nil == key) then
		return;
	end
	
	local keepKey = clone(key);
	local value = self:getDataByKey(key);
	value = value + modify;
	if (value < 0) then
		value = 0;
	end
	
	self:setDataByKey(keepKey, value);
end

--=============================================
--			多字段数据set, get操作
--=============================================
function Data:getcheckPoint(...)
	local args = {...};
	if (0 == #args) then
		return self.checkPoint;
	elseif (#args >= 1) then 
		local cpIndex = args[1];
		if (nil == self.checkPoint[cpIndex]) then
			return;
		end
		
		if (#args == 1) then
			return self.checkPoint[cpIndex];
		elseif (#args == 2) then
			return self.checkPoint[cpIndex][args[2]];
		elseif (#args == 3) then
			local cpIndexData = self.checkPoint[cpIndex];
			return cpIndexData[args[2]], cpIndexData[args[3]];
		end
	end
end

function Data:setcheckPoint(index, name, value)
	if (nil == self.checkPoint[index]) then
		self.checkPoint[index] = {};
	end
	
	self.checkPoint[index][name] = value;
	self:persistent({"checkPoint", index, name,}, value);
end

function Data:getitem(...)
	local args = {...};
	if (0 == #args) then
		return self.item;
	elseif (1 == #args) then
		return self.item[args[1]];
	elseif (2 == #args) then
		return self.item[args[1]][args[2]];
	end
end

function Data:setitem(id, name, value)
	if (self.item[id]) then
		self.item[id][name] = value;
		self:persistent({"item", id, name}, self.item[id][name]);
	end
end

function Data:gettripTask(...)
	local args = {...};
	if (0 == #args) then
		return self.tripTask;
	elseif (#args >= 1) then 
		local cpIndex = args[1];
		if (nil == self.tripTask[cpIndex]) then
			return;
		end

		if (#args == 1) then
			return self.tripTask[cpIndex];
		elseif (#args == 2) then
			return self.tripTask[cpIndex][args[2]];
		elseif (#args == 3) then
			local cpIndexData = self.tripTask[cpIndex];
			return cpIndexData[args[2]], cpIndexData[args[3]];
		end
	end
end

function Data:settripTask(index, name, value)
	if (nil == self.tripTask[index]) then
		self.tripTask[index] = {};
	end
	
	self.tripTask[index][name] = value;
	self:persistent({"tripTask", index, name,}, value);
end

function Data:getonoff(...)
	local args = {...};
	if (0 == #args) then
		return self.onoff;
	elseif (1 == #args) then
		return self.onoff[args[1]];
	end
end

function Data:setonoff(key, value)
	self.onoff[key] = value;
end

-- function Data:setguideIndex(main, sub)
-- 	self.guideIndex[self.guideIndexCount] = {main, sub};
-- 	self:persistent("guideIndex", {main, sub,});
-- end

function Data:getguideIndex(main, sub)
	for i=1, #self.guideIndex do
		local m, s = unpack(self.guideIndex[i]);
		if (m==main)and(s==sub) then
			return m, s;
		end
	end
	return nil, nil;
end

--=============================================
--			  获取配置文件某字段
--=============================================
function Data:getini(...)
	local keys = {...};

	local value = cc.exports[table.remove(keys, 1)];
	for i=1, #keys do
		if (nil == value) then
			return nil;
		end
		value = value[keys[i]];
	end
	return clone(value);
end

return Data;

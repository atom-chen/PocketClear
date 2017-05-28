local DataFromXml = class("DataFromXml", require("app.module.dataCenter.data"));
local xmlInst = cc.UserDefault:getInstance();

function DataFromXml:onCreate()
	for i=1, #configData do
		--是否有自定义读取xml函数->N:用UserDefault读取
		--						   Y:自定义读取
		local method = "read" .. configData[i].name;
		if (nil ~= self[method]) then
			self[method](self, configData[i]);
		else
			self[configData[i].name] = self:read(configData[i]);
			
			--每天重置
			if (configData[i].dayReset) 
				and (self:getDataByKey("newDay"))then
				self[configData[i].name] = configData[i].default;
				self:setDataByKey(configData[i].name, configData[i].default);
			end
		end
	end
end

--=========================================
--				存盘操作
--=========================================
function DataFromXml:persistent(key, value)
	if (nil == key) then
		return;
	end
	
	local keepKey, firstkey = clone(key), nil;
	if ("string" == type(key)) then
		firstkey = key;
	else
		firstkey = table.remove(key, 1);
	end
	
	if (self["persistent" .. firstkey]) then
		if ("table" == type(key)) then
			table.insert(key, value);
		else
			key = value;
		end
		self["persistent" .. firstkey](self, unpack(key));
	else
		local property = self.propertyMap[firstkey];
		if (nil == property) then
			return;
		end

		local method = "set" .. property.type .. "ForKey";
		xmlInst[method](xmlInst, key, value);
		xmlInst:flush();
	end
end

function DataFromXml:persistentitem(id, name, value)
	local property = self.propertyMap["item"];
	local subProperty = property.sub[name];
	local method = "set" .. subProperty.type .. "ForKey";
	xmlInst[method](xmlInst, "item" .. id .. name, value);
	xmlInst:flush();
end

function DataFromXml:persistentcheckPoint(index, name, value)
	local property = self.propertyMap["checkPoint"];
	local subProperty = property.sub[name];
	local method = "set" .. subProperty.type .. "ForKey";
	xmlInst[method](xmlInst, "checkPoint" .. index .. name, value);
	xmlInst:flush();
end

function DataFromXml:persistenttripTask(index, name, value)
	local property = self.propertyMap["tripTask"];
	local subProperty = property.sub[name];
	local method = "set" .. subProperty.type .. "ForKey";
	xmlInst[method](xmlInst, "tripTask" .. index .. name, value);
	xmlInst:flush();
end

function DataFromXml:persistentguideIndex(main, sub)
	self.guideIndex[self.guideIndexCount] = {main, sub};

	local property = self.propertyMap["guideIndex"];
	local method = "set" .. property.type .. "ForKey";
	xmlInst[method](xmlInst, "guideIndex" .. self.guideIndexCount, main .. "_" .. sub);
	xmlInst:flush();
	self.guideIndexCount = self.guideIndexCount + 1;
end

--=========================================
--				读盘操作
--=========================================
function DataFromXml:read(config)
	local method = "get" .. config.type .. "ForKey";
	if (nil == xmlInst[method]) then
		return config.default;
	end
	return xmlInst[method](xmlInst, config.name, config.default);
end

function DataFromXml:readfirstGameTime(config)
	self[config.name] = self:read(config);
	if (0 == self[config.name]) then
		self[config.name] = os.time();
		self:persistent(config.name, self[config.name]);
		self:setDataByKey(golbal.power(), golbal.powerLimit);
		self.firstEnterGameFlag = true;
	end
end

function DataFromXml:readcurDay(config)
	self[config.name] = self:read(config);
	local curDay = math.ceil((os.time()-self.firstGameTime)/86400);
	if (curDay > self[config.name]) then
		--新的一天
		self.newDay = true;
		self:persistent(config.name, curDay);
	end
end

function DataFromXml:readcheckPoint(config)
	if (nil == self[config.name]) then
		self[config.name] = {};
	end

	self.item[3].num = 0;
	self.item[5].num = 0;
	
	for i=1, self.maxCP+1 do
		self[config.name][i] = {};
		for j=1, #config.sub do
			local subConfig = clone(config.sub[j]);
			local propertyName = subConfig.name;
			subConfig.name = config.name .. i .. subConfig.name;
			self[config.name][i][propertyName] = self:read(subConfig);
			
			if (propertyName == "star") then
				self.item[3].num = self.item[3].num + self[config.name][i][propertyName];
			elseif (propertyName == "score") then
				self.item[5].num = self.item[5].num + self[config.name][i][propertyName];
			end
		end
	end

	--统计数据
	golbal.sendCustomEvent(configMsg.dataCount_level, {self.maxCP});
end

function DataFromXml:readtripTask(config)
	if (nil == self[config.name]) then
		self[config.name] = {};
	end

	--初始化每个任务数据
	local curTime, maxCompleteIndex = os.time(), 0; --当前时间,最大完成的任务
	for i=1, #configTrip do
		self[config.name][i] = {};
		for j=1, #config.sub do
			local subConfig = clone(config.sub[j]);
			local propertyName = subConfig.name;
			subConfig.name = config.name .. i .. subConfig.name;
			self[config.name][i][propertyName] = self:read(subConfig);
		end

		local day, cp, time, _, _ = unpack(configTrip[i]);
		if (self[config.name][i].endTime < 0) then
		    --如果任务未激活
			local startTime = self.firstGameTime + day; --计算任务开始时间
			local endTime = startTime + time; --计算任务结束时间
			self:setDataByKey({config.name, i, "startTime"}, startTime);
			self:setDataByKey({config.name, i, "endTime"}, endTime);
			self:setDataByKey({config.name, i, "complete"}, false);
			self:setDataByKey({config.name, i, "get"}, false);
		else
			--如果任务激活,则判断是否完成任务
			if (self.maxCP>=cp)and(0~=self[config.name][i].endTime) then
				maxCompleteIndex = i;
				self:setDataByKey({config.name, i, "endTime"}, 0);
				self:setDataByKey({config.name, i, "complete"}, true);
			end
		end
	end
	
	--设置下一个任务的启动时间
	local nextTripTask = self[config.name][maxCompleteIndex+1];
	if (nil~=nextTripTask)and(curTime<nextTripTask.startTime) then
		self:setDataByKey({config.name, maxCompleteIndex+1, "startTime"}, curTime);	
	end
end

function DataFromXml:readitem(config)
	if (nil == self[config.name]) then
		self[config.name] = {};
	end

	local itemList = self:getDataByKey({"ini", "configItem",});
	for k, v in pairs(itemList) do
		self[config.name][k] = {};
		for i=1, #config.sub do
			local subConfig = clone(config.sub[i]);
			local propertyName = subConfig.name;
			subConfig.name = config.name .. k .. subConfig.name;
			self[config.name][k][propertyName] = self:read(subConfig);
		end

		local readMethod = self["read" .. config.name .. k];
		if (nil ~= readMethod) then
			readMethod(self);
		end
	end
end

function DataFromXml:readitem4()
	if (os.time() > self.recoverEndTime) then
		self:setDataByKey(golbal.power(), golbal.powerLimit);
		self:setDataByKey("recoverEndTime", 0);
	end
end

function DataFromXml:readitem200()
	if (os.time() > self.item[200].timebar) then
		self:setDataByKey({"item", 200, "timebar"}, 0);
	end
end

function DataFromXml:readredIndex(config)
	self[config.name] = self:read(config);
	if (self:getDataByKey("newDay")) then
		self[config.name] = 1;
		self:setDataByKey("redIndex", config.default);
	end
	
	local itemID = configRedData[self[config.name]];
	if (nil ~= itemID) then
		local itemData = configItem[itemID];
		self:setDataByKey({"item", itemID, "timebar"}, (os.time()+itemData.timebar));
	end
end

function DataFromXml:readguideIndex(config)
	if (nil==self[config.name]) then
		self.guideIndexCount = 1;
		self[config.name] = {};
	end
	
	while (true) do
		local tempConfig = clone(config);
		tempConfig.name = tempConfig.name .. self.guideIndexCount;
		local guideID = self:read(tempConfig);
		if (0 == string.len(guideID)) then
			break;
		else
			local main, sub = unpack(string.split(guideID, "_"));
			self[config.name][self.guideIndexCount] = {tonumber(main), #configGuide[tonumber(main)]+1};
			self.guideIndexCount = self.guideIndexCount + 1;
		end
	end
end

return DataFromXml;
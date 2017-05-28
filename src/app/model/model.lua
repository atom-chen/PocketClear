local Model = class("Model");

function Model:ctor(name, ...)
	self.name = name;

	if (self.onCreate) then
		self:onCreate(...);
	end
end

function Model:delete()
	--释放监听器
    if (self.customEventListeners)
        and (nil ~= next(self.customEventListeners)) then
        for i=1, #self.customEventListeners do
            cc.Director:getInstance()
    		   		   :getEventDispatcher()
                       :removeEventListener(self.customEventListeners[i]);
        end
    end

    if (self.onDelete) then
    	self:onDelete();
    end
end

function Model:getDataByKey(key)
	if (nil == key) then
		return;
	end
	
	--判断是否有自定义获取方法->N:判断是否该model字段->N:扔到datacenter处理
	--							Y:获取, 返回		   Y:获取, 返回
	local keepKey, firstkey = clone(key), nil;
	if ("string" == type(key)) then
		firstkey = key;
	else
		firstkey = table.remove(key, 1);
	end

	local method = self["get" .. firstkey];
	if (nil ~= method) then
		return method(self, unpack(key));
	else
		if (self[firstkey]) then
			return self[firstkey];
		else
			return dataCenter:getDataByKey(keepKey);
		end
	end
end

function Model:setDataByKey(key, value)
	if (nil == key) then
		return;
	end

	--判断是否有自定义设置方法->N:判断是否该model字段->N:扔到datacenter处理
	--							Y:设置, 返回		   Y:设置, 返回
	local keepKey, firstkey, msgKey = clone(key), nil, clone(key);
	if ("string" == type(key)) then
		firstkey = key;
	else
		firstkey = table.remove(key, 1);
	end
	
	local method = self["set" .. firstkey];
	if (nil ~= method) then
		method(self, unpack(key), value);
	else
		if (self[firstkey]) then
			self[firstkey] = value;
		else
			dataCenter:setDataByKey(keepKey, value);
		end
	end

	self:sendCustomEvent(configMsg.data_update, msgKey);
end

function Model:modifyDataByKey(key, modify)
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

function Model:addCustomEvent(msg, method)
	local listener = cc.EventListenerCustom:create(msg, method);
    if (nil == listener) then
        return;
    end
    
    if (nil == self.customEventListeners) then
        self.customEventListeners = {};
    end
    table.insert(self.customEventListeners, listener);

    cc.Director:getInstance()
    		   :getEventDispatcher()
    		   :addEventListenerWithFixedPriority(listener, #self.customEventListeners);
end

function Model:sendCustomEvent(msg, data)
    local event = cc.EventCustom:new(msg);
    event._usedata = data;
    cc.Director:getInstance():getEventDispatcher():dispatchEvent(event);
end

--==============================道具
function Model:addItem(id, num)
	local itemData = configItem[id];
	if (nil ~= itemData.pack) then
		for i=1, #itemData.pack do
			if ("number" == type(itemData.pack[i].num)) then
				self:addItem(itemData.pack[i].id, itemData.pack[i].num);
			else
				local min = itemData.pack[i].num.min;
				local max = itemData.pack[i].num.max;
				if (nil~=min)and(nil~=max) then
					self:addItem(itemData.pack[i].id, math.random(min, max));
				end
			end
		end
	else
		if (4 == id) then --体力属性
			self:addPower(num);
		else
			self:modifyDataByKey({"item", id, "num"}, num);

			--数据统计
			local itemData = configItem[id];
			golbal.sendCustomEvent(configMsg.dataCount_bonusVirtualItem, {itemData.name, num, itemData.diamond, 0});
		end
	end
end

function Model:useItem(id, num)
	self:modifyDataByKey({"item", id, "num"}, -num);

	--数据统计
	local itemData = configItem[id];
	golbal.sendCustomEvent(configMsg.dataCount_useVirtualItem, {itemData.name, num, itemData.diamond,});
end

function Model:getItem(id, propertyName)
	if (nil == propertyName) then
		return self:getDataByKey({"item", id});
	else
		return self:getDataByKey({"item", id, propertyName});
	end
end

function Model:addPowerByItem(id)
	self:useItem(id, 1); --使用道具

	--恢复体力值
	local recoverValue = 0;
	if (20 == id) then --小体力瓶
		recoverValue = 5;
	elseif (21 == id) then --大体力瓶
		recoverValue = 30;
	end
	
	self:addPower(recoverValue);
end

function Model:addPower(value)
	local curPower = self:getDataByKey(golbal.power()) + value;
	if (curPower > golbal.powerLimit) then
		curPower = golbal.powerLimit;
		self:setDataByKey("recoverEndTime", 0); --设置体力恢复结束时间
	else
		local endTime = self:getDataByKey("recoverEndTime");
		self:setDataByKey("recoverEndTime", endTime-value*golbal.recoverPower)
	end
	self:setDataByKey(golbal.power(), curPower);
end

--是否签到
function Model:isSign()
	local signInTime = self:getDataByKey("singInTime");
	if (0 == signInTime) then
		return false;
	end

    local spacing = os.time() - signInTime;
    if (spacing < 0) then
        spacing = 0;
    end
    
    if (spacing >= golbal.signInSpacing) then
        return false;
    end
	return true;
end

return Model;
local tripM = class("tripM", require("app.model.model"));

function tripM:onCreate()
	--任务开始(倒计时结束or任务完成)
	self:addCustomEvent(configMsg.trip_newTask, function(event)
		event._usedata();
	end);

	--领取奖励
	self:addCustomEvent(configMsg.trip_get, function(event)
		local index, callBack = unpack(event._usedata);
		
		local _, _, _, _, items = unpack(configTrip[index]);
		for i=1, #items do
			local itemID, itemNum = unpack(items[i]);
			self:addItem(itemID, itemNum);
		end
		
		self:setDataByKey({"tripTask", index, "get"}, true);
		
		--视图回调
		callBack();
	end);
	
	--重置任务
	self:addCustomEvent(configMsg.trip_reset, function(event)
		local index, callBack = unpack(event._usedata);
		local _, _, time, _, _ = unpack(configTrip[index]);
		
		--设置数据
		self:setDataByKey({"tripTask", index, "startTime"}, os.time());
		self:setDataByKey({"tripTask", index, "endTime"},  time + os.time());
		self:setDataByKey({"tripTask", index, "complete"}, false);
		self:setDataByKey({"tripTask", index, "get"}, 	   false);

		--视图回调
		callBack();
	end);
end

function tripM:onDelete()
	
end

return tripM;
local fiveStepM = class("fiveStepM", require("app.model.model"));

function fiveStepM:onCreate(arg1, arg2)
	self.type = unpack(arg1);
	self.buyCall, self.closeCall = unpack(arg2);

	self.freeCoin = math.random(100, 200);

	--钻石购买加五步
	local itemID = 22;
	if (ACTION.TIME == self.type) then
		itemID = 24;
	end
	self:addCustomEvent(configMsg.fiveStep_diamond, function(event)
		local itemNum = self:getDataByKey({"item", itemID, "num"});
		if (itemNum > 0) then
			event._usedata(PAYRESULT.SUCCESS);
			self:useItem(itemID, 1);
		else
			golbal.buyWithDiamond(itemID, 1, function(result)
				event._usedata(result);
				
				--数据统计
				if (PAYRESULT.SUCCESS == result) then
					golbal.sendCustomEvent(configMsg.dataCount_customEvent, {COUNTEVENTS._1,});
				end
			end, true);
		end
	end);
	
	--视频广告加五步
	self:addCustomEvent(configMsg.fiveStep_ad, function(event)
		display.getRunningScene().M.fiveStepADFlag = true;
		event._usedata();
		
		--数据统计
		if (PAYRESULT.SUCCESS == result) then
			golbal.sendCustomEvent(configMsg.dataCount_customEvent, {COUNTEVENTS._2,});
		end
	end);
end

function fiveStepM:onDelete()
	
end

return fiveStepM;
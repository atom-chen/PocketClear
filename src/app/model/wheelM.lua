local wheelM = class("wheelM", require("app.model.model"));

function wheelM:onCreate()
	local itemList = {}; --转盘上的道具数据
	self.drawSumProb = 0; --抽取总几率
	self.drawProbs = {}; --各个道具抽取几率
	
	--转盘上的道具刷新
	self:addCustomEvent(configMsg.wheelRefresh, function(event)
		--获得显示池总几率, 显示池各个道具显示几率, 
		local getShowItemPoolInfo = function(pool)
			local showSumProb, showProbs = 0, {};
			
			--初始化转盘所有道具的显示几率
			for i=1, #pool do
				showSumProb = showSumProb + pool[i].showProb;
				table.insert(showProbs, showSumProb);			
			end
			return showSumProb, showProbs;
		end

		--抽取显示道具
		local showItemPool = clone(configWheel);
		while (true) do
			if (#itemList >= 8) then
				break;
			end

			local showSumProb, showProbs = getShowItemPoolInfo(showItemPool);
			local value = math.random(1, showSumProb);
			for i=1, #showProbs do
				if (value <= showProbs[i]) then
					--初始化转盘道具的抽取几率
					self.drawSumProb = self.drawSumProb + showItemPool[i].drawProb;
					table.insert(self.drawProbs, self.drawSumProb);

					--初始化转盘数据
					table.insert(itemList, {showItemPool[i].id, showItemPool[i].num,});

					--从池中删除已经抽取的显示道具
					table.remove(showItemPool, i);
					break;
				end
			end
		end
		event._usedata(itemList);
	end);
	
	--钻石抽奖
	self:addCustomEvent(configMsg.wheelDraw_diamond, function(event)
		local itemIDs = {39, 36, 36, 37, 37, 38, 38,};
		local count = self:getDataByKey("wheelDiamondCount")+1;
		if (count > #itemIDs) then
			count = #itemIDs;
		end
		
		local itemID = itemIDs[count];
		golbal.buyWithDiamond(itemID, 1, function(result)
			if (PAYRESULT.SUCCESS == result) then
				local drawIndex = self:draw(); --抽奖
				self:modifyDataByKey("wheelDiamondCount", 1); --增加钻石次数
				self:addItem(unpack(itemList[drawIndex])); --添加道具
				event._usedata(drawIndex); --显示回调

				--数据统计
				if (39 == itemID) then
					golbal.sendCustomEvent(configMsg.dataCount_customEvent, {COUNTEVENTS._5,});
				else
					golbal.sendCustomEvent(configMsg.dataCount_customEvent, {COUNTEVENTS._4,});
				end
			end
		end, true);
	end);

	--广告抽奖
	self:addCustomEvent(configMsg.wheelDraw_ad, function(event)
		local call = event._usedata;
		golbal.playVideoAD(function(result)
			local drawIndex = self:draw(); --抽奖
			self:modifyDataByKey("wheelADCount", 1); --设置次数
			self:setDataByKey("wheelAD_CD", os.time()+300); --设置CD

			local id, num = unpack(itemList[drawIndex]);
			if ("download" == result) then
				num = num * 2;
			end
			self:addItem(id, num); --添加道具
			call(drawIndex); --显示回调
		end);
	end);

	--转盘冷却时间结束
	self:addCustomEvent(configMsg.wheelCDComplete, function(event)
		self:setDataByKey("wheelAD_CD", 0);
		event._usedata();
	end);
end

function wheelM:onDelete()
	
end

function wheelM:draw()
	--抽取奖品
	local drawIndex = 0;
	local value = math.random(1, self.drawSumProb);
	for i=1, #self.drawProbs do
		if (value <= self.drawProbs[i]) then
			drawIndex = i;
			break;
		end
	end
	return drawIndex;
end

return wheelM;
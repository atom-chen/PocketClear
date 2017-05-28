local levelInfoM = class("levelInfoM", require("app.model.model"));

function levelInfoM:onCreate(cpIndex)
	self.cpIndex = cpIndex;
	self.cpData = configCP[self.cpIndex];

	--注册体力扣除消息
	self:addCustomEvent(configMsg.levelInfo_deductPower, 
						function(event)
							--设置当前体力
							self:modifyDataByKey(golbal.power(), -event._usedata);
							
							--这是体力恢复结束时间
							local endTime = self:getDataByKey("recoverEndTime");
							local consumeTime = event._usedata*golbal.recoverPower;
							if (0 == endTime) then
								endTime = os.time() + consumeTime;
							else
								endTime = endTime + consumeTime;
							end
							self:setDataByKey("recoverEndTime", endTime);
						end);
	
	--注册取消购买道具
	self:addCustomEvent(configMsg.levelInfo_cancelBuy,
						function(event)
							self:modifyDataByKey(golbal.coin(), event._usedata);
						end);
end

function levelInfoM:onDelete()
end

return levelInfoM;
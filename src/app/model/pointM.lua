local pointM = class("pointM", require("app.model.model"));

function pointM:onCreate()
	--计费点界面购买按钮触发
	self:addCustomEvent(configMsg.point_buy, function(event)
		self:pay(unpack(event._usedata));
	end);

	--添加道具,全部奖励关闭按钮
	self:addCustomEvent(configMsg.point_addItem, function(event)
		local itemList, callBack = unpack(event._usedata);
		for i=1, #itemList do
			self:addItem(unpack(itemList[i]));
		end
		callBack();
	end);
end

function pointM:onDelete()
	
end

function pointM:pay(id, successCall, extraItemList, failCall, cancelCall)
	if (nil == id) then
		return;
	end
	
	golbal.buyWithCurrency(id, function(result)
		if (result == "success") then
			--增加礼包购买次数
			self:modifyDataByKey({"item", id, "buyTime",}, 1);
			
			--成功购买计费点,添加道具
			local itemData = configItem[id];
			if (nil ~= itemData.pack) then
				self:addItem(id, 1);
			else
				if (102 == id) then --永久双倍金币
				elseif (109 == id) then --全部奖励
					if (nil ~= extraItemList) then
						for i=1, #extraItemList do
							self:addItem(unpack(extraItemList[i]));
						end
					end
				end
			end

			--通知监听该消息point_buySuccess监听者
			self:sendCustomEvent(configMsg.point_buySuccess);

			--成功回调
			if (nil ~= successCall) then
				successCall(self);
			end
		elseif (result == "fail") then
			if (nil ~= failCall) then
				failCall(self);
			end
		elseif (result == "cancel") then
			if (nil ~= cancelCall) then
				cancelCall(self);
			end
		end
	end);
end

return pointM;
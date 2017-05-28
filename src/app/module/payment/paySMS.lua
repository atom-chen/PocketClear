local paySMS = class("paySMS", require("app.model.model"));

function paySMS:onCreate()
	
end

--消耗, 购买结果回调
function paySMS:pay(itemID, payType, call)
	self.itemData = self:getDataByKey({"ini", "configItem", itemID});
	
	--支付回调
	local function paySuccess(result)
		if (nil ~= call) then
			call(result);
		end
	end
	
	local targetPlatform = cc.Application:getInstance():getTargetPlatform();
	if (cc.PLATFORM_OS_ANDROID == targetPlatform) then
		paySuccess("success");
	elseif (cc.PLATFORM_OS_IPHONE==targetPlatform) 
		or (cc.PLATFORM_OS_IPAD==targetPlatform) then
		if (payType == PAYMENT.WECHAT) then
			local discount = dataCenter:getDataByKey({"onoff", "wechatDiscount",})/100;
			golbal.lua2oc("Adapter", "wechatPay", {price=self.itemData.rmb*100*discount, name=self.itemData.name, call=paySuccess,});
		elseif (payType == PAYMENT.APPLEPAY) then
			golbal.lua2oc("Adapter", "iapPay", {point=self.itemData.point, call=paySuccess,});
		end
	else
		paySuccess("success");
	end 
end

return paySMS;

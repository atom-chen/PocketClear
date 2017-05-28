local UIPanel = require("cocos.framework.extends.UIPanel");
local paymentV = class("paymentV", UIPanel);

function paymentV:onCreate(payFunc)
	--设置关闭按钮
	self:seekNodeByName("closeBtn")
		:onTouch(function(event)
			if ("ended" == event.name) then
				self:close();
			end
		end);
		
	--设置苹果支付按钮
	self:seekNodeByName("appleBtn")
		:setPressedActionEnabled(true)
		:onTouch(function(event)
			if ("ended" == event.name) then
				payFunc(PAYMENT.APPLEPAY);
				self:close();
			end
		end);

	--设置微信支付按钮
	self:seekNodeByName("wechatBtn")
		:setPressedActionEnabled(true)
		:onTouch(function(event)
			if ("ended" == event.name) then
				payFunc(PAYMENT.WECHAT);
				self:close();
			end
		end);
		
	local discount = dataCenter:getDataByKey({"onoff", "wechatDiscount",});
	if (0 ~= discount) then
		self:seekNodeByName("discount")
			:setString(discount);
	end
end

function paymentV:onDelete()
	
end

return paymentV;
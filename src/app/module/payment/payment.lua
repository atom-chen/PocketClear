--=======================================
--				支付接口
--=======================================
local payment = class("payment");

function payment:ctor(paytype)
	self.type = paytype;
	
	if (PAYMENT.COIN == self.type) then --金币
		self.inst = require("app.module.payment.payCoin"):create();
	elseif (PAYMENT.DIAMOND == self.type) then --钻石
		self.inst = require("app.module.payment.payDiamond"):create();
	elseif (PAYMENT.SMS == self.type) then --短信
		self.inst = require("app.module.payment.paySMS"):create();
	end
end

function payment:pay(...)
	self.inst:pay(...);
end

return payment;
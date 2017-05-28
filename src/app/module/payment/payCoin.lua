local payCoin = class("payCoin", require("app.model.model"));

function payCoin:onCreate()
	
end

--消耗, 购买结果回调
function payCoin:pay(consume, call)
	local result = PAYRESULT.SUCCESS; --购买结果

	local ownCoin = self:getDataByKey(golbal.coin());
	if (ownCoin >= consume) then
		self:modifyDataByKey(golbal.coin(), -consume);
	else
		result = PAYRESULT.NOTENOUGH_COIN;
	end
	
	if (call) then
		call(result);
	end
end

return payCoin;
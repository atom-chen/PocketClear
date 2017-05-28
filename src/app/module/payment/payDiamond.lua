local payDiamond = class("payDiamond", require("app.model.model"));

function payDiamond:onCreate()
	
end

--消耗, 购买结果回调，label表示打开商店的位置，1表示其他地方打开，2表示商店的购买道具界面打开的
function payDiamond:pay(id, num, call)
	local consume = configItem[id].diamond*num;
	local result = PAYRESULT.SUCCESS; --购买结果
	
	local ownDiamond = self:getDataByKey(golbal.diamond());
	if (ownDiamond >= consume) then
		self:modifyDataByKey(golbal.diamond(), -consume);
	else
		result = PAYRESULT.NOTENOUGH_DIAMOND;
	end
	
	if (call) then
		call(result);
	end
end

return payDiamond;
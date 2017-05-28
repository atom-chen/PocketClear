local victoryM = class("victoryM", require("app.model.model"));

function victoryM:onCreate(score, cpIndex, starNum)
	self.score = score; --当前关卡得分
	self.cpIndex = cpIndex; --但钱关卡索引
	self.starNum = starNum; --星星数量

	self:addCustomEvent(configMsg.share, function(event)
		local call = event._usedata;
		
		--苹果分享
		golbal.lua2oc("Adapter", "wechatShare", {call=function()
			local id = math.random(20, 30);
			self:setDataByKey("shareFlag", true);
			self:addItem(id, 1);
			call(id, 1);
		end});
	end);
end

function victoryM:onDelete()
	
end

return victoryM;
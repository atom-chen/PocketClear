local signIn = class("singInM", require("app.model.model"));

function signIn:onCreate()
	local signInIndex = self:getDataByKey("singInIndex");
	if (signInIndex >= #configSingIn)
		and (not self:isSign()) then
		self:setDataByKey("singInIndex", 0);
	end

	self:addCustomEvent(configMsg.signIn_sign, function(event)
		local callBack = event._usedata;
		
		local updateDay = nil; --更新的天数
		if (not self:isSign()) then
			updateDay = self:getDataByKey("singInIndex") + 1;
			local signData = configSingIn[updateDay];
			for i=1, #signData do
				self:addItem(signData[i].id, signData[i].num);
			end

			--增加签到天数
			self:setDataByKey("singInIndex", updateDay);
			self:setDataByKey("singInTime", os.time());
		end
		callBack(updateDay);
	end);
end

function signIn:onDelete()
	
end

--是否签到
-- function signIn:isSign()
-- 	local signInTime = self:getDataByKey("singInTime");
-- 	if (0 == signInTime) then
-- 		return false;
-- 	end

--     local spacing = os.time() - signInTime;
--     if (spacing < 0) then
--         spacing = 0;
--     end
    
--     if (spacing >= golbal.signInSpacing) then
--         return false;
--     end
-- 	return true;
-- end

return signIn;
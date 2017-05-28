local mainActionM = class("mainActionM");

function mainActionM:ctor(model)
	self.M = model;

	self.type = self.M.cpData.action.type; --行动type
	self.action = self.M.cpData.action.limit; --行动力
	self.isPause = false; --暂停开关

	--使用道具增加行动力
	self.M:addCustomEvent(configMsg.main_increaseAction, function(event)
		local increase, endCall, updateCall = unpack(event._usedata);
		
		local id = nil;
		id = golbal.scheduler(function(dt)
			self.action = self.action + 1;
			updateCall(self.action);

			increase = increase - 1;
			if (increase <= 0) then
				golbal.removeScheduler(id);
				endCall();
				id = nil;
			end
		end, 1.0/increase, false);
	end);

	--行动力更新
	self.schedulerCount = 0; --时间关卡计数器,满一秒钟清零
	self.M:addCustomEvent(configMsg.main_updateAction, function(event)
		if (self.isPause) then
			return;
		end
		
		--行动力变化值, 视图刷新回调
		local variable, callBack = unpack(event._usedata);

		--更新行动力数据
		repeat
			if (ACTION.TIME == self.type) then
				if (variable < 0) then --每帧时间差
					self.schedulerCount = self.schedulerCount + variable;
					if (self.schedulerCount > -1) then
						break;
					else
						self.schedulerCount = 0;
						variable = -1;
					end
				end
			end

			self:count(variable); --计数
			callBack(self.action); --调用回调,更新界面
		until true
	end);

	--bonustime扣减步数
	self.M:addCustomEvent(configMsg.main_bonustimeAction, function(event)
		local callBack = event._usedata;
		
		--计数
		self:count(-1);

		--调用回调,更新界面
		if (callBack) then
			callBack(self.action);
		end
	end);

	--暂停界面
	self.M:addCustomEvent(configMsg.pause_main, function(event)
		self.isPause = event._usedata;
	end);
end

function mainActionM:count(value)
	self.action = self.action + value;
	if (self.action <= 0) then
		self.action = 0;
	end
end

return mainActionM;
local roleM = class("roleM");

function roleM:ctor(model)
	self.M = model; --mainM

	self.state = nil;
	self.curRound = nil; --当前轮

	if (self.onCreate) then
		self:onCreate();
	end

	self.M:addCustomEvent(configMsg.main_roleState, function(event)
		local state, callBack = unpack(event._usedata);
		self:setState(state);
		callBack(self.state);
	end);
end

function roleM:setState(state)
	local curState = self.stateEnum[state];
	if (nil == curState) then
		return false;
	end
	
	if (self.state == curState) then
		return false;
	end
	
	self.state = curState;
	return true;
end

function roleM:setCurRound(round)
	self.curRound = round;
end

return roleM;
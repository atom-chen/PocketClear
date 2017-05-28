local Spine = sp.SkeletonAnimation;

local tempCreate = Spine.create;
function Spine:create(name)
	self.config = configSpine[name];
	local inst = tempCreate(self, self.config.cFile, self.config.pFile);
	return inst;
end

function Spine:getAnimationName(name)
	return self.config[name][2];
end

function Spine:play(name, endCall)
	self:setAnimation(unpack(self.config[name]));
	return self;
end

function Spine:setStartCall(startCall)
	self.startCall = startCall;

	--注册动作开始回调
	self:registerSpineEventHandler(function(event)
		if (DEBUG == 2) then
			print(string.format("[spine] %d start: %s", event.trackIndex, event.animation));
		end

		if (self.startCall) then
			self.startCall(event.animation);
		end
	end, sp.EventType.ANIMATION_START);
	return self;
end

function Spine:setEndCall(endCall)
	self.endCall = endCall;

	--注册结束开始回调
	self:registerSpineEventHandler(function(event)
		if (DEBUG == 2) then
			print(string.format("[spine] %d end: %s", event.trackIndex, event.animation));
		end
		
		if (self.endCall) then
			self:delayCall(0.001, function()
				self.endCall(event.animation);
			end);
		end
	end, sp.EventType.ANIMATION_END);
	return self;
end

function Spine:setCompleteCall(completeCall)
	self.completeCall = completeCall

	--注册动作完成回调
	self:registerSpineEventHandler(function(event)
		if (DEBUG == 2) then
			print(string.format("[spine] %d complete: %d", event.trackIndex, event.loopCount));
		end

		if (self.completeCall) then
			self.completeCall(event.animation);
		end
	end, sp.EventType.ANIMATION_COMPLETE);
	return self;
end

function Spine:setEventCall(eventCall)
	self.eventCall = eventCall;

	--注册动作事件回调
	self:registerSpineEventHandler(function(event)
		if (DEBUG == 2) then
			print(string.format("[spine] %d event: %s, %d, %f, %s", 
								event.trackIndex, event.eventData.name,
                                event.eventData.intValue,event.eventData.floatValue,
                                event.animation));
		end

		if (self.eventCall) then
			self.eventCall(event.animation);
		end
	end, sp.EventType.ANIMATION_EVENT);
	return self;
end
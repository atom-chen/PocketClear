local ArmatureEx = ccs.Armature;
ArmatureEx.mgrInst = ccs.ArmatureDataManager:getInstance();

ArmatureEx.MovementEventType = {
    start = 0,
    complete = 1,
    loopComplete = 2,
};

ArmatureEx.InnerActionType = {
    LoopAction = 0,
    NoLoopAction = 1,
    SingleFrame = 2,
};

local tempCreate = ArmatureEx.create;
function ArmatureEx:create(name)
	local configure = configArmature[name];
	local armatureData = ArmatureEx.mgrInst:getArmatureData(configure.id);
	if (nil == armatureData) then
		display.getRunningScene():loadArmature(configure.cFile);
	end
	
	local inst = tempCreate(self, configure.id);
	inst.configure = configure;
	return inst;
end

function ArmatureEx:delete()
	self:removeFromParent(true);
	self.mgrInst:removeArmatureFileInfo(self.configure.cFile);
end

--args = {loop, call, removeSelf, }
function ArmatureEx:play(name, endFunc)
	local ini = self.configure[name];
	
	if (ini.post) then
		local tempFunc = endFunc;
		endFunc = function (armature)
			armature:play(ini.post, tempFunc);
		end
	end
	
	self:getAnimation():play(name, ini.duration, ini.loop);
	if (endFunc) then
		self:setMovementEventCallFunc(endFunc);
	end
	
	return self;
end

function ArmatureEx:getCurID()
	return self:getAnimation():getCurrentMovementID();
end

function ArmatureEx:switchTo(name)
	local ini = self.configure[name];
	if (nil == ini.index) then
		return;
	end
	self:getAnimation():playWithIndex(ini.index, ini.duration, ini.loop);
	return self;
end

function ArmatureEx:gotoAndPlay(frameIndex)
	self:getAnimation():gotoAndPlay(frameIndex);
	return self;
end

function ArmatureEx:gotoAndPause(frameIndex)
	self:getAnimation():gotoAndPause(frameIndex);
	return self;
end

function ArmatureEx:setMovementEventCallFunc(eventFunc)
	self:getAnimation():setMovementEventCallFunc(function (armature, movementType, movementID)
		if (movementType == self.MovementEventType.start) then
		elseif (movementType == self.MovementEventType.complete) 
			or (movementType == self.MovementEventType.loopComplete) then
			eventFunc(armature);
		end
	end);
end

function ArmatureEx:setFrameEventCallFunc(frameFunc)
	self:getAnimation():setFrameEventCallFunc(function(bone, frameEventName, originIndex, currentIndex)
		if (frameFunc) then
			frameFunc();
		end
	end);
	return self;
end
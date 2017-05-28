local actionTime = class("actionTime");

function actionTime:ctor(node, timeline, duration, timeSpeed)
	if (nil == node) then
		return;
	end

	if (nil == timeline) then
		return;
	end

	duration = duration or 30;
	timeSpeed = timeSpeed or 0.4167;
	
	self.node = node;
	self.action = ccs.ActionTimeline:create();
    self.action:setDuration(duration);
    self.action:setTimeSpeed(timeSpeed);
    self.node:runAction(self.action);

    self:addTimeline(timeline);
end

function actionTime:play(startIndex, endIndex, currentIndex, loop)
	startIndex = startIndex or self.action:getStartFrame();
	endIndex = endIndex or self.action:getEndFrame();
	currentIndex = currentIndex or startIndex;
	loop = loop or true;
	self.action:gotoFrameAndPlay(startIndex, endIndex, currentIndex, loop);
end

function actionTime:addscale(scaleframes)
	local scaleTimeLine = ccs.Timeline:create();
	for i=1, #scaleframes do
		local frame = scaleframes[i];

		local localFrame = ccs.ScaleFrame:create();
		localFrame:setFrameIndex(frame.index);
	    localFrame:setTween(frame.tween);
	    localFrame:setTweenType(frame.tweenType);
	    localFrame:setScaleX(frame.scale.x);
	    localFrame:setScaleY(frame.scale.y);
	    scaleTimeLine:addFrame(localFrame);
	end

	self.action:addTimeline(scaleTimeLine);
	scaleTimeLine:setNode(self.node);
end

function actionTime:addTimeline(name)
	local frames = configActionTime[name]
	if (nil == frames) then
		return;
	end

	for k, v in pairs(frames) do
		self["add" .. k](self, v);
	end
end

return actionTime;
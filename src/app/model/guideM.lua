local GuideM = class("GuideM", require("app.model.model"));

function GuideM:onCreate(mStep, sStep)
	self.mStep, self.sStep = mStep, sStep;
	if (self.sStep == #configGuide[mStep]) then
		sStep = #configGuide[mStep] + 1;
	end
	self:setDataByKey("guideIndex", {mStep, sStep,});
	
	if (nil~=configGuide[self.mStep][self.sStep].give) then
		for i=1, #configGuide[self.mStep][self.sStep].give do
			local id = configGuide[self.mStep][self.sStep].give[i].id;
			local num = configGuide[self.mStep][self.sStep].give[i].num;
			self:addItem(id, num);
		end
	end
	
	self:addCustomEvent(configMsg.guide_jump, function(event)
		self:setDataByKey("guideIndex", {self.mStep, #configGuide[self.mStep]+1,});
	end);
end

function GuideM:onDelete()

end

return GuideM;
local pauseM = class("pauseM", require("app.model.model"));

function pauseM:onCreate(call)
	self.musicFlag = true;
	self.soundFlag = true;

	self.call = call;

	 self:addCustomEvent(configMsg.pause_voiceFlag, function(event)
	 	self[event._usedata] = (not self[event._usedata]);
	 end);
end

function pauseM:onDelete()
	
end

return pauseM;
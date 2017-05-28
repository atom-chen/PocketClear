local commentM = class("commentM", require("app.model.model"));

function commentM:onCreate()
	self:addCustomEvent(configMsg.comment, function(event)
		self:setDataByKey("commentFlag", true);
		self:addItem(1, 500);
		self:addItem(2, 10);
		event._usedata();
	end);
end

function commentM:onDelete()
	
end

return commentM;
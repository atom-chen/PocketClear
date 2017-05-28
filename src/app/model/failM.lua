local failM = class("failM", require("app.model.model"));

function failM:onCreate(cpIndex)
	self.cpIndex = cpIndex; --但钱关卡索引
end

function failM:onDelete()
	
end

return failM;
local bearM = class("bearM", require("app.model.mainParts.role.roleM"));

function bearM:onCreate()
	self.stateEnum = {
		victory = "GRUNshengli",
		fail = "GRUNshibai",
		combo = "GRUNqingzhu01",
		idel = "GRUNdaiji",
		fiveStep = "",
	};
	self.state = self.stateEnum.idel;
end

function bearM:roundEnd()
	return true;
end

return bearM;
local bearV = class("bearV", require("app.view.mainParts.role.roleV"));

function bearV:onCreate()
	self.role = ccs.Armature:create("backkom")
							:addTo(self.roleCon)
							:centerTo(self.roleCon, cc.p(0, 34));
end

function bearV:update(state)
	self.role:play(state, function(armature)
		local stateEnum = self:get("stateEnum");
		if (stateEnum.combo == state) then
			self:setState("idel");
		end
	end);
end

function bearV:roundEnd(comboCount)
	if (comboCount >= 2) then
		self:setState("combo");
	end
end

return bearV;
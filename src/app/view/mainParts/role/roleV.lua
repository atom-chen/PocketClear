local roleV = class("roleV");

function roleV:ctor(model, root)
	self.M = model; --
	self.root = root; --主场景结点
	self.roleCon = self.root:seekNodeByName("roleCon"); --角色结点

	self.role = nil; --骨骼动画

	if (self.onCreate) then
		self:onCreate();
	end

	self.role:setName("role");
	self:setState(self:get("state"));
end

function roleV:get(key)
	return self.M:getDataByKey("role")[key];
end

function roleV:setState(state)
	local msgArr = {};
	table.insert(msgArr, state);
	table.insert(msgArr, function(state)
		self:update(state);
	end);
	self.root:sendCustomEvent(configMsg.main_roleState, msgArr);
end

function roleV:roundEnd()
end

return roleV;
local mainTaskM = class("mainTaskM", require("app.model.model"));

function mainTaskM:ctor(model)
	self.M = model; --mainM

	self.taskIni = clone(self.M.cpData.task);
	self.type = self.taskIni.type;
	self.limitIni = nil;
	
	self.complete = false; --任务是否完成

	local initMethod = self["init" .. self.type];
	if (nil ~= initMethod) then
		initMethod(self);
	end
end

--任务计数
function mainTaskM:count(element)
	local method = self["count" .. self.type];
	if (nil ~= method) then
		return method(self, element);
	end
end

--获得数据
function mainTaskM:get(...)
	local getMethod = self["get" .. self.type];
	if (nil ~= getMethod) then
		return getMethod(self, ...);
	end
end

--设置人物状态
function mainTaskM:setRoleState(point) --args: 触发点
	local setStateMethod = self["setRoleState" .. self.type];
	if (nil ~= setStateMethod) then
		setStateMethod(self, point);
	end
end

--======================================收集任务
function mainTaskM:init1()
	self.limitIni = self.taskIni.limit;

	self.limit = {};
	for i=1, #self.limitIni do
		self.limit[self.limitIni[i].type] = self.limitIni[i].num;
	end
end

function mainTaskM:count1(element)
	local remainNum = self.limit[element:get("key")];
	if (nil == remainNum) then
		return false;
	end
	
	if (remainNum <= 0) then
		return false;
	end
	
	self.limit[element:get("key")] = remainNum - 1;
	if (self.limit[element:get("key")] <= 0) then
		self.complete = true;
		for k, v in pairs(self.limit) do
			if (v > 0) then
				self.complete = false;
				break;
			end
		end
	end
end

function mainTaskM:get1(key)
	return self.limit[key];
end

--======================================分数任务
function mainTaskM:init2()
	self.limitIni = self.taskIni.limit;
	self.limit = self.limitIni;
end

function mainTaskM:count2(element)
	if (self.M.score >= self.limit) then
		self.complete = true;
	end
end

--======================================BOSS任务
function mainTaskM:init3(limit)
	self.limitIni = self.taskIni.hitElement;
	self.limit = self.taskIni.hp;

	self.hitElement = {};
	for i=1, #self.taskIni.hitElement do
		self.hitElement[self.taskIni.hitElement[i].type] = true;
	end 
end

function mainTaskM:count3(element)
	if (self.limit <= 0) then
		return;
	end
	
	if (not self.hitElement[element:get("key")]) then
		return;
	end
	
	self.limit = self.limit - 1;
	if (self.limit <= 0) then
		self.complete = true;
	end

	self.M.role:hit(); --boss受击
end

return mainTaskM;
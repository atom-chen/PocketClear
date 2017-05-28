local ElementMgr = require("app.model.mainParts.elementMgr.ElementMgr");
local CollectMgr = class("CollectMgr", ElementMgr);

function CollectMgr:onCreate()
	self.remain = {};
	for i=1, #self.mainM.cpData.task.limit do
		local key = self.mainM.cpData.task.limit[i].type;
		local arr = string.split(key, "@");
		if (ELEMENT.COLLECT == arr[1]) then
			self.remain[key] = self.mainM.cpData.task.limit[i].action;
		end
	end
end

function CollectMgr:loop()
	local delList = {};
	for i=1, #self.elements do
		local element = self.elements[i];
		if (element.roundDel) then
			local grid = self.mainM:get(element:get("index"), ELEMENT_LAYER.GRID);
			if (element:roundDel(grid)) then
				local key = element:get("key");
				if (nil~=self.remain[key])
					and (nil~=next(self.remain[key])) then
					table.remove(self.remain[key])
					table.insert(self.mainM.presetDropList, 1, key); --插入预设表
				end
				table.insert(delList, element); --删除表
			end
		end
	end

	for k, v in pairs(self.remain) do
		if (nil ~= v) and (nil ~= next(v)) then
			if ((self.mainM.action.action-1)==v[#v]) then
				table.remove(v)
				table.insert(self.mainM.presetDropList, 1, k); --插入预设表
			end
		end
	end
	
	return self.mainM:delAround(delList);
end

return CollectMgr;
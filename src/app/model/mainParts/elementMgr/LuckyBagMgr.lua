local ElementMgr = require("app.model.mainParts.elementMgr.ElementMgr");
local LuckyBagMgr = class("LuckyBagMgr", ElementMgr);

function LuckyBagMgr:onCreate()
end

function LuckyBagMgr:loop()
	local delList = {};
	for i=1, #self.elements do
		local element = self.elements[i];
		if (element.roundDel) then
			local grid = self.mainM:get(element:get("index"), ELEMENT_LAYER.GRID);
			if (element:roundDel(grid)) then
				table.insert(delList, element); --删除表
			end
		end
	end
	return self.mainM:delAround(delList);
end

return LuckyBagMgr;
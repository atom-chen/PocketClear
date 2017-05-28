local ElementMgr = require("app.model.mainParts.elementMgr.ElementMgr");
local ColorMachineMgr = class("ColorMachineMgr", ElementMgr);

function ColorMachineMgr:onCreate()

end

-- function ColorMachineMgr:loop()
-- 	local delList = {};
-- 	for i=1, #self.elements do
-- 		local element = self.elements[i];
-- 		if (element.roundDel) then
-- 			local grid = self.mainM:get(element:get("index"), ELEMENT_LAYER.GRID);
-- 			if (element:roundDel(grid)) then
-- 				element.createData = {element.type, {element.eType, element.num,}};
-- 				table.insert(delList, element); --删除表
-- 			end
-- 		end
-- 	end
	
-- 	return self.mainM:delAround(delList);
-- end

function ColorMachineMgr:loopEnd()
	local updateList = {};
	for i=1, #self.elements do
		local colorMachine = self.elements[i];
		if (colorMachine:reset()) then
			table.insert(updateList, {ELEMENT_OP.UPDATE, colorMachine,});
		end
	end
	return updateList;
end

return ColorMachineMgr;
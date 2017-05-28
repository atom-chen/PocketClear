local ElementMgr = require("app.model.mainParts.elementMgr.ElementMgr");
local PitchMgr = class("PitchMgr", ElementMgr);

function PitchMgr:onCreate()
	self.isDelFlag = false;
end

function PitchMgr:postRemove(element)
	self.isDelFlag = true;
end

function PitchMgr:loopEnd()
	if (self.isDelFlag) then
		self.isDelFlag = false;
		return;
	end
	
	--取一个沥青复制
	local pitch, dstElement, name = nil, nil, nil;
	local pool = clone(self.elements);
	while (true) do
		pitch = table.remove(pool, math.random(1, #pool));
		if (nil == pitch) then
			break;
		end

		local offsets = {{cc.p(0, 1), "xiadaoshang",}, {cc.p(0, -1), "shangdaoxia",}, {cc.p(-1, 0), "youdaozuo",}, {cc.p(1, 0), "zuodaoyou",},};
		while (true) do
			local group = table.remove(offsets, math.random(1, #offsets));
			if (nil == group) then
				break;
			end

			local offset, dir = unpack(group);
			local offsetCoord = cc.pAdd(pitch:get("coord"), offset);
			if (self.mainM:checkCoord(offsetCoord)) then
				local occupy = self.mainM:get(offsetCoord, ELEMENT_LAYER.OCCUPY);
				if (nil ~= occupy) and (ELEMENT.CUBE == occupy:get("type")) then
					local topElement = self.mainM:getTop(offsetCoord);
					if (nil == topElement)
						or (ELEMENT_MOTION.BLOCK~=topElement:get("motion")) then
						dstElement = occupy;
						name = dir;
						break;
					end
				end
			end
		end
		
		if (nil ~= dstElement) then
			break;
		end
	end

	if (nil==pitch)or(nil==dstElement) then
		return;
	end
	
	dstElement.createData = {"6", {name, pitch:get("coord")}};
	local delList = self.mainM:delAround({dstElement,});

	--沥青动画完成后才解锁棋盘格
	self.mainM:modifyLock(1);
	return delList;
end

return PitchMgr;
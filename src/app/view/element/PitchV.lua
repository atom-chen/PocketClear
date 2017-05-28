local ElemetnV = require("app.view.element.ElementV");
local PitchV = class("PitchV", ElemetnV);

function PitchV:onCreate()
	
end

function PitchV:onDelete()
	
end

function PitchV:updateShape()
	return self;
end

function PitchV:birthEffect(extra)
	if (nil == extra) then
		return;
	end
	
	self:hide();

	local name, coord = unpack(extra);
	local root = self.root;

	root:getViewInPool("pitchBirth", function()
		return ccs.Armature:create("pitch")
						   :addTo(root.con);
	end)
		:move(root:getPosByGrid(coord))
		:play(name, function(armature)
			self:show();
			root:returnViewToPool("pitchBirth", armature);
			
			--重置结束,解锁棋盘格和道具栏,该元素解锁
			root:sendUnlockMsg();
		end);
end

function PitchV:destroyEffect()
	local root = self.root;
	root:getViewInPool("pitchExplode", function()
		return ccs.Armature:create("pitch")
						   :addTo(root.con, 1000);
	end)
		:move(cc.p(root:getPosByGrid(self.M:get("index"))))
		:play("baopo", function(armature)
			root:returnViewToPool("pitchExplode", armature);
		end);
end

return PitchV;
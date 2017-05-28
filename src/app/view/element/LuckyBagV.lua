local ElemetnV = require("app.view.element.ElementV");
local LuckyBagV = class("LuckyBagV", ElemetnV);

function LuckyBagV:onCreate()
	
end

function LuckyBagV:onDelete()
	
end

function LuckyBagV:updateShape()
	return self;
end

function LuckyBagV:destroyEffect()
	local root = self.root;
	root:getViewInPool("luckyBagExplode", function()
		return ccs.Armature:create("luckyBag")
						   :addTo(root.con, 1000);
	end)
		:move(cc.p(root:getPosByGrid(self.M:get("index"))))
		:play("fudaibaozha", function(armature)
			root:returnViewToPool("luckyBagExplode", armature);
		end);
end

return LuckyBagV;
local ElemetnV = require("app.view.element.ElementV");
local GoldPigV = class("GoldPigV", ElemetnV);

function GoldPigV:onCreate()
	
end

function GoldPigV:onDelete()
	
end

function GoldPigV:destroyEffect()
	--音效
	-- audio.playSound(unpack(configAudio[self.explodeAudio[subType]]));
	
	local root = self.root;
	cc.ParticleSystemQuad:create("goldPigBreak")
                         :addTo(root.con, 1000)
                         :move(cc.p(root:getPosByGrid(self.M:get("index"))));
end

function GoldPigV:updateShape()
	return self;
end

return GoldPigV;
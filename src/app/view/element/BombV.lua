local ElemetnV = require("app.view.element.ElementV");

local BombV = class("BombV", ElemetnV);

BombV.destroyEffectEnum = {
	"runhengxiang",
	"runshuxiang",
	"runshizi",
};

BombV.comboAudio = {
	"sound_4", "sound_5", "sound_6", "sound_7",
	"sound_8", "sound_9", "sound_10", "sound_11",
};

BombV.explodeAudio = {
	"sound_17", "sound_17", "sound_18",
};

function BombV:onCreate()
	
end

function BombV:onDelete()

end

function BombV:updateShape()
	local ini = configElement[self.M:get("type")];
	ini.view[self.M:get("subType")](self);
	return self;
end

function BombV:birthEffect(extra)
	if (nil == extra) then
		return;
	end
	
	local shape, origin, comboCount = unpack(extra);
	local rotate, name = unpack(shape);
	local root = self.root;
	
	local pos = cc.p(root:getPosByGrid(origin));
	if (BOMB.MISSILE_H==self.M:get("subType")) then
		pos = cc.pAdd(pos, cc.p(120, 0));
	elseif (BOMB.MISSILE_V==self.M:get("subType")) then
		pos = cc.pAdd(pos, cc.p(0, 120));
	end
	
	root:getViewInPool("mainEffect", function()
		return ccs.Armature:create("cbEffect")
					:addTo(root.con, 1010);
	end)
		:rotate(rotate)
		:move(pos.x, pos.y)
		:play(name, function(armature)
			root:returnViewToPool("mainEffect", armature);
		end);
	
	--炸弹合成音效
	if (BOMB.BOMB == self.M:get("subType")) then
		audio.playSound(unpack(configAudio.sound_35));
	else
		audio.playSound(unpack(configAudio.sound_36));
	end

	--生成炸弹音效
	-- if (comboCount > #self.comboAudio) then
	-- 	comboCount = #self.comboAudio;
	-- end
	-- audio.playSound(unpack(configAudio[self.comboAudio[comboCount]]));
end

function BombV:destroyEffect()
	local subType = tonumber(self.M:get("subType"));
	
	--音效
	audio.playSound(unpack(configAudio[self.explodeAudio[subType]]));

	--特效
	local root = self.root;
	self.root:getViewInPool("mainEffect", function()
		return ccs.Armature:create("cbEffect")
					:addTo(root.con, 1010);
	end)
		:move(root:getPosByGrid(self.M:get("index")))
		:play(self.destroyEffectEnum[subType], function(armature)
			root:returnViewToPool("mainEffect", armature);
		end);
end

return BombV;
local Particle = cc.ParticleSystemQuad;

local tempCreate = Particle.create;
function Particle:create(id)
	local data = configParticle[id];
	local inst = tempCreate(self, data.cFile)
							:setPositionType(1);
							
	if (nil ~= data.life) then
		inst:delayCall(data.life, function()
			inst:removeSelf();
		end);
	end
	return inst;
end
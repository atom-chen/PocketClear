local ElemetnV = require("app.view.element.ElementV");

local CubeV = class("CubeV", ElemetnV);

function CubeV:onCreate()
	
end

function CubeV:onDelete()
	
end

function CubeV:destroyEffect()
	local root = self.root;
	local particleName = "cube_del_" .. self.M:get("color");
	cc.ParticleSystemQuad:create(particleName)
                         :addTo(root.con, 1000)
                         :setScale(1.3)
                         :move(cc.p(root:getPosByGrid(self.M:get("index"))));
end

function CubeV:updateShape()
	local ini = configElement[self.M:get("type")];
	ini.view[self.M:get("viewKey")](self);
	return self;
end

return CubeV;
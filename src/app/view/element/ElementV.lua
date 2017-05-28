local ElementV = class("ElementV", function (createFunc)
	return createFunc();
end);

function ElementV:ctor(view, name)
	self.name = name;

	if (self.onCreate) then
		self:onCreate();
	end
end

function ElementV:dector()
	self:reset();

	if (self.onDelete) then
		self:onDelete();
	end
end

function ElementV:reset()
	if (self.destroyEffect) 
		and (nil ~= self.root) then
		self:destroyEffect();
	end

	if (nil ~= self.root) then
		self.root = nil;
	end
	
	-- if (nil ~= self.M) then
	-- 	self.M:dector();
	-- 	self.M = nil;
	-- end
	
	self:hide()
		:setScale(1.0);
end

function ElementV:setStartPos(ini)
	self.viewRect, self.startPos = unpack(ini);
	return self;
end

function ElementV:setModel(model, root, extra)
	self.M = model;
	self.root = root;
	
	self:updateCoord()
		:updateLayer()
		:updateShape()
		:show();
		
	--设置生成特效
	if (self.birthEffect) then
		self:birthEffect(extra);
	end
	return self;
end

function ElementV:getModel()
	return self.M;
end

function ElementV:updateCoord()
	--设置二位坐标
	local pixW, pixH = golbal.chessBoard.pixW, golbal.chessBoard.pixH;
	local coord = cc.pSub(self.M:get("coord"), cc.p(self.viewRect.x, self.viewRect.y));
	local anchor = self:getAnchorPoint();
	local pos = cc.p(self.startPos.x+coord.x*pixW+anchor.x*pixW, 
					self.startPos.y+coord.y*pixH+anchor.y*pixH);
	self:move(pos);
	return self;
end

function ElementV:updateLayer()
	local zOrder = self.M:get("viewLayer")+self.M:get("coord").y;
	self:setLocalZOrder(zOrder);
	return self;
end

return ElementV;
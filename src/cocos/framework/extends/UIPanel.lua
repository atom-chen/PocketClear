local UIPanel = class("UIPanel", cc.Node);

function UIPanel:ctor(name)
	self.config = configPanel[name] or {};
	self:setName(name);
	self:enableNodeEvents();
end

function UIPanel:onEnter()
    print(string.format("[panel]%s:onEnter", self:getName()));
end

function UIPanel:onEnterTransitionFinish()
    print(string.format("[panel]%s:onEnterTransitionFinish", self:getName()));
end

function UIPanel:onExit()
    print(string.format("[panel]%s:onExit", self:getName()));
end

function UIPanel:onExitTransitionStart()
    print(string.format("[panel]%s:onExitTransitionStart", self:getName()));
end

function UIPanel:setModel(model)
	if (nil == model) then
		return self;
	end
	self.M = model;
	return self;
end

function UIPanel:setConfig(config)
	self.config = config;
	return self;
end

function UIPanel:initialize(...)
	if (nil~=self.config.pFile) and (nil~=self.config.iFile) then
		display.loadSpriteFrames(self.config.pFile, self.config.iFile);
	end

	if (self.config.cFile) then
		self.node = cc.CSLoader:createNode(self.config.cFile)
								:addTo(self)
								:centerTo(self);
		self.root = self:seekNodeByName("root");
	end
	
	if (self.onCreate) then
		self:onCreate(...);
	end

	--进入效果
	local enter = self.config.enter;
	if (nil ~= enter) then
		if (nil ~= enter.action) then --进入动画
			local type, dir = unpack(enter.action);
			if (self[type]) then
				self[type](self, dir);
			end
		end
		
		if (nil ~= enter.sound) then --进入音效
			audio.playSound(unpack(enter.sound[1]));
		end
	end

	self.mask = ccui.Layout:create()
						   :addTo(self)
						   :setContentSize(cc.size(CC_DESIGN_RESOLUTION.width, CC_DESIGN_RESOLUTION.height))
						   :setLocalZOrder(-1)
						   :setTouchEnabled(true);
						   
	if (not self.config.shieldMask) then
		self.mask:setBackGroundColorType(1)
			     :setBackGroundColor(cc.c3b(0, 0, 0))
			     :setBackGroundColorOpacity(self.config.pellucidity or 180)
			     :setOpacity(0)
			     :fadeIn(0.3);
	end

	return self;
end

function UIPanel:onCleanup()
    print(string.format("[panel]%s:onCleanup", self:getName()));

    --释放监听器
    if (self.customEventListeners)
        and (nil ~= next(self.customEventListeners)) then
        for i=1, #self.customEventListeners do
            self:getEventDispatcher()
                :removeEventListener(self.customEventListeners[i]);
        end
    end
    
    --释放定时器
    self:removeAllScheduler();
    
    --释放面板的model
    if (self.M) then
    	self.M:delete();
    end

    --释放面板的view
    if (self.onDelete) then
        self:onDelete();
    end

    self:releaseResource();
end

function UIPanel:releaseResource()
	display.removeSpriteFrames(self.config.pFile, self.config.iFile);

	if (DEBUG > 1) then
		print("================================================================");
        print(cc.Director:getInstance():getTextureCache():getCachedTextureInfo());
        print("================================================================");
    end
end

function UIPanel:close(endCall)
	local function panelDestroy()
		if (nil ~= self.closeCallback) then
			self.closeCallback();
		end
		
		if (endCall) then
			endCall();
		end
		
		self:removeSelf();
	end

	local isExistExitAction = false;
	local exit = self.config.exit;
	if (nil ~= exit) then
		--退出动画
		if (nil ~= exit.action) then
			local type, dir = unpack(exit.action);
			if (nil ~= self[type]) then
				isExistExitAction = true;
				self[type](self, dir, function()
					panelDestroy();
				end);
			end
			self.mask:fadeOut(0.2);
		end

		--退出音效
		if (nil ~= exit.sound) then
			audio.playSound(unpack(exit.sound[1]));
		end
	end

	--不存在动画退出
	if (not isExistExitAction) then
		panelDestroy();
	end
end

function UIPanel:registerCloseCallback(call)
	self.closeCallback = call;
end

--========================================面板进出动画
function UIPanel:moveEaseElasticOutEnter(dirEnum)
	if (nil == self.root) then
		return;
	end
	
	local normalDir = DIRVEC[dirEnum];

	local rootS = self.root:getContentSize();
	local rootA = self.root:getAnchorPoint();
	local dstPos = cc.p(CC_DESIGN_RESOLUTION.width/2.0 + (rootA.x-0.5)*rootS.width, 
						display.size.height/2.0 + (rootA.y-0.5)*rootS.height);
	local srcPos = cc.p(CC_DESIGN_RESOLUTION.width/2.0+normalDir.x*(CC_DESIGN_RESOLUTION.width/2.0+rootA.x*rootS.width) + (rootA.x-0.5)*rootS.width, 
						display.size.height/2.0+normalDir.y*(display.size.height/2.0+rootA.y*rootS.height) + (rootA.y-0.5)*rootS.height);

	self.root:move(srcPos)
		:moveByEaseElasticOut(1.0, cc.pSub(dstPos, srcPos), 1, function()
			if (self.transitionEnterFinish) then
				self:transitionEnterFinish();
			end
		end);
end

function UIPanel:moveExit(dirEnum, call)
	if (nil == self.root) then
		return;
	end
	
	local normalDir = DIRVEC[dirEnum];

	local factorX, factorY = 0, 0;
	if (normalDir.x > 0.000001) then
		factorX = 1.2;
	elseif (normalDir.x < -0.000001) then
		factorX = -1.2;
	end
	
	local rootS = self.root:getContentSize();
	local rootA = self.root:getAnchorPoint();
	local dstPos = cc.p(CC_DESIGN_RESOLUTION.width/2.0+factorX*(display.size.width/2.0+rootA.x*rootS.width) + (rootA.x-0.5)*rootS.width, 
						display.size.height/2.0+normalDir.y*(display.size.height/2.0+rootA.y*rootS.height) + (rootA.y-0.5)*rootS.height);
	local srcPos = cc.p(self.root:getPosition());

	self.root:moveBy(0.2, cc.pSub(dstPos, srcPos), function()
			if (call) then
				call();
			end
		end);
end

return UIPanel;
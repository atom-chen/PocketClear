local UIPanel = require("cocos.framework.extends.UIPanel");
local ContextGuide = require("app.context.contextGuide");

local GuideV = class("GuideV", UIPanel);

function GuideV:onCreate()
	self.size = cc.size(CC_DESIGN_RESOLUTION.width, CC_DESIGN_RESOLUTION.height);
	self.offsetPos = cc.p(display.getRunningScene():getLayer("panelLayer"):getPosition());

	self:setContentSize(self.size);

	local mStep = self.M:getDataByKey("mStep");
	local sStep = self.M:getDataByKey("sStep");
	self.ini = configGuide[mStep][sStep];
	
	--黑色遮罩
	local mask = ccui.Layout:create()
					:addTo(self)
					:setContentSize(self.size)
					:setLocalZOrder(-1)
					:setTouchEnabled(true);
					
	if (nil ~= self.ini.delay) then
		self:delayCall(self.ini.delay, function()
			self:close();
		end);
		return;
	else
		mask:setBackGroundColorType(1)
			:setBackGroundColor(cc.c3b(0, 0, 0))
			:setBackGroundColorOpacity(180)
			:setOpacity(0)
			:fadeIn(0.3);
	end

	self.controls = {}; --移动父容器的控件表
	--设置说明性图片
	if (nil ~= self.ini.des) then
		self.desBG = ccui.ImageView:create()
						:loadTexture("image/guide/xinshou_dikuang.png")
						:addTo(self)
						:centerTo(self, self.ini.des.pos);
						
		ccui.ImageView:create()
			:loadTexture(self.ini.des.path)
			:addTo(self.desBG)
			:centerTo(self.desBG);
			
		self.desBG:setScale(self.ini.des.scale or 1.0);
	end

	--设置高光元素
	if (nil~=self.ini.hlArea)and(nil~=self.ini.root) then
		for i=1, #self.ini.hlArea do
			local controlName = self.ini.hlArea[i].name;
			
			--设置坐标,响应命令
			local control, ghostCall, pos, s, a = nil, nil, nil; --幽灵的命令,幽灵的坐标参照控件
			local s, e = string.find(controlName, "Cube");
			if (nil ~= s) then
				local index = tonumber(string.sub(controlName, e+1));
				control = display.getRunningScene()
								:seekNodeByName(self.ini.root)
								:get(index, ELEMENT_VIEW_LAYER.OCCUPY);
				
				local grid = display.getRunningScene()
									:seekNodeByName(self.ini.root)
									:get(index, ELEMENT_VIEW_LAYER.GRID);

				s, a = grid:getContentSize(), grid:getAnchorPoint();
				pos = self:convertToNodeSpaceAR(grid:convertToWorldSpaceAR(cc.p(0, 0)));
				
				control = require("app.tool.ghost")
								:getOne(control)
								:addTo(self)
								:move(cc.pSub(pos, self.offsetPos));

				ghostCall = grid.callback;
			else
				control = display.getRunningScene()
									:seekNodeByName(self.ini.root)
									:seekNodeByName(controlName);
				table.insert(self.controls, {control=control, pos=cc.p(control:getPosition()), parent=control:getParent(),});

				s, a = control:getContentSize(), control:getAnchorPoint();
				pos = self:convertToNodeSpaceAR(control:convertToWorldSpaceAR(cc.p(0, 0)));
				ghostCall = control.callback;
				
				control:retain();
				control:removeSelf()
					   :addTo(self)
					   :move(cc.pSub(pos, self.offsetPos));
			end
			
			local touch = ccui.Layout:create()
							  :setAnchorPoint(a)
							  :setName("mask" .. controlName)
							  :addTo(self)
							  :setContentSize(s)
							  :move(cc.pSub(pos, self.offsetPos))
							  -- :setBackGroundColorType(1)
							  -- :setBackGroundColor(cc.c3b(255, 0, 0))
							  -- :setBackGroundColorOpacity(125)
							  :setTouchEnabled(false)
							  :onTouch(function(event)
									if ("ended" == event.name) then
										event.target = control;
										ghostCall(event);
										self:close();
									end
								end);
		end
	end

	--设置下一步操作
	self.guideHand = nil;
	if (nil == self.ini.clickArea) then
		local sureBtn = ccui.Button:create()
							:loadTextures("texture/common/btn_blue.png", "", "", 1)
							:addTo(self.desBG)
							:move(self.desBG:getContentSize().width*0.7, -80)
							:onTouch(function(event)
								if ("ended" == event.name) then
									self:close();
								end
							end);
		ccui.ImageView:create()
			:loadTexture("texture/common/font_queding.png", 1)
			:addTo(sureBtn)
			:centerTo(sureBtn);
	else
		for i=1, #self.ini.clickArea do
			local name = self.ini.clickArea[i].name;
			local mask = self:seekNodeByName("mask" .. name)
							:setTouchEnabled(true);
							
			if (nil == self.guideHand) then
				local pos = self.ini.clickArea[i].offsetPos or cc.p(60, -30);
				self.guideHand = ccs.Armature:create("guideHand")
									:addTo(self)
									:move(cc.pAdd(cc.p(mask:getPosition()), pos))
									:play("shou");
			end
		end
	end

	--设置跳过按钮
	if (self.ini.jumpBtn)and(not self.ini.jumpBtn.shield) then
		local jumpBtn = ccui.Button:create()
						:loadTextures("texture/common/btn_red.png", "", "", 1)
						:setAnchorPoint(cc.p(0, 0))
						:addTo(self)
						:onTouch(function(event)
							if ("ended" == event.name) then
								self:sendCustomEvent(configMsg.guide_jump);
								self:close();
							end
						end);

		if (nil ~= self.ini.jumpBtn) then
			jumpBtn:setAnchorPoint(cc.p(1.0, 0))
					:move(self.size.width, 0)
		end
		
		ccui.ImageView:create()
			:loadTexture("image/guide/font_tiaoguo.png")
			:addTo(jumpBtn)
			:centerTo(jumpBtn);
	end
end

function GuideV:onDelete()
	if (nil ~= self.controls) then
		for i=1, #self.controls do
			local v = self.controls[i];
			v.control:retain();
			v.control:removeSelf()
					 :addTo(v.parent)
					 :move(v.pos);
		end
	end

	local mStep = self.M:getDataByKey("mStep");
	local sStep = self.M:getDataByKey("sStep");
	ContextGuide:create(mStep, sStep+1);
end

return GuideV;
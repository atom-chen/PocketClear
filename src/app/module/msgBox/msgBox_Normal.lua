local panel = require("cocos.framework.extends.UIPanel");

local msgBox_Normal = class("msgBox_Normal", panel);

function msgBox_Normal:onCreate(sureCall, cancelCall, ...)
	--根节点
	self:setContentSize(display.size);
	self.root = ccui.Layout:create()
						   :addTo(self);
						   
	--背景
	local bg = ccui.ImageView:create()
				  			 :addTo(self.root);
	if (nil ~= self.config.bg) then
		bg:loadTexture(self.config.bg);
	else
		bg:loadTexture("msgBox/mianban002.png")
		  :setScale(1.5);
	end
	
	local bgSize = bg:getRealSize();
	self.root:setContentSize(bgSize)
			 :centerTo(self);
	bg:centerTo(self.root);
	
	--取消按钮
	if (not self.config.shieldCloseBtn) then
		self.closeBtn = ccui.Button:create()
						   :loadTextures("texture/common/closeBtn.png", nil, nil, 1)
						   :addTo(self.root)
						   :move(bgSize.width-20, bgSize.height-20)
						   :onTouch(function(event)
						   		if (event.name == "ended") then
						   			if (cancelCall) then
						   				cancelCall(self);
						   			end
						   			self:close();
						   		end
						   end);
	end
							   
	--确定按钮
	self.sureBtn = ccui.Button:create()
							  :loadTextures("texture/common/btn_red002.png", nil, nil, 1)
							  :addTo(self.root)
							  :centerTo(self.root, cc.p(0, -78))
							  :onTouch(function(event)
							  		if (event.name == "ended") then
							  			if (sureCall) then
							  				sureCall(self);
							  			end
							  			self:close();
							  		end
							  end);

	if (nil ~= self.config.sureBtnOffset) then
		self.sureBtn:moveDiff(self.config.sureBtnOffset);
	end

	--确定按钮字体
	display.newSprite("#texture/common/font_queding.png")
		   :addTo(self.sureBtn)
		   :centerTo(self.sureBtn);

	--提示语
	self.content = ccui.ImageView:create(self.config.content)
								 :addTo(self.root)
								 :centerTo(self.root, cc.p(0, 40));

	if (nil ~= self.config.contentOffset) then
		self.content:moveDiff(self.config.contentOffset);
	end

	--针对特殊弹出框初始化
	if (self.specialInit) then
		self:specialInit(...);
	end
end

return msgBox_Normal;
local freeCoinV = class("freeCoinV", require("cocos.framework.extends.UIPanel"));

function freeCoinV:onCreate()
	self:setContentSize(cc.size(CC_DESIGN_RESOLUTION.width, CC_DESIGN_RESOLUTION.height));

    self.root = ccui.ImageView:create()
			    	:loadTexture("image/gift_jinbidafangsong.png")
			    	:addTo(self)
			    	:centerTo(self);

    -- 关闭按钮
    ccui.Button:create()
	    :loadTextures("texture/common/closeBtn.png", "", "", 1)
	    :addTo(self.root)
	    :centerTo(self.root, cc.p(240, 170))
	    :onTouch(function(event)
	    	if ("ended" == event.name) then
	    		self:close();
	    	end
	    end);

	--领取按钮
	self.getBtn = ccui.Button:create()
					  :loadTextures("texture/common/btn_red.png", "", "", 1)
					  :addTo(self.root)
					  :centerTo(self.root, cc.p(0, -340))
					  :onTouch(function(event)
					  	if ("ended" == event.name) then
					  		self:sendCustomEvent(configMsg.freeCoin_get, function()
					  			self:close();
					  		end);
					  	end
					  end);

	--领取按钮字体
	ccui.ImageView:create()
			:loadTexture("texture/common/font_lingqu.png", 1)
			:addTo(self.getBtn)
			:centerTo(self.getBtn, cc.p(0,4));

	--赠送金币字体
	ccui.TextAtlas:create(configNumber._13)
		:setString(":" .. self.M:getDataByKey("freeCoin"))
		:setAnchorPoint(cc.p(0, 0))
		:setScale(2.0)
		:addTo(self.root)
		:centerTo(self.root, cc.p(80, -80));
end

function freeCoinV:onDelete()
    
end

return freeCoinV;
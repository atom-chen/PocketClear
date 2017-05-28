local fiveStepV = class("fiveStepV", require("cocos.framework.extends.UIPanel"));

function fiveStepV:onCreate()
	local closeCall = self.M.closeCall;
	local buyCall = self.M.buyCall;

	--生成礼包关闭按钮
	ccui.Button:create()
	    :loadTextures("texture/common/closeBtn.png", "", "", 1)
	    :addTo(self.root)
	    :move(530, 470)
	    :setPressedActionEnabled(true)
	    :onTouch(function(event)
	    	if ("ended" == event.name) then
	    		if (nil ~= closeCall) then
	    			closeCall();
	    		end
	    		self:close();
	    	end
	    end);

	--钻石购买按钮
	local diamondBtn = ccui.Button:create()
	    :loadTextures("texture/common/btn_blue.png", "", "", 1)
	    :addTo(self.root)
	    :move(160, 100)
	    :setPressedActionEnabled(true)
	    :onTouch(function(event)
	    	if ("ended" == event.name) then
	    		self:sendCustomEvent(configMsg.fiveStep_diamond, function(result)
	    			if (PAYRESULT.SUCCESS == result) then
		        		if (nil ~= buyCall) then
		        			buyCall();
		        		end
		        		self:close();
					end
	    		end);
	    	end
	    end);
	diamondBtn:setContentSize(cc.size(220, 93));
	diamondBtn:setScale9Enabled(true);
	diamondBtn:setCapInsetsNormalRenderer(cc.rect(30, 14, 209, 65));

	local font_goon = display.newSprite("#texture/fiveStep/font_goon.png")
						   :setScale(0.8)
						   :addTo(diamondBtn);

	--广告购买按钮
	local adBtn = ccui.Button:create()
	    :loadTextures("texture/common/btn_red.png", "", "", 1)
	    :addTo(self.root)
	    :move(400, 100)
	    :setPressedActionEnabled(true)
	    :onTouch(function(event)
	    	if ("ended" == event.name) then
	    		local sendMsg = function()
	    			self:sendCustomEvent(configMsg.fiveStep_ad, function()
		    			if (nil ~= buyCall) then
		    				buyCall();
		    			end
		    			self:close();
		    		end);
	    		end
	    		
	    		local fiveStepVideoCueCount = self.M:getDataByKey("fiveStepVideoCueCount");
	    		if (fiveStepVideoCueCount < 3) then
	    			self.M:setDataByKey("fiveStepVideoCueCount", fiveStepVideoCueCount+1);
	    			require("app.module.msgBox.msgBox")
	                    :create(configPanel.msgBox_FiveStep, 
	                    		function() --sure call
									sendMsg();
	                    		end);
	    		else
	    			sendMsg();
	    		end
	    	end
	    end);
	adBtn:setContentSize(cc.size(240, 93));
	adBtn:setScale9Enabled(true);
	adBtn:setCapInsetsNormalRenderer(cc.rect(30, 14, 209, 65));
	display.newSprite("#texture/fiveStep/font_freeResurgence.png")
		   :addTo(adBtn)
		   :centerTo(adBtn, cc.p(0, 6));
	display.newSprite("#texture/fiveStep/font_freeResurgenceOne.png")
			:addTo(adBtn)
			:centerTo(adBtn, cc.p(0, -50));

	--根据视频加5步标记布局界面
	if (display.getRunningScene().M.fiveStepADFlag) then
		diamondBtn:centerTo(self.root, cc.p(0, -160));
		adBtn:hide();
	end

	--根据类型判断
	local title = self:seekNodeByName("replaceFont1")
				  :ignoreContentAdaptWithSize(true);
	local content = self:seekNodeByName("replaceFont2")
					  	:ignoreContentAdaptWithSize(true);
	local icon = self:seekNodeByName("replaceImg")
					 :ignoreContentAdaptWithSize(true);
	
	local itemID = nil;
	if (ACTION.STEP == self.M.type) then
		title:loadTexture("texture/fiveStep/font_bushu.png", 1);
		content:loadTexture("texture/fiveStep/font_jia5bu.png", 1);
		icon:loadTexture("texture/common/item_6.png", 1);
		itemID = 22;
	elseif (ACTION.TIME == self.M.type) then
		title:loadTexture("texture/fiveStep/font_shijian2.png", 1);
		content:loadTexture("texture/fiveStep/font_jia30miao.png", 1);
		content:setScaleX(0.9);
		icon:loadTexture("texture/common/item_7.png", 1);
		itemID = 24;
	end
	
	--当有道具的时候设置相关控件
	local itemNum = self.M:getDataByKey({"item", itemID, "num"});
	if (itemNum > 0) then
		icon:seekNodeByName("num")
			:show()
			:setString(":" .. itemNum);

		font_goon:centerTo(diamondBtn);
	else
		font_goon:move(50, 48);
		ccui.TextAtlas:create(configNumber._1)
					  :addTo(diamondBtn)
					  :setString(configItem[22].diamond)
					  :move(130, 46);
		display.newSprite("#texture/common/zhuanshi.png")
				:setScale(0.7)
				:addTo(diamondBtn)
				:move(184, 46);
	end
end

function fiveStepV:onDelete()
end

return fiveStepV;
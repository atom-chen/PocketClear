local pointV = class("pointV", require("cocos.framework.extends.UIPanel"));

function pointV:onCreate(id, panelArgs, optionsArgs, skinIni, effectIni)
	--需要释放纹理
	self.textures = {};

	self.id = id;
	self.itemData = configItem[self.id];
	-- self.ini = pointSkin1[tostring(self.id)]; --白包配置

	self:setContentSize(cc.size(CC_DESIGN_RESOLUTION.width, CC_DESIGN_RESOLUTION.height));
	
	--界面设置
	local panelIni = configPoint.panel[tostring(self.id)];
	if (nil ~= panelIni.texture) then
		self.root = ccui.ImageView:create()
					    :loadTexture(panelIni.texture)
					    :setName("root")
					    :addTo(self)
					    :centerTo(self);
		table.insert(self.textures, panelIni.texture);
	end

	local method = self["Panel" .. id];
	if (nil ~= method) then
		panelArgs = panelArgs or {};
		method(self, unpack(panelArgs));
	end

	--通用配置
	self:commonOptions();

	--礼包皮肤设置
	self.skinIni = skinIni;
	self:skinOptions(skinIni);

	--礼包按钮,手指引导等效果设置
	self:effectOptions(effectIni);

	--专用设置
	method = self["Options" .. id];
	if (nil ~= method) then
		optionsArgs = optionsArgs or {};
		method(self, optionsArgs.callback);
	end
end

function pointV:onDelete()
    for i=1, #self.textures do
    	cc.Director:getInstance()
    			   :getTextureCache()
    			   :removeTextureForKey(self.textures[i]);
    end
end

--通用设置
function pointV:commonOptions()
	--生成礼包关闭按钮
	self.closeBtn = ccui.Button:create()
					    :loadTextures("texture/common/closeBtn.png", "", "", 1)
					    :addTo(self.root)
					    :centerTo(self.root)
					    :onTouch(function(event)
					    	if ("ended" == event.name) then
					    		self:close();
					    	end
					    end);

	--生成礼包购买按钮
	self.buyBtn = ccui.Button:create()
					  :loadTextures("texture/common/btn_red.png", "", "", 1)
					  :addTo(self.root)
					  :centerTo(self.root)
					  :onTouch(function(event)
					  	if ("ended" == event.name) then
					  		local msgArr = {};
					  		table.insert(msgArr, self.id);
					  		table.insert(msgArr, function()
					  			self:close();
					  		end);
					  		self:sendCustomEvent(configMsg.point_buy, msgArr);
					  	end
					  end);
					  
	--生成购买按钮字体
	self.buyBtnFont = ccui.ImageView:create()
						  :addTo(self.buyBtn)
						  :centerTo(self.buyBtn, cc.p(50, 4));
						  
	--生成礼包资费信息
	local path = "#texture/common/BTN_" .. self.itemData.rmb .. "yuan.png";
	self.buyCue = display.newSprite(path)
						 :addTo(self.buyBtn)
						 :centerTo(self.buyBtn, cc.p(-60, 4));
end

function pointV:skinOptions(ini)
	if (nil == ini) then
		return;
	end
	
	--设置关闭按钮皮肤
	ini.cb_pos_offset = ini.cb_pos_offset or cc.p(0, 0);
	ini.cb_scale = ini.cb_scale or 1.0;
	self.closeBtn:moveDiff(ini.cb_pos_offset)
				 :setScale(ini.cb_scale);

	--设置购买按钮皮肤
	ini.bb_pos_offset = ini.bb_pos_offset or cc.p(0, 0);
	ini.bb_scale = ini.bb_scale or 1.0;
	self.buyBtn:moveDiff(ini.bb_pos_offset)
			   :setScale(ini.bb_scale);

	ini.bb_font = ini.bb_font or "texture/common/font_buy.png";
	self.buyBtnFont:loadTexture(ini.bb_font, 1);

	--设置资费提示皮肤
	ini.cue_pos_offset = ini.cue_pos_offset or cc.p(0, 0);
	ini.cue_scale = ini.cue_scale or 1.0;
	ini.cue_size = ini.cue_size or 40;
	ini.cue_color = ini.cue_color or cc.c4b(0, 0, 0, 255);
	-- self.buyCue:moveDiff(ini.cue_pos_offset)
			   -- :setFontSize(ini.cue_size)
			   -- :setTextColor(ini.cue_color)
			   -- :setVisible(not ini.cue_hide);
end

function pointV:effectOptions(ini)
	if (nil==ini) or (0==ini) then
		return;
	end
	
	require("app.tool.actionTime")
		:create(self.buyBtn, "buttonBreathe2")
		:play(0, 30);

	display.getRunningScene():loadArmature(configArmature["guideHand"].cFile);
	ccs.Armature:create("guideHand")
				:addTo(self.buyBtn)
				:centerTo(self.buyBtn, cc.p(60, -40))
				:play("shou");
end

--================================================
--				 专用面板设置
--================================================
function pointV:Panel109(brandIni) --翻牌
	table.insert(self.textures, "texture/flipBrand.png");

	brandIni = clone(brandIni);
	cc.CSLoader:createNode("texture/flipBrand.csb")
			   :addTo(self);
	self.root = self:seekNodeByName("root");

	local function drawoff(show)
		local probs, sumProb = {}, 0;
	    local len = #brandIni.items.prob;
	    for i=1, len do
	        local index = i;
	        if (show) then
	            index = len - i + 1;
	        end

	        sumProb = sumProb + brandIni.items.prob[index];
	        table.insert(probs, sumProb);
	    end

	    local drawoffValue, drawoffIndex = math.random(1, sumProb), nil;
	    for i=1, #probs do
	        if (drawoffValue <= probs[i]) then
	            drawoffIndex = i;
	            break;
	        end
	    end

	    local id = brandIni.items.type[drawoffIndex];
	    table.remove(brandIni.items.type, drawoffIndex);
	    table.remove(brandIni.items.prob, drawoffIndex);

	    local num = 1;
	    if (show) and (not brandIni.isFree) then
	        local range = configAccountingData["randomNum"][id] or "1@1";
	        local min, max = unpack(string.split(range, "@"));
	        num = math.random(tonumber(min), tonumber(max));
	    end
	    return id, num;
	end

	local function setBrand(brand, id, num)
		local itemData = configItem[id]; --道具数据

		--把牌设置成正面
    	brand.flipFlag = true;
    	brand:loadTexture("texture/flipBrand/FP_zhengmian.png", 1);

    	--设置道具图标
    	brand:seekNodeByName("icon")
    		 :show()
    		 :ignoreContentAdaptWithSize(true)
    		 :loadTexture(itemData.icon, 1);

    	--设置道具名字
    	brand:seekNodeByName("title")
    		 :show()
    		 :ignoreContentAdaptWithSize(true)
    		 :loadTexture(itemData.title, 1);

    	--设置道具数量
    	brand:seekNodeByName("num")
    	     :show()
    		 :setString(":" .. num);
	end

	self.itemList = {};
	for i=1, 6 do
      	local brand = self:seekNodeByName("brand" .. i)
  					  	:setTouchEnabled(true)
			      		:onTouch(function(event)
			      			if ("ended" == event.name) then
				                local array = {};

				                --翻第一张牌
				                -- table.insert(array, cc.EaseIn:create(cc.OrbitCamera:create(1, 1, 0, 0, 360*5, 0, 0), 0.2));
				                -- table.insert(array, cc.OrbitCamera:create(1, 1, 0, 0, 270, 0, 0)); --old
				                table.insert(array, cc.OrbitCamera:create(0.5, 1, 0, 180, 90, 0, 0)); --new
				                table.insert(array, cc.CallFunc:create(function() --当前翻牌
				                	local id, num = drawoff(); --抽取道具
				                	table.insert(self.itemList, {id, num});

				                	setBrand(event.target, id, num); --设置卡牌

				                	ccs.Armature:create("flipBrand") --设置选中特效
											 	:setPosition(cc.p(50, 60))
											 	:setScaleX(0.6)
				                    			:setScaleY(1.2)
				                    			:addTo(event.target)
				                    			:play("btnside");
				                end));
				                table.insert(array, cc.OrbitCamera:create(0.5, 1, 0, 270, 90, 0, 0));

				                --时间间隔1秒钟
				                table.insert(array, cc.DelayTime:create(0.5));

				                --翻剩余5张牌
				                table.insert(array, cc.CallFunc:create(function() --其余5张翻牌
				                	for j=1, 6 do
			                            local brand = self:seekNodeByName("brand" .. j);
			                            if (not brand.flipFlag) then
			                            	local array1 = {};
				                            table.insert(array1, cc.OrbitCamera:create(0.5, 1, 0, 180, 90, 0, 0));
				                            table.insert(array1, cc.CallFunc:create(function()
				                            	local id, num = drawoff(true); --抽取道具
				                            	table.insert(self.itemList, {id, num});
				                            	setBrand(brand, id, num); --设置卡牌
				                            end));
				                            table.insert(array1, cc.OrbitCamera:create(0.5, 1, 0, 270, 90, 0, 0));
				                            brand:runAction(cc.Sequence:create(array1));
			                            end
				                    end
				                end));
				                
				                --时间间隔1秒钟
				                table.insert(array, cc.DelayTime:create(0.5));

				                table.insert(array, cc.CallFunc:create(function() --解锁按钮
				                	self.closeBtn:show();
									self.buyBtn:show();
									self.getBtn:show();
									self.buyCue:setVisible(not self.skinIni.cue_hide);
				                end));
				                event.target:runAction(cc.Sequence:create(array));
				                
				                for j=1, 6 do
				                	self:seekNodeByName("brand" .. j)
				                		:setTouchEnabled(false);
				                end
				            end
			      		end);
    end
end

function pointV:Panel105() --豪华钻石礼包
	ccui.TextAtlas:create(configNumber._3)
		:move(350, 230)
		:setString(2500)
		:addTo(self.root);

	ccui.TextAtlas:create(configNumber._3)
		:move(450, 160)
		:setString(1000)
		:addTo(self.root);
end

function pointV:Panel115() --一大袋金币
	ccui.TextAtlas:create(configNumber._3)
		:move(350, 230)
		:setString(90000)
		:addTo(self.root);

	ccui.TextAtlas:create(configNumber._3)
		:move(450, 160)
		:setString(10000)
		:addTo(self.root);
end

--================================================
--				 专用按钮设置
--================================================
function pointV:Options102()
	self.buyBtn:setScale(0.9);

	--恢复计费点
    local repeatBtn = ccui.Button:create()
                        :setPressedActionEnabled(true)
                        :loadTextures("texture/common/btn_blue.png", "", "", 1)
                        :setPosition(cc.p(460, 84))
                        :setScale(0.9)
                        :addTo(self.root)
                        :onTouch(function(event)
                            if ("ended" == event.name) then
                                golbal.lua2oc("Adapter", "iapRestore", {call=function(id)
                                    if ("xiong001"==id) then
                                        if (self.M:getDataByKey({"item", 102, "buyTime"})<1) then
                                            self.M:modifyDataByKey({"item", 102, "buyTime",}, 1);
                                        end
                                        self:close();

                                        --通知监听该消息point_buySuccess监听者
                                		self:sendCustomEvent(configMsg.point_buySuccess);
                                    end
                                end,});
                            end                            
                        end);

    ccui.ImageView:create()
        :loadTexture("texture/common/font_restore.png", 1)
        :addTo(repeatBtn)
        :centerTo(repeatBtn, cc.p(16, 6));
end

function pointV:Options109(call) --翻牌
	--领取按钮
	self.getBtn =  ccui.Button:create()
						  :hide()
						  :loadTextures("texture/common/btn_blue.png", "", "", 1)
						  :addTo(self.root)
						  :move(470, 104)
						  :onTouch(function(event)
						  	if ("ended" == event.name) then
						 		local msgArr = {};
						  		table.insert(msgArr, {self.itemList[1]});
						  		table.insert(msgArr, function()
						  			self:close();
						  			if (nil ~= call) then
						  				call();
						  			end
						  		end);
						  		self:sendCustomEvent(configMsg.point_addItem, msgArr);
						 	end
						  end);

	--领取按钮字体
	display.newSprite("#texture/flipBrand/chousongdejiangli.png")
			:setScale(0.9)
			:addTo(self.getBtn)
			:centerTo(self.getBtn, cc.p(-4, 0));

	--关闭按钮
	self.closeBtn:hide()
				 :onTouch(function(event)
				 	if ("ended" == event.name) then
				 		local msgArr = {};
				  		table.insert(msgArr, {self.itemList[1]});
				  		table.insert(msgArr, function()
				  			self:close();
				  			if (nil ~= call) then
				  				call();
				  			end
				  		end);
				  		self:sendCustomEvent(configMsg.point_addItem, msgArr);
				 	end
				 end);
				 
	--购买按钮
	self.buyBtn:hide()
			   :setLocalZOrder(self.getBtn:getLocalZOrder()+1)
			   :onTouch(function(event)
			   		if ("ended" == event.name) then
			   			local msgArr = {};
				  		table.insert(msgArr, 109);
				  		table.insert(msgArr, function()
				  			self:close();
				  			if (nil ~= call) then
				  				call();
				  			end
				  		end);
				  		table.insert(msgArr, self.itemList);
				  		self:sendCustomEvent(configMsg.point_buy, msgArr);
			   		end
			   end);

	--2折字体
	display.newSprite("#texture/flipBrand/da2zhe.png")
			:addTo(self.buyBtn)
			:centerTo(self.buyBtn, cc.p(120, 30));

	--资费提示
	self.buyCue:hide();
end

function pointV:Options106()
	display.newSprite("#texture/common/1zhe.png")
			:move(274, 60)
			:addTo(self.buyBtn);
end

return pointV;

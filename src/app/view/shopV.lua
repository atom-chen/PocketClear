local shopV = class("shopV", require("cocos.framework.extends.UIPanel"));
local ContextPanel = require("app.context.contextPanel");

function shopV:onCreate(index)
	--=====================================初始化界面
	self:seekNodeByName("closeBtn") --关闭按钮
    	:setPressedActionEnabled(true)
        :onTouch(function(event)
            if ("ended" == event.name) then
                self:close();
            end
        end);

    for i=1, SHOP.MAX-1 do --按钮,标签页
    	self:seekNodeByName("btn" .. i)
    		:ignoreContentAdaptWithSize(true)
    		:setTouchEnabled(true)
    		:onTouch(function(event)
    			self:setLabels(i);
    		end);

    	self:seekNodeByName("Panel" .. i)
    		:hide();
    end

    self:setLabels(index);

    --监控礼包购买成功
	self:addCustomEvent(configMsg.point_buySuccess, function(event)
		self:setPanel1();
	end);
end

function shopV:onDelete()
end

function shopV:setLabels(index)
	--恢复上次打开标签页按钮
	if (nil ~= self.index) then
		local btn = self:seekNodeByName("btn" .. self.index)
						:loadTexture("texture/shop/btn_SC_1.png", 1)
						:moveDiff(0, 6);
		btn:seekNodeByName("img")
		   :moveDiff(0, -14);

		self:seekNodeByName("Panel" .. self.index)
    		:hide();
	end

	--设置当前标签页按钮
	self.index = index;
	local btn = self:seekNodeByName("btn" .. self.index)
				    :loadTexture("texture/shop/btn_SC_2.png", 1)
					:moveDiff(0, -6);
	btn:seekNodeByName("img")
	   :moveDiff(0, 14);
	self:seekNodeByName("Panel" .. self.index)
    		:show();

	local method = self["setPanel" .. index];
	if (nil ~= method) then
		method(self);
	end
end

--礼包栏
function shopV:setPanel1()
	local sv = self:seekNodeByName("ScrollView1")
	sv:removeAllChildren();

	local controlList = {};
	local num, posY, sumHeight = #configShop[SHOP.MEAL], 0, 0;
	for i=1, num do
		local id, func = unpack(configShop[SHOP.MEAL][i]);
		local itemData = configItem[id];

		repeat
			--检测非重复购买计费点
			if (not itemData.repeatBuy) then
				if (self.M:getDataByKey({"item", id, "buyTime"})>=1) then
					break;
				end
			end

			local poster = ccui.ImageView:create()
								:setAnchorPoint(cc.p(0, 0))
								:loadTexture(itemData.poster)
								:addTo(sv)
								:insertToTable(controlList)
								:move(0, posY)
								:setTouchEnabled(true)
								:onTouch(function(event)
									if ("ended" == event.name) then
										func();
									end
								end);

			local posterSize = poster:getContentSize();
			posY = posY - posterSize.height;
			sumHeight = sumHeight + posterSize.height;
		until true
	end
	

	local svSize = sv:getContentSize();
	if (svSize.height > sumHeight) then
		sumHeight = svSize.height;
	end

	sv:setInnerContainerSize(cc.size(svSize.width, sumHeight));

	for i=1, #controlList do
		local size = controlList[i]:getContentSize();
		controlList[i]:moveDiff(0, sumHeight-size.height);
	end
end

--道具栏
function shopV:setPanel2()
	local sv = self:seekNodeByName("ScrollView2")
	if (#sv:getChildren() > 0) then
		return;
	end

	local temp = self:seekNodeByName("item_Temp");
	local tempSize = temp:getContentSize();
	local column, space = 4, cc.p(10, 34);
	local num, startPos = #configShop[SHOP.ITEM], cc.p(12, 80);
	local curPos = startPos;
	for i=1, num do
		local id, oldPrice = unpack(configShop[SHOP.ITEM][num-i+1]);

		local control = temp:clone()
							:show()
							:setAnchorPoint(cc.p(0, 0))
							:addTo(sv)
							:move(curPos)
							:setTouchEnabled(true)
							:onTouch(function(event)
								if ("ended" == event.name) then
									ContextPanel:create("CPBuyItem", id);
								end
							end);

		local itemData = configItem[id];
		if (nil == itemData) then
			control:hide();
		else
			--设置图标
			control:seekNodeByName("icon")
				   :loadTexture(itemData.icon, 1);

			--设置当前价钱
			control:seekNodeByName("priceCon")
				   :seekNodeByName("value")
				   :setString(itemData.diamond);

			--设置打折
			if (nil ~= oldPrice) then
				control:seekNodeByName("discount")
					   :show();

				control:seekNodeByName("oldPriceCon")
					   :show()
					   :seekNodeByName("value")
					   :setString(oldPrice);
			end
		end

		if (0~=i)and(0==i%column) then
			curPos = cc.p(startPos.x, curPos.y+space.y+tempSize.height);
		else
			curPos = cc.p(curPos.x+space.x+tempSize.width, curPos.y);
		end
	end
end

--货币栏
function shopV:setPanel3()
	local sv = self:seekNodeByName("ScrollView3")
	if (#sv:getChildren() > 0) then
		return;
	end

	local temp = self:seekNodeByName("money_Temp");
	local tempSize = temp:getContentSize();
	local num, posY = #configShop[SHOP.MONEY], 20;
	for i=1, num do
		local id, iconScale = unpack(configShop[SHOP.MONEY][num-i+1]);

		local control = temp:clone()
							:show()
							:setAnchorPoint(cc.p(0, 0))
							:addTo(sv)
							:move(0, posY);

		local itemData = configItem[id];

		--设置图标
		control:seekNodeByName("icon")
			   :ignoreContentAdaptWithSize(true)
			   :setScale(iconScale)
			   :loadTexture(itemData.icon, 1);

		--设置当前价钱
		local con1 = control:seekNodeByName("con1");
		con1:seekNodeByName("moneyIcon")
			:loadTexture(itemData.title, 1);
		con1:seekNodeByName("value")
			:setString(itemData.pack[1].num);

		if (1 == #itemData.pack) then
			control:seekNodeByName("con2")
				   :hide();
			control:seekNodeByName("con1")
				   :moveDiff(0, -24);
		else
			control:seekNodeByName("con2")
				   :seekNodeByName("value")
				   :setString(itemData.pack[2].num);
		end

		--设置按钮
		control:seekNodeByName("buyBtn")
			   :setPressedActionEnabled(true)
			   :onTouch(function(event)
			   		if ("ended" == event.name) then
			   			self:sendCustomEvent(configMsg.shop_buy, id);
			   		end
			   end)
			   :seekNodeByName("value")
			   :setString(itemData.rmb);

		posY = posY + control:getContentSize().height+12;
	end
end

--背包栏
function shopV:setPanel4()
	local sv = self:seekNodeByName("ScrollView4")
	sv:removeAllChildren();

	local temp = self:seekNodeByName("myItem_Temp");
	local tempSize = temp:getContentSize();
	local column, space, startPos = 4, cc.p(0, 34), cc.p(0, -20);
	local curPos, counter = startPos, 0;
	local controlList = {};
	for k, v in pairs(self.M:getDataByKey({"item"})) do
		repeat
			if (k<20)or(k>30)or(v.num<=0) then
				break;
			end

			counter = counter + 1;
			local control = temp:clone()
								:show()
								:setAnchorPoint(cc.p(0, 0))
								:addTo(sv)
								:move(curPos)
								:insertToTable(controlList);

			local itemData = configItem[k];
			--设置图标
			control:seekNodeByName("icon")
				   :loadTexture(itemData.icon, 1);

			--设置当前价钱
			control:seekNodeByName("numCon")
				   :seekNodeByName("value")
				   :setString(v.num);

			if (0~=counter)and(0==counter%column) then
				curPos = cc.p(startPos.x, curPos.y-space.y-tempSize.height);
			else
				curPos = cc.p(curPos.x+space.x+tempSize.width, curPos.y);
			end
		until true
	end

	local svSize = sv:getContentSize();
	if (svSize.height > curPos.y) then
		curPos.y = svSize.height-tempSize.height;
	end
	sv:setInnerContainerSize(cc.size(svSize.width, curPos.y));

	for i=1, #controlList do
		controlList[i]:moveDiff(0, curPos.y);
	end
end

return shopV;
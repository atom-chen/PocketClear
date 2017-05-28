local panel = require("cocos.framework.extends.UIPanel");
local wheelV = class("wheelV", panel);
local Shader = require("app.tool.shader");

function wheelV:onCreate(id)
	self.curDegree = 0;

	--关闭按钮
	self:seekNodeByName("closeBtn")
		:setPressedActionEnabled(true)
		:onTouch(function(event)
			if ("ended" == event.name) then
				self:close();
			end
		end);

	--钻石抽奖按钮
	self:seekNodeByName("diamondBtn")
		:setPressedActionEnabled(true)
		:onTouch(function(event)
			if ("ended" == event.name) then
				self:sendCustomEvent(configMsg.wheelDraw_diamond, function(index)
					self:draw(index, function()
						require("app.context.contextPoint")
							:create("wheelDiamondEnd");
						self:setDiamondBtn();

						--引导一次看视频转转盘
						if (0 ~= self.M:getDataByKey({"onoff", "sneakSkin"})) then
							require("app.context.contextGuide")
								:create(20014, 1);
						end
					end);
				end);
			end
		end);
		
	--广告抽奖按钮
	self:seekNodeByName("adBtn")
		:setPressedActionEnabled(true)
		:onTouch(function(event)
			if ("ended" == event.name) then
				require("app.module.msgBox.msgBox")
                    :create(configPanel.msgBox_VideoReward, 
                    		function() --sure call
								self:sendCustomEvent(configMsg.wheelDraw_ad, function(index)
									self:draw(index);
									self:setADBtn();
								end);
                    		end);
			end
		end);
		
	--设置按钮
	self:setDiamondBtn();
	self:setADBtn();

	--刷新界面
	self:setWheelCon();

	--面板动画
	local title = cc.CSLoader:createTimeline(self.config.cFile);
	if (nil ~= title) then
		self.node:runAction(title);
	end
	title:play("title", true);

	local lights = cc.CSLoader:createTimeline(self.config.cFile);
	if (nil ~= lights) then
		self.node:runAction(lights);
	end
	lights:play("lights", true);
end

function wheelV:onDelete()
	if (nil ~= self.timeCountID) then
		golbal.removeScheduler(self.timeCountID);
		self.timeCountID = nil;
	end
end

--获取当前钻石抽奖的消耗信息
function wheelV:getDiamondDrawConsumeInfo()
	local count = self.M:getDataByKey("wheelDiamondCount");
	local itemID = 0;
	if (0 == count) then
		itemID = nil;
	elseif (count <= 2) then
		itemID = 36;
	elseif (count <= 4) then
		itemID = 37;
	else
		itemID = 38;
	end
	return itemID;
end

function wheelV:setDiamondBtn()
	local diamondBtn = self:seekNodeByName("diamondBtn");
	local btnFont = diamondBtn:seekNodeByName("font");
	local count = self.M:getDataByKey("wheelDiamondCount");

	local path = nil;
	if (0 == count) then --免费抽奖
		path = "texture/wheel/font_mianfeichoujiang.png";
		diamondBtn:move(66, -154); --按钮移动
		btnFont:move(140, 50); --按钮字体居中对齐
		diamondBtn:seekNodeByName("font_free") --免费字体显示
				  :show();
		diamondBtn:seekNodeByName("diamond") --钻石消耗隐藏
				  :hide();
	else --钻石抽奖 20, 20, 40, 40, 60,.....
		path = "texture/wheel/font_yuanyici.png";
		diamondBtn:move(66, -144); --按钮移动
		btnFont:move(180, 50); --按钮字体偏移

		--钻石消耗显示
		local itemID = self:getDiamondDrawConsumeInfo();
		diamondBtn:seekNodeByName("diamond") 
				  :show()
				  :setString(configItem[itemID].diamond);

		--免费字体显示
		diamondBtn:seekNodeByName("font_free")
				  :hide();
	end
	btnFont:setSpriteFrame(path);

	--钻石抽奖举重
	if (self.M:getDataByKey("wheelADCount")>=10)
		or (0==self.M:getDataByKey({"onoff", "sneakSkin"})) then
		diamondBtn:moveDiff(160, 0);
	end
end

function wheelV:setADBtn()
	self.adCD = self.M:getDataByKey("wheelAD_CD")-os.time(); --广告CD
	if (self.adCD<0) then
		self.adCD = 0;
	end

	local adBtn = self:seekNodeByName("adBtn");
	local count = self.M:getDataByKey("wheelADCount");
	if (count >= 10)or(0==self.M:getDataByKey({"onoff", "sneakSkin"})) then --在线参数开关礼包判断
		--每天10次广告抽奖上限
		adBtn:hide();
	else
		--设置剩余次数
		adBtn:seekNodeByName("number")
			 :setString((10-count) .. ";10");

		--设置倒计时
		local timeCount = adBtn:seekNodeByName("timeCount")
		if (self.adCD > 0) then
			--设置广告按钮
			adBtn:setTouchEnabled(false);
			self:delayCall(0.1, function()
	            Shader:color(adBtn, cc.c3b(0.299, 0.587, 0.114));
	        end);

			--设置倒计时
			local counter = 0;
			self.timeCountID = golbal.scheduler(function(dt, id)
				counter = counter + dt;
				if (counter < 1) then
					return;
				end
				
				self.adCD = self.adCD - 1;
				if (self.adCD <= 0) then
					self:sendCustomEvent(configMsg.wheelCDComplete, function()
						golbal.removeScheduler(self.timeCountID);
						self.timeCountID = nil;
						self:setADBtn();
					end);
					return;
				end

				timeCount:setString(golbal.formatTime(self.adCD, true));
				if (not timeCount:isVisible()) then
					timeCount:show();
				end
			end, 1, false);
		else
			Shader:removeShader(adBtn);
			adBtn:setTouchEnabled(true);
			timeCount:hide();
		end
	end
end

function wheelV:setWheelCon()
	self:delayCall(0.01, function()
		self:sendCustomEvent(configMsg.wheelRefresh, function(itemList)
			self.itemList = itemList;

			local wheelCon = self:seekNodeByName("wheelCon");
			for i=1, #self.itemList do
				local id, num = unpack(self.itemList[i]);
				local itemData = configItem[id];

				wheelCon:seekNodeByName("itemCon" .. i)
						:seekNodeByName("item")
						:setSpriteFrame(itemData.icon)
						:setScale(0.01)
						:runAction(cc.ScaleTo:create(0.3, 0.7))
						:seekNodeByName("num")
						:setString("×" .. num);
			end
		end);
	end);
end

function wheelV:draw(index, endFunc)
	local mask = self:seekNodeByName("mask");
	if (nil == mask) then
		mask = ccui.Layout:create()
				   :addTo(self)
				   :setName("mask")
				   :setContentSize(display.size)
				   :setTouchEnabled(true);
	end
	mask:show();
	
	--目标道具的角度
	local targetDegree = (index-1)*45+math.random(3, 42);
	local actionArr = {};
	table.insert(actionArr, cc.EaseExponentialIn:create(cc.RotateBy:create(2.0, -360)));
	table.insert(actionArr, cc.RotateBy:create(2.0, -360*10));
	table.insert(actionArr, cc.EaseExponentialOut:create(cc.RotateBy:create(3.0, -(360+targetDegree-self.curDegree))));
	table.insert(actionArr, cc.CallFunc:create(function(sender)
		local id, num = unpack(self.itemList[index]);
		require("app.context.contextPanel")
			:create("showItemReward", {{id, num},}, function()
				self.curDegree = targetDegree; --设置当前角度
				mask:hide(); --遮罩隐藏

				--调用回掉
				if (nil ~= endFunc) then
					endFunc();
				end
			end);
	end));

	self:seekNodeByName("wheelCon")
		:runAction(cc.Sequence:create(actionArr));
end

return wheelV;
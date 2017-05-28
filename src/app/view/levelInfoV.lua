local UIPanel = require("cocos.framework.extends.UIPanel");
local ContextScene = require("app.context.contextScene");
local ContextPanel = require("app.context.contextPanel");

local LevelInfoV = class("LevelInfoV", UIPanel);

function LevelInfoV:onCreate()
	self.useItemCon = self:seekNodeByName("itemCon");

	self.cpIndex = self.M:getDataByKey("cpIndex"); --当前关卡
	self.cpIni = self.M:getDataByKey("cpData"); --获取本关的关卡配置

	--设置使用的道具
	self:setUseItems();

	--设置关闭按钮
	self:seekNodeByName("closeBtn")
		:setTouchEnabled(false)
		:onTouch(function(event)
			if ("ended" == event.name) then
				self:close();

				if ("main" == display.getRunningScene():getName()) then
					ContextScene:create("selectLevel");
				end
			end
		end);

	--设置关卡索引
	self:seekNodeByName("cpIndex")
		:setScale(1.3)
		:setString(self.cpIndex);
		
	--设置关卡目标
	self.taskIni = self.cpIni.task; --获取本关任务配置
	self.targetCon = self:seekNodeByName("targetCon");
	self["setTarget" .. self.taskIni.type](self);
	
	--设置开始按钮
	self.touchStartBtnFlag = false;
	self:seekNodeByName("startBtn")
		:setTouchEnabled(false)
		:onTouch(function(event)
			if ("ended" == event.name) then
				if (self.touchStartBtnFlag) then
					return;
				end

				if (0 == self.M:getDataByKey({"item", 200, "timebar"})) then
					local curPower = self.M:getDataByKey(golbal.power());
					if (curPower < self.cpIni.consume) then
						ContextPanel:create("power")
									:getV()
									:registerCloseCallback(function()
										--体力已满判断
										local endTime = self.M:getDataByKey({"item", 200, "timebar"});
										local curPower = self.M:getDataByKey({"item", 4, "num"});
										if (endTime>0) or (curPower>=golbal.powerLimit) then
											return;
										end

										require("app.context.contextPanel")
											:create("fullPower");
									end);
						return;
					end
				end
				
				audio.playSound(unpack(configAudio.sound_3));
				self.touchStartBtnFlag = true;
				
				--体力图标向上滑动消失
				local cosumeImg = display.newSprite("#texture/common/img_cp_power.png")
										 :addTo(self)
										 :setScale(0.1)
										 :setCascadeOpacityEnabled(true)
										 :move(180, display.size.height-100);
										 
				local consumeNum = ccui.TextAtlas:create(configNumber._3)
										  		 :setString(":" .. self.cpIni.consume)
										  		 :addTo(cosumeImg)
										  		 :setScale(1.4)
										  		 :move(-44, 58);
										  		 
				cosumeImg:runAction(cc.Sequence:create(
									cc.ScaleTo:create(checknumber(0.2), 1.0),
									cc.Spawn:create(cc.MoveBy:create(0.5, cc.p(0, 100)), 
													cc.FadeOut:create(0.5))));
				
				--体力图标飞往开始按钮
				local startPos = event.target:convertToNodeSpace(cc.p(180, display.size.height-100));
				local targetSize = event.target:getContentSize();
				local targetPos = cc.p(targetSize.width*0.58, targetSize.height*0.48);
				local flyConsumeImg = display.newSprite("#texture/common/img_cp_power.png")
											 :addTo(event.target)
											 :setScale(1.2)
											 :move(startPos.x, startPos.y);
											 
				local spline = cc.CardinalSplineBy:create(0.8, cc.getPosesInArc(startPos, targetPos), 0);
				local easeSpline = cc.EaseInOut:create(spline, 1.0);
				local scaleTo = cc.ScaleTo:create(0.8, 1.0);
				flyConsumeImg:runAction(cc.Sequence:create(cc.Spawn:create(easeSpline, scaleTo), cc.CallFunc:create(function()
					--销毁对象
					cosumeImg:removeSelf();
					
					self:sendCustomEvent(configMsg.levelInfo_deductPower, self.cpIni.consume); --扣除体力
					-- self:sendCustomEvent(configMsg.selectLevel_exit, self.cpIni.consume); --退出选择关卡场景
					
					--切换场景
					self:delayCall(0.4, function()
						self:close(function ()
							ContextScene:create("main", self.cpIndex, self.buyItemList);

							--数据统计
							for k, v in pairs(self.buyItemList) do
								local itemData = configItem[k];
								golbal.sendCustomEvent(configMsg.dataCount_buyVirtualItem, {itemData.name .. "@金币", num, itemData.coin,});
								golbal.sendCustomEvent(configMsg.dataCount_customEvent, {COUNTEVENTS._8,});
							end
						end);
					end);
				end)));
			end
		end);
end

function LevelInfoV:onDelete()
	
end

function LevelInfoV:transitionEnterFinish()
	require("app.context.contextGuide"):create(self.M:getDataByKey("cpIndex")+1000, 1);
	
	self:seekNodeByName("startBtn")
		:setTouchEnabled(true);
	self:seekNodeByName("closeBtn")
		:setTouchEnabled(true);
end

function LevelInfoV:setUseItems()
	local maxCP = self.M:getDataByKey("maxCP"); --最大通关数
	local itemLockData = self.M:getDataByKey({"ini", "configLockItem", "levelInfo"}); --道具解锁关卡
	local viewList = {}; --道具视图排序表
	self.buyItemList = {}; --购买道具表
	local isHasUnlock = false;
	
	for i=1, #self.cpIni.useItem_l do
		local itemID = self.cpIni.useItem_l[i].id;
		local itemData = configItem[itemID];

		local bg = ccui.ImageView:create("texture/common/bg_brown.png", 1)
								 :setName("itemCon" .. i)
								 :addTo(self.useItemCon)
								 :insertToTable(viewList);

		display.newSprite("#" .. itemData.icon)
			   :addTo(bg)
			   :centerTo(bg);

		if ((maxCP+1)<itemLockData[i]) then
			display.newSprite("#texture/common/img_lock.png")
			   	   :addTo(bg)
			   	   :centerTo(bg);

			ccui.TextAtlas:create(configNumber._7)
						  :setString(itemLockData[i])
						  :addTo(bg)
						  :setScale(0.8)
						  :move(38, 94);
		else
			isHasUnlock = true;
			bg:setTouchEnabled(true)
			  :onTouch(function(event)
					  	if (event.name == "ended") then
					  		local mark = bg:seekNodeByName("mark")
					  		if (not self.buyItemList[itemID]) then --购买
					  			golbal.buyWithCoin(itemID, 1, function()
					  				mark:show();
					  				self.buyItemList[itemID] = true;
					  			end);
					  		else
					  			self:sendCustomEvent(configMsg.levelInfo_cancelBuy, itemData.coin);
					  			mark:hide();
					  			self.buyItemList[itemID] = nil;
					  		end
					  	end
					 end);

			--选中勾
			display.newSprite("#texture/common/gou.png")
				   :setName("mark")
				   :addTo(bg)
				   :hide()
				   :move(bg:getContentSize().width-20, 30);

			--消耗金币相关显示
			local consumeBg = display.newSprite("#texture/levelInfo/img_daojujiagediban.png")
								     :addTo(bg)
								     :centerTo(bg, cc.p(0, -108));

			local consumeViewList = {};
			display.newSprite("#texture/common/jinbi.png")
				   :addTo(consumeBg)
				   :insertToTable(consumeViewList);
			ccui.TextAtlas:create(configNumber._6)
						  :setString(itemData.coin)
						  :addTo(consumeBg)
						  :insertToTable(consumeViewList);
			consumeBg:grid(consumeViewList,
							{column=#consumeViewList,
							 space={x=0, y=0,},
							 offsetS=cc.size(0, 0),});
		end
	end

	self.useItemCon:grid(viewList, 
						{row=1, column=#viewList, 
						space={x=50, y=0,}, 
						offsetS=cc.size(0, -106),});

	if (not isHasUnlock) then
		self.useItemCon:moveDiff(0, -20);
		self:seekNodeByName("startBtn"):moveDiff(0, 30);
	end
end

--设置收集任务目标
function LevelInfoV:setTarget1()
	local sortViewList = {};
	for i=1, #self.taskIni.limit do
		repeat
			local layout = ccui.Layout:create()
							   :setAnchorPoint(cc.p(0.5, 0.5))
							   :setContentSize(cc.size(80, 80))
							   :addTo(self.targetCon)
							   :insertToTable(sortViewList);
			
			golbal.createElement(self.taskIni.limit[i].type)
				  :addTo(layout)
				  :centerTo(layout);
				  
			ccui.TextAtlas:create(configNumber._6)
						  :addTo(layout)
						  :centerTo(layout, cc.p(0, -60))
						  :setString(":" .. self.taskIni.limit[i].num);
		until true
	end

	if (nil ~= next(self.taskIni.limit)) then
		self.targetCon:grid(sortViewList, 
							{row=1, column=#sortViewList, 
							space={x=30, y=0,}, 
							offsetS=cc.size(0, -40),});
	end
end

--设置分数任务目标
function LevelInfoV:setTarget2()
	local viewList = {};
	display.newSprite("#texture/common/font_fs.png")
		   :addTo(self.targetCon)
		   :insertToTable(viewList)
		   :setScale(2.0);
	
	ccui.TextAtlas:create(configNumber._4)
				  :addTo(self.targetCon)
				  :setString(self.taskIni.limit)
				  :setScale(1.6)
				  :insertToTable(viewList);
	self.targetCon:grid(viewList, {column=#viewList, space={x=20, y=0,}, offsetS=cc.size(0, -40)});
end

--设置BOSS任务目标
function LevelInfoV:setTarget3()
	sp.SkeletonAnimation:create(self.taskIni.name)
						:addTo(self.targetCon)
						:setScale(0.7)
						:centerTo(self.targetCon, cc.p(0, -120))
						:play("idel");
end

return LevelInfoV;
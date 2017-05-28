local UIPanel = require("cocos.framework.extends.UIPanel");
local ContextScene = require("app.context.contextScene");

local victoryV = class("victoryV", UIPanel);

function victoryV:onCreate()
	self.cpIndex = self.M:getDataByKey("cpIndex");
	local starNum = self.M:getDataByKey("starNum");
	self.nextIndex = self.cpIndex + 1;

	self.oepnNextCPInfoFlag = false; --是否打开下关信息界面

	--设置关闭按钮
	self:seekNodeByName("closeBtn")
		:onTouch(function(event)
			if ("ended" == event.name) then
				self:close();
			end
		end);
	
	--设置下一关按钮
	local nextBtn = self:seekNodeByName("nextBtn")
						:onTouch(function(event)
							if ("ended" == event.name) then
								self.oepnNextCPInfoFlag = true;
								self:close();
							end 
						end);
		
	--设置分享按钮
	local shareBtn = self:seekNodeByName("shareBtn");
	if (self.M:getDataByKey("shareFlag")) then
		nextBtn:moveDiff(100, 0);
		shareBtn:hide();
	else
		local checkState = self.M:getDataByKey({"onoff", "sneakSkin"});

		--设置分享按钮字体
		local fontPath, scale = nil, 1.0;
		if (0 == checkState) then
			fontPath = "texture/common/font_fenxiang.png";
		else
			fontPath = "texture/common/font_youjiangfenxiang.png";
			scale = 0.8;
		end
		shareBtn:seekNodeByName("font")
				:ignoreContentAdaptWithSize(true)
				:setScale(scale)
				:loadTexture(fontPath, 1);

		--设置分享按钮命令
		shareBtn:onTouch(function(event)
				if ("ended" == event.name) then
					local shareSuccess = function(id, num)
						nextBtn:moveDiff(100, 0);
						shareBtn:hide();
						
						local itemData = configItem[id];
						local rewardIcon = display.newSprite("#" .. itemData.icon);
						ccui.TextAtlas:create(configNumber._6)
								  :setString(":" .. num)
								  :move(rewardIcon:getContentSize().width, 0)
								  :addTo(rewardIcon);
						golbal.effectFly("itemCon5", rewardIcon);
					end
					
					if (0 == checkState) then
						self:sendCustomEvent(configMsg.share, function(id, num)
							shareSuccess(id, num);
						end);
					else
						require("app.context.contextPanel")
							:create("share", function(id, num)
								shareSuccess(id, num);
							end);
					end
				end
			end);
	end
	
	--设置关卡索引
	self:seekNodeByName("cpIndex")
		:setString(self.cpIndex);
		
	--设置星星动画
	if (starNum > 0) then
		local root = self:seekNodeByName("root");
		ccs.Armature:create("star")
				    :play("SLJMxingxing" .. starNum)
				    :addTo(root)
				    :centerTo(root, cc.p(-340, 600));
	end

	--设置奖励道具
	local viewList = {};
	local rewards = self.M:getDataByKey({"ini", "configCP", self.cpIndex, "reward"});
	for i=1, #rewards do
		local id, num = rewards[i].id, rewards[i].num;
		local itemData = self.M:getDataByKey({"ini", "configItem", id});
		
		local icon = display.newSprite("#" .. itemData.icon)
			   				:addTo(self:seekNodeByName("rewardCon"))
			   				:insertToTable(viewList);

		ccui.TextAtlas:create(configNumber._6)
			:setString(":" .. num)
			:move(icon:getContentSize().width, 0)
			:addTo(icon);
	end
	
	self:seekNodeByName("rewardCon")
		:grid(viewList, {column=#viewList, space={x=100, y=0,}, offsetS=cc.size(0, -36)});

	--设置分数
	local scoreCon = self:seekNodeByName("scoreCon");
	ccui.TextAtlas:create(configNumber._4)
			:setString(self.M:getDataByKey("score"))
			:setAnchorPoint(cc.p(0, 0))
			:move(scoreCon:getContentSize().width+10, -4)
			:addTo(scoreCon);
end

function victoryV:onDelete()
	if (self.nextIndex<=golbal.directBegin) 
		and (self.cpIndex==self.M:getDataByKey("maxCP")) then
		ContextScene:create("main", self.nextIndex);
	else
		ContextScene:create("selectLevel", self.cpIndex, self.oepnNextCPInfoFlag);
	end
end

return victoryV;
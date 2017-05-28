local panel = require("cocos.framework.extends.UIPanel");
local showItemRewardV = class("showItemRewardV", panel);

function showItemRewardV:onCreate(idlist, call)
	local itemControlList = {};

	self:seekNodeByName("sureBtn")
		:setPressedActionEnabled(true)
		:onTouch(function(event)
			if ("ended" == event.name) then
				local count = 0;
				self.schedulerID = self:addScheduler(function( ... )
					local itemCon = itemControlList[count+1];
					if (count == #itemControlList) then
						self:removeSchedulerByID(self.schedulerID);
						self.schedulerID = nil;
						return;
					end
					
					local icon  = itemCon:seekNodeByName("icon")
					local iconPos = icon:convertToWorldSpaceAR(cc.p(0, 0));

					--获得道具动画
			        local spawnActions = {}; --并发动作表
			        local poses = cc.getPosesInArc(iconPos, cc.p(display.size.width*0.9, 40)); --弧形动作
			        local spline = cc.CardinalSplineBy:create(0.8, poses, 0);
			        local easeSpline = cc.EaseInOut:create(spline, 1.0);
			        table.insert(spawnActions, easeSpline);
			        local rotate = cc.RotateBy:create(0.8, -360); --旋转动作
			        table.insert(spawnActions, rotate);
			        local scale = cc.ScaleTo:create(0.8, 0.4); --缩放动作
			        table.insert(spawnActions, scale);
			        
			        local actions = {}; --动作表
			        table.insert(actions, cc.Spawn:create(spawnActions));
			        table.insert(actions, cc.CallFunc:create(function(sender)
			        	sender:removeSelf();
			        	if (count == #itemControlList) then
			        		self:delayCall(0.2, function()
			        			self:close();
			        			if (nil ~= call) then
			        				call();
			        			end
			        		end);
			        	end
			        end));

			        itemCon:seekNodeByName("icon")
			        	   :runAction(cc.Sequence:create(actions));
			       	count = count + 1;
				end, 0.1, false);
			end
		end);

	for i=1, #idlist do
		local itemID, itemNum = unpack(idlist[i]);
		local itemData = configItem[itemID];

		--设置控件
		local item = self:seekNodeByName("item")
						 :show()
						 :clone()
						 :insertToTable(itemControlList);

		item:seekNodeByName("name")
			:ignoreContentAdaptWithSize(true)
			:loadTexture(itemData.title, 1);

		item:seekNodeByName("num")
			:setString(":" .. itemNum);

		item:seekNodeByName("icon")
			:ignoreContentAdaptWithSize(true)
			:loadTexture(itemData.icon, 1);
	end

	local itemCon = self:seekNodeByName("itemCon")
						:grid(itemControlList, {column=#itemControlList, space={x=60, y=0,},});

	ccs.Armature:create("itemReward")
	   :addTo(itemCon)
	   :setLocalZOrder(-1)
	   :play("jianglitishi")
	   :move(display.center.x, 100);
end

function showItemRewardV:onDelete()
	
end

return showItemRewardV;
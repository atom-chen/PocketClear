local cpGiftV = class("cpGiftV", require("cocos.framework.extends.UIPanel"));

function cpGiftV:onCreate(levelIndex)
	local cpGift = configCP[levelIndex].cpGift;
	local itemData = configItem[cpGift.id];

	--设置icon
	local icon = self:seekNodeByName("itemIcon")
					 :loadTexture(itemData.icon, 1);

	--设置数量
	icon:seekNodeByName("num")
		:setString(cpGift.num);
		
	--设置道具名字
	icon:seekNodeByName("name")
		:ignoreContentAdaptWithSize(true)
		:loadTexture(itemData.title, 1);

	--设置道具价值
	icon:seekNodeByName("value")
		:setString(cpGift.value);
		
	--设置领取按钮
	self:seekNodeByName("getBtn")
		:onTouch(function(event)
			if ("ended"==event.name) then
				self:sendCustomEvent(configMsg.cpGift, function()
					local item = display.newSprite("#" .. itemData.icon)
										:addTo(self.root)
										:centerTo(self.root, cc.p(0, 0));
										
					local startPos = item:convertToWorldSpace(cc.p(0, 0));
                    local endPos = cc.p(display.size.width*0.7, 0);
                    
                    local spawnActions = {}; --并发动作表
                    local poses = cc.getPosesInArc(startPos, endPos); --弧形动作
                    local spline = cc.CardinalSplineBy:create(0.8, poses, 0);
                    local easeSpline = cc.EaseInOut:create(spline, 1.0);
                    table.insert(spawnActions, easeSpline);
                    local rotate = cc.RotateBy:create(0.8, -360); --旋转动作
                    table.insert(spawnActions, rotate);
                    local scale = cc.ScaleTo:create(0.8, 0.4); --缩放动作
                    table.insert(spawnActions, scale);
                    
                    local actions = {}; --动作表
                    table.insert(actions, cc.Spawn:create(spawnActions));
                    table.insert(actions, cc.CallFunc:create(function(item)
                        item:hide();
                        self:close();
                    end));
                    item:runAction(cc.Sequence:create(actions));
				end);
			end
		end);
end

function cpGiftV:onDelete()
end

return cpGiftV;
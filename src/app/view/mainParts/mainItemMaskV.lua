local mainItemMaskV = class("mainItemMaskV");

mainItemMaskV.ZOrder = 10;

function mainItemMaskV:ctor(id, root)
	self.root = root;

	--设置棋盘格Z
	self.root:seekNodeByName("con")
		:setLocalZOrder(self.ZOrder+1);

	--设置遮罩
	self.parent = ccui.Layout:create()
					   :setBackGroundColorType(1)
					   :setBackGroundColor(cc.c3b(0, 0, 0))
					   :setBackGroundColorOpacity(180)
					   :setContentSize(display.size)
					   :addTo(self.root:seekNodeByName("root"), 10)
					   :setTouchEnabled(true)
					   :onTouch(function(event)
					   		if ("ended" == event.name) then
								self:dector();
							end
					   end);

	--道具设置
	local itemData = configItem[id];
	
	--道具图标
	display.newSprite("#" .. itemData.icon)
		   :addTo(self.parent)
		   :setScale(1.4)
		   :move(display.size.width*0.2, display.size.height*0.9);

	--道具名字
	display.newSprite("#" .. itemData.title)
		   :addTo(self.parent)
		   :setScale(1.3)
		   :setAnchorPoint(cc.p(0, 0))
		   :move(display.size.width*0.4, display.size.height*0.91);
		   
	--道具描述
	display.newSprite("#" .. itemData.des)
		   :addTo(self.parent)
		   :setScale(1.4)
		   :setAnchorPoint(cc.p(0, 0))
		   :move(display.size.width*0.4, display.size.height*0.87);
end

function mainItemMaskV:dector()
	self.root:sendCustomEvent(configMsg.main_itemUsingOnoff, {nil, function()
		self.root.itemBar.mask = nil;
		self.root.itemBar:removeColorPan();
		self.parent:removeSelf();
	end});
end

return mainItemMaskV;
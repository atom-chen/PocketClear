local mainItemM = class("mainItemM");

function mainItemM:ctor(model)
	self.M = model; --mainM

	--道具栏配置
	self.M.useItems = clone(self.M.cpData.useItem); 

	--道具ID-道具栏索引
	self.M.itemID_ItemBarIndex = {};
	for i=1, #self.M.useItems do
		local itemID = self.M.useItems[i].id;
		self.M.itemID_ItemBarIndex[itemID] = i;
	end

	self.tempItems = {}; --临时道具,出关卡删除,不存档。{[id]={num=x,}, ...}
	self.isUsing = nil; --道具是否在使用中
	
	--增加临时道具
	self.M:addCustomEvent(configMsg.main_increaseTempItem, function(event)
		local id, num, callBack = unpack(event._usedata);
		local index = self:modifyTempItems(id, num);
		if (callBack) then
			callBack(index);
		end
	end);

	--使用道具
	self.M:addCustomEvent(configMsg.main_useItem, function(event)
		local id, call = unpack(event._usedata);
		
		--修改道具数量
		repeat
			local sumNum, tempNum = self:getItemNum(id);
			if (sumNum <= 0) then
				break;
			end
			
			if (tempNum > 0) then
				call(self:modifyTempItems(id, -1));
			else
				self.M:useItem(id, 1);
			end
		until true
	end);

	--道具使用中
	self.M:addCustomEvent(configMsg.main_itemUsingOnoff, function(event)
		local id, callBack = unpack(event._usedata);
		self.isUsing = id; --道具是否正在使用中
		callBack(); --视图回调
	end);
end

function mainItemM:modifyTempItems(id, num)
	if (nil == self.tempItems[id]) then
		self.tempItems[id] = {num=0,};
	end
	
	self.tempItems[id].num = self.tempItems[id].num + num;
	if (self.tempItems[id].num < 0) then
		self.tempItems[id].num = 0;
	end

	return self.M.itemID_ItemBarIndex[id];
end

function mainItemM:getItemNum(id)
	local num = self.M:getDataByKey({"item", id, "num"});

	local tempNum = 0;
	if (self.tempItems[id]) then
		tempNum = self.tempItems[id].num or 0;
	end

	return num+tempNum, tempNum;
end

function mainItemM:getIndexByItemID(id)
	return self.M.itemID_ItemBarIndex[id];
end

function mainItemM:isUsingItem()
	return self.isUsing;
end

--====================================使用道具
function mainItemM:item25(element) --彩虹糖
	if (ELEMENT.CUBE ~= element:get("type")) then
		return false;
	end
	
	return true, true, self.M:delAround(self.M:findAllSameColorCube(element));
end

function mainItemM:item26(element) --换色刷
	if (ELEMENT.CUBE ~= element:get("type")) then
		return false;
	end

	return true, false, element;
end

function mainItemM:item29(element) --小木槌
	return true, true, self.M:delAround({element,});
end

function mainItemM:item30(element) --糖果炸弹
	if (ELEMENT.CUBE ~= element:get("type")) then
		return false;
	end
	return true, false, self.M:changeElement2Other(element, "30@3@1");
end

return mainItemM;
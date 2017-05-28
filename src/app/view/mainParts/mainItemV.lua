local ContextPanel = require("app.context.contextPanel");
local Shader = require("app.tool.shader");

local mainItemV = class("mainItemV");

mainItemV.size = {
	original = cc.size(display.size.width, 177),
	extend = cc.size(864, 177),
};

function mainItemV:ctor(model, root)
	self.M = model; --mainM
	self.root = root; --主场景结点

	self.bottom = self.root:seekNodeByName("bottom"); --道具栏
	self.sv = self.bottom:seekNodeByName("sv"); --滑动条

	self.itemCons = {}; --道具容器
	self.mainLockItems = configLockItem["main"]; --三消场景道具栏关卡限制配置
	self.maxCP = self.M:getDataByKey("maxCP"); --最大通关数

	--设置道具栏里面内容
	self:setItemBar();

	--设置道具栏滑动
	self.svInnerSize = self.size.original;
	self.sv:setInnerContainerSize(self.svInnerSize);

	--添加or使用永久性道具
	self.root:addCustomEvent(configMsg.data_update, function(event)
		if ("table" == type(event._usedata)) then
			local key, id = unpack(event._usedata);
			local index = self.M.itemBar:getIndexByItemID(id);
			if (nil ~= index) then
				self:updateItemBar(index);
			end
		end
	end);
end

function mainItemV:setItemBar()
	local limitItems = self.M:getDataByKey("useItems");
	for i=1, #limitItems do
		local id = limitItems[i].id;
		local helper = limitItems[i].helper;
		
		--设置控件
		self.bottom:seekNodeByName("itemCon" .. i) 
				   :setTag(id)
				   :insertToTable(self.itemCons);

		--设置道具视图
		local itemData = configItem[id];
		self.itemCons[#self.itemCons]
			:seekNodeByName("item")
			:setSpriteFrame(itemData.icon);
			
		--关卡限制
		local limitCP = self.mainLockItems[i];
		if (limitCP) and ((self.maxCP+1)>=limitCP) then
			--设置通关神器
			if (helper) then 
				self.itemCons[#self.itemCons]
					:seekNodeByName("helper")
					:show();
			end
			
			--设置道具数量
			self:updateItemBar(#self.itemCons);
		else
			--设置道具锁
			local lockFont = self.itemCons[#self.itemCons]
								 :seekNodeByName("lockFont")
								 :show();

			--设置限制关卡数
			lockFont:seekNodeByName("lockIndex")
					:setString(limitCP);
		end
	end
end

function mainItemV:updateItemBar(index)
	self.itemCons[index]:removeEventTouchOne();
	local itemID = self.itemCons[index]:getTag();
	local itemNum, tempNum = self.M.itemBar:getItemNum(itemID);

	--设置限制次数并抹灰
	local limitUseFlag = false;
	local items = self.M:getDataByKey("useItems");
	if (nil~=items[index].limit)
		and (items[index].limit <= 0) then
		limitUseFlag = true;
		Shader:color(self.itemCons[index], cc.c3b(0.299, 0.587, 0.114));
	end
	
	if (itemNum > 0) then
		--购买按钮隐藏
		self.itemCons[index]
			:seekNodeByName("addBtn")
			:hide();

		--道具数量
		self.itemCons[index]
			:seekNodeByName("num")
			:show()
			:setString(itemNum);

		--免费标签
		self.itemCons[index]
				:seekNodeByName("free")
				:setVisible(tempNum>0);

		if (not limitUseFlag) then
			self.itemCons[index]
				:onTouchOne(function(node)
					if (self.M:isLock()) then
						return;
					end
					
					--使用道具
					local method = self["useItem" .. itemID];
					if (nil ~= method) then
						if (nil ~= items[index].limit) then
							items[index].limit = items[index].limit - 1;
							if (items[index].limit <= 0) then
								items[index].limit = 0;
							end
						end
						method(self);
					end
				end);
		end
	else
		--道具数量隐藏
		self.itemCons[index]
			:seekNodeByName("num")
			:hide();

		--免费标签隐藏
		self.itemCons[index]
			:seekNodeByName("free")
			:hide();
			
		if (not limitUseFlag) then
			local function openBuyUI()
				ContextPanel:create("CPBuyItem", itemID)
							:getV()
							:registerCloseCallback(function()
								require("app.context.contextPoint")
									:create("notenoughItem");
							end);
			end

			--购买按钮
			self.itemCons[index]
				:seekNodeByName("addBtn")
				:setLocalZOrder(10)
				:show()
				:onTouch(function(event)
					if ("ended" == event.name) then
						openBuyUI();
					end
				end);

			--道具栏
			self.itemCons[index]
				:onTouchOne(function(node)
					openBuyUI();
				end);
		else
			self.itemCons[index]
				:seekNodeByName("addBtn")
				:hide();
		end
	end
end

function mainItemV:flexItemBar(actionType, action)
	repeat
		local fileName, actionName, normalName = nil, nil, nil;
		local triggerValue = 0;
		if (ACTION.STEP == actionType) then
			triggerValue = 5;
			fileName, actionName, normalName = "actionStep", "jia5buchuxian", "jia5bunormal";
		elseif (ACTION.TIME == actionType) then
			triggerValue = 30;
			fileName, actionName, normalName = "actionTime", "jia30miaochuxian", "jia30miaonormal";
		end

		if (action < triggerValue) then
			break;
		end

		local size = nil;
		if (action == triggerValue) then
			size = self.size.extend;

			--设置行动力道具提示
			local sixCon = self.itemCons[#self.itemCons];
			local sixArmature = sixCon:seekNodeByName("sixArmature");
			if (nil == sixArmature) then
				local itemView = sixCon:seekNodeByName("num");
				local itemViewZ = itemView:getLocalZOrder();
				sixArmature = ccs.Armature:create(fileName)
								 :setName("sixArmature")
								 :addTo(sixCon, 0)
								 :centerTo(sixCon);
			end

			sixArmature:show()
					   :play(actionName, function(sender)
					   	sender:play(normalName);
					   end);
			sixCon:seekNodeByName("item")
				  :hide();
		elseif (action > triggerValue) then
			size = self.size.original;
		end

		if (self.svInnerSize.width==size.width) then
			break;
		end

		self.svInnerSize = size;
		self.sv:setInnerContainerSize(self.svInnerSize)
			   :scrollToRight(0.8, true);
	until true
end

--====================================使用道具
function mainItemV:sendUseItemMsg(id) --道具使用并且刷新道具栏
	local msgArr = {};
	table.insert(msgArr, id);
	table.insert(msgArr, function(index)
		self:updateItemBar(index);
	end);
	self.root:sendCustomEvent(configMsg.main_useItem, msgArr);
end

function mainItemV:sendUsingItemMsg(id) --前置准备道具使用(小木槌,换色刷,糖果炸弹,彩虹糖)
	self.root:sendCustomEvent(configMsg.main_itemUsingOnoff, {id, function()
		self:openMask(id);
	end});
end

function mainItemV:usingItemSuccess(id, callBack, datas)
	if (26 ~= id) then --换色刷除外
		self:sendUseItemMsg(id);
		
		if (nil ~= self.mask) then
			self.mask:dector();
			self.mask = nil;
		end
	end
	
	local method = self["useItem" .. id .. "Success"];
	if (nil ~= method) then
		method(self, callBack, datas);
	end
end

function mainItemV:openMask(id)
	local targetPlatform = cc.Application:getInstance():getTargetPlatform();
	if (cc.PLATFORM_OS_WINDOWS == targetPlatform) then
		package.loaded["app.view.mainParts.mainItemMaskV"] = nil;
	end
	
	self.mask = require("app.view.mainParts.mainItemMaskV")
						:create(id, self.root);
end

--加五步
function mainItemV:useItem22()
	self.root:sendUpdateActionMsg(ACTION.STEP, 5);
	self:usingItemSuccess(22);
end

--时光机
function mainItemV:useItem24()
	self.root:sendUpdateActionMsg(ACTION.TIME, 30);
	self:usingItemSuccess(24);
end

--刷新
function mainItemV:useItem23()
	self.root:sendResetMsg();
	self:usingItemSuccess(23);
end

--彩虹糖
function mainItemV:useItem25() 
	self:sendUsingItemMsg(25);
end

function mainItemV:useItem25Success(callBack, delList)
	callBack();
	
	--渲染彩虹糖特效
	local id, count = nil, 1;
	id = golbal.scheduler(function(dt)
		local model = delList[count][2];

		self.root:getViewInPool("mainEffect", function()
			return ccs.Armature:create("cbEffect")
						:addTo(self.root.con, 1010);
		end)
			:setRotation(math.random(0, 359))
			:move(self.root:getPosByGrid(model:get("index")))
			:play("runhengxiang", function(sender)
				self.root:returnViewToPool("mainEffect", sender);
			end);

		if (count >= #delList) then
			golbal.removeScheduler(id);
			id = nil;
			self.root:sendUnlockMsg();
		end

		count = count + 1;
	end, 0, false);
end

--换色刷
function mainItemV:useItem26() 
	self:sendUsingItemMsg(26);
end

function mainItemV:useItem26Success(_, opElement)
	self:removeColorPan();

	local cpData = self.M:getDataByKey("cpData");
	local elementProb = cpData.elementProb.init;
	if (nil==elementProb)or(nil==next(elementProb)) then
		elementProb = cpData.elementProb.default;
	end

	--生成选择色块
	local viewsSize, viewList = cc.size(0, 0), {};
	for i=1, #elementProb do
		repeat
			local key = elementProb[i].type;
			if (key == opElement:get("key")) then
				break;
			end
			
			local view = golbal.createElement(key)
							   :setName(key)
							   :insertToTable(viewList)
							   :onTouchOne(function(node)
							   	opElement:changeColor(node:getName()); --改变颜色
							   	self.root:get(opElement:get("index"), opElement:get("viewLayer"))
							   			 :updateShape(); --更新视图
							   	self:sendUseItemMsg(26); --使用道具
							   	self.mask:dector(); --关闭道具说明

							   	local msgArr = {};
							   	table.insert(msgArr, opElement:get("index"));
							   	table.insert(msgArr, function(delList)
							   		self.root:delElements(delList);
							   		self.root:sendOnDropMsg();
							   	end);
							   	self.root:sendCustomEvent(configMsg.main_afterUseColorBrush, msgArr);
							   end);

			local viewS = view:getRealSize();
			viewsSize.width = viewsSize.width + viewS.width;
			viewsSize.height = viewS.height;
		until true
	end

	--生成容器
	local colorPanPos = cc.p(0, 0);
	local gridPos = cc.p(self.root:getPosByGrid(opElement:get("index")));
	local halfViewWidth = (viewsSize.width+golbal.chessBoard.pixW)/2.0;
	local rightDistance = display.size.width-gridPos.x; --右侧
	local leftDistance = gridPos.x-halfViewWidth; --左侧
	if (rightDistance < halfViewWidth) then
		colorPanPos = cc.pAdd(gridPos, cc.p(-((viewsSize.width+golbal.chessBoard.pixW)-rightDistance), 0));
	elseif (leftDistance < 0) then
		colorPanPos = cc.pAdd(gridPos, cc.p(0, 0));
	else
		colorPanPos = cc.pAdd(gridPos, cc.p(-halfViewWidth, 0));
	end

	self.colorPan = ccui.Layout:create()
						:addTo(self.root.con, 1020)
						:move(colorPanPos)
						:setBackGroundColorType(ccui.LayoutBackGroundColorType.solid)
						:setBackGroundColor(cc.c3b(0, 0, 0))
						:setBackGroundColorOpacity(140)
						:setContentSize(cc.size(viewsSize.width+60, viewsSize.height+20))
						:grid(viewList, {column=#viewList, space={x=10, y=0,}, offsetS=cc.size(0, 0)});
end

function mainItemV:removeColorPan()
	if (nil ~= self.colorPan) then
		self.colorPan:removeSelf();
		self.colorPan = nil;
	end
end

--小木槌
function mainItemV:useItem29() 
	self:sendUsingItemMsg(29);
end

function mainItemV:useItem29Success(callBack, delList)
	local model = delList[#delList][2];
	local index = model:get("index");
	local viewLayer = model:get("viewLayer");
	
	--播放动画
	ccs.Armature:create("hammer")
				:addTo(self.root.con, 1010)
				:move(cc.pAdd(cc.p(self.root:getPosByGrid(index)), cc.p(40, 20)))
				:play("chuizi_DH", function(armature)
					self.root:sendUnlockMsg();
					callBack();
					armature:removeSelf();
				end);
				
	--播放音效
	self.root:delayCall(0.55, function()
		audio.playSound(unpack(configAudio.sound_20));
	end);
end

--糖果炸弹
function mainItemV:useItem30() 
	self:sendUsingItemMsg(30);
end

function mainItemV:useItem30Success(_, bomb)
	self.root:changeElement2Other(bomb);
end

return mainItemV;
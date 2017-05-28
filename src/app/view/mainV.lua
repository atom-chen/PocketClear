--==========================================================
--						MainV
--==========================================================
local ObjectPool = require("app.tool.objectPool");
local ContextScene = require("app.context.contextScene");
local ContextPanel = require("app.context.contextPanel");

local mainV = class("mainV", cc.Scene);

mainV.comboShow = {
	5, --num
	{"good", "great", "amazing", "excellent", "unbelievable",}, --armature
	{"sound_12", "sound_13", "sound_14", "sound_15", "sound_16",}, --audio
};

function mainV:onCreate()
	--控件
	self.top = self:seekNodeByName("top");
	self.bottom = self:seekNodeByName("bottom");
	self.score = self:seekNodeByName("score");
	self.scoreBar = self:seekNodeByName("scoreBar");
	self.con = self:seekNodeByName("con");
	self.actionCon = self:seekNodeByName("action");

	--定时器id表
	self.schedulerList = {};
	
	--任务模块
	self.task = require("app.view.mainParts.mainTaskV")
						:create(self.M:getDataByKey("task"), self);
	
	--行动力
	self.action = require("app.view.mainParts.mainActionV")
						:create(self.M, self);

	--道具栏
	self.itemBar = require("app.view.mainParts.mainItemV")
						:create(self.M, self);
	
	--角色栏
	local roleName = self.M:getDataByKey("cpData").task.name;
	self.role = require("app.view.mainParts.role." .. roleName .. "V")
						:create(self.M, self);
	
	--视图对象的对象池
	-- self.pool = {grid={}, ...}
	self.pool = {};

	--每个格子的元素视图
	--self.grids = {[0] = {[0]=view0, [1]=view1, ...}, ...};
	self.grids = {};
	
	--初始化界面
	self:initPanel();

	--棋盘格初始化
	self:initChessBoard();

	--设置红包时间显示
	self:setRedTime();

	--N秒无操作进行提示
	self.noneOpCueRemainTime = golbal.noneOpCueLTime;

	--允许掉落标记
	self.dropEnable = true; --颜色制造机之类的元素适用

	--使用道具不更新步数标记
	self.noUpdateAction = false;
end

function mainV:onDelete()
    if (nil ~= self.scoreBarID) then
    	golbal.removeScheduler(self.scoreBarID);
		self.scoreBarID = nil;
    end
end

function mainV:onLoadingEnd()
	--打开任务提示
	local function popTaskCue()
		if (nil ~= self.tempItemsmask) then
			self.tempItemsmask:removeSelf();
		end
		
		ContextPanel:create("taskCue", self.M:getDataByKey("cpData").task, 
	    					self.task)
					:getV()
					:registerCloseCallback(function()
						local function ready()
							self:sendCustomEvent(configMsg.main_begin);
		    				require("app.context.contextGuide")
		    					:create(self.M:getDataByKey("cpIndex"), 1);
		    				require("app.context.contextPoint")
								:create("gameBox");
						end
						
						if (ACTION.TIME == self.M.action.type) then
							audio.playSound(unpack(configAudio.sound_26));
							ccs.Armature:create("cbEffect")
										:addTo(self)
										:centerTo(self)
										:play("g321go", ready);
						else
							ready();
						end
					end);
	end
	
	--关卡面板购买道具
	local tempItems = self.M:getDataByKey("tempItems");
	if (nil==tempItems)or(0==table.nums(tempItems)) then
		popTaskCue();
	else
		local function itemMove(src, dst, call, dstOffset)
			local srcPos = cc.p(src:getPosition());

			local dstSize = dst:getContentSize();
			dstOffset = dstOffset or cc.p(dstSize.width/2.0, dstSize.height/2.0);
			local dstPos = self.tempItemsmask:convertToNodeSpace(dst:convertToWorldSpace(dstOffset));

			local spawnActions = {}; --并发动作表
			table.insert(spawnActions, cc.EaseInOut:create(cc.MoveBy:create(0.5, cc.pSub(dstPos, srcPos)), 1.0));
			table.insert(spawnActions, cc.ScaleTo:create(0.5, 0.01));

			local actions = {}; --动作表
			table.insert(actions, cc.Spawn:create(spawnActions));
			if (nil ~= call) then
				table.insert(actions, cc.CallFunc:create(call));
			end
			src:runAction(cc.Sequence:create(actions));
		end

		--道具运动
		local item = {
			_33 = function(view, endCall) --加三步
				itemMove(view, self.actionCon, function()
					local msgArr = {};
					table.insert(msgArr, 3);
					table.insert(msgArr, function()
						if (nil ~= endCall) then
							endCall();
						end
					end);
					table.insert(msgArr, function(action)
						self.action:update(action);
					end);
					self:sendCustomEvent(configMsg.main_increaseAction, msgArr);
				end);
			end,

			_34 = function(view, endCall) --直线与爆炸
				--隐藏临时道具
				view:hide();
				
				--生成炸弹与直线
				self:sendCustomEvent(configMsg.main_lineAndBomb, function(lineAndBombList)
					for i=1, #lineAndBombList do
						local model = lineAndBombList[i];
						
						--生成元素
						local elementV = golbal.createElement(model:get("key"))
											:addTo(self.tempItemsmask)
											:move(view:getPosition());
											 
						--元素动画
						itemMove(elementV, self.con, function()
							self:removeElement(model:get("index"), 
											   model:get("viewLayer"));
							self:createElement(model);

							if (i == #lineAndBombList) then
								if (nil ~= endCall) then
									endCall();
								end
							end
						end, cc.p(self:getPosByGrid(model:get("index"))));
					end
				end);
			end,

			_35 = function(view, endCall) --加15秒
				itemMove(view, self.actionCon, function()
					local msgArr = {};
					table.insert(msgArr, 15);
					table.insert(msgArr, function()
						if (nil ~= endCall) then
							endCall();
						end
					end);
					table.insert(msgArr, function(action)
						self.action:update(action);
					end);
					self:sendCustomEvent(configMsg.main_increaseAction, msgArr);
				end);
			end,
			
			_23 = function(view, endCall) --刷新
				local dstCtr = self:seekNodeByName("itemCon1");
				itemMove(view, dstCtr, function()
					self:sendCustomEvent(configMsg.main_increaseTempItem, {23, 1, function(index)
						self.itemBar:updateItemBar(index);
					end});

					if (nil ~= endCall) then
						endCall();
					end
				end);
			end,
		};
		
		--临时道具遮罩
		self.tempItemsmask = ccui.Layout:create()
							 :addTo(self)
							 :setContentSize(display.size)
							 :setBackGroundColorType(1)
							 :setBackGroundColor(cc.c3b(0, 0, 0))
							 :setBackGroundColorOpacity(180);

		--临时道具视图初始化
		local tempItemsViewList = {};
		for k, v in pairs(tempItems) do
			if (v) then
				local itemData = configItem[k];
				local view = display.newSprite("#" .. itemData.icon)
									:addTo(self.tempItemsmask)
									:insertToTable(tempItemsViewList);
				view.id = k;
			end
		end
		self.tempItemsmask:grid(tempItemsViewList, {column=#tempItemsViewList, space={x=40, y=0,}, offsetS=cc.size(0, 0)});
 		
		--临时道具动画
		self:delayCall(0.5, function()
			self.tempItemsID = golbal.scheduler(function(dt)
				local view = table.remove(tempItemsViewList);
				if (nil == view) then
					golbal.removeScheduler(self.tempItemsID);
					self.tempItemsID = nil;
					return;
				end

				local method = item["_" .. view.id];
				if (method) then
					if (0 == #tempItemsViewList) then
						method(view, popTaskCue);
					else
						method(view);
					end
				end
			end, 0, false);
		end);
	end

	--方块开局的由小变大动画
	for index, _ in pairs(self.grids) do
		local cube = self:get(index, ELEMENT_VIEW_LAYER.OCCUPY);
		if (nil ~= cube) then
			cube:scaleTo(0.5, 1.0);
		end
	end
end

function mainV:step(dt)
	--游戏中状态时,每帧更新
	if (nil~=self.M)and(self.M:getDataByKey("state")==CPSTATE.GAMEING) then
		--时间关卡触发倒计时刷新
		self:sendUpdateActionMsg(ACTION.TIME, -dt);

		--经过一段时间没操作, 提示删除方块
		self.noneOpCueRemainTime = self.noneOpCueRemainTime - dt;
		if (self.noneOpCueRemainTime <= 0) then
			self.noneOpCueRemainTime = golbal.noneOpCueSTime;
			self:sendCustomEvent(configMsg.main_noneOpCue, function(elementList)
				for i=1, #elementList do
					local element = self:get(elementList[i].index, ELEMENT_VIEW_LAYER.OCCUPY);
					element:runAction(cc.Repeat:create(
										cc.Sequence:create(cc.TintTo:create(0.2, 300, 300, 300), 
															cc.TintTo:create(0.2, 255, 255, 255)), 2));
				end
			end);
		end
	end
	
	--红包倒计时时间更新
	local arr = {};
	table.insert(arr, dt);
	table.insert(arr, function(time)
		--添加红包倒计时
		local redPacketIcon = self:seekNodeByName("redPacket");
		if (nil == time) then
			if (nil ~= redPacketIcon) then
				redPacketIcon:hide();
			end
		else
			local redPacketGet = redPacketIcon:seekNodeByName("getRedPacket");
			local redPacketTime = redPacketIcon:seekNodeByName("redtime");
			
			if (0 >= time) then
				redPacketGet:show();
				redPacketTime:hide();
			else
				redPacketGet:hide();
				redPacketTime:show()
					   :setString(golbal.formatTime(time, true));
			end
		end
	end);
	self:sendCustomEvent(configMsg.main_countDown, arr);
end

function mainV:insertElement(element)
	local elementModel = element:getModel();
	local index = elementModel:get("index");
	if (nil == self.grids[index]) then
		self.grids[index] = {};
	end

	local layer = elementModel:get("viewLayer");
	if (nil ~= self.grids[index][layer]) then
		return;
	end
	self.grids[index][layer] = element;
end

function mainV:removeElement(location, layer)
	local index = location;
	if ("table" == type(location)) then
		index = self.M:coord2Index(location);
	end

	if (nil == self.grids[index]) then
		return;
	end
	
	if (nil == self.grids[index][layer]) then
		return;
	end

	self:returnElementToPool(self.grids[index][layer]);
	self.grids[index][layer] = nil;
end

function mainV:getTop(location)
	local index = location;
	if ("table" == type(location)) then
		index = self.M:coord2Index(location);
	end

	local maxLayer = ELEMENT_VIEW_LAYER.MAX-1;
	for i=1, maxLayer do
		local element = self.grids[index][maxLayer-i+1];
		if (nil ~= element) then
			return element;
		end
	end
	return nil;
end

function mainV:get(location, layer)
	local index = location;
	if ("table" == type(location)) then
		index = self.M:coord2Index(location);
	end

	if (nil == self.grids[index]) then
		return nil;
	end

	return self.grids[index][layer];
end

function mainV:getPosByGrid(location)
	-- return self:get(location, ELEMENT_VIEW_LAYER.GRID):getPosition();

	if ("table" ~= type(location)) then
		location = self.M:index2Coord(location);
	end

	local pixW, pixH = golbal.chessBoard.pixW, golbal.chessBoard.pixH;
	local coord = cc.pSub(location, cc.p(self.viewRect.x, self.viewRect.y));
	local anchor = self:getAnchorPoint();
	local pos = cc.p(self.startPos.x+coord.x*pixW+anchor.x*pixW, 
					self.startPos.y+coord.y*pixH+anchor.y*pixH);
	return pos;
end

--获得从池中获得一个视图(ps:包括棋盘格元素or其他批量生成视图)
--args1: name,对象池名字
function mainV:getViewInPool(name, createFunc)
	local view = nil;
	repeat
		if (nil == name) then
			break;
		end

		if (nil == createFunc) then
			break;
		end

		if (nil == self.pool[name]) then
			self.pool[name] = ObjectPool:create(createFunc, 1);
		end
		
		view = self.pool[name]:getObject()
			     			  :show();
	until true
	return view;
end

--返还一个视图到对应的对象池
--args1: name,对象池名字
--args2: view,归还的视图
function mainV:returnViewToPool(name, view)
	repeat
		if (nil == self.pool[name]) then
			break;
		end

		if (nil == view) then
			break;
		end

		view:hide()
			:rotate(0);

		self.pool[name]:returnObject(view);
	until true
end

--获得一个指定type, viewKey
function mainV:getElementInPool(type, viewKey, parent)
	parent = parent or self.con;
	local elementIni = configElement[type];
	
	--创建改元素的对象池
	local element = self:getViewInPool(elementIni.name, function()
		return require("app.view.element." .. elementIni.name .. "V")
				:create(elementIni.view.createFunc, elementIni.name)
				:addTo(parent);
	end);
	
	if (elementIni.view[viewKey]) then
		elementIni.view[viewKey](element);
	end
	return element;
end

--返还一个元素到元素池中
function mainV:returnElementToPool(element)
	self:returnViewToPool(element.name, element);
	element:reset();
end

--在棋盘格上创建一个元素
function mainV:createElement(element, extra)
	--获得对象
	local object = self:getElementInPool(element:get("type"), element:get("viewKey"))
					   :setStartPos({self.viewRect, self.startPos})
					   :setModel(element, self, extra);
	
	--如果是格子设置触摸事件
	if (ELEMENT.GRID == element:get("type")) then
		local coord = object.M:get("coord");
		object:setTouchEnabled(true)
			  :onTouch(function(event)
			  	if ("ended"==event.name) then
			  		self:sendTouchMsg(coord);
				end
			  end);
	end
	
	--添加进容器表
	self:insertElement(object);
	return object;
end

function mainV:moveElement(src, srcElement)
	local srcIndex = src;
	if ("table" == type(src)) then
		srcIndex = self.M:coord2Index(src);
	end

	local layer = srcElement:getModel():get("viewLayer");
	self.grids[srcIndex][layer] = nil;
	self:insertElement(srcElement);
end

function mainV:initPanel()
	--当前关卡
	local curIndex = self.M:getDataByKey("cpIndex");

	--设置当前背景
	if (curIndex <= 21) then
		self:seekNodeByName("bg")
			:loadTexture("image/main_bg_night.png");
	end

	--初始化关卡索引
	self:seekNodeByName("index")
		:setString(curIndex);

	--初始化星星位置
	local sumHeight = self.scoreBar:getContentSize().width;
	local cpStarsData = self.M:getDataByKey("cpStarsData");
	local sumScore = cpStarsData[#cpStarsData];
	for i=1, 3 do
        local y = cpStarsData[i]/sumScore*sumHeight;
        local star = self:seekNodeByName("star" .. i)
        				 :move(0, y);
    end
    self.scoreBar:setPercent(0);
    
    --计算棋盘格开始坐标
    self.viewRect = self.M:getDataByKey("viewRect"); --棋盘格可视区域
	local pixW, pixH = golbal.chessBoard.pixW, golbal.chessBoard.pixW;
	local conSize = self.con:getContentSize();
	self.startPos = cc.p((conSize.width-(self.viewRect.width*pixW))/2.0, 
						  (conSize.height-(self.viewRect.height*pixH))/2.0); --棋盘格开始坐标
						
	--初始化暂停按钮
	self:seekNodeByName("pauseBtn")
		:onTouchOne(function(target)
			ContextPanel:create("pause");
		end);
end

function mainV:initChessBoard()
	local grids = self.M:getDataByKey("grids");
	for index, elements in pairs(grids) do
		--非空格
		for layer, element in pairs(elements) do --m:元素所在层; n:元素;
			self:createElement(element);
		end

		--设置方块初始状态为最小化
		local cube = self:get(index, ELEMENT_VIEW_LAYER.OCCUPY);
		if (nil ~= cube) then
			cube:setScale(0.01);
		end
		
		--debug信息
		if (DEBUG > 0) then
			local gridVPos = cc.p(self:get(index, ELEMENT_VIEW_LAYER.GRID):getPosition());
			ccui.TextAtlas:create(configNumber._6)
						  :setScale(0.7)
						  :addTo(self.con, 1000)
						  :move(gridVPos.x-golbal.chessBoard.pixW/2.0+14, 
						  		gridVPos.y-golbal.chessBoard.pixH/2.0+14)
						  :setString(index);
						  
			local coord = self.M:index2Coord(index);
			ccui.TextAtlas:create(configNumber._6)
						  :setScale(0.7)
						  :addTo(self.con, 1000)
						  :move(gridVPos.x+golbal.chessBoard.pixW/2.0-16, 
						  		gridVPos.y+golbal.chessBoard.pixH/2.0-16)
						  :setString(coord.x .. coord.y);
		end
	end

	self:initChessBoardEdge(grids);
end

function mainV:initChessBoardEdge(grids)
	local function getDstIndex(src, offset)
		local dst = cc.pAdd(src, offset);
		if (dst.x < 0) or (dst.x >= golbal.chessBoard.width)
			or (dst.y < 0) or (dst.y >= golbal.chessBoard.height) then
			return nil;
		end
		return self.M:coord2Index(dst);
	end

	local function getEdge(grids, src, coners, offset, cIndexs)
		local index = getDstIndex(src, offset);
		if (nil == grids[index]) then
			return nil;
		end

		local result = {};
		for i=1, #cIndexs do
			if (coners[cIndexs[i]]) then
				table.insert(result, cIndexs[i]);
			end
		end
		return result;
	end

	local function getEdge(grids, src, offset)

	end

	--包边
	local coners = { --凹凸角检查配置
		{--凹角
			--格子偏移
			{
				{--左下
					function(grids, src)
						return (nil ~= grids[getDstIndex(src, cc.p(0, -1))]);
					end,
					function(grids, src)
						return (nil ~= grids[getDstIndex(src, cc.p(-1, 0))]);
					end,
					function(grids, src)
						return (nil == grids[getDstIndex(src, cc.p(0, 0))]);
					end,
				},

				{--左上
					function(grids, src)
						return (nil ~= grids[getDstIndex(src, cc.p(0, 1))]);
					end,
					function(grids, src)
						return (nil ~= grids[getDstIndex(src, cc.p(-1, 0))]);
					end,
					function(grids, src)
						return (nil == grids[getDstIndex(src, cc.p(0, 0))]);
					end,
				},

				{--右上
					function(grids, src)
						return (nil ~= grids[getDstIndex(src, cc.p(0, 1))]);
					end,
					function(grids, src)
						return (nil ~= grids[getDstIndex(src, cc.p(1, 0))]);
					end,
					function(grids, src)
						return (nil == grids[getDstIndex(src, cc.p(0, 0))]);
					end,
				},

				{--右下
					function(grids, src)
						return (nil ~= grids[getDstIndex(src, cc.p(0, -1))]);
					end,
					function(grids, src)
						return (nil ~= grids[getDstIndex(src, cc.p(1, 0))]);
					end,
					function(grids, src)
						return (nil == grids[getDstIndex(src, cc.p(0, 0))]);
					end,
				},
			},

			--旋转角度
			{180, 270, 0, 90},

			--偏移坐标
			{cc.p(-golbal.chessBoard.pixW/2.0+4, -golbal.chessBoard.pixH/2.0+4), 
			 cc.p(-golbal.chessBoard.pixW/2.0+4, golbal.chessBoard.pixH/2.0-7),
			 cc.p(golbal.chessBoard.pixW/2.0-4, golbal.chessBoard.pixH/2.0-7), 
			 cc.p(golbal.chessBoard.pixW/2.0-4, -golbal.chessBoard.pixH/2.0+4)},

			--视图
			"#texture/main/board_inside.png"
		},

		{ --凸角
			--格子偏移
			{
				{
					function(grids, src)
						return (nil == grids[getDstIndex(src, cc.p(0, -1))]);
					end,
					function(grids, src)
						return (nil == grids[getDstIndex(src, cc.p(-1, 0))]);
					end,
					function(grids, src)
						return (nil ~= grids[getDstIndex(src, cc.p(-1, -1))]);
					end,
				},

				{
					function(grids, src)
						return (nil == grids[getDstIndex(src, cc.p(0, 1))]);
					end,
					function(grids, src)
						return (nil == grids[getDstIndex(src, cc.p(-1, 0))]);
					end,
					function(grids, src)
						return (nil ~= grids[getDstIndex(src, cc.p(-1, 1))]);
					end,
				},

				{
					function(grids, src)
						return (nil == grids[getDstIndex(src, cc.p(0, 1))]);
					end,
					function(grids, src)
						return (nil == grids[getDstIndex(src, cc.p(1, 0))]);
					end,
					function(grids, src)
						return (nil ~= grids[getDstIndex(src, cc.p(1, 1))]);
					end,
				},

				{
					function(grids, src)
						return (nil == grids[getDstIndex(src, cc.p(0, -1))]);
					end,
					function(grids, src)
						return (nil == grids[getDstIndex(src, cc.p(1, 0))]);
					end,
					function(grids, src)
						return (nil ~= grids[getDstIndex(src, cc.p(1, -1))]);
					end,
				},
			},

			--旋转角度
			{180, 270, 0, 90},

			--偏移坐标
			{cc.p(-golbal.chessBoard.pixW/2.0-4, -golbal.chessBoard.pixH/2.0-4), 
			 cc.p(-golbal.chessBoard.pixW/2.0-4, golbal.chessBoard.pixH/2.0+1),
			 cc.p(golbal.chessBoard.pixW/2.0+4, golbal.chessBoard.pixH/2.0+1), 
			 cc.p(golbal.chessBoard.pixW/2.0+4, -golbal.chessBoard.pixH/2.0-4)},

			--视图
			"#texture/main/board_outside.png",
		},
	};

	local edges = {
		{
			--左边
			function(grids, src, coners)
				if (nil == grids[getDstIndex(src, cc.p(-1, 0))]) then
					return;
				end

				local conner = {};

				--左下拐角
				if ((nil==grids[getDstIndex(src, cc.p(-1, -1))])and(nil==grids[getDstIndex(src, cc.p(0, -1))])
					or (nil ~= grids[getDstIndex(src, cc.p(0, -1))])) then
					table.insert(conner, 1);
				end

				--左上拐角
				if ((nil==grids[getDstIndex(src, cc.p(-1, 1))])and(nil==grids[getDstIndex(src, cc.p(0, 1))])
					or (nil ~= grids[getDstIndex(src, cc.p(0, 1))])) then
					table.insert(conner, 2);
				end

				return conner;
			end,

			--上边
			function(grids, src, coners)
				if (nil == grids[getDstIndex(src, cc.p(0, 1))]) then
					return;
				end

				local conner = {};

				--右下拐角
				if ((nil==grids[getDstIndex(src, cc.p(1, 1))])and(nil==grids[getDstIndex(src, cc.p(1, 0))])
					or (nil ~= grids[getDstIndex(src, cc.p(1, 0))])) then
					table.insert(conner, 2);
				end

				--左下拐角
				if ((nil==grids[getDstIndex(src, cc.p(-1, 1))])and(nil==grids[getDstIndex(src, cc.p(-1, 0))])
					or (nil ~= grids[getDstIndex(src, cc.p(-1, 0))])) then
					table.insert(conner, 3);
				end

				return conner;
			end,

			--右边
			function(grids, src, coners)
				if (nil == grids[getDstIndex(src, cc.p(1, 0))]) then
					return;
				end

				local conner = {};

				--右上拐角
				if ((nil==grids[getDstIndex(src, cc.p(1, 1))])and(nil==grids[getDstIndex(src, cc.p(0, 1))])
					or (nil ~= grids[getDstIndex(src, cc.p(0, 1))])) then
					table.insert(conner, 3);
				end

				--右下拐角
				if ((nil==grids[getDstIndex(src, cc.p(1, -1))])and(nil==grids[getDstIndex(src, cc.p(0, -1))])
					or (nil ~= grids[getDstIndex(src, cc.p(0, -1))])) then
					table.insert(conner, 4);
				end

				return conner;
			end,

			--下边
			function(grids, src, coners)
				if (nil == grids[getDstIndex(src, cc.p(0, -1))]) then
					return;
				end

				local conner = {};

				--左上拐角
				if ((nil==grids[getDstIndex(src, cc.p(-1, -1))])and(nil==grids[getDstIndex(src, cc.p(-1, 0))])
					or (nil ~= grids[getDstIndex(src, cc.p(-1, 0))])) then
					table.insert(conner, 4);
				end

				--右上拐角
				if ((nil==grids[getDstIndex(src, cc.p(1, -1))])and(nil==grids[getDstIndex(src, cc.p(1, 0))])
					or (nil ~= grids[getDstIndex(src, cc.p(1, 0))])) then
					table.insert(conner, 1);
				end

				return conner;
			end,
		},

		--左,上,右,下
		{0, 90, 0, 90},

		--图片
		{"#texture/main/board_edge0.png", "#texture/main/board_edge0.png", "#texture/main/board_edge2.png",},

		--偏移
		{cc.p(-golbal.chessBoard.pixW/2.0, 0), 
		 cc.p(0, golbal.chessBoard.pixH/2.0-3), 
		 cc.p(golbal.chessBoard.pixW/2.0, -2), 
		 cc.p(0, -golbal.chessBoard.pixH/2.0), },
	};

	local startGrid, curGrid = cc.p(-1, -1), cc.p(-1, -1);
	local row, column = (golbal.chessBoard.width+2), (golbal.chessBoard.height+2);
	local num = row * column;
	for i=0,  num-1 do
		local x = i % row;
		if (0 == x) and (0 ~= i) then
			curGrid.x = startGrid.x;
			curGrid.y = curGrid.y+1;
		end
		curGrid = cc.p(startGrid.x+x, curGrid.y);
		
		local curGridPos = self:getPosByGrid(curGrid);
		local conerMask = {};

		--角
		for j=1, #coners do
			local offsets, rotate, offsetPos, path = unpack(coners[j]);
			for k=1, #offsets do
				local conerFlag = true;
				for m=1, #offsets[k] do
					if (not offsets[k][m](grids, curGrid)) then
						conerFlag = false;
						break;
					end
				end

				if (conerFlag) then
					display.newSprite(path)
						   :addTo(self.con)
						   :move(cc.pAdd(curGridPos, offsetPos[k]))
						   :rotate(rotate[k]);
					conerMask[k] = true;
				end
			end
		end

		--边
		if (nil == grids[getDstIndex(curGrid, cc.p(0, 0))]) then
			local offsets, rotate, imgs, offsetPos = unpack(edges);
			for j=1, #offsets do
				local result = offsets[j](grids, curGrid, conerMask);
				if (nil ~= result) then
					display.newSprite(imgs[#result+1])
						   :addTo(self.con)
						   :move(cc.pAdd(curGridPos, offsetPos[j]))
						   :rotate(rotate[j]);
				end
			end
		end
	end
end

function mainV:delElements(delList)
	--删除音效
	audio.playSound(unpack(configAudio.sound_34));
	
	--删除,合成,更新元素
	local increaseScore = 0;
	for i=1, #delList do
		repeat
			--更新棋盘格元素(删除, 创建, 更新)
			local op, model, score, extra = unpack(delList[i]);
			local index, viewLayer = model:get("index"), model:get("viewLayer");
			if (ELEMENT_OP.DEL == op) then
				self:removeElement(index, viewLayer);

				if (ELEMENT.LUCKYBAG == model:get("type")) then
					local viewList = {};
					for i=1, #extra do
						local view = self:getElementInPool(extra[i]:get("type"), extra[i]:get("viewKey"))
										:move(self:get(index, ELEMENT_LAYER.GRID):getPosition())
										:setScale(0.1)
								   	    :setLocalZOrder(1000)
								   	    
					   	local dstView = self:get(extra[i]:get("index"), ELEMENT_VIEW_LAYER.GRID);
						table.insert(viewList, {view, dstView, extra[i]});
					end

					self.dropEnable = false;
					local schedulerID, count = nil, #viewList;
					schedulerID = self:addScheduler(function(dt)
						local group = table.remove(viewList);
						if (nil == group) then
							self:removeSchedulerByID(schedulerID);
							schedulerID = nil;
							return;
						end
						
						local view, dstView, model = unpack(group);
						local startPos = view:convertToWorldSpaceAR(cc.p(0, 0));
						local endPos = dstView:convertToWorldSpaceAR(cc.p(0, 0));
						
						local spawnActions = {}; --并发动作表
						local poses = cc.getPosesInArc(startPos, endPos); --弧形动作
						local spline = cc.CardinalSplineBy:create(0.6, poses, 0);
						local easeSpline = cc.EaseInOut:create(spline, 1.0);
						table.insert(spawnActions, easeSpline);
						local rotate = cc.RotateBy:create(0.6, -360); --旋转动作
						table.insert(spawnActions, rotate);
						local scale = cc.ScaleTo:create(0.6, 1.0); --缩放动作
						table.insert(spawnActions, scale);
						
						local actions = {}; --动作表
						table.insert(actions, cc.Spawn:create(spawnActions));
						table.insert(actions, cc.CallFunc:create(function()
							self:sendUnlockMsg();
							self:returnElementToPool(view);
							if (ELEMENT_LAYER.OCCUPY == model:get("layer")) then
								self:changeElement2Other(model); --设置为攻击元素
							else
								self:createElement(model);
							end
							
							count = count - 1;
							if (0 == count) then
								self.dropEnable = true;
							end
						end));
						view:runAction(cc.Sequence:create(actions));
					end, 0, false);
				end
			elseif (ELEMENT_OP.CREATE == op) then
				if (ELEMENT.COLORMACHINE == model:get("type")) then
					local viewList = {};
					for i=1, #extra do
						local view = self:getElementInPool(extra[i]:get("type"), extra[i]:get("viewKey"))
										:move(self:get(index, viewLayer):getPosition())
										:setScale(0.1)
								   	    :setLocalZOrder(1000)
					   	local dstView = self:get(extra[i]:get("index"), extra[i]:get("viewLayer"));
						table.insert(viewList, {view, dstView});
					end

					self.dropEnable = false;
					local schedulerID, count = nil, #viewList;
					schedulerID = self:addScheduler(function(dt)
						local group = table.remove(viewList);
						if (nil == group) then
							self:removeSchedulerByID(schedulerID);
							schedulerID = nil;
							return;
						end

						local view, dstView = unpack(group);
						local startPos = view:convertToWorldSpaceAR(cc.p(0, 0));
						local endPos = dstView:convertToWorldSpaceAR(cc.p(0, 0));
						
						local spawnActions = {}; --并发动作表
						local poses = cc.getPosesInArc(startPos, endPos); --弧形动作
						local spline = cc.CardinalSplineBy:create(0.6, poses, 0);
						local easeSpline = cc.EaseInOut:create(spline, 1.0);
						table.insert(spawnActions, easeSpline);
						local rotate = cc.RotateBy:create(0.6, -360); --旋转动作
						table.insert(spawnActions, rotate);
						local scale = cc.ScaleTo:create(0.6, 1.0); --缩放动作
						table.insert(spawnActions, scale);
						
						local actions = {}; --动作表
						table.insert(actions, cc.Spawn:create(spawnActions));
						table.insert(actions, cc.CallFunc:create(function()
							self:sendUnlockMsg();
							dstView:updateShape();
							self:returnElementToPool(view);
							
							count = count - 1;
							if (0 == count) then
								self.dropEnable = true;
							end
						end));
						view:runAction(cc.Sequence:create(actions));
					end, 0, false);
				else
					self:removeElement(index, viewLayer);
					self:createElement(model, extra);
				end
			elseif (ELEMENT_OP.UPDATE == op) then
				self:get(index, viewLayer):updateShape();
			end

			--渲染得分
			if (nil~=score) and (0~=score) then
				--计算增加总分
				increaseScore = increaseScore + score;

				--创建分数视图
				local ta_score = self:getViewInPool("score", function()
					return ccui.TextAtlas:create(configNumber._8)
                              			 :addTo(self.con, 1001);
				end)
									 :show()
									 :setString(score)
				 					 :move(self:getPosByGrid(index))
				 					 :setOpacity(255);

				--创建分数动画
		        local arr = {};
		        local scaleBy = cc.ScaleBy:create(0.1, 1.4);
		        local scaleByEaseIn = cc.EaseIn:create(scaleBy, 4);
		        table.insert(arr, scaleByEaseIn);
		        local reverseBy = scaleBy:reverse();
		        local reverseByEaseIn = cc.EaseIn:create(reverseBy, 4);
		        table.insert(arr, reverseByEaseIn);
		        table.insert(arr, cc.DelayTime:create(0.2));
		        table.insert(arr, cc.FadeOut:create(0.5));
		        table.insert(arr, cc.CallFunc:create(function()
		        	ta_score:setScale(1.0)
		        			:hide();
		        	self:returnViewToPool("score", ta_score);
		        end));
		        ta_score:runAction(cc.Sequence:create(arr));
			end
		until true
	end
	
	--设置分数
	local oldScore = tonumber(self.score:getString());
	local curScore = oldScore+increaseScore;
	self.score:setString(curScore);

	--设置分数进度条
	if (self.scoreBar:getPercent() < 100) then
		--记录当前增加进度
		local cpStarsData = self.M:getDataByKey("cpStarsData");
		local increasePercent = increaseScore/cpStarsData[#cpStarsData]*100;
		if (nil == self.increasePercentList) then 
			self.increasePercentList = {};
		end
		table.insert(self.increasePercentList, increasePercent);

		if (nil == self.scoreBarID) then
			local percent = 0;
			self.scoreBarID = golbal.scheduler(function(dt)
				if (0 == percent) then
					percent = table.remove(self.increasePercentList);
					if (nil == percent) then
						golbal.removeScheduler(self.scoreBarID);
						self.scoreBarID = nil;
						return;
					end
				end

				local newPercent = 0;
				if (percent > 1) then
					newPercent = self.scoreBar:getPercent() + 1;
					percent = percent - 1;
				else
					newPercent = self.scoreBar:getPercent() + percent;
					percent = 0;
				end

				if (newPercent > 100) then
					newPercent = 100;
					golbal.removeScheduler(self.scoreBarID);
					self.scoreBarID = nil;
				end
				self.scoreBar:setPercent(newPercent);
			end, 0.04, false);
		end
	end

	--设置星星
	local starNum = self.M:getDataByKey("starNum");
	if (starNum > 0) then
		for i=1, starNum do
			local star = self:seekNodeByName("star" .. i);
			if (star) and (not star.light) then
				star.light = true;
				self:delayCall(0.1, function()
					star:setSpriteFrame("texture/common/main_star.png");	
				end);

				ccs.Armature:create("starActivate")
							:addTo(star)
							:centerTo(star)
							:play("shanguang01", function(armature)
								armature:removeSelf();
							end);
			end
		end
	end

	--任务渲染
	self.task:update(delList);
end

function mainV:changeElement2Other(model)
	self:removeElement(model:get("index"), model:get("viewLayer"));
	self:createElement(model);
end

function mainV:victory()
	--发送角色状态
	self.role:setState("victory");
	
	--蜥蜴
	ccs.Armature:create("lizard")
				:addTo(self)
				:centerTo(self, cc.p(50, 0))
				:play("G2RUNjiesuanqingz", function(armature)
					armature:removeSelf();

					local maxCPIndex = self.M:getDataByKey("maxCP");
					local curCPIndex = self.M:getDataByKey("cpIndex");
					
					--全部奖励后打开胜利界面
					local function openVictory()
						audio.playSound(unpack(configAudio.sound_25));

						--弹出胜利界面
						ContextPanel:create("victory", 
									self.M:getDataByKey("score"), 
									self.M:getDataByKey("cpIndex"),
									self.M:getDataByKey("starNum"));
									
						--失败触发在线参数
						require("app.context.contextPoint")
							:create("gameWin");
					end
					
					--打开评论面板
					local function openComment()
						if (1==self.M:getDataByKey({"onoff", "sneakSkin",}))
							and (not self.M:getDataByKey("commentFlag"))
							and (self.M:getDataByKey("curDay")>=2)
							and (0==curCPIndex%2) then
							ContextPanel:create("comment", function()
								openVictory();
							end);
						else
							openVictory();
						end
					end
					
					--打开全部奖励
					-- local isGetFlipBrand = self.M:getDataByKey({"checkPoint", curCPIndex, "isGetFlipBrand"});
					-- if (0==curCPIndex%10)and(not isGetFlipBrand)then
					-- 	self.M:setDataByKey({"checkPoint", curCPIndex, "isGetFlipBrand"}, true);
					-- 	require("app.context.contextPoint")
					-- 		:create(109, {configAccountingData[2],}, {callback=function()
					-- 			openComment();
					-- 		end});
					-- else
					-- 	openComment();
					-- end
					openComment();
				end);

	--创建彩带
	cc.ParticleSystemQuad:create("colourBar")
                         :addTo(self)
                         :centerTo(self, cc.p(-80, 230));

    --播放胜利笑声
    audio.playSound(unpack(configAudio.sound_24));
end

function mainV:fail()
	--发送角色状态
	self.role:setState("fail");
	
	--加五步界面
	self:delayCall(1.0, function()
		--失败加五步界面
		ContextPanel:create("fiveStep", {self.M.action.type,}, 
				{function()
					--购买成功,增加5步
					self:sendCustomEvent(configMsg.main_failFiveStep, function()
						if (ACTION.STEP == self.M.action.type) then
							self:sendUpdateActionMsg(self.M.action.type, 5);
						elseif (ACTION.TIME == self.M.action.type) then
							self:sendUpdateActionMsg(self.M.action.type, 30);
						end
						self.role:setState("idel");
					end);
				end, function()
					--失败音效
					audio.playSound(unpack(configAudio.sound_40));

					--打开失败界面
					ContextPanel:create("fail", self.M:getDataByKey("cpIndex"));

					--失败触发在线参数
					require("app.context.contextPoint")
						:create("gameFail");
				end});
	end);
end

--=================================================
--					message
--=================================================
function mainV:sendTouchMsg(coord)
	local msgArr = {};
	table.insert(msgArr, coord); --元素二位坐标
	table.insert(msgArr, function(delList, elementType, comboCount) --删除元素
		--连击音效
		-- if (0 ~= comboCount) then
		-- 	local audios = {"sound_4", "sound_5", "sound_6",};
		-- 	audio.playSound(unpack(configAudio[audios[comboCount]]));
		-- end
		
		--删除操作
		if (ELEMENT.CUBE == elementType) then
			self:delElements(delList);
			self:sendOnDropMsg();
		else
			self:addScheduler(function(dt, id)
				local list = table.remove(delList);
				if (nil == list) then
					self:removeSchedulerByID(id);
					self:sendOnDropMsg();
					return;
				end
				self:delElements(list);
			end, 0, false);
		end

		--更新无操作提示时间
		self.noneOpCueRemainTime = golbal.noneOpCueLTime;
	end);
	table.insert(msgArr, function(datas, id) --使用道具
		self.itemBar:usingItemSuccess(id, function()
			self.noUpdateAction = true;
			self:delElements(datas);
			self:sendOnDropMsg();
		end, datas);
	end);
	self:sendCustomEvent(configMsg.main_touch, msgArr);
end

function mainV:sendOnDropMsg()
	local beginDrop = function()
		self:sendCustomEvent(configMsg.main_onDrop, function(movePathList)
			if (0 == #movePathList) then
				self:sendSmallDropEndMsg();
			else
				local moveListLen, completeMoveCount = #movePathList, 0; --移动表个数, 完成移动元素计数器
				local firstCreateElementGridY = {}; --记录该纵列第一个创建元素的Y值
				while (true) do
					local movePath = table.remove(movePathList);
					if (nil == movePath) then
						break;
					end
					
					local elementM, elementPath = movePath.element, movePath.stack;
					local startGrid, dstGrid = elementPath[1], elementPath[#elementPath];
					local element = self:get(startGrid, ELEMENT_VIEW_LAYER.OCCUPY);
					local sPos = nil; --记录元素起始坐标
					if (nil == element) then
						--生成新元素
						element = self:createElement(elementM);

						--设置新元素的坐标
						if (nil == firstCreateElementGridY[dstGrid.x]) then
							firstCreateElementGridY[dstGrid.x] = dstGrid.y;
						end
						local diffY = dstGrid.y-firstCreateElementGridY[dstGrid.x]+1;
						local gridPos = cc.p(self:getPosByGrid(startGrid));
						sPos = cc.p(gridPos.x, gridPos.y+diffY*golbal.chessBoard.pixH);

						--设置新生成元素位置
						element:move(sPos);
					else
						self:moveElement(startGrid, element); --从下落起点移动元素到目标点
					end
					
					--元素移动动画
					local moveActionArr = {};
					local ePos, lPos = nil, nil;
					for i=1, #elementPath do
						local curPos = cc.p(self:getPosByGrid(elementPath[i]));
						if (nil == sPos) then
							sPos = curPos;
						else
							if (nil~=lPos) and (lPos.x ~= curPos.x) then
								ePos = lPos;

								--直线动作
								local distanceY = sPos.y - ePos.y;
								if (0 ~= distanceY) then
									local consumeTime = (distanceY/golbal.chessBoard.pixH)*0.15;
									local ease = cc.EaseIn:create(cc.MoveBy:create(consumeTime, cc.p(0, -distanceY)), 2.0);
									table.insert(moveActionArr, ease);
								end
								
								--斜线动作
								local consumeTime = (golbal.chessBoard.pixO/golbal.chessBoard.pixH)*0.15;
								if (lPos.y < curPos.y) then
									ePos = cc.p(curPos.x, curPos.y+80);
									table.insert(moveActionArr, cc.CallFunc:create(function()
										element:move(curPos.x, curPos.y+80);
									end));
								end
								-- local ease = cc.EaseIn:create(cc.MoveBy:create(consumeTime, cc.pSub(curPos, ePos)), 2.0);
								local ease = cc.EaseIn:create(cc.MoveBy:create(0.1, cc.pSub(curPos, ePos)), 2.0);
								table.insert(moveActionArr, ease);

								sPos = curPos;
								ePos = nil;
							else
								if (i == #elementPath) then
									local distanceY = sPos.y - curPos.y;
									if (0 ~= distanceY) then
										local consumeTime = (distanceY/golbal.chessBoard.pixH)*0.15;
										if (consumeTime > 0.6) then
											consumeTime = 0.6;
										end
										local ease = cc.EaseIn:create(cc.MoveBy:create(consumeTime, cc.p(0, -distanceY)), 2.0);
										table.insert(moveActionArr, ease);
									end
								end
							end
						end
						lPos = curPos;
					end
					
					--移动完毕回调动作
					table.insert(moveActionArr, cc.CallFunc:create(function()
						--停止下落,更新层次
						element:updateLayer();
						
						--所有元素移动完毕判断
					   	completeMoveCount = completeMoveCount + 1;
						if (completeMoveCount == moveListLen) then --掉落完毕
							self:sendSmallDropEndMsg();
						end
					end));

					element:setLocalZOrder(1000-dstGrid.y)
						   :runAction(cc.Sequence:create(moveActionArr));
				end
			end
		end);
	end

	--当有颜色制造机这类元素时，让他元素飞完了在开始掉落
	local schedulerID = nil;
	schedulerID = self:addScheduler(function()
		if (self.dropEnable) then
			beginDrop();
			self:removeSchedulerByID(schedulerID);
			schedulerID = nil;
		end
	end, 0, false);
end

function mainV:sendSmallDropEndMsg()
	self:sendCustomEvent(configMsg.main_smallDropEnd, function(state, delLists, comboCount)
		if (nil~=delLists)and(nil~=next(delLists)) then
			self:addScheduler(function(dt, id)
			local delList = table.remove(delLists);
				if (nil == delList) then
					self:removeSchedulerByID(id);
					self:sendOnDropMsg();
					return;
				end
				self:delElements(delList);
			end, 0, false);
		else
			if (CPSTATE.BONUSTIME == state) then
				self:sendRoundEndMsg();
			else
				self:sendBigDropEnd(comboCount);
			end
		end
	end);
end

function mainV:sendBigDropEnd(comboCount)
	--更新行动力
	if (not self.noUpdateAction) then
		self:sendUpdateActionMsg(ACTION.STEP, -1);
	else
		self.noUpdateAction = false;
	end
	
	--播放下落音效
	audio.playSound(unpack(configAudio.sound_33));

	--combo变现触发
	if (comboCount >= 2) then
		local max, armatures, audios = unpack(self.comboShow);
		
		--combo展示索引
		local showIndex = comboCount-1;
		if (showIndex > max) then
			showIndex = max;
		end
		
		--特效触发
		self:getViewInPool("mainEffect", function()
			return ccs.Armature:create("cbEffect")
					  :addTo(self:getLayer("panelLayer"));
		end)
			:centerTo(self:getLayer("panelLayer"))
			:play(armatures[showIndex], function(armature)
				self:returnViewToPool("mainEffect", armature);
			end);
			
		--音效触发
		audio.playSound(unpack(configAudio[audios[showIndex]]));
	end

	--掉落结束之后善后, 解锁, 沥青运动, 重置棋盘格
	self:sendCustomEvent(configMsg.main_bigDropEnd, {function(delLists)
		if (nil~=delLists)and(nil~=next(delLists)) then
			for i=1, #delLists do
				self:delElements(delLists[i]);
			end
		end
	end, function(state, elements)
		self.role:roundEnd(state, elements);
	end});

	self:sendUnlockMsg();
end

function mainV:sendUnlockMsg()
	self:sendCustomEvent(configMsg.main_unlock, function(isReset)
		--解锁成功, 是否需要重置
		if (isReset) then
			self:delayCall(0.01, function()
				self:sendResetMsg();
			end);
		else
			self:sendRoundEndMsg();
		end
	end);
end

function mainV:sendRoundEndMsg()
	self:sendCustomEvent(configMsg.main_roundEnd, function(state, step)
		if (CPSTATE.VICTORY == state) then
			self:sendCustomEvent(configMsg.main_settle);
			self:victory();
		elseif (CPSTATE.BONUSTIME == state) then
			self:runAction(cc.Sequence:create(cc.CallFunc:create(function()
				audio.playSound(unpack(configAudio.sound_23)); --胜利音效
			end), cc.DelayTime:create(1.0), cc.CallFunc:create(function()
				audio.playSound(unpack(configAudio.sound_22)); --bonustime音效

				--播放闯关成功动画
				ccs.Armature:create("cbEffect")
				   :addTo(self, 1002)
				   :centerTo(self)
				   :play("bonustime", function(armature)
				   		armature:removeSelf();
				   		if (step > 0) then
							self:sendBonustimeMsg();
						else
							self:sendRoundEndMsg();
						end
				    end);
			end)));
		end
	end);
end

function mainV:sendResetMsg()
	self:sendCustomEvent(configMsg.main_reset, function(indexPairList)
		local _30pixpers = 0.04; --移动30像素耗时
		local pixW, pixH = golbal.chessBoard.pixW, golbal.chessBoard.pixW;
		local midPos = cc.pAdd(self.startPos, cc.p(pixW*self.viewRect.width/2.0, pixH*self.viewRect.height/2.0));
		
		local count = 0;
		for i=1, #indexPairList do
			local indexPair = indexPairList[i];
			for j=1, #indexPair do
				local topElement = self:get(indexPair[j][1], ELEMENT_VIEW_LAYER.OCCUPY);
				local runningActionNum = topElement:getNumberOfRunningActions();
				if (runningActionNum > 0) then
					topElement:stopAllActions();
				end

				topElement:setLocalZOrder(1020)
						  :runAction(cc.Sequence:create(cc.MoveTo:create(0.2, midPos), cc.CallFunc:create(function(sender)
							--元素往返运动
							local arr1 = {};
							for k=1, 5 do
								local length = math.random(50, 200);
								local distance = cc.pMul(DIRVEC[math.random(1, #DIRVEC)], length);
								local moveBy = cc.MoveBy:create(math.ceil(length/30)*_30pixpers, distance);
								table.insert(arr1, moveBy);
								local moveByReverse = moveBy:reverse();
								table.insert(arr1, moveByReverse);
							end
							
							--元素在延时一段时间后统一运动到目标点
							local arr2 = {};
							table.insert(arr2, cc.DelayTime:create(1.4));
							table.insert(arr2, cc.CallFunc:create(function(sender)
								local dstPos = cc.p(self:getPosByGrid(indexPair[#indexPair-j+1][1]));
								sender:stopAllActions()
									  :runAction(cc.Sequence:create(cc.MoveTo:create(0.2, dstPos), cc.CallFunc:create(function(sender)
									  	count = count + 1;

									  	--设置移动后对应模型数据
									  	sender:setModel(indexPair[#indexPair-j+1][2]);

										--重置后自动合成
										if (count == #indexPairList) then
										  	self:sendResetEndMsg();
										end
									  end)));
							end));
							sender:runAction(cc.Spawn:create(cc.Sequence:create(arr1), cc.Sequence:create(arr2)));
						end)));
			end
		end
	end);
end

function mainV:sendResetEndMsg()
	self:sendCustomEvent(configMsg.main_resetEnd, function(delLists)
		if (nil==delLists)or(nil==next(delLists)) then --解锁屏幕
			self:sendUnlockMsg();
		else
			self:addScheduler(function(dt, id)
				local delList = table.remove(delLists);
				if (nil == delList) then
					self:removeSchedulerByID(id);
					self:sendOnDropMsg();
					return;
				end
				self:delElements(delList);
			end, 0, false);
		end
	end);
end

function mainV:sendUpdateActionMsg(actionType, value)
	local curActionType = self.M.action.type;
	if (actionType ~= curActionType) then
		return;
	end
	
	local msgArr = {};
	table.insert(msgArr, value); --行动力变化值(步数:整数值, 时间:每帧耗时)
	table.insert(msgArr, function(action) --行动更新回调
		--行动力耗尽
		if (0 == action) then
			self:sendCustomEvent(configMsg.main_actionOver);
		end

		--更新行动力
		self.action:update(action);

		--判断是否关卡失败
		local state = self.M:getDataByKey("state");
		if (CPSTATE.FAIL == state) then
			self:fail();
			return;
		end

		--根据当前行动力刷新道具栏
		self.itemBar:flexItemBar(curActionType, action);
	end);
	self:sendCustomEvent(configMsg.main_updateAction, msgArr);
end

function mainV:sendBonustimeMsg()
	--计算bonustime生成的炸弹表
	self:sendCustomEvent(configMsg.main_bonustime, function(bombList)
		local sumNum, count = #bombList, 0;

		--有剩余步数进入bonustime流程
		self:addScheduler(function(dt, id)
			local bombData = table.remove(bombList);
			if (nil == bombData) then
				self:removeSchedulerByID(id);
				return;
			end

			self:sendCustomEvent(configMsg.main_bonustimeAction, function(action)
				self.action:update(action);
			end);
			
			--获得偏转角度
			local index, model = bombData[1][2]:get("index"), bombData[1][2]; --unpack(bombData);
			local srcPos = self.con:convertToNodeSpace(self.actionCon:convertToWorldSpace(cc.p(0, 0)));
			local dstPos = cc.p(self:getPosByGrid(index));
			local angle = math.deg(cc.pGetAngle(cc.p(0, -1), cc.pSub(dstPos, srcPos)));

			local ray = self:getViewInPool("ray", function()
				return display.newSprite("#texture/main/sheguang.png")
							  :addTo(self.con, 1000);
			end)			
							:move(srcPos)
							:setAnchorPoint(cc.p(0, 0))
							:setRotation(math.pi/2-angle);

			local actionsArr = {};
			table.insert(actionsArr, cc.EaseInOut:create(cc.MoveBy:create(0.5, cc.pSub(dstPos, srcPos)), 1.0));
			table.insert(actionsArr, cc.CallFunc:create(function()
				--计数
				count = count + 1;

				--归还对象
				self:returnViewToPool("ray", ray);
				
				--设置为炸弹
				self:delElements(bombData);

				--引爆
				if (sumNum == count) then
					self:sendBonustimeExplodeMsg();
				end
			end));
			ray:runAction(cc.Sequence:create(actionsArr));
			
			--射出声音
			audio.playSound(unpack(configAudio.sound_21));
		end, 0.2, false);
	end);
end

function mainV:sendBonustimeExplodeMsg()
	self:sendCustomEvent(configMsg.main_bonustimeExplode, function(delList)
		self:addScheduler(function(dt, id)
			local list = table.remove(delList);
			if (nil == list) then
				self:removeSchedulerByID(id);
				self:sendOnDropMsg();
				return;
			end
			self:delElements(list);
		end, 0, false);
	end);
end

--设置红包
function mainV:setRedTime()
	local redIndex = self.M:getDataByKey("redIndex");
	local itemID = configRedData[redIndex];
	if (nil == itemID) then
		return;
	end
	
	local con = ccui.Layout:create()
					:setName("redPacket")
					:addTo(self.top)
					:move(450, 200)
					:setTouchEnabled(true)
					:onTouch(function(event)
						if ("ended" == event.name) then
							local time = self.M:getDataByKey({"item", itemID, "timebar"}) - os.time();
							if (time <= 0) then
								ContextPanel:create("redPacket");
							else
								event.target:seekNodeByName("armature")
											:play("nohongbao");
							end
						end
					end);
					
	local armature = ccs.Armature:create("icon")
								 :setName("armature")
								 :addTo(con)
								 :play("hongbao");
								
	con:setContentSize(armature:getContentSize());
	armature:centerTo(con);

	ccui.TextAtlas:create(configNumber._1)
				  :setName("redtime")
				  :setScale(0.75)
				  :addTo(con)
				  :centerTo(con, cc.p(0, -70));

	ccui.ImageView:create("texture/common/font_qianghongbaoziti.png", 1)
				  :setName("getRedPacket")
				  :addTo(con)
				  :centerTo(con, cc.p(0, -70));
end

return mainV;
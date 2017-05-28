--==========================================================
--						MainM
--==========================================================
local mainM = class("mainM", require("app.model.model"));

function mainM:onCreate(cpIndex, tempItems)
	--信息面板购买道具
	self.tempItems = tempItems;

	--配置数据
	self.cbData = self:getDataByKey({"ini", "configChessBoard", cpIndex}) or {}; --本关地图配置数据
	self.cpData = self:getDataByKey({"ini", "configCP", cpIndex}); --本关关卡配置数据
	self.cpStarsData = self.cpData.stars; --本关星级分布

	self.width = golbal.chessBoard.width; --宽
	self.height = golbal.chessBoard.height; --高
	self.num = self.width*self.height-1; --总数量

	self.score = 0; --获得分数
	self.starNum = 0; --获得星星数
	
	self.lock = 0; --锁屏

	self.cpIndex = cpIndex; --当前关卡
	self:setDataByKey("curCP", cpIndex);

	self.grids = {}; --当前关卡所有格子
	self.traversalIndex = {}; --在消除过程中记录所遍历过格子的索引
	self.moveElementList = nil; --移动元素表
	self.presetDropList = {}; --预设掉落表
	self.elementsMgr = nil; --元素管理器
	
	self.touchCount = 0; --点击普通方块计数
	self.comboCount = 0; --连击计数
	self.state = CPSTATE.NULL; --关卡当前状态

	self.counter_red = 0; --红包倒计时计数器
	
	--红包倒计时初始化
	local itemID = configRedData[self:getDataByKey("redIndex")];
	if (nil == itemID) then
		self.redRcoverTime = nil;
	else
		self.redRcoverTime = self:getDataByKey({"item", itemID, "timebar"})-os.time();
	end

	--初始化关卡相关数据
	self:initCPData();

	--初始化棋盘格
	self:initChessBoard();

	--初始化索引池
	self.indexPool = {};
	for index, _ in pairs(self.grids) do
		table.insert(self.indexPool, index);
	end
	
	--事件注册初始化
	self:initCustomEvent();

	--任务相关
	self.task = require("app.model.mainParts.mainTaskM") --任务模块
						:create(self);

	--行动力
	self.action = require("app.model.mainParts.mainActionM")
						:create(self);
	
	--道具栏
	self.itemBar = require("app.model.mainParts.mainItemM")
						:create(self);
							
	--任务角色
	self.role = require("app.model.mainParts.role." .. self.cpData.task.name .. "M")
						:create(self);
	self.role:setCurRound(self.action.action);
						
	--初始化元素管理器
	--(针对开局没有创建但是需要管理的元素)
	if (nil ~= self.cpData.task.limit) 
		and (TASK.COLLECT == self.cpData.task.type) then
		for i=1, #self.cpData.task.limit do
			local key = self.cpData.task.limit[i].type;
			local elementIni = self:getElementIni(key);
			self:createElementsMgr(elementIni.name);
		end
	end

	--当前关卡失败后有没有使用观看视频加五步
	self.fiveStepADFlag = false;

	--统计数据
	golbal.sendCustomEvent(configMsg.dataCount_startLevel, {self.cpIndex});
end

function mainM:onDelete()
	if (self.fiveStepADFlag) then
		golbal.playVideoAD();
	end

	--统计数据
	if (CPSTATE.VICTORY == self.state) 
		or (CPSTATE.BONUSTIME == self.state)then
		golbal.sendCustomEvent(configMsg.dataCount_finishLevel, {self.cpIndex});
	else
		golbal.sendCustomEvent(configMsg.dataCount_failLevel, {self.cpIndex});
	end
end

function mainM:initCPData()
	--初始化元素几率
	self.elementProb = {};
	for k, v in pairs(self.cpData.elementProb) do
		repeat
			if (nil == next(v)) then
				break;
			end

			self.elementProb[k] = {sumProb=0, pool={},};
			for i=1, #v do
				self.elementProb[k].sumProb = self.elementProb[k].sumProb + v[i].prob;
				table.insert(self.elementProb[k].pool, {v[i].type, self.elementProb[k].sumProb});
			end
		until true
	end

	if (nil == self.elementProb["default"]) then
		self.elementProb["default"] = {
			sumProb=60, 
			pool = {
				{"1@1@1", 10},{"1@1@2", 10},{"1@1@3", 10},
				{"1@1@4", 10},{"1@1@5", 10},{"1@1@6", 10},
			};
		};
	end
end

function mainM:initCustomEvent()
	--开始消息
	self:addCustomEvent(configMsg.main_begin, function(event)
		self.state = CPSTATE.GAMEING;
	end);

	--炸弹与直线生成
	self:addCustomEvent(configMsg.main_lineAndBomb, function(event)
		local elementIniPool = {{"30@1", "30@3",}, {"30@2", "30@3",},};
		local elementInis = elementIniPool[math.random(1, #elementIniPool)];

		local lineAndBombList = {};
		for i=1, #elementInis do
			local cube = self:getOnlyCubeInGrid();
			local index = cube:get("index");

			self:removeElement(cube);
			local newElement = self:createElment(elementInis[i], index);
			table.insert(lineAndBombList, newElement);
		end

		event._usedata(lineAndBombList);
	end);
	
	--触碰消息
	self:addCustomEvent(configMsg.main_touch, function(event)
		if (self.state ~= CPSTATE.GAMEING) then
			return;
		end

		if (self:isLock()) then
			return;
		end

		self.traversalIndex = {}; --开始检查, 重置检查表
		local coord, callBack, usingItemCallBack = unpack(event._usedata);
				
		local element = self:getTop(coord);
		if (nil == element) then
			return;
		end

		local elementType = element:get("type");
		repeat
			--使用道具
			local usingItemID = self.itemBar:isUsingItem();
			if (nil ~= usingItemID) then
				--使用道具
				local method = self.itemBar["item" .. usingItemID];
				if (nil == method) then
					break;
				end

				--道具使用后返回数据
				local res, isLock, datas = method(self.itemBar, element);
				if (not res) then --操作不成功
					break;
				end

				if (isLock) then
					self:modifyLock(2);
				end

				--视图回调
				usingItemCallBack(datas, usingItemID);
				break;
			end
			
			--判断点击坐标元素类型
			if (ELEMENT.CUBE~=elementType)
				and (ELEMENT.BOMB~=elementType) then
				break;
			end

			--设置角色当前轮
			self.role:setCurRound(self.action.action);

			--删除元素
			local delList = nil;
			if (ELEMENT.CUBE == elementType) then
				local sameColors = self:findSameColorCube(element);
				local sameColorsNum = #sameColors;
				
				if (#sameColors<golbal.chessBoard.minCubeDelNum) then
					break;
				end

				if (sameColorsNum >= 6) then
					self.touchCount = 3;
				elseif (sameColorsNum >= 4) then
					self.touchCount = 2;
				else
					self.touchCount = 1;
				end
				delList = self:delAround(sameColors); --删除元素
			else
				delList = self:explode(element);
			end

			--删除完毕善后
			self:modifyLock(1);
			callBack(delList, elementType, self.touchCount); --view回调
		until true
	end);

	--掉落
	self:addCustomEvent(configMsg.main_onDrop, function(event)
		self.traversalIndex = {};

		--寻找路径
		local function find(origin)
			--return code 0:成功; 1:失败; 2:返回当前后置与目标格;
			local preGrid, hasCheckMap = nil, {};
			local pathStack = {{grid=origin, traverse=0,},};
			hasCheckMap[self:coord2Index(origin)] = true;

			local traverseOrder = {cc.p(0, 0), cc.p(-1, 0), cc.p(1, 0)}; --先移动到目标排再做便宜,节点偏移(上, 左上, 右上)
			while (true) do
				local node = pathStack[#pathStack];
				if (nil == node) then
					break;
				end
				
				local isFind = false;

				--检测顶层元素是否为阻挡
				local top = self:getTop(node.grid);
				if (nil~=top)and(ELEMENT_MOTION.BLOCK==top:get("motion")) then
					--1.弹出当前格,
					table.remove(pathStack);
				else
					--占格元素
					local occupy = self:get(node.grid, ELEMENT_LAYER.OCCUPY);
					if (nil == occupy) then
						local grid = self:get(node.grid, ELEMENT_LAYER.GRID);
						if (GRID.CREATE == grid:get("subType")) then
							--找到!!!!!!!!!!!!!!!!!!!!
							isFind = true;
						end
					else
						if (ELEMENT_MOTION.MOVE == occupy:get("motion")) then
							--看是否斜向查找
							if (node.oblique) then
								local sonGrid_Down = node.grid;
								while (true) do
									sonGrid_Down = cc.pAdd(sonGrid_Down, cc.p(0, -1));
									if (not self:checkCoord(sonGrid_Down)) then
										break;
									end

									if (self:isBlock(sonGrid_Down)) then
										break;
									end
									
									local occupy = self:get(sonGrid_Down, ELEMENT_LAYER.OCCUPY);
									if (nil == occupy) then
										return 2, sonGrid_Down; --返回,寻路失败,有前置格!!!!!!!!!!!!
									end
								end
							end

							--找到!!!!!!!!!!!!!!!!!!!!
							isFind = true;
						else
							table.remove(pathStack);
						end
					end
				end

				if (isFind) then
					local path = {};
					for i=1, #pathStack do
						table.insert(path, 1, pathStack[i].grid);
					end
					return 0, path; --寻路成功!!!!!!!!!!!!!!!!!!
				end
				
				--2.判断栈顶格子分支格子是否遍历完毕
				--3.if (true)
				--		4.goto 1;
				--	else
						--5.栈顶格子换向,
						--6.压入换向后的格子
				--	end
				while (true) do
					if (nil == next(pathStack)) then
						break;
					end

					local topNode = pathStack[#pathStack];
					if (topNode.traverse == #traverseOrder) then
						table.remove(pathStack);
					else
						topNode.traverse = topNode.traverse + 1;

						local sonGrid, cutoffFlag = nil, false;
						local gridElement = self:get(topNode.grid, ELEMENT_LAYER.GRID);
						if (GRID.CUTOFF == gridElement:get("subType")) then
							local index = gridElement:get("pointToIndex");
							sonGrid = cc.pAdd(traverseOrder[topNode.traverse], self:index2Coord(index));
							cutoffFlag = true;
						else
							local offset = cc.pAdd(traverseOrder[topNode.traverse], cc.p(0, 1));
							sonGrid = cc.pAdd(offset, topNode.grid);

							--查看当前的斜上是否为隔断格子
							if (topNode.grid.x ~= sonGrid.x) then
								local sonGrid_Down = cc.pAdd(sonGrid, cc.p(0, -1));
								local sonGrid_DownElement = self:get(sonGrid_Down, ELEMENT_LAYER.GRID);
								if (nil~=sonGrid_DownElement)
									and(GRID.CUTOFF == sonGrid_DownElement:get("subType")) then
									local index = sonGrid_DownElement:get("pointToIndex");
									sonGrid = self:index2Coord(index);
									cutoffFlag = true;
								end
							end
						end
						
						if (not hasCheckMap[self:coord2Index(sonGrid)])
							and (self:checkCoord(sonGrid)) then
							hasCheckMap[self:coord2Index(sonGrid)] = true;

							local obliqueFlag = (topNode.grid.x~=sonGrid.x);
							if (cutoffFlag) then
								obliqueFlag = false;
							end
							table.insert(pathStack, {grid=sonGrid, traverse=0, oblique=obliqueFlag,});
							break;
						end
					end
				end

				if (nil==next(pathStack)) then
					return 1; --返回,寻路失败!!!!!!!!!!!!
				end
			end
		end

		--在移动路径表中寻找是否存在首尾相接的路径,有并合并
		local function getCombineIndex(list, sGrid)
			for i=1, #list do
				local eGrid = list[i].stack[#list[i].stack];
				if (eGrid.x==sGrid.x)
					and(eGrid.y==sGrid.y) then
					return i;
				end
			end
			return nil;
		end
		
		--计算空格表
		local emptyGridList, gridsLen = {}, self.width*self.height-1;
		for i=0, gridsLen do
			repeat
				local index = gridsLen-i;
				local elements = self.grids[index];
				if (nil == elements) then
					break;
				end
				
				local element = self:get(index, ELEMENT_LAYER.OCCUPY);
				if (nil == element) then
					table.insert(emptyGridList, index); --空格的索引,等待格子的索引
				end
			until true
		end
		
		local pathCombineList = {}; --路径合并表
		local movePathList = {}; --当前所有需要移动元素移动路径表
		if (nil == self.moveElementList) then
			self.moveElementList = {}; --移动元素表	
		end
		
		while (true) do
			local emptyIndex = table.remove(emptyGridList);
			if (nil == emptyIndex) then
				break;
			end
			
			local result, stack = find(self:index2Coord(emptyIndex));
			if (0 == result) then
				local stackLen = #stack;
				local startGrid, dstGrid = stack[1], stack[stackLen];
				
				--移动元素
				local startElement = self:get(startGrid, ELEMENT_LAYER.OCCUPY);
				if (nil == startElement) then --生成新元素
					local newKey = table.remove(self.presetDropList);
					if (nil == newKey) then
						newKey = self:randomElmentKey("drop");
					end
					startElement = self:createElment(newKey, self:coord2Index(dstGrid));
				else
					table.insert(emptyGridList, self:coord2Index(startGrid));
					table.sort(emptyGridList, function (e1, e2)
						return e1 > e2;
					end);
					self:moveElement(startElement, dstGrid);
				end

				--合并路径
				local combineIndex = getCombineIndex(movePathList, startGrid);
				if (nil ~= combineIndex) then
					local path = table.remove(movePathList, combineIndex).stack;
					for i=2, #stack do
						table.insert(path, stack[i]);
					end
					stack = path;
				else
					table.insert(self.moveElementList, 1, startElement); --构建移动元素表
				end
				table.insert(movePathList, 1, {element=startElement, stack=stack,}); --构建移动更新表
			elseif (2 == result) then
				local preIndex, index = self:coord2Index(stack), nil;
				for i=1, #emptyGridList do
					if (preIndex == emptyGridList[i]) then
						index = i;
						break;
					end
				end

				if (nil ~= index) then
					table.insert(emptyGridList, index, emptyIndex);
				end
			end
		end
		
		event._usedata(movePathList);
	end);
	
	--掉落结束
	self:addCustomEvent(configMsg.main_smallDropEnd, function(event)
		if (CPSTATE.BONUSTIME == self.state) then
			event._usedata(self.state);
		else
			local delLists = {};
			while (true) do
				local element = table.remove(self.moveElementList);

				--移动表检测完毕
				if (nil == element) then
					--元素管理器轮循
					if (nil ~= self.elementsMgr) then
						for k, v in pairs(self.elementsMgr) do
							if (v.loop) then
								local delList = v:loop();
								if (nil~=delList)and(nil~=next(delList)) then
									table.insert(delLists, delList);
								end
							end
						end
					end

					event._usedata(self.state, delLists, self.comboCount);
					break;
				end

				--检查是否自动合成炸弹
				repeat
					if (1 == self.cpIndex) then
						break;
					end
					
					if (self.traversalIndex[element:get("index")]) then
						break;
					end

					if (ELEMENT.CUBE ~= element:get("type")) then
						break;
					end

					--检测合成炸弹
					local result, bombKey, shape, origin = self:isBirthBomb(element:get("color"), element:get("coord"));
					if (not result) then
						break;
					end
					
					--合成炸弹,设置数据
					self.comboCount = self.comboCount+self.touchCount+1;
					element.createData = {bombKey, {shape, origin, self.comboCount,},};
					local delList = self:delAround(self:findSameColorCube(element));
					table.insert(delLists, delList);
				until true
			end
		end
	end);

	--掉落结束后善后
	self:addCustomEvent(configMsg.main_bigDropEnd, function(event)
		local delCall, roleCall = unpack(event._usedata);

		--角色攻击
		local state, elements = self.role:roundEnd();
		if (nil ~= state) then
			if ("bear" == self.cpData.task.name) then
				state = self.comboCount;
			end
			roleCall(state, elements);
		end
		
		local delLists = {};
		-- 元素管理器轮循结束(沥青)
		if (nil ~= self.elementsMgr) then
			for k, v in pairs(self.elementsMgr) do
				if (v.loopEnd) then
					local delList = v:loopEnd();
					if (nil~=delList)and(nil~=next(delList)) then
						table.insert(delLists, delList);
					end
				end
			end
		end
		delCall(delLists);
	end);

	--锁屏结束,判断是否需要重置棋盘格
	self:addCustomEvent(configMsg.main_unlock, function(event)
		self:modifyLock(-1);
		if (not self:isLock()) then
			self.traversalIndex = {};
			self.touchCount = 0;
			self.comboCount = 0;
			
			event._usedata(self:isReset());
		end
	end);

	--本轮结束
	self:addCustomEvent(configMsg.main_roundEnd, function(event)
		if (CPSTATE.GAMEING==self.state)
			and (self.task.complete) then
			self.state = CPSTATE.BONUSTIME;
			if (self.cpIndex<=golbal.directBegin) then
				self.action.action = 0;
			end
		elseif (CPSTATE.BONUSTIME == self.state) then
			self.state = CPSTATE.VICTORY;
		end
		event._usedata(self.state, self.action.action);
	end)

	--元素重排
	self:addCustomEvent(configMsg.main_reset, function(event)
		self:modifyLock(1);

		--计算抽取池
		local indexPool = {};
		for index, _ in pairs(self.grids) do
			repeat
				local top = self:getTop(index);
				if (nil == top) then
					break;
				end

				if (ELEMENT.CUBE ~= top:get("type")) then
					break;
				end
				
				table.insert(indexPool, {index, top,});
			until true
		end

		local indexPairList = {};
		while (true) do
			--抽取一对元素的索引
			local indexPair = {};
			for i=1, 2 do
				local uplimit = #indexPool;
				if (uplimit <= 0) then
					break;
				end

				local arrayIndex = math.random(1, #indexPool);
				table.insert(indexPair, table.remove(indexPool, arrayIndex));
			end
			
			if (0 == #indexPair) then
				break;
			elseif (1 == #indexPair) then
				table.insert(indexPair, indexPair[#indexPair]);
			end

			--交换数据
			local oneIndex, oneModel = unpack(indexPair[1]);
			local otherIndex, otherModel = unpack(indexPair[2]);
			self:insertElement(oneIndex, otherModel);
			self:insertElement(otherIndex, oneModel);
			table.insert(indexPairList, indexPair);
		end
		event._usedata(indexPairList);
	end);

	--重排结束后自动合成
	self:addCustomEvent(configMsg.main_resetEnd, function(event)
		--重置结束后,生成炸弹
		self.comboCount = 0;
		local delLists = {};
		for index, _ in pairs(self.grids) do
			local top = self:getTop(index);
			if (nil~=top)and(ELEMENT.CUBE==top:get("type")) then
				--检测合成炸弹
				local result, bombKey, shape, origin = self:isBirthBomb(top:get("color"), top:get("coord"));
				if (result) then
					--合成炸弹,设置数据
					self.comboCount = self.comboCount+self.touchCount+1;
					top.createData = {bombKey, {shape, origin, self.comboCount,},};
					local delList = self:delAround(self:findSameColorCube(top));
					table.insert(delLists, delList);
				end
			end
		end

		event._usedata(delLists);
	end);
	
	--bonustime生成
	self:addCustomEvent(configMsg.main_bonustime, function(event)
		self.state = CPSTATE.BONUSTIME; --设置游戏状态为bonustime
		self.score = self.score+self.action.action*1000; --设置游戏bonustime得分

		--生成导弹
		local bombList, bombInis = {}, {"30@1@1", "30@2@1",};
		for i=1, self.action.action do
			local cube = self:getOnlyCubeInGrid();
			if (nil == cube) then
				break;
			end
			
			local bombKey = bombInis[math.random(1, #bombInis)];
			local bomb = self:createElment(bombKey, cube:get("index"));
			table.insert(bombList, {{ELEMENT_OP.CREATE, bomb, 1000, nil},});
		end

		event._usedata(bombList);
	end);
	
	--bonutime引爆
	self:addCustomEvent(configMsg.main_bonustimeExplode, function(event)
		self.traversalIndex = {};
		local bombList = {};
		for index, _ in pairs(self.grids) do
			local element = self:getTop(index);
			if (nil~=element)and(ELEMENT.BOMB==element:get("type")) then
				table.insert(bombList, element);
			end
		end
		event._usedata(self:explode(bombList, true));
	end);

	--结算
	self:addCustomEvent(configMsg.main_settle, function(event)
		--存档星星总数
		local curStarNum = self:getDataByKey({"checkPoint", self.cpIndex, "star"}) or 0;
		self:modifyDataByKey(golbal.star(), self.starNum-curStarNum);
		self:setDataByKey({"checkPoint", self.cpIndex, "star"}, self.starNum); --存档星级
		self:setDataByKey({"checkPoint", self.cpIndex, "score"}, self.score); --存档分数
		if (self.cpIndex == (self:getDataByKey("maxCP")+1)) then
			self:modifyDataByKey("maxCP", 1);
		end
		
		--存档倒霉熊奇幻之旅任务数据
		for i=1, #configTrip do
			local _, cpIndex = unpack(configTrip[i]);
			if (cpIndex == self.cpIndex) then
				--检测该关卡任务是否完成
				local endTime = self:getDataByKey({"tripTask", i, "endTime"});
				if (endTime ~= 0) then
					self:setDataByKey({"tripTask", i, "endTime"}, 0);
					self:setDataByKey({"tripTask", i, "complete"}, true);
				end

				--检测下一个关卡是否激活
				if ((i+1)<=(#configTrip)) then
					local startTime = self:getDataByKey({"tripTask", i+1, "startTime"});
					local curTime = os.time();
					if (curTime < startTime) then
						self:setDataByKey({"tripTask", i+1, "startTime"}, curTime);
					end
				end
				break;
			end
		end
	end);
	
	--行动力消耗完毕
	self:addCustomEvent(configMsg.main_actionOver, function(event)
		if (not self.task.complete) then
			self.state = CPSTATE.FAIL;
		end
	end);

	--失败后加5步or加30秒
	self:addCustomEvent(configMsg.main_failFiveStep, function(event)
		self:modifyLock(-1);
		self.state = CPSTATE.GAMEING;
		event._usedata();
	end);

	--设置红包倒计时
	self:addCustomEvent(configMsg.main_countDown, function(event)
		local dt, callback = unpack(event._usedata);

		self.counter_red = self.counter_red + dt;
		if (self.counter_red < 1) then
			return;
		end
		self.counter_red = 0;
		
		repeat
			if (nil ~= self.redRcoverTime) then
				self.redRcoverTime = self.redRcoverTime - 1;	
			end
			callback(self.redRcoverTime);
		until true
	end);

	--换色刷使用完成后,是否合成炸弹检测
	self:addCustomEvent(configMsg.main_afterUseColorBrush, function(event)
		local index, callback = unpack(event._usedata);

		local element = self:get(index, ELEMENT_LAYER.OCCUPY);
		local result, bombKey, shape, origin = self:isBirthBomb(element:get("color"), element:get("coord"));
		if (result) then
			element.createData = {bombKey, {shape, origin, 1,},};
			local delList = self:delAround(self:findSameColorCube(element));
			callback(delList);
		end
	end);

	--监控抢红包
	self:addCustomEvent(configMsg.redGetDiamond, function(event)
		local redIndex = self:getDataByKey("redIndex");
		local itemID = configRedData[redIndex];
		if (nil == itemID) then
			self.redRcoverTime = nil;
		else
			self.redRcoverTime = self:getDataByKey({"item", itemID, "timebar"})-os.time();
		end
	end);
	
	--监控无操作提示
	self:addCustomEvent(configMsg.main_noneOpCue, function(event)
		local enableDelList = self:isChessBoardDelEnable();
		if (nil ~= enableDelList) then
			event._usedata(enableDelList);
		end
	end);
end

function mainM:index2Coord(index)
	return cc.p(index%self.width, math.floor(index/self.width));
end

function mainM:coord2Index(coord)
	return self.width*coord.y+coord.x;
end

--是否为非激活格子
function mainM:isUnactive(location)
	local index = location;
	if ("table" == type(location)) then
		index = self:coord2Index(location);
	end

	if (nil == self.grids[index]) then
		return true;
	end
	return false;
end

function mainM:checkCoord(coord)
	if (coord.x < 0) or (coord.x >= self.width)
		or (coord.y < 0) or (coord.y >= self.height) then
		return false;
	end

	if (self:isUnactive(coord)) then
		return false;
	end

	return true;
end

--获取一个元素的配置数据
function mainM:getElementIni(key)
	local arr = string.split(key, "@");
	local elementIni = configElement[arr[1]];
	return elementIni;
end

--获得一个格子且格子中只有方块
function mainM:getOnlyCubeInGrid(checkLayer)
	local cube, tempIndexPool = nil, clone(self.indexPool);
	while (true) do
		local index = table.remove(self.indexPool, math.random(1, #self.indexPool));
		if (nil == index) then
			break;
		end

		repeat
			if (self.traversalIndex[index]) then
				break;
			end

			local topElement = self:getTop(index);
			if (nil == topElement) then
				break;
			end
			
			if (nil ~= checkLayer) then
				local element = self:get(index, checkLayer);
				if (nil ~= element) then
					break;
				end
			end

			if (ELEMENT.CUBE ~= topElement:get("type")) then
				break;
			end
			
			local gridElement = self:get(index, ELEMENT_LAYER.GRID);
			if (GRID.CREATE == gridElement:get("subType")) then
				break;
			end

			self.traversalIndex[index] = true;
			cube = topElement;
		until true
		
		if (nil ~= cube) then
			break;
		end
	end
	
	self.indexPool = tempIndexPool;
	return cube;
end

--获得颜色制造机能投掷的格子
function mainM:getCubeForColorMachine(color)
	local cube, tempIndexPool = nil, clone(self.indexPool);
	while (true) do
		local random = math.random(1, #self.indexPool);
		local index = table.remove(self.indexPool, math.random(1, #self.indexPool));
		if (nil == index) then
			break;
		end

		repeat
			if (self.traversalIndex[index]) then
				break;
			end

			local topElement = self:getTop(index);
			if (nil == topElement) then
				break;
			end

			if (ELEMENT.CUBE ~= topElement:get("type")) then
				break;
			end

			if (color == topElement:get("color")) then
				break;
			end
			
			self.traversalIndex[index] = true;
			cube = topElement;
		until true

		if (nil ~= cube) then
			break;
		end
	end
	
	self.indexPool = tempIndexPool;
	return cube;
end

--把一个元素变成另外一个元素
function mainM:changeElement2Other(element, otherKey)
	local index = element:get("index"); --保存改元素的索引
	self:removeElement(element); --删除数据
	local newElement = self:createElment(otherKey, index); --生成新数据
	return newElement;
end

--创建元素管理器
function mainM:createElementsMgr(eName)
	if (nil == self.elementsMgr) then
		self.elementsMgr = {};
	end

	if (nil ~= self.elementsMgr[eName]) then
		return false;
	end

	local path = "app/model/mainParts/elementMgr/" .. eName  .. "Mgr" .. luaPostfix;
	if (not cc.FileUtils:getInstance():isFileExist(path)) then
		return false;
	end
	self.elementsMgr[eName] = require(path):create(self);
	return true;
end

--添加元素进对应的元素管理器
function mainM:addToElementsMgr(element)
	local createFlag = true;
	local name = element:get("name");
	if (nil == self.elementsMgr)
		or (nil == self.elementsMgr[name]) then
		createFlag = self:createElementsMgr(name);
	end
	
	if (not createFlag) then
		return;
	end

	if (nil == self.elementsMgr[name]) then
		return;
	end
	
	self.elementsMgr[name]:add(element);
end

--从元素管理器删除元素
function mainM:removeFromElementsMgr(element)
	if (nil == self.elementsMgr) then
		return;
	end
	
	local name = element:get("name");
	if (nil == self.elementsMgr[name]) then
		return;
	end

	self.elementsMgr[name]:remove(element);
end

function mainM:modifyLock(value)
	self.lock = self.lock + value;
	if (self.lock < 0) then
		self.lock = 0;
	end
end

function mainM:isLock()
	return (self.lock>0);
end

--==========================================对格子数据操作
function mainM:randomElmentKey(type)
	local filter = self.elementProb[type];
	if (nil == filter) then
		filter = self.elementProb["default"];
	end

	local resultKey = nil;
	local value = math.random(1, filter.sumProb);
	for i=1, #filter.pool do
		local key, up = unpack(filter.pool[i]);
		if (value <= up) then
			resultKey = key;
			break;
		end
	end

	return resultKey;
end

function mainM:createElmentOnly(key, location)
	local index = location;
	if ("table" == type(location)) then
		index = self:coord2Index(location);
	end
	
	--生成元素
	local elementIni = self:getElementIni(key);
	local element = require("app.model.element." .. elementIni.name .. "M")
							:create(key, elementIni);
	return element;
end

function mainM:createElment(key, location)
	local element = self:createElmentOnly(key, location); --生成元素
	self:insertElement(location, element); --插入棋盘格
	self:addToElementsMgr(element); --如果该元素有管理器则添加进管理器
	return element;
end

function mainM:insertElement(location, element)
	local index = location;
	if ("table" == type(location)) then
		index = self:coord2Index(location);
	end
	
	if (nil == self.grids[index]) then
		self.grids[index] = {};
	end

	self.grids[index][element:get("layer")] = element;
	element:setCoord(index);
end

function mainM:removeElement(element)
	local index = element:get("index");
	if (nil == self.grids[index]) then
		return;
	end

	local layer = element:get("layer");
	if (nil == self.grids[index][layer]) then
		return;
	end
	self.grids[index][layer] = nil;
	return element;
end

function mainM:moveElement(srcElement, dst)
	local removeElement = self:removeElement(srcElement);
	self:insertElement(dst, removeElement);
end

function mainM:getTop(location)
	local index = location;
	if ("table" == type(location)) then
		index = self:coord2Index(location);
	end

	if (nil == self.grids[index]) then
		return nil;
	end

	local maxLayer, decorateType = ELEMENT_LAYER.MAX-1, nil;
	for i=1, maxLayer do
		local element = self.grids[index][maxLayer-i+1];
		if (nil ~= element) then
			return element, decorateType;
		end
	end
	return nil;
end

function mainM:get(location, layer)
	local index = location;
	if ("table" == type(location)) then
		index = self:coord2Index(location);
	end

	if (nil == self.grids[index]) then
		return nil;
	end

	return self.grids[index][layer];
end

function mainM:getElementMotion(location, layer)
	local element = self:get(location, layer);
	if (nil == element) then
		return nil;
	end
	return element:get("motion");
end

function mainM:isBlock(location)
	local occupy = self:get(location, ELEMENT_LAYER.OCCUPY);
	if (nil~=occupy)and(ELEMENT_MOTION.BLOCK==occupy:get("motion")) then
		return true;
	end

	local top = self:getTop(location);
	if (nil~=top)and(ELEMENT_MOTION.BLOCK==top:get("motion")) then
		return true;
	end
	return false;
end

--==========================================发送消息
function mainM:initChessBoard()
	--初始化元素
	local minX, maxX, minY, maxY = self.width+1, 0, self.height+1, 0;
	for i=0, self.num do
		repeat
			--获取指定坐标格子的配置数据
			local coord = self:index2Coord(i);
			local elements = self.cbData[coord.x .. "@" .. coord.y] or {};
			
			--非激活格子
			if (1 == #elements) then
				local arr = string.split(elements[1], "@");
				if (ELEMENT.GRID==arr[1])and(GRID.UNACTIVE==arr[2]) then
					break;
				end
			end

			--创建该格的元素
			for j=1, #elements do
				self:createElment(elements[j], i);
			end

			--如果没有配置格子创建一个格子
			local grid = self:get(i, ELEMENT_LAYER.GRID);
			if (nil == grid) then
				self:createElment("0@1", i)
			end

			--如果没有配置占格元素则配置一个占格元素
			local occupy = self:get(i, ELEMENT_LAYER.OCCUPY);
			if (nil == occupy) then
				while (true) do --生成棋盘格避免生成炸弹逻辑
					local key = self:randomElmentKey("init");
					local color = string.split(key, "@")[3];
					local result = self:isBirthBomb(color, coord);
					if (not result) then
						self:createElment(key, i);
						break;
					end
				end
			end

			if (minX > coord.x) then
				minX = coord.x;
			end

			if (minY > coord.y) then
				minY = coord.y;
			end
			
			if (maxX < coord.x) then
				maxX = coord.x;
			end

			if (maxY < coord.y) then
				maxY = coord.y;
			end
		until true
	end
	self.viewRect = cc.rect(minX, minY, (maxX-minX)+1, (maxY-minY)+1);
end

--获取触发方块周围同色的方块
function mainM:findSameColorCube(cube)
	local uncheck, check = {}, {};
	table.insert(uncheck, cube);
	self.traversalIndex[cube:get("index")] = true;

	while (true) do
		local element = table.remove(uncheck);
		if (nil == element) then
			break;
		end
		
		--检测该坐标四周元素(up, down, left, right)
		local dir = {cc.p(0, 1), cc.p(0, -1), cc.p(-1, 0), cc.p(1, 0)};
		for i=1, 4 do
			repeat
				--检测二位坐标是否合法
				local curCoord = cc.pAdd(dir[i], element:get("coord"));
				if (not self:checkCoord(curCoord)) then
					break;
				end
				
				--检测是否被遍历
				if (self.traversalIndex[self:coord2Index(curCoord)]) then
					break;
				end
				
				--获得该坐标所在最上层元素
				local topElement = self:getTop(curCoord);
				if (nil == topElement) then
					break;
				end
				
				--检测类型是否为方块
				local topElementType = topElement:get("type");
				if (ELEMENT.CUBE ~= topElementType) then
					--如果是牢笼则插入已检查表
					local occupy = self:get(curCoord, ELEMENT_LAYER.OCCUPY);
					if (ELEMENT.CAGE == topElementType) 
						and (ELEMENT.CUBE == occupy:get("type")) 
						and (occupy:get("color") == cube:get("color")) then
						table.insert(check, topElement);
						self.traversalIndex[self:coord2Index(curCoord)] = true;
					end
					break;
				end
				
				--检测颜色是否匹配
				if (topElement:get("color") ~= cube:get("color")) then
					break;
				end

				table.insert(uncheck, topElement);
				self.traversalIndex[self:coord2Index(curCoord)] = true;
			until true
		end

		--插入已发散元素到检测表
		table.insert(check, element);
	end
	return check;
end

--获取整个棋盘格同色方块
function mainM:findAllSameColorCube(cube)
	local delList = {};
	for index, _ in pairs(self.grids) do
		repeat
			local top = self:getTop(index);
			if (nil == top) then
				break;
			end

			if (ELEMENT.CUBE ~= top:get("type")) then
				break;
			end
			
			if (cube:get("color") ~= top:get("color")) then
				break;
			end
			table.insert(delList, top);
		until true
	end
	return delList;
end

function mainM:explode(bomb, isGroup)
	if (nil == bomb) then
		return;
	end

	local function isInUncheckList(list, bomb)
		for i=1, #list do
			if (bomb == list[i]) then
				return true;
			end
		end
		return false;
	end

	local bombList = nil;
	if (isGroup) then
		bombList = bomb;
	else
		bombList = {bomb,};
	end
	
	local checkBomblist, delLists = {}, {};
	while (true) do
		local bomb = table.remove(bombList);
		if (nil == bomb) then
			break;
		end
		checkBomblist[bomb] = true;
		
		local delList = {};
		local bombIni = configElement[bomb:get("type")];
		local bombType = bomb:get("subType");
		local bombExplodeIni = bombIni.explode[bombType];
		for i=1, #bombExplodeIni do
			repeat
				local offsetCoord = cc.pAdd(bombExplodeIni[i], bomb:get("coord"));
				if (not self:checkCoord(offsetCoord)) then
					break;
				end

				local topElement = self:getTop(offsetCoord);
				if (nil == topElement) then
					break;
				end

				if (ELEMENT.BOMB==topElement:get("type")) and (bomb~=topElement) then
					if (not checkBomblist[topElement]) --不等于已经检测过的炸弹
						and (not isInUncheckList(bombList, topElement)) then --不等于未检测过的炸弹
						table.insert(bombList, 1, topElement);
					end
					break;
				end
				
				if (topElement.bombCheck)and(topElement:bombCheck()) then
					local topElementIndex = topElement:get("index");
					if (not self.traversalIndex[topElementIndex]) then
						self.traversalIndex[topElementIndex] = true;
						table.insert(delList, topElement);
					end
				end
			until true
		end
		table.insert(delLists, 1, self:delAround(delList));
	end
	return delLists;
end

function mainM:delAround(checkList)
	local delList = {}; --删除表
	local function deleteElement(list, element)
		--计算分数
		local curScore, count = 0, #list;
		repeat
			--计算得分
			if (ELEMENT.CUBE~=element:get("type"))
				and (ELEMENT.BOMB~=element:get("type")) then
				break;
			end
			curScore = 5 + count * 10;
			self.score = self.score + curScore;
			
			--点亮星星
			if (nil==self.cpStarsData[self.starNum+1]) then
				break;
			end
			
			if (self.score<self.cpStarsData[self.starNum+1]) then
				break;
			end
			self.starNum = self.starNum + 1;
		until true

		--创建or删除or更新形态
		local op, extra = nil;
		if (nil~=element.createData) then
			op = ELEMENT_OP.CREATE;
			extra = element.createData[2];
			if (ELEMENT.COLORMACHINE == element:get("type")) then
				local list = {};
				local color, num = unpack(extra);
				for i=1, num do
					local cube = self:getCubeForColorMachine(color);
					if (nil ~= cube) then
						self:modifyLock(1);
						cube:changeColor("1@1@" .. color);
						table.insert(list, cube);

						if (nil == self.moveElementList) then
							self.moveElementList = {}; --移动元素表	
						end
						table.insert(self.moveElementList, 1, cube); --构建移动元素表
					end
				end
				extra = list;
				element.createData = nil;
			else
				element = self:createElment(element.createData[1], element:get("coord"));	
			end
		else
			if (element.del) and (element:del()) then
				if (ELEMENT.LUCKYBAG == element:get("type")) then
					local list = {};
					local elementKey = string.gsub(element.eType, "#", "@");
					local elementIni = self:getElementIni(elementKey);

					for i=1, element.num do
						local checkLayer = nil;
						if (ELEMENT_LAYER.MASK == elementIni.layer) then --塑料薄膜
							checkLayer = ELEMENT_LAYER.MASK;
						end

						local cube = self:getOnlyCubeInGrid(checkLayer);
						if (nil ~= cube) then
							self:modifyLock(1);

							local newElement = nil;
							if (ELEMENT_LAYER.OCCUPY == elementIni.layer) then
								newElement = self:changeElement2Other(cube, elementKey);
							else
								newElement = self:createElment(elementKey, cube:get("index"));
							end
							table.insert(list, newElement);
						end
					end
					extra = list;
				end

				op = ELEMENT_OP.DEL;
				self:removeFromElementsMgr(element);
				self:removeElement(element);
			else
				op = ELEMENT_OP.UPDATE;
			end

			--任务计数
			self.task:count(clone(element));
		end
		table.insert(delList, {op, element, curScore, extra,});
	end
	
	while (true) do
		local element = table.remove(checkList);
		if (nil == element) then
			break;
		end
		
		--检测该元素其他层and该元素周围元素
		if (ELEMENT.CUBE==element:get("type"))
			and (nil==element.createData) 
			and (CPSTATE.GAMEING==self.state) then
			--检测该坐标其他层元素
			for i=1, ELEMENT_LAYER.MAX-1 do
				local otherElement = self:get(element:get("index"), i);
				repeat
					if (nil == otherElement) then
						break;
					end

					if (nil == otherElement.otherLayerCheck) then
						break;
					end

					if (not otherElement:otherLayerCheck()) then
						break;
					end

					deleteElement(delList, otherElement);
				until true
			end

			--检测该坐标四周元素(up, down, left, right)
			local dir = {cc.p(0, 1), cc.p(0, -1), cc.p(-1, 0), cc.p(1, 0)};
			for i=1, 4 do
				repeat
					--检测二位坐标是否合法
					local curCoord = cc.pAdd(dir[i], element:get("coord"));
					if (not self:checkCoord(curCoord)) then
						break;
					end

					--检测是否被遍历
					local curElementIndex = self:coord2Index(curCoord);
					if (self.traversalIndex[curElementIndex]) then
						break;
					end
					
					--获得改坐标所在最上层元素
					local curElement = self:getTop(curCoord);
					if (nil == curElement) then
						break;
					end

					if (nil == curElement.aroundCheck) then
						break;
					end
					
					if (not curElement:aroundCheck(element)) then
						break;
					end

					self.traversalIndex[curElementIndex] = true;
					deleteElement(delList, curElement);
				until true
			end
		end
		
		--删除该元素
		deleteElement(delList, element);
	end
	return delList;
end

--检测棋盘格是否需要被重置
function mainM:isReset()
	local result = false;
	local enableDelList = self:isChessBoardDelEnable();
	if (nil == enableDelList) then
		result = true;
	end
	return result;
end

--查询整个棋盘格是否有可删除
function mainM:isChessBoardDelEnable()
	local delEnableList = nil;
	
	self.traversalIndex = {};
	for index, _ in pairs(self.grids) do
		repeat
			if (self.traversalIndex[index]) then
				break;
			end
			
			local occupy = self:get(index, ELEMENT_LAYER.OCCUPY);
			if (nil == occupy) then
				self.traversalIndex[index] = true;
				break;
			end

			if (ELEMENT.CUBE ~= occupy:get("type")) then
				self.traversalIndex[index] = true;
				break;
			end
			
			local topElement = self:getTop(index);
			if (ELEMENT.CUBE ~= topElement:get("type")) then
				self.traversalIndex[index] = true;
				break;
			end

			local curDelEnableList = self:findSameColorCube(occupy);
			local curDelEnableListNum = #curDelEnableList;
			if (curDelEnableListNum >= golbal.chessBoard.minCubeDelNum) then
				if (nil == delEnableList) then
					delEnableList = curDelEnableList;
				else
					if (curDelEnableListNum > #delEnableList) then
						delEnableList = curDelEnableList;
					end
				end
			end
		until true
	end
	self.traversalIndex = {};
	return delEnableList;
end

--检测一个元素掉落后是否生成炸弹
function mainM:isBirthBomb(color, coord)
	local compositionInis = configElement["1"].composition;
	local startIndex = tonumber(ELEMENT.BOMB);
	local loopNum = tonumber(ELEMENT.BOMB)-tonumber(ELEMENT.BOMB)+1;

	for i=1, #compositionInis do
		local bombType = compositionInis[i].type;
		local bombOffsets = compositionInis[i].offsets;
		for j=1, #bombOffsets do
			for k=1, #bombOffsets[j] do
				local otherCoord = cc.pAdd(bombOffsets[j][k], coord);
				if (not self:checkCoord(otherCoord)) then
					break;
				end
				
				if (otherCoord.x~=coord.x)or(otherCoord.y~=coord.y) then
					local otherElemnt = self:get(otherCoord, ELEMENT_LAYER.OCCUPY);
					if (nil==otherElemnt)or(ELEMENT.CUBE~=otherElemnt:get("type"))
						or (color ~= otherElemnt:get("color")) then
						break;
					end
				end
				
				--找到一个炸弹
				if (k == #bombOffsets[j]) then
					return true, "30@" .. bombType, 
							compositionInis[i].shape, cc.pAdd(bombOffsets[j][1], coord);
				end
			end
		end
	end
	return false;
end

return mainM;
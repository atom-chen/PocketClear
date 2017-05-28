local mainTaskV = class("mainTaskV");

function mainTaskV:ctor(model, root)
	self.root = root; --主场景结点
	self.topCon = self.root:seekNodeByName("top");

	self.M = model;
	
	local initMethod = self["init" .. self.M:getDataByKey("type")];
	if (nil ~= initMethod) then
		initMethod(self);
	end
end

function mainTaskV:getTaskCon()
	return self.taskCon;
end

function mainTaskV:show(...)
	local initMethod = self["show" .. self.M:getDataByKey("type")];
	if (nil ~= initMethod) then
		initMethod(self, ...);
	end
end

function mainTaskV:showAll()
	local initMethod = self["showAll" .. self.M:getDataByKey("type")];
	if (nil ~= initMethod) then
		initMethod(self);
	end
end

function mainTaskV:update(delList)
	local updateMethod = self["update" .. self.M:getDataByKey("type")];
	if (nil ~= updateMethod) then
		updateMethod(self, delList);
	end
end

--======================================收集任务
function mainTaskV:init1()
	self.taskCon = self.topCon:seekNodeByName("taskCon");

	--收集目标
	local poses = {cc.p(45, 90), cc.p(105, 90), cc.p(50, 30), cc.p(100, 30),};
	local taskLimit = self.M:getDataByKey("limitIni");
	for i=1, #taskLimit do
		repeat
			local layout = ccui.Layout:create()
							   :setAnchorPoint(cc.p(0.5, 0.5))
							   :setName(taskLimit[i].type)
							   :setContentSize(cc.size(80, 80))
							   :addTo(self.taskCon)
							   :move(poses[i])
							   :hide()
							   :delayCall(0.2, function(node)
			  		  				node:setScale(0.4);
			  	  			   end);
							   
			golbal.createElement(taskLimit[i].type)
				  :setName("armature")
			  	  :addTo(layout)
			  	  :centerTo(layout);			  	  
			
			ccui.TextAtlas:create(configNumber._6)
						  :setName("num")
						  :addTo(layout)
						  :move(70, 10)
						  :setScale(1.4)
						  :setString(taskLimit[i].num);

			display.newSprite("#texture/common/gou.png")
				   :setName("complete")
				   :addTo(layout)
				   :move(70, 10)
				   :hide();
		until true
	end
end

function mainTaskV:show1(name)
	self.taskCon:seekNodeByName(name)
				:show()
				:scaleTo(0.05, 0.6);
	audio.playSound(unpack(configAudio.sound_19));
end

function mainTaskV:showAll1()
	local children = self.taskCon:getChildren();
	for i=1, #children do
		children[i]:show()
				   :scaleTo(0.05, 0.6);
	end
end

function mainTaskV:update1(delList)
	if (nil == self.modelList) then
		self.modelList = {};
	end
	table.insert(self.modelList, delList);
	
	if (nil == self.viewSchedulerID) then
		local viewList = {};
		self.viewSchedulerID = self.root:addScheduler(function(dt)
			local view = table.remove(viewList);
			if (nil == view) then
				local list = table.remove(self.modelList);
				if (nil == list) then
					self.root:removeSchedulerByID(self.viewSchedulerID);
					self.viewSchedulerID = nil;
				else
					local limit = self.M:getDataByKey("limit"); --限制条件
					for i=1, #list do
						repeat
							local op, model, key = list[i][1], list[i][2], list[i][2]:get("key");
							if (ELEMENT_OP.CREATE == op) then
								break;
							end

							if (nil == limit[key]) then
								break;
							end
							
							local curPosX, curPosY = self.root:get(model:get("index"), ELEMENT_VIEW_LAYER.GRID)
											   			 	  :getPosition();

							local view = self.root:getElementInPool(model:get("type"), model:get("viewKey"))
											   	  :move(curPosX, curPosY)
											   	  :setLocalZOrder(1000)
											   	  :insertToTable(viewList);
							view.key = key;
						until true
					end
				end
				return;
			end

			local startPos = view:convertToWorldSpace(cc.p(0, 0));
			local dstElement = self.taskCon:seekNodeByName(view.key);
			local endPos = dstElement:convertToWorldSpace(cc.p(-10, -10));
			
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
			table.insert(actions, cc.CallFunc:create(function()
				self.root:returnElementToPool(view); --返回视图到池
				audio.playSound(unpack(configAudio.sound_19)); --收集音效

				--更新收集数量显示
				local ta_num = dstElement:seekNodeByName("num");
				local curNum = tonumber(ta_num:getString())-1;
				ta_num:setString(curNum);
				if (curNum <= 0) then
					dstElement:seekNodeByName("complete")
							  :show();
					ta_num:hide();
					self.M:getDataByKey("limit")[view.key] = nil; --限制条件
				end
			end));
			view:runAction(cc.Sequence:create(actions));
		end, 0, false);
	end
end

--======================================分数任务
function mainTaskV:init2()
	self.taskCon = self.topCon:seekNodeByName("taskCon");
	
	local viewList = {};
	display.newSprite("#texture/common/font_fs.png")
		   :setName("fontScore")
	   	   :addTo(self.taskCon)
	   	   :setScale(0.4)
	   	   :hide()
	       :insertToTable(viewList);
	
	local taskLimit = self.M:getDataByKey("limitIni");
	ccui.TextAtlas:create(configNumber._4)
				  :addTo(self.taskCon)
				  :setName("NumScore")
				  :setScale(0.4)
				  :setString(taskLimit)
				  :hide()
				  :insertToTable(viewList);
				  
	self.taskCon:grid(viewList, {column=1, 
								align="middle",
								space={x=0, y=40,}, 
								offsetS=cc.size(0, 36)});
end

function mainTaskV:show2(name)
	local scale = 0;
	if ("fontScore" == name) then
		scale = 1.0;
	else
		scale = 0.8;
	end

	self.taskCon:seekNodeByName(name)
				:show()
				:scaleTo(0.05, scale);
end

function mainTaskV:showAll2()
	self.taskCon:seekNodeByName("fontScore")
				:show()
				:scaleTo(0.05, 1.0);

	self.taskCon:seekNodeByName("NumScore")
				:show()
				:scaleTo(0.05, 0.8);
end

function mainTaskV:update2()
	
end

--======================================Boss任务
function mainTaskV:init3()
	self.taskCon = self.topCon:seekNodeByName("roleCon");
	self.elementCon = self.topCon:seekNodeByName("taskCon");

	--收集目标
	local poses = {cc.p(45, 90), cc.p(105, 90), cc.p(50, 30), cc.p(100, 30),};
	local taskLimit = self.M:getDataByKey("limitIni");
	for i=1, #taskLimit do
		repeat
			local layout = ccui.Layout:create()
							   :setAnchorPoint(cc.p(0.5, 0.5))
							   :setName(taskLimit[i].type)
							   :setContentSize(cc.size(80, 80))
							   :addTo(self.elementCon)
							   :move(poses[i])
							   :delayCall(0.2, function(node)
			  		  				node:scaleTo(0.4, 0.62);
			  	  			   end);

			golbal.createElement(taskLimit[i].type)
				  :setName("armature")
			  	  :addTo(layout)
			  	  :centerTo(layout);
		until true
	end
end

function mainTaskV:show3()
	self.taskCon:seekNodeByName("role")
		:show()
		:scaleTo(0.2, 1.0);
		
	self.topCon:seekNodeByName("hpCon")
		:show();
end

function mainTaskV:showAll3()
	self.taskCon:seekNodeByName("role")
		:show()
		:scaleTo(0.2, 1.0);
		
	self.topCon:seekNodeByName("hpCon")
		:show();
end

function mainTaskV:update3(delList)
	if (self.root.role.hpPercent <= 0) then
		return;
	end

	if (nil == self.modelList) then
		self.modelList = {};
	end
	table.insert(self.modelList, delList);

	if (nil == self.viewSchedulerID) then
		local viewList = {};
		self.viewSchedulerID = self.root:addScheduler(function(dt)
			local view = table.remove(viewList);
			if (nil == view) then
				local list = table.remove(self.modelList);
				if (nil == list) then
					self.root:removeSchedulerByID(self.viewSchedulerID);
					self.viewSchedulerID = nil;
				else
					local limit = self.M:getDataByKey("hitElement"); --限制条件
					for i=1, #list do
						repeat
							local model, key = list[i][2], list[i][2]:get("key");
							if (nil == limit[key]) then
								break;
							end

							local curPosX, curPosY = self.root:get(model:get("index"), ELEMENT_VIEW_LAYER.GRID)
											   			 	  :getPosition();

							local view = self.root:getElementInPool(model:get("type"), model:get("viewKey"))
											   	  :move(curPosX, curPosY)
											   	  :setLocalZOrder(1000)
											   	  :insertToTable(viewList);
							view.key = key;
						until true
					end
				end
				return;
			end

			local startPos = view:convertToWorldSpace(cc.p(0, 0));
			local dstElement = self.taskCon:seekNodeByName("role");
			local endPos = dstElement:convertToWorldSpace(cc.p(-10, -10));
			
			local spawnActions = {}; --并发动作表
			local poses = cc.getPosesInArc(startPos, endPos); --弧形动作
			local spline = cc.CardinalSplineBy:create(1.0, poses, 0);
			local easeSpline = cc.EaseInOut:create(spline, 1.0);
			table.insert(spawnActions, easeSpline);
			local rotate = cc.RotateBy:create(1.0, -360); --旋转动作
			table.insert(spawnActions, rotate);
			local scale = cc.ScaleTo:create(1.0, 0.4); --缩放动作
			table.insert(spawnActions, scale);

			local actions = {}; --动作表
			table.insert(actions, cc.Spawn:create(spawnActions));
			table.insert(actions, cc.CallFunc:create(function()
				self.root:returnElementToPool(view);
				self.root.role:updateHP(); --元素击打boss
			end));
			view:runAction(cc.Sequence:create(actions));
		end, 0, false);
	end
end

return mainTaskV;
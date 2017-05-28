local UIPanel = require("cocos.framework.extends.UIPanel");
local ContextScene = require("app.context.contextScene");
local Ghost = require("app.tool.ghost");

local taskCueV = class("taskCueV", UIPanel);
taskCueV.targetMotionTime = 1.0;

function taskCueV:onCreate(data, taskView, endCall)
	self.endCall = endCall;
	self.root = self:seekNodeByName("root");
	
	self.taskView = taskView;
	self.taskCon = self.taskView:getTaskCon();

	--面板初始化
	local method = self["setTarget" .. data.type];
	if (method) then
		method(self, data);
	end
	
	--面板退出
	self:delayCall(1.0, function ()
		local function execTaskMove()
			self.root:setTouchEnabled(false);
			local method = self["target" .. data.type .. "Move"];
			if (method) then
				method(self, function ()
					self:close();
				end);
			else
				self:close();
			end
		end
		
		self.root:setTouchEnabled(true)
				 :onTouch(function(event)
				 	if ("ended" == event.name) then
				 		self:stopAllActions();
				 		self.taskView:showAll();
				 		self:close();
				 	end
				 end);

		self:delayCall(2.0, function()
			execTaskMove();
		end);
	end);
end

function taskCueV:onDelete()
	if (self.endCall) then
		self.endCall();
	end
end

--设置收集任务
function taskCueV:setTarget1(target)
	if (nil == target.limit) or (nil == next(target.limit)) then
		return;
	end
	
	self.viewList = {};
	for i=1, #target.limit do
		repeat
			local layout = ccui.Layout:create()
							   :setName(target.limit[i].type)
							   :setAnchorPoint(cc.p(0.5, 0.5))
							   :setContentSize(cc.size(80, 80))
							   :addTo(self.root)
							   :insertToTable(self.viewList);

			golbal.createElement(target.limit[i].type)
				  :setName("armature")
				  :addTo(layout)
				  :centerTo(layout);

			ccui.TextAtlas:create(configNumber._6)
						  :setName("num")
						  :addTo(layout)
						  :centerTo(layout, cc.p(0, -60))
						  :setString(":" .. target.limit[i].num);
		until true
	end
	
	self.root:grid(self.viewList, 
					{column=#self.viewList, 
					space={x=40, y=0,}, 
					offsetS=cc.size(0, -40),});
end

--收集任务移动
function taskCueV:target1Move(endCall)
	local count = 1;
	local posOffsets = {cc.p(0, 50), cc.p(60, 50), cc.p(0, 0), cc.p(60, 0)};
	self:addScheduler(function(dt, id)
		local view = table.remove(self.viewList, 1);
		if (nil == view) then
			self:removeSchedulerByID(id);
			return;
		end
		
		view:seekNodeByName("num")
			:hide();
		
		local startPos = view:convertToWorldSpace(cc.p(0, 0));
		local endPos = self.taskCon:convertToWorldSpace(posOffsets[count]);
		count = count + 1;

		local spawnActions = {}; --并发动作表
		local poses = cc.getPosesInArc(startPos, endPos); --弧形动作
		local spline = cc.CardinalSplineBy:create(self.targetMotionTime, poses, 0);
		local easeSpline = cc.EaseInOut:create(spline, 1.0);
		table.insert(spawnActions, easeSpline);
		local rotate = cc.RotateBy:create(self.targetMotionTime, -360); --旋转动作
		table.insert(spawnActions, rotate);
		local scale = cc.ScaleTo:create(self.targetMotionTime, 0.4); --缩放动作
		table.insert(spawnActions, scale);

		local actions = {}; --动作表
		table.insert(actions, cc.Spawn:create(spawnActions));
		table.insert(actions, cc.CallFunc:create(function()
			self.taskView:show(view:getName());
			view:hide();
			
			if (nil == next(self.viewList)) then
				if (endCall) then
					self:delayCall(self.targetMotionTime, function ()
						endCall();
					end);
				end
			end
		end));
		view:runAction(cc.Sequence:create(actions));
	end, 0.4);
end

--设置分数任务
function taskCueV:setTarget2(target)
	self.viewList = {};
	ccui.ImageView:create("texture/common/font_fs.png", 1)
				  :setName("fontScore")
			   	  :addTo(self.root)
			      :setScale(2.0)
			      :insertToTable(self.viewList);
	
	ccui.TextAtlas:create(configNumber._4)
				  :addTo(self.root)
				  :setName("NumScore")
				  :setString(target.limit)
				  :setScale(1.6)
				  :insertToTable(self.viewList);

	self.root:grid(self.viewList, {column=#self.viewList, 
										space={x=20, y=0,}, 
										offsetS=cc.size(0, -80)});
end

--分数任务移动
function taskCueV:target2Move(endCall)
	local posOffsets = {cc.p(-2, 50), cc.p(-14, -6),};
	self:addScheduler(function(dt, id)
		local view = table.remove(self.viewList, 1);
		if (nil == view) then
			self:removeSchedulerByID(id);
			return;
		end
		
		local startPos = view:convertToWorldSpace(cc.p(0, 0));
		local endPos = self.taskCon:convertToWorldSpace(posOffsets[#posOffsets-#self.viewList]);

		local spawnActions = {}; --并发动作表
		local poses = cc.getPosesInArc(startPos, endPos); --弧形动作
		local spline = cc.CardinalSplineBy:create(self.targetMotionTime, poses, 0);
		local easeSpline = cc.EaseInOut:create(spline, 1.0);
		table.insert(spawnActions, easeSpline);
		local rotate = cc.RotateBy:create(self.targetMotionTime, -360); --旋转动作
		table.insert(spawnActions, rotate);
		local scale = cc.ScaleTo:create(self.targetMotionTime, 0.4); --缩放动作
		table.insert(spawnActions, scale);

		local actions = {}; --动作表
		table.insert(actions, cc.Spawn:create(spawnActions));
		table.insert(actions, cc.CallFunc:create(function()
			self.taskView:show(view:getName());
			view:hide();
			
			if (nil == next(self.viewList)) then
				if (endCall) then
					self:delayCall(self.targetMotionTime, function ()
						endCall();
					end);
				end
			end
		end));
		view:runAction(cc.Sequence:create(actions));
	end, 0.4);
end

--设置BOSS任务
function taskCueV:setTarget3(target)
	self.role = sp.SkeletonAnimation
				  :create(target.name)
				  :addTo(self.root)
				  :setScale(0.7)
				  :centerTo(self.root, cc.p(0, -120))
				  :play("idel");
end

--BOSS任务移动
function taskCueV:target3Move(endCall)
	local roleReadyFlag = false;
	local startPos = self.role:convertToWorldSpace(cc.p(0, 0));
	local endPos = self.taskCon:convertToWorldSpace(cc.p(160, 100));

	local spawnActions = {}; --并发动作表
	local poses = cc.getPosesInArc(startPos, endPos); --弧形动作
	poses[2] = cc.p(poses[2].x+300, poses[2].y);
	local spline = cc.CardinalSplineBy:create(self.targetMotionTime, poses, 0);
	local easeSpline = cc.EaseInOut:create(spline, 1.0);
	table.insert(spawnActions, easeSpline);
	local rotate = cc.RotateBy:create(self.targetMotionTime, -360); --旋转动作
	table.insert(spawnActions, rotate);
	local scale = cc.ScaleTo:create(self.targetMotionTime, 0.4); --缩放动作
	table.insert(spawnActions, scale);
	
	local actions = {}; --动作表
	table.insert(actions, cc.Spawn:create(spawnActions));
	table.insert(actions, cc.CallFunc:create(function()
		roleReadyFlag = true;
		self.taskView:show();
		self.role:hide();

		if (endCall) then
			self:delayCall(self.targetMotionTime, function ()
				endCall();
			end);
		end
	end));
	self.role:runAction(cc.Sequence:create(actions));

	self:addScheduler(function(dt, id)
		if (roleReadyFlag) then
			self:removeSchedulerByID(id);
			return;
		end
		Ghost:create()
			 :add(self.role);
	end, 0);
end

return taskCueV;
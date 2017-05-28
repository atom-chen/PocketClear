local clownM = class("clownM", require("app.model.mainParts.role.roleM"));

function clownM:onCreate()
	self.stateEnum = {
		victory = "victory",
		fail = "fail",
		idel = "idel",
		dizziness = "dizziness",
		preAttack = "preAttack",
		attack = "attack",
		hrut = "hrut",
	};
	
	self.taskIni = self.M.cpData.task;
	self.hp = self.taskIni.hp;
	self.defense = self.taskIni.defense;
	self.atkSpace = self.taskIni.atk.space;
	self.atkNum = self.taskIni.atk.num;
	self.atkElement = self.taskIni.atk.element;
	self.hitElement = self.taskIni.hitElement;

	self.state = self.stateEnum.idel; --当前状态
	self.normalState = self.stateEnum.idel; --当前常态

	self.nextState = nil; --下一个状态

	self.dizzyRound = 0; --恢复眩晕的轮
	self.dizzyCount = 0; --眩晕计数器
	self.dizzyNum = 0; --眩晕在第几个方块开始生效

	self.victoryCount = 0; --死亡计数器
	self.victoryNum = 0; --死亡在第几个方块开始生效

	--boss受击
	self.M:addCustomEvent(configMsg.main_bossHit, function(event)
		if (nil ~= self.nextState) then
			if (self.stateEnum.dizziness == self.nextState) then
				self.dizzyCount = self.dizzyCount + 1;
				if (self.dizzyCount == self.dizzyNum) then
					self.dizzyCount, self.dizzyNum = 0, 0;
					self.nextState = nil;
					
					self.normalState = self.stateEnum.dizziness;
					self.atkSpace = self.taskIni.atk.space;
				end
			elseif (self.stateEnum.victory == self.nextState) then
				self.victoryCount = self.victoryCount + 1;
				if (self.victoryCount == self.victoryNum) then
					self.victoryCount, self.victoryNum = 0, 0;
					self.nextState = nil;
					
					self.normalState = self.stateEnum.victory;
				end
			end
		end
		event._usedata();
	end);
	
	--一轮结束进行操作
	-- self.M:addCustomEvent(configMsg.main_roleRoundEnd, function(event)
	-- 	local recoverIdelCall, attackPreCall, attackCall = unpack(event._usedata);

	-- 	--防御力恢复
	-- 	self.defense = self.taskIni.defense;

	-- 	--眩晕生效恢复
	-- 	if (self.stateEnum.dizziness~=self.nextState) then
	-- 		self.dizzyNum = 0;
	-- 	end

	-- 	--死亡生效恢复
	-- 	if (self.stateEnum.victory~=self.nextState) then
	-- 		self.victoryNum = 0;
	-- 	end
		
	-- 	--如果是眩晕状态,清醒计数恢复
	-- 	if (self.stateEnum.dizziness == self.state) then
	-- 		if (self.dizzyRound>=self.curRound) then
	-- 			self.normalState = self.stateEnum.idel;
	-- 			recoverIdelCall();
	-- 		end
	-- 	else
	-- 		self.atkSpace = self.atkSpace - 1;
	-- 		if (1 == self.atkSpace) then
	-- 			attackPreCall();
	-- 		elseif (0 == self.atkSpace) then
	-- 			--恢复攻击间隔
	-- 			self.atkSpace=self.taskIni.atk.space;

	-- 			--丢技能
	-- 			local skillElements = {};
	-- 			for i=1, self.atkNum do
	-- 				local cube = self.M:getOnlyCubeInGrid();
	-- 				if (nil == cube) then
	-- 					break;
	-- 				end
					
	-- 				local newElement = nil;
	-- 				local atkKey = self.atkElement[math.random(1, #self.atkElement)].type;
	-- 				local atkElementIni = self.M:getElementIni(atkKey);
	-- 				if (ELEMENT_LAYER.OCCUPY == atkElementIni.layer) then
	-- 					newElement = self.M:changeElement2Other(cube, atkKey);
	-- 				else
	-- 					newElement = self.M:createElment(atkKey, cube:get("index"));
	-- 				end
	-- 				table.insert(skillElements, newElement);
	-- 			end

	-- 			--攻击回调
	-- 			attackCall(skillElements);
	-- 		end
	-- 	end
	-- end);
end

function clownM:hit()
	if (self.hp <= 0) then
		return;
	end

	self.hp = self.hp - 1;
	self.victoryNum = self.victoryNum + 1;
	
	--玩家胜利
	if (self.hp <= 0) then
		self.hp = 0;
		self.nextState = self.stateEnum.victory;
		return;
	end

	--小丑眩晕判断
	if (self.stateEnum.dizziness ~= self.state) 
		and (self.stateEnum.dizziness ~= self.nextState) then
		self.defense = self.defense - 1;
		if (self.defense <= 0) then
			self.nextState = self.stateEnum.dizziness;
			self.defense = self.taskIni.defense;
			self.dizzyRound = self.curRound-self.taskIni.recover;
		else
			self.dizzyNum = self.dizzyNum + 1;
		end
	end
end

function clownM:roundEnd()
	-- local recoverIdelCall, attackPreCall, attackCall = unpack(event._usedata);

	--防御力恢复
	self.defense = self.taskIni.defense;

	--眩晕生效恢复
	if (self.stateEnum.dizziness~=self.nextState) then
		self.dizzyNum = 0;
	end

	--死亡生效恢复
	if (self.stateEnum.victory~=self.nextState) then
		self.victoryNum = 0;
	end
	
	local state, skillElements = nil, {};
	--如果是眩晕状态,清醒计数恢复
	if (self.stateEnum.dizziness == self.state) then
		if (self.dizzyRound>=self.curRound) then
			self.normalState = self.stateEnum.idel;
			-- recoverIdelCall();
			state = self.stateEnum.idel;
		end
	else
		self.atkSpace = self.atkSpace - 1;
		if (1 == self.atkSpace) then
			-- attackPreCall();
			state = self.stateEnum.preAttack;
		elseif (0 == self.atkSpace) then
			state = self.stateEnum.attack;

			--恢复攻击间隔
			self.atkSpace=self.taskIni.atk.space;

			--丢技能
			for i=1, self.atkNum do
				local cube = self.M:getOnlyCubeInGrid();
				if (nil == cube) then
					break;
				end
				
				self.M:modifyLock(1);
				local newElement = nil;
				local atkKey = self.atkElement[math.random(1, #self.atkElement)].type;
				local atkElementIni = self.M:getElementIni(atkKey);
				if (ELEMENT_LAYER.OCCUPY == atkElementIni.layer) then
					newElement = self.M:changeElement2Other(cube, atkKey);
				else
					newElement = self.M:createElment(atkKey, cube:get("index"));
				end
				table.insert(skillElements, newElement);
			end

			--攻击回调
			-- attackCall(skillElements);
		end
	end

	return state, skillElements;
end

return clownM;
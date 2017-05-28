local clownV = class("clownV", require("app.view.mainParts.role.roleV"));

function clownV:onCreate()
	self.role = sp.SkeletonAnimation:create("clown")
				  :hide()
				  :addTo(self.roleCon)
				  :setScale(0.4)
				  :centerTo(self.roleCon, cc.p(0, -100))
				  :setEndCall(function(animationName)
				  	if (self:get("stateEnum").fail==self:get("state")) 
				  		or (self:get("stateEnum").victory==self:get("state")) then
				  		return;
				  	end

				  	if (self.role:getAnimationName("hrut")==animationName) 
				  		or (self.role:getAnimationName("attack")==animationName) then
				  		if (self.role:getAnimationName("attack")==animationName) then
				  			audio.playSound(unpack(configAudio.sound_31));
				  		end
				  		
				  		local normalState = self:get("normalState");
				  		if (self:get("stateEnum").dizziness == normalState) 
				  			or (self:get("stateEnum").fail == normalState) 
				  			or (self:get("stateEnum").victory == normalState) then
				  			self:hideAttackPre();
				  		end
				  		self:setState(normalState);
				  	end
				  end);

	local hpValue = self:get("taskIni").hp;
	self.hpPercent = 100;
	self.hpPPercent = self.hpPercent/hpValue; --1滴血对应的进度
	self.hpBar = self.roleCon:seekNodeByName("hpBar")
					 :setScale9Enabled(true)
					 :setContentSize(cc.size(170, 20))
					 :setPercent(self.hpPercent);
	self.hp = self.roleCon:seekNodeByName("hp")
						  :setString(hpValue);
end

function clownV:update(state)
	if (self.role.curState == state) then
		return;
	end

	if (self:get("stateEnum").victory == state) then
		audio.playSound(unpack(configAudio.sound_27));
	elseif (self:get("stateEnum").dizziness == state) then
		audio.playSound(unpack(configAudio.sound_32));
	elseif (self:get("stateEnum").attack == state) then
		audio.playSound(unpack(configAudio.sound_29));
	elseif (self:get("stateEnum").hrut == state) then
		audio.playSound(unpack(configAudio.sound_30));
	end

	self.role.curState = state;
	self.role:play(state);
end

function clownV:updateHP()
	self.hpPercent = self.hpPercent - self.hpPPercent;
	if (self.hpPercent < 0) then
		self.hpPercent = 0;
	end
	self.hpBar:setPercent(self.hpPercent);

	local curHPValue = self.hp:getString()-1;
	if (curHPValue < 0) then
		curHPValue = 0;
	end
	self.hp:setString(curHPValue);

	--眩晕状态判断
	self.root:sendCustomEvent(configMsg.main_bossHit, function()
		self:setState("hrut");
	end);
end

function clownV:roundEnd(state, atkElements)
	if ("preAttack" == state) then
		audio.playSound(unpack(configAudio.sound_28));
		local attackPreArmature = self.roleCon:seekNodeByName("attackPre");
		if (nil == attackPreArmature) then
			attackPreArmature = ccs.Armature:create("attackPre")
									:setName("attackPre")
									:addTo(self.roleCon)
									:setLocalZOrder(-1)
									:centerTo(self.roleCon, cc.p(0, 80));
		end
		attackPreArmature:show()
						 :play("bosstexiao");
	else
		self:setState(state);
		if ("attack" == state) then
			self:hideAttackPre();

			self.root:delayCall(0.5, function()
				local unitPix, unitPixPerSecond, unitPixPerRing = 50, 0.04, 360;
				for i=1, #atkElements do
					--获得偏转角度
					local model = atkElements[i];
					local srcPos = self.root.con:convertToNodeSpace(self.root.top:convertToWorldSpace(cc.p(300, 0)));
					local dstPos = cc.p(self.root:getPosByGrid(model:get("index")));
					local distance = cc.pGetDistance(srcPos, dstPos);

					local elementV = self.root:getElementInPool(model:get("type"), model:get("viewKey"))
											  :move(srcPos)
											  :setLocalZOrder(1000);
					
					local unitNum = math.ceil(distance/unitPix)
					local consumeTime, rotateRing = unitNum*unitPixPerSecond, unitNum*unitPixPerRing;

					local actionsArr = {};
					local spawn = cc.Spawn:create(cc.EaseInOut:create(cc.MoveBy:create(consumeTime, cc.pSub(dstPos, srcPos)), 1.0), 
													cc.RotateBy:create(consumeTime, rotateRing));
					table.insert(actionsArr, spawn);
					table.insert(actionsArr, cc.CallFunc:create(function()
						self.root:sendUnlockMsg();
						
						self.root:returnElementToPool(elementV); --归还对象
						if (ELEMENT_LAYER.OCCUPY == model:get("layer")) then
							self.root:changeElement2Other(model); --设置为攻击元素
						else
							self.root:createElement(model);
						end
					end));
					elementV:runAction(cc.Sequence:create(actionsArr));
				end
			end);
		end
	end
end

function clownV:hideAttackPre()
	local attackPreArmature = self.roleCon:seekNodeByName("attackPre");
	if (attackPreArmature) and (attackPreArmature:isVisible()) then
		attackPreArmature:hide();
	end
end

return clownV;
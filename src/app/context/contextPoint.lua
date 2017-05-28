local contextPoint = class("contextPoint");

--args1:触发点
--args2:面板参数
--args3:配置参数(购买命令,关闭命令)
function contextPoint:ctor(tPoint, panelArgs, optionsArgs)
	if ("number" == type(tPoint)) then --计费点ID触发
		self:popByItemID(tPoint, panelArgs, optionsArgs);
	else --游戏逻辑触发
		self:popByTriggerPoint(tPoint);
	end
end

function contextPoint:getOnoff(key)
	return dataCenter:getDataByKey({"onoff", key});
end

function contextPoint:popByItemID(id, panelArgs, optionsArgs)
	local name_p = configItem[id].name_p;
	
	--获得礼包皮肤
	local skinIndex, effectIni = 0, nil;
	if (1 == self:getOnoff("sneakSkin")) then --隐晦皮肤生效
		skinIndex = self:getOnoff(name_p);
		
		--不弹出营销界面
		if (3 == skinIndex) then
			require("app.model.pointM")
				:create()
				:pay(id, function(object)
					object:delete();
				end);
				
			if (nil~=optionsArgs.callback) then
				optionsArgs.callback();
			end
			return;
		end
		
		--获得礼包按钮,引导效果
		effectIni = self:getOnoff(name_p .. "Hand");
	end

	local skinIni = configPoint["skin" .. skinIndex][tostring(id)];
	require("app.context.contextPanel")
		:create("point", id, panelArgs, optionsArgs, skinIni, effectIni);
end

function contextPoint:popByTriggerPoint(point)
	local method = self["popBy" .. point];
	if (nil ~= method) then
		method(self, point);
	else
		--获得改触发点礼包列表
		local giftIDs = configPoint[point];
		if (nil==giftIDs)or(nil==next(giftIDs)) then
			return;
		end

		--获得在线参数所配置的具体礼包ID
		local giftIndex = self:getOnoff(point) or 0;
		local giftID = giftIDs[giftIndex];
		if (nil == giftID) then
			return;
		end

		if ("number" == type(giftID)) then --弹出礼包
			--判断礼包是否非重复礼包并且已经购买了
			local itemData = configItem[giftID];
			if (not itemData.repeatBuy) then
				if (dataCenter:getDataByKey({"item", giftID, "buyTime"}) > 0) then
					--删除已经不能购买的礼包ID
					table.remove(giftIDs, giftIndex);
					
					--在礼包列表不为空的情况下重新选择一个礼包弹出
					if (nil ~= next(giftIDs)) then
						dataCenter:setDataByKey({"onoff", point}, math.random(1, #giftIDs));
						self:popByTriggerPoint(point);
					end
					return;
				end
			end
			
			--正常弹出礼包
			self:popByItemID(giftID);
		else
			--弹出广告
			if ("insertAD" == giftID) then
				golbal.playInsertAD(function()
					
				end);
			end
		end
	end
end

function contextPoint:popBysignIn()
	if (1 == self:getOnoff("signIn")) then
		require("app.model.pointM")
				:create()
				:pay(102, function(object)
					object:delete();
				end);
	else
		self:popByItemID(102);
	end
end

--==========================================关卡相关的在线参数
function contextPoint:isPop(point) --判断关卡是否弹出
	local popFlag = false; --是否弹出标记

	local onoff = self:getOnoff(point);
	if (1 == onoff) then
		popFlag = true;
	elseif (2 == onoff) then
		local cpIndex = dataCenter:getDataByKey("curCP");
		local levels = self:getOnoff(point .. "Level") or "";
		local levelArr = string.split(levels, "-");
		for i=1, #levelArr do
			if (cpIndex == tonumber(levelArr[i])) then
				popFlag = true;
				break;
			end
		end
	end

	if (not popFlag) then
		return popFlag;
	end

	local popProb = self:getOnoff(point .. "Prob") or 100;
	if (math.random(0, 100) > popProb) then
		popFlag = false;
	end
	return popFlag;
end

function contextPoint:popBygameFail(point)
	if (not self:isPop(point)) then
		return;
	end
	self:popByTriggerPoint(point .. "Gift");
end

function contextPoint:popBygameWin(point)
	if (not self:isPop(point)) then
		return;
	end
	self:popByTriggerPoint(point .. "Gift");
end

function contextPoint:popByselectLevelBox(point)
	if (not self:isPop(point)) then
		return;
	end

	golbal.dropBox(function()
		self:popByTriggerPoint(point .. "Gift");
	end);
end

function contextPoint:popBygameBox(point)
	if (not self:isPop(point)) then
		return;
	end

	golbal.dropBox(function()
		self:popByTriggerPoint(point .. "Gift");
	end);
end

function contextPoint:popBywheelDiamondEnd(point)
	if (not self:isPop(point)) then
		return;
	end
	self:popByTriggerPoint(point .. "Gift");
end

return contextPoint;
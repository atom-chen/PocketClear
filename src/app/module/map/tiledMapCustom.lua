local TiledMapCustom = class("TiledMapCustom", function(model)
    return ccui.ScrollView:create()
               :setBounceEnabled(false)
               :setDirection(1)
               :setContentSize(display.size)
end);

local ObjectPool = require("app.tool.objectPool");
local ContextPanel = require("app.context.contextPanel");

function TiledMapCustom:ctor(model)
    self.M = model;
    self.passCPData = self.M:getDataByKey("passCP") or {}; --通关数据

    self.configMap = self.M:getDataByKey({"ini", "configMap"}); --地图信息数据
    self.mapVisibleIndex = {};
    
	--地图基本信息(ref, 函数结束自动释放) --self.configure.file
	local mapInfo = cc.TMXMapInfo:create(self.configMap.file); --读取tiledmap xml文件
    local objectGroups = mapInfo:getObjectGroups(); --获得xml文件所有组
    local cpGroup = self:getObjectGroupByName(objectGroups, "CPObjectGroup"); --获取关卡节点组
    local cpObjects = cpGroup:getObjects(); --获取所有关卡节点
    local cpObjectsNum = #cpObjects; --所有关卡节点数量
    
    --地图附属物基本信息
    self.headCP = self.M:getDataByKey("maxCP")+1; --头像所在关卡
    if (self.headCP > cpObjectsNum) then
        self.headCP = cpObjectsNum;
    end
    
    --把关卡节点按地图分块
    self.cpObjectsWithIndex = {}; --{{地图1节点}, {地图2节点}, {地图3节点}, ...};
    self.cpObjectsWithName = {}; --{name=info, ...};s
    for i=1, cpObjectsNum do
        local object = cpObjects[i];
        local index = math.ceil(object.y/1280);
        if (nil == self.cpObjectsWithIndex[index]) then
            self.cpObjectsWithIndex[index] = {};
        end
        table.insert(self.cpObjectsWithIndex[index], object);
        self.cpObjectsWithName[object.name] = object;
    end
    
	self.tileNum = mapInfo:getMapSize();
    self.tileSize = mapInfo:getTileSize();
    self.mapSize = cc.size(self.tileNum.width*self.tileSize.width, 
    						self.tileNum.height*self.tileSize.height);
    if (nil ~= configMap.lastBg) then
        local curHeight = unpack(configMap.lastBg);
        self.mapSize.height = self.mapSize.height-(self.tileSize.height-curHeight);
    end
    
    local headCPObjectInfo = self.cpObjectsWithName["Button" .. self.headCP];
    local mapPercent = 100 - (headCPObjectInfo.y*1.1-display.size.height*0.5)/self.mapSize.height*100;
    if (mapPercent > 100) then
        mapPercent = 100;
    end

    self:setInnerContainerSize(self.mapSize)
        :jumpToPercentVertical(mapPercent)
        :addEventListener(function(sender, eventType)
            if (9 == eventType) then
                sender:updateMap();
            end
        end);
    
    --背景,节点,关卡锁缓冲
    for i=1, #self.configMap.createThing do 
        local key = self.configMap.createThing[i];
        local createFunc = handler(self, self[key .. "Create"]);
        self[key .. "Pool"] = ObjectPool:create(createFunc, self.configMap[key].num);
    end
    
    self:updateMap();
end

function TiledMapCustom:onDelete()
    for i=1, #self.configMap.createThing do 
        local key = self.configMap.createThing[i];
        self[key .. "Pool"]:clear();
    end

    self.configMap = nil;
    self.mapVisibleIndex = nil;
    self.headCP = nil;
    self.cpObjectsWithIndex = nil;
end

function TiledMapCustom:onLoadingEnd()
    local passCPIndex = self.M:getDataByKey("passCPIndex");
    if (nil~=self.headMoveFunc)
        and(golbal.welcomeGiftTriggerCP~=passCPIndex) then
        self.headMoveFunc();
        self.headMoveFunc = nil;
    end
end

function TiledMapCustom:getObjectGroupByName(groups, name)
    for i=1, #groups do
        local groupName = groups[i]:getGroupName();
        if (name==groupName) then
            return groups[i];
        end
    end
    return nil;
end

function TiledMapCustom:openLevelInfoPanel(cpIndex)
     --判断是否需要弹出下一关信息面板
    local isPopNextLevelInfo = function()
        local passCPIndex = self.M:getDataByKey("passCPIndex") or 0;
        if (self.M:getDataByKey("maxCP") > passCPIndex) then
            return true;
        end
        
        --关卡解锁功能判断
        if (golbal.signInTriggerCP==passCPIndex)
            -- or (golbal.wheelTriggerCP==passCPIndex)
            or (golbal.flipBrandTriggerCP==passCPIndex) 
            or (configTrip[1][2]==passCPIndex) then
            return false;
        end
        
        --星星奖励判断
        local curStars = dataCenter:getDataByKey({"item", 3, "num"});
        if (passCPIndex>=10)and(curStars>=configStarReward[1].stars)
            and(0==self.M:getDataByKey("starRewardIndex")) then
            return false;
        end

        return true;
    end
    
    if (isPopNextLevelInfo()) then
        ContextPanel:create(self.configMap.cp.openUI, cpIndex);
        local cpGift = configCP[cpIndex].cpGift;
        if (nil~=cpGift)and(self.headCP==cpIndex) 
            and (not self.M:getDataByKey({"checkPoint", cpIndex, "isGetCPGift"})) then
            ContextPanel:create("cpGift", cpIndex);
        end
    end

    self.M:setDataByKey("passCPIndex", nil);
end

function TiledMapCustom:updateMap()
    local hideHeight = math.abs(self:getInnerContainerPosition().y);
	self.curStartIndex = math.floor(hideHeight/self.tileSize.height)+1;
    local visibleRect = cc.rect(0, hideHeight, display.size.width, display.size.height); --当前可见区域

    --回收不可见对象
    for k, v in pairs(self.mapVisibleIndex) do
        if (k~=self.curStartIndex) and (k~=self.curStartIndex+1) 
            and (nil ~= self.mapVisibleIndex[k]) then
            for m, n in pairs(v) do
                for i=1, #n do
                    n[i]:hide()
                        :setName("");
                    self[m .. "Pool"]:returnObject(n[i]);
                end
            end
            self.mapVisibleIndex[k] = nil;
        end
    end
    
	--渲染两幅地图的资源
    for i=0, self.configMap.num-1 do
        repeat
            local index = self.curStartIndex + i;
            if (self.mapVisibleIndex[index]) then
                break;
            end

            self.mapVisibleIndex[self.curStartIndex+i] = {};
            for j=1, #self.configMap.createThing do
                local method = self[self.configMap.createThing[j] .. "Init"];
                if (method) then
                    method(self, index);
                end
            end
        until true
    end
end

--==================================池化对象初始化函数
function TiledMapCustom:bgCreate() --背景
    local imageView = ccui.ImageView:create()
                                    :addTo(self);
    return imageView;
end

function TiledMapCustom:bgInit(index)
    if (nil == self.mapVisibleIndex[index].bg) then
        self.mapVisibleIndex[index].bg = {};
    end

    local poolObject = self.bgPool:getObject();
    if (poolObject) then
        table.insert(self.mapVisibleIndex[index].bg, poolObject);

        poolObject:loadTexture(self.configMap.bg.path[index])
                  :show();
        local s = poolObject:getContentSize();
        poolObject:setPosition(cc.p(s.width/2.0, s.height/2.0+(index-1)*self.tileSize.height));
    end
end

function TiledMapCustom:cpCreate() --普通关卡节点
    --父容器
    local layout = ccui.Layout:create()
                              :setContentSize(cc.size(101, 76))
                              :addTo(self);

    --结点底图
    layout.bg = display.newSprite("#texture/selectLevel/btn_active.png")
                        :addTo(layout)
                        :centerTo(layout)
                        :setScale(1.2);

    --关卡数
    layout.cpIndex = ccui.TextAtlas:create(configNumber._1)
                                   :setString(0)
                                   :addTo(layout)
                                   :centerTo(layout, cc.p(0, 18))
                                   :setScale(1.2)
                                   :hide();

    --星星骨骼
    layout.star = ccs.Armature:create("star")
                              :addTo(layout)
                              :setScale(0.24)
                              :move(52, -20)
                              :play("guanka3xing")
                              :hide();
    
    --boss标记
    layout.bossMark = display.newSprite("#texture/selectLevel/bossguanka.png")
                             :addTo(layout)
                             :centerTo(layout, cc.p(0, -24))
                             :hide();
    return layout;
end

function TiledMapCustom:cpInit(index)
    if (nil == self.cpObjectsWithIndex[index]) then
        return;
    end
    
    if (nil == self.mapVisibleIndex[index].cp) then
        self.mapVisibleIndex[index].cp = {};
    end

    local passCPIndex = self.M:getDataByKey("passCPIndex");
    for i=1, #self.cpObjectsWithIndex[index] do
        repeat
            local info = self.cpObjectsWithIndex[index][i];
            local position = cc.p(info.x+info.width/2.0, info.y+info.height/2.0);
            if (info.name == "Terminal") then
                --终点结点渲染
                self:setcpLock(index, position);
            else
                local poolObject = self.cpPool:getObject();
                if (nil == poolObject) then
                    break;
                end
                
                poolObject.star:hide();
                poolObject.bossMark:hide();
                
                table.insert(self.mapVisibleIndex[index].cp, poolObject);
                local cpIndex = tonumber(string.sub(info.name, 7));
                poolObject:setPosition(position)
                          :setName("CP" .. cpIndex)
                          :show();
                          
                --增加关卡节点附属物件
                if (golbal.lightFullMap)or(cpIndex<=self.headCP) then
                    --关卡节点底图
                    poolObject.bg:setSpriteFrame("texture/selectLevel/btn_active.png"); 
                    --关卡索引
                    poolObject.cpIndex:setString(cpIndex) 
                                      :show();
                                      
                    if (cpIndex == self.headCP) then
                        --创建当前闯关头像
                        if (nil == self.head) then
                            self.head = ccs.Armature:create("head")
                                          :addTo(self, 1000)
                                          :play("touxiang");

                            cc.ParticleSystemQuad:create("cpHead")
                                                 :addTo(self.head)
                                                 :setName("particle")
                                                 :setScale(1.3)
                                                 :centerTo(self.head, cc.p(-70, -190));
                        end
                        
                        --设置已经闯关结点
                        local curPos = cc.p(info.x+info.width-6, info.y+info.height+110);
                        if (passCPIndex == self.M:getDataByKey("maxCP")) 
                            and (not configCP[cpIndex].terminal) then --通过当前最大关卡
                            --设置头像在上一个结点
                            local preInfo = self.cpObjectsWithName["Button" .. passCPIndex];
                            local prePos = cc.p(preInfo.x+preInfo.width-6, preInfo.y+preInfo.height+110);
                            self.head:move(prePos);

                            poolObject.bg:setSpriteFrame("texture/selectLevel/btn_unactive.png"); --关卡节点底图
                            poolObject.cpIndex:hide(); --关卡索引
                            self.head:seekNodeByName("particle") --隐藏头像的特效
                                     :hide();
                                     
                            --头像移动函数,等待loading图片结束后开始执行
                            self.headMoveFunc = function()
                                local actionArr = {};
                                table.insert(actionArr, cc.DelayTime:create(0.5));
                                table.insert(actionArr, cc.CallFunc:create(function()
                                    poolObject.bg:setSpriteFrame("texture/selectLevel/btn_active.png"); --关卡节点底图
                                    poolObject.cpIndex:show() --关卡索引

                                    --关卡激活特效
                                    cc.ParticleSystemQuad:create("cpActivate")
                                                         :addTo(poolObject)
                                                         :centerTo(poolObject);
                                end));
                                table.insert(actionArr, cc.DelayTime:create(0.2));
                                table.insert(actionArr, cc.CallFunc:create(function()
                                    local moveArr = {};
                                    table.insert(moveArr, cc.MoveBy:create(0.5, cc.pSub(curPos, prePos)));
                                    table.insert(moveArr, cc.CallFunc:create(function()
                                        self.head:seekNodeByName("particle")
                                                 :show();
                                        
                                        if (self.M:getDataByKey("isOpenLevelInfoUi")) then
                                            self.head:delayCall(0.2, function(sender)
                                                self:openLevelInfoPanel(passCPIndex+1);
                                            end);
                                        end
                                    end));
                                    self.head:runAction(cc.Sequence:create(moveArr));
                                end));
                                self:runAction(cc.Sequence:create(actionArr));
                            end
                        else
                            self.head:move(curPos); --设置头像位置
                        end
                    else
                        --打过关卡的星级显示
                        local cpStarNum = self.M:getDataByKey({"checkPoint", cpIndex, "star"});
                        if (nil~=cpStarNum) and (cpStarNum > 0) then
                            local armatureName = nil;
                            if (passCPIndex == cpIndex) then
                                armatureName = "SLJMxingxing" .. cpStarNum;
                            else
                                armatureName = "guanka" .. cpStarNum .. "xing";
                            end
                            poolObject.star:show()
                                      :play(armatureName);
                        end
                    end
                    
                    --关卡节点回调
                    poolObject:setTouchEnabled(true)
                              :onTouch(function (event)
                                if ("ended" == event.name) then
                                    self:openLevelInfoPanel(cpIndex);
                                end
                              end);
                elseif (cpIndex > self.headCP) then
                    --关卡节点抹灰, 隐藏关卡索引, 隐藏关卡星级
                    poolObject:setTouchEnabled(false);
                    poolObject.bg:setSpriteFrame("texture/selectLevel/btn_unactive.png");
                    poolObject.cpIndex:hide();
                    poolObject.star:hide();

                    --关卡锁
                    local lock = self.M:getDataByKey({"ini", "configCP", cpIndex, "lock"});
                    if (nil ~= lock) then
                        local lockPoolObject = self.cpLockPool:getObject()
                                                              :show()
                                                              :move(info.x, info.y);

                        if (nil == self.mapVisibleIndex[index].cpLock) then
                            self.mapVisibleIndex[index].cpLock = {};
                        end
                        table.insert(self.mapVisibleIndex[index].cpLock, lockPoolObject);
                    end
                end
                
                --boss关卡标志显示
                local taskType = self.M:getDataByKey({"ini", "configCP", cpIndex, "task", "type",});
                if (TASK.BOSS == taskType) then
                    poolObject.bossMark:show();
                else
                    poolObject.bossMark:hide();
                end
                
                --渲染关卡礼物
                self:setcpGift(index, cpIndex, poolObject);
            end
        until true
    end
end

function TiledMapCustom:cpGiftCreate()
    local cpGift = display.newSprite("#texture/common/item_3.png")
                        :addTo(self)
                        :hide();
    return cpGift;
end

function TiledMapCustom:setcpGift(mapIndex, cpIndex, cpObject)
    local cpIni = configCP[cpIndex];
    if (nil == cpIni) then
        return;
    end

    local cpGift = cpIni.cpGift;
    if (nil~=cpGift) then
        if (self.headCP<=cpIndex) 
            and(not self.M:getDataByKey({"checkPoint", cpIndex, "isGetCPGift"}))then
            if (nil == self.mapVisibleIndex[mapIndex].cpGift) then
                self.mapVisibleIndex[mapIndex].cpGift = {};
            end
            
            local cpGiftObject = self.cpGiftPool:getObject();
            table.insert(self.mapVisibleIndex[mapIndex].cpGift, cpGiftObject);

            local itemData = configItem[cpGift.id];
            cpGiftObject:show()
                        :setName("cpGift" .. cpIndex)
                        :move(cc.pAdd(cc.p(cpObject:getPosition()), cc.p(40, 110)))
                        :setSpriteFrame(itemData.icon)
                        :setLocalZOrder(cpObject:getLocalZOrder()+1)
                        :runAction(cc.RepeatForever:create(cc.Sequence:create(
                                    cc.EaseSineOut:create(cc.MoveBy:create(2.0, cc.p(0, -8))),
                                    cc.EaseSineOut :create(cc.MoveBy:create(2.0, cc.p(0, 8))))));
        else
            local cpGiftObject = self:seekNodeByName("cpGift" .. cpIndex);
            if (nil ~= cpGiftObject) then
                cpGiftObject:hide()
                            :setName("");
                self["cpGiftPool"]:returnObject(cpGiftObject);
            end
        end
    end
end

function TiledMapCustom:cpLockCreate()
    local lock = ccs.Armature:create("cpLock")
                             :addTo(self)
                             :hide();

    ccs.Armature:create("newReward")
        :setName("terminal")
        :addTo(lock)
        :setLocalZOrder(100)
        :play("jijiangtuichu");
    return lock;
end

function TiledMapCustom:setcpLock(mapIndex, position)
    if (nil == self.mapVisibleIndex[mapIndex].cpLock) then
        self.mapVisibleIndex[mapIndex].cpLock = {};
    end
    
    local cpLockObject = self.cpLockPool:getObject();
    table.insert(self.mapVisibleIndex[mapIndex].cpLock, cpLockObject);
    
    cpLockObject:show()
                :move(position)
                :setLocalZOrder(1000)
end

function TiledMapCustom:headMove(passCPIndex, isDirect)
   self.headMoveFunc();
end

return TiledMapCustom;
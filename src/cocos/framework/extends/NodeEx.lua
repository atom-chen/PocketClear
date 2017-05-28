--[[

Copyright (c) 2011-2014 chukong-inc.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

]]

local Node = cc.Node

local tempSetScale = Node.setScale;
function Node:setScale(x, y)
    if (nil == x) then
        return;
    end
    y = y or x;

    tempSetScale(self, x, y);
    return self;
end

local tempSetContentSize = Node.setContentSize;
function Node:setContentSize(size)
    tempSetContentSize(self, size);
    return self;
end

local tempSetName = Node.setName;
function Node:setName(name)
    tempSetName(self, name);
    return self;
end

local tempSetLocalZOrder = Node.setLocalZOrder;
function Node:setLocalZOrder(z)
    tempSetLocalZOrder(self, z);
    return self;
end

local tempSetAnchorPoint = Node.setAnchorPoint;
function Node:setAnchorPoint(a)
    tempSetAnchorPoint(self, a);
    return self;
end

local tempSetCascadeOpacityEnabled = Node.setCascadeOpacityEnabled;
function Node:setCascadeOpacityEnabled(enabled)
    tempSetCascadeOpacityEnabled(self, enabled);
    return self;
end

local tempSetOpacity = Node.setOpacity
function Node:setOpacity(opacity)
    tempSetOpacity(self, opacity);
    return self;
end

function Node:add(child, zorder, tag)
    if tag then
        self:addChild(child, zorder, tag)
    elseif zorder then
        self:addChild(child, zorder)
    else
        self:addChild(child)
    end
    return self
end

function Node:addTo(parent, zorder, tag)
    if tag then
        parent:addChild(self, zorder, tag)
    elseif zorder then
        parent:addChild(self, zorder)
    else
        parent:addChild(self)
    end
    return self
end

function Node:removeSelf()
    self:removeFromParent()
    return self
end

function Node:align(anchorPoint, x, y)
    self:setAnchorPoint(anchorPoint)
    return self:move(x, y)
end

function Node:show()
    self:setVisible(true)
    return self
end

function Node:hide()
    self:setVisible(false)
    return self
end

local tempSetVisible = Node.setVisible
function Node:setVisible(v)
    tempSetVisible(self, v);
    return self;
end

function Node:move(x, y)
    if y then
        self:setPosition(x, y)
    else
        self:setPosition(x)
    end
    return self
end

function Node:moveDiff(x, y)
    local curX, curY = self:getPosition();
    if (nil ~= y) then
        self:setPosition(curX+x, curY+y);
    else
        self:setPosition(cc.pAdd(x, cc.p(curX, curY)));
    end
    return self;
end

local tempRunAction = Node.runAction
function Node:runAction(actions)
    tempRunAction(self, actions);
    return self;
end

local tempStopAllActions = Node.stopAllActions;
function Node:stopAllActions()
    tempStopAllActions(self);
    return self;
end

function Node:moveTo(args)
    transition.moveTo(self, args)
    return self
end

function Node:moveBy(time, distance, call)
    local moveBy = cc.MoveBy:create(time, distance);
    self:runAction(cc.Sequence:create(moveBy, 
                                      cc.CallFunc:create(function()
                                          if (call) then
                                            call(self);
                                          end
                                      end)));
    return self;
end

function Node:fadeIn(time, call)
    self:runAction(cc.Sequence:create(cc.FadeIn:create(time),
                                        cc.CallFunc:create(function()
                                            if (call) then
                                                call();
                                            end
                                        end)));
    return self
end

function Node:fadeOut(time, call)
    self:runAction(cc.Sequence:create(cc.FadeOut:create(time),
                                        cc.CallFunc:create(function()
                                            if (call) then
                                                call();
                                            end
                                        end)));
    return self
end

function Node:fadeTo(time, opacity, call)
    self:runAction(cc.Sequence:create(cc.FadeTo:create(time, opacity),
                                        cc.CallFunc:create(function()
                                            if (call) then
                                                call();
                                            end
                                        end)));
    return self
end

function Node:rotate(rotation)
    self:setRotation(rotation)
    return self
end

function Node:rotateTo(args)
    transition.rotateTo(self, args)
    return self
end

function Node:rotateBy(args)
    transition.rotateBy(self, args)
    return self
end

function Node:scaleTo(time, scale, call)
    self:runAction(cc.Sequence:create(cc.ScaleTo:create(time, scale),
                                        cc.CallFunc:create(function()
                                            if (call) then
                                                call();
                                            end
                                        end)));
    return self
end

function Node:delayCall(delayTime, call)
    self:runAction(cc.Sequence:create(
                    cc.DelayTime:create(delayTime), 
                    cc.CallFunc:create(function ()
                        if (call) then
                            call(self);
                        end
                    end)));
    return self;
end

function Node:moveByEaseElasticOut(time, distance, rate, call)
    local moveBy = cc.MoveBy:create(time, distance);
    local easeElasticOut = cc.EaseElasticOut:create(moveBy, rate);

    self:runAction(cc.Sequence:create(easeElasticOut, 
                                      cc.CallFunc:create(function()
                                          if (call) then
                                            call(self);
                                          end
                                      end)));
    return self;
end

local tempSetOpacity = Node.setOpacity;
function Node:setOpacity(value)
    tempSetOpacity(self, value);
    return self;
end

function Node:onUpdate(callback)
    self:scheduleUpdateWithPriorityLua(callback, 0)
    return self
end

Node.scheduleUpdate = Node.onUpdate

function Node:onNodeEvent(eventName, callback)
    if "enter" == eventName then
        self.onEnterCallback_ = callback
    elseif "exit" == eventName then
        self.onExitCallback_ = callback
    elseif "enterTransitionFinish" == eventName then
        self.onEnterTransitionFinishCallback_ = callback
    elseif "exitTransitionStart" == eventName then
        self.onExitTransitionStartCallback_ = callback
    elseif "cleanup" == eventName then
        self.onCleanupCallback_ = callback
    end
    self:enableNodeEvents()
end

function Node:enableNodeEvents()
    if self.isNodeEventEnabled_ then
        return self
    end

    self:registerScriptHandler(function(state)
        if state == "enter" then
            self:onEnter_()
        elseif state == "exit" then
            self:onExit_()
        elseif state == "enterTransitionFinish" then
            self:onEnterTransitionFinish_()
        elseif state == "exitTransitionStart" then
            self:onExitTransitionStart_()
        elseif state == "cleanup" then
            self:onCleanup_()
        end
    end)
    self.isNodeEventEnabled_ = true

    return self
end

function Node:disableNodeEvents()
    self:unregisterScriptHandler()
    self.isNodeEventEnabled_ = false
    return self
end


function Node:onEnter()
end

function Node:onExit()
end

function Node:onEnterTransitionFinish()
end

function Node:onExitTransitionStart()
end

function Node:onCleanup()
end

function Node:onEnter_()
    self:onEnter()
    if not self.onEnterCallback_ then
        return
    end
    self:onEnterCallback_()
end

function Node:onExit_()
    self:onExit()
    if not self.onExitCallback_ then
        return
    end
    self:onExitCallback_()
end

function Node:onEnterTransitionFinish_()
    self:onEnterTransitionFinish()
    if not self.onEnterTransitionFinishCallback_ then
        return
    end
    self:onEnterTransitionFinishCallback_()
end

function Node:onExitTransitionStart_()
    self:onExitTransitionStart()
    if not self.onExitTransitionStartCallback_ then
        return
    end
    self:onExitTransitionStartCallback_()
end

function Node:onCleanup_()
    self:onCleanup()
    if not self.onCleanupCallback_ then
        return
    end
    self:onCleanupCallback_()
end

--==================================================custom
--args={column=, space={x=, y=,}, offsetS=cc.size(0, 0)};
function Node:grid(children, args)
    -- local function getRealSize(node)
    --     local size = node:getContentSize();
    --     local scaleX, scaleY = node:getScaleX(), node:getScaleY();
    --     local realSize = cc.size(size.width*scaleX, size.height*scaleY);
    --     return realSize;
    -- end

    local childrenNum = #children;
    args = args or {};
    local column = args.column or 1; --列数
    local space = args.space or cc.p(0, 0); --元素之间间隔
    local align = args.align or "left"; --元素对齐方式
    local offsetSize = args.offsetS or cc.size(0, 0); --所有元素在父容器内的偏移
    local numPerRow, sumRow = column, math.ceil(childrenNum/column); --每排子节点个数

    local childrenSize, rowWidths, columnHeights = {}, {}, {}; --子节点size, 每排宽度, 每列最大高度
    local maxWidth, sumHeight, rowWidth, rowMaxHeight = 0, 0, 0, 0; --所有行最大宽度, 总高度, 行宽度, 行最大高度
    for i=1, childrenNum do
        local child = children[i];

        --插入子结点size
        local childSize = child:getRealSize();
        table.insert(childrenSize, childSize);
        
        --记录行宽度, 行最大高度
        rowWidth = rowWidth + childSize.width;
        if (rowMaxHeight < childSize.height) then
            rowMaxHeight = childSize.height;
        end
        
        --换行
        if (0==i%numPerRow) or (i==childrenNum) then
            --插入行宽度和行最大高度
            rowWidth = rowWidth + (numPerRow-1)*space.x;
            table.insert(rowWidths, rowWidth);
            table.insert(columnHeights, rowMaxHeight);

            --为最大宽度赋值
            if (maxWidth < rowWidth) then
                maxWidth = rowWidth;
            end

            --计算总高度
            sumHeight = sumHeight + rowMaxHeight + space.y;

            --恢复默认值
            rowWidth, rowMaxHeight = 0, 0;
        end
        
        if (nil == child:getParent()) then
            self:addChild(child);
        end
    end
    
    --计算实际的父容器区域
    local selfSize = self:getRealSize();
    selfSize = cc.size(selfSize.width+offsetSize.width, selfSize.height+offsetSize.height);

    --计算整个子节点的起点
    local leftbottom = cc.p((selfSize.width-maxWidth)/2.0, (selfSize.height-sumHeight)/2.0);
    local leftTop = cc.p(leftbottom.x, leftbottom.y+sumHeight);
    local childCurPos = clone(leftTop);

    for i=1, #children do
        local curRow = math.ceil(i/numPerRow);
        if (1==i%numPerRow) or (1==numPerRow) then
            if (align == "left") then
                childCurPos.x = leftTop.x;
            elseif (align == "middle") then
                childCurPos.x = leftTop.x+(maxWidth-rowWidths[curRow])/2.0;
            elseif (align == "right") then
                childCurPos.x = leftTop.x+(maxWidth-rowWidths[curRow]);
            end

            childCurPos.y = childCurPos.y-(columnHeights[curRow]+space.y);
        end

        local child = children[i];
        local childAnchorPos = child:getAnchorPoint();
        local childSize = childrenSize[i];
        
        local startPosY = childCurPos.y+(columnHeights[curRow]-childSize.height)/2.0;
        local childPos = cc.p(childCurPos.x+childSize.width*childAnchorPos.x, 
                                startPosY+childSize.height*childAnchorPos.y);
        child:setPosition(childPos);
        childCurPos.x = childCurPos.x + childSize.width + space.x;
    end

    return self;
end

function Node:center(node, offset)
    self:grid({node,});

    if (offset) then
        local curPos = cc.p(node:getPosition());
        local curPos = cc.pAdd(curPos, offset);
        node:setPosition(curPos);
    end
    return self;
end

function Node:centerTo(node, offset)
    node:grid({self,});

    if (offset) then
        local curPos = cc.p(self:getPosition());
        local curPos = cc.pAdd(curPos, offset);
        self:setPosition(curPos);
    end
    return self;
end

function Node:seekNodeByName(name)
    local nodeName = self:getName();
    if (nodeName == name) then
        return self;
    end

    local children = self:getChildren();
    for i=1, #children do
        repeat
            local child = children[i];
            if (nil == child) then
                break;
            end

            local node = children[i]:seekNodeByName(name);
            if (nil == node) then
                break;
            end
            return node;
        until true
    end
    return nil;
end

function Node:insertToTable(array)
    if (nil == table) then
        return self;
    end
    table.insert(array, self);
    return self;
end

function Node:getRealSize()
    local size = self:getContentSize();
    local scaleX, scaleY = self:getScaleX(), self:getScaleY();
    local realSize = cc.size(size.width*scaleX, size.height*scaleY);
    return realSize;
end

--======================================事件
function Node:onTouchOne(call)
    local function isClick(touch, event)
        local target = event:getCurrentTarget();
        local s = target:getRealSize();
        local a = target:getAnchorPoint();
        local locationInNode = target:convertToNodeSpace(touch:getLocation());
        
        local rect = nil;
        if (target.getAnimation) then
            rect = cc.rect(-s.width*a.x, -s.height*a.y, s.width, s.height);
        else
            rect = cc.rect(0, 0, s.width, s.height);
        end
        
        if cc.rectContainsPoint(rect, locationInNode) then
            return true;
        end
        return false;
    end

    self:onEventTouchOne(self, 
        function (touch, event) --began
            return isClick(touch, event);
        end, 

        function (touch, event) --move
            
        end, 

        function (touch, event) --ended
            if (isClick(touch, event)) then
                if (call) then
                    call(event:getCurrentTarget());
                end
            end
        end, 
        
        function (touch, event) --cancel
            
        end);
    self.callback = call;
    return self;
end

function Node:onEventTouchOne(node, beganCall, moveCall, endedCall, cancelCall)
    local listener = cc.EventListenerTouchOneByOne:create();
    listener:setSwallowTouches(true)
    listener:registerScriptHandler(beganCall, cc.Handler.EVENT_TOUCH_BEGAN);
    listener:registerScriptHandler(moveCall, cc.Handler.EVENT_TOUCH_MOVED);
    listener:registerScriptHandler(endedCall, cc.Handler.EVENT_TOUCH_ENDED);
    listener:registerScriptHandler(cancelCall, cc.Handler.EVENT_TOUCH_CANCELLED);

    self:getEventDispatcher()
        :addEventListenerWithSceneGraphPriority(listener, node);

    if (nil == self.touchOneListeners) then
        self.touchOneListeners = {};
    end
    table.insert(self.touchOneListeners, listener);
    return self;
end

function Node:removeEventTouchOne()
    if (nil==self.touchOneListeners) 
        or (nil==next(self.touchOneListeners)) then
        return;
    end
    
    for i=1, #self.touchOneListeners do
        self:getEventDispatcher()
            :removeEventListener(self.touchOneListeners[i]);
    end
    self.touchOneListeners = nil;
    return self;
end

function Node:onEventKeyboard(pressedCall, releasedCall)
    local listener = cc.EventListenerKeyboard:create()
    listener:registerScriptHandler(function(keyCode, event)
        print(string.format("Key %d was pressed!", keyCode));
        if (pressedCall) then
            pressedCall(keyCode);
        end
    end, cc.Handler.EVENT_KEYBOARD_PRESSED);
    
    listener:registerScriptHandler(function(keyCode, event)
        print(string.format("Key %d was released!", keyCode));
        if (releasedCall) then
            releasedCall(keyCode);
        end
    end, cc.Handler.EVENT_KEYBOARD_RELEASED);

    self:getEventDispatcher()
        :addEventListenerWithSceneGraphPriority(listener, self);

    if (nil == self.keyboardListeners) then
        self.keyboardListeners = {};
    end
    table.insert(self.keyboardListeners, listener);
    return self;
end

function Node:removeEventKeyboard()
    if (nil==self.keyboardListeners) 
        or (nil==next(self.keyboardListeners)) then
        return;
    end
    
    for i=1, #self.keyboardListeners do
        self:getEventDispatcher()
            :removeEventListener(self.keyboardListeners[i]);
    end
    return self;
end

--======================================事件
--添加自定义事件 优先级为添加事件顺序
--支持广播(事件名相同)和单播
function Node:addCustomEvent(msg, method)
    local listener = cc.EventListenerCustom:create(msg, method);
    if (nil == listener) then
        return;
    end
    
    if (nil == self.customEventListeners) then
        self.customEventListeners = {};
    end
    table.insert(self.customEventListeners, listener);

    self:getEventDispatcher()
        :addEventListenerWithFixedPriority(listener, #self.customEventListeners);
end

function Node:sendCustomEvent(msg, data)
    local event = cc.EventCustom:new(msg);
    event._usedata = data;
    cc.Director:getInstance():getEventDispatcher():dispatchEvent(event);
end

--======================================定时器
function Node:addScheduler(call, interval, bPaused)
    if (nil == self.schedulerIdList) then
        self.schedulerIdList = {};
    end
    
    bPaused = bPaused or false;
    local scheduler = cc.Director:getInstance():getScheduler()

    local id = 0;
    id = scheduler:scheduleScriptFunc(function(dt)
        call(dt, id);
    end, interval, bPaused);
    table.insert(self.schedulerIdList, id);
    return id;
end

function Node:removeSchedulerByID(id)
    if (nil == self.schedulerIdList) then
        return;
    end

    local scheduler = cc.Director:getInstance():getScheduler();
    for i=1, #self.schedulerIdList do
        if (id == self.schedulerIdList[i]) then
            local id = table.remove(self.schedulerIdList, i);
            scheduler:unscheduleScriptEntry(id);
        end
    end
end

function Node:removeAllScheduler()
    if (nil == self.schedulerIdList) then
        return;
    end

    local scheduler = cc.Director:getInstance():getScheduler();
    for i=1, #self.schedulerIdList do
        scheduler:unscheduleScriptEntry(self.schedulerIdList[i]);
    end
    self.schedulerIdList = {};
end
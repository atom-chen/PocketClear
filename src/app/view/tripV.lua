local tripV = class("tripV", require("cocos.framework.extends.UIPanel"));

function tripV:onCreate()
    -- self.backkomTripIndex = self.M:getDataByKey("tripIndex"); --领取奖励的索引

    self.templateCell = self:seekNodeByName("template");
    self.templateCellSize = self.templateCell:getContentSize();
    self.sapce = cc.p(0, 5);
    
	--关闭按钮
	self:seekNodeByName("closeBtn")
		:setPressedActionEnabled(true)
		:onTouch(function(event)
			if ("ended" == event.name) then
				self:close();
			end
		end);

	--滚动条
    self.innerSize = cc.size(self.templateCellSize.width, #configTrip*(self.templateCellSize.height+self.sapce.y));
    self:seekNodeByName("ScrollView")
        :setClippingEnabled(true)
        :setInnerContainerSize(self.innerSize);

    --设置内容
    self:setCells();
end

function tripV:onDelete()
    for i=1, #configTrip do
        self:seekNodeByName("ScrollView")
            :seekNodeByName("cell" .. i)
            :removeAllScheduler();
    end
end

function tripV:setCells()
    for i=1, #configTrip do
        self:setCell(i);
    end
end

function tripV:setCell(index)
    -- local data = configTrip[index];
    -- 天数, 通过关卡, 结束时间, 道具表
    local day, cp, time, consumeReset, items = unpack(configTrip[index])

    local cell = self.templateCell:clone()
                     :show()
                     :setName("cell" .. index)
                     :addTo(self:seekNodeByName("ScrollView"))
                     :move(0, self.innerSize.height-index*(self.templateCellSize.height+self.sapce.y));

    --=========================================设置天数相关
    cell:seekNodeByName("dayCon")
        :seekNodeByName("day")
        :setString(math.floor(day/86400)+1);

    --=========================================设置通过关卡
    cell:seekNodeByName("font_cp")
        :seekNodeByName("cp")
        :setString(cp);

    --=========================================设置道具列表
    for i=1, #items do
        --获得道具数据
        local itemID, itemNum = unpack(items[i]);
        local itemData = configItem[itemID];

        --获得道具控件容器
        local itemCon = cell:seekNodeByName("itemCon" .. i)
                            :show();

        --设置图标
        itemCon:seekNodeByName("item")
               :loadTexture(itemData.icon, 1)

        --设置数量
        itemCon:seekNodeByName("num")
               :setString(":" .. itemNum);
    end

    --=========================================设置当前任务的状态
    self:updateTaskState(index, cell);
end

function tripV:updateTaskState(index)
    local cell = self:seekNodeByName("ScrollView")
                     :seekNodeByName("cell" .. index);

    local curTime = os.time();
    local startTime = self.M:getDataByKey({"tripTask", index, "startTime"}); --任务结束时间
    local endTime = self.M:getDataByKey({"tripTask", index, "endTime"}); --任务结束时间

    if (curTime < startTime) then --未激活任务
        cell:seekNodeByName("maskCon")
            :show();
    else
        --天数标签颜色设置
        cell:seekNodeByName("dayCon")
            :loadTexture("texture/trip/img_hentiaotou.png", 1);

        if (curTime>=startTime)and(curTime<=endTime) then --任务正在进行中
            cell:seekNodeByName("maskCon")
                :hide()

            local remainTime = endTime - os.time(); --任务剩余时间

            local timeCtrl = cell:seekNodeByName("timeCon")
                                 :seekNodeByName("font_time")
                                 :show()
                                 :seekNodeByName("time")
                                 :setString(golbal.formatTime(remainTime, true));
            timeCtrl.remainTime = remainTime; --剩余时间
            timeCtrl.counter = 1; --1秒计数器

            if (nil == cell.schedulerID) then
                cell.schedulerID = cell:addScheduler(function(dt, id)
                    timeCtrl.counter = timeCtrl.counter + dt;
                    if (timeCtrl.counter < 1) then
                        return;
                    end

                    timeCtrl.counter = 0;
                    timeCtrl.remainTime = timeCtrl.remainTime - 1;
                    timeCtrl:setString(golbal.formatTime(timeCtrl.remainTime, true));

                    if (timeCtrl.remainTime <= 0) then
                        cell:removeSchedulerByID(cell.schedulerID);
                        cell.schedulerID = nil;

                        self:sendCustomEvent(configMsg.trip_newTask, function()
                            cell:seekNodeByName("timeCon")
                                :seekNodeByName("font_time")
                                :hide();
                                
                            self:updateTaskState(index);
                            self:updateTaskState(index+1);
                        end);
                    end
                end, 0, false);
            end
        elseif(curTime > endTime) then --任务时间已过
            local isComplete = self.M:getDataByKey({"tripTask", index, "complete"}); --是否完成当前任务
            if (isComplete) then --任务完成
                local isGet = self.M:getDataByKey({"tripTask", index, "get"});
                if (isGet) then --已经获取道具
                    cell:seekNodeByName("maskCon")
                        :show()
                        :seekNodeByName("font_get")
                        :show();
                else --未获取道具
                    local timeCon = cell:seekNodeByName("timeCon")
                    
                    --显示获取按钮
                    timeCon:seekNodeByName("getBtn")
                           :show()
                           :onTouch(function(event)
                                if ("ended" == event.name) then
                                    local msgArr = {};
                                    table.insert(msgArr, index);
                                    table.insert(msgArr, function()
                                        event.target:hide();
                                        self:updateTaskState(index);
                                    end);
                                    self:sendCustomEvent(configMsg.trip_get, msgArr);
                                end
                           end);

                    --隐藏倒计时
                    timeCon:seekNodeByName("font_time")
                           :hide();
                end
            else --任务未完成
                --显示重置按钮
                cell:seekNodeByName("maskCon")
                    :show()
                    :seekNodeByName("resetBtn")
                    :show()
                    :setPressedActionEnabled(true)
                    :onTouch(function(event)
                        if ("ended" == event.name) then
                            local msgArr = {};
                            table.insert(msgArr, index);
                            table.insert(msgArr, function()
                                cell:seekNodeByName("maskCon")
                                    :hide()
                                    :seekNodeByName("resetBtn")
                                    :hide();
                                self:updateTaskState(index);
                            end);
                            self:sendCustomEvent(configMsg.trip_reset, msgArr);
                        end
                    end);
            end
        end
    end
end

return tripV;
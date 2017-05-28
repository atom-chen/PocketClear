local powerV = class("powerV", require("cocos.framework.extends.UIPanel"));

local ContextPanel = require("app.context.contextPanel");

function powerV:onCreate()
    self:seekNodeByName("closeBtn")
    	:setPressedActionEnabled(true)
        :onTouch(function(event)
            if ("ended" == event.name) then
                self:close();
            end
        end);

    self:setCountDown();
    self:setPowerSonCon();
end

function powerV:onDelete()

end

function powerV:setCountDown()
    local curPower = self.M:getDataByKey(golbal.power());
    if (curPower < golbal.powerLimit) then
        local endTime = self.M:getDataByKey("recoverEndTime");
        local remainTime = endTime - os.time()+1; --剩余总时间

        self:seekNodeByName("fullFont")
            :hide();
        local timeCtr = self:seekNodeByName("counterFont")
                            :show()
                            :seekNodeByName("time")
                            :setString(golbal.formatTime(remainTime, true));

        if (nil == self.schedulerID) then

            local counter = 0;
            self.schedulerID = self:addScheduler(function(dt, id)
                counter = counter + dt;
                if (counter < 1) then
                    return;
                end
                counter = 0;

                remainTime = remainTime - 1;
                timeCtr:setString(golbal.formatTime(remainTime, true));

                if (remainTime <= 0) then
                    self:removeSchedulerByID(self.schedulerID);
                    self.schedulerID = nil;
                    self:setCountDown();
                end
            end, 0, false);
        end
    else
        self:seekNodeByName("fullFont")
            :show();
        self:seekNodeByName("counterFont")
            :hide();
    end

    self:seekNodeByName("powerValue")
        :setString(curPower .. ";" .. golbal.powerLimit);
end

function powerV:setPowerSonCon()
    local itemIDs = {20, 21};
    for i=1, 2 do
        local num = self.M:getItem(itemIDs[i], "num");
        local con = self:seekNodeByName("itemCon" .. i);

        if (num > 0) then
            con:seekNodeByName("num")
               :show()
               :setString(":" .. num);
            con:seekNodeByName("priceCon")
               :hide();

            con:seekNodeByName("btn")
               :loadTextureNormal("texture/common/btn_blue.png", 1)
               :onTouch(function(event)
                   if ("ended" == event.name) then
                        local msgArr = {};
                        table.insert(msgArr, itemIDs[i]);
                        table.insert(msgArr, function(result)
                          if ("success" == result) then
                              self:setPowerSonCon();
                              self:setCountDown();
                          elseif ("fail" == result) then
                              require("app.module.msgBox.msgBox")
                                      :create(configPanel.msgBox_PowerFull);
                          end
                        end);
                        self:sendCustomEvent(configMsg.power_use, msgArr);
                   end
               end)
               :seekNodeByName("font")
               :loadTexture("texture/power/font_use.png", 1);
        else
            con:seekNodeByName("priceCon")
               :show();
            con:seekNodeByName("num")
               :hide();

            con:seekNodeByName("btn")
               :loadTextureNormal("texture/common/btn_red.png", 1)
               :onTouch(function(event)
                   if ("ended" == event.name) then
                        local msgArr = {};
                        table.insert(msgArr, itemIDs[i]);
                        table.insert(msgArr, function(result)
                            self:setPowerSonCon();
                        end);
                        self:sendCustomEvent(configMsg.power_buy, msgArr);
                   end
               end)
               :seekNodeByName("font")
               :loadTexture("texture/common/font_buy.png", 1);
        end
    end
end

return powerV;
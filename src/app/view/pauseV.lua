local pauseV = class("pauseV", require("cocos.framework.extends.UIPanel"));

local ContextPanel = require("app.context.contextPanel");
local ContextScene = require("app.context.contextScene");

function pauseV:onCreate()
    self.root = self:seekNodeByName("root");
    local curSceneName = display.getRunningScene():getName();

    --关闭按钮
    self:seekNodeByName("closeBtn")
    	:setPressedActionEnabled(true)
        :onTouch(function(event)
            if ("ended" == event.name) then
                self:close();
            end
        end);

    --根据不同场景调用不同初始化方法
    local method = self["setPanelIn" .. curSceneName];
    if (nil ~= method) then
        method(self);
    end
    
    --设置音乐开关UI
    local function setMusicFlagWithControl()
        local musicFlagImg = self:seekNodeByName("musicFlag");
        local musicFontImg = self:seekNodeByName("musicFont");
        if (self.M:getDataByKey("musicFlag")) then
            musicFlagImg:setVisible(true);
            musicFontImg:loadTexture("texture/pause/font_kai.png", 1);
        else
            musicFlagImg:setVisible(false);
            musicFontImg:loadTexture("texture/pause/font_guan.png", 1);
        end
    end
    setMusicFlagWithControl();

    --音乐开关按钮
    self:seekNodeByName("musicBtn")
        :setTouchEnabled(true)
        :onTouch(function(event)
            if ("ended" == event.name) then
                if (self.M:getDataByKey("musicFlag")) then
                    audio.setMusicVolume(0);
                else
                    audio.setMusicVolume(1);
                end
                self:sendCustomEvent(configMsg.pause_voiceFlag, "musicFlag");
                setMusicFlagWithControl();
            end
        end);

    --设置音效开关UI
    local function setSoundWithControl()
        local soundFlagImg = self:seekNodeByName("soundFlag");
        local soundFontImg = self:seekNodeByName("soundFont");
        if (self.M:getDataByKey("soundFlag")) then
            soundFlagImg:setVisible(true);
            soundFontImg:loadTexture("texture/pause/font_kai.png", 1);
        else
            soundFlagImg:setVisible(false);
            soundFontImg:loadTexture("texture/pause/font_guan.png", 1);
        end
    end
    setSoundWithControl();

    --设置音效按钮
    self:seekNodeByName("soundBtn")
        :setTouchEnabled(true)
        :onTouch(function(event)
            if ("ended" == event.name) then
                if (self.M:getDataByKey("soundFlag")) then
                    audio.setSoundsVolume(0);
                else
                    audio.setSoundsVolume(1);
                end
                --发送消息
                self:sendCustomEvent(configMsg.pause_voiceFlag, "soundFlag");
                setSoundWithControl();
            end
        end);

    --主场景暂停
    if ("main" == curSceneName) then
        self:sendCustomEvent(configMsg.pause_main, true);
    end
end

function pauseV:onDelete()
    --主场景暂停
    if ("main"==display.getRunningScene():getName()) then
        self:sendCustomEvent(configMsg.pause_main, false);
    end
    
    --设置ESC标记
    display.getRunningScene():setEscFlag(false);
end

function pauseV:setPanelInselectLevel()
    --继续游戏
    local goonGame = ccui.Button:create()
                        :setPressedActionEnabled(true)
                        :loadTextures("texture/common/btn_red.png", "", "", 1)
                        :setPosition(cc.p(260, 120))
                        :setScale(0.8)
                        :addTo(self.root)
                        :onTouch(function(event)
                            if ("ended" == event.name) then
                                self:close();
                            end                            
                        end);

    ccui.ImageView:create()
        :loadTexture("texture/common/font_jixuwan.png", 1)
        :setScale(1.4)
        :addTo(goonGame)
        :centerTo(goonGame, cc.p(26, 12));

    --恢复计费点
    local repeatBtn = ccui.Button:create()
                        :setPressedActionEnabled(true)
                        :loadTextures("texture/common/btn_blue.png", "", "", 1)
                        :setPosition(cc.p(260, 220))
                        :setScale(0.8)
                        :addTo(self.root)
                        :onTouch(function(event)
                            if ("ended" == event.name) then
                                golbal.lua2oc("Adapter", "iapRestore", {call=function(id)
                                    if ("xiong001"==id) then
                                        if (self.M:getDataByKey({"item", 102, "buyTime"})<1) then
                                            self.M:modifyDataByKey({"item", 102, "buyTime",}, 1);
                                        end
                                    end
                                end,});
                            end
                        end);

    ccui.ImageView:create()
        :loadTexture("texture/common/font_restore.png", 1)
        :setScale(1.2)
        :addTo(repeatBtn)
        :centerTo(repeatBtn, cc.p(26, 14));
end

function pauseV:setPanelInmain()
    --退出按钮
    local exitBtn = ccui.Button:create()
                        :setPressedActionEnabled(true)
                        :loadTextures("texture/common/btn_blue.png", "", "", 1)
                        :setPosition(cc.p(260, 120))
                        :setScale(0.8)
                        :addTo(self.root)
                        :onTouch(function(event)
                            if ("ended" == event.name) then
                                ContextScene:create("selectLevel");
                            end
                        end);

    ccui.ImageView:create()
        :loadTexture("texture/pause/font_tuichubenguan.png", 1)
        :setScale(1.4)
        :addTo(exitBtn)
        :centerTo(exitBtn, cc.p(26, 12));

    --重玩按钮
    local repeatBtn = ccui.Button:create()
                        :setPressedActionEnabled(true)
                        :loadTextures("texture/common/btn_red.png", "", "", 1)
                        :setPosition(cc.p(260, 220))
                        :setScale(0.8)
                        :addTo(self.root)
                        :onTouch(function(event)
                            if ("ended" == event.name) then
                                local curIndex = display.getRunningScene()
                                                        .M:getDataByKey("cpIndex");
                                ContextPanel:create("levelInfo", curIndex);
                            end                            
                        end);

    ccui.ImageView:create()
        :loadTexture("texture/pause/font_chongwanbenguan.png", 1)
        :setScale(1.4)
        :addTo(repeatBtn)
        :centerTo(repeatBtn, cc.p(26, 14));
end

return pauseV;
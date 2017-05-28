local signIn = class("signInV", require("cocos.framework.extends.UIPanel"));

local ContextPanel = require("app.context.contextPanel");
local Shader = require("app.tool.shader");

local boxOpenPNG = {"texture/singIn/ui_qiandao_baoxiang0_kai_icon.png", 
                    "texture/singIn/ui_qiandao_baoxiang1_kai_icon.png",
                    "texture/singIn/ui_qiandao_baoxiang2_kai_icon.png",
                    "texture/singIn/ui_qiandao_baoxiang3_kai_icon.png",};

function signIn:onCreate()
    self:setContentSize(display.size);

    self.nodeCon = self:seekNodeByName("nodeCon");

    -- self:seekNodeByName("closeBtn")
    --     :hide()
    --     :setPressedActionEnabled(true)
    --     :onTouch(function(event)
    --         if ("ended" == event.name) then
    --             self:close();
    --         end
    --     end);
    
    local getBtn = self:seekNodeByName("getBtn")
                    :setPressedActionEnabled(true)
                    :onTouch(function(event)
                        if ("ended" == event.name) then
                            self:sendCustomEvent(configMsg.signIn_sign, function(updateDay)
                                if (nil ~= updateDay) then 
                                    self:flyReward(updateDay);
                                    self:setDay(updateDay); --刷新当前签到
                                    self:setGetBtnFont(event.target); --刷新领取按钮字体
                                else
                                    self:close();
                                end
                            end);
                        end
                    end);
    
    --更新界面
    self:setDays();

    --更新按钮上的图片
    self:setGetBtnFont(getBtn);
end

function signIn:onDelete()
    require("app.context.contextPoint")
        :create("loginGift");
end

--领取按钮字体
function signIn:setGetBtnFont(target)
    -- local getBtn = self:seekNodeByName("getBtn");
    if (self.M:isSign()) then
        target:seekNodeByName("font")
              :setSpriteFrame("texture/singIn/font_guanbi.png");
    end
end

--设置某天签到奖励
function signIn:setDay(day)
    local curSignInIndex = self.M:getDataByKey("singInIndex"); --获取签到天数
    if (day <= curSignInIndex) then
        local node = self.nodeCon:seekNodeByName("node" .. day);
        if (0 == day%7) then
            node:setSpriteFrame(boxOpenPNG[day/7]);
        else
            node:setSpriteFrame("texture/singIn/ui_qiandao_qiandaodian_yiqiandao.png");
        end
    end
end

function signIn:setDays()
    for i=1, #configSingIn do
        self:setDay(i);
    end
end

function signIn:flyReward(day)
    local rewardCon = ccui.Layout:create()
                          :setContentSize(cc.size(CC_DESIGN_RESOLUTION.width, CC_DESIGN_RESOLUTION.height))
                          :addTo(self)
                          -- :centerTo(self, cc.p(0, 0))
                          :setTouchEnabled(true)
                          :setBackGroundColorType(1)
                          :setBackGroundColor(cc.c3b(0, 0, 0))
                          :setBackGroundColorOpacity(120)
                          :setOpacity(0)
                          :runAction(cc.Sequence:create(cc.FadeIn:create(0.1),
                                                        cc.DelayTime:create(1.0), 
                                                        cc.CallFunc:create(function(sender)
                                                            local counter = 0;
                                                            local children = sender:getChildren();
                                                            self:addScheduler(function(dt, id)
                                                                counter = counter + 1;
                                                                if (nil == children[counter]) then
                                                                    self:removeSchedulerByID(id);
                                                                    return;
                                                                end
                                                                
                                                                local startPos = children[counter]:convertToWorldSpace(cc.p(0, 0));
                                                                local endPos = cc.p(display.size.width*0.7, 0);
                                                                
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
                                                                table.insert(actions, cc.CallFunc:create(function(item, args)
                                                                    item:hide();
                                                                    if (args[1] == #children) then
                                                                        sender:removeSelf();
                                                                    end
                                                                end, {counter,}));
                                                                children[counter]:runAction(cc.Sequence:create(actions));
                                                                children[counter]:seekNodeByName("num")
                                                                                 :hide();
                                                            end, 0.2, false);
                                                        end)));

    local signData = configSingIn[day];
    local alignIcons = {};
    for i=1, #signData do
        local id, num = signData[i].id, signData[i].num;
        local itemData = configItem[id];
        local sprite = display.newSprite("#" .. itemData.icon)
                              :addTo(rewardCon)
                              :insertToTable(alignIcons);

        ccui.TextAtlas:create(configNumber._6)
            :setName("num")
            :setString(":" .. num)
            :move(sprite:getContentSize().width, 20)
            :addTo(sprite);
    end
    rewardCon:grid(alignIcons, {column=#alignIcons, space={x=40, y=0,}, offsetS=cc.size(0, 0)});
end

return signIn;
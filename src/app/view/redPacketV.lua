local redPacketV = class("redPacketV", require("cocos.framework.extends.UIPanel"));

local ContextPanel = require("app.context.contextPanel");

function redPacketV:onCreate()
  local layout = ccui.Layout:create()
                :setContentSize(display.size)
                :addTo(self);
    --5个红包的容器
    local panel = ccui.Layout:create()
                :setAnchorPoint(cc.p(0.5, 0.5))
                :setContentSize(cc.size(720, 250))
                :setPosition(cc.p(360, 600))
                :setBackGroundColorType(1)
                :setBackGroundColor(cc.c3b(0, 0, 0))
                :setBackGroundColorOpacity(0)
                :setTouchEnabled(true)
                :setVisible(false)
                :addTo(layout);

    --红包骨骼动画
    local armatureHongbao = ccs.Armature:create("chouhongbao")
                                        :addTo(layout)
                                        :setName("chouhongbao");

    --5个红包
    for i = 1, 5 do
        local red = ccui.ImageView:create("texture/redPacket/img_hongbao.png", 1)
                                  :setAnchorPoint(cc.p(0.5, 0.5))
                                  :setScale(0.9)
                                  :setTouchEnabled(true)
                                  :addTo(panel);
        if (1 == i) then
            red:setRotation(-15)
            red:setPosition(cc.p(120, 113));
        elseif (2 == i) then
            red:setRotation(-8)
            red:setPosition(cc.p(240, 134));
        elseif (3 == i) then
            red:setRotation(-0)
            red:setPosition(cc.p(360, 141));
        elseif (4 == i) then
            red:setRotation(8)
            red:setPosition(cc.p(480, 134));
        elseif (5 == i) then
            red:setRotation(15)
            red:setPosition(cc.p(600, 114));
        end

        local function callback(event)
            if ("ended" == event.name) then
                panel:setVisible(false);

                --播放弹红包骨骼动画
                armatureHongbao:move(370, 620)
                               :show()
                               :play("tanhongbao");
                self:runAction(cc.Sequence:create(cc.DelayTime:create(1.15), cc.CallFunc:create(function() 
                                layout:setVisible(false);
                                self:sendCustomEvent(configMsg.redSetDiamond, function(num)
                                  self:openRed(num);
                                end);
                            end))) 
            end
        end
        red:onTouch(callback)
    end
    --文字
    ccui.ImageView:create("texture/redPacket/font_chouquyigehongbao.png", 1)
                  :addTo(layout)
                  :move(cc.p(360, 900));

    --播放抽红包骨骼动画
    armatureHongbao:move(370, 600)
                   :play("chouhongbao");

    --手指骨骼动画
    self:runAction(cc.Sequence:create(cc.DelayTime:create(0.6), cc.CallFunc:create(function() 
                --播放手指骨骼动画
                local armatureHongbaoshou = ccs.Armature:create("chouhongbao")
                                                        :move(390, -20)
                                                        :addTo(panel)
                                                        :play("hongbaoshou");

                armatureHongbao:hide();
                panel:setVisible(true);
          end))) 
end

function redPacketV:openRed(value)
    local layout2 = ccui.Layout:create()
                               :setContentSize(display.size)
                               :addTo(self);

    --熊，文字，钻石图标
    ccui.ImageView:create("texture/redPacket/img_daomeixiongqianghongbao.png", 1)
                  :move(cc.p(360, 930))
                  :addTo(layout2);
    ccui.ImageView:create("texture/redPacket/font_gongxinihuodehongbao.png", 1)
                  :move(cc.p(360, 730))
                  :setScale(1.5)
                  :addTo(layout2);
    ccui.ImageView:create("texture/common/SC_zuanshi03.png", 1)
                  :move(cc.p(260, 502))
                  :setScale(1.8)
                  :addTo(layout2);
    --钻石数量
    ccui.TextAtlas:create(configNumber._13)
                  :setString(":" .. tostring(value))
                  :setScale(1.5)
                  :addTo(layout2)
                  :move(cc.p(440, 500));
    --领取按钮
    local lqBtn = ccui.Button:create()
                             :setPressedActionEnabled(true)
                             :setPosition(cc.p(360, 240))
                             :setScale(1.3)
                             :loadTextures("texture/common/btn_blue.png", "texture/common/btn_blue.png", "texture/common/btn_blue.png", 1)
                             :addTo(layout2);
    --按钮文字
    ccui.ImageView:create()
                  :loadTexture("texture/common/font_lingqu.png", 1)
                  :setPosition(cc.p(134, 47))
                  :setScale(1.4)
                  :addTo(lqBtn);
    local function close_CallBack(evet)
        if ("ended" == evet.name) then
            --点击领取后，增加钻石，设置新的倒计时时间
            self:sendCustomEvent(configMsg.redGetDiamond, function()
              -- 领取红包表现
              
            end);
            self:close();
        end
    end
    lqBtn:onTouch(close_CallBack);
end

return redPacketV;
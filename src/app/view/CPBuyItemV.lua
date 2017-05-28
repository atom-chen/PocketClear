local CPBuyItemV = class("CPBuyItemV", require("cocos.framework.extends.UIPanel"));

local ContextPanel = require("app.context.contextPanel");

function CPBuyItemV:onCreate()
	local itemData = configItem[self.M.id]; --当前道具配置

    --设置关闭按钮
    self:seekNodeByName("closeBtn")
    	:setPressedActionEnabled(true)
        :onTouch(function(event)
            if ("ended" == event.name) then
                self:close();
            end
        end);

    --设置购买按钮
    self:seekNodeByName("buyBtn")
        :setPressedActionEnabled(true)
        :onTouch(function(event)
            if ("ended" == event.name) then
                self:sendCustomEvent(configMsg.CPBuyItem_buy);
                self:close();
            end
        end);
        
    --设置道具图标
    self:seekNodeByName("itemIcon")
        :loadTexture(itemData.icon, 1)
        :setScale(1.4);

    --设置道具名字
    self:seekNodeByName("itemName")
        :loadTexture(itemData.title, 1)
        :ignoreContentAdaptWithSize(true)
        :setScale(1.2);

    --设置道具说明
    self:seekNodeByName("itemDes")
        :ignoreContentAdaptWithSize(true)
        :loadTexture(itemData.des, 1)
        :setScale(1.3);

    --修改道具数量后处理函数
    local modifyNum = function(value)
        self:sendCustomEvent(configMsg.CPBuyItem_modifyNum, {value, function(num)
            self:update(num);
        end});
    end
    
    --设置"+"按钮
    self:seekNodeByName("btn_jia")
        :setPressedActionEnabled(true)
        :onTouch(function(event)
            if ("ended" == event.name) then
                modifyNum(1);
            end
        end);

    --设置"-"按钮
    self:seekNodeByName("btn_jian")
        :setPressedActionEnabled(true)
        :onTouch(function(event)
            if ("ended" == event.name) then
                modifyNum(-1);
            end
        end);

    --初始化刷新界面
    self:update(1);
end

function CPBuyItemV:onDelete()
    
end

--根据购买道具数量更新面板
function CPBuyItemV:update(num)
    --设置数量显示
    self:seekNodeByName("num")
        :setString(num);

    --设置钻石消耗显示
    self:seekNodeByName("diamond")
        :setString(configItem[self.M.id].diamond*num);
end

return CPBuyItemV;
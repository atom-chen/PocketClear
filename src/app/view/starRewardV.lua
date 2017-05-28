local starRewardV = class("starRewardV", require("cocos.framework.extends.UIPanel"));

function starRewardV:onCreate()
    self.templateCell = self:seekNodeByName("template");
    self.templateCellSize = self.templateCell:getContentSize();
    self.sapce = cc.p(0, 3);

	--关闭按钮
	self:seekNodeByName("closeBtn")
		:setPressedActionEnabled(true)
		:onTouch(function(event)
			if ("ended" == event.name) then
				self:close();
			end
		end);

	--滚动条
    self.innerSize = cc.size(self.templateCellSize.width, #configStarReward*(self.templateCellSize.height+self.sapce.y));
    self:seekNodeByName("ScrollView")
        :setClippingEnabled(true)
        :setInnerContainerSize(self.innerSize);

    --设置内容
    self:setCells();
end

function starRewardV:onDelete()

end

function starRewardV:setCells()
    for i=1, #configStarReward do
        self:setCell(i);
    end
end

function starRewardV:setCell(index)
    local data = configStarReward[index];

    local cell = self.templateCell:clone()
                     :show()
                     :setName("cell" .. index)
                     :addTo(self:seekNodeByName("ScrollView"))
                     :move(0, self.innerSize.height-index*(self.templateCellSize.height+self.sapce.y));

    --设置星星数量
    cell:seekNodeByName("starNum")
        :setString(":" .. data.stars);

    --设置道具
    for i=1, #data.items do
        --获得道具数据
        local itemID, itemNum = data.items[i].id, data.items[i].num;
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

    --设置按钮
    local getBtn = cell:seekNodeByName("getBtn");
    local hasGetIndex = self.M:getDataByKey("starRewardIndex");
    if (index <= hasGetIndex) then
        getBtn:hide();

        cell:seekNodeByName("font_ylq")
            :show();
    else
        local curStarNum = self.M:getDataByKey(golbal.star());
        if (curStarNum >= data.stars) then
            getBtn:show()
                  :setPressedActionEnabled(true)
                  :onTouch(function(event)
                        if ("ended" == event.name) then
                            local msgArr = {};
                            table.insert(msgArr, index);
                            table.insert(msgArr, function()
                                self:setCell(index);
                            end);
                            self:sendCustomEvent(configMsg.starReward_get, msgArr);
                        end
                  end);
        else
            getBtn:hide();
        end
    end
end

return starRewardV;
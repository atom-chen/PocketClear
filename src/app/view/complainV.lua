local complainV = class("complainV", require("cocos.framework.extends.UIPanel"));
--投诉热线
function complainV:onCreate()
    self:seekNodeByName("closeBtn")
    	:setPressedActionEnabled(true)
        :onTouch(function(event)
            if ("ended" == event.name) then
                self:close();
            end
        end);
end

function complainV:onDelete()
    
end

return complainV;
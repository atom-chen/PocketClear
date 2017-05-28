local MsgBox_Normal = require("app.module.msgBox.msgBox_Normal");

local msgBox_Currency = class("msgBox_Currency", MsgBox_Normal);

function msgBox_Currency:specialInit()
	local poses = {cc.p(241, 248), cc.p(128, 178)};
	for i=1, #poses do
		ccui.ImageView:create(self.config.subType)
					  :addTo(self.root)
					  :move(poses[i]);
	end
end

return msgBox_Currency;
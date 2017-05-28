local mainActionV = class("mainActionV");

function mainActionV:ctor(model, root)
	self.M = model; --mainM
	self.root = root; --主场景结点

	self.nervousBGMFlag = false; --进入紧张背景音乐标记
	
	self.action = self.root:seekNodeByName("action")
						   :setString(self.M:getDataByKey("action").action);
end

function mainActionV:update(action)
	self.action:setString(action);

	if (self.M.state == CPSTATE.GAMEING) then
		if (ACTION.TIME == self.M.cpData.action.type) then
			if (10 == action) then
				audio.playSound(unpack(configAudio.sound_38));
			elseif (action < 10) then
				audio.playSound(unpack(configAudio.sound_37));
			end
		elseif (ACTION.STEP == self.M.cpData.action.type) then
			if (action<=5) then
				if (not self.nervousBGMFlag) then
					self.nervousBGMFlag = true;
					audio.playMusic(unpack(configAudio.music_4));
				end
			else
				if (self.nervousBGMFlag) then
					self.nervousBGMFlag = false;
					audio.playMusic(unpack(configAudio.music_2));
				end
			end
		end
	end
end

return mainActionV;
local LoadingBar = ccui.LoadingBar;

local tempCreate = LoadingBar.create;
function LoadingBar:create(ini)
	local inst = tempCreate(self);
	return inst;
end

local tempSetScale9Enabled = LoadingBar.setScale9Enabled;
function LoadingBar:setScale9Enabled(enabled)
	tempSetScale9Enabled(self, enabled);
	return self;
end

local tempSetPercent = LoadingBar.setPercent;
function LoadingBar:setPercent(percent)
	tempSetPercent(self, value);
	return self;
end
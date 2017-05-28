local Layout = ccui.Layout;

local tempSetBackGroundColorType = Layout.setBackGroundColorType;
function Layout:setBackGroundColorType(type)
	tempSetBackGroundColorType(self, type);
	return self;
end

local tempSetBackGroundColor = Layout.setBackGroundColor;
function Layout:setBackGroundColor(color)
	tempSetBackGroundColor(self, color);
	return self;
end

local tempSetBackGroundColorOpacity = Layout.setBackGroundColorOpacity;
function Layout:setBackGroundColorOpacity(opacity)
	tempSetBackGroundColorOpacity(self, opacity);
	return self;
end
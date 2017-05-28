local Label = cc.Label

local tempCreateWithSystemFont = Label.createWithSystemFont;
function Label:createWithSystemFont(str, size, font)
	local inst = tempCreateWithSystemFont(self, str, font, size);
	return inst;
end

local tempSetTextColor = Label.setTextColor;
function Label:setTextColor(c4b)
	tempSetTextColor(self, c4b);
	return self;
end

local tempSetString = Label.setString;
function Label:setString(str)
	tempSetString(self, str);
	return self;
end
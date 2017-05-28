local TextAtlas = ccui.TextAtlas;

local tempCreate = TextAtlas.create;
function TextAtlas:create(ini)
	local inst = tempCreate(self);
	inst:setProperty(ini);
	return inst;
end

local tempSetProperty = TextAtlas.setProperty;
function TextAtlas:setProperty(ini)
	tempSetProperty(self, unpack(ini));
	return self;
end

local tempSetString = TextAtlas.setString;
function TextAtlas:setString(value)
	tempSetString(self, value);
	return self;
end
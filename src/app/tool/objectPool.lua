local ObjectPool = class("ObjectPool");

function ObjectPool:ctor(objectFunc, initNum)
	self.objectFunc = objectFunc;
	self.pool = {};

	initNum = initNum or 0;
	for i=1, initNum do
		self:createObject();
	end
end

function ObjectPool:getSize()
	return #self.pool;
end

function ObjectPool:getObjects()
	return self.pool;
end

function ObjectPool:getObject()
	local object = self:findFreeObject();
	object.freeFlag = false;
	return object;
end

function ObjectPool:returnObject(object)
	object.freeFlag = true;
end

function ObjectPool:clear()
	self.objectFunc = nil;
	self.pool = nil;
end

function ObjectPool:findFreeObject()
	for i=1, #self.pool do
		local object = self.pool[i];
		if (object.freeFlag) then
			return object;
		end
	end
	return self:createObject();
end

function ObjectPool:createObject()
	local object = self.objectFunc();
	object.freeFlag = true;
	table.insert(self.pool, object);
	return object;
end

return ObjectPool;
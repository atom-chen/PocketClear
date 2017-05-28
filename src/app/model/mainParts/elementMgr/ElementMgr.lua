local ElementMgr = class("ElementMgr");

function ElementMgr:ctor(mainM)
	self.mainM = mainM;
	self.elements = {};

	if (self.onCreate) then
		self:onCreate();
	end
end

function ElementMgr:dector()

end

function ElementMgr:add(element)
	table.insert(self.elements, element);
end

function ElementMgr:remove(element)
	for i=1, #self.elements do
		if (element == self.elements[i]) then
			if (self.postRemove) then
				self:postRemove(element);
			end
			table.remove(self.elements, i);
			break;
		end
	end
end

-- function ElementMgr:loop()
	
-- end

-- function ElementMgr:loopEnd()
-- 	-- body
-- end

return ElementMgr;
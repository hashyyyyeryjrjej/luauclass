local Class = {
	className = 'Class'
}
Class.__index = Class

-- Returns all fields & methods inside self
function Class:inspect()
	local result = ''
	
	for index, value in self do
		result ..= string.format('%s: %s', index, value) .. "\n"
	end
	
	print(result)
end

-- Return class name on stringify
function Class:__tostring()
	return self.className
end

-- Works like a pseudo-removal by locking the table from editing
function Class:destroy()
	table.freeze(self)
end

-- Compare class to another with strings
function Class:is(otherClass: string)
	return tostring(self) == tostring(otherClass)
end

-- Base :new method; Doesn't serve much purpose except for occupying :new space on extensions
function Class:new()
	-- As to prevent using .new instead of :new
	if not self then
		warn('Desired class has no valid .new method; Did you forget to use ":"?')
		self = Class
	end
	
	return setmetatable({}, self)
end

-- Extension method to inherit fields & functions
function Class:extend()
	if not self then
		warn('No valid class to extend from; Did you forget to use ":"?')
		return
	end
	
	local object = {}
	object.__index = object
	object._inheritsFrom = tostring(self)
	
	return setmetatable(object, self)
end

return Class

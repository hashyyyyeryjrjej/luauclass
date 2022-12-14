local Class = {
	ClassName = 'Class'
}
Class.__index = Class

-- Works like a pseudo-removal by locking the table from editing
function Class:destroy()
	table.freeze(self)
end

-- Compare class to another with strings
function Class:is(otherClass)
	if typeof(otherClass) == 'table' then
		otherClass = otherClass.ClassName
	end

	return tostring(self) == otherClass
end

-- Base :new method; Doesn't serve much purpose except for occupying :new space on extensions
function Class.new(self)
	-- As to prevent using .new instead of :new
	if not self then
		warn( string.format('Class %s has no defined .new() method; Utilizing default Class .new()', self.ClassName) )
		self = Class
	end

	return setmetatable({}, self)
end

-- Makes a new object from the super
-- Good for making .new functions on inherited objects
function Class:newSuperClassObject(...)
	return setmetatable(self.__super.new(...), self)
end

-- Extension method to inherit fields & functions
function Class:extend()
	if not self then
		warn('No valid class to extend from; Did you forget to use ":"?')
		return
	end

	local object = {}
	object.__index = object
	object.__super = self

	return setmetatable(object, self)
end

-- Metamethods

-- Alias for :new
function Class:__call(...)
	return Class:new(...)
end

return Class

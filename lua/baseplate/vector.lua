local vectorMeta = {}

RegisterMetaTable( "Vector", vectorMeta )

function Vector( x, y, z )
	x = x or 0
	y = y or 0
	z = z or 0

	o = {
		x = tonumber(x),
		y = tonumber(y),
		z = tonumber(z)
	}

	setmetatable(o, vectorMeta)
	vectorMeta.__index = vectorMeta

	return o
end

--[[
	METHODS
]]--

function vectorMeta:Add( other )
	other = other or {}
	self.x = self.x + ( other.x or 0 )
	self.y = self.y + ( other.y or 0 )
	self.z = self.z + ( other.z or 0 )

	return self
end

function vectorMeta:Sub( other )
	other = other or {}
	self.x = self.x - ( other.x or 0 )
	self.y = self.y - ( other.y or 0 )
	self.z = self.z - ( other.z or 0 )

	return self
end

function vectorMeta:Cross( other )
	other = other or Vector()
	local vec = Vector()

	vec.x = ( self.y * other.z ) - ( other.y * self.z )
	vec.y = ( self.z * other.x ) - ( other.z * self.x )
	vec.z = ( self.x * other.y ) - ( other.x * self.y )

	return vec
end

function vectorMeta:Distance( other )
	other = other or Vector()
	local vec = self - other

	return vec:Length()
end

function vectorMeta:Dot( other )
	other = other or Vector()

	return (self.x  * other.x) + (self.y * other.y) + (self.z * other.z)
end

function vectorMeta:Length()
	return math.sqrt( (self.x * self.x) + (self.y * self.y) + (self.z * self.z) )
end

function vectorMeta:Normalize()
	local length = self:Length()

	self.x = self.x / length
	self.y = self.y / length
	self.z = self.z / length

	return self
end

function vectorMeta:GetNormalized()
	local new = Vector(self.x, self.y, self.z)
	new:Normalize()

	return new
end

--[[
	METAMETHODS
]]--

vectorMeta.__concat = function( vec )
	return tostring(vec.x .. ' ' .. vec.y .. ' ' .. vec.z)
end

vectorMeta.__tostring = function( vec )
	return tostring(vec.x .. ' ' .. vec.y .. ' ' .. vec.z)
end

-- ex.	Vector(1, 0, 0) + Vector(0, 0, 1) will return Vector(1, 0, 1)
vectorMeta.__add = function( left, right )
	left = left or {}
	right = right or {}

	local x = ( left.x or 0 ) + ( right.x or 0 )
	local y = ( left.y or 0 ) + ( right.y or 0 )
	local z = ( left.z or 0 ) + ( right.z or 0 )

	return Vector( x, y, z )
end

vectorMeta.__sub = function( left, right )
	left = left or {}
	right = right or {}

	local x = ( left.x or 0 ) - ( right.x or 0 )
	local y = ( left.y or 0 ) - ( right.y or 0 )
	local z = ( left.z or 0 ) - ( right.z or 0 )

	return Vector( x, y, z )
end

vectorMeta.__mul = function( left, right )
	left = left or {}
	right = right or 1

	local x = ( left.x or 0 ) * right
	local y = ( left.y or 0 ) * right
	local z = ( left.z or 0 ) * right

	return Vector( x, y, z )
end

vectorMeta.__div = function( left, right )
	left = left or {}
	right = right or 1

	local x = ( left.x or 0 ) / right
	local y = ( left.y or 0 ) / right
	local z = ( left.z or 0 ) / right

	return Vector( x, y, z )
end

vectorMeta.__pow = function( left, right )
	left = left or {}
	right = right or 1

	local x = ( left.x or 0 ) ^ right
	local y = ( left.y or 0 ) ^ right
	local z = ( left.z or 0 ) ^ right

	return Vector( x, y, z )
end

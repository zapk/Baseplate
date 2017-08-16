-- void	  Vector:Add( Vector other )
-- void	  Vector:Sub( Vector other )
-- vector	Vector:Cross( Vector other )
-- number	Vector:Distance( Vector other )
-- number	Vector:Dot( Vector other )
-- number	Vector:Length()
-- void	  Vector:Normalize()

-- You can also use operators on vectors to get results.
-- ex.		Vector(1, 0, 1) + Vector(1, 0, 0) is the same as Vector(2, 0, 1)
-- ex.		Vector(1, 0, 1) - Vector(1, 0, 0) is the same as Vector(0, 0, 1)
-- ex.		Vector(1, 0, 1) / 2 is the same as Vector(0.5, 0, 0.5)
-- ex.		Vector(1, 0, 1) * 2 is the same as Vector(2, 0, 2)
-- ex.		Vector(1, 0, 1) ^ 2 is the same as Vector(1, 0, 1) - exponential, 1 squared is 1 :P

-- tostring( Vector(1, 2, 3) ) will return "1 2 3"

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
	other = other or {}

	local crossProduct = con.VectorCross( tostring(self), tostring(other) )

	local x = tonumber( con.GetWord( crossProduct, 0 ) )
	local y = tonumber( con.GetWord( crossProduct, 1 ) )
	local z = tonumber( con.GetWord( crossProduct, 2 ) )

	return Vector( x, y, z )
end

function vectorMeta:Distance( other )
	other = other or {}

	return tonumber( con.VectorDist( tostring(self), tostring(other) ) )
end

function vectorMeta:Dot( other )
	other = other or {}

	return tonumber( con.VectorDot( tostring(self), tostring(other) ) )
end

function vectorMeta:Length()
	return tonumber( con.VectorLen( tostring(self) ) )
end

function vectorMeta:Normalize()
	local norm = con.VectorNormalize( tostring(self) )

	self.x = tonumber( con.GetWord( norm, 0 ) )
	self.y = tonumber( con.GetWord( norm, 1 ) )
	self.z = tonumber( con.GetWord( norm, 2 ) )

	return self
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

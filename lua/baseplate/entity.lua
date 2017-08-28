local entMeta = {}
entMeta.__index = entMeta

RegisterMetaTable( "Entity", entMeta )

------------------------------

-- an entity object should only ever have 1 table
-- this is so custom shit can be stored on entity tables
local stored = {}

local classDerivatives = {}
function DefineEntityDerivative(className, metaTable)
	assert(istable(metaTable))

	metaTable.__index = metaTable
	setmetatable(metaTable, entMeta)
	function metaTable:__tostring()
		return 'Entity(' .. self:GetClass() .. '): ' .. self:GetID()
	end

	classDerivatives[className] = metaTable
end

function Entity(objID)
	local o

	if stored[objID] then
		o = stored[objID]
	else
		o = {
			objID = objID
		}
		stored[objID] = o
	end

	setmetatable(o, entMeta)

	if classDerivatives[o:GetClass()] then
		setmetatable(o, classDerivatives[o:GetClass()])
	end

	return o
end

--[[
	METHODS
]]--

function entMeta:GetEngineObject()
	local sim = ts.obj( self.objID )
	assert(sim, 'entity in use has no engine object')
	return sim
end

function entMeta:IsValid()
	if not con.isObject(self.objID) or not ts.obj(self.objID) then
		return false
	end

	return true
end

function entMeta:GetClass()
	local sim = self:GetEngineObject()
	return ts.func('SimObject', 'getClassName')(sim)
end

function entMeta:GetID()
	return tonumber(self.objID)
end

function entMeta:GetName()
	local sim = self:GetEngineObject()
	return tostring(ts.func('SimObject', 'getName')( sim ))
end

function entMeta:SetName(name)
	local sim = self:GetEngineObject()
	ts.func('SimObject', 'setName')( sim, tostring(name) )
end

function entMeta:__tostring()
	return 'Entity(*' .. self:GetClass() .. '): ' .. self:GetID()
end

function entMeta:Delete()
	local sim = self:GetEngineObject()

	ts.func(self:GetClass(), 'delete')(sim)
	stored[self.objID] = nil
end

function entMeta:GetPos()
	local sim = self:GetEngineObject()

	local str = ts.func(self:GetClass(), 'getPosition')( sim )
	local x = tonumber( con.GetWord( str, 0 ) )
	local y = tonumber( con.GetWord( str, 1 ) )
	local z = tonumber( con.GetWord( str, 2 ) )

	return Vector( x, y, z )
end

function entMeta:SetPos( vectorPos )
	local sim = self:GetEngineObject()

	vectorPos = vectorPos or Vector( 0, 0, 0 )

	ts.func(self:GetClass(), 'setTransform')( sim, tostring( vectorPos ) )
end

function entMeta:GetVelocity()
	local sim = self:GetEngineObject()

	local str = ts.func(self:GetClass(), 'getVelocity')( sim )
	local x = tonumber( con.GetWord( str, 0 ) )
	local y = tonumber( con.GetWord( str, 1 ) )
	local z = tonumber( con.GetWord( str, 2 ) )

	return Vector( x, y, z )
end

function entMeta:SetVelocity( vectorVel )
	local sim = self:GetEngineObject()

	vectorVel = vectorVel or Vector( 0, 0, 0 )

	ts.func(self:GetClass(), 'setVelocity')( sim, tostring( vectorVel ) )
end

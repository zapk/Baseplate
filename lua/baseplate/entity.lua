local entMeta = {}
entMeta.__index = entMeta

RegisterMetaTable( "Entity", entMeta )

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

	assert(con.isObject(tonumber(objID)), 'no such entity')

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
	-- asterisk (*) signifying there is no handler for this class in Lua yet
	return 'Entity(*' .. self:GetClass() .. '): ' .. self:GetID()
end

function entMeta:Delete()
	local sim = self:GetEngineObject()

	ts.func(self:GetClass(), 'delete')(sim)
	stored[self.objID] = nil
end

function entMeta:Fire(funcName, ...)
	local sim = self:GetEngineObject()

	local func = ts.func(self:GetClass(), funcName)
	assert(func, 'Cannot fire function ' .. funcName)

	return func()(sim, ...)
end

function entMeta:GetPos()
	local sim = self:GetEngineObject()
	local sp = string.Split(ts.func(self:GetClass(), 'getPosition')( sim ), " ")
	return Vector( sp[1], sp[2], sp[3] )
end
entMeta.GetPosition = entMeta.GetPos

function entMeta:SetPos( vectorPos )
	local sim = self:GetEngineObject()

	vectorPos = vectorPos or Vector( 0, 0, 0 )

	ts.func(self:GetClass(), 'setTransform')( sim, tostring( vectorPos ) )
end
entMeta.SetPosition = entMeta.SetPos

function entMeta:GetVelocity()
	local sim = self:GetEngineObject()
	local sp = string.Split(ts.func(self:GetClass(), 'GetVelocity')( sim ), " ")
	return Vector( sp[1], sp[2], sp[3] )
end

function entMeta:SetVelocity( vectorVel )
	local sim = self:GetEngineObject()

	vectorVel = vectorVel or Vector()

	ts.func(self:GetClass(), 'SetVelocity')( sim, tostring( vectorVel ) )
end

function entMeta:GetForwardVector()
	local sim = self:GetEngineObject()
	local sp = string.Split(ts.func(self:GetClass(), 'GetForwardVector')( sim ), " ")
	return Vector( sp[1], sp[2], sp[3] )
end

function entMeta:GetUpVector()
	local sim = self:GetEngineObject()
	local sp = string.Split(ts.func(self:GetClass(), 'GetUpVector')( sim ), " ")
	return Vector( sp[1], sp[2], sp[3] )
end

function entMeta:GetScale()
	local sim = self:GetEngineObject()
	local sp = string.Split(ts.func(self:GetClass(), 'GetScale')( sim ), " ")
	return Vector( sp[1], sp[2], sp[3] )
end

function entMeta:SetScale( vectorScale )
	local sim = self:GetEngineObject()

	vectorScale = vectorScale or Vector()

	ts.func(self:GetClass(), 'SetScale')( sim, tostring( vectorScale ) )
end

function entMeta:GetWorldBox()
	local sim = self:GetEngineObject()
	local sp = string.Split(ts.func(self:GetClass(), 'GetWorldBox')( sim ), " ")
	return Vector( sp[1], sp[2], sp[3] ), Vector( sp[4], sp[5], sp[6] )
end

function entMeta:GetWorldBoxCenter()
	local sim = self:GetEngineObject()
	local sp = string.Split(ts.func(self:GetClass(), 'GetWorldBoxCenter')( sim ), " ")
	return Vector( sp[1], sp[2], sp[3] )
end

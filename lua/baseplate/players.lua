local playerMeta = {}
local clientMeta = FindMetaTable( "Client" )

RegisterMetaTable( "Player", playerMeta )

------------------------------

-- a player object should only ever have 1 table
-- this is so custom shit can be stored on player tables
local stored = {}

local function struct(objID)
	local o

	if stored[objID] then
		o = stored[objID]
	else
		o = {
			objID = objID
		}
	end

	setmetatable(o, playerMeta)
	playerMeta.__index = playerMeta

	return o
end

------------------------------

function clientMeta:HasPlayer()
	local sim = self:GetEngineObject()

	return con.isObject( sim.player )
end

function clientMeta:GetPlayer()
	local sim = self:GetEngineObject()

	assert(self:HasPlayer(), 'client has no player')
	
	return struct( ts.obj( sim.player ) )
end

--[[
	METHODS
]]--

function playerMeta:GetEngineObject()
	local sim = ts.obj( self.objID )
	assert(sim, 'player in use has no engine object')
	return sim
end

function playerMeta:HasClient()
	local sim = self:GetEngineObject()
	return con.isObject( sim.client )
end

function playerMeta:GetClient()
	local sim = self:GetEngineObject()

	assert(self:HasPlayer(), 'client has no player')

	local clisim = ts.obj( sim.client )
	local cli = clients.GetBySimID()
	return cli
end

function playerMeta:GetPosition()
	local sim = self:GetEngineObject()

	local tfunc = ts.func('Player', 'GetPosition')

	local str = tfunc( sim )
	local x = tonumber( con.GetWord( str, 0 ) )
	local y = tonumber( con.GetWord( str, 1 ) )
	local z = tonumber( con.GetWord( str, 2 ) )

	return Vector( x, y, z )
end

function playerMeta:SetPosition( vectorPos )
	local sim = self:GetEngineObject()

	vectorPos = vectorPos or Vector( 0, 0, 0 )

	local tfunc = ts.func('Player', 'SetTransform')

	tfunc( sim, tostring( vectorPos ) )
end

function playerMeta:GetVelocity()
	local sim = self:GetEngineObject()

	local tfunc = ts.func('Player', 'GetVelocity')

	local str = tfunc( sim )
	local x = tonumber( con.GetWord( str, 0 ) )
	local y = tonumber( con.GetWord( str, 1 ) )
	local z = tonumber( con.GetWord( str, 2 ) )

	return Vector( x, y, z )
end

function playerMeta:SetVelocity( vectorVel )
	local sim = self:GetEngineObject()

	vectorVel = vectorVel or Vector( 0, 0, 0 )

	local tfunc = ts.func('Player', 'SetVelocity')
	tfunc( sim, tostring( vectorVel ) )
end

function playerMeta:Kill()
	local sim = self:GetEngineObject()
	local tfunc = ts.func('Player', 'Kill')
	tfunc( sim )
end

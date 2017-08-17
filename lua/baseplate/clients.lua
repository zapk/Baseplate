local clientMeta = {}

RegisterMetaTable( "Client", clientMeta )

------------------------------

-- a client object should only ever have 1 table
-- this is so custom shit can be stored on client tables
local stored = {}

local function struct(objID)
	local o

	if stored[objID] then
		o = stored[objID]
	else
		o = {
			objID = objID
		}
		stored[objID] = o
	end

	setmetatable(o, clientMeta)
	clientMeta.__index = clientMeta

	return o
end

------------------------------

clients = {
	GetAll = function()
		local t = {}

		local getCount = ts.func( 'SimSet', 'getCount' )
		local getObject = ts.func( 'SimSet', 'getObject' )
		local ClientGroup = ts.obj( 'ClientGroup' )

		for i = 0, getCount( ClientGroup ) - 1 do
			local client = struct( tonumber(getObject( ClientGroup, i )) )
			table.insert(t, client)
		end

		return t
	end,

	GetByBLID = function( blid )
		blid = tonumber(blid)
		for k, v in pairs( clients.GetAll() ) do
			if v:GetBLID() == blid then
				return v
			end
		end

		return nil
	end,

	GetByName = function( name )
		name = tostring(name)
		for k, v in pairs( clients.GetAll() ) do
			if v:GetName() == name then
				return v
			end
		end

		return nil
	end,

	GetBySimID = function( objID )
		objID = tonumber(objID)
		for k, v in pairs( clients.Getall() ) do
			if v.objID == objID then
				return v
			end
		end

		return nil
	end
}

--[[
	METHODS
]]--

function clientMeta:__tostring()
	return 'Client: ' .. self:GetName()
end

function clientMeta:GetEngineObject()
	local sim = ts.obj( self.objID )
	assert(sim, 'client in use has no engine object')
	return sim
end

function clientMeta:GetName()
	local sim = self:GetEngineObject()
	local tfunc = ts.func('GameConnection', 'GetPlayerName')
	return tostring( tfunc( sim ) )
end

function clientMeta:GetBLID()
	local sim = self:GetEngineObject()
	local tfunc = ts.func('GameConnection', 'getBLID')
	return tonumber( tfunc( sim ) )
end

function clientMeta:InstantRespawn()
	local sim = self:GetEngineObject()
	local tfunc = ts.func('GameConnection', 'InstantRespawn')
	tfunc( sim )
end

function clientMeta:Play2D( profileName )
	local sim = self:GetEngineObject()
	local tfunc = ts.func('GameConnection', 'play2D')
	tfunc( sim, tostring( profileName ) )
end

function clientMeta:Play3D( profileName, vectorPos )
	local sim = self:GetEngineObject()
	local tfunc = ts.func('GameConnection', 'play3D')
	tfunc( sim, tostring( profileName ), tostring( vectorPos ) )
end

function clientMeta:SetScore( amount )
	local sim = self:GetEngineObject()
	local tfunc = ts.func('GameConnection', 'setScore')
	tfunc( sim, math.floor( amount ) )
end

function clientMeta:IncScore( amount )
	local sim = self:GetEngineObject()
	local tfunc = ts.func('GameConnection', 'incScore')
	tfunc( sim, math.floor( amount ) )
end

function clientMeta:SendMessage( ... )
	local sim = self:GetEngineObject()
	con.messageClient( self.objID, TagString(""), ... )
end

function clientMeta:SendMessageCallback( callback, ... )
	local sim = self:GetEngineObject()
	con.messageClient( self.objID, TagString(callback), ... )
end

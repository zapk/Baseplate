local meta = {}

RegisterMetaTable( "GameConnection", meta )
DefineEntityDerivative( "GameConnection", meta )

function meta:GetPlayerName()
	local sim = self:GetEngineObject()
	local tfunc = ts.func('GameConnection', 'GetPlayerName')
	return tostring( tfunc( sim ) )
end
meta.Nick = meta.GetPlayerName

function meta:GetBLID()
	local sim = self:GetEngineObject()
	local tfunc = ts.func('GameConnection', 'getBLID')
	return tonumber( tfunc( sim ) )
end

function meta:InstantRespawn()
	local sim = self:GetEngineObject()
	local tfunc = ts.func('GameConnection', 'InstantRespawn')
	tfunc( sim )
end

function meta:Play2D( profileName )
	local sim = self:GetEngineObject()
	local tfunc = ts.func('GameConnection', 'play2D')
	tfunc( sim, tostring( profileName ) )
end

function meta:Play3D( profileName, vectorPos )
	local sim = self:GetEngineObject()
	local tfunc = ts.func('GameConnection', 'play3D')
	tfunc( sim, tostring( profileName ), tostring( vectorPos ) )
end

function meta:SetScore( amount )
	local sim = self:GetEngineObject()
	local tfunc = ts.func('GameConnection', 'setScore')
	tfunc( sim, math.floor( amount ) )
end

function meta:IncScore( amount )
	local sim = self:GetEngineObject()
	local tfunc = ts.func('GameConnection', 'incScore')
	tfunc( sim, math.floor( amount ) )
end

function meta:SendMessage( ... )
	local sim = self:GetEngineObject()
	con.messageClient( self.objID, TagString(""), ... )
end

function meta:SendMessageCallback( callback, ... )
	local sim = self:GetEngineObject()
	con.messageClient( self.objID, TagString(callback), ... )
end

function meta:HasPlayer()
	local sim = self:GetEngineObject()

	return con.isObject( sim.player )
end

function meta:GetPlayer()
	local sim = self:GetEngineObject()

	assert(self:HasPlayer(), 'client has no player')

	return Entity( tonumber( sim.player ) )
end

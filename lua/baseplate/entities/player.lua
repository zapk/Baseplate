local playerMeta = {}

RegisterMetaTable( "Player", playerMeta )
DefineEntityDerivative( "Player", playerMeta )

function playerMeta:HasClient()
	local sim = self:GetEngineObject()
	return con.isObject( sim.client )
end

function playerMeta:GetClient()
	local sim = self:GetEngineObject()

	assert(self:HasClient(), 'player has no client')

	local clisim = ts.obj( sim.client )
	local cli = clients.GetBySimID()
	return cli
end

function playerMeta:Kill()
	local sim = self:GetEngineObject()
	local tfunc = ts.func('Player', 'Kill')
	tfunc( sim )
end

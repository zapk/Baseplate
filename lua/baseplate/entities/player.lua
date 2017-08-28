local meta = {}

RegisterMetaTable( "Player", meta )
DefineEntityDerivative( "Player", meta )

function meta:HasClient()
	local sim = self:GetEngineObject()
	return con.isObject( sim.client )
end

function meta:GetClient()
	local sim = self:GetEngineObject()

	assert(self:HasClient(), 'player has no client')

	local clisim = ts.obj( sim.client )
	local cli = clients.GetBySimID()
	return cli
end

function meta:Kill()
	local sim = self:GetEngineObject()
	local tfunc = ts.func('Player', 'Kill')
	tfunc( sim )
end

function meta:SetHeadUp( bool )
	local sim = self:GetEngineObject()
	ts.func('Player', 'SetHeadUp')( sim, bool )
end

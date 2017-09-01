clients = {}

function clients.GetAll()
	local t = {}

	local getCount = ts.func( 'SimSet', 'getCount' )
	local getObject = ts.func( 'SimSet', 'getObject' )
	local ClientGroup = ts.obj( 'ClientGroup' )

	for i = 0, getCount( ClientGroup ) - 1 do
		local client = Entity( tonumber(getObject( ClientGroup, i )) )
		table.insert(t, client)
	end

	return t
end

function clients.GetByBLID( blid )
	blid = tonumber(blid)
	for k, v in pairs( clients.GetAll() ) do
		if v:GetBLID() == blid then
			return v
		end
	end

	return nil
end

function clients.GetByName( name )
	name = tostring(name)
	for k, v in pairs( clients.GetAll() ) do
		if v:GetName() == name then
			return v
		end
	end

	return nil
end

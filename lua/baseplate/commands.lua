local clientMeta = FindMetaTable( "Client" )

------------------------------

function clientMeta:SendCommand( cmd, ... )
	local sim = ts.obj( self.objID )
	if sim == nil then
		return
	end

	local tag = con.addTaggedString( cmd )
	con.commandToClient( sim.id, tag, ... )
end

function BroadcastCommand( cmd, ... )
	for k, v in pairs( clients.GetAll() ) do
		v:SendCommand( cmd, ... )
	end
end

------------------------------

function clientMeta:SendMessage( str, ... )
	local sim = ts.obj( self.objID )
	if sim == nil then
		return
	end

	local tag = con.addTaggedString( str )
	con.messageClient( sim.id, tag, ... )
end

function BroadcastMessage( str, ... )
	for k, v in pairs( clients.GetAll() ) do
		v:SendMessage( str, ... )
	end
end

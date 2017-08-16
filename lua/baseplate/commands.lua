local clientMeta = FindMetaTable( "Client" )

------------------------------

function clientMeta:SendCommand( cmd, ... )
	local sim = self:GetEngineObject()

	local tag = con.addTaggedString( cmd )
	con.commandToClient( sim.id, tag, ... )
end

function BroadcastCommand( cmd, ... )
	for k, v in pairs( clients.GetAll() ) do
		v:SendCommand( cmd, ... )
	end
end

------------------------------

function TagString( str )
	return con.addTaggedString( tostring(str) )
end

function BroadcastMessageCallback( ... )
	for k, v in pairs( clients.GetAll() ) do
		v:SendMessage( ... )
	end
end

function BroadcastMessageCallback( callback, ... )
	for k, v in pairs( clients.GetAll() ) do
		v:SendMessage( callback, ... )
	end
end

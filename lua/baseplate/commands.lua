local clientMeta = FindMetaTable( "Client" )

commands = {}

local stored = {}

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

function BroadcastMessage( ... )
	for k, v in pairs( clients.GetAll() ) do
		v:SendMessage( ... )
	end
end

function BroadcastMessageCallback( callback, ... )
	for k, v in pairs( clients.GetAll() ) do
		v:SendMessageCallback( callback, ... )
	end
end

function commands.Register(name, callback)
	-- Command names must be alphanumeric and start with alpha
	assert(string.match(name, '^[a-zA-Z][a-zA-Z0-9]+$'), 'command name is incompatible with TorqueScript')
	assert(isfunction(callback), 'function expected')
	stored[name] = callback
	ts.eval([[
		function serverCmd]] .. name .. [[(%client,%a,%b,%c,%d,%e,%f,%g,%h,%i,%j,%k,%l,%m,%n,%o,%p) {
			luaCall("_baseplateCmd", "]] .. name .. [[", %client.getID(), %a,%b,%c,%d,%e,%f,%g,%h,%i,%j,%k,%l,%m,%n,%o,%p);
		}
	]])
end

function _baseplateCmd(name, clientSimID, ...)
	if stored[name] then
		local client = clients.GetBySimID(clientSimID)

		if client then
			stored[name](client, {...})
		end
	end
end

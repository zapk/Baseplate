local clientMeta = {}

RegisterMetaTable( "Client", clientMeta )

------------------------------

local function struct(objID)
	o = {
      objID = objID
   }
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
         local sim = ts.obj( getObject( ClientGroup, i ) )
         local client = struct( sim.id )
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

------------------------------

function clientMeta:GetName()
   local sim = ts.obj( self.objID )
   if sim == nil then
      return nil
   end

   local tfunc = ts.func('GameConnection', 'GetPlayerName')
   return tostring( tfunc( sim ) )
end

function clientMeta:GetBLID()
   local sim = ts.obj( self.objID )
   if sim == nil then
      return nil
   end

   local tfunc = ts.func('GameConnection', 'getBLID')
   return tonumber( tfunc( sim ) )
end

function clientMeta:InstantRespawn()
   local sim = ts.obj( self.objID )
   if sim == nil then
      return
   end

   local tfunc = ts.func('GameConnection', 'InstantRespawn')
   tfunc( sim )
end

function clientMeta:Play2D( profileName )
   local sim = ts.obj( self.objID )
   if sim == nil then
      return
   end

   local tfunc = ts.func('GameConnection', 'play2D')
   tfunc( sim, tostring( profileName ) )
end

function clientMeta:Play3D( profileName, vectorPos )
   local sim = ts.obj( self.objID )
   if sim == nil then
      return
   end

   local tfunc = ts.func('GameConnection', 'play3D')
   tfunc( sim, tostring( profileName ), tostring( vectorPos ) )
end

function clientMeta:SetScore( amount )
   local sim = ts.obj( self.objID )
   if sim == nil then
      return
   end

   local tfunc = ts.func('GameConnection', 'setScore')
   tfunc( sim, math.floor( amount ) )
end

function clientMeta:IncScore( amount )
   local sim = ts.obj( self.objID )
   if sim == nil then
      return
   end

   local tfunc = ts.func('GameConnection', 'incScore')
   tfunc( sim, math.floor( amount ) )
end

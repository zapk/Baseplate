local playerMeta = {}
local clientMeta = FindMetaTable( "Client" )

RegisterMetaTable( "Player", playerMeta )

local function struct(objID)
	o = {
      objID = objID
   }
	setmetatable(o, playerMeta)
	playerMeta.__index = playerMeta

	return o
end

ts.eval([[
	function GameConnection::getPlyID(%this) {
		return %this.player | 0;
	}
	function Player::getCliID(%this) {
		return %this.client | 0;
	}
]])

------------------------------

function clientMeta:HasPlayer()
   local sim = ts.obj( self.objID )
   if sim == nil then
      return nil
   end

   local tfunc = ts.func('GameConnection', 'getPlyID')
   return con.isObject( tfunc( sim ) )
end

function clientMeta:GetPlayer()
   local sim = ts.obj( self.objID )
   if sim == nil then
      return nil
   elseif not self:HasPlayer() then
		error( 'client has no player' )
      return
	end

   local tfunc = ts.func('GameConnection', 'getPlyID')
	local plysim = ts.obj( tfunc( sim ) )
	local ply = struct( plysim.id )
   return ply
end

--[[
   METHODS
]]--

function playerMeta:HasClient()
   local sim = ts.obj( self.objID )
   if sim == nil then
      return nil
   end

   local tfunc = ts.func('Player', 'getCliID')
   return con.isObject( tfunc( sim ) )
end

function playerMeta:GetClient()
   local sim = ts.obj( self.objID )
   if sim == nil then
      return nil
   elseif not self:HasPlayer() then
		error( 'client has no player' )
      return
	end

   local tfunc = ts.func('Player', 'getCliID')
	local clisim = ts.obj( tfunc( sim ) )
	local cli = clients.GetBySimID()
   return cli
end

function playerMeta:GetPosition()
   local sim = ts.obj( self.objID )
   if sim == nil then
      return nil
   end

   local tfunc = ts.func('Player', 'GetPosition')

	local str = tfunc( sim )
	local x = tonumber( con.GetWord( str, 0 ) )
   local y = tonumber( con.GetWord( str, 1 ) )
   local z = tonumber( con.GetWord( str, 2 ) )

   return Vector( x, y, z )
end

function playerMeta:SetPosition( vectorPos )
   local sim = ts.obj( self.objID )
   if sim == nil then
      return nil
   end

	vectorPos = vectorPos or Vector( 0, 0, 0 )

   local tfunc = ts.func('Player', 'SetTransform')

	tfunc( sim, tostring( vectorPos ) )
end

function playerMeta:GetVelocity()
   local sim = ts.obj( self.objID )
   if sim == nil then
      return nil
   end

   local tfunc = ts.func('Player', 'GetVelocity')

	local str = tfunc( sim )
	local x = tonumber( con.GetWord( str, 0 ) )
   local y = tonumber( con.GetWord( str, 1 ) )
   local z = tonumber( con.GetWord( str, 2 ) )

   return Vector( x, y, z )
end

function playerMeta:SetVelocity( vectorVel )
   local sim = ts.obj( self.objID )
   if sim == nil then
      return nil
   end

	vectorVel = vectorVel or Vector( 0, 0, 0 )

   local tfunc = ts.func('Player', 'SetVelocity')

	tfunc( sim, tostring( vectorVel ) )
end

function playerMeta:Kill()
   local sim = ts.obj( self.objID )
   if sim == nil then
      return
   end

   local tfunc = ts.func('Player', 'Kill')

   tfunc( sim )
end

--[[
   METAMETHODS
]]--

playerMeta.__eq = function( left, right )
   left = left or {}
   right = right or {}

	if not left.objID or not right.objID then
		return false
	end

	return left.objID == right.objID
end

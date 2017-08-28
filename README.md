# Baseplate
[![GitHub (pre-)release](https://img.shields.io/github/release/zapk/baseplate/all.svg)](https://github.com/zapk/baseplate/releases)

A set of essential libraries for working with Lua in Blockland.

## Installation

Place everything from this project inside your Blockland folder, and do:
```Lua
require('baseplate')
```

#### Requirements

- [BlocklandLoader](https://github.com/qoh/BlocklandLoader)
- [BlocklandLua](https://github.com/qoh/BlocklandLua)

## Table of contents

- [clients.lua](#clientslua)
- [colors.lua](#colorslua)
- [commands.lua](#commandslua)
- [hook.lua](#hooklua)
- [meta.lua](#metalua)
- [players.lua](#playerslua)
- [timer.lua](#timerlua)
- [utility.lua](#utilitylua)
- [vector.lua](#vectorlua)

## clients.lua
Library for handling Blockland clients with Lua.

```Lua
--[[table]]  clients.GetAll() -- returns a table of all clients.
--[[client]] clients.GetByBLID(blid) -- returns the client with that blid, or nil
--[[client]] clients.GetByName(name) -- returns the client with that name, or nil

--[[string]] Client:GetName()
--[[number]] Client:GetBLID()
--[[void]]   Client:InstantRespawn()
--[[void]]   Client:Play2D( string profileName )
--[[void]]   Client:Play3D( string profileName, vector pos )
--[[void]]   Client:SetScore( number amount )
--[[void]]   Client:IncScore( number amount )
--[[void]]   Client:SendMessage( ... )
--[[void]]   Client:SendMessageCallback( string callback, ... )
```
#### Example:
```Lua
local client = clients.GetByName('John')

print(client:GetName()) -- John
print(client:GetBLID()) -- 1337
client:Play3D('AlarmSound', Vector(6, 2, 3))

for k, v in pairs( clients.GetAll() ) do
  if v == client then
    print(v:GetName()) -- John
    print(v:GetBLID()) -- 1337
    v:SendMessage('Hello, John!')
    v:SendMessage(TagString('Hello, %1!'), 'John')
  end
end
```

## colors.lua
Colours used in TorqueScript messages (ex. \c1) do not work in Lua and will throw an error.

Baseplate exposes the global `color` (alias `colour` for real English) table for appending colours to chat strings.

ID | Name
-- | ----
0 | red
1 | blue
2 | green
3 | yellow
4 | cyan
5 | magenta `OR` purple
6 | white
7 | gray `OR` grey
8 | black

#### Example:
```Lua
BroadcastMessage(colors.red .. "This is red, " .. colors.blue .. "and this is blue!")
BroadcastMessage(colors[0] .. "This is red, " .. colors[1] .. "and this is blue!")
```

## commands.lua
Library for handling client/server commands and messages easily with Lua.

```Lua
--[[void]]  Client:SendCommand( string cmd, ... )
--[[void]]  BroadcastCommand( string cmd, ... )
--[[void]]  BroadcastMessage( ... )
--[[void]]  BroadcastMessageCallback( string callback, ... )
--[[void]]  commands.Register(name, callback) -- registers a slash command, see below for callback details
```
#### Example:
```Lua
local client = clients.GetByName('John')

client:SendCommand('MsgBoxOK', 'Hello', 'Just click "OK" please.') -- Sends a client command to the client.
client:SendMessage(colors.white .. 'This is white, ' .. client:GetName() .. '!') -- Sends a message to the client.

BroadcastMessageCallback('MsgAdminForce', colors.green .. 'Mr Queeba has become Super Admin (Auto)') -- Sends a message to all clients.

--adds /KillMe please
commands.Register('KillMe', function(client, args)
  if client:HasPlayer() and args[1] == "please" then
    client:GetPlayer():Kill()
    client:SendMessage(colors.white .. 'Since you asked nicely, ' .. colors.cyan .. client:GetName())
  end
end)
```

## hook.lua
Implements a simpler version of hooks from Garry's Mod.

```Lua
hook.Add( event, name, func ) -- adds a hook to be called when the event runs
hook.Remove( event, name ) -- removes a hook by name
hook.Run( event, ... ) -- calls all the hooks of a given event. if any of the hook functions return true, it stops
```

#### Default Hooks:

Event | Description
----- | -----------
Think | Called every frame or every tick on a dedicated server

## meta.lua
Simple library for working with important meta tables (such as Client, Player, Vector).
#### Example:
```Lua
local clientMeta = FindMetaTable( "Client" )
function clientMeta:IsJohn()
  if self:GetName() == "John" then
  return "Yup."
  else
  return "Barely."
  end
end

local client = clients.GetByName('John')
print(client:IsJohn()) -- Yup.
```

## players.lua
Library for handling Blockland players with Lua.

```Lua
--[[bool]]   Client:HasPlayer()
--[[player]] Client:GetPlayer()

--[[bool]]   Player:HasClient()
--[[client]] Player:GetClient()
--[[vector]] Player:GetPos()
--[[void]]   Player:SetPos( vector pos )
--[[vector]] Player:GetVelocity()
--[[void]]   Player:SetVelocity( vector vel )
--[[void]]   Player:Kill()
```
#### Example:
```Lua
local client = clients.GetByName('John')
local player = nil

if not client:HasPlayer() then return end
player = client:GetPlayer()

print( tostring( player:GetVelocity() ) ) -- 0 0 0
player:SetVelocity( Vector( 2, 4, 6 ) )
print( tostring( player:GetVelocity() ) ) -- 2 4 6

player:Kill()
```

## timer.lua
Timer library that hooks into Torque schedules.

```Lua
--[[void]]   timer.Simple( number delay, function callback )
```
#### Example:
```Lua
timer.Simple( 1, function()
  print('Hello!')
end )
-- Will print 'Hello!' in 1 second.
```

## utility.lua
Adds `isboolean, isnumber, isstring, isfunction, istable` for comparing types.
```Lua
--[[bool]]    IsValid(any) -- true if any:IsValid() exists and returns true
--[[number]]  CurTime() -- uptime in seconds; affected by timescale, lag, etc. good for timing game events
--[[number]]  RealTime() -- system time in seconds, not affected by the game
```

## vector.lua
Library for vectors that are easier to work with than Torque's. Similar to [Garry's Mod](http://wiki.garrysmod.com/page/Category:Vector).

```Lua
--[[void]]   Vector:Add( Vector other )
--[[void]]   Vector:Sub( Vector other )
--[[vector]] Vector:Cross( Vector other )
--[[number]] Vector:Distance( Vector other )
--[[number]] Vector:Dot( Vector other )
--[[number]] Vector:Length()
--[[void]]   Vector:Normalize()
--[[vector]] Vector:GetNormalized()

tostring( Vector(1, 2, 3) ) -- returns "1 2 3"
```
You can also use operators on vectors to get results.
```Lua
Vector(1, 0, 1) + Vector(1, 0, 0) -- is the same as Vector(2, 0, 1)
Vector(1, 0, 1) - Vector(1, 0, 0) -- is the same as Vector(0, 0, 1)
Vector(1, 0, 1) / 2 -- is the same as Vector(0.5, 0, 0.5)
Vector(1, 0, 1) * 2 -- is the same as Vector(2, 0, 2)
Vector(1, 0, 1) ^ 2 -- is the same as Vector(1, 0, 1) - exponential, 1 squared is 1 :P
```
#### Example:
```Lua
local vec = Vector(5, 10, 15)

print(tostring(vec)) -- 5 10 15
print(vec.x) -- 5
print(vec.y) -- 10
print(vec.z) -- 15

vec:Add( Vector(5, 0, 0) ) -- adds to the vector itself
print(tostring()) -- 10 10 15
```

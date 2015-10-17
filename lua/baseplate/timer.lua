-- usage:
-- timer(1000, function() print("hey") end)

if timerCount == nil then timerCount = 0 end
if timerTable == nil then timerTable = {} end

timer = {}

function _finishTimer( i )
   i = tonumber(i)
   timerTable[i]()
   timerTable[i] = nil
end

timer.Create = function( ms, f )
   local i = timerCount
   timerCount = timerCount + 1
   timerTable[i] = f
   local idx = con.schedule( ms, 0, 'luaCall', '_finishTimer', i )
   return idx
end

timer.Exists = function( idx )
   idx = math.floor( idx )
   return con.isEventPending( idx )
end

timer.Cancel = function( idx )
   idx = math.floor( idx )
   con.cancel( idx )
end

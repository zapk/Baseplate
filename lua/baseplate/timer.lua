-- usage:
-- timer(1000, function() print("hey") end)

if timerCount == nil then timerCount = 0 end
if timerTable == nil then timerTable = {} end

function finishTimer(i)
   i = tonumber(i)
   timerTable[i]()
   timerTable[i] = nil
end

function timer(t, f)
   local i = timerCount
   timerCount = timerCount + 1
   timerTable[i] = f
   con.schedule( t, 0, 'luaCall', 'finishTimer', i )
end

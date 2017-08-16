-- usage:
-- timer(1000, function() print("hey") end)

timerCount = timerCount or 0
timerTable = timerTable or {}

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
	return con.isEventPending( idx )
end

timer.Cancel = function( idx )
	con.cancel( idx )
end

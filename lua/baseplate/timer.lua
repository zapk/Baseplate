-- usage:
-- timer(1000, function() print("hey") end)

timerCount = timerCount or 0
timerTable = timerTable or {}

timer = {}

function _finishTimer( i )
  assert(timerTable[i])
	timerTable[i]()
	timerTable[i] = nil
end

function timer.Simple( delay, f )
	local i = timerCount
	timerCount = timerCount + 1
	timerTable[i] = f
	local idx = con.schedule( delay * 1000, 0, 'luaCall', '_finishTimer', i )
	return idx
end

function timer.Exists( idx )
	return con.isEventPending( idx )
end

function timer.Cancel( idx )
	con.cancel( idx )
end

function _baseplateThink()
  if timer._lastLoop then
    con.cancel(timer._lastLoop)
  end

  hook.Run('Think')

  timer._lastLoop = con.schedule( 1, 0, 'luaCall', '_baseplateThink' )
end

_baseplateThink()

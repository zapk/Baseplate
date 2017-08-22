timer = {}

local simpleTimers = {}

hook.Add('Think', 'baseplate.timer', function()
	local now = CurTime()
	for i, v in ipairs(simpleTimers) do
		if now >= v.finishTime then
			table.remove(simpleTimers, i)
			v.callback()
		end
	end
end)

function timer.Simple( delay, callback )
	table.insert(simpleTimers, {
		finishTime = CurTime() + delay,
		callback = callback
	})
end

function _baseplateThink()
  if timer._lastLoop then
    con.cancel(timer._lastLoop)
  end

  hook.Run('Think')

  timer._lastLoop = con.schedule( 1, 0, 'luaCall', '_baseplateThink' )
end

_baseplateThink()

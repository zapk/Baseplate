function isboolean(any)
  return type(any) == "boolean"
end

function isnumber(any)
  return type(any) == "number"
end

function isstring(any)
  return type(any) == "string"
end

function isfunction(any)
  return type(any) == "function"
end

function istable(any)
	return type(any) == "table"
end

function tobool(any)
	if ( any == nil or any == false or any == 0 or any == "0" or any == "false" ) then return false end
	return true
end

function IsValid(any)
	return istable(any) and any.IsValid and any:IsValid()
end

function CurTime()
  return tonumber(con.getSimTime()) / 1000
end

function RealTime()
  return tonumber(con.getRealTime()) / 1000
end

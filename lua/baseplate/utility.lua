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

function DumpTable(tab)
	for k, v in pairs(tab) do
		print(tostring(k) .. "   " .. tostring(v))
	end
end

function string.Split(input, delimiter)
  local result = { }
  local from  = 1
  local delim_from, delim_to = string.find( input, delimiter, from  )
  while delim_from do
    table.insert( result, string.sub( input, from , delim_from-1 ) )
    from  = delim_to + 1
    delim_from, delim_to = string.find( input, delimiter, from  )
  end
  table.insert( result, string.sub( input, from  ) )
  return result
end

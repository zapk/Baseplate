ents = {}

local allButBricksMask = 434109559
local _currentSearch
local function hasCurrentSearchUpdated()
	_currentSearch = tonumber(con.containerSearchNext())
	if _currentSearch > 0 then return true end
end

function ents.FindInSphere(origin, radius, mask)
	local t = {}
	mask = mask or -1

	con.initContainerRadiusSearch(tostring(origin), tonumber(radius), mask);

	while hasCurrentSearchUpdated() do
		local ent = Entity(_currentSearch)
		if IsValid(ent) then
			table.insert(t, ent)
		end
	end

	return t
end

function ents.GetAll()
	return ents.FindInSphere(Vector(), 2^1023)
end

-- significantly faster when you don't need to deal with tens of thousands of pesky bricks
function ents.GetAllButBricks()
	return ents.FindInSphere(Vector(), 2^1023, allButBricksMask)
end

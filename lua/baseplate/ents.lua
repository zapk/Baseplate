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

local classTypes = {
	Camera = "CameraObjectType",
	Player = "PlayerObjectType",
	Item = "ItemObjectType",
	WheeledVehicle = "VehicleObjectType",
	FlyingVehicle = "VehicleObjectType",
	fxDTSBrick = "FxBrickAlwaysObjectType",
	fxDayCycle = "EnvironmentObjectType",
	fxSunLight = "StaticRenderedObjectType",
	fxPlane = "TerrainObjectType",
	ParticleEmitterNode = "GameBaseObjectType",
	fxLight = "StaticTSObjectType",
	Projectile = "ProjectileObjectType"
}

function ents.FindByClass(class)
	local t = {}
	local mask = classTypes[class] and (ts.global["TypeMasks::" .. classTypes[class]]) or allButBricksMask

	for k, ent in pairs(ents.FindInSphere(Vector(), 2^1023, mask)) do
		if ent:GetClass() == class then
			table.insert(t, ent)
		end
	end

	return t
end

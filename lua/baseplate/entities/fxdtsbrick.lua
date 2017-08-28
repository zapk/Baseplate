local meta = {}

RegisterMetaTable( "fxDTSBrick", meta )
DefineEntityDerivative( "fxDTSBrick", meta )

function meta:GetDownBricks()
	local sim = self:GetEngineObject()
	local t = {}
	local count = tonumber(ts.func('fxDTSBrick', 'GetNumDownBricks')( sim ))

	for i = 0, count - 1 do
		local ent = Entity(ts.func('fxDTSBrick', 'GetDownBrick')( sim, i ))
		if IsValid(ent) then
			table.insert(t, ent)
		end
	end

	return t
end

function meta:GetUpBricks()
	local sim = self:GetEngineObject()
	local t = {}
	local count = tonumber(ts.func('fxDTSBrick', 'GetNumUpBricks')( sim ))

	for i = 0, count - 1 do
		local ent = Entity(ts.func('fxDTSBrick', 'GetUpBrick')( sim, i ))
		if IsValid(ent) then
			table.insert(t, ent)
		end
	end

	return t
end

function meta:GetAngleID()
	local sim = self:GetEngineObject()
	return tonumber(ts.func('fxDTSBrick', 'GetAngleID')( sim ))
end

function meta:GetColorID()
	local sim = self:GetEngineObject()
	return tonumber(ts.func('fxDTSBrick', 'GetColorID')( sim ))
end

function meta:GetPrintID()
	local sim = self:GetEngineObject()
	return tonumber(ts.func('fxDTSBrick', 'GetPrintID')( sim ))
end

function meta:GetColorFxID()
	local sim = self:GetEngineObject()
	return tonumber(ts.func('fxDTSBrick', 'GetColorFxID')( sim ))
end

function meta:GetShapeFxID()
	local sim = self:GetEngineObject()
	return tonumber(ts.func('fxDTSBrick', 'GetShapeFxID')( sim ))
end

function meta:IsBaseplate()
	local sim = self:GetEngineObject()
	return tobool(ts.func('fxDTSBrick', 'IsBaseplate')( sim ))
end

function meta:IsPlanted()
	local sim = self:GetEngineObject()
	return tobool(ts.func('fxDTSBrick', 'IsPlanted')( sim ))
end

function meta:IsDead()
	local sim = self:GetEngineObject()
	return tobool(ts.func('fxDTSBrick', 'IsDead')( sim ))
end

function meta:IsFakeDead()
	local sim = self:GetEngineObject()
	return tobool(ts.func('fxDTSBrick', 'IsFakeDead')( sim ))
end

function meta:GetFakeDeadTime()
	local sim = self:GetEngineObject()
	return tonumber(ts.func('fxDTSBrick', 'GetFakeDeadTime')( sim ))
end

function meta:SetTrusted( isTrusted )
	local sim = self:GetEngineObject()
	ts.func('fxDTSBrick', 'SetTrusted')( sim, isTrusted )
end

function meta:SetColor( id )
	local sim = self:GetEngineObject()
	ts.func('fxDTSBrick', 'SetColor')( sim, id )
end

function meta:SetColorFX( id )
	local sim = self:GetEngineObject()
	ts.func('fxDTSBrick', 'SetColorFX')( sim, id )
end

function meta:SetShapeFX( id )
	local sim = self:GetEngineObject()
	ts.func('fxDTSBrick', 'SetShapeFX')( sim, id )
end

function meta:GetDistanceFromGround()
	local sim = self:GetEngineObject()
	return tonumber(ts.func('fxDTSBrick', 'GetDistanceFromGround')( sim ))
end

function meta:HasPathToGround()
	local sim = self:GetEngineObject()
	return tobool(ts.func('fxDTSBrick', 'HasPathToGround')( sim ))
end

function meta:HasFakePathToGround()
	local sim = self:GetEngineObject()
	return tobool(ts.func('fxDTSBrick', 'HasFakePathToGround')( sim ))
end

function meta:IsExposed()
	local sim = self:GetEngineObject()
	return tobool(ts.func('fxDTSBrick', 'IsExposed')( sim ))
end

function meta:Kill()
	local sim = self:GetEngineObject()
	ts.func('fxDTSBrick', 'KillBrick')( sim )
end

function meta:SetColliding(val)
	local sim = self:GetEngineObject()
	ts.func('fxDTSBrick', 'SetColliding')( sim, val )
end

function meta:SetRendering(val)
	local sim = self:GetEngineObject()
	ts.func('fxDTSBrick', 'SetRendering')( sim, val )
end

function meta:SetRayCasting(val)
	local sim = self:GetEngineObject()
	ts.func('fxDTSBrick', 'SetRayCasting')( sim, val )
end

function meta:IsColliding()
	local sim = self:GetEngineObject()
	return tobool(ts.func('fxDTSBrick', 'IsColliding')( sim ))
end

function meta:IsRendering()
	local sim = self:GetEngineObject()
	return tobool(ts.func('fxDTSBrick', 'IsRendering')( sim ))
end

function meta:IsRayCasting()
	local sim = self:GetEngineObject()
	return tobool(ts.func('fxDTSBrick', 'IsRayCasting')( sim ))
end

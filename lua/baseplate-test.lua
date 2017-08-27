require('baseplate')

--------------------------------

for k, v in pairs(clients.GetAll()) do
	v:SendMessage(colors.white .. "Hello, " .. colors.green .. v:GetName())
	v:SendMessage(colors.white .. "Your BLID is " .. colors.green .. v:GetBLID())
end

--------------------------------

commands.Register('KillMe', function(client, args)
  if client:HasPlayer() and string.lower(args[1]) == "please" then
    client:GetPlayer():Kill()
  end
end)
--------------------------------


hook.Add('Think', 'baseplate-test.Think', function()
	for k, v in pairs(clients.GetAll()) do
		if v:HasPlayer() then
			local ply = v:GetPlayer()
			local pos = ply:GetPos()

			if pos.z > 2 then
				ply:Kill()
				v:SendMessage(colors.gray .. "Don't jump, that isn't polite.")
			end
		end
	end
end)

--------------------------------

timer.Simple(1, function()
	print("My my, it's been 1 second already?")
end)

--------------------------------

print(isboolean(false))
print(isnumber(2))
print(isstring("Two"))
print(isfunction(function()
	return 2
end))

--------------------------------

local vec = Vector(2, 4.1, 5.725)
print(vec)
vec:Add(Vector(100, 0, 0))
print(vec:Length())
vec:Normalize()
print(vec:Length())
print(vec.x)

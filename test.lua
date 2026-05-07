local player = game.Players.LocalPlayer

local function autoMove(character)
	local humanoid = character:WaitForChild("Humanoid")

	task.wait(1)

	-- nhích nhẹ
	humanoid:Move(Vector3.new(1,0,0), true)

	task.wait(0.2)

	-- dừng
	humanoid:Move(Vector3.zero, true)
end

if player.Character then
	autoMove(player.Character)
end

player.CharacterAdded:Connect(autoMove)

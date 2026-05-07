local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function nudge(character)
	local humanoid = character:WaitForChild("Humanoid")
	local root = character:WaitForChild("HumanoidRootPart")

	task.wait(1)

	-- đi nhích 2 stud về phía trước
	local targetPos = root.Position + root.CFrame.LookVector * 2

	humanoid:MoveTo(targetPos)
end

if player.Character then
	nudge(player.Character)
end

player.CharacterAdded:Connect(nudge)

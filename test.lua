-- LocalScript trong StarterPlayerScripts
local Players = game:GetService("Players")
local player = Players.LocalPlayer

player.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid")
    local hrp = character:WaitForChild("HumanoidRootPart")

    task.wait(2) -- đợi nhân vật spawn hoàn toàn

    -- Cách 1: MoveTo nhích nhẹ
    humanoid:MoveTo(hrp.Position + Vector3.new(0, 0, -0.5))

    -- Cách 2: SetWalkSpeed rồi Move
    -- humanoid:Move(Vector3.new(0,0,-1), true)
end)

-- LocalScript trong StarterPlayerScripts
local Players = game:GetService("Players")
local player = Players.LocalPlayer

player.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid")
    local hrp = character:WaitForChild("HumanoidRootPart")

    task.wait(2) -- đợi nhân vật load xong

    -- Tăng tốc độ đi bộ tạm thời
    humanoid.WalkSpeed = 8

    -- Cho nhân vật bước ra phía trước một chút
    humanoid:Move(Vector3.new(0,0,-1), true)

    -- Dừng sau 0.5 giây để chỉ nhích nhẹ
    task.wait(0.5)
    humanoid:Move(Vector3.new(0,0,0), true)
end)

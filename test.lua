-- LocalScript trong StarterPlayerScripts
local Players = game:GetService("Players")
local player = Players.LocalPlayer

player.CharacterAdded:Connect(function(character)
    local humanoid = character:WaitForChild("Humanoid")

    task.wait(2) -- đợi nhân vật spawn hoàn toàn

    -- Nhích nhẹ bằng cách gọi Move liên tục trong thời gian ngắn
    for i = 1, 10 do
        humanoid:Move(Vector3.new(0,0,-1), true) -- bước về phía trước
        task.wait(0.1)
    end
end)

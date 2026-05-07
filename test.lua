-- LocalScript trong StarterPlayerScripts
local Players = game:GetService("Players")

local player = Players.LocalPlayer

player.CharacterAdded:Connect(function(character)
    character:WaitForChild("HumanoidRootPart")

    -- Đợi nhân vật load xong
    task.wait(1)

    local hrp = character:FindFirstChild("HumanoidRootPart")
    if hrp then
        -- Dịch chuyển nhẹ về phía trước (nhích 0.5 stud)
        hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, -0.5)
    end
end)

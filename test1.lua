-- Chạy trong LocalScript
local playerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

for _, gui in ipairs(playerGui:GetDescendants()) do
    if gui:IsA("TextButton") and gui.Text == "PLAY NOW" then
        print(gui:GetFullName()) -- In ra đường dẫn đầy đủ
    end
end

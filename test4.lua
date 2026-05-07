local gui = game.Players.LocalPlayer.PlayerGui
local ls = gui:FindFirstChild("LoadingScreen")
if ls then
    local lf = ls:FindFirstChild("LoadingFrame")
    if lf then
        print("=== LoadingFrame children ===")
        for _, child in ipairs(lf:GetChildren()) do
            local txt = ""
            pcall(function() txt = child.Text end)
            print(child.ClassName .. " | " .. child.Name .. " | Visible=" .. tostring(child.Visible) .. " | Text='" .. txt .. "'")
        end
    else
        print("Khong co LoadingFrame!")
        for _, child in ipairs(ls:GetChildren()) do
            print("LS child: " .. child.ClassName .. " | " .. child.Name)
        end
    end
else
    print("Khong co LoadingScreen!")
end

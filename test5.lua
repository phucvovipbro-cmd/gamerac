local gui = game.Players.LocalPlayer.PlayerGui
local ls = gui:FindFirstChild("LoadingScreen")
if ls then
    print("Co LoadingScreen")
    local lf = ls:FindFirstChild("LoadingFrame")
    if lf then
        print("Co LoadingFrame")
        for _, child in ipairs(lf:GetDescendants()) do
            local txt = ""
            pcall(function() txt = child.Text end)
            if child:IsA("TextButton") or child:IsA("ImageButton") or child:IsA("Frame") then
                print(child.ClassName .. " | " .. child.Name .. " | Visible=" .. tostring(child.Visible) .. " | Text='" .. txt .. "' | Size=" .. tostring(child.AbsoluteSize))
            end
        end
    else
        print("KHONG co LoadingFrame, scan LoadingScreen:")
        for _, child in ipairs(ls:GetDescendants()) do
            local txt = ""
            pcall(function() txt = child.Text end)
            if child:IsA("TextButton") or child:IsA("ImageButton") then
                print(child.ClassName .. " | " .. child.Name .. " | Text='" .. txt .. "'")
            end
        end
    end
else
    print("KHONG co LoadingScreen!")
    for _, g in ipairs(gui:GetChildren()) do
        print("GUI child: " .. g.Name)
    end
end

-- Scan ReplicatedStorage + Workspace + PlayerGui
local function scan(obj)
    for _, v in pairs(obj:GetChildren()) do
        local ok, _ = pcall(function()
            if v:IsA("TextButton") or v:IsA("ImageButton") then
                print("[BUTTON] " .. tostring(v.Text) .. " | " .. v:GetFullName())
            end
            if v:IsA("ScreenGui") or v:IsA("Frame") or v:IsA("ScrollingFrame") then
                print("[GUI] " .. v.ClassName .. " | " .. v:GetFullName())
            end
        end)
        pcall(function() scan(v) end)
    end
end

print("=== PlayerGui ===")
scan(game.Players.LocalPlayer.PlayerGui)

print("=== ReplicatedStorage ===")
scan(game.ReplicatedStorage)

print("=== Workspace ===")
scan(game.Workspace)

print("DONE")

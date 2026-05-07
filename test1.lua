local gui = game.Players.LocalPlayer.PlayerGui

local function scan(obj)
    for _, v in pairs(obj:GetChildren()) do
        if v:IsA("TextButton") or v:IsA("ImageButton") then
            print(v.Text .. " | " .. v:GetFullName())
        end
        scan(v)
    end
end

scan(gui)
print("DONE")

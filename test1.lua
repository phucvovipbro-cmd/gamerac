local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")

local lp = Players.LocalPlayer
local pg = lp:FindFirstChild("PlayerGui")

if not pg then
    warn("Không tìm thấy PlayerGui")
    return
end

for _, v in pairs(pg:GetDescendants()) do
    if v.ClassName == "TextButton" then
        local txt = tostring(v.Text)

        if string.find(string.lower(txt), "play") then
            local path = v:GetFullName()
            warn("FOUND:", path)

            pcall(function()
                StarterGui:SetCore("SendNotification", {
                    Title = "FOUND PLAY",
                    Text = path,
                    Duration = 10
                })
            end)
        end
    end
end

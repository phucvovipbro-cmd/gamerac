local Players = game:GetService("Players")
local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

for _, v in ipairs(pg:GetDescendants()) do
    if v.ClassName == "TextButton" then
        warn("TEXTBUTTON |", v.Name, "|", v.Text, "|", v:GetFullName())
    end

    if v.ClassName == "ImageButton" then
        warn("IMAGEBUTTON |", v.Name, "|", v:GetFullName())
    end
end

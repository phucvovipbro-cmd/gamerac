local pg = game.Players.LocalPlayer.PlayerGui

for _, v in pairs(pg:GetDescendants()) do
    if v.ClassName == "TextButton" then
        warn("TEXTBUTTON:", v.Name, v.Text, v:GetFullName())
    end
    
    if v.ClassName == "TextLabel" then
        warn("TEXTLABEL:", v.Name, v.Text, v:GetFullName())
    end
    
    if v.ClassName == "ImageButton" then
        warn("IMAGEBUTTON:", v.Name, v:GetFullName())
    end
end

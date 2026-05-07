local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

for _,v in ipairs(PlayerGui:GetDescendants()) do
    if v:IsA("TextButton") then
        local text = v.Text or ""
        warn("BUTTON:", v.Name, "| TEXT:", text, "| PATH:", v:GetFullName())

        if string.lower(text) == "play now" then
            warn("FOUND PLAY NOW:", v:GetFullName())
        end
    elseif v:IsA("ImageButton") then
        warn("IMAGEBUTTON:", v.Name, "| PATH:", v:GetFullName())
    end
end

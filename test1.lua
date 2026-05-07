for _, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui:GetDescendants()) do
    if v:IsA("TextButton") and v.Text == "PLAY NOW" then
        print("Found Play Now button at:", v:GetFullName())
    end
end

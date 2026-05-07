for _,v in pairs(game.Players.LocalPlayer.PlayerGui:GetDescendants()) do
    if v:IsA("TextButton") then
        if string.lower(v.Text) == "play now" then
            
            game.StarterGui:SetCore("SendNotification",{
                Title = "FOUND PLAY NOW",
                Text = v:GetFullName(),
                Duration = 15
            })
            
        end
    end
end

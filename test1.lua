task.wait(5)

for _,v in pairs(game:GetDescendants()) do
    pcall(function()
        if v:IsA("TextButton") or v:IsA("TextLabel") then
            if v.Text == "PLAY NOW" then
                warn("FOUND:", v:GetFullName())
            end
        end
    end)
end

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local function findUIElements(parent, results)
    results = results or {}
    for _, child in ipairs(parent:GetChildren()) do
        if child:IsA("TextButton") or child:IsA("ImageButton") then
            local text = ""
            pcall(function() text = child.Text or "" end)
            if text ~= "" then
                table.insert(results, {
                    Name = child.Name,
                    Text = text,
                    ClassName = child.ClassName,
                    Path = child:GetFullName(),
                    Visible = child.Visible
                })
            end
        end
        findUIElements(child, results)
    end
    return results
end

task.wait(3)
print("===== BUTTONS ONLY =====")

local allElements = findUIElements(playerGui)

for _, elem in ipairs(allElements) do
    -- Chỉ in button đang Visible
    if elem.Visible then
        print("[BTN] '" .. elem.Text .. "' | " .. elem.Path)
    end
end

print("===== TOTAL: " .. #allElements .. " buttons =====")

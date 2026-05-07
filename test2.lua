-- Script lấy UI "PLAY NOW" và in ra Console (LocalScript)
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Hàm tìm kiếm đệ quy tất cả UI elements
local function findUIElements(parent, results)
    results = results or {}
    for _, child in ipairs(parent:GetChildren()) do
        -- Kiểm tra nếu là TextButton hoặc TextLabel
        if child:IsA("TextButton") or child:IsA("TextLabel") then
            table.insert(results, {
                Name = child.Name,
                Text = child.Text,
                ClassName = child.ClassName,
                Path = child:GetFullName()
            })
        end
        -- Đệ quy vào các children
        findUIElements(child, results)
    end
    return results
end

-- Chờ GUI load xong
task.wait(3)

print("===== SCANNING UI =====")

local allElements = findUIElements(playerGui)

for _, elem in ipairs(allElements) do
    -- Lọc riêng "PLAY NOW"
    if string.find(string.upper(elem.Text), "PLAY NOW") then
        print("[FOUND] PLAY NOW Button!")
        print("  Name     : " .. elem.Name)
        print("  Text     : " .. elem.Text)
        print("  Class    : " .. elem.ClassName)
        print("  FullPath : " .. elem.Path)
    else
        -- In tất cả UI còn lại
        print("[UI] " .. elem.ClassName .. " | Text: '" .. elem.Text .. "' | Path: " .. elem.Path)
    end
end

print("===== SCAN COMPLETE =====")

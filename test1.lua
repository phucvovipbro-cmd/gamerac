-- LocalScript - Safe UI Scanner cho Asura
local Players = game:GetService("Players")
local player = Players.LocalPlayer

print("[START] Waiting for PlayerGui...")

-- Chờ PlayerGui
local playerGui = player:WaitForChild("PlayerGui", 10)

if not playerGui then
    warn("[ERROR] PlayerGui not found!")
    return
end

-- Hàm tìm đệ quy an toàn
local function scanUI(parent, depth)
    depth = depth or 0
    local indent = string.rep("  ", depth)
    
    local ok, children = pcall(function()
        return parent:GetChildren()
    end)
    
    if not ok then return end
    
    for _, child in ipairs(children) do
        -- In tất cả elements
        local text = ""
        if child:IsA("TextButton") or child:IsA("TextLabel") then
            local ok2, t = pcall(function() return child.Text end)
            text = ok2 and t or "(error reading text)"
            
            -- Highlight PLAY NOW
            if string.find(string.upper(text), "PLAY") then
                warn(">>> [PLAY NOW FOUND] <<<")
                warn("    Name: " .. tostring(child.Name))
                warn("    Text: " .. tostring(text))
                warn("    Path: " .. tostring(child:GetFullName()))
            else
                print(indent .. "[" .. child.ClassName .. "] " .. child.Name .. ' | "' .. text .. '"')
            end
        else
            print(indent .. "[" .. child.ClassName .. "] " .. child.Name)
        end
        
        -- Đệ quy
        scanUI(child, depth + 1)
    end
end

-- Thử nhiều lần nếu GUI chưa load
for i = 1, 5 do
    print("[SCAN #" .. i .. "] Scanning PlayerGui...")
    
    local count = #playerGui:GetChildren()
    print("  Found " .. count .. " top-level GUI objects")
    
    if count > 0 then
        scanUI(playerGui)
        print("[DONE] Scan complete!")
        break
    else
        print("  GUI empty, waiting 2s...")
        task.wait(2)
    end
end

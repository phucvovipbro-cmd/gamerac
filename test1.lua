-- LocalScript: Chờ GUI load hoàn toàn rồi mới scan
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui", 15)

print("[ASURA SCANNER] Started...")

-- Hàm scan toàn bộ
local function scanForButtons(root)
    local found = {}
    local function recurse(obj)
        if not obj then return end
        local ok, kids = pcall(function() return obj:GetChildren() end)
        if not ok then return end
        for _, v in ipairs(kids) do
            if v:IsA("TextButton") or v:IsA("ImageButton") then
                local txt = ""
                pcall(function() txt = v.Text end)
                table.insert(found, {
                    text = txt,
                    name = v.Name,
                    path = v:GetFullName()
                })
            end
            recurse(v)
        end
    end
    recurse(root)
    return found
end

-- Chờ ít nhất 1 ScreenGui có nội dung
local function waitForGUI()
    for attempt = 1, 20 do
        task.wait(1)
        local guis = playerGui:GetChildren()
        for _, gui in ipairs(guis) do
            if gui:IsA("ScreenGui") then
                local buttons = scanForButtons(gui)
                if #buttons > 0 then
                    print("[ATTEMPT " .. attempt .. "] GUI Ready! Found " .. #buttons .. " buttons in: " .. gui.Name)
                    return true, buttons
                end
            end
        end
        print("[ATTEMPT " .. attempt .. "] Waiting... (" .. #guis .. " GUIs found so far)")
    end
    return false, {}
end

local success, buttons = waitForGUI()

if success then
    print("========== ALL BUTTONS ==========")
    for _, btn in ipairs(buttons) do
        local upper = string.upper(btn.text or "")
        if upper == "PLAY NOW" 
        or upper == "CLOSED COMMUNITY" 
        or upper == "PRIVATE SERVER" 
        or upper == "RANKED" then
            warn(">>> MENU BUTTON: [" .. btn.text .. "]")
            warn("    Path: " .. btn.path)
        else
            print("- [" .. btn.name .. '] Text: "' .. btn.text .. '"')
        end
    end
    print("=================================")
else
    warn("[FAIL] Could not find any buttons after 20 seconds.")
    warn("Try running the script again after game fully loads.")
end

-- find_play_now.lua
-- Script kiểm tra PlayerGui/CoreGui để tìm nút Play/Start/Ready chuẩn.
-- Chạy trong môi trường LocalScript trên Roblox.

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local VIM = game:GetService("VirtualInputManager")
local CoreGui = game:GetService("CoreGui")

local keywords = {"play", "start", "ready", "bắt", "bat", "enter", "join", "continue", "next"}

local function lower(text)
    return text and tostring(text):lower() or ""
end

local function hasKeyword(text)
    local t = lower(text)
    for _, kw in ipairs(keywords) do
        if t:find(kw) then
            return true
        end
    end
    return false
end

local function getTextValue(obj)
    if obj:IsA("TextButton") or obj:IsA("TextLabel") or obj:IsA("TextBox") then
        return obj.Text
    elseif obj:IsA("ImageButton") or obj:IsA("ImageLabel") then
        return obj.Name
    end
    return obj.Name
end

local function findClickableAncestor(obj, stopAt)
    local current = obj
    while current and current ~= stopAt do
        if current:IsA("GuiButton") then
            return current
        end
        current = current.Parent
    end
    return nil
end

local function scanContainer(root)
    local candidates = {}
    for _, obj in ipairs(root:GetDescendants()) do
        if obj:IsA("GuiObject") and obj.Visible then
            local nameMatch = hasKeyword(obj.Name)
            local textMatch = hasKeyword(getTextValue(obj))
            if nameMatch or textMatch then
                local clickable = obj:IsA("GuiButton") and obj or findClickableAncestor(obj, root)
                table.insert(candidates, {
                    object = obj,
                    path = obj:GetFullName(),
                    className = obj.ClassName,
                    text = getTextValue(obj),
                    clickable = clickable and clickable:GetFullName() or "(none)",
                    rootName = root.Name,
                })
            end
        end
    end
    return candidates
end

local function FindPlayButton()
    if not player then
        warn("LocalPlayer không tồn tại. Chỉ chạy dưới client (LocalScript).")
        return nil
    end

    local allCandidates = {}
    local gui = player:FindFirstChild("PlayerGui")
    if gui then
        for _, c in ipairs(scanContainer(gui)) do
            table.insert(allCandidates, c)
        end
    else
        warn("PlayerGui chưa tồn tại.")
    end

    local coreCandidates = scanContainer(CoreGui)
    for _, c in ipairs(coreCandidates) do
        table.insert(allCandidates, c)
    end

    if #allCandidates == 0 then
        return nil
    end

    for _, data in ipairs(allCandidates) do
        print(string.format("[PlayCandidate][%s] path=%s class=%s text=%s clickable=%s",
            data.rootName, data.path, data.className, tostring(data.text), data.clickable))
    end

    for _, data in ipairs(allCandidates) do
        if data.object:IsA("GuiButton") or data.object:IsA("ImageButton") then
            return data.object
        end
    end

    for _, data in ipairs(allCandidates) do
        local clickable = findClickableAncestor(data.object, player.PlayerGui or CoreGui)
        if clickable then
            return clickable
        end
    end

    return allCandidates[1].object
end

local function clickButton(button)
    if not button then
        warn("Không có nút để click")
        return false
    end
    pcall(function()
        if button.Activate then
            button:Activate()
        end
    end)
    if button.AbsolutePosition and button.AbsoluteSize then
        local x = button.AbsolutePosition.X + button.AbsoluteSize.X / 2
        local y = button.AbsolutePosition.Y + button.AbsoluteSize.Y / 2
        pcall(function()
            VIM:SendMouseButtonEvent(x, y, 0, true, game, 0)
            task.wait(0.05)
            VIM:SendMouseButtonEvent(x, y, 0, false, game, 0)
        end)
    else
        warn("Button không có AbsolutePosition/AbsoluteSize: " .. button:GetFullName())
    end
    print("Đã thử click lên: " .. button:GetFullName())
    return true
end

local function Run()
    print("========== Find Play Now Script ==========")
    if not player then
        warn("Không tìm được LocalPlayer. Chỉ chạy LocalScript.")
        return
    end

    local gui = player:WaitForChild("PlayerGui", 10)
    if not gui then
        warn("Không tìm được PlayerGui sau 10s")
        return
    end

    local button = FindPlayButton()
    if not button then
        warn("Không tìm thấy Play/Start button nào trong PlayerGui/CoreGui")
        return
    end

    print("Tìm thấy button: " .. button:GetFullName() .. " class=" .. button.ClassName)
    clickButton(button)
end

Run()

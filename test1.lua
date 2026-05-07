-- find_play_now.lua
-- Script kiểm tra PlayerGui để tìm Play/Start/Ready button chuẩn.
-- Chạy trong môi trường LocalScript trên Roblox.

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local VIM = game:GetService("VirtualInputManager")

local keywords = {"play", "start", "ready", "bắt", "bat", "enter"}

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

local function FindPlayButton()
    local gui = player:FindFirstChild("PlayerGui")
    if not gui then
        warn("PlayerGui chưa tồn tại")
        return nil
    end

    local candidates = {}

    for _, obj in ipairs(gui:GetDescendants()) do
        if obj.Visible then
            local nameMatch = hasKeyword(obj.Name)
            local textMatch = hasKeyword(obj:IsA("TextButton") and obj.Text or obj:IsA("TextLabel") and obj.Text or obj:IsA("ImageLabel") and obj.Name or obj.Name)
            if nameMatch or textMatch then
                local clickable = obj:IsA("GuiButton") and obj or findClickableAncestor(obj, gui)
                table.insert(candidates, {
                    object = obj,
                    path = obj:GetFullName(),
                    className = obj.ClassName,
                    text = (obj:IsA("TextButton") or obj:IsA("TextLabel")) and obj.Text or "",
                    clickable = clickable and clickable:GetFullName() or "(none)",
                })
            end
        end
    end

    if #candidates == 0 then
        return nil
    end

    for _, data in ipairs(candidates) do
        print("[PlayCandidate] ", data.path, "class=", data.className, "text=", data.text, "clickable=", data.clickable)
    end

    -- Ưu tiên GuiButton hoặc ImageButton trực tiếp có keyword
    for _, data in ipairs(candidates) do
        if data.object:IsA("GuiButton") then
            return data.object
        end
    end

    -- Nếu có clickable ancestor thì trả về button đó
    for _, data in ipairs(candidates) do
        local obj = data.object
        local clickable = findClickableAncestor(obj, gui)
        if clickable then
            return clickable
        end
    end

    -- Trả về candidate đầu tiên nếu không có button rõ ràng
    return candidates[1].object
end

local function ClickButton(button)
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
    end
    print("Đã thử click lên: ", button:GetFullName())
    return true
end

local function Run()
    print("========== Find Play Now Script ==========")
    local gui = player:WaitForChild("PlayerGui", 10)
    if not gui then
        warn("Không tìm được PlayerGui sau 10s")
        return
    end

    local button = FindPlayButton()
    if not button then
        warn("Không tìm thấy Play/Start button nào")
        return
    end

    print("Tìm thấy button: ", button:GetFullName(), " class=", button.ClassName)
    ClickButton(button)
end

Run()

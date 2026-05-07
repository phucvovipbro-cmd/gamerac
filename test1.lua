local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local pg = player:WaitForChild("PlayerGui")

local gui = Instance.new("ScreenGui")
gui.Parent = pg

local label = Instance.new("TextLabel")
label.Parent = gui
label.Size = UDim2.new(1,0,0,40)
label.BackgroundColor3 = Color3.new(0,0,0)
label.TextColor3 = Color3.new(1,1,1)
label.TextScaled = true
label.Text = "Tap GUI để inspect"

local function scan()
    for _,v in pairs(pg:GetDescendants()) do
        if v:IsA("GuiObject") then
            
            v.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.Touch then
                    
                    label.Text = v:GetFullName()
                    warn(v:GetFullName())
                    
                end
            end)
            
        end
    end
end

scan()

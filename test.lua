local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local safezone = true

humanoid.Running:Connect(function(speed)
	if speed > 0 and safezone then
		safezone = false
		print("Đã rời safezone!")
		
		-- Ví dụ:
		-- tắt forcefield
		-- bật PvP
	end
end)

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local DB = "https://huy-antiafk-default-rtdb.asia-southeast1.firebasedatabase.app"

-- UI
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "HuyAntiAFK_UI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.fromScale(0.25, 0.2)
frame.Position = UDim2.fromScale(0.05, 0.3)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Size = UDim2.fromScale(1, 0.25)
title.Text = "Huy Anti-AFK"
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextScaled = true

local function makeLabel(text, y)
	local lbl = Instance.new("TextLabel", frame)
	lbl.Position = UDim2.fromScale(0, y)
	lbl.Size = UDim2.fromScale(1, 0.25)
	lbl.Text = text
	lbl.TextColor3 = Color3.fromRGB(200,200,200)
	lbl.BackgroundTransparency = 1
	lbl.Font = Enum.Font.Gotham
	lbl.TextScaled = true
	return lbl
end

local totalUsersLbl = makeLabel("Total Users: ...", 0.25)
local totalChecksLbl = makeLabel("Total Checks: ...", 0.5)
local activeUsersLbl = makeLabel("Active Users: ...", 0.75)

-- Update UI
task.spawn(function()
	while true do
		local data = HttpService:JSONDecode(game:HttpGet(DB.."/stats.json"))
		if data then
			totalUsersLbl.Text = "Total Users: "..data.totalUsers
			totalChecksLbl.Text = "Total Checks: "..data.totalChecks
			activeUsersLbl.Text = "Active Users: "..data.activeUsers
		end
		task.wait(5)
	end
end)

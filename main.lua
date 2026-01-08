--// Huy Anti-AFK | Main.lua
--// Full version: Key GUI + Main GUI + Icon

repeat task.wait() until game:IsLoaded()

-- SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local VU = game:GetService("VirtualUser")
local LP = Players.LocalPlayer

-- ANTI AFK CORE
LP.Idled:Connect(function()
	VU:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
	task.wait(1)
	VU:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- GUI ROOT
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HuyAntiAFK"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

--==============================
-- ICON
--==============================
local Icon = Instance.new("TextButton")
Icon.Parent = ScreenGui
Icon.Size = UDim2.new(0,50,0,50)
Icon.Position = UDim2.new(0,30,0.5,-25)
Icon.Text = "🛡️"
Icon.TextSize = 24
Icon.BackgroundColor3 = Color3.fromRGB(40,40,40)
Icon.TextColor3 = Color3.new(1,1,1)
Icon.BorderSizePixel = 0
Icon.Visible = false
Icon.Active = true
Icon.Draggable = true

--==============================
-- KEY GUI
--==============================
local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0,320,0,220)
KeyFrame.Position = UDim2.new(0.5,-160,0.5,-110)
KeyFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
KeyFrame.BorderSizePixel = 0
KeyFrame.Active = true
KeyFrame.Draggable = true

local KeyTitle = Instance.new("TextLabel", KeyFrame)
KeyTitle.Size = UDim2.new(1,0,0,40)
KeyTitle.Text = "🔐 Huy Anti-AFK"
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 18
KeyTitle.TextColor3 = Color3.new(1,1,1)
KeyTitle.BackgroundTransparency = 1

local KeyBox = Instance.new("TextBox", KeyFrame)
KeyBox.Size = UDim2.new(1,-40,0,40)
KeyBox.Position = UDim2.new(0,20,0,60)
KeyBox.PlaceholderText = "Enter your key..."
KeyBox.Text = ""
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 14
KeyBox.BackgroundColor3 = Color3.fromRGB(35,35,35)
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.BorderSizePixel = 0

local GetKeyBtn = Instance.new("TextButton", KeyFrame)
GetKeyBtn.Size = UDim2.new(1,-40,0,35)
GetKeyBtn.Position = UDim2.new(0,20,0,110)
GetKeyBtn.Text = "🌐 Get Key"
GetKeyBtn.Font = Enum.Font.GothamBold
GetKeyBtn.TextSize = 14
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
GetKeyBtn.TextColor3 = Color3.new(1,1,1)
GetKeyBtn.BorderSizePixel = 0

local VerifyBtn = Instance.new("TextButton", KeyFrame)
VerifyBtn.Size = UDim2.new(1,-40,0,35)
VerifyBtn.Position = UDim2.new(0,20,0,155)
VerifyBtn.Text = "✅ Verify Key"
VerifyBtn.Font = Enum.Font.GothamBold
VerifyBtn.TextSize = 14
VerifyBtn.BackgroundColor3 = Color3.fromRGB(0,170,100)
VerifyBtn.TextColor3 = Color3.new(1,1,1)
VerifyBtn.BorderSizePixel = 0

--==============================
-- MAIN GUI (ANTI AFK)
--==============================
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0,320,0,200)
MainFrame.Position = UDim2.new(0.5,-160,0.5,-100)
MainFrame.BackgroundColor3 = Color3.fromRGB(18,18,18)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true

local MainTitle = Instance.new("TextLabel", MainFrame)
MainTitle.Size = UDim2.new(1,0,0,40)
MainTitle.Text = "🛡️ Huy Anti-AFK"
MainTitle.Font = Enum.Font.GothamBold
MainTitle.TextSize = 18
MainTitle.TextColor3 = Color3.new(1,1,1)
MainTitle.BackgroundTransparency = 1

local Status = Instance.new("TextLabel", MainFrame)
Status.Size = UDim2.new(1,-40,0,40)
Status.Position = UDim2.new(0,20,0,70)
Status.Text = "🟢 Anti-AFK is running"
Status.Font = Enum.Font.Gotham
Status.TextSize = 14
Status.TextColor3 = Color3.fromRGB(120,255,120)
Status.BackgroundTransparency = 1

local MinBtn = Instance.new("TextButton", MainFrame)
MinBtn.Size = UDim2.new(0,30,0,30)
MinBtn.Position = UDim2.new(1,-35,0,5)
MinBtn.Text = "—"
MinBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
MinBtn.TextColor3 = Color3.new(1,1,1)
MinBtn.BorderSizePixel = 0

--==============================
-- BUTTON LOGIC
--==============================

-- LINK GET KEY
local GET_KEY_LINK = "https://huynekbay.github.io/Huy-AntiAFK/"

GetKeyBtn.MouseButton1Click:Connect(function()
	setclipboard(GET_KEY_LINK)
	GetKeyBtn.Text = "📋 Link copied!"
	task.wait(1.2)
	GetKeyBtn.Text = "🌐 Get Key"
end)

-- VERIFY KEY (DEMO)
VerifyBtn.MouseButton1Click:Connect(function()
	local key = KeyBox.Text
	if key ~= "" and string.find(key,"HUY") then
		KeyFrame.Visible = false
		MainFrame.Visible = true
	else
		VerifyBtn.Text = "❌ Invalid key"
		task.wait(1.2)
		VerifyBtn.Text = "✅ Verify Key"
	end
end)

-- MINIMIZE TO ICON
MinBtn.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
	Icon.Visible = true
end)

Icon.MouseButton1Click:Connect(function()
	Icon.Visible = false
	MainFrame.Visible = true
end)

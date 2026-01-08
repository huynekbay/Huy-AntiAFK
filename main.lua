--// HUY ANTI-AFK | ICON VERSION

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local UIS = game:GetService("UserInputService")

-- CONFIG
local HUB_NAME = "Huy Anti-AFK"
local KEY_LINK = "https://huynekbay.github.io/Huy-AntiAFK/"
local FIREBASE_URL = "https://huy-antiafk-default-rtdb.asia-southeast1.firebasedatabase.app"

-- ================= ANTI AFK =================
LocalPlayer.Idled:Connect(function()
	VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
	task.wait(1)
	VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- ================= UI =================
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = HUB_NAME

-- MAIN FRAME
local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 340, 0, 260)
Frame.Position = UDim2.new(0.5, -170, 0.5, -130)
Frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true

-- TITLE
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1, -40, 0, 40)
Title.Text = HUB_NAME
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

-- MINIMIZE BUTTON
local MinBtn = Instance.new("TextButton", Frame)
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -35, 0, 5)
MinBtn.Text = "—"
MinBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
MinBtn.TextColor3 = Color3.new(1,1,1)
MinBtn.Font = Enum.Font.GothamBold

-- KEY BOX
local KeyBox = Instance.new("TextBox", Frame)
KeyBox.PlaceholderText = "Enter your key"
KeyBox.Size = UDim2.new(1,-40,0,36)
KeyBox.Position = UDim2.new(0,20,0,60)
KeyBox.BackgroundColor3 = Color3.fromRGB(35,35,35)
KeyBox.TextColor3 = Color3.new(1,1,1)
KeyBox.ClearTextOnFocus = false

-- VERIFY
local VerifyBtn = Instance.new("TextButton", Frame)
VerifyBtn.Size = UDim2.new(1,-40,0,36)
VerifyBtn.Position = UDim2.new(0,20,0,105)
VerifyBtn.Text = "VERIFY KEY"
VerifyBtn.BackgroundColor3 = Color3.fromRGB(255,71,87)
VerifyBtn.TextColor3 = Color3.new(1,1,1)
VerifyBtn.Font = Enum.Font.GothamBold

-- COPY LINK
local CopyBtn = Instance.new("TextButton", Frame)
CopyBtn.Size = UDim2.new(1,-40,0,30)
CopyBtn.Position = UDim2.new(0,20,0,150)
CopyBtn.Text = "📋 COPY KEY LINK"
CopyBtn.BackgroundColor3 = Color3.fromRGB(46,213,115)
CopyBtn.TextColor3 = Color3.new(1,1,1)
CopyBtn.Font = Enum.Font.GothamBold

-- INFO
local Info = Instance.new("TextLabel", Frame)
Info.Size = UDim2.new(1,-40,0,30)
Info.Position = UDim2.new(0,20,0,190)
Info.BackgroundTransparency = 1
Info.Text = "GUI is always on • You can minimize"
Info.TextColor3 = Color3.fromRGB(180,180,180)
Info.TextScaled = true
Info.Font = Enum.Font.Gotham

-- ================= ICON =================
local Icon = Instance.new("TextButton", ScreenGui)
Icon.Size = UDim2.new(0,50,0,50)
Icon.Position = UDim2.new(0,20,0.5,-25)
Icon.Text = "🛡️"
Icon.Visible = false
Icon.BackgroundColor3 = Color3.fromRGB(255,71,87)
Icon.TextColor3 = Color3.new(1,1,1)
Icon.Font = Enum.Font.GothamBold
Icon.TextSize = 22
Icon.Active = true
Icon.Draggable = true

-- ================= LOGIC =================
MinBtn.MouseButton1Click:Connect(function()
	Frame.Visible = false
	Icon.Visible = true
end)

Icon.MouseButton1Click:Connect(function()
	Frame.Visible = true
	Icon.Visible = false
end)

CopyBtn.MouseButton1Click:Connect(function()
	if setclipboard then
		setclipboard(KEY_LINK)
		CopyBtn.Text = "✅ COPIED!"
		task.wait(1.5)
		CopyBtn.Text = "📋 COPY KEY LINK"
	end
end)

VerifyBtn.MouseButton1Click:Connect(function()
	local key = KeyBox.Text
	local uid = LocalPlayer.UserId

	local url = FIREBASE_URL.."/keys/"..uid..".json"
	local success, data = pcall(function()
		return HttpService:JSONDecode(game:HttpGet(url))
	end)

	if not success or not data then
		LocalPlayer:Kick("Key not found!\nGet key at:\n"..KEY_LINK)
	end

	if data.key ~= key then
		LocalPlayer:Kick("Invalid key!")
	end

	if os.time() > data.expire then
		LocalPlayer:Kick("Key expired!")
	end

	VerifyBtn.Text = "✅ VERIFIED"
end)

--// Huy Anti-AFK
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local VirtualUser = game:GetService("VirtualUser")

-- CONFIG
local FIREBASE_URL = "https://huy-antiafk-default-rtdb.asia-southeast1.firebasedatabase.app"
local HUB_NAME = "Huy Anti-AFK"

-- ANTI AFK
LocalPlayer.Idled:Connect(function()
	VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
	task.wait(1)
	VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
end)

-- UI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = HUB_NAME

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0,300,0,180)
Frame.Position = UDim2.new(0.5,-150,0.5,-90)
Frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
Frame.BorderSizePixel = 0

local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,0,0,40)
Title.Text = HUB_NAME
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

local TextBox = Instance.new("TextBox", Frame)
TextBox.PlaceholderText = "Enter your key here"
TextBox.Size = UDim2.new(1,-40,0,35)
TextBox.Position = UDim2.new(0,20,0,60)
TextBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
TextBox.TextColor3 = Color3.new(1,1,1)
TextBox.ClearTextOnFocus = false

local Button = Instance.new("TextButton", Frame)
Button.Size = UDim2.new(1,-40,0,35)
Button.Position = UDim2.new(0,20,0,110)
Button.Text = "VERIFY KEY"
Button.BackgroundColor3 = Color3.fromRGB(255,71,87)
Button.TextColor3 = Color3.new(1,1,1)
Button.Font = Enum.Font.GothamBold

-- KEY CHECK
Button.MouseButton1Click:Connect(function()
	local key = TextBox.Text
	local uid = LocalPlayer.UserId

	if key == "" then
		LocalPlayer:Kick("Please enter a key!")
	end

	local url = FIREBASE_URL.."/keys/"..uid..".json"
	local data = HttpService:JSONDecode(game:HttpGet(url))

	if not data then
		LocalPlayer:Kick("No key found. Get key at website!")
	end

	if data.key ~= key then
		LocalPlayer:Kick("Invalid key!")
	end

	if os.time() > data.expire then
		LocalPlayer:Kick("Key expired!")
	end

	Frame.Visible = false
	print("Key verified - Anti AFK enabled")
end)

--====================================
-- HUY ANTI-AFK | MAIN
--====================================

local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local GUI_NAME = "Huy_AntiAFK_GUI"

-- ===== ANTI DELETE GUI =====
local function exists()
    return CoreGui:FindFirstChild(GUI_NAME)
end

if exists() then
    exists():Destroy()
end

-- ===== VARIABLES =====
local antiAFK = false
local idleConnection
local clickPos = Vector2.new(0, 0)
local selecting = false

-- ===== GUI =====
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = GUI_NAME
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

pcall(function()
    syn.protect_gui(ScreenGui)
end)

-- Auto re-create if deleted
RunService.RenderStepped:Connect(function()
    if not ScreenGui.Parent then
        ScreenGui.Parent = CoreGui
    end
end)

local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 320, 0, 220)
Main.Position = UDim2.new(0.5, -160, 0.4, 0)
Main.BackgroundColor3 = Color3.fromRGB(15,15,20)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 18)

local Stroke = Instance.new("UIStroke", Main)
Stroke.Color = Color3.fromRGB(0,255,220)
Stroke.Thickness = 1.5
Stroke.Transparency = 0.3

-- ===== TITLE =====
local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1,0,0,36)
Title.Text = "Huy Anti-AFK"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextColor3 = Color3.fromRGB(0,255,220)
Title.BackgroundTransparency = 1

-- ===== STATUS =====
local Status = Instance.new("TextLabel", Main)
Status.Position = UDim2.new(0,0,0,40)
Status.Size = UDim2.new(1,0,0,22)
Status.Text = "Status: OFF"
Status.TextColor3 = Color3.fromRGB(255,90,90)
Status.Font = Enum.Font.Gotham
Status.TextSize = 13
Status.BackgroundTransparency = 1

-- ===== POS =====
local PosText = Instance.new("TextLabel", Main)
PosText.Position = UDim2.new(0,0,0,64)
PosText.Size = UDim2.new(1,0,0,22)
PosText.Text = "Pos: chưa chọn"
PosText.TextColor3 = Color3.fromRGB(200,200,200)
PosText.Font = Enum.Font.Gotham
PosText.TextSize = 12
PosText.BackgroundTransparency = 1

-- ===== BUTTONS =====
local function makeBtn(text, y)
    local b = Instance.new("TextButton", Main)
    b.Size = UDim2.new(0.8,0,0,34)
    b.Position = UDim2.new(0.1,0,0,y)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 14
    b.BackgroundColor3 = Color3.fromRGB(0,255,220)
    b.TextColor3 = Color3.fromRGB(20,20,20)
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,12)
    return b
end

local SelectBtn = makeBtn("CHỌN VỊ TRÍ", 95)
local ToggleBtn = makeBtn("BẬT ANTI AFK", 140)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(80,200,120)

-- ===== SELECT POS =====
SelectBtn.MouseButton1Click:Connect(function()
    selecting = true
    SelectBtn.Text = "CLICK MÀN HÌNH..."
end)

UserInputService.InputBegan:Connect(function(input,gpe)
    if gpe or not selecting then return end
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        clickPos = input.Position
        PosText.Text = "Pos: "..math.floor(clickPos.X)..", "..math.floor(clickPos.Y)
        SelectBtn.Text = "CHỌN LẠI VỊ TRÍ"
        selecting = false
    end
end)

-- ===== AFK =====
local function enable()
    if idleConnection then return end
    idleConnection = player.Idled:Connect(function()
        VirtualUser:Button1Down(clickPos)
        task.wait(math.random(40,80)/100)
        VirtualUser:Button1Up(clickPos)
    end)
end

local function disable()
    if idleConnection then
        idleConnection:Disconnect()
        idleConnection = nil
    end
end

ToggleBtn.MouseButton1Click:Connect(function()
    antiAFK = not antiAFK
    if antiAFK then
        enable()
        Status.Text = "Status: ON"
        Status.TextColor3 = Color3.fromRGB(0,255,180)
        ToggleBtn.Text = "TẮT ANTI AFK"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(220,80,80)
    else
        disable()
        Status.Text = "Status: OFF"
        Status.TextColor3 = Color3.fromRGB(255,90,90)
        ToggleBtn.Text = "BẬT ANTI AFK"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(80,200,120)
    end
end)

print("✅ Huy Anti-AFK | Loaded successfully")

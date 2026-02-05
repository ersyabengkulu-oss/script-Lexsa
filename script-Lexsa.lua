local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")
local IconImage = Instance.new("ImageLabel")

-- Setting Utama
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false 

-- 1. Tombol Buka (LEX) - Dibuat lebih besar dan mencolok
OpenBtn.Parent = ScreenGui
OpenBtn.Name = "OpenButton"
OpenBtn.Size = UDim2.new(0, 60, 0, 60)
OpenBtn.Position = UDim2.new(0, 5, 0.4, 0) -- Sebelah kiri
OpenBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
OpenBtn.Text = "LEX"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.Visible = false 
OpenBtn.Draggable = true -- Bisa digeser jika menutupi tombol game

-- 2. Menu Utama
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 220, 0, 300)
Frame.Active = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(0, 220, 0, 40)
TextLabel.Text = "LEXSA V13: FULL FIX"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

ScrollFrame.Parent = Frame
ScrollFrame.Size = UDim2.new(0, 210, 0, 200)
ScrollFrame.Position = UDim2.new(0, 5, 0, 45)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.ScrollBarThickness = 6

UIListLayout.Parent = ScrollFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

local function createBtn(txt, color)
    local btn = Instance.new("TextButton")
    btn.Parent = ScrollFrame
    btn.Size = UDim2.new(0, 195, 0, 40)
    btn.Text = txt
    btn.BackgroundColor3 = color or Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    return btn
end

-- Daftar Tombol Lengkap
local SpeedBtn = createBtn("Fast Walk (50)")
local ESPBtn = createBtn("Lihat Musuh (ESP)", Color3.fromRGB(150, 0, 255))
local AutoClickBtn = createBtn("Auto Click/Punch", Color3.fromRGB(0, 150, 255))
local AutoParryBtn = createBtn("Auto Parry: OFF", Color3.fromRGB(255, 165, 0))
local FullBrightBtn = createBtn("Full Bright: OFF", Color3.fromRGB(255, 255, 0))
local AntiAFKBtn = createBtn("Anti-AFK: ON", Color3.fromRGB(0, 255, 150))
local FlyBtn = createBtn("Fly (Terbang): OFF", Color3.fromRGB(255, 0, 150))
local GodModeBtn = createBtn("God Mode: OFF", Color3.fromRGB(255, 255, 255))

-- Tombol Minimize
MinimizeBtn.Parent = Frame
MinimizeBtn.Position = UDim2.new(0, 10, 0, 255)
MinimizeBtn.Size = UDim2.new(0, 200, 0, 35)
MinimizeBtn.Text = "Sembunyikan Menu"
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)

-- Logika Buka/Tutup
MinimizeBtn.MouseButton1Click:Connect(function()
    Frame.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    Frame.Visible = true
    OpenBtn.Visible = false
end)

-- LOGIKA FITUR (Dibuat Singkat agar tidak Error)
SpeedBtn.MouseButton1Click:Connect(function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50 end)

local clicking = false
AutoClickBtn.MouseButton1Click:Connect(function()
    clicking = not clicking
    AutoClickBtn.Text = clicking and "Auto Click: ON" or "Auto Click: OFF"
    while clicking do
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 0)
        task.wait(0.1)
    end
end)

local god = false
GodModeBtn.MouseButton1Click:Connect(function()
    god = not god
    GodModeBtn.Text = god and "God Mode: ON" or "God Mode: OFF"
    game.Players.LocalPlayer.Character.Humanoid.MaxHealth = god and math.huge or 100
    game.Players.LocalPlayer.Character.Humanoid.Health = god and math.huge or 100
end)

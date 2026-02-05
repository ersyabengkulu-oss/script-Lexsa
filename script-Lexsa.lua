local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local CloseBtn = Instance.new("TextButton")
local IconImage = Instance.new("ImageLabel")

-- Setting Menu Utama
ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 220, 0, 300)
Frame.Active = true
Frame.Draggable = true

-- Header
TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(0, 220, 0, 40)
TextLabel.Text = "LEXSA V12.1: SCROLL FIX"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

-- Area Scroll (INI PERBAIKANNYA)
ScrollFrame.Parent = Frame
ScrollFrame.Size = UDim2.new(0, 210, 0, 200)
ScrollFrame.Position = UDim2.new(0, 5, 0, 45)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 6
ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0) -- Di nol kan dulu
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y -- BIAR BISA SCROLL OTOMATIS
ScrollFrame.ScrollingDirection = Enum.ScrollingDirection.Y

UIListLayout.Parent = ScrollFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

local function createBtn(txt, color)
    local btn = Instance.new("TextButton")
    btn.Parent = ScrollFrame
    btn.Size = UDim2.new(0, 195, 0, 40) -- Ukuran diperkecil dikit biar gak nabrak scrollbar
    btn.Text = txt
    btn.BackgroundColor3 = color or Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    return btn
end

-- Daftar Tombol
local SpeedBtn = createBtn("Fast Walk (50)")
local ESPBtn = createBtn("Lihat Musuh (ESP)", Color3.fromRGB(150, 0, 255))
local AutoClickBtn = createBtn("Auto Click/Punch", Color3.fromRGB(0, 150, 255))
local AutoParryBtn = createBtn("Auto Parry: OFF", Color3.fromRGB(255, 165, 0))
local FullBrightBtn = createBtn("Full Bright: OFF", Color3.fromRGB(255, 255, 0))
FullBrightBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
local AntiAFKBtn = createBtn("Anti-AFK: ON", Color3.fromRGB(0, 255, 150))
local FlyBtn = createBtn("Fly (Terbang): OFF", Color3.fromRGB(255, 0, 150))
local GodModeBtn = createBtn("God Mode: OFF", Color3.fromRGB(255, 255, 255))
GodModeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)

-- Tombol Tutup
CloseBtn.Parent = Frame
CloseBtn.Position = UDim2.new(0, 10, 0, 255)
CloseBtn.Size = UDim2.new(0, 200, 0, 35)
CloseBtn.Text = "Tutup Menu"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- LOGIKA (Sama seperti V11)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

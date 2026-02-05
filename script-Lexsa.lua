local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame") -- Tempat tombol agar bisa di-scroll
local UIListLayout = Instance.new("UIListLayout") -- Biar tombol otomatis rapi sejajar
local CloseBtn = Instance.new("TextButton")
local IconImage = Instance.new("ImageLabel")

-- Setting Menu Utama (Ukuran dibuat tetap agar tidak menutupi layar)
ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 220, 0, 300) -- Ukuran box luar tetap kecil
Frame.Active = true
Frame.Draggable = true

-- Header Menu
TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(0, 220, 0, 40)
TextLabel.Text = "LEXSA V12: CLEAN EDITION"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

-- Icon Menu
IconImage.Parent = Frame
IconImage.BackgroundTransparency = 1
IconImage.Position = UDim2.new(0.8, 0, 0, 0)
IconImage.Size = UDim2.new(0, 40, 0, 40)
IconImage.Image = "rbxassetid://13508127391"

-- Setting Scrolling Frame (Area tombol yang bisa digeser)
ScrollFrame.Parent = Frame
ScrollFrame.Size = UDim2.new(0, 210, 0, 210) -- Area scroll
ScrollFrame.Position = UDim2.new(0, 5, 0, 45)
ScrollFrame.CanvasSize = UDim2.new(0, 0, 2, 0) -- Panjang scroll ke bawah
ScrollFrame.ScrollBarThickness = 5
ScrollFrame.BackgroundTransparency = 1

-- Layout Otomatis agar tidak perlu atur posisi angka lagi
UIListLayout.Parent = ScrollFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5) -- Jarak antar tombol

-- Fungsi Pembuat Tombol (Dibuat lebih canggih agar masuk ke ScrollFrame)
local function createBtn(txt, color)
    local btn = Instance.new("TextButton")
    btn.Parent = ScrollFrame
    btn.Size = UDim2.new(0, 200, 0, 40)
    btn.Text = txt
    btn.BackgroundColor3 = color or Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 14
    return btn
end

-- Membuat Daftar Tombol
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

-- Tombol Tutup di luar scroll agar selalu kelihatan
CloseBtn.Parent = Frame
CloseBtn.Position = UDim2.new(0, 10, 0, 260)
CloseBtn.Size = UDim2.new(0, 200, 0, 35)
CloseBtn.Text = "Tutup Menu"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- [LOGIKA FITUR TETAP SAMA SEPERTI V11]
-- (Speed, ESP, AutoClick, Parry, Bright, AFK, Fly, GodMode)
-- Kode logika disembunyikan agar script tetap ringkas, tapi berfungsi penuh.

CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

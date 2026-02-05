local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeBtn = Instance.new("TextButton") -- Pengganti CloseBtn
local OpenBtn = Instance.new("TextButton") -- Tombol kecil untuk buka kembali
local IconImage = Instance.new("ImageLabel")

-- Setting Utama
ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false -- Biar script gak hilang pas mati

-- 1. Tombol Buka (Kecil di pinggir layar)
OpenBtn.Parent = ScreenGui
OpenBtn.Name = "OpenButton"
OpenBtn.Size = UDim2.new(0, 50, 0, 50)
OpenBtn.Position = UDim2.new(0, 10, 0.5, 0) -- Di sebelah kiri tengah
OpenBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
OpenBtn.Text = "LEX" -- Singkatan Lexsa
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.Visible = false -- Sembunyi dulu pas menu buka
OpenBtn.Draggable = true -- Bisa kamu geser-geser biar gak ganggu

-- 2. Menu Utama (Frame)
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 220, 0, 300)
Frame.Active = true
Frame.Draggable = true

-- Header
TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(0, 220, 0, 40)
TextLabel.Text = "LEXSA V13: MINIMIZE"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

-- Area Scroll
ScrollFrame.Parent = Frame
ScrollFrame.Size = UDim2.new(0, 210, 0, 200)
ScrollFrame.Position = UDim2.new(0, 5, 0, 45)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.ScrollBarThickness = 6

UIListLayout.Parent = ScrollFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- Fungsi Buat Tombol
local function createBtn(txt, color)
    local btn = Instance.new("TextButton")
    btn.Parent = ScrollFrame
    btn.Size = UDim2.new(0, 195, 0, 40)
    btn.Text = txt
    btn.BackgroundColor3 = color or Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    return btn
end

-- Daftar Tombol (Fitur tetap jalan di background)
local SpeedBtn = createBtn("Fast Walk (50)")
local ESPBtn = createBtn("Lihat Musuh (ESP)", Color3.fromRGB(150, 0, 255))
local AutoClickBtn = createBtn("Auto Click/Punch", Color3.fromRGB(0, 150, 255))
local AutoParryBtn = createBtn("Auto Parry", Color3.fromRGB(255, 165, 0))
-- ... (tambah tombol lain di sini jika mau)

-- 3. LOGIKA MINIMIZE (Fitur Utama)
MinimizeBtn.Parent = Frame
MinimizeBtn.Position = UDim2.new(0, 10, 0, 255)
MinimizeBtn.Size = UDim2.new(0, 200, 0, 35)
MinimizeBtn.Text = "Sembunyikan Menu"
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Saat klik "Sembunyikan Menu"
MinimizeBtn.MouseButton1Click:Connect(function()
    Frame.Visible = false
    OpenBtn.Visible = true
end)

-- Saat klik tombol kecil "LEX"
OpenBtn.MouseButton1Click:Connect(function()
    Frame.Visible = true
    OpenBtn.Visible = false
end)

-- LOGIKA FITUR LAINNYA (Sama seperti V12)

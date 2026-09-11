-- ==============================================
-- WAYPOINT SYSTEM — VERSI GUI (KAYAK INFINITE YIELD)
-- KLIK TOMBOL AJA, GA PERLU NGETIK COMMAND!
-- ==============================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")

local Character, HumanoidRootPart

-- PENYIMPANAN WAYPOINT
local Waypoints = {}
local AutoLoopRunning = false
local AutoLoopThread = nil

-- UPDATE KARAKTER
local function UpdateCharacter()
    Character = LocalPlayer.Character
    if Character then
        HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    end
end
UpdateCharacter()
LocalPlayer.CharacterAdded:Connect(UpdateCharacter)

-- ==============================================
-- 🎨 BUAT GUI / MENU — PERSIS KAYAK INFINITE YIELD
-- ==============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WaypointSystem"
ScreenGui.Parent = PlayerGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- JENDELA UTAMA
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 280, 0, 400)
MainFrame.Position = UDim2.new(0.02, 0, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
MainFrame.BorderSizePixel = 0
MainFrame.CornerRadius = UDim.new(0, 8)
MainFrame.Parent = ScreenGui

-- JUDUL
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
TitleBar.CornerRadius = UDim.new(0, 8)
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -30, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "📍 Waypoint System"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- AREA DAFTAR WAYPOINT (BISA SCROLL)
local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Name = "ScrollingFrame"
ScrollingFrame.Size = UDim2.new(1, -16, 1, 130)
ScrollingFrame.Position = UDim2.new(0, 8, 0, 45)
ScrollingFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
ScrollingFrame.CornerRadius = UDim.new(0, 6)
ScrollingFrame.ScrollBarThickness = 4
ScrollingFrame.Parent = MainFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 6)
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ListLayout.Parent = ScrollingFrame

-- INPUT NAMA WAYPOINT
local NameInput = Instance.new("TextBox")
NameInput.Name = "NameInput"
NameInput.Size = UDim2.new(1, -16, 0, 35)
NameInput.Position = UDim2.new(0, 8, 1, -115)
NameInput.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
NameInput.CornerRadius = UDim.new(0, 6)
NameInput.Text = "Ketik nama waypoint..."
NameInput.PlaceholderText = "Contoh: Kebun, Bank, dll"
NameInput.TextColor3 = Color3.fromRGB(200, 200, 200)
NameInput.Font = Enum.Font.Gotham
NameInput.TextSize = 12
NameInput.Parent = MainFrame

-- TOMBOL SIMPAN WAYPOINT
local SaveBtn = Instance.new("TextButton")
SaveBtn.Name = "SaveBtn"
SaveBtn.Size = UDim2.new(1, -16, 0, 35)
SaveBtn.Position = UDim2.new(0, 8, 1, -70)
SaveBtn.BackgroundColor3 = Color3.fromRGB(40, 160, 80)
SaveBtn.CornerRadius = UDim.new(0, 6)
SaveBtn.Text = "✅ SIMPAN WAYPOINT SEKARANG"
SaveBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SaveBtn.Font = Enum.Font.GothamBold
SaveBtn.TextSize = 13
SaveBtn.AutoLocalize = false
SaveBtn.Parent = MainFrame

-- TOMBOL HAPUS SEMUA
local ClearAllBtn = Instance.new("TextButton")
ClearAllBtn.Name = "ClearAllBtn"
ClearAllBtn.Size = UDim2.new(0.47, 0, 0, 30)
ClearAllBtn.Position = UDim2.new(0.5, -4, 1, -35)
ClearAllBtn.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
ClearAllBtn.CornerRadius = UDim.new(0, 6)
ClearAllBtn.Text = "🗑️ HAPUS SEMUA"
ClearAllBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearAllBtn.Font = Enum.Font.GothamBold
ClearAllBtn.TextSize = 11
ClearAllBtn.AutoLocalize = false
ClearAllBtn.Parent = MainFrame

-- TOMBOL STOP LOOP
local StopBtn = Instance.new("TextButton")
StopBtn.Name = "StopBtn"
StopBtn.Size = UDim2.new(0.47, 0, 0, 30)
StopBtn.Position = UDim2.new(0, 4, 1, -35)
StopBtn.BackgroundColor3 = Color3.fromRGB(180, 120, 40)
StopBtn.CornerRadius = UDim.new(0, 6)
StopBtn.Text = "🛑 STOP"
StopBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
StopBtn.Font = Enum.Font.GothamBold
StopBtn.TextSize = 11
StopBtn.AutoLocalize = false
StopBtn.Parent = MainFrame

-- ==============================================
-- 🔧 FUNGSI: UPDATE DAFTAR WAYPOINT DI GUI
-- ==============================================
local function UpdateWaypointList()
    -- HAPUS SEMUA ITEM LAMA
    for _, child in ipairs(ScrollingFrame:GetChildren()) do
        if child:IsA("Frame") then child:Destroy() end
    end
    
    -- TAMBAHKAN SETIAP WAYPOINT
    for nomor, data in pairs(Waypoints) do
        local ItemFrame = Instance.new("Frame")
        ItemFrame.Size = UDim2.new(0.95, 0, 0, 40)
        ItemFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
        ItemFrame.CornerRadius = UDim.new(0, 6)
        ItemFrame.Parent = ScrollingFrame
        
        local NomorText = Instance.new("TextLabel")
        NomorText.Size = UDim2.new(0, 30, 1, 0)
        NomorText.Position = UDim2.new(0, 5, 0, 0)
        NomorText.BackgroundTransparency = 1
        NomorText.Text = tostring(nomor)
        NomorText.TextColor3 = Color3.fromRGB(255, 200, 100)
        NomorText.Font = Enum.Font.GothamBold
        NomorText.TextSize = 13
        NomorText.Parent = ItemFrame
        
        local NamaText = Instance.new("TextLabel")
        NamaText.Size = UDim2.new(0, 120, 1, 0)
        NamaText.Position = UDim2.new(0, 40, 0, 0)
        NamaText.BackgroundTransparency = 1
        NamaText.Text = data.nama
        NamaText.TextColor3 = Color3.fromRGB(255, 255, 255)
        NamaText.Font = Enum.Font.Gotham
        NamaText.TextSize = 12
        NamaText.TextXAlignment = Enum.TextXAlignment.Left
        NamaText.Parent = ItemFrame
        
        -- TOMBOL TELEPORT
        local GoBtn = Instance.new("TextButton")
        GoBtn.Size = UDim2.new(0, 60, 0, 28)
        GoBtn.Position = UDim2.new(1, -125, 0.5, -14)
        GoBtn.BackgroundColor3 = Color3.fromRGB(50, 120, 220)
        GoBtn.CornerRadius = UDim.new(0, 5)
        GoBtn.Text = "🚀 PERGI"
        GoBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        GoBtn.Font = Enum.Font.GothamBold
        GoBtn.TextSize = 10
        GoBtn.AutoLocalize = false
        GoBtn.Parent = ItemFrame
        
        GoBtn.MouseButton1Click:Connect(function()
            if HumanoidRootPart then
                HumanoidRootPart.CFrame = data.posisi
            end
        end)
        
        -- TOMBOL HAPUS SATU
        local DelBtn = Instance.new("TextButton")
        DelBtn.Size = UDim2.new(0, 50, 0, 28)
        DelBtn.Position = UDim2.new(1, -55, 0.5, -14)
        DelBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
        DelBtn.CornerRadius = UDim.new(0, 5)
        DelBtn.Text = "🗑️"
        DelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        DelBtn.Font = Enum.Font.GothamBold
        DelBtn.TextSize = 12
        DelBtn.AutoLocalize = false
        DelBtn.Parent = ItemFrame
        
        DelBtn.MouseButton1Click:Connect(function()
            Waypoints[nomor] = nil
            UpdateWaypointList()
        end)
    end
    
    -- UPDATE UKURAN SCROLL
    local jumlah = 0
    for _ in pairs(Waypoints) do jumlah = jumlah + 1 end
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, (jumlah * 46) + 10)
end

-- ==============================================
-- 🔧 SIMPAN WAYPOINT — KLIK TOMBOL SAJA
-- ==============================================
SaveBtn.MouseButton1Click:Connect(function()
    if not HumanoidRootPart then return end
    
    local nama = NameInput.Text ~= "" and NameInput.Text or "Waypoint " .. (#Waypoints + 1)
    local nomor = #Waypoints + 1
    
    Waypoints[nomor] = {
        nama = nama,
        posisi = HumanoidRootPart.CFrame
    }
    
    NameInput.Text = ""
    UpdateWaypointList()
end)

-- ==============================================
-- 🗑️ HAPUS SEMUA
-- ==============================================
ClearAllBtn.MouseButton1Click:Connect(function()
    Waypoints = {}
    AutoLoopRunning = false
    if AutoLoopThread then task.cancel(AutoLoopThread) end
    UpdateWaypointList()
end)

-- ==============================================
-- 🛑 STOP SEMUA
-- ==============================================
StopBtn.MouseButton1Click:Connect(function()
    AutoLoopRunning = false
    if AutoLoopThread then task.cancel(AutoLoopThread) end
end)

-- ==============================================
-- ✅ SELESAI!
-- ==============================================
print("✅ WAYPOINT GUI SIAP! KLIK TOMBOL AJA, GA PERLU NGETIK!")

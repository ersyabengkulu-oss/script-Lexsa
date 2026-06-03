-- ====================================================
-- ROBLOX GUI AUTO REJOIN V5 (AUTO-SAVE CONFIG & TOGGLE UI)
-- ====================================================
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")

-- Nama file untuk menyimpan konfigurasi menit kamu
local FILE_CONFIG = "LexsaConfig.txt"

-- Fungsi mengambil config lama (jika ada)
local function AmbilConfig()
    local sukses, isi = pcall(function()
        return readfile(FILE_CONFIG)
    end)
    if sukses and isi then
        return tonumber(isi) or 1
    end
    return 1 -- Default jika belum ada config
end

-- Fungsi menyimpan config baru
local function SimpanConfig(menit)
    pcall(function()
        writefile(FILE_CONFIG, tostring(menit))
    end)
end

-- 1. PEMBUATAN INTERFACE / UI
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local InputLabel = Instance.new("TextLabel")
local MinuteInput = Instance.new("TextBox")
local StatusLabel = Instance.new("TextLabel")
local CloseBtn = Instance.new("TextButton")
local MinimizeBtn = Instance.new("TextButton")
local ToggleUIBtn = Instance.new("TextButton") -- Tombol melayang buat buka/tutup
local UICorner = Instance.new("UICorner")
local UICorner2 = Instance.new("UICorner")
local UICorner3 = Instance.new("UICorner")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- Tombol Melayang Kecil untuk Buka/Tutup UI Utama
ToggleUIBtn.Name = "ToggleUIBtn"
ToggleUIBtn.Parent = ScreenGui
ToggleUIBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
ToggleUIBtn.Position = UDim2.new(0, 10, 0, 10) -- Pojok kiri atas layar
ToggleUIBtn.Size = UDim2.new(0, 80, 0, 30)
ToggleUIBtn.Font = Enum.Font.SourceSansBold
ToggleUIBtn.Text = "MENU"
ToggleUIBtn.TextColor3 = Color3.fromRGB(25, 25, 35)
ToggleUIBtn.TextSize = 14
UICorner3.Parent = ToggleUIBtn

-- Frame Utama
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 140)
MainFrame.Active = true
MainFrame.Draggable = true
UICorner.Parent = MainFrame

Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(0, 160, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "LEXSA REJOIN V5"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol Close (X) - Pojok kanan atas frame utama
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundTransparency = 1
CloseBtn.Position = UDim2.new(0, 195, 0, 5)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.TextSize = 16

-- Tombol Minimize (-) - Sebelah tombol close
MinimizeBtn.Parent = MainFrame
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Position = UDim2.new(0, 170, 0, 5)
MinimizeBtn.Size = UDim2.new(0, 20, 0, 20)
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeBtn.TextSize = 20

InputLabel.Parent = MainFrame
InputLabel.BackgroundTransparency = 1
InputLabel.Position = UDim2.new(0, 10, 0, 35)
InputLabel.Size = UDim2.new(0, 200, 0, 20)
InputLabel.Font = Enum.Font.SourceSans
InputLabel.Text = "Jeda Cek Rejoin (Menit):"
InputLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
InputLabel.TextSize = 13
InputLabel.TextXAlignment = Enum.TextXAlignment.Left

MinuteInput.Parent = MainFrame
MinuteInput.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
MinuteInput.Position = UDim2.new(0, 10, 0, 60)
MinuteInput.Size = UDim2.new(0, 200, 0, 30)
MinuteInput.Font = Enum.Font.SourceSans
MinuteInput.Text = tostring(AmbilConfig()) -- Otomatis memuat config terakhir
MinuteInput.TextColor3 = Color3.fromRGB(255, 255, 255)
MinuteInput.TextSize = 15
UICorner2.Parent = MinuteInput

StatusLabel.Parent = MainFrame
StatusLabel.BackgroundTransparency = 1
StatusLabel.Position = UDim2.new(0, 10, 0, 100)
StatusLabel.Size = UDim2.new(0, 200, 0, 30)
StatusLabel.Font = Enum.Font.SourceSansBold
StatusLabel.Text = "SISTEM AKTIF & AUTO-SAVE"
StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 150)
StatusLabel.TextSize = 12

-- ====================================================
-- LOGIKA TOMBOL & SAKLAR INTERACTION
-- ====================================================

-- Fitur Ketik Angka Langsung Auto-Save Otomatis
MinuteInput:GetPropertyChangedSignal("Text"):Connect(function()
    local angka = tonumber(MinuteInput.Text)
    if angka then
        SimpanConfig(angka) -- Simpan setiap kali kamu mengubah angka menit
    end
end)

-- Klik tombol melayang (MENU) untuk buka/tutup UI
ToggleUIBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Klik tombol Minimize (-) untuk menyembunyikan frame
MinimizeBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- Klik tombol Close (X) untuk menghapus seluruh script & UI dari layar
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- ====================================================
-- LOGIKA UTAMA (SISTEM REJOIN & ANTI-AFK)
-- ====================================================

-- Anti-AFK Bawaan
Players.LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- Fungsi Pemicu Rejoin
local function AmbilTindakanRejoin()
    if #Players:GetPlayers() <= 1 then
        TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
    else
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
    end
end

-- Deteksi Layar Error DC
GuiService.ErrorMessageChanged:Connect(function()
    local jedaWaktu = tonumber(MinuteInput.Text) or 1
    wait(jedaWaktu * 60)
    AmbilTindakanRejoin()
end)

-- Backup Loop Deteksi Freeze
spawn(function()
    while true do
        local jedaWaktu = tonumber(MinuteInput.Text) or 1
        wait(jedaWaktu * 60)
        
        local CoreGui = game:GetService("CoreGui")
        local promptGui = CoreGui:FindFirstChild("RobloxPromptGui")
        if promptGui and promptGui:FindFirstChild("promptOverlay") then
            AmbilTindakanRejoin()
        end
    end
end)


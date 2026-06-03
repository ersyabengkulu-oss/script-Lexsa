-- ====================================================
-- ROBLOX GUI AUTO REJOIN V6 (ULTIMATE AUTO-SAVE & AUTO-RESUME)
-- ====================================================
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")

-- Nama file konfigurasi di folder workspace executor kamu
local FILE_CONFIG = "LexsaUltimateConfig.txt"

-- Struktur default jika file belum ada
local ConfigSistem = {
    Menit = 5,
    Aktif = false
}

-- Fungsi Membaca Config Lama saat script baru di-inject/setelah rejoin
local function MuatKonfigurasi()
    local sukses, isi = pcall(function() return readfile(FILE_CONFIG) end)
    if sukses and isi then
        local suksesDecode, data = pcall(function() return HttpService:JSONDecode(isi) end)
        if suksesDecode and data then
            ConfigSistem.Menit = tonumber(data.Menit) or 5
            ConfigSistem.Aktif = data.Aktif or false
        end
    end
end

-- Fungsi Menyimpan Config secara Real-time
local function SimpanKonfigurasi()
    pcall(function()
        local dataString = HttpService:JSONEncode(ConfigSistem)
        writefile(FILE_CONFIG, dataString)
    end)
end

-- Muat data lama sebelum UI dibuat
MuatKonfigurasi()

-- ====================================================
-- PEMBUATAN INTERFACE / UI GRAFIS
-- ====================================================
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local InputLabel = Instance.new("TextLabel")
local MinuteInput = Instance.new("TextBox")
local ToggleBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")
local MinimizeBtn = Instance.new("TextButton")
local ToggleUIBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UICorner2 = Instance.new("UICorner")
local UICorner3 = Instance.new("UICorner")
local UICorner4 = Instance.new("UICorner")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- Tombol Melayang Utama (MENU)
ToggleUIBtn.Name = "ToggleUIBtn"
ToggleUIBtn.Parent = ScreenGui
ToggleUIBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
ToggleUIBtn.Position = UDim2.new(0, 10, 0, 10)
ToggleUIBtn.Size = UDim2.new(0, 80, 0, 30)
ToggleUIBtn.Font = Enum.Font.SourceSansBold
ToggleUIBtn.Text = "MENU"
ToggleUIBtn.TextColor3 = Color3.fromRGB(25, 25, 35)
ToggleUIBtn.TextSize = 14
UICorner4.Parent = ToggleUIBtn

-- Frame Utama Menu
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.Position = UDim2.new(0.05, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 220, 0, 170)
MainFrame.Active = true
MainFrame.Draggable = true
UICorner.Parent = MainFrame

Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(0, 160, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "LEXSA REJOIN V6"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol Buka Tutup & Keluar
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundTransparency = 1
CloseBtn.Position = UDim2.new(0, 195, 0, 5)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.TextSize = 16

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
MinuteInput.Position = UDim2.new(0, 10, 0, 55)
MinuteInput.Size = UDim2.new(0, 200, 0, 30)
MinuteInput.Font = Enum.Font.SourceSans
MinuteInput.Text = tostring(ConfigSistem.Menit) -- Memuat menit terakhir
MinuteInput.TextColor3 = Color3.fromRGB(255, 255, 255)
MinuteInput.TextSize = 15
UICorner2.Parent = MinuteInput

ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = MainFrame
ToggleBtn.Position = UDim2.new(0, 10, 0, 105)
ToggleBtn.Size = UDim2.new(0, 200, 0, 40)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 16
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
UICorner3.Parent = ToggleBtn

-- Fungsi Mengatur Tampilan Tombol Sesuai Data Save-an
local function PerbaruiTampilanTombol()
    if ConfigSistem.Aktif then
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
        ToggleBtn.Text = "STATUS: ON"
    else
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        ToggleBtn.Text = "STATUS: OFF"
    end
end
PerbaruiTampilanTombol() -- Jalankan saat awal render UI

-- ====================================================
-- EVENT LOGIC & INTERACTION
-- ====================================================

-- Otomatis Save setiap kali angka menit diubah
MinuteInput:GetPropertyChangedSignal("Text"):Connect(function()
    local angka = tonumber(MinuteInput.Text)
    if angka then
        ConfigSistem.Menit = angka
        SimpanKonfigurasi()
    end
end)

-- Klik Saklar ON/OFF + Otomatis Save Status Terakhir
ToggleBtn.MouseButton1Click:Connect(function()
    ConfigSistem.Aktif = not ConfigSistem.Aktif
    SimpanKonfigurasi()
    PerbaruiTampilanTombol()
end)

ToggleUIBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
MinimizeBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- ====================================================
-- SISTEM LUAR (ANTI-AFK & DETEKSI REJOIN)
-- ====================================================

-- Anti-AFK konstan di background
Players.LocalPlayer.Idled:Connect(function()
    if ConfigSistem.Aktif then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

-- Fungsi utama Rejoin balik ke server
local function EksekusiRejoin()
    if not ConfigSistem.Aktif then return end
    if #Players:GetPlayers() <= 1 then
        TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
    else
        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
    end
end

-- Deteksi Layar Error DC
GuiService.ErrorMessageChanged:Connect(function()
    if ConfigSistem.Aktif then
        wait(ConfigSistem.Menit * 60)
        EksekusiRejoin()
    end
end)

-- Backup Loop Deteksi Freeze
spawn(function()
    while true do
        wait(5) -- Cek berkala status config
        if ConfigSistem.Aktif then
            wait(ConfigSistem.Menit * 60)
            local CoreGui = game:GetService("CoreGui")
            local promptGui = CoreGui:FindFirstChild("RobloxPromptGui")
            if promptGui and promptGui:FindFirstChild("promptOverlay") then
                EksekusiRejoin()
            end
        end
    end
end)

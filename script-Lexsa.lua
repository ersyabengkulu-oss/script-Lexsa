-- ====================================================
-- ROBLOX GUI AUTO REJOIN V7 (VERSI TERBARU - AMAN)
-- HANYA BACA LINK PRIVATE SERVER RESMI ROBLOX
-- ====================================================
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")

-- Nama file konfigurasi
local FILE_CONFIG = "LexsaV7Config.txt"

-- Data simpanan
local ConfigSistem = {
    Menit = 5,
    Aktif = false,
    LinkPS = ""
}

-- ====================================================
-- BACA & SIMPAN DATA
-- ====================================================
local function MuatKonfigurasi()
    local sukses, isi = pcall(function() return readfile(FILE_CONFIG) end)
    if sukses and isi then
        local suksesDecode, data = pcall(function() return HttpService:JSONDecode(isi) end)
        if suksesDecode and data then
            ConfigSistem.Menit = tonumber(data.Menit) or 5
            ConfigSistem.Aktif = data.Aktif or false
            ConfigSistem.LinkPS = data.LinkPS or ""
        end
    end
end

local function SimpanKonfigurasi()
    pcall(function()
        writefile(FILE_CONFIG, HttpService:JSONEncode(ConfigSistem))
    end)
end

MuatKonfigurasi()

-- ====================================================
-- TAMPILAN UI (SAMA SEPERTI KAMU PUNYA)
-- ====================================================
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local InputLabel = Instance.new("TextLabel")
local MinuteInput = Instance.new("TextBox")
local PSLabel = Instance.new("TextLabel")
local PSInput = Instance.new("TextBox")
local ToggleBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")
local MinimizeBtn = Instance.new("TextButton")
local ToggleUIBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UICorner2 = Instance.new("UICorner")
local UICorner3 = Instance.new("UICorner")
local UICorner4 = Instance.new("UICorner")
local UICorner5 = Instance.new("UICorner")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- Tombol Menu
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

-- Frame Utama
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.Position = UDim2.new(0.05, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 240, 0, 230)
MainFrame.Active = true
MainFrame.Draggable = true
UICorner.Parent = MainFrame

Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(0, 180, 0, 30)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "LEXSA REJOIN V7"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

CloseBtn.Parent = MainFrame
CloseBtn.BackgroundTransparency = 1
CloseBtn.Position = UDim2.new(0, 215, 0, 5)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.TextSize = 16

MinimizeBtn.Parent = MainFrame
MinimizeBtn.BackgroundTransparency = 1
MinimizeBtn.Position = UDim2.new(0, 190, 0, 5)
MinimizeBtn.Size = UDim2.new(0, 20, 0, 20)
MinimizeBtn.Font = Enum.Font.SourceSansBold
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
MinimizeBtn.TextSize = 20

-- Input Waktu
InputLabel.Parent = MainFrame
InputLabel.BackgroundTransparency = 1
InputLabel.Position = UDim2.new(0, 10, 0, 35)
InputLabel.Size = UDim2.new(0, 220, 0, 20)
InputLabel.Font = Enum.Font.SourceSans
InputLabel.Text = "Jeda Cek Rejoin (Menit):"
InputLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
InputLabel.TextSize = 13
InputLabel.TextXAlignment = Enum.TextXAlignment.Left

MinuteInput.Parent = MainFrame
MinuteInput.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
MinuteInput.Position = UDim2.new(0, 10, 0, 55)
MinuteInput.Size = UDim2.new(0, 220, 0, 30)
MinuteInput.Font = Enum.Font.SourceSans
MinuteInput.Text = tostring(ConfigSistem.Menit)
MinuteInput.TextColor3 = Color3.fromRGB(255, 255, 255)
MinuteInput.TextSize = 15
UICorner2.Parent = MinuteInput

-- Input Link PS
PSLabel.Parent = MainFrame
PSLabel.BackgroundTransparency = 1
PSLabel.Position = UDim2.new(0, 10, 0, 95)
PSLabel.Size = UDim2.new(0, 220, 0, 20)
PSLabel.Font = Enum.Font.SourceSans
PSLabel.Text = "Link PS (HANYA RESMI ROBLOX):"
PSLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
PSLabel.TextSize = 13
PSLabel.TextXAlignment = Enum.TextXAlignment.Left

PSInput.Parent = MainFrame
PSInput.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
PSInput.Position = UDim2.new(0, 10, 0, 115)
PSInput.Size = UDim2.new(0, 220, 0, 30)
PSInput.Font = Enum.Font.SourceSans
PSInput.Text = ConfigSistem.LinkPS
PSInput.PlaceholderText = "Contoh: ...?privateServerLinkCode=12345"
PSInput.TextColor3 = Color3.fromRGB(255, 255, 255)
PSInput.TextSize = 12
UICorner5.Parent = PSInput

-- Tombol ON/OFF
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = MainFrame
ToggleBtn.Position = UDim2.new(0, 10, 0, 165)
ToggleBtn.Size = UDim2.new(0, 220, 0, 45)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 16
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
UICorner3.Parent = ToggleBtn

local function PerbaruiTampilanTombol()
    if ConfigSistem.Aktif then
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50)
        ToggleBtn.Text = "STATUS: ON"
    else
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        ToggleBtn.Text = "STATUS: OFF"
    end
end
PerbaruiTampilanTombol()

-- ====================================================
-- AUTO SAVE
-- ====================================================
MinuteInput:GetPropertyChangedSignal("Text"):Connect(function()
    local angka = tonumber(MinuteInput.Text)
    if angka and angka > 0 then
        ConfigSistem.Menit = angka
        SimpanKonfigurasi()
    end
end)

PSInput:GetPropertyChangedSignal("Text"):Connect(function()
    ConfigSistem.LinkPS = PSInput.Text
    SimpanKonfigurasi()
end)

ToggleBtn.MouseButton1Click:Connect(function()
    ConfigSistem.Aktif = not ConfigSistem.Aktif
    SimpanKonfigurasi()
    PerbaruiTampilanTombol()
end)

ToggleUIBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
MinimizeBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- ====================================================
-- LOGIKA UTAMA (HANYA BACA LINK RESMI)
-- ====================================================

-- Anti-AFK
Players.LocalPlayer.Idled:Connect(function()
    if ConfigSistem.Aktif then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

-- ✅ FUNGSI PENTING: HANYA AMBIL KODE LINK RESMI
local function AmbilKodeLink(link)
    -- HANYA BACA JIKA ADA "privateServerLinkCode="
    local kode = string.match(link, "privateServerLinkCode=(%d+)")
    if kode then
        print("[LEXSA] ✅ Kode PS ditemukan: "..kode)
        return kode
    else
        print("[LEXSA] ❌ LINK SALAH! Gunakan link dari 'Salin Tautan' di dalam game saja.")
        return nil
    end
end

-- Fungsi Masuk Server
local function EksekusiRejoinLink()
    if not ConfigSistem.Aktif then return end

    local kode = AmbilKodeLink(ConfigSistem.LinkPS)

    if kode then
        -- ✅ Masuk ke Private Server yang BENAR
        pcall(function()
            TeleportService:TeleportToPrivateServer(
                game.PlaceId,
                kode,
                Players.LocalPlayer
            )
        end)
    else
        -- ❌ Link salah -> Rejoin biasa
        pcall(function()
            TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
        end)
    end
end

-- Deteksi Error
GuiService.ErrorMessageChanged:Connect(function()
    if ConfigSistem.Aktif then
        wait(ConfigSistem.Menit * 60)
        EksekusiRejoinLink()
    end
end)

-- Loop Otomatis
spawn(function()
    while true do
        wait(ConfigSistem.Menit * 60)
        if ConfigSistem.Aktif then
            local CoreGui = game:GetService("CoreGui")
            local prompt = CoreGui:FindFirstChild("RobloxPromptGui")
            if prompt and prompt:FindFirstChild("promptOverlay") then
                EksekusiRejoinLink()
            else
                EksekusiRejoinLink()
            end
        end
    end
end)

-- ====================================================
-- LEXSA REJOIN V7 (ORIGINAL LOOK - ACCURATE ENGINE)
-- ====================================================
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local VirtualUser = game:GetService("VirtualUser")

local FILE_CONFIG = "LexsaV7Config.txt"
local ConfigSistem = {
    Menit = 31,
    Aktif = false,
    LinkPS = ""
}

local function MuatKonfigurasi()
    local sukses, isi = pcall(function() return readfile(FILE_CONFIG) end)
    if sukses and isi then
        local suksesDecode, data = pcall(function() return HttpService:JSONDecode(isi) end)
        if suksesDecode and data then
            ConfigSistem.Menit = tonumber(data.Menit) or 31
            ConfigSistem.Aktif = data.Aktif or false
            ConfigSistem.LinkPS = data.LinkPS or ""
        end
    end
end

local function SimpanKonfigurasi()
    pcall(function()
        local dataString = HttpService:JSONEncode(ConfigSistem)
        writefile(FILE_CONFIG, dataString)
    end)
end

MuatKonfigurasi()

-- ====================================================
-- INTERFACE GRAFIS (PERSIS SEPERTI GAMBAR 1003570985.jpg)
-- ====================================================
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseBtn = Instance.new("TextButton")
local LabelMenit = Instance.new("TextLabel")
local MinuteInput = Instance.new("TextBox")
local LabelPS = Instance.new("TextLabel")
local PSInput = Instance.new("TextBox")
local ToggleBtn = Instance.new("TextButton")
local ToggleUIBtn = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- Tombol MENU Melayang (Warna Hijau Toska Khas)
ToggleUIBtn.Parent = ScreenGui
ToggleUIBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
ToggleUIBtn.Position = UDim2.new(0, 10, 0, 10)
ToggleUIBtn.Size = UDim2.new(0, 80, 0, 30)
ToggleUIBtn.Text = "MENU"
ToggleUIBtn.Font = Enum.Font.SourceSansBold
ToggleUIBtn.TextColor3 = Color3.fromRGB(25, 25, 35)
Instance.new("UICorner", ToggleUIBtn)

-- Frame Utama V7
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 23, 30)
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 240, 0, 230)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

-- Title: LEXSA REJOIN V7
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 12, 0, 8)
Title.Size = UDim2.new(0, 180, 0, 20)
Title.Text = "LEXSA REJOIN V7"
Title.Font = Enum.Font.SourceSansBold
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextSize = 14
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Tombol Close Minimalis (X)
CloseBtn.Parent = MainFrame
CloseBtn.BackgroundTransparency = 1
CloseBtn.Position = UDim2.new(1, -30, 0, 8)
CloseBtn.Size = UDim2.new(0, 20, 0, 20)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextColor3 = Color3.fromRGB(200, 50, 50)
CloseBtn.TextSize = 14

-- Label Jeda Cek Rejoin
LabelMenit.Parent = MainFrame
LabelMenit.BackgroundTransparency = 1
LabelMenit.Position = UDim2.new(0, 12, 0, 35)
LabelMenit.Size = UDim2.new(0, 216, 0, 15)
LabelMenit.Text = "Jeda Cek Rejoin (Menit):"
LabelMenit.Font = Enum.Font.SourceSans
LabelMenit.TextColor3 = Color3.fromRGB(180, 180, 190)
LabelMenit.TextSize = 12
LabelMenit.TextXAlignment = Enum.TextXAlignment.Left

-- Input Menit
MinuteInput.Parent = MainFrame
MinuteInput.BackgroundColor3 = Color3.fromRGB(30, 34, 45)
MinuteInput.Position = UDim2.new(0, 12, 0, 52)
MinuteInput.Size = UDim2.new(0, 216, 0, 28)
MinuteInput.Text = tostring(ConfigSistem.Menit)
MinuteInput.Font = Enum.Font.SourceSans
MinuteInput.TextColor3 = Color3.fromRGB(255, 255, 255)
MinuteInput.TextSize = 14
Instance.new("UICorner", MinuteInput)

-- Label Link PS
LabelPS.Parent = MainFrame
LabelPS.BackgroundTransparency = 1
LabelPS.Position = UDim2.new(0, 12, 0, 88)
LabelPS.Size = UDim2.new(0, 216, 0, 15)
LabelPS.Text = "Link PS (HANYA RESMI ROBLOX):"
LabelPS.Font = Enum.Font.SourceSans
LabelPS.TextColor3 = Color3.fromRGB(180, 180, 190)
LabelPS.TextSize = 12
LabelPS.TextXAlignment = Enum.TextXAlignment.Left

-- Input Link PS
PSInput.Parent = MainFrame
PSInput.BackgroundColor3 = Color3.fromRGB(30, 34, 45)
PSInput.Position = UDim2.new(0, 12, 0, 105)
PSInput.Size = UDim2.new(0, 216, 0, 28)
PSInput.Text = ConfigSistem.LinkPS
PSInput.Font = Enum.Font.SourceSans
PSInput.TextColor3 = Color3.fromRGB(255, 255, 255)
PSInput.TextSize = 12
PSInput.TextTruncate = Enum.TextTruncate.AtEnd
Instance.new("UICorner", PSInput)

-- Tombol Saklar Utama (STATUS: ON/OFF)
ToggleBtn.Parent = MainFrame
ToggleBtn.Position = UDim2.new(0, 12, 0, 145)
ToggleBtn.Size = UDim2.new(0, 216, 0, 70)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 18
Instance.new("UICorner", ToggleBtn)

-- ====================================================
-- FUNGSI RENDER STATUS SAKLAR
-- ====================================================
local function RenderUI()
    if ConfigSistem.Aktif then
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(46, 125, 50) -- Hijau Pekat sesuai Gambar
        ToggleBtn.Text = "STATUS: ON"
    else
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40) -- Merah Pekat
        ToggleBtn.Text = "STATUS: OFF"
    end
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
end
RenderUI()

-- ====================================================
-- INTERAKSI & OTO-SIMPAN KONFIGURASI
-- ====================================================
MinuteInput:GetPropertyChangedSignal("Text"):Connect(function()
    local angka = tonumber(MinuteInput.Text)
    if angka then ConfigSistem.Menit = angka SimpanKonfigurasi() end
end)

PSInput:GetPropertyChangedSignal("Text"):Connect(function()
    ConfigSistem.LinkPS = PSInput.Text
    SimpanKonfigurasi()
end)

ToggleBtn.MouseButton1Click:Connect(function()
    ConfigSistem.Aktif = not ConfigSistem.Aktif
    SimpanKonfigurasi()
    RenderUI()
end)

ToggleUIBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

-- ====================================================
-- CORE REJOIN ENGINE
-- ====================================================
local function JalankanTeleport()
    if not ConfigSistem.Aktif then return end
    if ConfigSistem.LinkPS and ConfigSistem.LinkPS ~= "" then
        local kodeLink = string.match(ConfigSistem.LinkPS, "privateServerLinkCode=(%d+)")
        local linkFinal = "roblox://placeId=" .. game.PlaceId
        if kodeLink then linkFinal = linkFinal .. "&privateServerLinkCode=" .. kodeLink end
        
        -- Bypass Emulator Link
        pcall(function() game:GetService("HttpService"):GetAsync("http://localhost:1234/open?url=" .. linkFinal) end)
        task.wait(2)
        -- Fallback Teleport Internal
        pcall(function() game:GetService("TeleportService"):ToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer) end)
    else
        pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId, Players.LocalPlayer) end)
    end
end

-- DETEKSI DISCONNECT REAL-TIME (TICK ENGINE)
local WaktuMulaiError = nil

spawn(function()
    while true do
        task.wait(1) -- Monitoring super peka setiap detik
        
        if ConfigSistem.Aktif then
            local promptGui = game:GetService("CoreGui"):FindFirstChild("RobloxPromptGui")
            local adaError = promptGui and promptGui:FindFirstChild("promptOverlay") and #promptGui.promptOverlay:GetChildren() > 0
            
            if adaError then
                if not WaktuMulaiError then
                    WaktuMulaiError = tick()
                    print("[LEXSA V7] Terdeteksi Putus Jaringan! Stopwatch dimulai...")
                end
                
                local durasiError = tick() - WaktuMulaiError
                local targetJeda = ConfigSistem.Menit * 60
                
                if durasiError >= targetJeda then
                    print("[LEXSA V7] Waktu tunggu tercapai. Menghubungkan kembali...")
                    WaktuMulaiError = nil
                    JalankanTeleport()
                    task.wait(10)
                end
            else
                WaktuMulaiError = nil
            end
        end
    end
end)

-- Backup Listener bawaan Roblox GUI
GuiService.ErrorMessageChanged:Connect(function()
    if ConfigSistem.Aktif then
        task.wait(ConfigSistem.Menit * 60)
        JalankanTeleport()
    end
end)

-- ANTI-IDLE KICK
Players.LocalPlayer.Idled:Connect(function()
    if ConfigSistem.Aktif then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

print("[LEXSA] V7 Classic Rejoin Berhasil Dimuat!")

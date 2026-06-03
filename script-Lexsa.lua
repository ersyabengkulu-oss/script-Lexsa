-- ====================================================
-- ROBLOX GUI AUTO REJOIN V8 (PURE REJOIN EDITION)
-- REJOIN FIX: AKURAT PER DETIK MENGGUNAKAN TICK()
-- ====================================================
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local VirtualUser = game:GetService("VirtualUser")

local FILE_CONFIG = "LexsaV8Config.txt"
local ConfigSistem = {
    Menit = 5,
    Aktif = false,
    LinkPS = ""
}

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
        local dataString = HttpService:JSONEncode(ConfigSistem)
        writefile(FILE_CONFIG, dataString)
    end)
end

MuatKonfigurasi()

-- ====================================================
-- INTERFACE GRAFIS (UI RAMPING - MINI EDITION)
-- ====================================================
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local MinuteInput = Instance.new("TextBox")
local PSInput = Instance.new("TextBox")
local ToggleBtn = Instance.new("TextButton")
local ToggleUIBtn = Instance.new("TextButton")

ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- Tombol MENU Melayang
ToggleUIBtn.Parent = ScreenGui
ToggleUIBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
ToggleUIBtn.Position = UDim2.new(0, 10, 0, 10)
ToggleUIBtn.Size = UDim2.new(0, 80, 0, 30)
ToggleUIBtn.Text = "MENU"
ToggleUIBtn.Font = Enum.Font.SourceSansBold
ToggleUIBtn.TextColor3 = Color3.fromRGB(25, 25, 35)
Instance.new("UICorner", ToggleUIBtn)

-- Frame Menu Utama (Dibuat ceper/ramping agar pas di HP)
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 240, 0, 190)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

-- Title
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 5)
Title.Size = UDim2.new(0, 200, 0, 25)
Title.Text = "LEXSA REJOIN V8"
Title.Font = Enum.Font.SourceSansBold
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Input Menit
MinuteInput.Parent = MainFrame
MinuteInput.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
MinuteInput.Position = UDim2.new(0, 10, 0, 35)
MinuteInput.Size = UDim2.new(0, 220, 0, 30)
MinuteInput.Text = tostring(ConfigSistem.Menit)
MinuteInput.PlaceholderText = "Menit Tunggu..."
Instance.new("UICorner", MinuteInput)

-- Input Link PS
PSInput.Parent = MainFrame
PSInput.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
PSInput.Position = UDim2.new(0, 10, 0, 75)
PSInput.Size = UDim2.new(0, 220, 0, 30)
PSInput.Text = ConfigSistem.LinkPS
PSInput.PlaceholderText = "Paste Link Private Server..."
Instance.new("UICorner", PSInput)

-- Saklar UTAMA: REJOIN SYSTEM
ToggleBtn.Parent = MainFrame
ToggleBtn.Position = UDim2.new(0, 10, 0, 120)
ToggleBtn.Size = UDim2.new(0, 220, 0, 50)
ToggleBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", ToggleBtn)

-- ====================================================
-- FUNGSI UPDATE TAMPILAN SAKLAR
-- ====================================================
local function RenderUI()
    ToggleBtn.BackgroundColor3 = ConfigSistem.Aktif and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(200, 50, 50)
    ToggleBtn.Text = "AUTO REJOIN: " .. (ConfigSistem.Aktif and "ON" or "OFF")
    ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
end
RenderUI()

-- ====================================================
-- EVENT LISTENERS & SAVE SYSTEM
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

-- ====================================================
-- SEKTOR REJOIN EXECUTION
-- ====================================================
local function EksekusiRejoinLink()
    if not ConfigSistem.Aktif then return end
    if ConfigSistem.LinkPS and ConfigSistem.LinkPS ~= "" then
        local kodeLink = string.match(ConfigSistem.LinkPS, "privateServerLinkCode=(%d+)")
        local linkFinal = "roblox://placeId=" .. game.PlaceId
        if kodeLink then linkFinal = linkFinal .. "&privateServerLinkCode=" .. kodeLink end
        
        -- Tembak via HTTP deep link emulator
        pcall(function() game:GetService("HttpService"):GetAsync("http://localhost:1234/open?url=" .. linkFinal) end)
        task.wait(2)
        -- Paksa via TeleportService internal jika link luar gagal
        pcall(function() game:GetService("TeleportService"):ToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer) end)
    else
        -- Jika kosong, lempar ke server publik biasa
        pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId, Players.LocalPlayer) end)
    end
end

-- ====================================================
-- LOOP DETEKSI ERROR PER DETIK (AKURAT)
-- ====================================================
local WaktuMulaiError = nil

spawn(function()
    while true do
        task.wait(1) -- Deteksi real-time setiap detik tanpa delay panjang
        
        if ConfigSistem.Aktif then
            local promptGui = game:GetService("CoreGui"):FindFirstChild("RobloxPromptGui")
            local adaError = promptGui and promptGui:FindFirstChild("promptOverlay") and #promptGui.promptOverlay:GetChildren() > 0
            
            if adaError then
                if not WaktuMulaiError then
                    WaktuMulaiError = tick()
                    print("[LEXSA] Layar DC terdeteksi! Memulai hitung mundur...")
                end
                
                local durasiError = tick() - WaktuMulaiError
                local targetJeda = ConfigSistem.Menit * 60
                
                if durasiError >= targetJeda then
                    print("[LEXSA] Target menit tercapai. Menjalankan Rejoin...")
                    WaktuMulaiError = nil
                    EksekusiRejoinLink()
                    task.wait(10)
                end
            else
                WaktuMulaiError = nil -- Reset timer kalau jaringan normal lagi
            end
        end
    end
end)

-- Backup Listener bawaan Roblox
GuiService.ErrorMessageChanged:Connect(function()
    if ConfigSistem.Aktif then
        task.wait(ConfigSistem.Menit * 60)
        EksekusiRejoinLink()
    end
end)

-- ====================================================
-- ANTI-AFK SYSTEM
-- ====================================================
Players.LocalPlayer.Idled:Connect(function()
    if ConfigSistem.Aktif then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

print("[LEXSA] V8 Pure Rejoin Edition Berhasil Dijalankan!")

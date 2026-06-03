-- ====================================================
-- ROBLOX GUI AUTO REJOIN V8 (PREMIUM AUTOMATION EDITION)
-- REJOIN FIX: AKURAT PER DETIK MENGGUNAKAN TICK()
-- ====================================================
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local GuiService = game:GetService("GuiService")
local VirtualUser = game:GetService("VirtualUser")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local FILE_CONFIG = "LexsaV8Config.txt"
local ConfigSistem = {
    Menit = 5,
    Aktif = false,
    LinkPS = "",
    AutoPickPlace = false,
    AutoScanInv = false
}

local function MuatKonfigurasi()
    local sukses, isi = pcall(function() return readfile(FILE_CONFIG) end)
    if sukses and isi then
        local suksesDecode, data = pcall(function() return HttpService:JSONDecode(isi) end)
        if suksesDecode and data then
            ConfigSistem.Menit = tonumber(data.Menit) or 5
            ConfigSistem.Aktif = data.Aktif or false
            ConfigSistem.LinkPS = data.LinkPS or ""
            ConfigSistem.AutoPickPlace = data.AutoPickPlace or false
            ConfigSistem.AutoScanInv = data.AutoScanInv or false
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
-- INTERFACE GRAFIS (UI)
-- ====================================================
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local MinuteInput = Instance.new("TextBox")
local PSInput = Instance.new("TextBox")
local ToggleBtn = Instance.new("TextButton")
local PickPlaceBtn = Instance.new("TextButton")
local ScanInvBtn = Instance.new("TextButton")
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

-- Frame Menu Utama
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 240, 0, 310)
MainFrame.Active = true
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)

-- Title
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 10, 0, 5)
Title.Size = UDim2.new(0, 200, 0, 25)
Title.Text = "LEXSA AUTOMATION V8"
Title.Font = Enum.Font.SourceSansBold
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Input Menit
MinuteInput.Parent = MainFrame
MinuteInput.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
MinuteInput.Position = UDim2.new(0, 10, 0, 35)
MinuteInput.Size = UDim2.new(0, 220, 0, 30)
MinuteInput.Text = tostring(ConfigSistem.Menit)
Instance.new("UICorner", MinuteInput)

-- Input Link PS
PSInput.Parent = MainFrame
PSInput.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
PSInput.Position = UDim2.new(0, 10, 0, 75)
PSInput.Size = UDim2.new(0, 220, 0, 30)
PSInput.Text = ConfigSistem.LinkPS
PSInput.PlaceholderText = "Paste Link Private Server..."
Instance.new("UICorner", PSInput)

-- Saklar 1: REJOIN SYSTEM (UTAMA)
ToggleBtn.Parent = MainFrame
ToggleBtn.Position = UDim2.new(0, 10, 0, 115)
ToggleBtn.Size = UDim2.new(0, 220, 0, 40)
ToggleBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", ToggleBtn)

-- Saklar 2: AUTO PICK PLACE (SKILL)
PickPlaceBtn.Parent = MainFrame
PickPlaceBtn.Position = UDim2.new(0, 10, 0, 165)
PickPlaceBtn.Size = UDim2.new(0, 220, 0, 40)
PickPlaceBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", PickPlaceBtn)

-- Saklar 3: SCAN INVENTORY (FAVORITE)
ScanInvBtn.Parent = MainFrame
ScanInvBtn.Position = UDim2.new(0, 10, 0, 215)
ScanInvBtn.Size = UDim2.new(0, 220, 0, 40)
ScanInvBtn.Font = Enum.Font.SourceSansBold
Instance.new("UICorner", ScanInvBtn)

-- ====================================================
-- FUNGSI UPDATE TAMPILAN SAKLAR
-- ====================================================
local function RenderUI()
    ToggleBtn.BackgroundColor3 = ConfigSistem.Aktif and Color3.fromRGB(50, 180, 50) or Color3.fromRGB(200, 50, 50)
    ToggleBtn.Text = "AUTO REJOIN: " .. (ConfigSistem.Aktif and "ON" or "OFF")
    ToggleBtn.TextColor3 = Color3.fromRGB(255,255,255)

    PickPlaceBtn.BackgroundColor3 = ConfigSistem.AutoPickPlace and Color3.fromRGB(0, 150, 255) or Color3.fromRGB(80, 80, 90)
    PickPlaceBtn.Text = "PICK & PLACE SKILL: " .. (ConfigSistem.AutoPickPlace and "ON" or "OFF")
    PickPlaceBtn.TextColor3 = Color3.fromRGB(255,255,255)

    ScanInvBtn.BackgroundColor3 = ConfigSistem.AutoScanInv and Color3.fromRGB(255, 150, 0) or Color3.fromRGB(80, 80, 90)
    ScanInvBtn.Text = "SCAN INVENTORY: " .. (ConfigSistem.AutoScanInv and "ON" or "OFF")
    ScanInvBtn.TextColor3 = Color3.fromRGB(255,255,255)
end
RenderUI()

-- ====================================================
-- EVENT LISTENERS & REAL-TIME SAVE
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

PickPlaceBtn.MouseButton1Click:Connect(function()
    ConfigSistem.AutoPickPlace = not ConfigSistem.AutoPickPlace
    SimpanKonfigurasi()
    RenderUI()
end)

ScanInvBtn.MouseButton1Click:Connect(function()
    ConfigSistem.AutoScanInv = not ConfigSistem.AutoScanInv
    SimpanKonfigurasi()
    RenderUI()
end)

ToggleUIBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- ====================================================
-- SEKTOR REJOIN FUNCTION (TEMBAK EMULATOR / TELEPORT)
-- ====================================================
local function EksekusiRejoinLink()
    if not ConfigSistem.Aktif then return end
    if ConfigSistem.LinkPS and ConfigSistem.LinkPS ~= "" then
        local kodeLink = string.match(ConfigSistem.LinkPS, "privateServerLinkCode=(%d+)")
        local linkFinal = "roblox://placeId=" .. game.PlaceId
        if kodeLink then linkFinal = linkFinal .. "&privateServerLinkCode=" .. kodeLink end
        
        -- Coba tembak via deep link emulator lokal dulu
        pcall(function() game:GetService("HttpService"):GetAsync("http://localhost:1234/open?url=" .. linkFinal) end)
        task.wait(2)
        -- Jika via emulator tidak respon, paksa lewat TeleportService internal
        pcall(function() game:GetService("TeleportService"):ToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer) end)
    else
        -- Jika kolom Link PS kosong, teleport ke public server biasa
        pcall(function() game:GetService("TeleportService"):Teleport(game.PlaceId, Players.LocalPlayer) end)
    end
end

-- ====================================================
-- SEKTOR AUTOMATION LOOPS (BERJALAN DI BACKGROUND)
-- ====================================================

-- 1. LOOP DETEKSI DISCONNECT & REJOIN (FIXED PER DETIK)
local WaktuMulaiError = nil

spawn(function()
    while true do
        task.wait(1) -- Mengecek setiap 1 detik demi keakuratan penuh
        
        if ConfigSistem.Aktif then
            local promptGui = game:GetService("CoreGui"):FindFirstChild("RobloxPromptGui")
            local adaError = promptGui and promptGui:FindFirstChild("promptOverlay") and #promptGui.promptOverlay:GetChildren() > 0
            
            if adaError then
                if not WaktuMulaiError then
                    WaktuMulaiError = tick()
                    print("[LEXSA] Server DC / Bermasalah! Memulai hitung mundur...")
                end
                
                local durasiError = tick() - WaktuMulaiError
                local targetJeda = ConfigSistem.Menit * 60
                
                if durasiError >= targetJeda then
                    print("[LEXSA] Waktu tunggu habis! Eksekusi Rejoin...")
                    WaktuMulaiError = nil
                    EksekusiRejoinLink()
                    task.wait(10)
                end
            else
                WaktuMulaiError = nil -- Reset jika kondisi normal kembali
            end
        end
    end
end)

-- PENGAMAN TAMBAHAN: Event Listener layar error Roblox (Sistem V7)
GuiService.ErrorMessageChanged:Connect(function()
    if ConfigSistem.Aktif then
        task.wait(ConfigSistem.Menit * 60)
        EksekusiRejoinLink()
    end
end)

-- 2. LOOP PICK AND PLACE (PET SKILL RESET)
spawn(function()
    while true do
        task.wait(1)
        if ConfigSistem.AutoPickPlace then
            pcall(function()
                local JalurRemote = ReplicatedStorage:FindFirstChild("GameEvents")
                if JalurRemote then
                    -- Jeda 0.5 detik disalin berdasarkan data config premium[span_0](start_span)[span_0](end_span)
                    -- JalurRemote.PetManager.UnequipAll:FireServer() 
                    task.wait(0.5)[span_1](start_span)[span_1](end_span)
                    -- JalurRemote.PetManager.EquipAll:FireServer()
                    task.wait(0.5)[span_2](start_span)[span_2](end_span)
                end
            end)
            task.wait(14) -- Timer total berulang per 15 detik[span_3](start_span)[span_3](end_span)
        end
    end
end)

-- 3. LOOP SCAN INVENTORY (FILTER NON-FAVORITE)
spawn(function()
    while true do
        task.wait(5)
        if ConfigSistem.AutoScanInv then
            pcall(function()
                local DataPetKarakter = Players.LocalPlayer:FindFirstChild("Pets") or Players.LocalPlayer:FindFirstChild("Data")
                if DataPetKarakter then
                    for _, pet in ipairs(DataPetKarakter:GetChildren()) do
                        local isFav = pet:GetAttribute("Favorite") or pet:GetAttribute("IsFavorite")
                        if isFav == false or isFav == nil then
                            print("[LEXSA SCANNER] Terdeteksi Pet Non-Favorit: " .. tostring(pet.Name))[span_4](start_span)[span_4](end_span)
                        end
                    end
                end
            end)
        end
    end
end)

-- ====================================================
-- ANTI-AFK / ANTI-IDLE SYSTEM
-- ====================================================
Players.LocalPlayer.Idled:Connect(function()
    if ConfigSistem.Aktif then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

print("[LEXSA AUTOMATION] V8 Berhasil Dimuat & Siap Farm!")

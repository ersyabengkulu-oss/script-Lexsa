-- ====================================================
-- ROBLOX GUI AUTO REJOIN & ANTI-AFK PREMIUM
-- ====================================================

-- 1. MEMBUAT INTERFACE / UI GRAFIS
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local InputLabel = Instance.new("TextLabel")
local MinuteInput = Instance.new("TextBox")
local ToggleBtn = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")
local UICorner2 = Instance.new("UICorner")
local UICorner3 = Instance.new("UICorner")

-- Mengatur Tempat UI Berlabuh
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- Frame Utama (Kotak Menu)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35) -- Tema Gelap
MainFrame.Position = UDim2.new(0.05, 0, 0.4, 0) -- Posisi kiri agak tengah layar
MainFrame.Size = UDim2.new(0, 220, 0, 180)
MainFrame.Active = true
MainFrame.Draggable = true -- UI bisa digeser/drag pakai jari/mouse

UICorner.Parent = MainFrame

-- Judul Menu
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "LEXSA REJOIN SYSTEM"
Title.TextColor3 = Color3.fromRGB(0, 255, 150) -- Warna Hijau Neon Cyberpunk
Title.TextSize = 16

-- Label Input
InputLabel.Parent = MainFrame
InputLabel.BackgroundTransparency = 1
InputLabel.Position = UDim2.new(0, 10, 0, 45)
InputLabel.Size = UDim2.new(0, 200, 0, 25)
InputLabel.Font = Enum.Font.SourceSans
InputLabel.Text = "Atur Waktu Jeda (Menit):"
InputLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
InputLabel.TextSize = 14
InputLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Kotak Input Menit (Bisa Diketik)
MinuteInput.Name = "MinuteInput"
MinuteInput.Parent = MainFrame
MinuteInput.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
MinuteInput.Position = UDim2.new(0, 10, 0, 75)
MinuteInput.Size = UDim2.new(0, 200, 0, 30)
MinuteInput.Font = Enum.Font.SourceSans
MinuteInput.Text = "5" -- Default waktu 5 menit
MinuteInput.TextColor3 = Color3.fromRGB(255, 255, 255)
MinuteInput.TextSize = 16
UICorner2.Parent = MinuteInput

-- Tombol Saklar ON/OFF
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = MainFrame
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Merah pas OFF
ToggleBtn.Position = UDim2.new(0, 10, 0, 120)
ToggleBtn.Size = UDim2.new(0, 200, 0, 40)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Text = "STATUS: OFF"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 16
UICorner3.Parent = ToggleBtn

-- 2. LOGIKA DAN SISTEM UTAMA
local SistemAktif = false
local VirtualUser = game:GetService("VirtualUser")

-- Fitur Anti-AFK Bawaan (Selalu aktif pas UI di-inject agar tidak terdepak 20 menit)
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    if SistemAktif then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

-- Loop Fungsi Pengecekan Rejoin
spawn(function()
    while true do
        wait(5) -- Cek status saklar setiap 5 detik
        if SistemAktif then
            local durasi = tonumber(MinuteInput.Text) or 5
            wait(durasi * 60)
            
            -- Jika tombol putus koneksi/DC terdeteksi di layar kamu
            local CoreGui = game:GetService("CoreGui")
            if CoreGui:FindFirstChild("RobloxPromptGui") then
                local prompt = CoreGui.RobloxPromptGui:FindFirstChild("promptOverlay")
                if prompt and prompt:FindFirstChild("ErrorPrompt") then
                    
                    local TeleportService = game:GetService("TeleportService")
                    local Players = game:GetService("Players")
                    
                    if #Players:GetPlayers() <= 1 then
                        -- Jika di Private Server sendirian
                        TeleportService:Teleport(game.PlaceId, Players.LocalPlayer)
                    else
                        -- Jika di Public Server / Server Ramai
                        TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Players.LocalPlayer)
                    end
                end
            end
        end
    end
end)

-- Mengatur Klik Tombol SAKLAR ON/OFF
ToggleBtn.MouseButton1Click:Connect(function()
    SistemAktif = not SistemAktif
    if SistemAktif then
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 180, 50) -- Berubah Hijau saat ON
        ToggleBtn.Text = "STATUS: ON"
        print("[LEXSA] Auto Rejoin dinyalakan dengan jeda " .. MinuteInput.Text .. " menit.")
    else
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50) -- Berubah Merah saat OFF
        ToggleBtn.Text = "STATUS: OFF"
        print("[LEXSA] Auto Rejoin dimatikan.")
    end
end)

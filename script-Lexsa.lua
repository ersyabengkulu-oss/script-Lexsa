-- KODE INI HANYA UNTUK PELAJARAN LOGIKA, BUKAN UNTUK SCRIPT JADI --

-- 1. Servis yang Dibutuhkan
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- 2. Variabel Penting
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()
local isAiming = false -- Status apakah tombol aim ditekan

-- 3. Fungsi Mencari Musuh Terdekat
local function GetClosestPlayer()
    local target = nil
    local shortestDistance = math.huge -- Setel jarak awal tak terhingga

    -- Loop semua player di game
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid").Health > 0 then
            -- Hitung jarak dari karakter lo ke karakter musuh (pake Vector3)
            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
            
            -- Kalau jaraknya paling deket, jadikan target
            if distance < shortestDistance then
                target = player
                shortestDistance = distance
            end
        end
    end
    return target
end

-- 4. Fungsi Mengarahkan Kamera (Logic Utama)
RunService.RenderStepped:Connect(function()
    if isAiming then
        local targetPlayer = GetClosestPlayer() -- Cari musuh terdekat
        if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("Head") then
            -- INI INTI AUTO AIM: Paksa kamera melihat ke koordinat Kepala Musuh
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, targetPlayer.Character.Head.Position)
        end
    end
end)

-- 5. Fungsi Mendeteksi Tombol (Misal: Tahan Tombol E)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.E then
        isAiming = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.E then
        isAiming = false
    end
end)

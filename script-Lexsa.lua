-- ============================================
-- SET WAYPOINT SAJA | DARI DATA YANG UDAH WORK
-- Kompatibel: Arceus & Delta
-- ============================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local Waypoints = {}
local CurrentIndex = 1
local isLooping = true
local isRunning = false
local moveDelay = 1

-- AMBIL POSISI SEKARANG → TAMBAH KE DAFTAR
local function AddWaypoint(name)
    local Char = Player.Character
    if not Char or not Char:FindFirstChild("HumanoidRootPart") then
        return warn("⚠️ Karakter belum dimuat!")
    end
    local pos = Char.HumanoidRootPart.CFrame
    table.insert(Waypoints, {
        Name = name or "Titik "..#Waypoints+1,
        Position = pos
    })
    print("✅ Ditambah ["..#Waypoints.."]: "..(name or "Titik "..#Waypoints))
end

-- HAPUS WAYPOINT BERDASARKAN NOMOR
local function RemoveWaypoint(index)
    if Waypoints[index] then
        table.remove(Waypoints, index)
        print("🗑️ Dihapus titik ke-"..index)
    end
end

-- HAPUS SEMUA
local function ClearAllWaypoints()
    Waypoints = {}
    CurrentIndex = 1
    print("🗑️ Semua waypoint dihapus")
end

-- PINDAH KE TITIK SEKARANG
local function MoveToCurrent()
    if #Waypoints == 0 then return end
    local wp = Waypoints[CurrentIndex]
    local Char = Player.Character
    if not Char or not Char:FindFirstChild("HumanoidRootPart") then return end
    Char.HumanoidRootPart.CFrame = wp.Position
    print("📍 Sampai: "..wp.Name)
end

-- MULAI JALAN OTOMATIS
local function StartWaypoint()
    if #Waypoints == 0 then
        return warn("⚠️ Belum ada waypoint! Tambah dulu pakai AddWaypoint()")
    end
    isRunning = true
    task.spawn(function()
        while isRunning do
            MoveToCurrent()
            CurrentIndex += 1
            if CurrentIndex > #Waypoints then
                if isLooping then
                    CurrentIndex = 1
                    print("🔁 Ulang dari awal")
                else
                    isRunning = false
                    print("✅ Selesai semua titik")
                    break
                end
            end
            task.wait(moveDelay)
        end
    end)
end

-- BERHENTI
local function StopWaypoint()
    isRunning = false
    print("⏹️ Berhenti")
end

-- UBAH JEDA (detik)
local function SetDelay(detik)
    moveDelay = detik
end

-- AKTIFKAN / MATIKAN LOOP
local function SetLoop(bool)
    isLooping = bool
end

-- ==========================================
-- 📌 CARA PAKAI — COPY DI KONSOL / EXECUTOR
-- ==========================================
-- AddWaypoint("Depan Kebun")   → tambah titik di posisi sekarang
-- AddWaypoint("Tengah")
-- AddWaypoint("Toko")
-- StartWaypoint()              → mulai jalan
-- StopWaypoint()               → berhenti
-- RemoveWaypoint(2)            → hapus titik ke-2
-- ClearAllWaypoints()          → hapus semua
-- SetDelay(0.5)                → ubah jeda jadi 0.5 detik
-- SetLoop(false)               → matikan ulang otomatis

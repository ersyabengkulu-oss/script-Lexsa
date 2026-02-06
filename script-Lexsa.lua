-- [[ LEXSA BUG RESEARCHER - AUTO TESTER ]]

local RS = game:GetService("ReplicatedStorage")
local Remote = RS.RemoteEvent.ServerRemoteEvent -- Remote yang kamu temukan

-- Mengetes peningkatan level dengan angka yang berbeda
local testValues = {50, 100, 500} -- Kita coba tes dari angka 50 sampai 500

print("--- Memulai Pengetesan Celah Remote ---")

for _, val in ipairs(testValues) do
    local args = {
        [1] = "Business",
        [2] = "\232\158\141\229\144\136_\229\174\160\231\137\169", -- ID Tanaman dari fotomu
        [3] = val -- Mengganti angka 48 dengan nilai tes
    }
    
    print("Mencoba mengirim nilai: " .. val)
    Remote:FireServer(unpack(args)) -- Kirim ke server
    task.wait(1) -- Beri jeda agar tidak langsung terdeteksi spam
end

print("--- Tes Selesai. Cek apakah DPS atau Level tanamanmu berubah! ---")

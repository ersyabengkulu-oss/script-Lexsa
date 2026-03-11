-- AUTO UPGRADE - SESUAI KODE SIMPLESPY
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Lokasi Remote Event yang ditemukan
local UpgradeRemote = ReplicatedStorage:FindFirstChild("Packages")
if UpgradeRemote then
    UpgradeRemote = UpgradeRemote:FindFirstChild("Packets")
    if UpgradeRemote then
        UpgradeRemote = UpgradeRemote:FindFirstChild("PacketModule")
        if UpgradeRemote then
            UpgradeRemote = UpgradeRemote:FindFirstChild("RemoteEvent")
        end
    end
end

-- Cek apakah remote ditemukan
if not UpgradeRemote or not UpgradeRemote:IsA("RemoteEvent") then
    warn("Remote Event tidak ditemukan! Pastikan lokasinya benar.")
else
    print("Auto Upgrade aktif!")
    
    -- Fungsi untuk menjalankan upgrade
    local function runUpgrade()
        local args = {
            [1] = nil --[[buffer]] -- Sama seperti yang ada di SimpleSpy
        }
        -- Jalankan remote call
        UpgradeRemote:FireServer(unpack(args))
    end

    -- Jalankan setiap 3-5 detik (sesuaikan aja)
    while task.wait(4) do
        runUpgrade()
        print("Upgrade dipanggil! Cek apakah ada perubahan di game.")
    end
end

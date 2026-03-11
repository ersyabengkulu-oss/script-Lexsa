-- VERSI ALTERNATIF - JIKA VERSI PERTAMA TIDAK BERJALAN
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UpgradeRemote = ReplicatedStorage.Packages.Packets.PacketModule.RemoteEvent

-- Coba kirim dengan beberapa variasi args
local possibleArgs = {
    nil,
    "",
    0,
    {}
}

print("Mencoba berbagai variasi args...")
for _, arg in pairs(possibleArgs) do
    local args = {[1] = arg}
    UpgradeRemote:FireServer(unpack(args))
    print("Dikirim dengan arg:", arg)
    task.wait(2)
end

-- Setelah menemukan arg yang bekerja, gunakan di loop
while task.wait(5) do
    UpgradeRemote:FireServer(nil) -- Ganti nil dengan arg yang berhasil
    print("Auto Upgrade berjalan...")
end

-- Scanner Khusus Violet District
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local lp = game.Players.LocalPlayer

print("--- Menunggu Signal Medis... ---")

-- Kita pantau folder Packets yang pernah kamu liat kemarin
local packetModule = ReplicatedStorage:FindFirstChild("Packages") and ReplicatedStorage.Packages:FindFirstChild("Packets")

if packetModule then
    print("Folder Packets Ditemukan, Memantau...")
    -- Script ini bakal bunyi kalau ada aktivitas Remote pas kamu di-heal
    for _, v in pairs(packetModule:GetDescendants()) do
        if v:IsA("RemoteEvent") then
            v.OnClientEvent:Connect(function()
                print("Aktivitas Terdeteksi di: " .. v.Name)
            end)
        end
    end
end

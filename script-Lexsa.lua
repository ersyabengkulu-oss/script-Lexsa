-- SCRIPT TRICK "Knit Ghost"
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MiningRF, SellRF

-- Mencari Remote secara otomatis di seluruh folder
for _, v in pairs(ReplicatedStorage:GetDescendants()) do
    if v.Name == "HitRock" and v:IsA("RemoteFunction") then
        MiningRF = v
    elseif v.Name == "SellJewels" and v:IsA("RemoteFunction") then
        SellRF = v
    end
end

-- Eksekusi Penambangan & Penjualan
if MiningRF and SellRF then
    print("Remote Berhasil Ditemukan! Mulai Farming...")
    
    spawn(function()
        while task.wait(0.2) do
            -- Kita cari batu terdekat
            for _, stone in pairs(game.Workspace:GetChildren()) do
                if stone:IsA("Model") and stone.Name:find("_") then
                    local p = game.Players.LocalPlayer.Character.HumanoidRootPart.Position
                    if (p - stone:GetModelCFrame().Position).Magnitude < 15 then
                        -- Gunakan pcall agar tidak crash kalau batu hancur
                        pcall(function() MiningRF:InvokeServer(stone.Name) end)
                    end
                end
            end
        end
    end)
    
    spawn(function()
        while task.wait(10) do
            pcall(function() SellRF:InvokeServer() end)
        end
    end)
else
    print("Gagal menemukan Remote. Coba gerakkan karaktermu dulu!")
end

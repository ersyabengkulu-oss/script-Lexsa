-- BIKINI BOTTOM SURVIVOR - LEXSA EDITION
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DamageRemote = ReplicatedStorage:WaitForChild("GearInteractions"):WaitForChild("TryDamageEntity") -- Berdasarkan log TryDamageEntity
local LootRemote = ReplicatedStorage:FindFirstChild("NetworkEvent", true) -- Mencari NetworkEvent secara dinamis

_G.AutoKill = true
_G.AutoLoot = true

-- 1. KILL AURA (Otomatis Serang Ubur-ubur/Monster Terdekat)
spawn(function()
    while _G.AutoKill do
        task.wait(0.1)
        for _, v in pairs(game.Workspace.Map.Jellyfish:GetChildren()) do -- Folder ubur-ubur dari log kamu
            local char = game.Players.LocalPlayer.Character
            if char and v:FindFirstChild("Base") then
                local dist = (char.HumanoidRootPart.Position - v.Base.Position).Magnitude
                if dist < 20 then
                    -- Kirim damage sesuai format log kamu: [1] = target, [2] = posisi
                    DamageRemote:FireServer(v, v.Base.Position)
                end
            end
        end
    end
end)

-- 2. AUTO LOOT (Ambil JellyBlob Otomatis)
spawn(function()
    while _G.AutoLoot do
        task.wait(0.5)
        for _, v in pairs(game.Workspace.LootDrops:GetChildren()) do
            if v.Name == "JellyBlob" then
                -- Gunakan format OnUnstashItem dari log NetworkEvent kamu
                local args = {[1] = 144, [2] = "OnUnstashItem", [3] = v}
                LootRemote:FireServer(unpack(args))
            end
        end
    end
end)

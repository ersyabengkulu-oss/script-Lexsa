-- SCRIPT PERBAIKAN UNTUK LEXSA
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Mencari Remote secara dinamis (mencegah error path)
local function getRemote(name)
    for _, v in pairs(ReplicatedStorage:GetDescendants()) do
        if v.Name == name and (v:IsA("RemoteFunction") or v:IsA("UnreliableRemoteEvent")) then
            return v
        end
    end
end

local MiningRemote = getRemote("HitRock")
local EggRemote = getRemote("PickUpEgg")
local SellRemote = getRemote("SellJewels")

_G.Active = true

-- 1. AUTO MINING (Sekarang lebih responsif)
spawn(function()
    while _G.Active do
        task.wait(0.2)
        if MiningRemote then
            for _, v in pairs(game.Workspace:GetChildren()) do
                if v:IsA("Model") and v.Name:find("_") then
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        if (char.HumanoidRootPart.Position - v:GetModelCFrame().Position).Magnitude < 18 then 
                            -- Menggunakan InvokeServer sesuai log SimpleSpy-mu
                            pcall(function() MiningRemote:InvokeServer(v.Name) end)
                        end
                    end
                end
            end
        end
    end
end)

-- 2. AUTO SELL (Tiap 8 Detik)
spawn(function()
    while _G.Active do
        task.wait(8)
        if SellRemote then
            pcall(function() SellRemote:InvokeServer() end)
        end
    end
end)

print("Script Versi 2 diaktifkan! Coba dekati batu tambangnya.")

-- Mega Script Brainrot Raja Server by Gemini for Lexsa
-- Fitur: Auto-Click, Auto-Teleport Rarity, Auto-Rebirth

_G.RajaServer = true

-- 1. Fungsi Auto-Click (Buat nambah uang/speed tanpa henti)
spawn(function()
    while _G.RajaServer do
        game:GetService("ReplicatedStorage").Events.ClickEvent:FireServer()
        task.wait(0.01) -- Speed klik maksimal
    end
end)

-- 2. Fungsi Auto-Rebirth (Biar multiplier kamu jadi yang tertinggi)
spawn(function()
    while _G.RajaServer do
        game:GetService("ReplicatedStorage").Events.RebirthEvent:FireServer()
        task.wait(5) -- Rebirth setiap 5 detik
    end
end)

-- 3. Fungsi Auto-Loop Teleport (Koleksi Full Index Divine)
spawn(function()
    local player = game.Players.LocalPlayer
    local rarities = {"Divine", "Supreme", "Radioactive", "Lava", "Diamond", "Gold"}
    
    while _G.RajaServer do
        local character = player.Character or player.CharacterAdded:Wait()
        local root = character:WaitForChild("HumanoidRootPart")
        
        for _, name in pairs(rarities) do
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v:IsA("BasePart") and (v.Name:find(name) or (v.Parent and v.Parent.Name:find(name))) then
                    root.CFrame = v.CFrame
                    task.wait(0.3) -- Jeda biar server detect "Claim"
                end
            end
        end
        task.wait(1) -- Jeda sebelum putaran berikutnya
    end
end)

print("Mega Script Berhasil Dijalankan! Waktunya jadi yang terkaya.")

-- Script Supreme Hunter V3 by Gemini for Lexsa
-- Target: Khusus Brainrot Rarity Supreme

_G.SupremeMode = true

-- Alamat Remote sesuai SimpleSpy kamu
local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent

spawn(function()
    while _G.SupremeMode do
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local root = character:WaitForChild("HumanoidRootPart")
        
        -- Cari semua objek di Workspace
        for _, v in pairs(game.Workspace:GetDescendants()) do
            -- Kita cari yang namanya mengandung 'Supreme'
            if v:IsA("BasePart") and string.find(string.lower(v.Name), "supreme") then
                -- Teleport ke lokasi
                root.CFrame = v.CFrame
                
                -- Jalankan sinyal Remote yang kamu tangkap tadi
                local args = { [1] = nil }
                Remote:FireServer(unpack(args))
                
                task.wait(0.3) -- Jeda biar masuk inventory
            end
        end
        task.wait(1)
    end
end)

print("Supreme Hunter V3 Aktif! Menuju Sultan 2.51B++")

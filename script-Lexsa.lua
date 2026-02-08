-- Script Supreme Hunter V2 by Gemini
_G.SupremeMode = true

local player = game.Players.LocalPlayer
print("Memulai pencarian Supreme...")

spawn(function()
    while _G.SupremeMode do
        local character = player.Character or player.CharacterAdded:Wait()
        local root = character:WaitForChild("HumanoidRootPart")
        local found = false

        -- Scan mendalam ke seluruh folder Workspace
        for _, v in pairs(game.Workspace:GetDescendants()) do
            -- Kita cari yang namanya mengandung 'Supreme' (tidak sensitif huruf besar/kecil)
            if v:IsA("BasePart") and string.find(string.lower(v.Name), "supreme") then
                print("Supreme Ditemukan: " .. v.Name)
                root.CFrame = v.CFrame
                found = true
                task.wait(0.5) 
            end
        end
        
        if not found then
            -- Kalau tidak ketemu, mungkin namanya pake kode lain. 
            -- Coba teleport ke koordinat uang 2.51B kamu berada biasanya.
            task.wait(2) 
        end
    end
end)

-- LEXSA V8.6: HOTBAR BYPASS [2026-02-06]
local catching = false
CatchBtn.MouseButton1Click:Connect(function()
    catching = not catching
    CatchBtn.Text = catching and "HOTBAR: ON" or "HOTBAR: OFF"
    
    task.spawn(function()
        local Net = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net
        
        while catching do
            pcall(function()
                -- 1. Paksa Equip Tanpa Unpack (Langsung ke Slot 1)
                Net["RE/EquipToolFromHotbar"]:FireServer(1)
                task.wait(0.3) -- Beri jeda lebih lama agar karakter benar-benar memegang alat
                
                -- 2. Urutan Mancing Cepat
                Net["RF/ChargeFishingRod"]:InvokeServer(100)
                task.wait(0.2)
                
                -- 3. Klaim dengan Argumen "Fish"
                Net["RF/CatchFishCompleted"]:InvokeServer("Fish")
                Net["RE/ClaimNotification"]:FireServer("Fish")
                
                print("LEXSA: Mencoba Klaim...")
            end)
            task.wait(0.5) 
        end
    end)
end)

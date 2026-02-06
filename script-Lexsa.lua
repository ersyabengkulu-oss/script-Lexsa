-- LEXSA V9.1: FORCE CASTING ANIMATION [2026-02-06]
while catching do
    pcall(function()
        -- 1. PEGANG ALAT (Wajib agar animasi bisa jalan)
        local Character = game.Players.LocalPlayer.Character
        local Tool = Character:FindFirstChildOfClass("Tool") or game.Players.LocalPlayer.Backpack:FindFirstChild("Batang Berlian")
        
        if Tool then
            -- 2. PAKSA ANIMASI MELEMPAR (Klik Kiri Simulasi)
            -- Ini akan memicu karakter melempar umpan secara fisik
            Tool:Activate() 
            
            -- 3. KIRIM REMOTE LEMPAR (Power 100)
            Net["RF/ChargeFishingRod"]:InvokeServer(100)
            task.wait(0.2) -- Jeda biar umpan "nyemplung"
            
            -- 4. FAST REEL (Tarik Ikan Otomatis)
            Net["RF/CatchFishCompleted"]:InvokeServer("Fish")
            Net["RE/ClaimNotification"]:FireServer("Fish")
            
            print("LEXSA: Umpan ditaruh & Ikan ditarik!")
        else
            -- Jika tidak pegang alat, paksa equip dulu
            Net["RE/EquipToolFromHotbar"]:FireServer(1)
        end
    end)
    task.wait(0.5) -- Delay total agar tidak DC
end

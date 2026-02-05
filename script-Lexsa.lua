-- LEXSA V8.7: VIRTUAL HOTBAR PRESS [2026-02-06]
local catching = false
CatchBtn.MouseButton1Click:Connect(function()
    catching = not catching
    CatchBtn.Text = catching and "SIMULASI: ON" or "SIMULASI: OFF"
    
    task.spawn(function()
        local VirtualInput = game:GetService("VirtualInputManager")
        local Net = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net
        
        while catching do
            pcall(function()
                -- 1. Simulasi Tekan Angka 1 (Memaksa Memegang Pancingan)
                -- Ini cara paling aman jika Remote di-block server
                VirtualInput:SendKeyEvent(true, Enum.KeyCode.One, false, game)
                task.wait(0.2)
                
                -- 2. Kirim Remote Mancing (Gunakan urutan Vora)
                Net["RF/ChargeFishingRod"]:InvokeServer(100)
                task.wait(0.1)
                
                -- 3. Klaim Ikan (Berdasarkan hasil Spy kamu yang "Fish")
                Net["RF/CatchFishCompleted"]:InvokeServer("Fish")
                Net["RE/ClaimNotification"]:FireServer("Fish")
                
                print("LEXSA: Simulasi Selesai!")
            end)
            task.wait(0.5) -- Delay Reel agar tidak terdeteksi
        end
    end)
end)

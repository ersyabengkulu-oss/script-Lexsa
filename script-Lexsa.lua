-- LEXSA V12.0: FINAL AUTO-CAST FIX [2026-02-06]
local catching = false
CatchBtn.MouseButton1Click:Connect(function()
    catching = not catching
    CatchBtn.Text = catching and "GACOR: ON" or "GACOR: OFF"
    CatchBtn.BackgroundColor3 = catching and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(200, 0, 0)
    
    if catching then
        task.spawn(function()
            local RS = game:GetService("ReplicatedStorage")
            local Net = RS.Packages._Index:FindFirstChild("sleitnick_net@0.2.0", true).net
            
            while catching do
                pcall(function()
                    local Char = game.Players.LocalPlayer.Character
                    
                    -- 1. PEGANG PANCINGAN
                    Net["RE/EquipToolFromHotbar"]:FireServer(1)
                    task.wait(0.8) -- Jeda lebih lama agar server deteksi alat dipegang
                    
                    -- 2. NAROK UMPAN (LEMpar)
                    -- Kita tembak remote, lalu paksa klik fisik
                    Net["RF/ChargeFishingRod"]:InvokeServer(100)
                    task.wait(0.2)
                    Char:FindFirstChildOfClass("Tool"):Activate() 
                    print("LEXSA: Mencoba Melempar...")
                    
                    -- 3. JEDA MENUNGGU (WAJIB LAMA)
                    -- Kita beri waktu 3 detik agar umpan benar-benar sah di air
                    task.wait(3.0) 
                    
                    -- 4. TARIK IKAN CEPAT
                    Net["RF/CatchFishCompleted"]:InvokeServer("Fish")
                    task.wait(0.5)
                    Net["RE/ClaimNotification"]:FireServer("Fish")
                    print("LEXSA: Ikan Didapat!")
                    
                    -- 5. JEDA RESET (Agar tidak bug di lemparan berikutnya)
                    task.wait(2.5) -- Waktu istirahat karakter
                end)
            end
        end)
    end
end)

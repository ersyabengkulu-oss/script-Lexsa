-- LEXSA V9.0: FIXED CASTING & FAST REEL [2026-02-06]
local catching = false
CatchBtn.MouseButton1Click:Connect(function()
    catching = not catching
    CatchBtn.Text = catching and "STATUS: ON" or "STATUS: OFF"
    CatchBtn.BackgroundColor3 = catching and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    
    if catching then
        task.spawn(function()
            local Net = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net
            
            -- Pastikan pancingan dipegang dulu
            Net["RE/EquipToolFromHotbar"]:FireServer(1)
            task.wait(0.3)
            
            while catching do
                pcall(function()
                    -- 1. FIX LEMPAR (Narok Umpan): Kita paksa lempar dengan Power 100
                    Net["RF/ChargeFishingRod"]:InvokeServer(100) 
                    task.wait(0.1) -- Delay Bait sangat tipis sesuai Vora
                    
                    -- 2. TRIGGER START: Memulai sesi mancing
                    Net["RF/RequestFishingMinigame"]:InvokeServer()
                    
                    -- 3. FAST REEL (Tarik Ikan): Sesuai hasil temuanmu yang "Fish"
                    Net["RF/CatchFishCompleted"]:InvokeServer("Fish")
                    Net["RE/ClaimNotification"]:FireServer("Fish")
                    
                    print("LEXSA: Berhasil Lempar & Tarik!")
                end)
                task.wait(0.4) -- Jeda antar tarikan agar tidak DC
            end
        end)
    end
end)

-- LEXSA V11.3: AUTO-CAST FIXED [2026-02-06]
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
                    -- 1. PASTIKAN PEGANG ROD
                    Net["RE/EquipToolFromHotbar"]:FireServer(1)
                    task.wait(0.6) -- Beri waktu karakter untuk benar-benar pegang rod
                    
                    -- 2. NAROK UMPAN (Cast)
                    -- Kita panggil remote-nya, lalu paksa klik pancingannya
                    Net["RF/ChargeFishingRod"]:InvokeServer(100)
                    task.wait(0.2)
                    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):Activate()
                    print("LEXSA: Umpan Ditarok...")
                    
                    -- 3. JEDA BERMAIN (WAJIB LAMA)
                    -- Kita tunggu 2.5 detik agar kail benar-benar dianggap sah di air
                    task.wait(2.5) 
                    
                    -- 4. TARIK IKAN CEPAT
                    Net["RF/CatchFishCompleted"]:InvokeServer("Fish")
                    task.wait(0.2)
                    Net["RE/ClaimNotification"]:FireServer("Fish")
                    print("LEXSA: Ikan Didapat!")
                    
                    -- 5. JEDA RESET (Agar tidak error di lemparan berikutnya)
                    task.wait(2.0)
                end)
            end
        end)
    end
end)

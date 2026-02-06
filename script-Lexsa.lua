-- LEXSA V11.2: SOLUSI NAROK UMPAN MACET [2026-02-06]
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
                    -- 1. PEGANG ALAT & RESET STATUS
                    Net["RE/EquipToolFromHotbar"]:FireServer(1)
                    task.wait(0.5) -- Jeda agar karakter stabil
                    
                    -- 2. NAROK UMPAN (Pemicu Utama)
                    -- Memanggil Charge dua kali untuk memastikan server menerima perintah
                    Net["RF/ChargeFishingRod"]:InvokeServer(100)
                    task.wait(0.1)
                    game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool"):Activate()
                    
                    -- 3. JEDA MENUNGGU (Penting!)
                    -- Beri waktu 2 detik agar umpan benar-benar dianggap sah oleh game
                    task.wait(2.0) 
                    
                    -- 4. NARIK IKAN CEPAT
                    Net["RF/CatchFishCompleted"]:InvokeServer("Fish")
                    task.wait(0.3)
                    
                    -- 5. KLAIM HADIAH
                    Net["RE/ClaimNotification"]:FireServer("Fish")
                    print("LEXSA: Ikan Didapat, Menunggu Reset...")
                    
                    -- 6. JEDA RESET SERVER (Agar tidak macet di lemparan berikutnya)
                    task.wait(1.5) 
                end)
            end
        end)
    end
end)

-- LEXSA V10.3: RE-SYNC CASTING [2026-02-06]
local catching = false
CatchBtn.MouseButton1Click:Connect(function()
    catching = not catching
    CatchBtn.Text = catching and "GACOR: ON" or "GACOR: OFF"
    CatchBtn.BackgroundColor3 = catching and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(200, 0, 0)
    
    if catching then
        task.spawn(function()
            local RS = game:GetService("ReplicatedStorage")
            local Net = RS:WaitForChild("Packages"):WaitForChild("_Index"):FindFirstChild("sleitnick_net@0.2.0", true):WaitForChild("net")
            
            while catching do
                pcall(function()
                    local Char = game.Players.LocalPlayer.Character
                    local Tool = Char:FindFirstChildOfClass("Tool")
                    
                    -- 1. Pastikan Pegang Rod
                    if not Tool then
                        Net["RE/EquipToolFromHotbar"]:FireServer(1)
                        task.wait(0.5)
                        Tool = Char:FindFirstChildOfClass("Tool")
                    end
                    
                    if Tool then
                        -- 2. NAROK UMPAN (Langkah Awal)
                        -- Kita panggil Charge dua kali untuk memastikan server menerima
                        Net["RF/ChargeFishingRod"]:InvokeServer(100)
                        task.wait(0.1)
                        Tool:Activate() -- Animasi Lempar
                        
                        -- 3. JEDA BERMAIN (Sangat Penting!)
                        -- Kita beri waktu 1.5 detik agar umpan dianggap sah masuk air
                        task.wait(1.5) 
                        
                        -- 4. NARIK IKAN (Fast Reel)
                        Net["RF/CatchFishCompleted"]:InvokeServer("Fish")
                        task.wait(0.2)
                        Net["RE/ClaimNotification"]:FireServer("Fish")
                        
                        print("LEXSA: Siklus Selesai!")
                    end
                end)
                task.wait(1) -- Cooldown sebelum melempar lagi
            end
        end)
    end
end)

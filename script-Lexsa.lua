-- LEXSA V10.1: FIX AUTO-CAST (NAROK UMPAN) [2026-02-06]
local catching = false
CatchBtn.MouseButton1Click:Connect(function()
    catching = not catching
    CatchBtn.Text = catching and "GACOR: ON" or "GACOR: OFF"
    CatchBtn.BackgroundColor3 = catching and Color3.fromRGB(0, 200, 80) or Color3.fromRGB(200, 0, 0)
    
    if catching then
        task.spawn(function()
            local RS = game:GetService("ReplicatedStorage")
            local Net = RS:WaitForChild("Packages"):WaitForChild("_Index"):FindFirstChild("sleitnick_net@0.2.0", true):WaitForChild("net")
            
            while catching do
                pcall(function()
                    local Player = game.Players.LocalPlayer
                    local Char = Player.Character
                    local Humanoid = Char:FindFirstChildOfClass("Humanoid")
                    
                    -- 1. CEK ALAT
                    local Tool = Char:FindFirstChildOfClass("Tool")
                    if not Tool then
                        Net["RE/EquipToolFromHotbar"]:FireServer(1)
                        task.wait(0.3)
                        Tool = Char:FindFirstChildOfClass("Tool")
                    end
                    
                    if Tool then
                        -- 2. RESET STATE (Lompat Kecil agar server refresh status)
                        -- Ini trik agar "Narok Umpan" tidak macet
                        Humanoid.Jump = true 
                        task.wait(0.2)
                        
                        -- 3. NAROK UMPAN (Melempar)
                        Tool:Activate() 
                        Net["RF/ChargeFishingRod"]:InvokeServer(100) 
                        print("LEXSA: Umpan Berhasil Ditarok!")
                        
                        -- 4. TUNGGU IKAN NYANGKUT (Beri jeda agar tidak dianggap spam)
                        task.wait(0.7) 
                        
                        -- 5. TARIK IKAN (Fast Reel)
                        Net["RF/CatchFishCompleted"]:InvokeServer("Fish")
                        Net["RE/ClaimNotification"]:FireServer("Fish")
                        print("LEXSA: Ikan Ditarik!")
                    end
                end)
                task.wait(0.5) -- Jeda antar siklus
            end
        end)
    end
end)

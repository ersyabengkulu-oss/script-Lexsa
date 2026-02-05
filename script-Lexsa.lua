-- LEXSA V8.5: FULL AUTHENTICATION BYPASS [2026-02-06]
local catching = false
CatchBtn.MouseButton1Click:Connect(function()
    catching = not catching
    CatchBtn.Text = catching and "GACOR TOTAL: ON" or "GACOR TOTAL: OFF"
    
    task.spawn(function()
        local Net = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net
        
        while catching do
            pcall(function()
                -- 1. WAJIB: Paksa Pegang Pancingan (Slot 1)
                Net["RE/EquipToolFromHotbar"]:FireServer(1)
                task.wait(0.1)
                
                -- 2. Lempar Kail
                Net["RF/ChargeFishingRod"]:InvokeServer(100)
                task.wait(0.2)
                
                -- 3. Trigger Minigame Start
                Net["RF/RequestFishingMinigame"]:InvokeServer()
                task.wait(0.1)
                
                -- 4. Langsung Tangkap dengan Kata Kunci "Fish"
                Net["RF/CatchFishCompleted"]:InvokeServer("Fish")
                
                -- 5. Klaim Hadiah agar Masuk Tas
                Net["RE/ClaimNotification"]:FireServer("Fish")
                
                print("LEXSA: Full Sequence Sent!")
            end)
            task.wait(0.5) -- Delay biar gak dicurigai server
        end
    end)
end)

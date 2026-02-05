-- LEXSA V8.2: AUTO-CLAIM FISH [2026-02-06]
local catching = false
CatchBtn.MouseButton1Click:Connect(function()
    catching = not catching
    CatchBtn.Text = catching and "AUTO-CLAIM: ON" or "AUTO-CLAIM: OFF"
    
    task.spawn(function()
        local Net = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net
        
        while catching do
            pcall(function()
                -- 1. Lempar Kail
                Net["RF/ChargeFishingRod"]:InvokeServer(100)
                task.wait(0.1) -- Mengikuti jeda Vora Hub
                
                -- 2. Tangkap Ikan
                Net["RF/CatchFishCompleted"]:InvokeServer("Fish")
                
                -- 3. KLAIM HADIAH (Ini yang baru kamu temukan!)
                Net["RE/ClaimNotification"]:FireServer("Fish")
                
                print("LEXSA: Ikan diklaim ke tas!")
            end)
            task.wait(0.4) -- Delay Reel agar tidak lag
        end
    end)
end)

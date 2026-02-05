-- LEXSA V8.3: MODULE BYPASS [2026-02-06]
local catching = false
CatchBtn.MouseButton1Click:Connect(function()
    catching = not catching
    CatchBtn.Text = catching and "BYPASS: ON" or "BYPASS: OFF"
    
    task.spawn(function()
        -- Mencari jalur Net secara dinamis sesuai hasil SimpleSpy kamu
        local Net = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net
        
        while catching do
            pcall(function()
                -- Step 1: Simulasi Melempar Kail (Charge)
                Net["RF/ChargeFishingRod"]:InvokeServer(100)
                task.wait(0.2) 
                
                -- Step 2: Trigger Game Start (PENTING!)
                Net["RF/RequestFishingMinigame"]:InvokeServer()
                task.wait(0.2)
                
                -- Step 3: Selesaikan Pancingan dengan Argument "Fish"
                Net["RF/CatchFishCompleted"]:InvokeServer("Fish")
                
                -- Step 4: Klaim Hadiah
                Net["RE/ClaimNotification"]:FireServer("Fish")
                
                print("LEXSA: Remote Sequence Sent!")
            end)
            task.wait(0.5) -- Delay mengikuti Vora Hub
        end
    end)
end)

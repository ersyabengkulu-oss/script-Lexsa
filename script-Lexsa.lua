-- LEXSA V7.9: DIRECT PATH FIX
local catching = false
CatchBtn.MouseButton1Click:Connect(function()
    catching = not catching
    CatchBtn.Text = catching and "STRICT: ON" or "STRICT: OFF"
    
    task.spawn(function()
        -- Kita pakai cara mencari (Find) agar tidak error jika folder tidak ketemu
        local RS = game:GetService("ReplicatedStorage")
        local Net = RS:WaitForChild("Packages"):WaitForChild("_Index"):FindFirstChild("sleitnick_net@0.2.0", true):WaitForChild("net")
        
        local RemoteCast = Net:FindFirstChild("RF/ChargeFishingRod")
        local RemoteCatch = Net:FindFirstChild("RF/CatchFishCompleted")
        
        while catching do
            pcall(function()
                -- Step 1: Paksa Lempar (Power 100)
                RemoteCast:InvokeServer(100)
                task.wait(0.1) -- Delay Bait Vora
                
                -- Step 2: Paksa Menang
                RemoteCatch:InvokeServer()
                print("Remote Terkirim!") -- Cek di F9 apakah tulisan ini muncul
            end)
            task.wait(0.4) -- Delay Reel Vora
        end
    end)
end)

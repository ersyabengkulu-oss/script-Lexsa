-- LEXSA V7.5: FIX REMOTE SEQUENCE
local catching = false
CatchBtn.MouseButton1Click:Connect(function()
    catching = not catching
    CatchBtn.Text = catching and "FIXED: ON" or "FIXED: OFF"
    
    task.spawn(function()
        local RS = game:GetService("ReplicatedStorage")
        -- Cari folder remote sesuai game pancingmu
        local cast = RS:FindFirstChild("ChargeFishingRod", true)
        local req = RS:FindFirstChild("RequestFishingMinigame", true)
        local catch = RS:FindFirstChild("CatchFishComplete", true)
        
        while catching do
            pcall(function()
                -- 1. Lempar (Sesuai urutan log 1)
                cast:InvokeServer(100)
                task.wait(0.2) 
                
                -- 2. Request Minigame (Sesuai urutan log 2)
                req:InvokeServer()
                task.wait(0.2)
                
                -- 3. Klaim Ikan (Sesuai urutan log 3)
                catch:InvokeServer(true)
                task.wait(0.5) -- Beri waktu server bernapas
            end)
        end
    end)
end)

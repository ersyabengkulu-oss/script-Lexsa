-- LEXSA V7.4: OVERCLOCK EDITION (FAST REEL)
-- Settings disesuaikan dengan Vora Hub (Delay 0.4 & 0.1)

local catching = false
CatchBtn.MouseButton1Click:Connect(function()
    catching = not catching
    CatchBtn.Text = catching and "INSTANT: ON" or "INSTANT: OFF"
    CatchBtn.BackgroundColor3 = catching and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(50, 50, 50)
    
    task.spawn(function()
        local RS = game:GetService("ReplicatedStorage")
        -- Remote hasil sadapan SimpleSpy kamu sebelumnya
        local castRemote = RS:FindFirstChild("ChargeFishingRod", true)
        local catchRemote = RS:FindFirstChild("CatchFishComplete", true)
        
        while catching do
            pcall(function()
                -- 1. Lempar Kail (Fast Bait)
                castRemote:InvokeServer(100)
                task.wait(0.1) -- Mengikuti Delay Bait Vora Hub
                
                -- 2. Tarik Ikan (Fast Reel)
                catchRemote:InvokeServer(true)
                task.wait(0.4) -- Mengikuti Delay Reel Vora Hub
            end)
        end
    end)
end)

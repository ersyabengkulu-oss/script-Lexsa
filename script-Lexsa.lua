-- LEXSA V7.7: SUCCESS MIRROR
local catching = false
CatchBtn.MouseButton1Click:Connect(function()
    catching = not catching
    CatchBtn.Text = catching and "MIRROR: ON" or "MIRROR: OFF"
    CatchBtn.BackgroundColor3 = catching and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(50, 50, 50)
    
    task.spawn(function()
        -- Jalur Rahasia yang kamu temukan lewat SimpleSpy
        local NetPath = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net
        local CatchRemote = NetPath["RF/CatchFishCompleted"]
        local CastRemote = NetPath["RF/ChargeFishingRod"]
        
        while catching do
            pcall(function()
                -- Step 1: Lempar (Power 100)
                CastRemote:InvokeServer(100)
                task.wait(0.1) -- Delay Bait sesuai Vora
                
                -- Step 2: Langsung Klaim (Tanpa Args sesuai hasil spy kamu)
                CatchRemote:InvokeServer()
                task.wait(0.4) -- Delay Reel sesuai Vora
            end)
        end
    end)
end)

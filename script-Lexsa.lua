-- LEXSA V8.9: THE FINAL INTERFACE [2026-02-06]
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 200, 0, 100)
MainFrame.Position = UDim2.new(0.5, -100, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local CatchBtn = Instance.new("TextButton", MainFrame)
CatchBtn.Size = UDim2.new(1, -20, 0, 50)
CatchBtn.Position = UDim2.new(0, 10, 0, 25)
CatchBtn.Text = "MULAI GACOR"
CatchBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)

local catching = false
CatchBtn.MouseButton1Click:Connect(function()
    catching = not catching
    CatchBtn.Text = catching and "STATUS: ON" or "STATUS: OFF"
    CatchBtn.BackgroundColor3 = catching and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    
    if catching then
        task.spawn(function()
            local Net = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net
            -- 1. Pegang Alat (Slot 1)
            Net["RE/EquipToolFromHotbar"]:FireServer(1)
            task.wait(0.5)
            
            while catching do
                pcall(function()
                    -- 2. Urutan Mancing & Klaim
                    Net["RF/ChargeFishingRod"]:InvokeServer(100)
                    task.wait(0.2)
                    Net["RF/CatchFishCompleted"]:InvokeServer("Fish")
                    Net["RE/ClaimNotification"]:FireServer("Fish")
                end)
                task.wait(0.5) -- Sesuai Delay Vora
            end
        end)
    end
end)

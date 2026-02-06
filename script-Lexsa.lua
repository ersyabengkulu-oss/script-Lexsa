-- LEXSA V9.4: THE PERFECT TIMING [2026-02-06]
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 200, 0, 100)
MainFrame.Position = UDim2.new(0.5, -100, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true
MainFrame.Draggable = true 

local CatchBtn = Instance.new("TextButton", MainFrame)
CatchBtn.Size = UDim2.new(1, -20, 0, 50)
CatchBtn.Position = UDim2.new(0, 10, 0, 25)
CatchBtn.Text = "KLIK UNTUK GACOR"
CatchBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CatchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

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
                    -- 1. PASTIKAN PEGANG ALAT
                    Net["RE/EquipToolFromHotbar"]:FireServer(1)
                    task.wait(0.2)
                    
                    -- 2. LEMPAR (NAROK UMPAN) - Harus yang pertama!
                    Net["RF/ChargeFishingRod"]:InvokeServer(100)
                    print("LEXSA: Umpan Terlempar")
                    task.wait(0.5) -- Beri waktu umpan sampai ke air
                    
                    -- 3. TARIK & KLAIM (FAST REEL)
                    Net["RF/CatchFishCompleted"]:InvokeServer("Fish")
                    task.wait(0.1)
                    Net["RE/ClaimNotification"]:FireServer("Fish")
                    print("LEXSA: Ikan Didapat!")
                end)
                task.wait(1.5) -- Delay total antar tarikan agar server tidak curiga
            end
        end)
    end
end)

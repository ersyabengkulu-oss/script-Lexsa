-- LEXSA V9.2: AUTO-CAST & FAST-REEL (FIXED)
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 200, 0, 100)
MainFrame.Position = UDim2.new(0.5, -100, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Active = true
MainFrame.Draggable = true -- Biar bisa digeser

local CatchBtn = Instance.new("TextButton", MainFrame)
CatchBtn.Size = UDim2.new(1, -20, 0, 50)
CatchBtn.Position = UDim2.new(0, 10, 0, 25)
CatchBtn.Text = "AUTO FISH: OFF"
CatchBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CatchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local catching = false
CatchBtn.MouseButton1Click:Connect(function()
    catching = not catching
    CatchBtn.Text = catching and "AUTO FISH: ON" or "AUTO FISH: OFF"
    CatchBtn.BackgroundColor3 = catching and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    
    if catching then
        task.spawn(function()
            -- Definisi Jalur Net
            local Net = game:GetService("ReplicatedStorage").Packages._Index["sleitnick_net@0.2.0"].net
            local Player = game.Players.LocalPlayer
            
            while catching do
                pcall(function()
                    -- 1. Pastikan Pegang Pancingan (Equip)
                    local Char = Player.Character
                    local Tool = Char:FindFirstChildOfClass("Tool")
                    
                    if not Tool then
                        Net["RE/EquipToolFromHotbar"]:FireServer(1)
                        task.wait(0.3)
                        Tool = Char:FindFirstChildOfClass("Tool")
                    end
                    
                    if Tool then
                        -- 2. NAROK UMPAN (Force Animation)
                        Tool:Activate() 
                        Net["RF/ChargeFishingRod"]:InvokeServer(100) 
                        task.wait(0.2) -- Jeda agar kail meluncur
                        
                        -- 3. NARIK IKAN (Fast Reel)
                        Net["RF/CatchFishCompleted"]:InvokeServer("Fish")
                        Net["RE/ClaimNotification"]:FireServer("Fish")
                        
                        print("LEXSA: Umpan Terpasang & Ikan Didapat!")
                    end
                end)
                task.wait(0.5) -- Delay antar tarikan
            end
        end)
    end
end)

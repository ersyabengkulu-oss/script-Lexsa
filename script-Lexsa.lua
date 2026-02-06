-- LEXSA V10.2: EMERGENCY REPAIR (FIX CASTING) [2026-02-06]
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 200, 0, 100)
MainFrame.Position = UDim2.new(0.5, -100, 0.4, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Active = true
MainFrame.Draggable = true 

local CatchBtn = Instance.new("TextButton", MainFrame)
CatchBtn.Size = UDim2.new(1, -20, 0, 60)
CatchBtn.Position = UDim2.new(0, 10, 0, 20)
CatchBtn.Text = "KLIK UNTUK GACOR"
CatchBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
CatchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local catching = false
CatchBtn.MouseButton1Click:Connect(function()
    catching = not catching
    CatchBtn.Text = catching and "GACOR: ON" or "GACOR: OFF"
    CatchBtn.BackgroundColor3 = catching and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(200, 0, 0)
    
    if catching then
        task.spawn(function()
            -- Mencari Net secara lebih aman agar tidak crash
            local Net = game:GetService("ReplicatedStorage").Packages._Index:FindFirstChild("sleitnick_net@0.2.0", true).net
            
            while catching do
                pcall(function()
                    local Char = game.Players.LocalPlayer.Character
                    
                    -- 1. CEK ALAT (Jika belum pegang, ambil otomatis)
                    local Tool = Char:FindFirstChildOfClass("Tool")
                    if not Tool then
                        Net["RE/EquipToolFromHotbar"]:FireServer(1)
                        task.wait(0.3)
                        Tool = Char:FindFirstChildOfClass("Tool")
                    end
                    
                    if Tool then
                        -- 2. TRIK MELEMPAR: Gunakan Activate + Remote sekaligus
                        Tool:Activate() 
                        Net["RF/ChargeFishingRod"]:InvokeServer(100) 
                        print("LEXSA: Mencoba Narok Umpan...")
                        
                        -- 3. JEDA AGAR UMMPAN NYEMPLUNG
                        task.wait(0.8) 
                        
                        -- 4. TARIK IKAN CEPAT
                        Net["RF/CatchFishCompleted"]:InvokeServer("Fish")
                        Net["RE/ClaimNotification"]:FireServer("Fish")
                        print("LEXSA: Ikan Didapat!")
                    end
                end)
                task.wait(0.5) -- Jeda antar lemparan
            end
        end)
    end
end)

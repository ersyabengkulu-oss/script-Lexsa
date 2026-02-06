-- LEXSA V11.0: FIX AUTO-CAST (NAROK UMPAN) [2026-02-06]
-- Salin semua kode di bawah ini ke Executor kamu

local Player = game.Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")
local ScreenGui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 180, 0, 80)
MainFrame.Position = UDim2.new(0.5, -90, 0.3, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Active = true
MainFrame.Draggable = true 

local CatchBtn = Instance.new("TextButton", MainFrame)
CatchBtn.Size = UDim2.new(1, -10, 1, -10)
CatchBtn.Position = UDim2.new(0, 5, 0, 5)
CatchBtn.Text = "KLIK AKTIF"
CatchBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
CatchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local catching = false
CatchBtn.MouseButton1Click:Connect(function()
    catching = not catching
    CatchBtn.Text = catching and "GACOR: ON" or "GACOR: OFF"
    CatchBtn.BackgroundColor3 = catching and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(150, 0, 0)
    
    if catching then
        task.spawn(function()
            -- Mencari jalur Net secara aman
            local NetPath = RS.Packages._Index:FindFirstChild("sleitnick_net@0.2.0", true)
            local Net = NetPath and NetPath:FindFirstChild("net")
            
            while catching do
                if Net then
                    pcall(function()
                        -- 1. PAKSA PEGANG PANCINGAN
                        Net["RE/EquipToolFromHotbar"]:FireServer(1)
                        task.wait(0.4)
                        
                        -- 2. NAROK UMPAN (Melempar): Pakai Power 100
                        Net["RF/ChargeFishingRod"]:InvokeServer(100)
                        print("LEXSA: Umpan Terlempar!")
                        
                        -- 3. JEDA KRUSIAL: Beri waktu 1.2 detik agar umpan nyemplung
                        task.wait(1.2) 
                        
                        -- 4. TARIK IKAN (Fast Reel)
                        Net["RF/CatchFishCompleted"]:InvokeServer("Fish")
                        task.wait(0.2)
                        
                        -- 5. KLAIM & JEDA SEBELUM LOOP LAGI
                        Net["RE/ClaimNotification"]:FireServer("Fish")
                        print("LEXSA: Ikan Didapat!")
                        task.wait(1) -- Jeda istirahat server
                    end)
                end
                task.wait(0.5)
            end
        end)
    end
end)

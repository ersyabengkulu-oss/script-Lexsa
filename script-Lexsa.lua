-- LEXSA V11.4: ANTI-CRASH & AUTO-CAST [2026-02-06]
local Player = game.Players.LocalPlayer
local RS = game:GetService("ReplicatedStorage")

-- 1. BUAT UI DULU (PASTI MUNCUL)
local ScreenGui = Instance.new("ScreenGui", Player:WaitForChild("PlayerGui"))
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 150, 0, 70)
MainFrame.Position = UDim2.new(0.5, -75, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.Draggable = true 

local CatchBtn = Instance.new("TextButton", MainFrame)
CatchBtn.Size = UDim2.new(1, -10, 1, -10)
CatchBtn.Position = UDim2.new(0, 5, 0, 5)
CatchBtn.Text = "START GACOR"
CatchBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
CatchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local catching = false
CatchBtn.MouseButton1Click:Connect(function()
    catching = not catching
    CatchBtn.Text = catching and "GACOR: ON" or "GACOR: OFF"
    CatchBtn.BackgroundColor3 = catching and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(180, 0, 0)
    
    if catching then
        task.spawn(function()
            -- Cari Net secara otomatis tanpa bikin crash
            local Net = RS:FindFirstChild("net", true) or RS.Packages._Index:FindFirstChild("sleitnick_net@0.2.0", true).net
            
            while catching do
                pcall(function()
                    -- A. PEGANG ROD
                    Net["RE/EquipToolFromHotbar"]:FireServer(1)
                    task.wait(0.5)
                    
                    -- B. NAROK UMPAN (MELEMPAR)
                    Net["RF/ChargeFishingRod"]:InvokeServer(100)
                    task.wait(0.2)
                    Player.Character:FindFirstChildOfClass("Tool"):Activate() -- Animasi fisik
                    
                    -- C. TUNGGU IKAN NYANGKUT (Jeda Biar Gak Macet)
                    task.wait(2.2) 
                    
                    -- D. TARIK & KLAIM
                    Net["RF/CatchFishCompleted"]:InvokeServer("Fish")
                    Net["RE/ClaimNotification"]:FireServer("Fish")
                end)
                task.wait(1.5) -- Jeda istirahat karakter
            end
        end)
    end
end)

-- LEXSA V9.3: SAFE-LOAD INTERFACE [2026-02-06]
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
CatchBtn.Text = "KLIK UNTUK AKTIF"
CatchBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CatchBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local catching = false
CatchBtn.MouseButton1Click:Connect(function()
    catching = not catching
    CatchBtn.Text = catching and "GACOR: ON" or "GACOR: OFF"
    CatchBtn.BackgroundColor3 = catching and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(200, 0, 0)
    
    if catching then
        task.spawn(function()
            -- Cara mencari folder secara dinamis agar tidak error
            local RS = game:GetService("ReplicatedStorage")
            local NetFolder = RS:WaitForChild("Packages"):WaitForChild("_Index"):FindFirstChild("sleitnick_net@0.2.0", true):WaitForChild("net")
            
            while catching do
                pcall(function()
                    -- Simulasi klik fisik agar umpan terlempar
                    local Tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
                    if Tool then
                        Tool:Activate() -- Pemicu animasi melempar
                    else
                        NetFolder["RE/EquipToolFromHotbar"]:FireServer(1) -- Paksa pegang
                    end
                    
                    task.wait(0.2)
                    NetFolder["RF/ChargeFishingRod"]:InvokeServer(100) -- Kirim power
                    task.wait(0.2)
                    NetFolder["RF/CatchFishCompleted"]:InvokeServer("Fish") -- Tarik ikan
                    NetFolder["RE/ClaimNotification"]:FireServer("Fish") -- Klaim hadiah
                end)
                task.wait(0.5) -- Jeda aman
            end
        end)
    end
end)

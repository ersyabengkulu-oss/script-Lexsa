-- LEXSA V11.5: ANTI-LELAH EDITION [2026-02-06]
local SGui = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)
local Btn = Instance.new("TextButton", SGui)
Btn.Size = UDim2.new(0, 150, 0, 50)
Btn.Position = UDim2.new(0.5, -75, 0.1, 0)
Btn.Text = "START GACOR"
Btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)

local aktif = false
Btn.MouseButton1Click:Connect(function()
    aktif = not aktif
    Btn.Text = aktif and "GACOR: ON" or "GACOR: OFF"
    Btn.BackgroundColor3 = aktif and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
    
    if aktif then
        task.spawn(function()
            -- Mencari remote pancing secara otomatis sesuai log SimpleSpy kamu
            local Net = game:GetService("ReplicatedStorage"):FindFirstChild("net", true)
            
            while aktif do
                pcall(function()
                    -- 1. Pegang Alat
                    Net["RE/EquipToolFromHotbar"]:FireServer(1)
                    task.wait(0.5)
                    
                    -- 2. Narok Umpan (Melempar)
                    Net["RF/ChargeFishingRod"]:InvokeServer(100)
                    task.wait(1.5) -- Jeda biar umpan sampai ke air
                    
                    -- 3. Tarik Ikan
                    Net["RF/CatchFishCompleted"]:InvokeServer("Fish")
                    Net["RE/ClaimNotification"]:FireServer("Fish")
                end)
                task.wait(1.5) -- Jeda antar lemparan
            end
        end)
    end
end)

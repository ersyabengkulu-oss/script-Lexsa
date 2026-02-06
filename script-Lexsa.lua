-- COPY SEMUA TEKS DI BAWAH INI --
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
            local NetPath = RS.Packages._Index:FindFirstChild("sleitnick_net@0.2.0", true)
            local Net = NetPath and NetPath:FindFirstChild("net")
            while catching do
                if Net then
                    pcall(function()
                        Net["RE/EquipToolFromHotbar"]:FireServer(1)
                        task.wait(0.3)
                        Net["RF/ChargeFishingRod"]:InvokeServer(100)
                        task.wait(1.2)
                        Net["RF/CatchFishCompleted"]:InvokeServer("Fish")
                        Net["RE/ClaimNotification"]:FireServer("Fish")
                    end)
                end
                task.wait(0.5)
            end
        end)
    end
end)

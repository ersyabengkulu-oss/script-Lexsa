-- Script Rainbow Savior V11 with GUI for Lexsa
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ToggleBtn = Instance.new("TextButton")
local StatusLabel = Instance.new("TextLabel")

-- Setup GUI
ScreenGui.Parent = game.CoreGui
MainFrame.Name = "LexsaPanel"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.Position = UDim2.new(0.1, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 150, 0, 80)
MainFrame.Active = true
MainFrame.Draggable = true -- Bisa digeser-geser di layar HP

ToggleBtn.Parent = MainFrame
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ToggleBtn.Position = UDim2.new(0, 10, 0, 35)
ToggleBtn.Size = UDim2.new(0, 130, 0, 35)
ToggleBtn.Text = "OFF"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 20

StatusLabel.Parent = MainFrame
StatusLabel.Size = UDim2.new(0, 150, 0, 30)
StatusLabel.Text = "Dragon Collector"
StatusLabel.TextColor3 = Color3.new(1, 1, 1)
StatusLabel.BackgroundTransparency = 1

-- Logika Script
_G.RainbowSavior = false
local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent

ToggleBtn.MouseButton1Click:Connect(function()
    _G.RainbowSavior = not _G.RainbowSavior
    if _G.RainbowSavior then
        ToggleBtn.Text = "ON"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
    else
        ToggleBtn.Text = "OFF"
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    end
end)

spawn(function()
    while true do
        if _G.RainbowSavior then
            local lp = game.Players.LocalPlayer
            local char = lp.Character
            local myRoot = char and char:FindFirstChild("HumanoidRootPart")
            
            if myRoot then
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    if not _G.RainbowSavior then break end
                    
                    -- Mencari model Dragon sesuai struktur Dex kamu
                    if v:IsA("Model") and (v.Name == "DragonCannelloni" or v:FindFirstChild("HumanoidRootPart")) then
                        local target = v:FindFirstChild("HumanoidRootPart")
                        if target then
                            myRoot.CFrame = target.CFrame
                            Remote:FireServer({[1] = {[1] = v.Name}}) -- Format log terbaru
                            
                            for i = 1, 3 do
                                for _, p in pairs(v:GetDescendants()) do
                                    if p:IsA("ProximityPrompt") then fireproximityprompt(p) end
                                end
                            end
                            task.wait(0.1)
                        end
                    end
                end
            end
        end
        task.wait(0.5)
    end
end)

-- Script V14 Anti-Nyasar by Gemini for Lexsa
local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local ToggleBtn = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.1, 0, 0.4, 0)
MainFrame.Size = UDim2.new(0, 150, 0, 60)
MainFrame.Active = true
MainFrame.Draggable = true

ToggleBtn.Parent = MainFrame
ToggleBtn.Size = UDim2.new(1, -20, 1, -20)
ToggleBtn.Position = UDim2.new(0, 10, 0, 10)
ToggleBtn.Text = "ON"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)

_G.RainbowSavior = true
local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent

ToggleBtn.MouseButton1Click:Connect(function()
    _G.RainbowSavior = not _G.RainbowSavior
    ToggleBtn.Text = _G.RainbowSavior and "ON" or "OFF"
    ToggleBtn.BackgroundColor3 = _G.RainbowSavior and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(200, 0, 0)
end)

spawn(function()
    while true do
        if _G.RainbowSavior then
            local lp = game.Players.LocalPlayer
            local myRoot = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
            
            if myRoot then
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    if not _G.RainbowSavior then break end
                    
                    -- FILTER LEBIH SADIS: Cek Nama + ParticleEmitter
                    if v.Name == "DragonCannelloni" and v:IsA("Model") then
                        local hrp = v:FindFirstChild("HumanoidRootPart")
                        -- Papan update/Pepe biasanya nggak punya ParticleEmitter di HRP-nya
                        if hrp and hrp:FindFirstChildWhichIsA("ParticleEmitter", true) then
                            local prompt = v:FindFirstChildWhichIsA("ProximityPrompt", true)
                            
                            if prompt and prompt.ActionText == "Pick up" then
                                myRoot.CFrame = hrp.CFrame
                                Remote:FireServer({[1] = {[1] = "DragonCannelloni"}})
                                fireproximityprompt(prompt)
                                task.wait(0.2)
                            end
                        end
                    end
                end
            end
        end
        task.wait(0.7)
    end
end)

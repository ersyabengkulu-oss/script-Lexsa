-- LEXSA V7.1: LAVA WALKING & RADAR MANTAU
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LexsaV71"
ScreenGui.Parent = game:GetService("CoreGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 150)
Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "LEXSA V7.1"
Title.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Parent = Frame

-- FUNGSI LAVA WALKING
local LavaBtn = Instance.new("TextButton")
LavaBtn.Size = UDim2.new(0.9, 0, 0, 40)
LavaBtn.Position = UDim2.new(0.05, 0, 0.25, 0)
LavaBtn.Text = "LAVA WALKING: OFF"
LavaBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
LavaBtn.Parent = Frame

local lavaActive = false
LavaBtn.MouseButton1Click:Connect(function()
    lavaActive = not lavaActive
    LavaBtn.Text = lavaActive and "LAVA WALKING: ON" or "LAVA WALKING: OFF"
    LavaBtn.BackgroundColor3 = lavaActive and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(50, 50, 50)
    task.spawn(function()
        while lavaActive do
            pcall(function()
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    if v.Name:lower():find("lava") and v:IsA("BasePart") then
                        v.CanCollide = true
                        if v:FindFirstChild("TouchInterest") then v.TouchInterest:Destroy() end
                    end
                end
            end)
            task.wait(1)
        end
    end)
end)

-- FUNGSI RADAR MANTAU (ESP)
local EspBtn = Instance.new("TextButton")
EspBtn.Size = UDim2.new(0.9, 0, 0, 40)
EspBtn.Position = UDim2.new(0.05, 0, 0.6, 0)
EspBtn.Text = "RADAR MANTAU: OFF"
EspBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
EspBtn.Parent = Frame

local espActive = false
EspBtn.MouseButton1Click:Connect(function()
    espActive = not espActive
    EspBtn.Text = espActive and "RADAR MANTAU: ON" or "RADAR MANTAU: OFF"
    EspBtn.BackgroundColor3 = espActive and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(50, 50, 50)
    
    while espActive do
        for _, plr in pairs(game.Players:GetPlayers()) do
            if plr ~= game.Players.LocalPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                if not plr.Character.HumanoidRootPart:FindFirstChild("LexsaRadar") then
                    local box = Instance.new("BoxHandleAdornment")
                    box.Name = "LexsaRadar"
                    box.Size = plr.Character.HumanoidRootPart.Size + Vector3.new(0.5, 1, 0.5)
                    box.AlwaysOnTop = true
                    box.ZIndex = 5
                    box.Transparency = 0.5
                    box.Color3 = Color3.fromRGB(255, 0, 0)
                    box.Adornee = plr.Character.HumanoidRootPart
                    box.Parent = plr.Character.HumanoidRootPart
                end
            end
        end
        task.wait(1)
        if not espActive then
            for _, plr in pairs(game.Players:GetPlayers()) do
                if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character.HumanoidRootPart:FindFirstChild("LexsaRadar") then
                    plr.Character.HumanoidRootPart.LexsaRadar:Destroy()
                end
            end
        end
    end
end)

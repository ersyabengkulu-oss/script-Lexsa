-- LEXSA V7.2: LAVA WALKING + HIDE FEATURE
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LexsaCompact"
ScreenGui.Parent = game:GetService("CoreGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 180, 0, 100)
Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.8, 0, 0, 30)
Title.Text = "LEXSA LAVA CORE"
Title.BackgroundColor3 = Color3.fromRGB(200, 50, 0)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Parent = Frame

-- TOMBOL SEMBUNYIKAN (HIDE)
local HideBtn = Instance.new("TextButton")
HideBtn.Size = UDim2.new(0.2, 0, 0, 30)
HideBtn.Position = UDim2.new(0.8, 0, 0, 0)
HideBtn.Text = "_"
HideBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
HideBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
HideBtn.Parent = Frame

-- TOMBOL BUKA KEMBALI (OPEN)
local OpenBtn = Instance.new("TextButton")
OpenBtn.Size = UDim2.new(0, 50, 0, 25)
OpenBtn.Position = UDim2.new(0, 10, 0, 10)
OpenBtn.Text = "LEXSA"
OpenBtn.Visible = false
OpenBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 0)
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.Parent = ScreenGui

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0.9, 0, 0, 45)
ToggleBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
ToggleBtn.Text = "LAVA WALKING: OFF"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Parent = Frame

-- LOGIKA HIDE/SHOW
HideBtn.MouseButton1Click:Connect(function()
    Frame.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    Frame.Visible = true
    OpenBtn.Visible = false
end)

local active = false
ToggleBtn.MouseButton1Click:Connect(function()
    active = not active
    ToggleBtn.Text = active and "LAVA WALKING: ON" or "LAVA WALKING: OFF"
    ToggleBtn.BackgroundColor3 = active and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(40, 40, 40)
    
    task.spawn(function()
        while active do
            pcall(function()
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    if v.Name:lower():find("lava") and v:IsA("BasePart") then
                        v.CanCollide = true
                        if v:FindFirstChild("TouchInterest") then v.TouchInterest:Destroy() end
                    end
                end
            end)
            task.wait(1.5)
        end
    end)
end)

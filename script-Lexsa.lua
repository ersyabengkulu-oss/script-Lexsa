-- LEXSA V1: LAVA SURVIVAL (BRAINROT EDITION)
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")

ScreenGui.Name = "LexsaLavaV1"
ScreenGui.Parent = game:GetService("CoreGui")

OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 60, 0, 60)
OpenBtn.Position = UDim2.new(0, 10, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
OpenBtn.Text = "LAVA"
OpenBtn.Visible = false
OpenBtn.Draggable = true

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 220, 0, 300)
Frame.Active = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(1, 0, 0, 40)
TextLabel.Text = "LEXSA V1: LAVA"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(200, 0, 0)

ScrollFrame.Parent = Frame
ScrollFrame.Size = UDim2.new(1, -10, 1, -90)
ScrollFrame.Position = UDim2.new(0, 5, 0, 45)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

UIListLayout.Parent = ScrollFrame
UIListLayout.Padding = UDim.new(0, 5)

local function addToggle(name, color, func)
    local active = false
    local btn = Instance.new("TextButton")
    btn.Parent = ScrollFrame
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Text = name .. ": OFF"
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = active and name .. ": ON" or name .. ": OFF"
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 200, 0) or color
        func(active)
    end)
end

-- 1. FLY / FLOAT (Agar tidak kena Lava)
addToggle("ANTI LAVA (FLOAT)", Color3.fromRGB(255, 100, 0), function(state)
    _G.Float = state
    local hrp = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    if state then
        local bV = Instance.new("BodyVelocity", hrp)
        bV.Name = "LavaFloat"
        bV.Velocity = Vector3.new(0, 0, 0)
        bV.MaxForce = Vector3.new(0, 5000, 0) -- Menahan gravitasi
    else
        if hrp:FindFirstChild("LavaFloat") then hrp.LavaFloat:Destroy() end
    end
end)

-- 2. SPEED BOOST (Buat lari ke tempat tinggi)
addToggle("SPEED BOOST", Color3.fromRGB(50, 50, 50), function(state)
    _G.Spd = state
    task.spawn(function()
        while _G.Spd do
            pcall(function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 60 end)
            task.wait(0.5)
        end
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
    end)
end)

-- 3. JUMP POWER (Lompat ke puncak gedung)
addToggle("HIGH JUMP", Color3.fromRGB(0, 150, 255), function(state)
    if state then
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 150
    else
        game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    end
end)

MinimizeBtn.Parent = Frame
MinimizeBtn.Size = UDim2.new(1, -20, 0, 35)
MinimizeBtn.Position = UDim2.new(0, 10, 1, -40)
MinimizeBtn.Text = "Hide Menu"
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinimizeBtn.MouseButton1Click:Connect(function() Frame.Visible = false OpenBtn.Visible = true end)
OpenBtn.MouseButton1Click:Connect(function() Frame.Visible = true OpenBtn.Visible = false end)

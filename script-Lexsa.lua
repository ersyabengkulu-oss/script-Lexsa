-- LEXSA V4.2: BRAINROT SPAMMER (LAVA SURVIVAL)
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")

ScreenGui.Name = "LexsaV42"
ScreenGui.Parent = game:GetService("CoreGui")

OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 60, 0, 60)
OpenBtn.Position = UDim2.new(0, 10, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
OpenBtn.Text = "ROT"
OpenBtn.Visible = false
OpenBtn.Draggable = true

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 220, 0, 350)
Frame.Active = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(1, 0, 0, 40)
TextLabel.Text = "LEXSA V4.2: BRAINROT"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(120, 0, 200)

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

-- ==========================================
-- BRAINROT CHAT SPAMMER
-- ==========================================
local messages = {
    "SKIBIDI TOILET RIZZ!",
    "LEVEL 10 GYATT DETECTED!",
    "FANUM TAX ON THE LAVA!",
    "MOGGING THE DEVELOPER 💀",
    "SIGMA GRINDSET IN THE SKY!",
    "NO CAP JUST BRAINROT FR FR"
}

addToggle("CHAT SPAMMER", Color3.fromRGB(200, 0, 100), function(state)
    _G.Spam = state
    task.spawn(function()
        while _G.Spam do
            local msg = messages[math.random(1, #messages)]
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
            task.wait(3) -- Jeda 3 detik biar gak kena mute sistem
        end
    end)
end)

-- FITUR LAMA YANG SUDAH JALAN
local platform = nil
addToggle("SKY BASE", Color3.fromRGB(255, 100, 0), function(state)
    if state then
        platform = Instance.new("Part", workspace)
        platform.Size = Vector3.new(60, 1, 60)
        platform.Position = Vector3.new(game.Players.LocalPlayer.Character.HumanoidRootPart.Position.X, 180, game.Players.LocalPlayer.Character.HumanoidRootPart.Position.Z)
        platform.Anchored = true
        platform.Transparency = 0.5
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(platform.Position.X, 185, platform.Position.Z)
    else
        if platform then platform:Destroy() end
    end
end)

addToggle("AUTO FARM", Color3.fromRGB(0, 150, 255), function(state)
    _G.Farm = state
    while _G.Farm do
        pcall(function()
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v:IsA("TouchTransmitter") and v.Parent.Name ~= "Lava" then
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1)
                end
            end
        end)
        task.wait(1)
    end
end)

MinimizeBtn.Parent = Frame
MinimizeBtn.Size = UDim2.new(1, -20, 0, 35)
MinimizeBtn.Position = UDim2.new(0, 10, 1, -40)
MinimizeBtn.Text = "Sembunyikan Menu"
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinimizeBtn.MouseButton1Click:Connect(function() Frame.Visible = false OpenBtn.Visible = true end)
OpenBtn.MouseButton1Click:Connect(function() Frame.Visible = true OpenBtn.Visible = false end)

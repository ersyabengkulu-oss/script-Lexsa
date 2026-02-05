-- LEXSA V4.1: STEALTH & PROTECTION (LAVA SURVIVAL)
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")

ScreenGui.Name = "LexsaV41"
ScreenGui.Parent = game:GetService("CoreGui")

OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 60, 0, 60)
OpenBtn.Position = UDim2.new(0, 10, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(50, 255, 50)
OpenBtn.Text = "SAFE"
OpenBtn.Visible = false
OpenBtn.Draggable = true

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 220, 0, 320)
Frame.Active = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(1, 0, 0, 40)
TextLabel.Text = "LEXSA V4.1: STEALTH"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(0, 180, 0)

ScrollFrame.Parent = Frame
ScrollFrame.Size = UDim2.new(1, -10, 1, -90)
ScrollFrame.Position = UDim2.new(0, 5, 0, 45)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

UIListLayout.Parent = ScrollFrame
UIListLayout.Padding = UDim.new(0, 5)

-- ==========================================
-- ADMIN DETECTOR (AUTO EXIT)
-- ==========================================
task.spawn(function()
    game.Players.PlayerAdded:Connect(function(player)
        -- Jika pemain yang masuk punya badge Admin atau grup owner
        if player:GetRankInGroup(0) > 100 or player.Name == "DeveloperName" then 
            print("ADMIN DETECTED! CLOSING SCRIPT...")
            if platform then platform:Destroy() end
            ScreenGui:Destroy()
            game.Players.LocalPlayer:Kick("Admin masuk, kamu aman!")
        end
    end)
end)

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
-- FITUR UTAMA
-- ==========================================
local platform = nil
addToggle("SKY BASE", Color3.fromRGB(255, 100, 0), function(state)
    if state then
        platform = Instance.new("Part")
        platform.Size = Vector3.new(50, 1, 50)
        platform.Position = Vector3.new(0, 180, 0)
        platform.Anchored = true
        platform.Transparency = 0.5
        platform.Parent = workspace
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 185, 0)
    else
        if platform then platform:Destroy() end
    end
end)

addToggle("AUTO FARM ITEM", Color3.fromRGB(0, 150, 255), function(state)
    _G.Farm = state
    while _G.Farm do
        pcall(function()
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "Brainrot" or v:IsA("TouchTransmitter") then
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)
                    firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 1)
                end
            end
        end)
        task.wait(1)
    end
end)

addToggle("ANTI AFK", Color3.fromRGB(100, 100, 100), function(state)
    local VirtualUser = game:service'VirtualUser'
    game:service'Players'.LocalPlayer.Idled:connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end)

MinimizeBtn.Parent = Frame
MinimizeBtn.Size = UDim2.new(1, -20, 0, 35)
MinimizeBtn.Position = UDim2.new(0, 10, 1, -40)
MinimizeBtn.Text = "Sembunyikan Menu"
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinimizeBtn.MouseButton1Click:Connect(function() Frame.Visible = false OpenBtn.Visible = true end)
OpenBtn.MouseButton1Click:Connect(function() Frame.Visible = true OpenBtn.Visible = false end)

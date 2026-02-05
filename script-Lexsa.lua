-- LEXSA V4.3: ULTIMATE BRAINROT (LAVA SURVIVAL)
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")

ScreenGui.Name = "LexsaV43"
ScreenGui.Parent = game:GetService("CoreGui")

OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 60, 0, 60)
OpenBtn.Position = UDim2.new(0, 10, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
OpenBtn.Text = "LEXSA"
OpenBtn.Visible = false
OpenBtn.Draggable = true

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 230, 0, 380)
Frame.Active = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(1, 0, 0, 45)
TextLabel.Text = "LEXSA V4.3: BYPASS"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(100, 0, 255)

ScrollFrame.Parent = Frame
ScrollFrame.Size = UDim2.new(1, -10, 1, -100)
ScrollFrame.Position = UDim2.new(0, 5, 0, 50)
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

-- 1. SMART SKYWALK (Ikuti kaki, anti ujung map)
addToggle("SMART SKYWALK", Color3.fromRGB(0, 200, 150), function(state)
    _G.SkyWalk = state
    task.spawn(function()
        while _G.SkyWalk do
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                local hrp = char:WaitForChild("HumanoidRootPart")
                local p = Instance.new("Part")
                p.Size = Vector3.new(8, 1, 8)
                p.CFrame = hrp.CFrame * CFrame.new(0, -3.5, 0)
                p.Anchored = true
                p.Transparency = 0.5
                p.Color = Color3.fromRGB(255, 255, 255)
                p.Parent = workspace
                task.wait(0.05)
                p:Destroy()
            end)
            task.wait()
        end
    end)
end)

-- 2. AUTO FARM BRAINROT
addToggle("AUTO FARM ITEM", Color3.fromRGB(0, 150, 255), function(state)
    _G.AutoFarm = state
    task.spawn(function()
        while _G.AutoFarm do
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
end)

-- 3. CHAT SPAMMER BRAINROT
local msgs = {"SKIBIDI RIZZ!", "FANUM TAX!", "SIGMA MOGGING!", "GYATT DETECTED!", "LAVA IS LAME!"}
addToggle("BRAINROT CHAT", Color3.fromRGB(255, 0, 150), function(state)
    _G.ChatSpam = state
    task.spawn(function()
        while _G.ChatSpam do
            local msg = msgs[math.random(1, #msgs)]
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
            task.wait(4)
        end
    end)
end)

-- 4. SPEED BOOST
addToggle("SPEED BOOST", Color3.fromRGB(50, 50, 50), function(state)
    _G.Speed = state
    while _G.Speed do
        pcall(function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50 end)
        task.wait(0.5)
    end
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
end)

MinimizeBtn.Parent = Frame
MinimizeBtn.Size = UDim2.new(1, -20, 0, 35)
MinimizeBtn.Position = UDim2.new(0, 10, 1, -45)
MinimizeBtn.Text = "Sembunyikan"
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinimizeBtn.MouseButton1Click:Connect(function() Frame.Visible = false OpenBtn.Visible = true end)
OpenBtn.MouseButton1Click:Connect(function() Frame.Visible = true OpenBtn.Visible = false end)

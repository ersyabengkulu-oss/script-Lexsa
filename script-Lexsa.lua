-- LEXSA V6.0: ULTIMATE SURVIVOR (LAVA + WALL + SILENT KICK)
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local OpenBtn = Instance.new("TextButton")

ScreenGui.Name = "LexsaV6"
ScreenGui.Parent = game:GetService("CoreGui")

OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 50, 0, 50)
OpenBtn.Position = UDim2.new(0, 10, 0.4, 0)
OpenBtn.Text = "LEXSA"
OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 150)
OpenBtn.Draggable = true

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 220, 0, 350)
Frame.Active = true
Frame.Draggable = true
Frame.Visible = true

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(1, 0, 0, 40)
TextLabel.Text = "LEXSA V6: ULTIMATE"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

ScrollFrame.Parent = Frame
ScrollFrame.Size = UDim2.new(1, -10, 1, -60)
ScrollFrame.Position = UDim2.new(0, 5, 0, 45)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y

UIListLayout.Parent = ScrollFrame
UIListLayout.Padding = UDim.new(0, 5)

local function addToggle(name, color, func)
    local active = false
    local btn = Instance.new("TextButton")
    btn.Parent = ScrollFrame
    btn.Size = UDim2.new(1, -10, 0, 35)
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

-- 1. LAVA WALKING (FITUR ANDALAN)
addToggle("LAVA WALKING", Color3.fromRGB(255, 100, 0), function(state)
    _G.LavaWalk = state
    task.spawn(function()
        while _G.LavaWalk do
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

-- 2. WALL ESCAPE (CELAH DINDING KAMU)
addToggle("WALL ESCAPE", Color3.fromRGB(100, 0, 255), function(state)
    if state then
        -- Teleport langsung ke area hijau rahasia yang kamu temukan
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-45, 10, 50)
    end
end)

-- 3. NOCLIP (UNTUK TEMBUS DINDING)
addToggle("NOCLIP MODE", Color3.fromRGB(50, 50, 50), function(state)
    _G.Noclip = state
    game:GetService("RunService").Stepped:Connect(function()
        if _G.Noclip then
            pcall(function()
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
            end)
        end
    end)
end)

-- 4. SILENT FLING (TENDANG DIAM-DIAM)
addToggle("SILENT KICK", Color3.fromRGB(200, 0, 50), function(state)
    _G.SilentFling = state
    task.spawn(function()
        while _G.SilentFling do
            pcall(function()
                local player = game.Players.LocalPlayer
                local hrp = player.Character.HumanoidRootPart
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= player and v.Character and v.Character:FindFirstChild("HumanoidRootPart") then
                        local targetHRP = v.Character.HumanoidRootPart
                        if (hrp.Position - targetHRP.Position).Magnitude < 6 then
                            -- Berikan dorongan fisik instan
                            targetHRP.Velocity = (targetHRP.Position - hrp.Position).Unit * 150 + Vector3.new(0, 50, 0)
                        end
                    end
                end
            end)
            task.wait(0.1)
        end
    end)
end)

OpenBtn.MouseButton1Click:Connect(function() Frame.Visible = not Frame.Visible end)

-- LEXSA MENU V22: VIOLENCE DISTRICT EXCLUSIVE
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")

-- Setup UI
ScreenGui.Name = "LexsaV22"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 60, 0, 60)
OpenBtn.Position = UDim2.new(0, 10, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
OpenBtn.Text = "LEX"
OpenBtn.Visible = false
OpenBtn.Draggable = true

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 220, 0, 320)
Frame.Active = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(1, 0, 0, 40)
TextLabel.Text = "LEXSA: VIOLENCE DIST"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

ScrollFrame.Parent = Frame
ScrollFrame.Size = UDim2.new(1, -10, 1, -90)
ScrollFrame.Position = UDim2.new(0, 5, 0, 45)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.ScrollBarThickness = 5

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
    btn.Font = Enum.Font.SourceSansBold
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = active and name .. ": ON" or name .. ": OFF"
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 180, 0) or color
        func(active)
    end)
end

-- ==========================================
-- 1. GOD MODE (STABLE)
-- ==========================================
addToggle("GOD MODE", Color3.fromRGB(60, 60, 60), function(state)
    _G.God = state
    task.spawn(function()
        while _G.God do
            pcall(function()
                game.Players.LocalPlayer.Character.Humanoid.Health = 100
                if game.Players.LocalPlayer.Character.Humanoid.Health < 100 then
                    game.Players.LocalPlayer.Character.Humanoid.Health = 100
                end
            end)
            task.wait(0.1)
        end
    end)
end)

-- ==========================================
-- 2. AUTO GENERATOR (FIXED)
-- ==========================================
addToggle("AUTO GEN", Color3.fromRGB(0, 100, 200), function(state)
    _G.Gen = state
    task.spawn(function()
        while _G.Gen do
            pcall(function()
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    -- Mencari objek dengan nama Generator atau Gen
                    if (v.Name:find("Generator") or v.Name:find("Gen")) and v:IsA("BasePart") then
                        -- ESP Hijau
                        if not v:FindFirstChild("Highlight") then
                            local h = Instance.new("Highlight", v)
                            h.FillColor = Color3.fromRGB(0, 255, 0)
                        end
                        -- Auto Repair jika dekat
                        local prompt = v:FindFirstChildOfClass("ProximityPrompt") or v:FindFirstChild("Prompt", true)
                        if prompt and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude < 12 then
                            fireproximityprompt(prompt)
                        end
                    end
                end
            end)
            task.wait(0.5)
        end
    end)
end)

-- ==========================================
-- 3. AUTO PARRY (VIRTUAL F - NO EMOTE)
-- ==========================================
addToggle("AUTO PARRY", Color3.fromRGB(255, 100, 0), function(state)
    _G.Parry = state
    task.spawn(function()
        while _G.Parry do
            pcall(function()
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                        if dist < 10 then
                            -- Hanya menekan F sebentar agar tidak memicu menu emot
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, "F", false, game)
                            task.wait(0.02)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, "F", false, game)
                        end
                    end
                end
            end)
            task.wait(0.1)
        end
    end)
end)

-- ==========================================
-- 4. SPEED & AUTO CLICK
-- ==========================================
addToggle("SPEED BOOST", Color3.fromRGB(40, 40, 40), function(state)
    _G.Spd = state
    while _G.Spd do
        pcall(function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 55 end)
        task.wait(0.5)
    end
end)

addToggle("AUTO CLICK", Color3.fromRGB(0, 150, 255), function(state)
    _G.AC = state
    while _G.AC do
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 0)
        task.wait(0.1)
    end
end)

-- Minimize System
MinimizeBtn.Parent = Frame
MinimizeBtn.Size = UDim2.new(1, -20, 0, 35)
MinimizeBtn.Position = UDim2.new(0, 10, 1, -40)
MinimizeBtn.Text = "Sembunyikan Menu"
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinimizeBtn.MouseButton1Click:Connect(function() Frame.Visible = false OpenBtn.Visible = true end)
OpenBtn.MouseButton1Click:Connect(function() Frame.Visible = true OpenBtn.Visible = false end)

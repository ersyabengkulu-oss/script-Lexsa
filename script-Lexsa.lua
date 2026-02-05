-- LEXSA MENU V26: CATCH & TAME SPECIAL
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")

-- Setup UI
ScreenGui.Name = "LexsaV26"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 60, 0, 60)
OpenBtn.Position = UDim2.new(0, 10, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
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
TextLabel.Text = "LEXSA: CATCH & TAME"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(0, 120, 180)

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
-- 1. MONSTER ESP (MELIHAT MONSTER DARI JAUH)
-- ==========================================
addToggle("MONSTER ESP", Color3.fromRGB(150, 0, 200), function(state)
    _G.MonsterEsp = state
    task.spawn(function()
        while _G.MonsterEsp do
            pcall(function()
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    -- Mencari objek yang biasanya menjadi monster di game ini
                    if v:IsA("Model") and v:FindFirstChild("Humanoid") and not game.Players:GetPlayerFromCharacter(v) then
                        if not v:FindFirstChild("Highlight") then
                            local h = Instance.new("Highlight", v)
                            h.FillColor = Color3.fromRGB(255, 255, 0) -- Kuning untuk monster
                        end
                    end
                end
            end)
            task.wait(1)
        end
    end)
end)

-- ==========================================
-- 2. AUTO ATTACK / CLICK
-- ==========================================
addToggle("AUTO ATTACK", Color3.fromRGB(200, 0, 0), function(state)
    _G.AutoAtk = state
    while _G.AutoAtk do
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 0)
        task.wait(0.1)
    end
end)

-- ==========================================
-- 3. SPEED BOOST (STABIL)
-- ==========================================
addToggle("SPEED BOOST", Color3.fromRGB(40, 40, 40), function(state)
    _G.Spd = state
    while _G.Spd do
        pcall(function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50 end)
        task.wait(0.2)
    end
    pcall(function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16 end)
end)

-- ==========================================
-- 4. INF STAMINA / JUMP
-- ==========================================
addToggle("HIGH JUMP", Color3.fromRGB(0, 150, 0), function(state)
    _G.Jump = state
    while _G.Jump do
        pcall(function() game.Players.LocalPlayer.Character.Humanoid.JumpPower = 80 end)
        task.wait(0.2)
    end
    pcall(function() game.Players.LocalPlayer.Character.Humanoid.JumpPower = 50 end)
end)

-- Minimize System
MinimizeBtn.Parent = Frame
MinimizeBtn.Size = UDim2.new(1, -20, 0, 35)
MinimizeBtn.Position = UDim2.new(0, 10, 1, -40)
MinimizeBtn.Text = "Sembunyikan Menu"
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinimizeBtn.MouseButton1Click:Connect(function() Frame.Visible = false OpenBtn.Visible = true end)
OpenBtn.MouseButton1Click:Connect(function() Frame.Visible = true OpenBtn.Visible = false end)

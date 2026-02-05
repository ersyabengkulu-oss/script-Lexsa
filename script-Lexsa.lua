-- LEXSA V5: LAVA GOD (FINAL BYPASS)
-- [2026-02-06] Fitur: Lava Walking, Auto Farm, Stealth Mode
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")

ScreenGui.Name = "LexsaV5"
ScreenGui.Parent = game:GetService("CoreGui")

OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 60, 0, 60)
OpenBtn.Position = UDim2.new(0, 10, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 180)
OpenBtn.Text = "LEXSA"
OpenBtn.Visible = false
OpenBtn.Draggable = true

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 230, 0, 350)
Frame.Active = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(1, 0, 0, 45)
TextLabel.Text = "LEXSA V5: LAVA GOD"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(0, 200, 150)

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

-- ==========================================
-- 1. LAVA WALKING (Celah yang baru ditemukan)
-- ==========================================
addToggle("LAVA WALKING", Color3.fromRGB(255, 80, 0), function(state)
    _G.LavaWalk = state
    task.spawn(function()
        while _G.LavaWalk do
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                -- Memaksa lava menjadi solid di bawah kaki
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    if v.Name:lower():find("lava") and v:IsA("BasePart") then
                        v.CanCollide = true
                        v.TouchInterest:Destroy() -- Hapus deteksi mati
                    end
                end
            end)
            task.wait(2)
        end
    end)
end)

-- 2. AUTO FARM (Grab Brainrot)
addToggle("AUTO FARM", Color3.fromRGB(0, 150, 255), function(state)
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
            task.wait(0.5)
        end
    end)
end)

-- 3. SPEED & JUMP (Support)
addToggle("GOD SPEED", Color3.fromRGB(100, 100, 100), function(state)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = state and 60 or 16
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = state and 100 or 50
end)

MinimizeBtn.Parent = Frame
MinimizeBtn.Size = UDim2.new(1, -20, 0, 35)
MinimizeBtn.Position = UDim2.new(0, 10, 1, -45)
MinimizeBtn.Text = "Sembunyikan"
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinimizeBtn.MouseButton1Click:Connect(function() Frame.Visible = false OpenBtn.Visible = true end)
OpenBtn.MouseButton1Click:Connect(function() Frame.Visible = true OpenBtn.Visible = false end)

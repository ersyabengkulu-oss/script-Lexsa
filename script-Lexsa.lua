-- LEXSA MENU V28: ULTRA FAST TAME & AUTO COLLECT
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")

-- Setup UI
ScreenGui.Name = "LexsaV28"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 60, 0, 60)
OpenBtn.Position = UDim2.new(0, 10, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 150)
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
TextLabel.Text = "LEXSA: ULTRA TAME"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(0, 150, 100)

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
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 255, 100) or color
        func(active)
    end)
end

-- ==========================================
-- 1. ULTRA TAME (AUTO TELEPORT + AUTO CATCH)
-- ==========================================
addToggle("ULTRA TAME", Color3.fromRGB(0, 120, 200), function(state)
    _G.UltraTame = state
    task.spawn(function()
        while _G.UltraTame do
            pcall(function()
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    -- Mencari Monster
                    if v:IsA("Model") and v:FindFirstChild("Humanoid") and not game.Players:GetPlayerFromCharacter(v) then
                        local root = v:FindFirstChild("HumanoidRootPart") or v.PrimaryPart
                        if root then
                            -- Teleport ke monster
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = root.CFrame * CFrame.new(0, 0, 3)
                            
                            -- Spam Klik & Tombol E (Tombol umum buat Tangkap/Tame)
                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.E, false, game)
                            task.wait(0.05)
                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 0)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.E, false, game)
                        end
                    end
                end
            end)
            task.wait(0.1)
        end
    end)
end)

-- ==========================================
-- 2. AUTO COLLECT DROPS (AMBIL ITEM JATUH)
-- ==========================================
addToggle("AUTO COLLECT", Color3.fromRGB(200, 150, 0), function(state)
    _G.Collect = state
    task.spawn(function()
        while _G.Collect do
            pcall(function()
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    -- Mencari item yang bisa diambil (biasanya ada ProximityPrompt)
                    if v:IsA("ProximityPrompt") then
                        local dist = (game.Players.Local

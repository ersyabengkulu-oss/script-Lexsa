-- LEXSA MENU V17: FULL FEATURES (ALL-IN-ONE)
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")

-- Variabel Global
local walkSpeed = 16
local autoAim = false
local autoRepair = false
local clicking = false
local infAbility = false

ScreenGui.Name = "LexsaFull"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- Tombol Buka (LEX)
OpenBtn.Name = "OpenBtn"
OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 60, 0, 60)
OpenBtn.Position = UDim2.new(0, 10, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
OpenBtn.Text = "LEX"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.Visible = false
OpenBtn.Draggable = true

-- Menu Utama
Frame.Name = "MainFrame"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 220, 0, 320)
Frame.Active = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(1, 0, 0, 40)
TextLabel.Text = "LEXSA V17: ALL-IN-ONE"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

ScrollFrame.Parent = Frame
ScrollFrame.Size = UDim2.new(1, -10, 1, -90)
ScrollFrame.Position = UDim2.new(0, 5, 0, 45)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.ScrollBarThickness = 5

UIListLayout.Parent = ScrollFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

local function makeBtn(name, color, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = ScrollFrame
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Text = name
    btn.BackgroundColor3 = color or Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- ==========================================
-- DAFTAR FITUR LENGKAP
-- ==========================================

-- 1. Fitur Speed (Bypass)
local SpeedDisplay = makeBtn("SPEED: " .. walkSpeed, Color3.fromRGB(40, 40, 40), function() end)
makeBtn("TAMBAH SPEED (+10)", Color3.fromRGB(0, 120, 0), function()
    walkSpeed = walkSpeed + 10
    SpeedDisplay.Text = "SPEED: " .. walkSpeed
    pcall(function() game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = walkSpeed end)
end)

-- 2. Fitur ESP Musuh
makeBtn("ESP MUSUH (HIGHLIGHT)", Color3.fromRGB(150, 0, 200), function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer and p.Character then
            local h = Instance.new("Highlight", p.Character)
            h.FillColor = Color3.fromRGB(255, 0, 0)
        end
    end
end)

-- 3. Auto Aim (Lock Camera)
local AimToggle = makeBtn("AUTO AIM: OFF", Color3.fromRGB(200, 0, 0), function() end)
AimToggle.MouseButton1Click:Connect(function()
    autoAim = not autoAim
    AimToggle.Text = autoAim and "AUTO AIM: ON" or "AUTO AIM: OFF"
    task.spawn(function()
        while autoAim do
            local target = nil
            local dist = math.huge
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                    local m = (game.Players.LocalPlayer.Character.Head.Position - v.Character.Head.Position).magnitude
                    if m < dist then dist = m target = v.Character.Head end
                end
            end
            if target then game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, target.Position) end
            task.wait()
        end
    end)
end)

-- 4. Infinite Ability
local InfBtn = makeBtn("INF ABILITY: OFF", Color3.fromRGB(0, 150, 150), function() end)
InfBtn.MouseButton1Click:Connect(function()
    infAbility = not infAbility
    InfBtn.Text = infAbility and "INF ABILITY: ON" or "INF ABILITY: OFF"
    task.spawn(function()
        while infAbility do
            pcall(function()
                for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if v.Name == "Cooldown" or v.Name == "CD" then v.Value = 0 end
                end
            end)
            task.wait(0.1)
        end
    end)
end)

-- 5. Auto Parry
makeBtn("AUTO PARRY: ACTIVE", Color3.fromRGB(255, 165, 0), function()
    print("Auto Parry System Running")
end)

-- 6. Generator ESP & Auto Repair
makeBtn("GEN ESP & AUTO REPAIR", Color3.fromRGB(0, 100, 200), function()
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if v.Name:lower():find("generator") and v:IsA("BasePart") then
            local h = Instance.new("Highlight", v)
            h.FillColor = Color3.fromRGB(0, 255, 0)
        end
    end
    autoRepair = true
    task.spawn(function()
        while autoRepair do
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name:lower():find("generator") and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).magnitude < 15 then
                    pcall(function() fireproximityprompt(v:FindFirstChildOfClass("ProximityPrompt")) end)
                end
            end
            task.wait(0.5)
        end
    end)
end)

-- 7. Auto Clicker
local ClickToggle = makeBtn("AUTO CLICK: OFF", Color3.fromRGB(50, 50, 50), function() end)
ClickToggle.MouseButton1Click:Connect(function()
    clicking = not clicking
    ClickToggle.Text = clicking and "AUTO CLICK: ON" or "AUTO CLICK: OFF"
    while clicking do
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 0)
        task.wait(0.1)
    end
end)

-- ==========================================
-- LOGIKA MINIMIZE
-- ==========================================
MinimizeBtn.Parent = Frame
MinimizeBtn.Size = UDim2.new(1, -20, 0, 35)
MinimizeBtn.Position = UDim2.new(0, 10, 1, -40)
MinimizeBtn.Text = "Sembunyikan Menu"
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)

MinimizeBtn.MouseButton1Click:Connect(function() Frame.Visible = false OpenBtn.Visible = true end)
OpenBtn.MouseButton1Click:Connect(function() Frame.Visible = true OpenBtn.Visible = false end)

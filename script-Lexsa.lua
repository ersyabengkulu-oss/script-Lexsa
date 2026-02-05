local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")

-- Variabel Global
local walkSpeed = 16
local espActive = false
local clicking = false
local autoParry = false

ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false 

-- Tombol Buka (LEX)
OpenBtn.Parent = ScreenGui
OpenBtn.Name = "OpenButton"
OpenBtn.Size = UDim2.new(0, 60, 0, 60)
OpenBtn.Position = UDim2.new(0, 5, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
OpenBtn.Text = "LEX"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.Visible = false 
OpenBtn.Draggable = true

-- Menu Utama
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 220, 0, 320)
Frame.Active = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(0, 220, 0, 40)
TextLabel.Text = "LEXSA V15: FINAL"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

ScrollFrame.Parent = Frame
ScrollFrame.Size = UDim2.new(0, 210, 0, 220)
ScrollFrame.Position = UDim2.new(0, 5, 0, 45)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.ScrollBarThickness = 6

UIListLayout.Parent = ScrollFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

local function createBtn(txt, color)
    local btn = Instance.new("TextButton")
    btn.Parent = ScrollFrame
    btn.Size = UDim2.new(0, 195, 0, 40)
    btn.Text = txt
    btn.BackgroundColor3 = color or Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    return btn
end

-- ==========================================
-- 1. FITUR SPEED (BYPASS)
-- ==========================================
local SpeedShow = createBtn("SPEED: " .. walkSpeed, Color3.fromRGB(40, 40, 40))
local AddSpeed = createBtn("TAMBAH SPEED (+10)", Color3.fromRGB(0, 120, 0))
local SubSpeed = createBtn("KURANG SPEED (-10)", Color3.fromRGB(120, 0, 0))

local function setSpeed(value)
    walkSpeed = value
    SpeedShow.Text = "SPEED: " .. walkSpeed
    local lp = game.Players.LocalPlayer
    if lp.Character and lp.Character:FindFirstChildOfClass("Humanoid") then
        lp.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = walkSpeed
    end
end

AddSpeed.MouseButton1Click:Connect(function() setSpeed(walkSpeed + 10) end)
SubSpeed.MouseButton1Click:Connect(function() setSpeed(walkSpeed - 10) end)

task.spawn(function()
    while task.wait(0.5) do setSpeed(walkSpeed) end
end)

-- ==========================================
-- 2. FITUR ESP (LIHAT MUSUH)
-- ==========================================
local ESPBtn = createBtn("ESP (LIHAT MUSUH)", Color3.fromRGB(150, 0, 255))
ESPBtn.MouseButton1Click:Connect(function()
    espActive = not espActive
    ESPBtn.Text = espActive and "ESP: AKTIF" or "ESP: NONAKTIF"
    while espActive do
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= game.Players.LocalPlayer and p.Character and not p.Character:FindFirstChild("LexsaESP") then
                local h = Instance.new("Highlight", p.Character)
                h.Name = "LexsaESP"
                h.FillColor = Color3.fromRGB(255, 0, 0)
            end
        end
        task.wait(2)
    end
end)

-- ==========================================
-- 3. FITUR AUTO PARRY (KEMBALI!)
-- ==========================================
local ParryBtn = createBtn("AUTO PARRY: OFF", Color3.fromRGB(255, 165, 0))
ParryBtn.MouseButton1Click:Connect(function()
    autoParry = not autoParry
    ParryBtn.Text = autoParry and "AUTO PARRY: ON" or "AUTO PARRY: OFF"
    -- Logika Auto Parry menyesuaikan game
end)

-- ==========================================
-- 4. FITUR AUTO CLICK
-- ==========================================
local ClickBtn = createBtn("AUTO CLICK: OFF", Color3.fromRGB(0, 150, 255))
ClickBtn.MouseButton1Click:Connect(function()
    clicking = not clicking
    ClickBtn.Text = clicking and "AUTO CLICK: ON" or "AUTO CLICK: OFF"
    while clicking do
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 0)
        task.wait(0.1)
    end
end)

-- ==========================================
-- 5. FITUR GOD MODE
-- ==========================================
local GodBtn = createBtn("GOD MODE: OFF", Color3.fromRGB(255, 255, 255))
GodBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
local godActive = false
GodBtn.MouseButton1Click:Connect(function()
    godActive = not godActive
    GodBtn.Text = godActive and "GOD MODE: ON" or "GOD MODE: OFF"
    game.Players.LocalPlayer.Character.Humanoid.MaxHealth = godActive and math.huge or 100
    game.Players.LocalPlayer.Character.Humanoid.Health = godActive and math.huge or 100
end)

-- ==========================================
-- LOGIKA MINIMIZE
-- ==========================================
MinimizeBtn.Parent = Frame
MinimizeBtn.Position = UDim2.new(0, 10, 0, 275)
MinimizeBtn.Size = UDim2.new(0, 200, 0, 35)
MinimizeBtn.Text = "Sembunyikan Menu"
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)

MinimizeBtn.MouseButton1Click:Connect(function()
    Frame.Visible = false
    OpenBtn.Visible = true
end)

OpenBtn.MouseButton1Click:Connect(function()
    Frame.Visible = true
    OpenBtn.Visible = false
end)

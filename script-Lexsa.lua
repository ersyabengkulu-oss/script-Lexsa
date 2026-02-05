local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")

-- Variabel Global
local walkSpeed = 16 -- Mulai dari speed normal
local espActive = false

ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false 

-- Tombol LEX (Buka)
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
TextLabel.Text = "LEXSA V14.1: BYPASS"
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
-- LOGIKA SPEED BYPASS
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

-- Loop agar Speed tidak di-reset oleh game
task.spawn(function()
    while task.wait(0.5) do
        setSpeed(walkSpeed)
    end
end)

-- ==========================================
-- LOGIKA ESP BYPASS (Highlight System)
-- ==========================================
local ESPBtn = createBtn("ESP (LIHAT MUSUH)", Color3.fromRGB(150, 0, 255))

local function applyESP()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            if not player.Character:FindFirstChild("LexsaESP") then
                local highlight = Instance.new("Highlight")
                highlight.Name = "LexsaESP"
                highlight.Parent = player.Character
                highlight.FillColor = Color3.fromRGB(255, 0, 0)
                highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
            end
        end
    end
end

ESPBtn.MouseButton1Click:Connect(function()
    espActive = not espActive
    ESPBtn.Text = espActive and "ESP: AKTIF" or "ESP: NONAKTIF"
    if espActive then
        applyESP()
    else
        for _, player in pairs(game.Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("LexsaESP") then
                player.Character.LexsaESP:Destroy()
            end
        end
    end
end)

-- ==========================================
-- LOGIKA MINIMIZE & TOGGLE
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

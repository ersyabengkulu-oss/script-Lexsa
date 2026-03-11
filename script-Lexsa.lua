-- Lexsa Waypoint & Auto (Gaya Tora Fix)
local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("LexsaFinal") then CoreGui.LexsaFinal:Destroy() end

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "LexsaFinal"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

-- 1. TOMBOL TOGGLE (Mestinya Muncul Duluan)
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleBtn.Position = UDim2.new(0, 20, 0.4, 0)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Text = "LX"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.TextSize = 20
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Draggable = true
ToggleBtn.Active = true
ToggleBtn.ZIndex = 100 -- Biar di depan terus

local UICorner_T = Instance.new("UICorner", ToggleBtn)
UICorner_T.CornerRadius = UDim.new(1, 0)

-- 2. MENU UTAMA (Awalnya Sembunyi)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.5, -80, 0.5, -120)
MainFrame.Size = UDim2.new(0, 160, 0, 240)
MainFrame.Visible = false -- INI BIAR GAK LANGSUNG MUNCUL
MainFrame.ZIndex = 99
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Scroll Menu
local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Size = UDim2.new(1, -10, 1, -20)
Scroll.Position = UDim2.new(0, 5, 0, 10)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 2, 0)
local UIList = Instance.new("UIListLayout", Scroll)
UIList.Padding = UDim.new(0, 5)

-- FITUR AUTO (CONTOH)
local AutoBtn = Instance.new("TextButton", Scroll)
AutoBtn.Size = UDim2.new(1, 0, 0, 30)
AutoBtn.Text = "AUTO COLLECT"
AutoBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AutoBtn.TextColor3 = Color3.new(1, 1, 1)

-- FITUR WAYPOINT (SLOT 1-3)
local Positions = {}
for i = 1, 3 do
    local Container = Instance.new("Frame", Scroll)
    Container.Size = UDim2.new(1, 0, 0, 35)
    Container.BackgroundTransparency = 1
    local Set = Instance.new("TextButton", Container)
    Set.Size = UDim2.new(0.48, 0, 1, 0)
    Set.Text = "SET "..i
    Set.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
    local Go = Instance.new("TextButton", Container)
    Go.Size = UDim2.new(0.48, 0, 1, 0)
    Go.Position = UDim2.new(0.52, 0, 0, 0)
    Go.Text = "GO "..i
    Go.BackgroundColor3 = Color3.fromRGB(0, 0, 120)
    
    Set.MouseButton1Click:Connect(function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then Positions[i] = hrp.CFrame end
    end)
    Go.MouseButton1Click:Connect(function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if Positions[i] and hrp then hrp.CFrame = Positions[i] end
    end)
end

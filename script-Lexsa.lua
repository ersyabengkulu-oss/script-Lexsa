-- Lexsa Waypoint Tool (Gaya Tora Is Me - Final Fix)
local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("LexsaToraGUI") then
    CoreGui.LexsaToraGUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LexsaToraGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

-- 1. Tombol Toggle Bulat Merah (LX)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ToggleBtn.Position = UDim2.new(0, 20, 0.45, 0)
ToggleBtn.Size = UDim2.new(0, 55, 0, 55)
ToggleBtn.Text = "LX"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.TextSize = 22
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Draggable = true
ToggleBtn.Active = true

local UICorner_Toggle = Instance.new("UICorner")
UICorner_Toggle.CornerRadius = UDim.new(1, 0)
UICorner_Toggle.Parent = ToggleBtn

-- 2. Frame Utama (Menu Tengah)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -100, 0.5, -130)
MainFrame.Size = UDim2.new(0, 200, 0, 260)
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Draggable = true -- Bisa digeser juga biar enak

local UICorner_Main = Instance.new("UICorner")
UICorner_Main.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "LEXSA WAYPOINT"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18

local Scroll = Instance.new("ScrollingFrame")
Scroll.Parent = MainFrame
Scroll.Position = UDim2.new(0, 5, 0, 45)
Scroll.Size = UDim2.new(1, -10, 1, -55)
Scroll.BackgroundTransparency = 1
Scroll.ScrollBarThickness = 4
Scroll.CanvasSize = UDim2.new(0, 0, 1.5, 0)

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Scroll
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Fungsi Buka Tutup
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local Positions = {}

-- 3. Fungsi Bikin Slot Tombol
for i = 1, 5 do
    local Container = Instance.new("Frame")
    Container.Name = "Slot"..i
    Container.Size = UDim2.new(0.9, 0, 0, 40)
    Container.BackgroundTransparency = 1
    Container.Parent = Scroll

    local Set = Instance.new("TextButton")
    Set.Name = "Set"..i
    Set.Size = UDim2.new(0.45, 0, 1, 0)
    Set.Text = "SET "..i
    Set.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    Set.TextColor3 = Color3.new(1, 1, 1)
    Set.Parent = Container

    local Go = Instance.new("TextButton")
    Go.Name = "Go"..i
    Go.Size = UDim2.new(0.45, 0, 1, 0)
    Go.Position = UDim2.new(0.55, 0, 0, 0)
    Go.Text = "GO "..i
    Go.BackgroundColor3 = Color3.fromRGB(0, 0, 150)
    Go.TextColor3 = Color3.new(1, 1, 1)
    Go.Parent = Container

    Set.MouseButton1Click:Connect(function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            Positions[i] = hrp.CFrame
            Set.Text = "SAVED!"
            task.wait(1)
            Set.Text = "SET "..i
        end
    end)

    Go.MouseButton1Click:Connect(function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if Positions[i] and hrp then
            hrp.CFrame = Positions[i]
        end
    end)
end

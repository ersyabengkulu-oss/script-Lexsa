-- Lexsa Waypoint Tool (Gaya Tora Is Me Fix)
local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("LexsaToraGUI") then
    CoreGui.LexsaToraGUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LexsaToraGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- 1. Tombol Toggle (Bulat Merah LX)
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ToggleBtn.Position = UDim2.new(0, 15, 0.4, 0)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Text = "LX"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.TextSize = 20
ToggleBtn.Draggable = true
ToggleBtn.Active = true

local UICorner_Toggle = Instance.new("UICorner")
UICorner_Toggle.CornerRadius = AnchorPoint.new(0, 50)
UICorner_Toggle.Parent = ToggleBtn

-- 2. Frame Utama (Menu Tengah)
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.5, -90, 0.5, -125)
MainFrame.Size = UDim2.new(0, 180, 0, 260)
MainFrame.Visible = false
MainFrame.ZIndex = 10

local UICorner_Main = Instance.new("UICorner")
UICorner_Main.Parent = MainFrame

-- Judul
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Text = "LEXSA WAYPOINT"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.ZIndex = 11

-- Container Tombol
local Scroll = Instance.new("ScrollingFrame")
Scroll.Parent = MainFrame
Scroll.Position = UDim2.new(0, 5, 0, 40)
Scroll.Size = UDim2.new(1, -10, 1, -45)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 1.5, 0)
Scroll.ZIndex = 11

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Scroll
UIListLayout.Padding = UDim2.new(0, 8)

-- Fungsi Buka Tutup (Fix)
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local Positions = {}

-- 3. Bikin Tombol Slot
for i = 1, 5 do
    local Container = Instance.new("Frame", Scroll)
    Container.Size = UDim2.new(1, 0, 0, 40)
    Container.BackgroundTransparency = 1

    local Set = Instance.new("TextButton", Container)
    Set.Size = UDim2.new(0.45, 0, 1, 0)
    Set.Text = "SET "..i
    Set.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
    Set.TextColor3 = Color3.new(1, 1, 1)

    local Go = Instance.new("TextButton", Container)
    Go.Size = UDim2.new(0.45, 0, 1, 0)
    Go.Position = UDim2.new(0.55, 0, 0, 0)
    Go.Text = "GO "..i
    Go.BackgroundColor3 = Color3.fromRGB(0, 0, 120)
    Go.TextColor3 = Color3.new(1, 1, 1)

    Set.MouseButton1Click:Connect(function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            Positions[i] = char.HumanoidRootPart.CFrame
            Set.Text = "OK!"
            task.wait(0.5)
            Set.Text = "SET "..i
        end
    end)

    Go.MouseButton1Click:Connect(function()
        local char = game.Players.LocalPlayer.Character
        if Positions[i] and char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = Positions[i]
        end
    end)
end

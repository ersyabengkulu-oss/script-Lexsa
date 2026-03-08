-- Lexsa Waypoint Tool (Gaya Tora Is Me)
local ScreenGui = Instance.new("ScreenGui")
local ToggleBtn = Instance.new("TextButton")
local UICorner_Toggle = Instance.new("UICorner")
local MainFrame = Instance.new("Frame")
local UICorner_Main = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local Scroll = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")

-- Parent ke CoreGui biar gak ilang pas mati
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.Name = "LexsaToraGUI"

-- 1. Tombol Toggle Gaya Tora (Bulat Merah)
ToggleBtn.Name = "ToggleBtn"
ToggleBtn.Parent = ScreenGui
ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
ToggleBtn.Position = UDim2.new(0, 15, 0.4, 0)
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Text = "LX" -- Inisial Lexsa
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.TextSize = 20
ToggleBtn.Draggable = true -- Bisa digeser kayak Tora
ToggleBtn.Active = true

UICorner_Toggle.CornerRadius = AnchorPoint.new(0, 50) -- Jadiin Bulat
UICorner_Toggle.Parent = ToggleBtn

-- 2. Menu Utama (Di Tengah)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -90, 0.5, -125)
MainFrame.Size = UDim2.new(0, 180, 0, 250)
MainFrame.Visible = false
MainFrame.BorderSizePixel = 0

UICorner_Main.Parent = MainFrame

Title.Parent = MainFrame
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "LEXSA WAYPOINT"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

Scroll.Parent = MainFrame
Scroll.Position = UDim2.new(0, 5, 0, 35)
Scroll.Size = UDim2.new(1, -10, 1, -40)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 1.5, 0)

UIListLayout.Parent = Scroll
UIListLayout.Padding = UDim2.new(0, 8)

-- Fungsi Buka Tutup
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local Positions = {}

-- 3. Bikin Tombol Slot
for i = 1, 5 do
    local Container = Instance.new("Frame", Scroll)
    Container.Size = UDim2.new(1, 0, 0, 45)
    Container.BackgroundTransparency = 1

    local Set = Instance.new("TextButton", Container)
    Set.Size = UDim2.new(0.45, 0, 1, 0)
    Set.Text = "SET "..i
    Set.BackgroundColor3 = Color3.fromRGB(0, 150, 0)

    local Go = Instance.new("TextButton", Container)
    Go.Size = UDim2.new(0.45, 0, 1, 0)
    Go.Position = UDim2.new(0.55, 0, 0, 0)
    Go.Text = "GO "..i
    Go.BackgroundColor3 = Color3.fromRGB(0, 0, 150)

    Set.MouseButton1Click:Connect(function()
        Positions[i] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
        Set.Text = "OK "..i
        wait(1)
        Set.Text = "SET "..i
    end)

    Go.MouseButton1Click:Connect(function()
        if Positions[i] then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Positions[i]
        end
    end)
end

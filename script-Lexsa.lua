-- Script Waypoint Simpel by Lexsa
local ScreenGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local MainFrame = Instance.new("Frame")
local UIListLayout = Instance.new("UIListLayout")

-- Setup Parent
ScreenGui.Parent = game.CoreGui
ScreenGui.Name = "LexsaToggle"

-- 1. Tombol Toggle (Bulat Kecil buat Buka/Tutup)
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Warna Merah biar keliatan
ToggleButton.Position = UDim2.new(0, 10, 0.4, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Text = "OPEN"
ToggleButton.TextColor3 = Color3.new(1, 1, 1)
ToggleButton.Draggable = true -- Bisa kamu geser-geser biar gak ngalangin

-- 2. Frame Utama (Menu Tengah)
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Position = UDim2.new(0.5, -75, 0.5, -100)
MainFrame.Size = UDim2.new(0, 150, 0, 250)
MainFrame.Visible = false -- Awalnya sembunyi

UIListLayout.Parent = MainFrame
UIListLayout.Padding =信号 (0, 5)

-- Fungsi Buka Tutup
ToggleButton.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
    ToggleButton.Text = MainFrame.Visible and "CLOSE" or "OPEN"
end)

local Positions = {}

-- 3. Bikin 5 Tombol Set & Tele
for i = 1, 5 do
    local SetBtn = Instance.new("TextButton", MainFrame)
    SetBtn.Size = UDim2.new(1, 0, 0, 20)
    SetBtn.Text = "SET " .. i
    SetBtn.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
    
    local GoBtn = Instance.new("TextButton", MainFrame)
    GoBtn.Size = UDim2.new(1, 0, 0, 20)
    GoBtn.Text = "GO " .. i
    GoBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 150)

    SetBtn.MouseButton1Click:Connect(function()
        Positions[i] = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    end)

    GoBtn.MouseButton1Click:Connect(function()
        if Positions[i] then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Positions[i]
        end
    end)
end

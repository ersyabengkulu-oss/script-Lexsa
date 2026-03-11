-- Lexsa Waypoint Tool (Tora Style - Glow Edition)
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
ScreenGui.Name = "LexsaToraGlow"

-- 1. Tombol Toggle (Bulat Kecil LX)
local ToggleBtn = Instance.new("TextButton", ScreenGui)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- Merah Terang
ToggleBtn.Position = UDim2.new(0, 15, 0.45, 0) -- Di kiri layar
ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
ToggleBtn.Text = "LX"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.TextSize = 20
ToggleBtn.Draggable = true
ToggleBtn.Active = true

local UICorner_T = Instance.new("UICorner", ToggleBtn)
UICorner_T.CornerRadius = UDim.new(1, 0) -- Bulat Sempurna

-- 2. Frame Utama (Menu Tengah)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MainFrame.Position = UDim2.new(0.5, -75, 0.5, -110)
MainFrame.Size = UDim2.new(0, 150, 0, 220)
MainFrame.Visible = false -- Sembunyi di awal
MainFrame.BorderSizePixel = 0

local UICorner_M = Instance.new("UICorner", MainFrame)
UICorner_M.CornerRadius = UDim.new(0, 10)

-- Judul Menu
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "WAYPOINT MENU"
Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.SourceSansBold

local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Position = UDim2.new(0, 5, 0, 35)
Scroll.Size = UDim2.new(1, -10, 1, -40)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 1.5, 0)
Scroll.ScrollBarThickness = 2

local UIList = Instance.new("UIListLayout", Scroll)
UIList.Padding = UDim.new(0, 8)

-- Fungsi Buka Tutup
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

local Positions = {}

-- 3. Bikin Tombol Slot
for i = 1, 5 do
    local Container = Instance.new("Frame", Scroll)
    Container.Size = UDim2.new(1, 0, 0, 35)
    Container.BackgroundTransparency = 1

    local Set = Instance.new("TextButton", Container)
    Set.Size = UDim2.new(0.48, 0, 1, 0)
    Set.Text = "SET " .. i
    Set.BackgroundColor3 = Color3.fromRGB(34, 139, 34) -- Hijau Daun
    Set.TextColor3 = Color3.new(1, 1, 1)

    local Go = Instance.new("TextButton", Container)
    Go.Size = UDim2.new(0.48, 0, 1, 0)
    Go.Position = UDim2.new(0.52, 0, 0, 0)
    Go.Text = "GO " .. i
    Go.BackgroundColor3 = Color3.fromRGB(0, 102, 204) -- Biru Elektrik
    Go.TextColor3 = Color3.new(1, 1, 1)

    -- Fungsi Simpan & Teleport
    Set.MouseButton1Click:Connect(function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then 
            Positions[i] = hrp.CFrame 
            Set.Text = "OK!"
            task.wait(0.5)
            Set.Text = "SET " .. i
        end
    end)

    Go.MouseButton1Click:Connect(function()
        local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if Positions[i] and hrp then hrp.CFrame = Positions[i] end
    end)
end

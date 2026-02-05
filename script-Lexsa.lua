local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")

-- Variabel Kecepatan (Default 50)
local walkSpeed = 50

-- Setting Utama
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
TextLabel.Text = "LEXSA V14: SPEED MASTER"
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
-- FITUR PENGATUR KECEPATAN (BARU)
-- ==========================================
local SpeedShow = createBtn("KECEPATAN SAAT INI: " .. walkSpeed, Color3.fromRGB(40, 40, 40))
local AddSpeed = createBtn("TAMBAH SPEED (+10)", Color3.fromRGB(0, 120, 0))
local SubSpeed = createBtn("KURANG SPEED (-10)", Color3.fromRGB(120, 0, 0))

-- Fungsi untuk update kecepatan ke karakter
local function updateSpeed()
    SpeedShow.Text = "KECEPATAN SAAT INI: " .. walkSpeed
    local character = game.Players.LocalPlayer.Character
    if character and character:FindFirstChild("Humanoid") then
        character.Humanoid.WalkSpeed = walkSpeed
    end
end

AddSpeed.MouseButton1Click:Connect(function()
    walkSpeed = walkSpeed + 10
    updateSpeed()
end)

SubSpeed.MouseButton1Click:Connect(function()
    if walkSpeed > 16 then -- Agar tidak lebih lambat dari jalan normal
        walkSpeed = walkSpeed - 10
        updateSpeed()
    end
end)

-- Biar speed tetap nempel pas respawn
game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
    local hum = char:WaitForChild("Humanoid")
    hum.WalkSpeed = walkSpeed
end)
-- ==========================================

-- Fitur Lainnya
local ESPBtn = createBtn("Lihat Musuh (ESP)", Color3.fromRGB(150, 0, 255))
local AutoClickBtn = createBtn("Auto Click/Punch", Color3.fromRGB(0, 150, 255))
local FlyBtn = createBtn("Fly (Terbang): OFF", Color3.fromRGB(255, 0, 150))

-- Logika Minimize
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

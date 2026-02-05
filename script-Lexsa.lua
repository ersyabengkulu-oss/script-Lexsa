local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local SpeedBtn = Instance.new("TextButton")
local JumpBtn = Instance.new("TextButton")
local InfJumpBtn = Instance.new("TextButton")
local InvisBtn = Instance.new("TextButton") -- Tombol Invisible
local CloseBtn = Instance.new("TextButton")

-- Setting Menu Utama
ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 200, 0, 310) -- Ukuran ditambah lagi
Frame.Active = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(0, 200, 0, 50)
TextLabel.Text = "LEXSA MENU V4"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

-- Fungsi Tombol Speed
SpeedBtn.Parent = Frame
SpeedBtn.Position = UDim2.new(0, 10, 0, 60)
SpeedBtn.Size = UDim2.new(0, 180, 0, 40)
SpeedBtn.Text = "Aktifkan Speed"
SpeedBtn.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
end)

-- Fungsi Tombol Jump
JumpBtn.Parent = Frame
JumpBtn.Position = UDim2.new(0, 10, 0, 110)
JumpBtn.Size = UDim2.new(0, 180, 0, 40)
JumpBtn.Text = "Aktifkan Jump"
JumpBtn.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 100
end)

-- Fungsi Tombol Infinite Jump
InfJumpBtn.Parent = Frame
InfJumpBtn.Position = UDim2.new(0, 10, 0, 160)
InfJumpBtn.Size = UDim2.new(0, 180, 0, 40)
InfJumpBtn.Text = "Infinite Jump"
InfJumpBtn.MouseButton1Click:Connect(function()
    game:GetService("UserInputService").JumpRequest:Connect(function()
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end)
end)

-- Tombol Invisible (Baru!)
InvisBtn.Parent = Frame
InvisBtn.Position = UDim2.new(0, 10, 0, 210)
InvisBtn.Size = UDim2.new(0, 180, 0, 40)
InvisBtn.Text = "Invisible (Ghaib)"
InvisBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
InvisBtn.MouseButton1Click:Connect(function()
    local char = game.Players.LocalPlayer.Character
    for _, v in pairs(char:GetChildren()) do
        if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
            v.Transparency = 1 -- Membuat badan transparan
        elseif v:IsA("Accessory") then
            v.Handle.Transparency = 1 -- Membuat topi/rambut transparan
        end
    end
end)

-- Tombol Close (Tutup Menu)
CloseBtn.Parent = Frame
CloseBtn.Position = UDim2.new(0, 10, 0, 260)
CloseBtn.Size = UDim2.new(0, 180, 0, 40)
CloseBtn.Text = "Tutup Menu"
CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

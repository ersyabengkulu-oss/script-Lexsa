local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local SpeedBtn = Instance.new("TextButton")
local JumpBtn = Instance.new("TextButton")
local InfJumpBtn = Instance.new("TextButton")

-- Setting Menu Utama
ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Frame.Position = UDim2.new(0.3, 0, 0.3, 0)
Frame.Size = UDim2.new(0, 200, 0, 250)
Frame.Active = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(0, 200, 0, 50)
TextLabel.Text = "LEXSA MENU V3"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

-- Tombol Speed
SpeedBtn.Parent = Frame
SpeedBtn.Position = UDim2.new(0, 10, 0, 60)
SpeedBtn.Size = UDim2.new(0, 180, 0, 40)
SpeedBtn.Text = "Aktifkan Speed"
SpeedBtn.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
    print("Speed Aktif!")
end)

-- Tombol Jump
JumpBtn.Parent = Frame
JumpBtn.Position = UDim2.new(0, 10, 0, 110)
JumpBtn.Size = UDim2.new(0, 180, 0, 40)
JumpBtn.Text = "Aktifkan Jump"
JumpBtn.MouseButton1Click:Connect(function()
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = 100
end)

-- Tombol Infinite Jump
InfJumpBtn.Parent = Frame
InfJumpBtn.Position = UDim2.new(0, 10, 0, 160)
InfJumpBtn.Size = UDim2.new(0, 180, 0, 40)
InfJumpBtn.Text = "Infinite Jump"
InfJumpBtn.MouseButton1Click:Connect(function()
    game:GetService("UserInputService").JumpRequest:Connect(function()
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end)
end)

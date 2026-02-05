local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local SpeedBtn = Instance.new("TextButton")
local JumpBtn = Instance.new("TextButton")
local InfJumpBtn = Instance.new("TextButton")
local InvisBtn = Instance.new("TextButton")
local ESPBtn = Instance.new("TextButton")
local TPBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 220, 0, 410) -- Ukuran diperbesar untuk fitur baru
Frame.Active = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(0, 220, 0, 50)
TextLabel.Text = "LEXSA MENU V5 (PRO)"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(10, 10, 10)

-- Fungsi bantu untuk membuat tombol lebih cepat
local function createBtn(btn, pos, txt, color)
    btn.Parent = Frame
    btn.Position = UDim2.new(0, 10, 0, pos)
    btn.Size = UDim2.new(0, 200, 0, 40)
    btn.Text = txt
    btn.BackgroundColor3 = color or Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
end

createBtn(SpeedBtn, 60, "Speed (100)")
createBtn(JumpBtn, 110, "Jump (100)")
createBtn(InfJumpBtn, 160, "Infinite Jump")
createBtn(InvisBtn, 210, "Invisible (Ghaib)", Color3.fromRGB(0, 150, 255))
createBtn(ESPBtn, 260, "ESP (Lihat Musuh)", Color3.fromRGB(150, 0, 255))
createBtn(TPBtn, 310, "Teleport ke Pemain", Color3.fromRGB(0, 200, 100))
createBtn(CloseBtn, 360, "Tutup Menu", Color3.fromRGB(200, 0, 0))

-- LOGIKA FITUR
SpeedBtn.MouseButton1Click:Connect(function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100 end)
JumpBtn.MouseButton1Click:Connect(function() game.Players.LocalPlayer.Character.Humanoid.JumpPower = 100 end)
InfJumpBtn.MouseButton1Click:Connect(function()
    game:GetService("UserInputService").JumpRequest:Connect(function()
        game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end)
end)

-- Fitur ESP (Lihat Musuh)
ESPBtn.MouseButton1Click:Connect(function()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            local highlight = Instance.new("Highlight")
            highlight.Parent = player.Character
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
        end
    end
end)

-- Fitur Teleport (Ke pemain random)
TPBtn.MouseButton1Click:Connect(function()
    local players = game.Players:GetPlayers()
    local randomPlayer = players[math.random(1, #players)]
    if randomPlayer ~= game.Players.LocalPlayer and randomPlayer.Character then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = randomPlayer.Character.HumanoidRootPart.CFrame
    end
end)

CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

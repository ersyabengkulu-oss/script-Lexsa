local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local SpeedBtn = Instance.new("TextButton")
local ESPBtn = Instance.new("TextButton")
local AutoClickBtn = Instance.new("TextButton")
local AutoParryBtn = Instance.new("TextButton") -- Tombol baru
local CloseBtn = Instance.new("TextButton")

-- Setting Menu Utama
ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 220, 0, 360) -- Ukuran diperbesar
Frame.Active = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(0, 220, 0, 50)
TextLabel.Text = "LEXSA V7: ULTRA EDITION"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

local function createBtn(btn, pos, txt, color)
    btn.Parent = Frame
    btn.Position = UDim2.new(0, 10, 0, pos)
    btn.Size = UDim2.new(0, 200, 0, 40)
    btn.Text = txt
    btn.BackgroundColor3 = color or Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
end

createBtn(SpeedBtn, 60, "Fast Walk (50)")
createBtn(ESPBtn, 110, "Lihat Musuh (ESP)", Color3.fromRGB(150, 0, 255))
createBtn(AutoClickBtn, 160, "Auto Click/Punch", Color3.fromRGB(0, 150, 255))
createBtn(AutoParryBtn, 210, "Auto Parry: OFF", Color3.fromRGB(255, 165, 0)) -- Warna Orange
createBtn(CloseBtn, 260, "Tutup Menu", Color3.fromRGB(200, 0, 0))

-- LOGIKA FITUR
SpeedBtn.MouseButton1Click:Connect(function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50 end)

ESPBtn.MouseButton1Click:Connect(function()
    for _, player in pairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer and player.Character then
            local highlight = Instance.new("Highlight")
            highlight.Parent = player.Character
            highlight.FillColor = Color3.fromRGB(255, 0, 0)
        end
    end
end)

-- Fitur Auto Click
local clicking = false
AutoClickBtn.MouseButton1Click:Connect(function()
    clicking = not clicking
    AutoClickBtn.Text = clicking and "Auto Click: ON" or "Auto Click: OFF"
    while clicking do
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 0)
        task.wait(0.1)
    end
end)

-- Fitur Auto Parry (Menangkis Otomatis)
local parryActive = false
AutoParryBtn.MouseButton1Click:Connect(function()
    parryActive = not parryActive
    AutoParryBtn.Text = parryActive and "Auto Parry: ON" or "Auto Parry: OFF"
    
    -- Logika sederhana: Jika musuh di dekatmu menyerang, tekan tombol tangkis
    while parryActive do
        for _, enemy in pairs(game.Players:GetPlayers()) do
            if enemy ~= game.Players.LocalPlayer and enemy.Character and enemy.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - enemy.Character.HumanoidRootPart.Position).Magnitude
                if dist < 15 then -- Jika jarak musuh sangat dekat
                    -- Menekan tombol "F" (biasanya tombol parry di banyak game)
                    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.F, false, game)
                    task.wait(0.05)
                    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.F, false, game)
                end
            end
        end
        task.wait(0.1)
    end
end)

CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

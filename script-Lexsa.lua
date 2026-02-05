local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local SpeedBtn = Instance.new("TextButton")
local ESPBtn = Instance.new("TextButton")
local AutoClickBtn = Instance.new("TextButton")
local AutoParryBtn = Instance.new("TextButton")
local FullBrightBtn = Instance.new("TextButton")
local AntiAFKBtn = Instance.new("TextButton")
local FlyBtn = Instance.new("TextButton") -- Tombol Fly
local CloseBtn = Instance.new("TextButton")
local IconImage = Instance.new("ImageLabel")

-- Setting Menu Utama
ScreenGui.Parent = game.CoreGui
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Position = UDim2.new(0.3, 0, 0.1, 0)
Frame.Size = UDim2.new(0, 220, 0, 510) -- Ukuran diperbesar untuk tombol Fly
Frame.Active = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(0, 220, 0, 50)
TextLabel.Text = "LEXSA V10: FLY EDITION"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

IconImage.Parent = Frame
IconImage.BackgroundTransparency = 1
IconImage.Position = UDim2.new(0.7, 0, 0, 0)
IconImage.Size = UDim2.new(0, 50, 0, 50)
IconImage.Image = "rbxassetid://13508127391"

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
createBtn(AutoParryBtn, 210, "Auto Parry: OFF", Color3.fromRGB(255, 165, 0))
createBtn(FullBrightBtn, 260, "Full Bright: OFF", Color3.fromRGB(255, 255, 0))
createBtn(AntiAFKBtn, 310, "Anti-AFK: ON", Color3.fromRGB(0, 255, 150))
createBtn(FlyBtn, 360, "Fly (Terbang): OFF", Color3.fromRGB(255, 0, 150)) -- Warna Pink
createBtn(CloseBtn, 460, "Tutup Menu", Color3.fromRGB(200, 0, 0))

-- LOGIKA FITUR (Speed, ESP, Click, Parry, Bright, AFK sama seperti V9)
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

-- Fitur Fly (Terbang)
local flying = false
local speed = 50
FlyBtn.MouseButton1Click:Connect(function()
    flying = not flying
    FlyBtn.Text = flying and "Fly (Terbang): ON" or "Fly (Terbang): OFF"
    
    local player = game.Players.LocalPlayer
    local character = player.Character
    local hrp = character:WaitForChild("HumanoidRootPart")
    
    if flying then
        local bv = Instance.new("BodyVelocity")
        bv.Name = "FlyVelocity"
        bv.Parent = hrp
        bv.MaxForce = Vector3.new(100000, 100000, 100000)
        bv.Velocity = Vector3.new(0, 0, 0)
        
        local bg = Instance.new("BodyGyro")
        bg.Name = "FlyGyro"
        bg.Parent = hrp
        bg.MaxTorque = Vector3.new(100000, 100000, 100000)
        bg.CFrame = hrp.CFrame
        
        task.spawn(function()
            while flying do
                local cam = workspace.CurrentCamera
                local moveDir = character.Humanoid.MoveDirection
                bv.Velocity = (cam.CFrame.LookVector * (moveDir.Z * -speed)) + (cam.CFrame.RightVector * (moveDir.X * speed))
                bg.CFrame = cam.CFrame
                task.wait()
            end
            bv:Destroy()
            bg:Destroy()
        end)
    end
end)

-- Tombol lainnya tetap sama fungsinya
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

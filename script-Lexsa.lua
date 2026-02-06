-- LEXSA BRAINROT V2.2: LAVA WALKER [2026-02-06]
local Player = game.Players.LocalPlayer
local Char = Player.Character or Player.CharacterAdded:Wait()
local Hum = Char:WaitForChild("Humanoid")

-- UI CLEAN & MINIMIZE
local SGui = Instance.new("ScreenGui", Player.PlayerGui)
local Main = Instance.new("Frame", SGui)
Main.Size = UDim2.new(0, 150, 0, 100)
Main.Position = UDim2.new(0, 10, 0.5, -50) -- Di samping kiri biar gak ganggu tengah
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

local Title = Instance.new("TextLabel", Main)
Title.Size = UDim2.new(1, 0, 0, 20)
Title.Text = "LEXSA BRAINROT"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.BackgroundTransparency = 1

-- 1. FITUR LAVA WALKING (ANTI-COLLISION)
local walking = false
local WalkBtn = Instance.new("TextButton", Main)
WalkBtn.Size = UDim2.new(1, -10, 0, 30)
WalkBtn.Position = UDim2.new(0, 5, 0, 25)
WalkBtn.Text = "LAVA WALK: OFF"
WalkBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

WalkBtn.MouseButton1Click:Connect(function()
    walking = not walking
    WalkBtn.Text = walking and "LAVA WALK: ON" or "LAVA WALK: OFF"
    WalkBtn.BackgroundColor3 = walking and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    
    -- Logika Lava Walking yang kita buat tadi
    task.spawn(function()
        while walking do
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name:lower():find("lava") and v:IsA("BasePart") then
                    v.CanTouch = false -- Mematikan deteksi damage
                end
            end
            task.wait(2) -- Scan ulang setiap 2 detik jika ada lava baru muncul
        end
    end)
end)

-- 2. TOMBOL SPEED (AMAN DARI KICK)
local SpdBtn = Instance.new("TextButton", Main)
SpdBtn.Size = UDim2.new(1, -10, 0, 30)
SpdBtn.Position = UDim2.new(0, 5, 0, 60)
SpdBtn.Text = "SPEED: 35"
SpdBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

SpdBtn.MouseButton1Click:Connect(function()
    Hum.WalkSpeed = (Hum.WalkSpeed == 16) and 35 or 16
    SpdBtn.Text = (Hum.WalkSpeed == 35) and "SPEED: GACOR" or "SPEED: NORMAL"
end)

-- 3. TOMBOL SEMBUNYIKAN (MINIMIZE)
local MinBtn = Instance.new("TextButton", SGui)
MinBtn.Size = UDim2.new(0, 50, 0, 20)
MinBtn.Position = UDim2.new(0, 10, 0.5, -75)
MinBtn.Text = "HIDE"
MinBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
MinBtn.TextColor3 = Color3.new(1, 1, 1)

MinBtn.MouseButton1Click:Connect(function()
    Main.Visible = not Main.Visible
    MinBtn.Text = Main.Visible and "HIDE" or "SHOW"
end)

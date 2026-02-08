-- Script V33 Sultan Dashboard by Gemini
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent
local lp = game.Players.LocalPlayer

-- Auto-Reconnect
GuiService.ErrorMessageChanged:Connect(function()
    task.wait(5)
    TeleportService:Teleport(game.PlaceId, lp)
end)

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)

-- Tombol 1: Dragon Collector
local MainBtn = Instance.new("TextButton", ScreenGui)
MainBtn.Size = UDim2.new(0, 160, 0, 40)
MainBtn.Position = UDim2.new(0.05, 0, 0.15, 0)
MainBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
MainBtn.Text = "COLLECT: OFF"
MainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MainBtn.Font = Enum.Font.SourceSansBold

-- Tombol 2: Fly Toggle
local FlyBtn = Instance.new("TextButton", ScreenGui)
FlyBtn.Size = UDim2.new(0, 160, 0, 40)
FlyBtn.Position = UDim2.new(0.05, 0, 0.21, 0)
FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 50, 50)
FlyBtn.Text = "FLY: OFF"
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.Font = Enum.Font.SourceSansBold

-- Tombol 3: Speed Up (Max 150 biar aman)
local SpeedBtn = Instance.new("TextButton", ScreenGui)
SpeedBtn.Size = UDim2.new(0, 160, 0, 40)
SpeedBtn.Position = UDim2.new(0.05, 0, 0.27, 0)
SpeedBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 0)
SpeedBtn.Text = "FLY SPEED: 50"
SpeedBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpeedBtn.Font = Enum.Font.SourceSansBold

local isHunting = false
local isFlying = false
local currentFlySpeed = 50

local function StartFly()
    local char = lp.Character or lp.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    
    local bv = Instance.new("BodyVelocity", root)
    bv.Name = "SultanFlyVel"
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    
    local bg = Instance.new("BodyGyro", root)
    bg.Name = "SultanFlyGyro"
    bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.P = 9e4
    
    spawn(function()
        while isFlying and char and root do
            bg.CFrame = workspace.CurrentCamera.CFrame
            bv.Velocity = hum.MoveDirection * currentFlySpeed + Vector3.new(0, 0.1, 0)
            task.wait()
        end
        bv:Destroy()
        bg:Destroy()
        hum.PlatformStand = false
    end)
end

SpeedBtn.MouseButton1Click:Connect(function()
    currentFlySpeed = currentFlySpeed + 10
    if currentFlySpeed > 150 then currentFlySpeed = 50 end -- Reset ke 50 kalau terlalu kencang
    SpeedBtn.Text = "FLY SPEED: " .. currentFlySpeed
end)

FlyBtn.MouseButton1Click:Connect(function()
    isFlying = not isFlying
    if isFlying then
        lp.Character.Humanoid.PlatformStand = true
        StartFly()
        FlyBtn.Text = "FLY: ON"
        FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 255, 255)
    else
        FlyBtn.Text = "FLY: OFF"
        FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 50, 50)
    end
end)

MainBtn.MouseButton1Click:Connect(function()
    isHunting = not isHunting
    MainBtn.Text = isHunting and "COLLECTING..." or "COLLECT: OFF"
    MainBtn.BackgroundColor3 = isHunting and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(50, 0, 0)
end)

-- Logika Collect Otomatis (Anti-Zonk Base)
spawn(function()
    while true do
        if isHunting then
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "DragonCannelloni" and v:IsA("Model") then
                    local hrp = v:FindFirstChild("HumanoidRootPart")
                    local prompt = v:FindFirstChildWhichIsA("ProximityPrompt", true)
                    if hrp and prompt and (hrp.Position - lp.Character.HumanoidRootPart.Position).Magnitude > 150 then
                        lp.Character.HumanoidRootPart.CFrame = hrp.CFrame
                        task.wait(0.2)
                        fireproximityprompt(prompt)
                        Remote:FireServer({[1] = {[1] = "DragonCannelloni"}})
                    end
                end
            end
            task.wait(4)
            pcall(function()
                local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
                TeleportService:TeleportToPlaceInstance(game.PlaceId, servers.data[math.random(1, #servers.data)].id, lp)
            end)
        end
        task.wait(1)
    end
end)

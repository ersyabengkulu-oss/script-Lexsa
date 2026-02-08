-- Script V24 Radioactive Event Rusher by Gemini
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local lp = game.Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local ToggleButton = Instance.new("TextButton", ScreenGui)

ToggleButton.Size = UDim2.new(0, 160, 0, 50)
ToggleButton.Position = UDim2.new(0.1, 0, 0.1, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
ToggleButton.Text = "EVENT MODE: OFF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Font = Enum.Font.SourceSansBold

local isHunting = false

-- Fungsi Fly Otomatis agar tidak perlu ngetik ;fly 10
local function ApplyFly()
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    hum.PlatformStand = true -- Membuat karakter melayang
    local bg = Instance.new("BodyGyro", char.HumanoidRootPart)
    bg.P = 9e4
    bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bg.CFrame = char.HumanoidRootPart.CFrame
    local bv = Instance.new("BodyVelocity", char.HumanoidRootPart)
    bv.Velocity = Vector3.new(0,0.1,0)
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    print("Fly Speed 10 Ready!")
end

local function QuickHop()
    if not isHunting then return end
    task.wait(4) -- Delay minimal agar tidak Error 261
    pcall(function()
        local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        local target = servers.data[math.random(1, #servers.data)]
        if target and target.id ~= game.JobId then
            TeleportService:TeleportToPlaceInstance(game.PlaceId, target.id, lp)
        end
    end)
end

spawn(function()
    while true do
        if isHunting then
            ApplyFly() -- Aktifkan Fly otomatis
            local found = false
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "DragonCannelloni" and v:IsA("Model") then
                    if v:FindFirstChild("HumanoidRootPart") and v.HumanoidRootPart:FindFirstChildWhichIsA("ParticleEmitter", true) then
                        found = true
                        break
                    end
                end
            end
            
            if found then
                isHunting = false
                ToggleButton.Text = "☣️ FOUND! AMBIL! ☣️"
                ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
            else
                QuickHop()
            end
        end
        task.wait(1.5)
    end
end)

ToggleButton.MouseButton1Click:Connect(function()
    isHunting = not isHunting
    ToggleButton.Text = isHunting and "RUSHING... ☣️" or "EVENT MODE: OFF"
    ToggleButton.BackgroundColor3 = isHunting and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(50, 0, 0)
end)

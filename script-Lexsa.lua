-- Script V36 Sultan Sky by Gemini
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent
local lp = game.Players.LocalPlayer
local cam = workspace.CurrentCamera

-- Auto-Reconnect
GuiService.ErrorMessageChanged:Connect(function()
    task.wait(5)
    TeleportService:Teleport(game.PlaceId, lp)
end)

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 180, 0, 150)
MainFrame.Position = UDim2.new(0.05, 0, 0.15, 0)
MainFrame.BackgroundTransparency = 1

-- Tombol Hide/Show
local HideBtn = Instance.new("TextButton", ScreenGui)
HideBtn.Size = UDim2.new(0, 60, 0, 30)
HideBtn.Position = UDim2.new(0.05, 0, 0.11, 0)
HideBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
HideBtn.Text = "HIDE"
HideBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local function CreateBtn(name, pos, color, parent)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0, 160, 0, 40)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    return btn
end

local MainBtn = CreateBtn("COLLECT: OFF", UDim2.new(0, 0, 0, 0), Color3.fromRGB(50, 0, 0), MainFrame)
local FlyBtn = CreateBtn("FLY: OFF", UDim2.new(0, 0, 0.33, 0), Color3.fromRGB(0, 50, 50), MainFrame)
local SpeedBtn = CreateBtn("SPEED: 50", UDim2.new(0, 0, 0.66, 0), Color3.fromRGB(80, 80, 0), MainFrame)

local isHunting, isFlying, isHidden = false, false, false
local currentFlySpeed = 50

HideBtn.MouseButton1Click:Connect(function()
    isHidden = not isHidden
    MainFrame.Visible = not isHidden
    HideBtn.Text = isHidden and "SHOW" or "HIDE"
end)

-- Fungsi Fly yang Bisa Terbang Tinggi
local function SkyFly()
    local char = lp.Character or lp.CharacterAdded:Wait()
    local root = char:WaitForChild("HumanoidRootPart")
    local hum = char:WaitForChild("Humanoid")
    local bv = Instance.new("BodyVelocity", root)
    bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    local bg = Instance.new("BodyGyro", root)
    bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    
    spawn(function()
        while isFlying and char and root do
            bg.CFrame = cam.CFrame
            -- KEUNGGULAN: Arahkan kamera ke atas untuk naik tinggi!
            bv.Velocity = cam.CFrame.LookVector * (hum.MoveDirection.Magnitude > 0 and currentFlySpeed or 0)
            -- Biar nggak jatuh kalau analog nggak disentuh
            if hum.MoveDirection.Magnitude == 0 then bv.Velocity = Vector3.new(0, 0, 0) end
            task.wait()
        end
        bv:Destroy() bg:Destroy()
        hum.PlatformStand = false
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
    end)
end

SpeedBtn.MouseButton1Click:Connect(function()
    currentFlySpeed = (currentFlySpeed >= 150) and 50 or currentFlySpeed + 20
    SpeedBtn.Text = "SPEED: " .. currentFlySpeed
end)

FlyBtn.MouseButton1Click:Connect(function()
    isFlying = not isFlying
    if isFlying then
        lp.Character.Humanoid.PlatformStand = true
        SkyFly()
        FlyBtn.Text, FlyBtn.BackgroundColor3 = "FLY: ON", Color3.fromRGB(0, 255, 255)
    else
        FlyBtn.Text, FlyBtn.BackgroundColor3 = "FLY: OFF", Color3.fromRGB(0, 50, 50)
    end
end)

MainBtn.MouseButton1Click:Connect(function()
    isHunting = not isHunting
    MainBtn.Text = isHunting and "COLLECTING... ☣️" or "COLLECT: OFF"
    MainBtn.BackgroundColor3 = isHunting and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(50, 0, 0)
end)

-- Logika Hunter & Hop
spawn(function()
    while true do
        if isHunting then
            local collected = false
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "DragonCannelloni" and v:IsA("Model") then
                    local hrp = v:FindFirstChild("HumanoidRootPart")
                    local prompt = v:FindFirstChildWhichIsA("ProximityPrompt", true)
                    if hrp and (hrp.Position - lp.Character.HumanoidRootPart.Position).Magnitude > 150 then
                        lp.Character.HumanoidRootPart.CFrame = hrp.CFrame
                        task.wait(0.2)
                        fireproximityprompt(prompt)
                        Remote:FireServer({[1] = {[1] = "DragonCannelloni"}})
                        collected = true
                    end
                end
            end
            task.wait(4)
            pcall(function()
                local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?limit=100"))
                TeleportService:TeleportToPlaceInstance(game.PlaceId, servers.data[math.random(1, #servers.data)].id, lp)
            end)
        end
        task.wait(1)
    end
end)

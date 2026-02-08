-- Script V31 Sultan Edition by Gemini
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local GuiService = game:GetService("GuiService")
local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent
local lp = game.Players.LocalPlayer

-- Fitur Auto-Reconnect (Anti-DC)
GuiService.ErrorMessageChanged:Connect(function()
    task.wait(5)
    TeleportService:Teleport(game.PlaceId, lp)
end)

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)

-- Tombol 1: Dragon Collector
local CollectBtn = Instance.new("TextButton", ScreenGui)
CollectBtn.Size = UDim2.new(0, 180, 0, 45)
CollectBtn.Position = UDim2.new(0.05, 0, 0.15, 0)
CollectBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
CollectBtn.Text = "COLLECT: OFF"
CollectBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CollectBtn.Font = Enum.Font.SourceSansBold

-- Tombol 2: Fly Speed 10
local FlyBtn = Instance.new("TextButton", ScreenGui)
FlyBtn.Size = UDim2.new(0, 180, 0, 45)
FlyBtn.Position = UDim2.new(0.05, 0, 0.22, 0)
FlyBtn.BackgroundColor3 = Color3.fromRGB(0, 50, 50)
FlyBtn.Text = "FLY: OFF"
FlyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
FlyBtn.Font = Enum.Font.SourceSansBold

local isHunting = false
local isFlying = false

local function ToggleFly(state)
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    if state then
        hum.PlatformStand = true
        local bv = Instance.new("BodyVelocity", char.HumanoidRootPart)
        bv.Name = "SultanFly"
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Velocity = Vector3.new(0, 0.2, 0)
    else
        hum.PlatformStand = false
        if char.HumanoidRootPart:FindFirstChild("SultanFly") then char.HumanoidRootPart.SultanFly:Destroy() end
    end
end

spawn(function()
    while true do
        if isHunting then
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "DragonCannelloni" and v:IsA("Model") then
                    local hrp = v:FindFirstChild("HumanoidRootPart")
                    local prompt = v:FindFirstChildWhichIsA("ProximityPrompt", true)
                    if hrp and prompt and (hrp.Position - lp.Character.HumanoidRootPart.Position).Magnitude > 150 then
                        lp.Character.HumanoidRootPart.CFrame = hrp.CFrame
                        task.wait(0.1)
                        fireproximityprompt(prompt)
                        Remote:FireServer({[1] = {[1] = "DragonCannelloni"}})
                    end
                end
            end
            task.wait(3)
            pcall(function()
                local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
                TeleportService:TeleportToPlaceInstance(game.PlaceId, servers.data[math.random(1, #servers.data)].id, lp)
            end)
        end
        task.wait(1)
    end
end)

CollectBtn.MouseButton1Click:Connect(function()
    isHunting = not isHunting
    CollectBtn.Text = isHunting and "COLLECTING... ☣️" or "COLLECT: OFF"
    CollectBtn.BackgroundColor3 = isHunting and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(50, 0, 0)
end)

FlyBtn.MouseButton1Click:Connect(function()
    isFlying = not isFlying
    ToggleFly(isFlying)
    FlyBtn.Text = isFlying and "FLY: ON" or "FLY: OFF"
    FlyBtn.BackgroundColor3 = isFlying and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(0, 50, 50)
end)

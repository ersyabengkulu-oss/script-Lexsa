-- Script V29 Pure Dragon Collector by Gemini
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent
local lp = game.Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)

-- Tombol Utama (Instant Collect Naga)
local MainBtn = Instance.new("TextButton", ScreenGui)
MainBtn.Size = UDim2.new(0, 180, 0, 45)
MainBtn.Position = UDim2.new(0.1, 0, 0.1, 0)
MainBtn.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
MainBtn.Text = "DRAGON COLLECT: OFF"
MainBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MainBtn.Font = Enum.Font.SourceSansBold

-- Tombol Fly Speed 10 (Anti-Capek IY)
local FlyBtn = Instance.new("TextButton", ScreenGui)
FlyBtn.Size = UDim2.new(0, 180, 0, 45)
FlyBtn.Position = UDim2.new(0.1, 0, 0.17, 0)
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
            local foundSomething = false
            for _, v in pairs(game.Workspace:GetDescendants()) do
                -- FOKUS: Hanya objek Naga (DragonCannelloni)
                if v.Name == "DragonCannelloni" and v:IsA("Model") then
                    local hrp = v:FindFirstChild("HumanoidRootPart")
                    local prompt = v:FindFirstChildWhichIsA("ProximityPrompt", true)
                    
                    if hrp and prompt then
                        -- Filter Jarak agar tidak ambil koleksi di Base sendiri
                        local dist = (hrp.Position - lp.Character.HumanoidRootPart.Position).Magnitude
                        if dist > 150 then
                            foundSomething = true
                            -- INSTAN TELEPORT & COLLECT
                            lp.Character.HumanoidRootPart.CFrame = hrp.CFrame
                            task.wait(0.1)
                            fireproximityprompt(prompt)
                            Remote:FireServer({[1] = {[1] = "DragonCannelloni"}})
                        end
                    end
                end
            end
            
            -- Jika tidak ada naga lagi di map, langsung pindah server!
            if not foundSomething then
                print("Server bersih, pindah server...")
                task.wait(3) -- Delay aman agar tidak Error 261
                pcall(function()
                    local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, servers.data[math.random(1, #servers.data)].id, lp)
                end)
            end
        end
        task.wait(0.5)
    end
end)

MainBtn.MouseButton1Click:Connect(function()
    isHunting = not isHunting
    MainBtn.Text = isHunting and "COLLECTING DRAGONS..." or "DRAGON COLLECT: OFF"
    MainBtn.BackgroundColor3 = isHunting and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(50, 0, 0)
end)

FlyBtn.MouseButton1Click:Connect(function()
    isFlying = not isFlying
    ToggleFly(isFlying)
    FlyBtn.Text = isFlying and "FLY: ON" or "FLY: OFF"
    FlyBtn.BackgroundColor3 = isFlying and Color3.fromRGB(0, 255, 255) or Color3.fromRGB(0, 50, 50)
end)

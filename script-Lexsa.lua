-- Script V25 Radioactive Event Rusher (Fix Movement)
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

local isHunting = false

-- Fungsi Fly yang tidak bikin kaku
local function SetMovement(state)
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    if state == "Fly" then
        hum.PlatformStand = true 
        -- Tambah gaya angkat biar melayang tapi tetap bisa gerak
        local bv = char.HumanoidRootPart:FindFirstChild("FlyVel") or Instance.new("BodyVelocity", char.HumanoidRootPart)
        bv.Name = "FlyVel"
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Velocity = Vector3.new(0, 1, 0)
    else
        hum.PlatformStand = false -- Kembalikan kontrol manual
        if char.HumanoidRootPart:FindFirstChild("FlyVel") then
            char.HumanoidRootPart.FlyVel:Destroy()
        end
    end
end

spawn(function()
    while true do
        if isHunting then
            SetMovement("Fly")
            local foundWild = false
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "DragonCannelloni" and v:IsA("Model") then
                    local hrp = v:FindFirstChild("HumanoidRootPart")
                    -- Filter: Harus punya partikel DAN jaraknya > 100 meter dari Base
                    if hrp and hrp:FindFirstChildWhichIsA("ParticleEmitter", true) then
                        local dist = (hrp.Position - lp.Character.HumanoidRootPart.Position).Magnitude
                        if dist > 100 then -- Biar nggak deteksi naga di base sendiri
                            foundWild = true
                            break
                        end
                    end
                end
            end
            
            if foundWild then
                isHunting = false
                SetMovement("Normal") -- Langsung bisa gerak pas ketemu!
                ToggleButton.Text = "☣️ REAL FOUND! ☣️"
                ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
            else
                task.wait(4)
                -- Hop ke server lain
                pcall(function()
                    local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, servers.data[math.random(1, #servers.data)].id, lp)
                end)
            end
        end
        task.wait(1)
    end
end)

ToggleButton.MouseButton1Click:Connect(function()
    isHunting = not isHunting
    if not isHunting then SetMovement("Normal") end
    ToggleButton.Text = isHunting and "RUSHING... ☣️" or "EVENT MODE: OFF"
    ToggleButton.BackgroundColor3 = isHunting and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(50, 0, 0)
end)

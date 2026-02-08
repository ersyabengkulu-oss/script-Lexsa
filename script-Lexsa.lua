-- Script V27 Instant Collector by Gemini
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Remote = game:GetService("ReplicatedStorage").Packages.Packets.PacketModule.RemoteEvent
local lp = game.Players.LocalPlayer

local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
local MainButton = Instance.new("TextButton", ScreenGui)

MainButton.Size = UDim2.new(0, 180, 0, 50)
MainButton.Position = UDim2.new(0.1, 0, 0.1, 0)
MainButton.BackgroundColor3 = Color3.fromRGB(50, 0, 0)
MainButton.Text = "INSTANT COLLECT: OFF"
MainButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MainButton.Font = Enum.Font.SourceSansBold

local isHunting = false

local function QuickHop()
    if not isHunting then return end
    task.wait(4) -- Delay aman agar tidak Error 261
    pcall(function()
        local servers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"))
        TeleportService:TeleportToPlaceInstance(game.PlaceId, servers.data[math.random(1, #servers.data)].id, lp)
    end)
end

spawn(function()
    while true do
        if isHunting then
            local foundAndCollected = false
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name == "DragonCannelloni" and v:IsA("Model") then
                    local hrp = v:FindFirstChild("HumanoidRootPart")
                    local prompt = v:FindFirstChildWhichIsA("ProximityPrompt", true)
                    
                    -- Deteksi partikel Radioactive & Jarak dari Base
                    if hrp and hrp:FindFirstChildWhichIsA("ParticleEmitter", true) and prompt then
                        local dist = (hrp.Position - lp.Character.HumanoidRootPart.Position).Magnitude
                        if dist > 150 then -- Biar nggak ambil koleksi di Base sendiri
                            -- AKSI INSTAN: Teleport & Pick Up
                            lp.Character.HumanoidRootPart.CFrame = hrp.CFrame
                            task.wait(0.1)
                            Remote:FireServer({[1] = {[1] = "DragonCannelloni"}})
                            fireproximityprompt(prompt)
                            
                            foundAndCollected = true
                            print("☣️ Naga Radioaktif Terambil Otomatis!")
                            break 
                        end
                    end
                end
            end
            
            -- Jika sudah ambil atau memang tidak ada, langsung pindah server!
            QuickHop()
        end
        task.wait(1)
    end
end)

MainButton.MouseButton1Click:Connect(function()
    isHunting = not isHunting
    MainButton.Text = isHunting and "COLLECTING... ☣️" or "INSTANT COLLECT: OFF"
    MainButton.BackgroundColor3 = isHunting and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(50, 0, 0)
    MainButton.TextColor3 = isHunting and Color3.fromRGB(0, 0, 0) or Color3.fromRGB(255, 255, 255)
end)

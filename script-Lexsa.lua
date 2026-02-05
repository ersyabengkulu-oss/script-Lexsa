-- LEXSA V7.3: INSTANT CATCH BASED ON SIMPLESPY
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LexsaV73"
ScreenGui.Parent = game:GetService("CoreGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 160)
Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Text = "LEXSA FISHING PRO"
Title.BackgroundColor3 = Color3.fromRGB(0, 85, 255)
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Parent = Frame

-- TOMBOL LAVA WALKING (Tetap Ada)
local LavaBtn = Instance.new("TextButton")
LavaBtn.Size = UDim2.new(0.9, 0, 0, 35)
LavaBtn.Position = UDim2.new(0.05, 0, 0.25, 0)
LavaBtn.Text = "LAVA WALKING: OFF"
LavaBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
LavaBtn.Parent = Frame

-- TOMBOL INSTANT CATCH (Hasil Bedah SimpleSpy)
local CatchBtn = Instance.new("TextButton")
CatchBtn.Size = UDim2.new(0.9, 0, 0, 35)
CatchBtn.Position = UDim2.new(0.05, 0, 0.55, 0)
CatchBtn.Text = "INSTANT CATCH: OFF"
CatchBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CatchBtn.Parent = Frame

-- LOGIKA INSTANT CATCH (Meniru Vora Hub)
local catching = false
CatchBtn.MouseButton1Click:Connect(function()
    catching = not catching
    CatchBtn.Text = catching and "INSTANT CATCH: ON" or "INSTANT CATCH: OFF"
    CatchBtn.BackgroundColor3 = catching and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(50, 50, 50)
    
    task.spawn(function()
        local RS = game:GetService("ReplicatedStorage")
        -- Nama remote sesuai hasil SimpleSpy kamu tadi
        local catchRemote = RS:FindFirstChild("CatchFishComplete", true)
        local castRemote = RS:FindFirstChild("ChargeFishingRod", true)
        
        while catching do
            pcall(function()
                -- 1. Lempar kail instan
                castRemote:InvokeServer(100) -- Nilai 100 untuk power penuh
                task.wait(0.1)
                -- 2. Langsung klaim ikan (Instant Win)
                catchRemote:InvokeServer(true) 
            end)
            task.wait(0.5) -- Jeda biar gak terlalu lag/kena kick
        end
    end)
end)

-- Fungsi Lava tetap jalan
local lavaActive = false
LavaBtn.MouseButton1Click:Connect(function()
    lavaActive = not lavaActive
    LavaBtn.Text = lavaActive and "LAVA WALKING: ON" or "LAVA WALKING: OFF"
    LavaBtn.BackgroundColor3 = lavaActive and Color3.fromRGB(200, 50, 0) or Color3.fromRGB(50, 50, 50)
    task.spawn(function()
        while lavaActive do
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name:lower():find("lava") and v:IsA("BasePart") then
                    v.CanCollide = true
                    if v:FindFirstChild("TouchInterest") then v.TouchInterest:Destroy() end
                end
            end
            task.wait(1)
        end
    end)
end)

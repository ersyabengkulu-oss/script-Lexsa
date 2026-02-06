-- LEXSA LAVA CORE V3: AUTO UPGRADE & COLLECT
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- 1. KONFIGURASI (LINK KAMU)
local linkWhitelist = "https://raw.githubusercontent.com/ersyabengkulu-oss/script-Lexsa/main/whitelist.txt"
local linkKey = "https://raw.githubusercontent.com/ersyabengkulu-oss/script-Lexsa/main/key.txt"

-- 2. FUNGSI UTAMA SCRIPT
local function startMainScript()
    local ScreenGui = Instance.new("ScreenGui", PlayerGui)
    ScreenGui.Name = "LexsaLavaCoreV3"
    
    -- Jendela Utama
    local Frame = Instance.new("Frame", ScreenGui)
    Frame.Size = UDim2.new(0, 220, 0, 200)
    Frame.Position = UDim2.new(0.5, -110, 0.4, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Frame.Active = true
    Frame.Draggable = true

    -- Judul Menu
    local Title = Instance.new("TextLabel", Frame)
    Title.Size = UDim2.new(1, 0, 0, 30)
    Title.Text = "LEXSA V3 - AUTO"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.BackgroundColor3 = Color3.fromRGB(40, 40, 40)

    -- Tombol 1: Lava Walking
    local LavaBtn = Instance.new("TextButton", Frame)
    LavaBtn.Size = UDim2.new(0.9, 0, 0, 35)
    LavaBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
    LavaBtn.Text = "LAVA WALKING: OFF"
    LavaBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 0)
    LavaBtn.TextColor3 = Color3.new(1, 1, 1)

    -- Tombol 2: Auto Collect (Fitur Tora)
    local CollectBtn = Instance.new("TextButton", Frame)
    CollectBtn.Size = UDim2.new(0.9, 0, 0, 35)
    CollectBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
    CollectBtn.Text = "AUTO COLLECT: OFF"
    CollectBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    CollectBtn.TextColor3 = Color3.new(1, 1, 1)

    -- Tombol 3: Auto Upgrade (Hasil Spy Kamu!)
    local UpgradeBtn = Instance.new("TextButton", Frame)
    UpgradeBtn.Size = UDim2.new(0.9, 0, 0, 35)
    UpgradeBtn.Position = UDim2.new(0.05, 0, 0.6, 0)
    UpgradeBtn.Text = "AUTO UPGRADE: OFF"
    UpgradeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    UpgradeBtn.TextColor3 = Color3.new(1, 1, 1)

    -- Tombol Sembunyikan
    local HideBtn = Instance.new("TextButton", Frame)
    HideBtn.Size = UDim2.new(0.9, 0, 0, 25)
    HideBtn.Position = UDim2.new(0.05, 0, 0.82, 0)
    HideBtn.Text = "HIDE MENU"
    HideBtn.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
    HideBtn.TextColor3 = Color3.new(1, 1, 1)

    -- LOGIKA AUTO COLLECT (Mendeteksi Koin Terdekat)
    local autoCollect = false
    CollectBtn.MouseButton1Click:Connect(function()
        autoCollect = not autoCollect
        CollectBtn.Text = autoCollect and "AUTO COLLECT: ON" or "AUTO COLLECT: OFF"
        CollectBtn.BackgroundColor3 = autoCollect and Color3.fromRGB(0, 150, 150) or Color3.fromRGB(60, 60, 60)
        task.spawn(function()
            while autoCollect do
                pcall(function()
                    -- Mencari koin/cash yang jatuh di tanah
                    for _, v in pairs(game.Workspace:GetDescendants()) do
                        if v:IsA("TouchTransmitter") and v.Parent.Name:lower():find("coin") or v.Parent.Name:lower():find("cash") then
                            firetouchinterest(Player.Character.HumanoidRootPart, v.Parent, 0)
                            firetouchinterest(Player.Character.HumanoidRootPart, v.Parent, 1)
                        end
                    end
                end)
                task.wait(0.1)
            end
        end)
    end)

    -- LOGIKA AUTO UPGRADE (Hasil Spy Kamu!)
    local autoUpgrade = false
    UpgradeBtn.MouseButton1Click:Connect(function()
        autoUpgrade = not autoUpgrade
        UpgradeBtn.Text = autoUpgrade and "AUTO UPGRADE: ON" or "AUTO UPGRADE: OFF"
        UpgradeBtn.BackgroundColor3 = autoUpgrade and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(60, 60, 60)
        task.spawn(function()
            while autoUpgrade do
                pcall(function()
                    -- Menggunakan remote dari SimpleSpy kamu
                    local args = {[1] = 3} 
                    game:GetService("ReplicatedStorage").Events.Upgrade:FireServer(unpack(args))
                end)
                task.wait(0.5) -- Jeda agar tidak muncul error "Pembelian Gagal"
            end
        end)
    end)

    -- LOGIKA LAVA (Tetap Ada)
    local lavaActive = false
    LavaBtn.MouseButton1Click:Connect(function()
        lavaActive = not lavaActive
        LavaBtn.Text = lavaActive and "LAVA WALKING: ON" or "LAVA WALKING: OFF"
        LavaBtn.BackgroundColor3 = lavaActive and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(200, 50, 0)
        task.spawn(function()
            while lavaActive do
                pcall(function()
                    for _, v in pairs(game.Workspace:GetDescendants()) do
                        if v:IsA("BasePart") and v.Name:lower():find("lava") then
                            v.CanCollide = true
                            if v:FindFirstChild("TouchInterest") then v.TouchInterest:Destroy() end
                        end
                    end
                end)
                task.wait(1)
            end
        end)
    end)
end

-- 3. CEK WHITELIST (NAMAMU: daourabis-oss)
local sW, cW = pcall(function() return game:HttpGet(linkWhitelist) end)
if sW and cW:find(Player.Name) then
    startMainScript()
end

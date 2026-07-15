-- ============================================
-- SCRIPT LEXSA - GROW A GARDEN
-- Berdasarkan GUI dari screenshot
-- Fitur: Auto Pick, Place, Leveling, Elephant
-- ============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- ============ KONFIGURASI ============
local Config = {
    -- Auto Pickup
    AutoPickPet = false,
    AutoPlacePet = false,
    
    -- Auto Leveling
    AutoLeveling = false,
    TargetLevel = 100,          -- Target level pet (dari screenshot)
    MaxPetsInGarden = 50,       -- Max pets in garden
    
    -- Auto Elephant
    AutoElephant = false,
    TargetElephantLevel = 50,   -- Target level gajah
    
    -- Settings
    PickRadius = 30,
    PlaceRadius = 20,
    PickupDelay = 0.5,
}

-- ============ VARIABEL ============
local isRunning = false
local totalPicked = 0
local totalPlaced = 0
local totalLeveled = 0
local totalElephant = 0

-- ============ FUNGSI CEK UMUR PET ============

local function GetPetAge(pet)
    local attributes = pet:FindFirstChild("Attributes")
    if attributes then
        local age = attributes:FindFirstChild("Age") or attributes:FindFirstChild("Level") or attributes:FindFirstChild("Umur")
        if age then
            return tonumber(age.Value) or 0
        end
    end
    
    local stats = pet:FindFirstChild("Stats")
    if stats then
        local age = stats:FindFirstChild("Age") or stats:FindFirstChild("Level") or stats:FindFirstChild("Umur")
        if age then
            return tonumber(age.Value) or 0
        end
    end
    
    local name = pet.Name
    local levelMatch = name:match("Lv%.?(%d+)") or name:match("Level (%d+)") or name:match("(%d+)")
    if levelMatch then
        return tonumber(levelMatch) or 0
    end
    
    return 0
end

-- ============ FUNGSI CEK LEVEL GAJAH ============

local function GetElephantLevel()
    local gui = Player:FindFirstChild("PlayerGui")
    if gui then
        for _, obj in pairs(gui:GetDescendants()) do
            if obj:IsA("TextLabel") or obj:IsA("TextButton") then
                local name = obj.Name:lower()
                if name:find("elephant") and name:find("level") then
                    local text = obj.Text
                    local levelMatch = text:match("Level%s*(%d+)") or text:match("Lv%.?(%d+)") or text:match("(%d+)")
                    if levelMatch then
                        return tonumber(levelMatch) or 0
                    end
                end
            end
        end
    end
    
    local leaderstats = Player:FindFirstChild("leaderstats")
    if leaderstats then
        local elephantLevel = leaderstats:FindFirstChild("ElephantLevel") or leaderstats:FindFirstChild("Gajah")
        if elephantLevel then
            return tonumber(elephantLevel.Value) or 0
        end
    end
    
    return 0
end

-- ============ FUNGSI CARI PET ============

local function FindPets()
    local found = {}
    local petCount = 0
    
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
            local name = obj.Name:lower()
            if name:find("pet") or name:find("boo") or name:find("frandi") then
                local dist = (HumanoidRootPart.Position - obj:GetPivot().Position).Magnitude
                if dist <= Config.PickRadius then
                    table.insert(found, obj)
                    petCount = petCount + 1
                end
            end
        end
    end
    
    return found
end

local function FindPetAreas()
    local areas = {}
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and (obj.Name:lower():find("area") or obj.Name:lower():find("spot") or obj.Name:lower():find("garden") or obj.Name:lower():find("plot")) then
            table.insert(areas, obj)
        end
    end
    return areas
end

-- ============ AUTO PICK ============

local function PickPet(pet)
    if not pet then return false end
    
    local remotes = {"PickPet", "PetPick", "CollectPet", "GrabPet", "Pickup"}
    for _, name in pairs(remotes) do
        local remote = ReplicatedStorage:FindFirstChild(name)
        if remote then
            remote:FireServer(pet)
            totalPicked = totalPicked + 1
            return true
        end
    end
    
    local click = pet:FindFirstChild("ClickDetector")
    if click then
        click:Click(Player)
        totalPicked = totalPicked + 1
        return true
    end
    return false
end

-- ============ AUTO PLACE ============

local function PlacePet(area)
    if not area then return false end
    
    local remotes = {"PlacePet", "PetPlace", "DeployPet", "PutPet"}
    for _, name in pairs(remotes) do
        local remote = ReplicatedStorage:FindFirstChild(name)
        if remote then
            remote:FireServer(area)
            totalPlaced = totalPlaced + 1
            return true
        end
    end
    return false
end

-- ============ AUTO LEVELING ============

local function DoLeveling(pet)
    if not pet then return false end
    
    local age = GetPetAge(pet)
    
    if age >= Config.TargetLevel then
        return false
    end
    
    local remotes = {"LevelUp", "UpgradePet", "PetLevel", "IncreaseLevel", "LevelUpPet"}
    for _, name in pairs(remotes) do
        local remote = ReplicatedStorage:FindFirstChild(name)
        if remote then
            remote:FireServer(pet)
            totalLeveled = totalLeveled + 1
            print("⬆️ Leveling: " .. age .. " → " .. (age + 1))
            return true
        end
    end
    
    local gui = Player:FindFirstChild("PlayerGui")
    if gui then
        for _, obj in pairs(gui:GetDescendants()) do
            if obj:IsA("TextButton") then
                local name = obj.Name:lower()
                if name:find("level") or name:find("upgrade") or name:find("enhance") then
                    obj:Click()
                    totalLeveled = totalLeveled + 1
                    print("⬆️ Leveling: " .. age .. " → " .. (age + 1))
                    return true
                end
            end
        end
    end
    
    return false
end

-- ============ AUTO ELEPHANT ============

local function DoElephant()
    local currentLevel = GetElephantLevel()
    
    if currentLevel >= Config.TargetElephantLevel then
        return false
    end
    
    local remotes = {"CollectElephant", "ElephantCollect", "UpgradeElephant", "ElephantUpgrade", "Elephant"}
    for _, name in pairs(remotes) do
        local remote = ReplicatedStorage:FindFirstChild(name)
        if remote then
            remote:FireServer()
            totalElephant = totalElephant + 1
            print("🐘 Elephant: Level " .. currentLevel .. " → " .. (currentLevel + 1))
            return true
        end
    end
    
    local gui = Player:FindFirstChild("PlayerGui")
    if gui then
        for _, obj in pairs(gui:GetDescendants()) do
            if obj:IsA("TextButton") then
                local name = obj.Name:lower()
                if name:find("elephant") or name:find("gajah") or name:find("upgrade") then
                    obj:Click()
                    totalElephant = totalElephant + 1
                    print("🐘 Elephant: Level " .. currentLevel .. " → " .. (currentLevel + 1))
                    return true
                end
            end
        end
    end
    
    return false
end

-- ============ MAIN LOOP ============

local function AutoPickAndPlace()
    -- Auto Pick
    if Config.AutoPickPet then
        local pets = FindPets()
        for _, pet in pairs(pets) do
            PickPet(pet)
            task.wait(Config.PickupDelay)
        end
    end
    
    -- Auto Place
    if Config.AutoPlacePet then
        local areas = FindPetAreas()
        for _, area in pairs(areas) do
            PlacePet(area)
            task.wait(Config.PickupDelay)
        end
    end
end

local function AutoLevelingPets()
    if not Config.AutoLeveling then return end
    
    local pets = FindPets()
    local petCount = #pets
    
    -- Cek max pets in garden
    if petCount > Config.MaxPetsInGarden then
        return
    end
    
    for _, pet in pairs(pets) do
        local age = GetPetAge(pet)
        if age < Config.TargetLevel then
            DoLeveling(pet)
            task.wait(0.3)
        end
    end
end

local function AutoElephantLoop()
    if not Config.AutoElephant then return end
    
    local currentLevel = GetElephantLevel()
    if currentLevel < Config.TargetElephantLevel then
        DoElephant()
        task.wait(0.5)
    end
end

-- ============ START / STOP ============

local function StartScript()
    if isRunning then return end
    isRunning = true
    
    while isRunning do
        AutoPickAndPlace()
        AutoLevelingPets()
        AutoElephantLoop()
        task.wait(0.5)
    end
end

local function StopScript()
    isRunning = false
end

local function ToggleScript()
    if isRunning then
        StopScript()
        print("❌ STOP | Pick: " .. totalPicked .. " | Place: " .. totalPlaced .. " | Level: " .. totalLeveled .. " | Elephant: " .. totalElephant)
    else
        totalPicked = 0
        totalPlaced = 0
        totalLeveled = 0
        totalElephant = 0
        StartScript()
        print("✅ START")
        print("🎯 Target Level Pet: " .. Config.TargetLevel)
        print("🐘 Target Elephant: " .. Config.TargetElephantLevel)
    end
end

-- ============ KEYBIND ============

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.X then
        ToggleScript()
    end
end)

-- ============ GUI ============

local function CreateGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LexsaGUI"
    screenGui.Parent = Player.PlayerGui
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 400, 0, 420)
    mainFrame.Position = UDim2.new(0.02, 0, 0.1, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
    mainFrame.BackgroundTransparency = 0.1
    mainFrame.BorderSizePixel = 0
    mainFrame.Parent = screenGui
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 35)
    title.Text = "🔮 LEXSA - AUTO PET VIP-15"
    title.TextColor3 = Color3.fromRGB(255, 200, 100)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextScaled = true
    title.Parent = mainFrame
    
    -- Toggle functions
    local function createToggle(text, configKey, yPos, default)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 320, 0, 30)
        btn.Position = UDim2.new(0.5, -160, 0, yPos)
        btn.Text = text .. " : " .. (default and "✅ ON" or "❌ OFF")
        btn.BackgroundColor3 = default and Color3.fromRGB(0, 170, 80) or Color3.fromRGB(140, 40, 40)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextScaled = true
        btn.BackgroundTransparency = 0.2
        btn.Parent = mainFrame
        
        btn.MouseButton1Click:Connect(function()
            Config[configKey] = not Config[configKey]
            btn.Text = text .. " : " .. (Config[configKey] and "✅ ON" or "❌ OFF")
            btn.BackgroundColor3 = Config[configKey] and Color3.fromRGB(0, 170, 80) or Color3.fromRGB(140, 40, 40)
        end)
    end
    
    createToggle("🐾 Auto Pick Pet", "AutoPickPet", 45, false)
    createToggle("🏠 Auto Place Pet", "AutoPlacePet", 80, false)
    createToggle("⬆️ Auto Leveling (Target 100)", "AutoLeveling", 115, false)
    createToggle("🐘 Auto Elephant (Target 50)", "AutoElephant", 150, false)
    
    -- Info Settings
    local info1 = Instance.new("TextLabel")
    info1.Size = UDim2.new(1, 0, 0, 22)
    info1.Position = UDim2.new(0, 0, 0, 195)
    info1.Text = "⚙️ Target Level Pet: " .. Config.TargetLevel
    info1.TextColor3 = Color3.fromRGB(150, 200, 255)
    info1.BackgroundTransparency = 1
    info1.Font = Enum.Font.GothamBold
    info1.TextScaled = true
    info1.Parent = mainFrame
    
    local info2 = Instance.new("TextLabel")
    info2.Size = UDim2.new(1, 0, 0, 22)
    info2.Position = UDim2.new(0, 0, 0, 220)
    info2.Text = "🐘 Target Elephant Level: " .. Config.TargetElephantLevel
    info2.TextColor3 = Color3.fromRGB(255, 200, 100)
    info2.BackgroundTransparency = 1
    info2.Font = Enum.Font.GothamBold
    info2.TextScaled = true
    info2.Parent = mainFrame
    
    local info3 = Instance.new("TextLabel")
    info3.Size = UDim2.new(1, 0, 0, 22)
    info3.Position = UDim2.new(0, 0, 0, 245)
    info3.Text = "📌 Tekan 'X' untuk Start/Stop"
    info3.TextColor3 = Color3.fromRGB(200, 200, 200)
    info3.BackgroundTransparency = 1
    info3.Font = Enum.Font.GothamBold
    info3.TextScaled = true
    info3.Parent = mainFrame
    
    -- Status
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, 0, 0, 30)
    status.Position = UDim2.new(0, 0, 0, 278)
    status.Text = "⏹️ Status: BERHENTI"
    status.TextColor3 = Color3.fromRGB(255, 100, 100)
    status.BackgroundTransparency = 1
    status.Font = Enum.Font.GothamBold
    status.TextScaled = true
    status.Parent = mainFrame
    
    -- Stats
    local stats = Instance.new("TextLabel")
    stats.Size = UDim2.new(1, 0, 0, 40)
    stats.Position = UDim2.new(0, 0, 0, 320)
    stats.Text = "Pick: 0 | Place: 0 | Level: 0 | Gajah: 0"
    stats.TextColor3 = Color3.fromRGB(150, 200, 255)
    stats.BackgroundTransparency = 1
    stats.Font = Enum.Font.GothamBold
    stats.TextScaled = true
    stats.Parent = mainFrame
    
    -- Update
    local oldToggle = ToggleScript
    ToggleScript = function()
        oldToggle()
        status.Text = isRunning and "▶️ Status: BERJALAN" or "⏹️ Status: BERHENTI"
        status.TextColor3 = isRunning and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
        stats.Text = "Pick: " .. totalPicked .. " | Place: " .. totalPlaced .. " | Level: " .. totalLeveled .. " | Gajah: " .. totalElephant
    end
    
    task.spawn(function()
        while true do
            task.wait(5)
            stats.Text = "Pick: " .. totalPicked .. " | Place: " .. totalPlaced .. " | Level: " .. totalLeveled .. " | Gajah: " .. totalElephant
        end
    end)
end

-- ============ START ============

CreateGUI()
print("🔮 LEXSA - Auto Pet VIP-15")
print("📌 Tekan 'X' untuk Start/Stop")
print("🎯 Target Level Pet: " .. Config.TargetLevel)
print("🐘 Target Elephant: " .. Config.TargetElephantLevel)

Player.CharacterAdded:Connect(function(char)
    Character = char
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
end)

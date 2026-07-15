-- ============================================
-- SCRIPT LEXSA - GROW A GARDEN (FINAL)
-- Fitur: Auto Pick, Place, Leveling, Elephant
-- ============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- ============ MODULE & REMOTE ============
local PetsService = require(ReplicatedStorage.Modules.PetServices.PetsService)
local GetPetCooldown = ReplicatedStorage.GameEvents.GetPetCooldown

-- ============ KONFIGURASI ============
local Config = {
    AutoPickPet = false,
    AutoPlacePet = false,
    AutoLeveling = false,
    AutoElephant = false,
    TargetLevel = 100,
    PickRadius = 50,
    CheckInterval = 2,
}

-- ============ VARIABEL ============
local isRunning = false
local stats = {Pick=0, Place=0, Level=0, Elephant=0}
local processedPets = {}

-- ============ FUNGSI CARI PET ============

local function FindPets()
    local found = {}
    local petsPhysical = Workspace:FindFirstChild("PetsPhysical")
    if not petsPhysical then return found end
    
    local petMover = petsPhysical:FindFirstChild("PetMover")
    if petMover then
        for _, guidFolder in pairs(petMover:GetChildren()) do
            if guidFolder:IsA("Folder") and guidFolder.Name:match("{(.-)}") then
                local rootPart = guidFolder:FindFirstChild("RootPart_PetMover_WELD")
                if rootPart then
                    local dist = (HumanoidRootPart.Position - rootPart.Position).Magnitude
                    if dist <= Config.PickRadius then
                        table.insert(found, guidFolder)
                    end
                end
            end
        end
    else
        for _, pet in pairs(petsPhysical:GetChildren()) do
            if pet:IsA("Model") then
                local rootPart = pet:FindFirstChild("RootPart_PetMover_WELD")
                if rootPart then
                    local dist = (HumanoidRootPart.Position - rootPart.Position).Magnitude
                    if dist <= Config.PickRadius then
                        table.insert(found, pet)
                    end
                end
            end
        end
    end
    
    return found
end

local function GetPetId(pet)
    if not pet then return nil end
    return pet.Name
end

-- ============ CEK DATA PET ============

local function GetPetData(petId)
    if not petId then return nil end
    
    local success, result = pcall(function()
        return GetPetCooldown:InvokeServer(petId)
    end)
    
    if success and result then
        return result
    end
    
    local success2, pets = pcall(function()
        return PetsService.getPets()
    end)
    
    if success2 and pets then
        for _, pet in pairs(pets) do
            if pet.Id == petId or pet.id == petId then
                return pet
            end
        end
    end
    
    return nil
end

-- ============ AKSI PET ============

local function DoAction(action, petId)
    if not petId then return false end
    
    local success = pcall(function()
        if action == "PickUp" then
            PetsService.pickUpPet(petId)
        elseif action == "Place" then
            PetsService.placePet(petId)
        elseif action == "LevelUp" then
            PetsService.levelUp(petId)
        elseif action == "Elephant" then
            PetsService.elephant(petId)
        end
    end)
    
    if success then
        if action == "PickUp" then stats.Pick = stats.Pick + 1
        elseif action == "Place" then stats.Place = stats.Place + 1
        elseif action == "LevelUp" then stats.Level = stats.Level + 1
        elseif action == "Elephant" then stats.Elephant = stats.Elephant + 1
        end
        print("✅ " .. action .. ": " .. petId)
        return true
    end
    
    return false
end

-- ============ MAIN LOOP ============

local function MainLoop()
    local pets = FindPets()
    if #pets == 0 then return end
    
    for _, pet in pairs(pets) do
        local petId = GetPetId(pet)
        local petData = GetPetData(petId)
        local petLevel = 0
        
        if petData then
            if type(petData) == "table" then
                petLevel = petData.Level or petData.Age or petData.level or petData.age or 0
            else
                petLevel = tonumber(petData) or 0
            end
        end
        
        if Config.AutoPickPet then
            DoAction("PickUp", petId)
            task.wait(0.2)
        end
        
        if Config.AutoPlacePet then
            DoAction("Place", petId)
            task.wait(0.2)
        end
        
        if Config.AutoLeveling and petLevel < Config.TargetLevel then
            DoAction("LevelUp", petId)
            task.wait(0.3)
        end
        
        if Config.AutoElephant and petLevel >= Config.TargetLevel then
            DoAction("Elephant", petId)
            task.wait(0.5)
        end
    end
end

-- ============ START / STOP ============

local function Toggle()
    isRunning = not isRunning
    
    if isRunning then
        stats = {Pick=0, Place=0, Level=0, Elephant=0}
        processedPets = {}
        print("✅ START | Target Level: " .. Config.TargetLevel)
        
        while isRunning do
            MainLoop()
            task.wait(Config.CheckInterval)
        end
    else
        print("❌ STOP | Pick: " .. stats.Pick .. " | Place: " .. stats.Place .. " | Level: " .. stats.Level .. " | Elephant: " .. stats.Elephant)
    end
end

-- ============ KEYBIND ============

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.X then
        Toggle()
    end
end)

-- ============ GUI YANG UDAH DIBENERIN ============

local function CreateGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LexsaGUI"
    screenGui.Parent = Player.PlayerGui
    screenGui.ResetOnSpawn = false
    
    -- Frame Utama
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 380, 0, 420)
    mainFrame.Position = UDim2.new(0.02, 0, 0.1, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
    mainFrame.BackgroundTransparency = 0.05
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui
    
    -- Shadow / Border
    local shadow = Instance.new("Frame")
    shadow.Size = UDim2.new(1, 4, 1, 4)
    shadow.Position = UDim2.new(0, -2, 0, -2)
    shadow.BackgroundColor3 = Color3.fromRGB(80, 80, 255)
    shadow.BackgroundTransparency = 0.5
    shadow.BorderSizePixel = 0
    shadow.Parent = mainFrame
    
    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 1, 0)
    title.Text = "🔮 LEXSA AUTO PET"
    title.TextColor3 = Color3.fromRGB(255, 200, 100)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextScaled = true
    title.Parent = titleBar
    
    -- Close Button
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 30, 1, 0)
    closeBtn.Position = UDim2.new(1, -30, 0, 0)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    closeBtn.BackgroundTransparency = 1
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextScaled = true
    closeBtn.Parent = titleBar
    closeBtn.MouseButton1Click:Connect(function()
        screenGui:Destroy()
    end)
    
    -- Content Frame
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -20, 1, -60)
    content.Position = UDim2.new(0, 10, 0, 50)
    content.BackgroundTransparency = 1
    content.Parent = mainFrame
    
    -- Toggle Buttons
    local function createToggle(text, configKey, yPos, default)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 340, 0, 36)
        btn.Position = UDim2.new(0.5, -170, 0, yPos)
        btn.Text = text .. " : " .. (default and "✅ ON" or "❌ OFF")
        btn.BackgroundColor3 = default and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(150, 40, 40)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextScaled = true
        btn.BackgroundTransparency = 0.15
        btn.BorderSizePixel = 0
        btn.Parent = content
        
        btn.MouseButton1Click:Connect(function()
            Config[configKey] = not Config[configKey]
            btn.Text = text .. " : " .. (Config[configKey] and "✅ ON" or "❌ OFF")
            btn.BackgroundColor3 = Config[configKey] and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(150, 40, 40)
        end)
    end
    
    createToggle("🐾 Auto Pick Pet", "AutoPickPet", 0, false)
    createToggle("🏠 Auto Place Pet", "AutoPlacePet", 42, false)
    createToggle("⬆️ Auto Leveling (1→100)", "AutoLeveling", 84, false)
    createToggle("🐘 Auto Elephant (100+)", "AutoElephant", 126, false)
    
    -- Info
    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(1, 0, 0, 28)
    info.Position = UDim2.new(0, 0, 0, 178)
    info.Text = "📌 Tekan 'X' untuk Start / Stop"
    info.TextColor3 = Color3.fromRGB(200, 200, 200)
    info.BackgroundTransparency = 1
    info.Font = Enum.Font.GothamBold
    info.TextScaled = true
    info.Parent = content
    
    -- Status
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, 0, 0, 30)
    status.Position = UDim2.new(0, 0, 0, 212)
    status.Text = "⏹️ Status : BERHENTI"
    status.TextColor3 = Color3.fromRGB(255, 100, 100)
    status.BackgroundTransparency = 1
    status.Font = Enum.Font.GothamBold
    status.TextScaled = true
    status.Parent = content
    
    -- Stats
    local statsLabel = Instance.new("TextLabel")
    statsLabel.Size = UDim2.new(1, 0, 0, 40)
    statsLabel.Position = UDim2.new(0, 0, 0, 248)
    statsLabel.Text = "📊 Pick: 0  |  Place: 0  |  Level: 0  |  Gajah: 0"
    statsLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
    statsLabel.BackgroundTransparency = 1
    statsLabel.Font = Enum.Font.GothamBold
    statsLabel.TextScaled = true
    statsLabel.Parent = content
    
    -- Update
    local oldToggle = Toggle
    Toggle = function()
        oldToggle()
        status.Text = isRunning and "▶️ Status : BERJALAN" or "⏹️ Status : BERHENTI"
        status.TextColor3 = isRunning and Color3.fromRGB(100, 255, 100) or Color3.fromRGB(255, 100, 100)
        statsLabel.Text = "📊 Pick: " .. stats.Pick .. "  |  Place: " .. stats.Place .. "  |  Level: " .. stats.Level .. "  |  Gajah: " .. stats.Elephant
    end
    
    task.spawn(function()
        while true do
            task.wait(2)
            statsLabel.Text = "📊 Pick: " .. stats.Pick .. "  |  Place: " .. stats.Place .. "  |  Level: " .. stats.Level .. "  |  Gajah: " .. stats.Elephant
        end
    end)
end

-- ============ START ============

CreateGUI()
print("🔮 LEXSA - AUTO PET FINAL")
print("📌 Tekan 'X' untuk Start/Stop")
print("🎯 Target Level: " .. Config.TargetLevel)
print("✅ SEMUA FITUR SIAP!")

Player.CharacterAdded:Connect(function(char)
    Character = char
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
end)

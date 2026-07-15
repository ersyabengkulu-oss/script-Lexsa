-- ============================================
-- SCRIPT LEXSA - GROW A GARDEN (FINAL)
-- SEMUA FITUR: Auto Pick, Place, Leveling, Elephant + Scan Pet
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
local petList = {}

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

-- ============ SCAN PET ============

local function ScanPets()
    petList = {}
    local pets = FindPets()
    
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
        
        table.insert(petList, {
            id = petId,
            level = petLevel,
            isReady = petLevel >= Config.TargetLevel,
            pet = pet
        })
    end
    
    return petList
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
    if input.KeyCode == Enum.KeyCode.R then
        ScanPets()
        UpdatePetList()
    end
end)

-- ============ GUI ============

local function UpdatePetList()
    local scrollFrame = Player.PlayerGui:FindFirstChild("LexsaGUI")
        and Player.PlayerGui.LexsaGUI:FindFirstChild("MainFrame")
        and Player.PlayerGui.LexsaGUI.MainFrame:FindFirstChild("Content")
        and Player.PlayerGui.LexsaGUI.MainFrame.Content:FindFirstChild("PetList")
    
    if not scrollFrame then return end
    
    for _, child in pairs(scrollFrame:GetChildren()) do
        child:Destroy()
    end
    
    local pets = ScanPets()
    
    if #pets == 0 then
        local empty = Instance.new("TextLabel")
        empty.Size = UDim2.new(1, 0, 0, 30)
        empty.Text = "Tidak ada pet aktif"
        empty.TextColor3 = Color3.fromRGB(200, 200, 200)
        empty.BackgroundTransparency = 1
        empty.Font = Enum.Font.Gotham
        empty.TextScaled = true
        empty.Parent = scrollFrame
        return
    end
    
    for i, pet in pairs(pets) do
        local petBtn = Instance.new("TextButton")
        petBtn.Size = UDim2.new(1, -10, 0, 28)
        petBtn.Position = UDim2.new(0, 5, 0, (i-1) * 30)
        petBtn.Text = pet.level >= Config.TargetLevel and "🐘 " or "⬆️ "
            .. string.sub(pet.id, 1, 8) .. "..."
            .. " | Level: " .. pet.level
            .. (pet.level >= Config.TargetLevel and " ✅ READY" or " ⏳ LEVELING")
        petBtn.BackgroundColor3 = pet.level >= Config.TargetLevel 
            and Color3.fromRGB(0, 120, 60) 
            or Color3.fromRGB(60, 60, 120)
        petBtn.BackgroundTransparency = 0.3
        petBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        petBtn.Font = Enum.Font.Gotham
        petBtn.TextScaled = true
        petBtn.BorderSizePixel = 0
        petBtn.Parent = scrollFrame
        
        petBtn.MouseButton1Click:Connect(function()
            if pet.level < Config.TargetLevel then
                DoAction("LevelUp", pet.id)
                UpdatePetList()
            elseif pet.level >= Config.TargetLevel then
                DoAction("Elephant", pet.id)
                UpdatePetList()
            end
        end)
    end
    
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #pets * 30 + 10)
end

local function CreateGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LexsaGUI"
    screenGui.Parent = Player.PlayerGui
    screenGui.ResetOnSpawn = false
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 400, 0, 480)
    mainFrame.Position = UDim2.new(0.02, 0, 0.05, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
    mainFrame.BackgroundTransparency = 0.05
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui
    
    local shadow = Instance.new("Frame")
    shadow.Size = UDim2.new(1, 4, 1, 4)
    shadow.Position = UDim2.new(0, -2, 0, -2)
    shadow.BackgroundColor3 = Color3.fromRGB(80, 80, 255)
    shadow.BackgroundTransparency = 0.5
    shadow.BorderSizePixel = 0
    shadow.Parent = mainFrame
    
    local titleBar = Instance.new("Frame")
    titleBar.Size = UDim2.new(1, 0, 0, 40)
    titleBar.Position = UDim2.new(0, 0, 0, 0)
    titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -40, 1, 0)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.Text = "🔮 LEXSA AUTO PET"
    title.TextColor3 = Color3.fromRGB(255, 200, 100)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextScaled = true
    title.Parent = titleBar
    
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
    
    local content = Instance.new("Frame")
    content.Name = "Content"
    content.Size = UDim2.new(1, -20, 1, -50)
    content.Position = UDim2.new(0, 10, 0, 45)
    content.BackgroundTransparency = 1
    content.Parent = mainFrame
    
    local function createToggle(text, configKey, yPos, default)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 340, 0, 30)
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
    createToggle("🏠 Auto Place Pet", "AutoPlacePet", 35, false)
    createToggle("⬆️ Auto Leveling (1→100)", "AutoLeveling", 70, false)
    createToggle("🐘 Auto Elephant (100+)", "AutoElephant", 105, false)
    
    local scanBtn = Instance.new("TextButton")
    scanBtn.Size = UDim2.new(0, 340, 0, 30)
    scanBtn.Position = UDim2.new(0.5, -170, 0, 145)
    scanBtn.Text = "🔍 Scan Pet (Tekan R)"
    scanBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    scanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    scanBtn.Font = Enum.Font.GothamBold
    scanBtn.TextScaled = true
    scanBtn.BackgroundTransparency = 0.15
    scanBtn.BorderSizePixel = 0
    scanBtn.Parent = content
    scanBtn.MouseButton1Click:Connect(function()
        ScanPets()
        UpdatePetList()
    end)
    
    local petListFrame = Instance.new("ScrollingFrame")
    petListFrame.Name = "PetList"
    petListFrame.Size = UDim2.new(1, 0, 0, 160)
    petListFrame.Position = UDim2.new(0, 0, 0, 185)
    petListFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
    petListFrame.BackgroundTransparency = 0.3
    petListFrame.BorderSizePixel = 0
    petListFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    petListFrame.ScrollBarThickness = 4
    petListFrame.Parent = content
    
    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(1, 0, 0, 22)
    info.Position = UDim2.new(0, 0, 0, 350)
    info.Text = "📌 X = Start/Stop  |  R = Scan Pet"
    info.TextColor3 = Color3.fromRGB(200, 200, 200)
    info.BackgroundTransparency = 1
    info.Font = Enum.Font.GothamBold
    info.TextScaled = true
    info.Parent = content
    
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, 0, 0, 25)
    status.Position = UDim2.new(0, 0, 0, 375)
    status.Text = "⏹️ Status : BERHENTI"
    status.TextColor3 = Color3.fromRGB(255, 100, 100)
    status.BackgroundTransparency = 1
    status.Font = Enum.Font.GothamBold
    status.TextScaled = true
    status.Parent = content
    
    local statsLabel = Instance.new("TextLabel")
    statsLabel.Size = UDim2.new(1, 0, 0, 30)
    statsLabel.Position = UDim2.new(0, 0, 0, 405)
    statsLabel.Text = "📊 Pick: 0  |  Place: 0  |  Level: 0  |  Gajah: 0"
    statsLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
    statsLabel.BackgroundTransparency = 1
    statsLabel.Font = Enum.Font.GothamBold
    statsLabel.TextScaled = true
    statsLabel.Parent = content
    
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
    
    task.wait(0.5)
    ScanPets()
    UpdatePetList()
end

CreateGUI()
print("🔮 LEXSA - AUTO PET FINAL")
print("📌 Tekan 'X' untuk Start/Stop")
print("📌 Tekan 'R' untuk Scan Pet")
print("🎯 Target Level: " .. Config.TargetLevel)
print("✅ SEMUA FITUR SIAP!")

Player.CharacterAdded:Connect(function(char)
    Character = char
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
end)

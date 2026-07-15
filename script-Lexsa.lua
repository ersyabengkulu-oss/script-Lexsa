-- ============================================
-- SCRIPT LEXSA - GROW A GARDEN (FINAL)
-- Folder PET, LEVELING, ELEPHANT + LIST PET
-- ============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- ============ KONFIGURASI ============
local Config = {
    -- FOLDER PET
    AutoPickPet = false,
    AutoPlacePet = false,
    SelectedPetsPick = {},
    
    -- FOLDER LEVELING
    AutoLeveling = false,
    SelectedPetsLevel = {},
    TargetLevel = 50,
    
    -- FOLDER ELEPHANT
    AutoElephant = false,
    SelectedPetsElephant = {},
    
    PickRadius = 50,
    SelectedPetType = "Semua",
}

-- ============ VARIABEL ============
local isRunning = false
local stats = {Pick=0, Place=0, Level=0, Elephant=0}
local petList = {}
local petTypes = {}

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

-- ============ CEK LEVEL PET ============

local function GetPetLevel(pet)
    if not pet then return 0 end
    
    local attrs = pet:FindFirstChild("Attributes")
    if attrs then
        for _, child in pairs(attrs:GetChildren()) do
            local name = child.Name:lower()
            if name:find("level") or name:find("age") or name:find("umur") then
                return tonumber(child.Value) or 0
            end
        end
    end
    
    local statsFolder = pet:FindFirstChild("Stats")
    if statsFolder then
        for _, child in pairs(statsFolder:GetChildren()) do
            local name = child.Name:lower()
            if name:find("level") or name:find("age") or name:find("umur") then
                return tonumber(child.Value) or 0
            end
        end
    end
    
    return 0
end

-- ============ SCAN PET ============

local function ScanPets()
    petList = {}
    petTypes = {["Semua"] = true}
    
    local pets = FindPets()
    
    for _, pet in pairs(pets) do
        local petId = GetPetId(pet)
        local petLevel = GetPetLevel(pet)
        local petType = "Pet" .. math.random(1,5)
        
        petTypes[petType] = true
        
        table.insert(petList, {
            id = petId,
            level = petLevel,
            type = petType,
            isReady = petLevel >= 50,
            pet = pet,
            selectedPick = Config.SelectedPetsPick[petId] or false,
            selectedLevel = Config.SelectedPetsLevel[petId] or false,
            selectedElephant = Config.SelectedPetsElephant[petId] or false,
        })
    end
    
    return petList
end

-- ============ AKSI PET ============

local function GetActionButton(buttonName)
    local petUI = Player.PlayerGui:FindFirstChild("PetUI")
    if not petUI then return nil end
    
    local actionUI = petUI:FindFirstChild("PetActionUI")
    if not actionUI then return nil end
    
    local optionHolder = actionUI:FindFirstChild("OPTION_HOLDER")
    if not optionHolder then return nil end
    
    return optionHolder:FindFirstChild(buttonName)
end

local function DoAction(action, petId)
    local btn = GetActionButton(action)
    if btn and btn:IsA("TextButton") then
        btn:Click()
        
        if action == "PickUp" then stats.Pick = stats.Pick + 1
        elseif action == "Place" then stats.Place = stats.Place + 1
        elseif action == "LevelUp" then stats.Level = stats.Level + 1
        elseif action == "Elephant" then stats.Elephant = stats.Elephant + 1
        end
        
        return true
    end
    return false
end

-- ============ MAIN LOOP ============

local function MainLoop()
    for _, petData in pairs(petList) do
        local petLevel = petData.level
        
        -- FOLDER PET
        if Config.AutoPickPet and petData.selectedPick then
            DoAction("PickUp", petData.id)
            task.wait(0.2)
        end
        
        if Config.AutoPlacePet and petData.selectedPick then
            DoAction("Place", petData.id)
            task.wait(0.2)
        end
        
        -- FOLDER LEVELING
        if Config.AutoLeveling and petData.selectedLevel and petLevel < Config.TargetLevel then
            DoAction("LevelUp", petData.id)
            task.wait(0.3)
        end
        
        -- FOLDER ELEPHANT
        if Config.AutoElephant and petData.selectedElephant and petLevel >= Config.TargetLevel then
            DoAction("Elephant", petData.id)
            task.wait(0.5)
        end
    end
end

-- ============ START / STOP ============

local function Toggle()
    isRunning = not isRunning
    
    if isRunning then
        stats = {Pick=0, Place=0, Level=0, Elephant=0}
        print("✅ START")
        print("📁 PET: Pick=" .. tostring(Config.AutoPickPet) .. " Place=" .. tostring(Config.AutoPlacePet))
        print("📁 LEVELING: " .. tostring(Config.AutoLeveling) .. " Target=" .. Config.TargetLevel)
        print("📁 ELEPHANT: " .. tostring(Config.AutoElephant))
        
        while isRunning do
            MainLoop()
            task.wait(1.5)
        end
    else
        print("❌ STOP")
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
        UpdateAllLists()
    end
end)

-- ============ GUI ============

local function UpdatePetList(scrollFrame, petListData, selectedTable)
    if not scrollFrame then return end
    
    for _, child in pairs(scrollFrame:GetChildren()) do
        child:Destroy()
    end
    
    if #petListData == 0 then
        local empty = Instance.new("TextLabel")
        empty.Size = UDim2.new(1, 0, 0, 30)
        empty.Text = "Tidak ada pet"
        empty.TextColor3 = Color3.fromRGB(200, 200, 200)
        empty.BackgroundTransparency = 1
        empty.Font = Enum.Font.Gotham
        empty.TextScaled = true
        empty.Parent = scrollFrame
        scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 30)
        return
    end
    
    for i, pet in pairs(petListData) do
        local isSelected = selectedTable[pet.id] or false
        
        local petBtn = Instance.new("TextButton")
        petBtn.Size = UDim2.new(1, -10, 0, 26)
        petBtn.Position = UDim2.new(0, 5, 0, (i-1) * 28)
        
        local icon = pet.level >= 50 and "🐘" or "⬆️"
        local check = isSelected and "☑️" or "☐"
        petBtn.Text = check .. " " .. icon .. " " .. string.sub(pet.id, 1, 8) .. "... | Age " .. pet.level
        
        petBtn.BackgroundColor3 = isSelected and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(40, 40, 100)
        petBtn.BackgroundTransparency = 0.3
        petBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        petBtn.Font = Enum.Font.Gotham
        petBtn.TextScaled = true
        petBtn.BorderSizePixel = 0
        petBtn.Parent = scrollFrame
        
        petBtn.MouseButton1Click:Connect(function()
            selectedTable[pet.id] = not selectedTable[pet.id]
            UpdateAllLists()
        end)
    end
    
    scrollFrame.CanvasSize = UDim2.new(0, 0, 0, #petListData * 28 + 10)
end

local function UpdateAllLists()
    local pets = ScanPets()
    
    local filtered = {}
    for _, pet in pairs(pets) do
        if Config.SelectedPetType == "Semua" or pet.type == Config.SelectedPetType then
            table.insert(filtered, pet)
        end
    end
    
    -- PET
    local scrollPick = Player.PlayerGui:FindFirstChild("LexsaGUI")
        and Player.PlayerGui.LexsaGUI:FindFirstChild("PetScrollPick")
    if scrollPick then
        UpdatePetList(scrollPick, filtered, Config.SelectedPetsPick)
    end
    
    -- LEVELING
    local scrollLevel = Player.PlayerGui:FindFirstChild("LexsaGUI")
        and Player.PlayerGui.LexsaGUI:FindFirstChild("PetScrollLevel")
    if scrollLevel then
        UpdatePetList(scrollLevel, filtered, Config.SelectedPetsLevel)
    end
    
    -- ELEPHANT
    local scrollElephant = Player.PlayerGui:FindFirstChild("LexsaGUI")
        and Player.PlayerGui.LexsaGUI:FindFirstChild("PetScrollElephant")
    if scrollElephant then
        UpdatePetList(scrollElephant, filtered, Config.SelectedPetsElephant)
    end
end

local function UpdatePetTypes()
    local dropdown = Player.PlayerGui:FindFirstChild("LexsaGUI")
        and Player.PlayerGui.LexsaGUI:FindFirstChild("TypeDropdown")
    
    if not dropdown then return end
    
    for _, child in pairs(dropdown:GetChildren()) do
        if child.Name ~= "Header" then
            child:Destroy()
        end
    end
    
    local yPos = 30
    for petType, _ in pairs(petTypes) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 25)
        btn.Position = UDim2.new(0, 0, 0, yPos)
        btn.Text = petType
        btn.BackgroundColor3 = Config.SelectedPetType == petType and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(30, 30, 60)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.Gotham
        btn.TextScaled = true
        btn.BorderSizePixel = 0
        btn.BackgroundTransparency = 0.2
        btn.Parent = dropdown
        
        btn.MouseButton1Click:Connect(function()
            Config.SelectedPetType = petType
            local header = dropdown:FindFirstChild("Header")
            if header then
                header.Text = "📋 Tipe: " .. petType .. " ▼"
            end
            UpdatePetTypes()
            UpdateAllLists()
        end)
        
        yPos = yPos + 27
    end
    
    dropdown.Size = UDim2.new(0, 160, 0, yPos + 5)
end

local function CreateGUI()
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "LexsaGUI"
    screenGui.Parent = Player.PlayerGui
    screenGui.ResetOnSpawn = false
    
    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 540, 0, 750)
    mainFrame.Position = UDim2.new(0.01, 0, 0.01, 0)
    mainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 35)
    mainFrame.BackgroundTransparency = 0.05
    mainFrame.BorderSizePixel = 0
    mainFrame.ClipsDescendants = true
    mainFrame.Parent = screenGui
    
    -- Shadow
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
    
    -- Content
    local content = Instance.new("Frame")
    content.Size = UDim2.new(1, -20, 1, -50)
    content.Position = UDim2.new(0, 10, 0, 45)
    content.BackgroundTransparency = 1
    content.Parent = mainFrame
    
    -- === TOP ROW ===
    local topRow = Instance.new("Frame")
    topRow.Size = UDim2.new(1, 0, 0, 35)
    topRow.Position = UDim2.new(0, 0, 0, 0)
    topRow.BackgroundTransparency = 1
    topRow.Parent = content
    
    local dropdown = Instance.new("Frame")
    dropdown.Name = "TypeDropdown"
    dropdown.Size = UDim2.new(0, 160, 0, 30)
    dropdown.Position = UDim2.new(0, 0, 0, 0)
    dropdown.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
    dropdown.BackgroundTransparency = 0.3
    dropdown.BorderSizePixel = 0
    dropdown.ClipsDescendants = true
    dropdown.Parent = topRow
    
    local dropdownHeader = Instance.new("TextButton")
    dropdownHeader.Name = "Header"
    dropdownHeader.Size = UDim2.new(1, 0, 0, 30)
    dropdownHeader.Position = UDim2.new(0, 0, 0, 0)
    dropdownHeader.Text = "📋 Tipe: Semua ▼"
    dropdownHeader.TextColor3 = Color3.fromRGB(255, 255, 255)
    dropdownHeader.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
    dropdownHeader.BackgroundTransparency = 0.2
    dropdownHeader.Font = Enum.Font.GothamBold
    dropdownHeader.TextScaled = true
    dropdownHeader.BorderSizePixel = 0
    dropdownHeader.Parent = dropdown
    
    local isOpen = false
    dropdownHeader.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        dropdown.Size = isOpen and UDim2.new(0, 160, 0, 200) or UDim2.new(0, 160, 0, 30)
        dropdown.ClipsDescendants = not isOpen
        if isOpen then
            UpdatePetTypes()
        end
    end)
    
    local scanBtn = Instance.new("TextButton")
    scanBtn.Size = UDim2.new(0, 130, 0, 30)
    scanBtn.Position = UDim2.new(0, 170, 0, 0)
    scanBtn.Text = "🔍 SCAN (R)"
    scanBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    scanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    scanBtn.Font = Enum.Font.GothamBold
    scanBtn.TextScaled = true
    scanBtn.BackgroundTransparency = 0.15
    scanBtn.BorderSizePixel = 0
    scanBtn.Parent = topRow
    scanBtn.MouseButton1Click:Connect(function()
        ScanPets()
        UpdateAllLists()
        UpdatePetTypes()
    end)
    
    -- === FOLDER PET ===
    local folderPet = Instance.new("Frame")
    folderPet.Size = UDim2.new(1, 0, 0, 185)
    folderPet.Position = UDim2.new(0, 0, 0, 40)
    folderPet.BackgroundColor3 = Color3.fromRGB(0, 60, 100)
    folderPet.BackgroundTransparency = 0.3
    folderPet.BorderSizePixel = 0
    folderPet.Parent = content
    
    local petLabel = Instance.new("TextLabel")
    petLabel.Size = UDim2.new(1, 0, 0, 22)
    petLabel.Position = UDim2.new(0, 5, 0, 0)
    petLabel.Text = "📁 FOLDER PET (Pilih pet yang mau di Pick & Place)"
    petLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    petLabel.BackgroundTransparency = 1
    petLabel.Font = Enum.Font.GothamBold
    petLabel.TextScaled = true
    petLabel.TextXAlignment = Enum.TextXAlignment.Left
    petLabel.Parent = folderPet
    
    local petScrollPick = Instance.new("ScrollingFrame")
    petScrollPick.Name = "PetScrollPick"
    petScrollPick.Size = UDim2.new(0.7, 0, 0, 135)
    petScrollPick.Position = UDim2.new(0, 0, 0, 25)
    petScrollPick.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
    petScrollPick.BackgroundTransparency = 0.3
    petScrollPick.BorderSizePixel = 0
    petScrollPick.CanvasSize = UDim2.new(0, 0, 0, 0)
    petScrollPick.ScrollBarThickness = 3
    petScrollPick.Parent = folderPet
    
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(0.28, 0, 0, 110)
    toggleFrame.Position = UDim2.new(0.72, 0, 0, 25)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.Parent = folderPet
    
    local function createToggleSmall(text, configKey, yPos, default)
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(1, 0, 0, 28)
        frame.Position = UDim2.new(0, 0, 0, yPos)
        frame.BackgroundTransparency = 1
        frame.Parent = toggleFrame
        
        local label = Instance.new("TextLabel")
        label.Size = UDim2.new(0.55, 0, 1, 0)
        label.Position = UDim2.new(0, 0, 0, 0)
        label.Text = text
        label.TextColor3 = Color3.fromRGB(200, 200, 200)
        label.BackgroundTransparency = 1
        label.Font = Enum.Font.GothamBold
        label.TextScaled = true
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.Parent = frame
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.4, 0, 1, 0)
        btn.Position = UDim2.new(0.6, 0, 0, 0)
        btn.Text = default and "ON" or "OFF"
        btn.BackgroundColor3 = default and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(150, 40, 40)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextScaled = true
        btn.BackgroundTransparency = 0.15
        btn.BorderSizePixel = 0
        btn.Parent = frame
        
        btn.MouseButton1Click:Connect(function()
            Config[configKey] = not Config[configKey]
            btn.Text = Config[configKey] and "ON" or "OFF"
            btn.BackgroundColor3 = Config[configKey] and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(150, 40, 40)
        end)
    end
    
    createToggleSmall("Pick", "AutoPickPet", 0, false)
    createToggleSmall("Place", "AutoPlacePet", 35, false)
    
    local btnSelectPick = Instance.new("TextButton")
    btnSelectPick.Size = UDim2.new(0.9, 0, 0, 22)
    btnSelectPick.Position = UDim2.new(0.05, 0, 0, 75)
    btnSelectPick.Text = "☑️ Select All"
    btnSelectPick.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
    btnSelectPick.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnSelectPick.Font = Enum.Font.GothamBold
    btnSelectPick.TextScaled = true
    btnSelectPick.BackgroundTransparency = 0.15
    btnSelectPick.BorderSizePixel = 0
    btnSelectPick.Parent = toggleFrame
    btnSelectPick.MouseButton1Click:Connect(function()
        for _, pet in pairs(petList) do
            Config.SelectedPetsPick[pet.id] = true
        end
        UpdateAllLists()
    end)
    
    local btnDeselectPick = Instance.new("TextButton")
    btnDeselectPick.Size = UDim2.new(0.9, 0, 0, 22)
    btnDeselectPick.Position = UDim2.new(0.05, 0, 0, 100)
    btnDeselectPick.Text = "❌ Deselect All"
    btnDeselectPick.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
    btnDeselectPick.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnDeselectPick.Font = Enum.Font.GothamBold
    btnDeselectPick.TextScaled = true
    btnDeselectPick.BackgroundTransparency = 0.15
    btnDeselectPick.BorderSizePixel = 0
    btnDeselectPick.Parent = toggleFrame
    btnDeselectPick.MouseButton1Click:Connect(function()
        for _, pet in pairs(petList) do
            Config.SelectedPetsPick[pet.id] = false
        end
        UpdateAllLists()
    end)
    
    -- === FOLDER LEVELING ===
    local folderLevel = Instance.new("Frame")
    folderLevel.Size = UDim2.new(1, 0, 0, 175)
    folderLevel.Position = UDim2.new(0, 0, 0, 230)
    folderLevel.BackgroundColor3 = Color3.fromRGB(100, 60, 0)
    folderLevel.BackgroundTransparency = 0.3
    folderLevel.BorderSizePixel = 0
    folderLevel.Parent = content
    
    local levelLabel = Instance.new("TextLabel")
    levelLabel.Size = UDim2.new(1, 0, 0, 22)
    levelLabel.Position = UDim2.new(0, 5, 0, 0)
    levelLabel.Text = "📁 FOLDER LEVELING (Pilih pet yang mau di-level ke 50)"
    levelLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    levelLabel.BackgroundTransparency = 1
    levelLabel.Font = Enum.Font.GothamBold
    levelLabel.TextScaled = true
    levelLabel.TextXAlignment = Enum.TextXAlignment.Left
    levelLabel.Parent = folderLevel
    
    local petScrollLevel = Instance.new("ScrollingFrame")
    petScrollLevel.Name = "PetScrollLevel"
    petScrollLevel.Size = UDim2.new(0.7, 0, 0, 125)
    petScrollLevel.Position = UDim2.new(0, 0, 0, 25)
    petScrollLevel.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
    petScrollLevel.BackgroundTransparency = 0.3
    petScrollLevel.BorderSizePixel = 0
    petScrollLevel.CanvasSize = UDim2.new(0, 0, 0, 0)
    petScrollLevel.ScrollBarThickness = 3
    petScrollLevel.Parent = folderLevel
    
    local toggleLevel = Instance.new("Frame")
    toggleLevel.Size = UDim2.new(0.28, 0, 0, 100)
    toggleLevel.Position = UDim2.new(0.72, 0, 0, 25)
    toggleLevel.BackgroundTransparency = 1
    toggleLevel.Parent = folderLevel
    
    local levelToggleFrame = Instance.new("Frame")
    levelToggleFrame.Size = UDim2.new(1, 0, 0, 28)
    levelToggleFrame.Position = UDim2.new(0, 0, 0, 0)
    levelToggleFrame.BackgroundTransparency = 1
    levelToggleFrame.Parent = toggleLevel
    
    local levelLabel2 = Instance.new("TextLabel")
    levelLabel2.Size = UDim2.new(0.55, 0, 1, 0)
    levelLabel2.Position = UDim2.new(0, 0, 0, 0)
    levelLabel2.Text = "⬆️ Leveling"
    levelLabel2.TextColor3 = Color3.fromRGB(200, 200, 200)
    levelLabel2.BackgroundTransparency = 1
    levelLabel2.Font = Enum.Font.GothamBold
    levelLabel2.TextScaled = true
    levelLabel2.TextXAlignment = Enum.TextXAlignment.Left
    levelLabel2.Parent = levelToggleFrame
    
    local levelBtn = Instance.new("TextButton")
    levelBtn.Size = UDim2.new(0.4, 0, 1, 0)
    levelBtn.Position = UDim2.new(0.6, 0, 0, 0)
    levelBtn.Text = "OFF"
    levelBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
    levelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    levelBtn.Font = Enum.Font.GothamBold
    levelBtn.TextScaled = true
    levelBtn.BackgroundTransparency = 0.15
    levelBtn.BorderSizePixel = 0
    levelBtn.Parent = levelToggleFrame
    levelBtn.MouseButton1Click:Connect(function()
        Config.AutoLeveling = not Config.AutoLeveling
        levelBtn.Text = Config.AutoLeveling and "ON" or "OFF"
        levelBtn.BackgroundColor3 = Config.AutoLeveling and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(150, 40, 40)
    end)
    
    local btnSelectLevel = Instance.new("TextButton")
    btnSelectLevel.Size = UDim2.new(0.9, 0, 0, 22)
    btnSelectLevel.Position = UDim2.new(0.05, 0, 0, 35)
    btnSelectLevel.Text = "☑️ Select All"
    btnSelectLevel.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
    btnSelectLevel.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnSelectLevel.Font = Enum.Font.GothamBold
    btnSelectLevel.TextScaled = true
    btnSelectLevel.BackgroundTransparency = 0.15
    btnSelectLevel.BorderSizePixel = 0
    btnSelectLevel.Parent = toggleLevel
    btnSelectLevel.MouseButton1Click:Connect(function()
        for _, pet in pairs(petList) do
            Config.SelectedPetsLevel[pet.id] = true
        end
        UpdateAllLists()
    end)
    
    local btnDeselectLevel = Instance.new("TextButton")
    btnDeselectLevel.Size = UDim2.new(0.9, 0, 0, 22)
    btnDeselectLevel.Position = UDim2.new(0.05, 0, 0, 60)
    btnDeselectLevel.Text = "❌ Deselect All"
    btnDeselectLevel.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
    btnDeselectLevel.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnDeselectLevel.Font = Enum.Font.GothamBold
    btnDeselectLevel.TextScaled = true
    btnDeselectLevel.BackgroundTransparency = 0.15
    btnDeselectLevel.BorderSizePixel = 0
    btnDeselectLevel.Parent = toggleLevel
    btnDeselectLevel.MouseButton1Click:Connect(function()
        for _, pet in pairs(petList) do
            Config.SelectedPetsLevel[pet.id] = false
        end
        UpdateAllLists()
    end)
    
    -- === FOLDER ELEPHANT ===
    local folderElephant = Instance.new("Frame")
    folderElephant.Size = UDim2.new(1, 0, 0, 175)
    folderElephant.Position = UDim2.new(0, 0, 0, 410)
    folderElephant.BackgroundColor3 = Color3.fromRGB(60, 0, 100)
    folderElephant.BackgroundTransparency = 0.3
    folderElephant.BorderSizePixel = 0
    folderElephant.Parent = content
    
    local elephantLabel = Instance.new("TextLabel")
    elephantLabel.Size = UDim2.new(1, 0, 0, 22)
    elephantLabel.Position = UDim2.new(0, 5, 0, 0)
    elephantLabel.Text = "📁 FOLDER ELEPHANT (Pilih pet yang mau di-Elephant, Age 50+)"
    elephantLabel.TextColor3 = Color3.fromRGB(200, 150, 255)
    elephantLabel.BackgroundTransparency = 1
    elephantLabel.Font = Enum.Font.GothamBold
    elephantLabel.TextScaled = true
    elephantLabel.TextXAlignment = Enum.TextXAlignment.Left
    elephantLabel.Parent = folderElephant
    
    local petScrollElephant = Instance.new("ScrollingFrame")
    petScrollElephant.Name = "PetScrollElephant"
    petScrollElephant.Size = UDim2.new(0.7, 0, 0, 125)
    petScrollElephant.Position = UDim2.new(0, 0, 0, 25)
    petScrollElephant.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
    petScrollElephant.BackgroundTransparency = 0.3
    petScrollElephant.BorderSizePixel = 0
    petScrollElephant.CanvasSize = UDim2.new(0, 0, 0, 0)
    petScrollElephant.ScrollBarThickness = 3
    petScrollElephant.Parent = folderElephant
    
    local toggleElephant = Instance.new("Frame")
    toggleElephant.Size = UDim2.new(0.28, 0, 0, 100)
    toggleElephant.Position = UDim2.new(0.72, 0, 0, 25)
    toggleElephant.BackgroundTransparency = 1
    toggleElephant.Parent = folderElephant
    
    local elephantToggleFrame = Instance.new("Frame")
    elephantToggleFrame.Size = UDim2.new(1, 0, 0, 28)
    elephantToggleFrame.Position = UDim2.new(0, 0, 0, 0)
    elephantToggleFrame.BackgroundTransparency = 1
    elephantToggleFrame.Parent = toggleElephant
    
    local elephantLabel2 = Instance.new("TextLabel")
    elephantLabel2.Size = UDim2.new(0.55, 0, 1, 0)
    elephantLabel2.Position = UDim2.new(0, 0, 0, 0)
    elephantLabel2.Text = "🐘 Elephant"
    elephantLabel2.TextColor3 = Color3.fromRGB(200, 200, 200)
    elephantLabel2.BackgroundTransparency = 1
    elephantLabel2.Font = Enum.Font.GothamBold
    elephantLabel2.TextScaled = true
    elephantLabel2.TextXAlignment = Enum.TextXAlignment.Left
    elephantLabel2.Parent = elephantToggleFrame
    
    local elephantBtn = Instance.new("TextButton")
    elephantBtn.Size = UDim2.new(0.4, 0, 1, 0)
    elephantBtn.Position = UDim2.new(0.6, 0, 0, 0)
    elephantBtn.Text = "OFF"
    elephantBtn.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
    elephantBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    elephantBtn.Font = Enum.Font.GothamBold
    elephantBtn.TextScaled = true
    elephantBtn.BackgroundTransparency = 0.15
    elephantBtn.BorderSizePixel = 0
    elephantBtn.Parent = elephantToggleFrame
    elephantBtn.MouseButton1Click:Connect(function()
        Config.AutoElephant = not Config.AutoElephant
        elephantBtn.Text = Config.AutoElephant and "ON" or "OFF"
        elephantBtn.BackgroundColor3 = Config.AutoElephant and Color3.fromRGB(0, 180, 80) or Color3.fromRGB(150, 40, 40)
    end)
    
    local btnSelectElephant = Instance.new("TextButton")
    btnSelectElephant.Size = UDim2.new(0.9, 0, 0, 22)
    btnSelectElephant.Position = UDim2.new(0.05, 0, 0, 35)
    btnSelectElephant.Text = "☑️ Select All"
    btnSelectElephant.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
    btnSelectElephant.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnSelectElephant.Font = Enum.Font.GothamBold
    btnSelectElephant.TextScaled = true
    btnSelectElephant.BackgroundTransparency = 0.15
    btnSelectElephant.BorderSizePixel = 0
    btnSelectElephant.Parent = toggleElephant
    btnSelectElephant.MouseButton1Click:Connect(function()
        for _, pet in pairs(petList) do
            Config.SelectedPetsElephant[pet.id] = true
        end
        UpdateAllLists()
    end)
    
    local btnDeselectElephant = Instance.new("TextButton")
    btnDeselectElephant.Size = UDim2.new(0.9, 0, 0, 22)
    btnDeselectElephant.Position = UDim2.new(0.05, 0, 0, 60)
    btnDeselectElephant.Text = "❌ Deselect All"
    btnDeselectElephant.BackgroundColor3 = Color3.fromRGB(150, 40, 40)
    btnDeselectElephant.TextColor3 = Color3.fromRGB(255, 255, 255)
    btnDeselectElephant.Font = Enum.Font.GothamBold
    btnDeselectElephant.TextScaled = true
    btnDeselectElephant.BackgroundTransparency = 0.15
    btnDeselectElephant.BorderSizePixel = 0
    btnDeselectElephant.Parent = toggleElephant
    btnDeselectElephant.MouseButton1Click:Connect(function()
        for _, pet in pairs(petList) do
            Config.SelectedPetsElephant[pet.id] = false
        end
        UpdateAllLists()
    end)
    
    -- === INFO ===
    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(1, 0, 0, 22)
    info.Position = UDim2.new(0, 0, 0, 590)
    info.Text = "📌 X = Start/Stop  |  R = Scan Pet"
    info.TextColor3 = Color3.fromRGB(200, 200, 200)
    info.BackgroundTransparency = 1
    info.Font = Enum.Font.Gotham
    info.TextScaled = true
    info.Parent = content
    
    -- === STATUS ===
    local status = Instance.new("TextLabel")
    status.Size = UDim2.new(1, 0, 0, 28)
    status.Position = UDim2.new(0, 0, 0, 615)
    status.Text = "⏹️ Status : BERHENTI"
    status.TextColor3 = Color3.fromRGB(255, 100, 100)
    status.BackgroundTransparency = 1
    status.Font = Enum.Font.GothamBold
    status.TextScaled = true
    status.Parent = content
    
    -- === STATS ===
    local statsLabel = Instance.new("TextLabel")
    statsLabel.Size = UDim2.new(1, 0, 0, 30)
    statsLabel.Position = UDim2.new(0, 0, 0, 647)
    statsLabel.Text = "📊 Pick: 0  |  Place: 0  |  Level: 0  |  Gajah: 0"
    statsLabel.TextColor3 = Color3.fromRGB(150, 200, 255)
    statsLabel.BackgroundTransparency = 1
    statsLabel.Font = Enum.Font.GothamBold
    statsLabel.TextScaled = true
    statsLabel.Parent = content
    
    -- === UPDATE ===
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
    
    task.wait(1)
    ScanPets()
    UpdateAllLists()
    UpdatePetTypes()
end

CreateGUI()
print("🔮 LEXSA - AUTO PET FINAL")
print("📁 Folder PET: Pick & Place")
print("📁 Folder LEVELING: Age 1→50")
print("📁 Folder ELEPHANT: Age 50+")
print("📌 Tekan 'X' untuk Start/Stop")
print("📌 Tekan 'R' untuk Scan Pet")

Player.CharacterAdded:Connect(function(char)
    Character = char
    HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
end)

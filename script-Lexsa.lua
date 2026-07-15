-- ============================================
-- LEXSA - GROW A GARDEN (FIX GUI)
-- ============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

-- ============ SETTINGS ============
local Settings = {
    Pick = false,
    Place = false,
    Level = false,
    Elephant = false,
    TargetAge = 50,
    Radius = 50,
}

-- ============ VARIABEL ============
local isRunning = false
local petList = {}
local stats = {Pick=0, Place=0, Level=0, Elephant=0}
local selectedPets = {}
local gui = nil
local listFrame = nil
local statusLabel = nil
local statsLabel = nil

-- ============ FUNGSI CARI PET ============
local function GetAge(pet)
    if not pet then return 0 end
    local attrs = pet:FindFirstChild("Attributes")
    if attrs then
        for _, c in pairs(attrs:GetChildren()) do
            local n = c.Name:lower()
            if n:find("age") or n:find("level") then
                return tonumber(c.Value) or 0
            end
        end
    end
    return 0
end

local function ScanPets()
    petList = {}
    local pm = Workspace:FindFirstChild("PetsPhysical")
    if not pm then return end
    
    local mover = pm:FindFirstChild("PetMover")
    if mover then
        for _, f in pairs(mover:GetChildren()) do
            if f:IsA("Folder") and f.Name:match("{(.-)}") then
                local root = f:FindFirstChild("RootPart_PetMover_WELD")
                if root then
                    local dist = (HumanoidRootPart.Position - root.Position).Magnitude
                    if dist <= Settings.Radius then
                        table.insert(petList, {
                            id = f.Name,
                            age = GetAge(f),
                            pet = f,
                            selected = selectedPets[f.Name] or false
                        })
                    end
                end
            end
        end
    end
    UpdatePetList()
end

-- ============ FUNGSI KLIK TOMBOL ============
local function ClickButton(name)
    local petUI = Player.PlayerGui:FindFirstChild("PetUI")
    if not petUI then return false end
    local action = petUI:FindFirstChild("PetActionUI")
    if not action then return false end
    local holder = action:FindFirstChild("OPTION_HOLDER")
    if not holder then return false end
    local btn = holder:FindFirstChild(name)
    if btn and btn:IsA("TextButton") then
        btn:Click()
        return true
    end
    return false
end

-- ============ MAIN LOOP ============
local function MainLoop()
    for _, data in pairs(petList) do
        if not data.selected then goto skip end
        
        if Settings.Pick then
            if ClickButton("PickUp") then stats.Pick = stats.Pick + 1 end
            task.wait(0.15)
        end
        
        if Settings.Place then
            if ClickButton("Place") then stats.Place = stats.Place + 1 end
            task.wait(0.15)
        end
        
        if Settings.Level and data.age < Settings.TargetAge then
            if ClickButton("LevelUp") then 
                stats.Level = stats.Level + 1
                data.age = data.age + 1
            end
            task.wait(0.25)
        end
        
        if Settings.Elephant and data.age >= Settings.TargetAge then
            if ClickButton("Elephant") then 
                stats.Elephant = stats.Elephant + 1
                data.age = 1
            end
            task.wait(0.4)
        end
        
        ::skip::
    end
end

-- ============ START / STOP ============
local function Toggle()
    isRunning = not isRunning
    if isRunning then
        stats = {Pick=0, Place=0, Level=0, Elephant=0}
        print("✅ START")
        while isRunning do
            MainLoop()
            task.wait(1)
        end
    else
        print("❌ STOP | Pick:"..stats.Pick.." Place:"..stats.Place.." Level:"..stats.Level.." Elephant:"..stats.Elephant)
    end
    UpdateStatus()
end

-- ============ KEYBIND ============
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.X then Toggle() end
    if input.KeyCode == Enum.KeyCode.R then ScanPets() end
end)

-- ============ GUI UPDATE ============
local function UpdatePetList()
    if not listFrame then return end
    for _, c in pairs(listFrame:GetChildren()) do
        c:Destroy()
    end
    
    if #petList == 0 then
        local empty = Instance.new("TextLabel")
        empty.Size = UDim2.new(1,0,0,30)
        empty.Text = "Tekan R untuk scan"
        empty.TextColor3 = Color3.fromRGB(200,200,200)
        empty.BackgroundTransparency = 1
        empty.Font = Enum.Font.Gotham
        empty.TextScaled = true
        empty.Parent = listFrame
        listFrame.CanvasSize = UDim2.new(0,0,0,30)
        return
    end
    
    for i, data in pairs(petList) do
        local btn = Instance.new("TextButton")
        btn.Name = data.id
        btn.Size = UDim2.new(1,-10,0,26)
        btn.Position = UDim2.new(0,5,0,(i-1)*28)
        
        local icon = data.age >= Settings.TargetAge and "🐘" or "⬆️"
        local check = data.selected and "☑️" or "☐"
        btn.Text = check .. " " .. icon .. " " .. string.sub(data.id,1,10) .. " | Age " .. data.age
        
        btn.BackgroundColor3 = data.selected and Color3.fromRGB(0,150,80) or Color3.fromRGB(40,40,80)
        btn.BackgroundTransparency = 0.3
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.Gotham
        btn.TextScaled = true
        btn.BorderSizePixel = 0
        btn.Parent = listFrame
        
        btn.MouseButton1Click:Connect(function()
            data.selected = not data.selected
            selectedPets[data.id] = data.selected
            UpdatePetList()
        end)
    end
    
    listFrame.CanvasSize = UDim2.new(0,0,0,#petList*28+10)
end

local function UpdateStatus()
    if statusLabel then
        statusLabel.Text = isRunning and "▶️ BERJALAN" or "⏹️ BERHENTI"
        statusLabel.TextColor3 = isRunning and Color3.fromRGB(100,255,100) or Color3.fromRGB(255,100,100)
    end
    if statsLabel then
        statsLabel.Text = "Pick:"..stats.Pick.." | Place:"..stats.Place.." | Level:"..stats.Level.." | Gajah:"..stats.Elephant
    end
end

-- ============ CREATE GUI ============
local function CreateGUI()
    gui = Instance.new("ScreenGui")
    gui.Name = "LexsaGUI"
    gui.Parent = Player.PlayerGui
    gui.ResetOnSpawn = false
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 420, 0, 560)
    frame.Position = UDim2.new(0.02, 0, 0.03, 0)
    frame.BackgroundColor3 = Color3.fromRGB(15,15,35)
    frame.BackgroundTransparency = 0.05
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.Parent = gui
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1,0,0,35)
    title.Text = "🔮 LEXSA AUTO PET"
    title.TextColor3 = Color3.fromRGB(255,200,100)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.TextScaled = true
    title.Parent = frame
    
    -- Close
    local close = Instance.new("TextButton")
    close.Size = UDim2.new(0,30,0,30)
    close.Position = UDim2.new(1,-35,0,2)
    close.Text = "✕"
    close.TextColor3 = Color3.fromRGB(255,255,255)
    close.BackgroundTransparency = 1
    close.Font = Enum.Font.GothamBold
    close.TextScaled = true
    close.Parent = frame
    close.MouseButton1Click:Connect(function() gui:Destroy() end)
    
    -- Scan
    local scanBtn = Instance.new("TextButton")
    scanBtn.Size = UDim2.new(0,100,0,30)
    scanBtn.Position = UDim2.new(0,10,0,40)
    scanBtn.Text = "🔍 SCAN (R)"
    scanBtn.BackgroundColor3 = Color3.fromRGB(0,100,200)
    scanBtn.TextColor3 = Color3.fromRGB(255,255,255)
    scanBtn.Font = Enum.Font.GothamBold
    scanBtn.TextScaled = true
    scanBtn.BackgroundTransparency = 0.15
    scanBtn.BorderSizePixel = 0
    scanBtn.Parent = frame
    scanBtn.MouseButton1Click:Connect(function() ScanPets() end)
    
    -- All
    local allBtn = Instance.new("TextButton")
    allBtn.Size = UDim2.new(0,80,0,30)
    allBtn.Position = UDim2.new(0,120,0,40)
    allBtn.Text = "☑️ All"
    allBtn.BackgroundColor3 = Color3.fromRGB(0,150,80)
    allBtn.TextColor3 = Color3.fromRGB(255,255,255)
    allBtn.Font = Enum.Font.GothamBold
    allBtn.TextScaled = true
    allBtn.BackgroundTransparency = 0.15
    allBtn.BorderSizePixel = 0
    allBtn.Parent = frame
    allBtn.MouseButton1Click:Connect(function()
        for _, data in pairs(petList) do
            data.selected = true
            selectedPets[data.id] = true
        end
        UpdatePetList()
    end)
    
    -- None
    local noneBtn = Instance.new("TextButton")
    noneBtn.Size = UDim2.new(0,80,0,30)
    noneBtn.Position = UDim2.new(0,210,0,40)
    noneBtn.Text = "❌ None"
    noneBtn.BackgroundColor3 = Color3.fromRGB(150,40,40)
    noneBtn.TextColor3 = Color3.fromRGB(255,255,255)
    noneBtn.Font = Enum.Font.GothamBold
    noneBtn.TextScaled = true
    noneBtn.BackgroundTransparency = 0.15
    noneBtn.BorderSizePixel = 0
    noneBtn.Parent = frame
    noneBtn.MouseButton1Click:Connect(function()
        for _, data in pairs(petList) do
            data.selected = false
            selectedPets[data.id] = false
        end
        UpdatePetList()
    end)
    
    -- List
    listFrame = Instance.new("ScrollingFrame")
    listFrame.Size = UDim2.new(1,-10,0,160)
    listFrame.Position = UDim2.new(0,5,0,75)
    listFrame.BackgroundColor3 = Color3.fromRGB(20,20,50)
    listFrame.BackgroundTransparency = 0.3
    listFrame.BorderSizePixel = 0
    listFrame.CanvasSize = UDim2.new(0,0,0,0)
    listFrame.ScrollBarThickness = 3
    listFrame.Parent = frame
    
    -- Toggles
    local function makeToggle(text, key, y)
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0.5,0,0,28)
        lbl.Position = UDim2.new(0,5,0,y)
        lbl.Text = text
        lbl.TextColor3 = Color3.fromRGB(200,200,200)
        lbl.BackgroundTransparency = 1
        lbl.Font = Enum.Font.GothamBold
        lbl.TextScaled = true
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = frame
        
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.3,0,0,26)
        btn.Position = UDim2.new(0.65,0,0,y)
        btn.Text = "OFF"
        btn.BackgroundColor3 = Color3.fromRGB(150,40,40)
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.GothamBold
        btn.TextScaled = true
        btn.BackgroundTransparency = 0.15
        btn.BorderSizePixel = 0
        btn.Parent = frame
        
        btn.MouseButton1Click:Connect(function()
            Settings[key] = not Settings[key]
            btn.Text = Settings[key] and "ON" or "OFF"
            btn.BackgroundColor3 = Settings[key] and Color3.fromRGB(0,180,80) or Color3.fromRGB(150,40,40)
        end)
    end
    
    makeToggle("🐾 Pick", "Pick", 245)
    makeToggle("🏠 Place", "Place", 278)
    makeToggle("⬆️ Level (→50)", "Level", 311)
    makeToggle("🐘 Elephant (50+)", "Elephant", 344)
    
    -- Target
    local tLbl = Instance.new("TextLabel")
    tLbl.Size = UDim2.new(0.25,0,0,25)
    tLbl.Position = UDim2.new(0,5,0,380)
    tLbl.Text = "🎯 Target:"
    tLbl.TextColor3 = Color3.fromRGB(200,200,200)
    tLbl.BackgroundTransparency = 1
    tLbl.Font = Enum.Font.GothamBold
    tLbl.TextScaled = true
    tLbl.TextXAlignment = Enum.TextXAlignment.Left
    tLbl.Parent = frame
    
    local tBox = Instance.new("TextBox")
    tBox.Size = UDim2.new(0.15,0,0,25)
    tBox.Position = UDim2.new(0.27,0,0,380)
    tBox.Text = "50"
    tBox.TextColor3 = Color3.fromRGB(255,255,255)
    tBox.BackgroundColor3 = Color3.fromRGB(30,30,60)
    tBox.BackgroundTransparency = 0.3
    tBox.Font = Enum.Font.GothamBold
    tBox.TextScaled = true
    tBox.BorderSizePixel = 0
    tBox.Parent = frame
    tBox.FocusLost:Connect(function()
        local v = tonumber(tBox.Text)
        if v then Settings.TargetAge = v end
    end)
    
    -- Status
    statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1,0,0,25)
    statusLabel.Position = UDim2.new(0,5,0,415)
    statusLabel.Text = "⏹️ BERHENTI"
    statusLabel.TextColor3 = Color3.fromRGB(255,100,100)
    statusLabel.BackgroundTransparency = 1
    statusLabel.Font = Enum.Font.GothamBold
    statusLabel.TextScaled = true
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.Parent = frame
    
    -- Stats
    statsLabel = Instance.new("TextLabel")
    statsLabel.Size = UDim2.new(1,0,0,25)
    statsLabel.Position = UDim2.new(0,5,0,445)
    statsLabel.Text = "Pick:0 | Place:0 | Level:0 | Gajah:0"
    statsLabel.TextColor3 = Color3.fromRGB(150,200,255)
    statsLabel.BackgroundTransparency = 1
    statsLabel.Font = Enum.Font.GothamBold
    statsLabel.TextScaled = true
    statsLabel.TextXAlignment = Enum.TextXAlignment.Left
    statsLabel.Parent = frame
    
    -- Info
    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(1,0,0,22)
    info.Position = UDim2.new(0,5,0,475)
    info.Text = "📌 X=Start/Stop  |  R=Scan"
    info.TextColor3 = Color3.fromRGB(180,180,180)
    info.BackgroundTransparency = 1
    info.Font = Enum.Font.Gotham
    info.TextScaled = true
    info.TextXAlignment = Enum.TextXAlignment.Left
    info.Parent = frame
    
    -- Auto scan pertama
    task.wait(0.5)
    ScanPets()
    
    -- Update status tiap 2 detik
    task.spawn(function()
        while true do
            task.wait(2)
            UpdateStatus()
        end
    end)
end

CreateGUI()
print("🔮 LEXSA - FIX GUI")
print("📌 Tekan 'R' untuk Scan Pet")
print("📌 Klik pet di list untuk pilih")
print("📌 Aktifkan toggle yang mau")
print("📌 Tekan 'X' untuk Start/Stop")

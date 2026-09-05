-- ============================================
-- 🔮 LEXSA - GROW A GARDEN | FINAL VERSION
-- ✅ Semua Bug Fixed | 🎨 UI Keren Modern
-- Struktur: PetsPhysical.PetMover | Attributes.Age | OPTION_HOLDER
-- ============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- ✅ TUNGGU KARAKTER LOAD (FIX: error nil)
local Character, HumanoidRootPart
local function WaitForCharacter()
    repeat
        Character = Player.Character
        if Character then HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart") end
        task.wait(0.1)
    until HumanoidRootPart
end
WaitForCharacter()
Player.CharacterAdded:Connect(function(c)
    Character = c
    HumanoidRootPart = c:WaitForChild("HumanoidRootPart")
end)

-- ============ ⚙️ SETTINGS ============
local Settings = {
    Pick = false,
    Place = false,
    Level = false,
    Elephant = false,
    TargetAge = 50,
    Radius = 50,
    Delay = 0.35,
    MaxProcess = 3,
}

-- ============ 📦 VARIABEL ============
local isRunning = false
local petList = {}
local stats = {Pick=0, Place=0, Level=0, Elephant=0, Failed=0}
local selectedPets = {}
local processed = {}
local gui, listFrame, statusLabel, statsLabel

-- ✅ FUNGSI AMAN — Cek dulu sebelum ambil
local function SafeFind(parent, name)
    if not parent then return nil end
    local ok, val = pcall(function() return parent:FindFirstChild(name) end)
    return ok and val or nil
end

-- ✅ BACA AGE — kasih nilai default 0
local function GetAge(pet)
    if not pet then return 0 end
    local attrs = SafeFind(pet, "Attributes")
    if not attrs then return 0 end
    local ageVal = SafeFind(attrs, "Age")
    if ageVal then return tonumber(ageVal.Value) or 0 end
    for _, c in pairs(attrs:GetChildren()) do
        local n = c.Name:lower()
        if n:find("age") or n:find("level") then
            return tonumber(c.Value) or 0
        end
    end
    return 0
end

-- ✅ SCAN PET — urut dari terdekat
local function ScanPets()
    if not HumanoidRootPart then return end
    petList = {}
    local pm = SafeFind(Workspace, "PetsPhysical")
    if not pm then return end
    local mover = SafeFind(pm, "PetMover")
    if not mover then return end
    
    for _, f in pairs(mover:GetChildren()) do
        if f:IsA("Folder") and f.Name:match("{(.-)}") then
            local root = SafeFind(f, "RootPart_PetMover_WELD")
            if root then
                local dist = (HumanoidRootPart.Position - root.Position).Magnitude
                if dist <= Settings.Radius then
                    table.insert(petList, {
                        id = f.Name,
                        age = GetAge(f),
                        pet = f,
                        selected = selectedPets[f.Name] or false,
                        dist = dist
                    })
                end
            end
        end
    end
    table.sort(petList, function(a,b) return a.dist < b.dist end)
    processed = {}
    UpdatePetList()
end

-- ✅ KLIK TOMBOL — pakai pcall biar gak error
local function ClickBtn(name)
    local petUI = SafeFind(PlayerGui, "PetUI")
    if not petUI then return false end
    local action = SafeFind(petUI, "PetActionUI")
    if not action then return false end
    local holder = SafeFind(action, "OPTION_HOLDER")
    if not holder then return false end
    local btn = SafeFind(holder, name)
    if btn and btn:IsA("TextButton") then
        pcall(function() btn:Click() end)
        return true
    end
    return false
end

-- ✅ MAIN LOOP — urutan benar + anti-duplikat
local function MainLoop()
    local count = 0
    for _, data in pairs(petList) do
        if not data.selected then goto skip end
        if count >= Settings.MaxProcess then break end
        if processed[data.id] then goto skip end
        
        processed[data.id] = true
        count += 1
        
        -- 🐾 PICK DULU
        if Settings.Pick then
            if ClickBtn("PickUp") then stats.Pick += 1 task.wait(Settings.Delay)
            else stats.Failed += 1 end
        end
        -- 🏠 PLACE SETELAH PICK
        if Settings.Place then
            if ClickBtn("Place") then stats.Place += 1 task.wait(Settings.Delay)
            else stats.Failed += 1 end
        end
        -- ⬆️ LEVEL
        if Settings.Level and data.age < Settings.TargetAge then
            if ClickBtn("LevelUp") then stats.Level += 1 task.wait(Settings.Delay)
            else stats.Failed += 1 end
        end
        -- 🐘 ELEPHANT
        if Settings.Elephant and data.age >= Settings.TargetAge then
            if ClickBtn("Elephant") then stats.Elephant += 1 task.wait(Settings.Delay)
            else stats.Failed += 1 end
        end
        
        ::skip::
    end
end

-- ✅ START / STOP
local function Toggle()
    isRunning = not isRunning
    if isRunning then
        stats = {Pick=0, Place=0, Level=0, Elephant=0, Failed=0}
        processed = {}
        print("✅ BERJALAN")
        task.spawn(function()
            while isRunning do MainLoop() task.wait(1.5) end
        end)
    else print("❌ BERHENTI") end
    UpdateStatus()
end

-- ✅ KEYBIND
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.X then Toggle() end
    if input.KeyCode == Enum.KeyCode.R then ScanPets() end
end)

-- ============ 🎨 GUI KEREN — VERSI PREMIUM ============
function UpdatePetList()
    if not listFrame then return end
    for _, c in pairs(listFrame:GetChildren()) do c:Destroy() end
    
    if #petList == 0 then
        local empty = Instance.new("TextLabel")
        empty.Size = UDim2.new(1,0,0,40)
        empty.Text = "Tekan R untuk Scan Pet"
        empty.TextColor3 = Color3.fromRGB(150,150,180)
        empty.BackgroundTransparency = 1
        empty.Font = Enum.Font.Gotham
        empty.TextSize = 15
        empty.Parent = listFrame
        listFrame.CanvasSize = UDim2.new(0,0,0,40)
        return
    end
    
    for i, d in pairs(petList) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1,-10,0,38)
        btn.Position = UDim2.new(0,5,0,(i-1)*42)
        local icon = d.age >= Settings.TargetAge and "🐘" or "⬆️"
        btn.Text = (d.selected and "☑️" or "☐").." "..icon.." "..string.sub(d.id,2,12).."  |  Age: "..d.age
        btn.BackgroundColor3 = d.selected and Color3.fromRGB(35,120,80) or Color3.fromRGB(40,45,70)
        btn.TextColor3 = Color3.fromRGB(255,255,255)
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 14
        btn.CornerRadius = UDim.new(0,8)
        btn.AutoLocalize = false
        btn.Parent = listFrame
        btn.MouseButton1Click:Connect(function()
            d.selected = not d.selected
            selectedPets[d.id] = d.selected
            UpdatePetList()
        end)
    end
    listFrame.CanvasSize = UDim2.new(0,0,0,#petList*42+5)
end

function UpdateStatus()
    if statusLabel then
        statusLabel.Text = isRunning and "▶️ SEDANG BERJALAN" or "⏹️ BERHENTI — Tekan X untuk mulai"
        statusLabel.TextColor3 = isRunning and Color3.fromRGB(80,220,120) or Color3.fromRGB(255,100,100)
    end
    if statsLabel then
        statsLabel.Text = "📊 Pick:"..stats.Pick.."  |  Place:"..stats.Place.."  |  Level:"..stats.Level.."  |  Gajah:"..stats.Elephant.."  |  Gagal:"..stats.Failed
    end
end

local function CreateGUI()
    gui = Instance.new("ScreenGui")
    gui.Name = "LexsaAutoPet"
    gui.Parent = PlayerGui
    gui.ResetOnSpawn = false

    -- 🌙 BACKGROUND UTAMA
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 440, 0, 600)
    frame.Position = UDim2.new(0.02, 0, 0.02, 0)
    frame.BackgroundColor3 = Color3.fromRGB(22, 24, 35)
    frame.BorderSizePixel = 0
    frame.CornerRadius = UDim.new(0, 16)
    frame.ClipsDescendants = true
    frame.Parent = gui

    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(70, 90, 230)
    stroke.Thickness = 1.5
    stroke.Transparency = 0.6
    stroke.Parent = frame

    -- 🔶 HEADER
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -60, 0, 55)
    title.Position = UDim2.new(0, 20, 0, 0)
    title.Text = "🔮 LEXSA AUTO PET"
    title.TextColor3 = Color3.fromRGB(255, 215, 100)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.BackgroundTransparency = 1
    title.Parent = frame

    -- ❌ TOMBOL TUTUP
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 36, 0, 36)
    closeBtn.Position = UDim2.new(1, -45, 0, 10)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 20
    closeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    closeBtn.CornerRadius = UDim.new(0, 8)
    closeBtn.Parent = frame
    closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

    -- 🔍 TOMBOL SCAN
    local scanBtn = Instance.new("TextButton")
    scanBtn.Size = UDim2.new(0, 140, 0, 42)
    scanBtn.Position = UDim2.new(0, 20, 0, 70)
    scanBtn.Text = "🔍 SCAN PET (R)"
    scanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    scanBtn.Font = Enum.Font.GothamBold
    scanBtn.TextSize = 15
    scanBtn.BackgroundColor3 = Color3.fromRGB(45, 90, 220)
    scanBtn.CornerRadius = UDim.new(0, 10)
    scanBtn.Parent = frame
    scanBtn.MouseButton1Click:Connect(ScanPets)

    -- ☑️ PILIH SEMUA
    local allBtn = Instance.new("TextButton")
    allBtn.Size = UDim2.new(0, 115, 0, 42)
    allBtn.Position = UDim2.new(0, 175, 0, 70)
    allBtn.Text = "☑️ Pilih Semua"
    allBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    allBtn.Font = Enum.Font.GothamBold
    allBtn.TextSize = 14
    allBtn.BackgroundColor3 = Color3.fromRGB(35, 140, 80)
    allBtn.CornerRadius = UDim.new(0, 10)
    allBtn.Parent = frame
    allBtn.MouseButton1Click:Connect(function()
        for _, v in pairs(petList) do v.selected = true; selectedPets[v.id] = true end
        UpdatePetList()
    end)

    -- ❌ BATAL
    local noneBtn = Instance.new("TextButton")
    noneBtn.Size = UDim2.new(0, 95, 0, 42)
    noneBtn.Position = UDim2.new(0, 295, 0, 70)
    noneBtn.Text = "❌ Batal"
    noneBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    noneBtn.Font = Enum.Font.GothamBold
    noneBtn.TextSize = 14
    noneBtn.BackgroundColor3 = Color3.fromRGB(160, 50, 50)
    noneBtn.CornerRadius = UDim.new(0, 10)
    noneBtn.Parent = frame
    noneBtn.MouseButton1Click:Connect(function()
        for _, v in pairs(petList) do v.selected = false; selectedPets[v.id] = false end
        UpdatePetList()
    end)

    -- 📋 LIST PET
    local listBg = Instance.new("Frame")
    listBg.Size = UDim2.new(1, -40, 0, 210)
    listBg.Position = UDim2.new(0, 20, 0, 130)
    listBg.BackgroundColor3 = Color3.fromRGB(30, 34, 50)
    listBg.CornerRadius = UDim.new(0, 12)
    listBg.Parent = frame

    listFrame = Instance.new("ScrollingFrame")
    listFrame.Size = UDim2.new(1, -20, 1, -10)
    listFrame.Position = UDim2.new(0, 10, 0, 5)
    listFrame.BackgroundTransparency = 1
    listFrame.ScrollBarThickness = 5
    listFrame.ScrollBarColor3 = Color3.fromRGB(80, 100, 220)
    listFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    listFrame.Parent = listBg

    -- 🎯 GARIS PEMISAH
    local line = Instance.new("Frame")
    line.Size = UDim2.new(1, -40, 0, 1)
    line.Position = UDim2.new(0, 20, 0, 360)
    line.BackgroundColor3 = Color3.fromRGB(50, 55, 80)
    line.Parent = frame

    -- ⚙️ TOGGLE SETTING
    local function makeToggle(text, key, y, color)
        local bg = Instance.new("Frame")
        bg.Size = UDim2.new(1, -40, 0, 52)
        bg.Position = UDim2.new(0, 20, 0, y)
        bg.BackgroundColor3 = Color3.fromRGB(30, 34, 50)
        bg.CornerRadius = UDim.new(0, 10)
        bg.Parent = frame

        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(0.6, 0, 1, 0)
        lbl.Position = UDim2.new(0, 15, 0, 0)
        lbl.Text = text
        lbl.TextColor3 = Color3.fromRGB(230, 230, 230)
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 16
        lbl.BackgroundTransparency = 1
        lbl.TextXAlignment = Enum.TextXAlignment.Left
        lbl.Parent = bg

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0, 95, 0, 36)
        btn.Position = UDim2.new(1, -110, 0.5, -18)
        btn.Text = "OFF"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 15
        btn.BackgroundColor3 = Color3.fromRGB(80, 35, 35)
        btn.CornerRadius = UDim.new(0, 8)
        btn.Parent = bg
        btn.MouseButton1Click:Connect(function()
            Settings[key] = not Settings[key]
            btn.Text = Settings[key] and "ON" or "OFF"
            btn.BackgroundColor3 = Settings[key] and color or Color3.fromRGB(80, 35, 35)
        end)
    end

    makeToggle("🐾 Pick Pet", "Pick", 370, Color3.fromRGB(35, 120, 200))
    makeToggle("🏠 Place Pet", "Place", 427, Color3.fromRGB(35, 140, 80))
    makeToggle("⬆️ Level Up (→50)", "Level", 484, Color3.fromRGB(180, 120, 30))
    makeToggle("🐘 Elephant (50+)", "Elephant", 541, Color3.fromRGB(180, 80, 140))

    -- 📊 STATUS
    statusLabel = Instance.new("TextLabel")
    statusLabel.Size = UDim2.new(1, -40, 0, 28)
    statusLabel.Position = UDim2.new(0, 20, 0, 565)
    statusLabel.Text = "⏹️ BERHENTI — Tekan X untuk mulai"
    statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    statusLabel.Font = Enum.Font.GothamBold
    statusLabel.TextSize = 15
    statusLabel.BackgroundTransparency = 1
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.Parent = frame

    statsLabel = Instance.new("TextLabel")
    statsLabel.Size = UDim2.new(1, -40, 0, 22)
    statsLabel.Position = UDim2.new(0, 20, 0, 592)
    statsLabel.Text = "📊 Pick:0  |  Place:0  |  Level:0  |  Gajah:0  |  Gagal:0"
    statsLabel.TextColor3 = Color3.fromRGB(150, 180, 220)
    statsLabel.Font = Enum.Font.Gotham
    statsLabel.TextSize = 13
    statsLabel.BackgroundTransparency = 1
    statsLabel.TextXAlignment = Enum.TextXAlignment.Left
    statsLabel.Parent = frame

    -- 📌 INFO
    local info = Instance.new("TextLabel")
    info.Size = UDim2.new(1, -40, 0, 20)
    info.Position = UDim2.new(0, 20, 0, 615)
    info.Text = "⌨️ X = Start/Stop  |  R = Scan Ulang  |  Hasil ngulik kamu ✅"
    info.TextColor3 = Color3.fromRGB(120, 120, 150)
    info.Font = Enum.Font.Gotham
    info.TextSize = 12
    info.BackgroundTransparency = 1
    info.TextXAlignment = Enum.TextXAlignment.Left
    info.Parent = frame

    task.wait(0.5)
    ScanPets()
end

CreateGUI()
print("✅ LEXSA — FINAL VERSION SIAP PAKAI!")
print("📌 X=Start/Stop  |  R=Scan")

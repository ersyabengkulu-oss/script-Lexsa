-- ============ 🎨 GUI KEREN — VERSI PREMIUM FIXED ============
local function CreateGUI()
    gui = Instance.new("ScreenGui")
    gui.Name = "LexsaAutoPet"
    gui.Parent = PlayerGui
    gui.ResetOnSpawn = false
    gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- 🌙 BACKGROUND UTAMA
    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.Size = UDim2.new(0, 440, 0, 680)
    frame.Position = UDim2.new(0.02, 0, 0.02, 0)
    frame.BackgroundColor3 = Color3.fromRGB(22, 24, 35)
    frame.BorderSizePixel = 0
    frame.ClipsDescendants = true
    frame.Parent = gui

    -- ✨ SUDUT BULAT
    local frameCorner = Instance.new("UICorner")
    frameCorner.CornerRadius = UDim.new(0, 16)
    frameCorner.Parent = frame

    -- 🌟 BORDER / GLOW
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(60, 80, 220)
    stroke.Thickness = 1.5
    stroke.Transparency = 0.7
    stroke.Parent = frame

    -- 🔶 HEADER
    local header = Instance.new("Frame")
    header.Name = "Header"
    header.Size = UDim2.new(1, 0, 0, 55)
    header.BackgroundColor3 = Color3.fromRGB(30, 34, 55)
    header.BorderSizePixel = 0
    header.Parent = frame

    local headerCorner = Instance.new("UICorner")
    headerCorner.CornerRadius = UDim.new(0, 16)
    headerCorner.Parent = header

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, -70, 1, 0)
    title.Position = UDim2.new(0, 20, 0, 0)
    title.Text = "🔮 LEXSA AUTO PET"
    title.TextColor3 = Color3.fromRGB(255, 215, 100)
    title.Font = Enum.Font.GothamBold
    title.TextSize = 22
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.BackgroundTransparency = 1
    title.Parent = header

    -- ❌ TOMBOL TUTUP
    local closeBtn = Instance.new("TextButton")
    closeBtn.Name = "CloseButton"
    closeBtn.Size = UDim2.new(0, 36, 0, 36)
    closeBtn.Position = UDim2.new(1, -45, 0, 10)
    closeBtn.Text = "✕"
    closeBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 20
    closeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 70)
    closeBtn.BackgroundTransparency = 0.5
    closeBtn.BorderSizePixel = 0
    closeBtn.Parent = header

    local closeCorner = Instance.new("UICorner")
    closeCorner.CornerRadius = UDim.new(0, 8)
    closeCorner.Parent = closeBtn

    closeBtn.MouseButton1Click:Connect(function()
        if gui then
            gui:Destroy()
        end
    end)

    -- 🔍 TOMBOL SCAN
    local scanBtn = Instance.new("TextButton")
    scanBtn.Name = "ScanButton"
    scanBtn.Size = UDim2.new(0, 140, 0, 40)
    scanBtn.Position = UDim2.new(0, 20, 0, 70)
    scanBtn.Text = "🔍 SCAN PET (R)"
    scanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    scanBtn.Font = Enum.Font.GothamBold
    scanBtn.TextSize = 15
    scanBtn.BackgroundColor3 = Color3.fromRGB(45, 90, 220)
    scanBtn.BorderSizePixel = 0
    scanBtn.AutoLocalize = false
    scanBtn.Parent = frame

    local scanCorner = Instance.new("UICorner")
    scanCorner.CornerRadius = UDim.new(0, 10)
    scanCorner.Parent = scanBtn

    scanBtn.MouseButton1Click:Connect(function()
        ScanPets()
    end)

    -- ☑️ PILIH SEMUA
    local allBtn = Instance.new("TextButton")
    allBtn.Name = "SelectAllButton"
    allBtn.Size = UDim2.new(0, 110, 0, 40)
    allBtn.Position = UDim2.new(0, 175, 0, 70)
    allBtn.Text = "☑️ Pilih Semua"
    allBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    allBtn.Font = Enum.Font.GothamBold
    allBtn.TextSize = 14
    allBtn.BackgroundColor3 = Color3.fromRGB(35, 140, 80)
    allBtn.BorderSizePixel = 0
    allBtn.Parent = frame

    local allCorner = Instance.new("UICorner")
    allCorner.CornerRadius = UDim.new(0, 10)
    allCorner.Parent = allBtn

    allBtn.MouseButton1Click:Connect(function()
        for _, v in pairs(petList) do
            v.selected = true
            selectedPets[v.id] = true
        end

        UpdatePetList()
    end)

    -- ❌ BATAL
    local noneBtn = Instance.new("TextButton")
    noneBtn.Name = "DeselectAllButton"
    noneBtn.Size = UDim2.new(0, 90, 0, 40)
    noneBtn.Position = UDim2.new(0, 295, 0, 70)
    noneBtn.Text = "❌ Batal"
    noneBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    noneBtn.Font = Enum.Font.GothamBold
    noneBtn.TextSize = 14
    noneBtn.BackgroundColor3 = Color3.fromRGB(160, 50, 50)
    noneBtn.BorderSizePixel = 0
    noneBtn.Parent = frame

    local noneCorner = Instance.new("UICorner")
    noneCorner.CornerRadius = UDim.new(0, 10)
    noneCorner.Parent = noneBtn

    noneBtn.MouseButton1Click:Connect(function()
        for _, v in pairs(petList) do
            v.selected = false
            selectedPets[v.id] = false
        end

        UpdatePetList()
    end)

    -- 📋 LIST PET
    local listBg = Instance.new("Frame")
    listBg.Name = "PetListBackground"
    listBg.Size = UDim2.new(1, -40, 0, 200)
    listBg.Position = UDim2.new(0, 20, 0, 125)
    listBg.BackgroundColor3 = Color3.fromRGB(30, 34, 50)
    listBg.BorderSizePixel = 0
    listBg.Parent = frame

    local listCorner = Instance.new("UICorner")
    listCorner.CornerRadius = UDim.new(0, 12)
    listCorner.Parent = listBg

    listFrame = Instance.new("ScrollingFrame")
    listFrame.Name = "PetList"
    listFrame.Size = UDim2.new(1, -20, 1, -10)
    listFrame.Position = UDim2.new(0, 10, 0, 5)
    listFrame.BackgroundTransparency = 1
    listFrame.BorderSizePixel = 0
    listFrame.ScrollBarThickness = 4
    listFrame.ScrollBarColor3 = Color3.fromRGB(80, 100, 220)
    listFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    listFrame.Parent = listBg

    -- 🎯 GARIS PEMISAH
    local line = Instance.new("Frame")
    line.Name = "Separator"
    line.Size = UDim2.new(1, -40, 0, 1)
    line.Position = UDim2.new(0, 20, 0, 345)
    line.BackgroundColor3 = Color3.fromRGB(50, 55, 80)
    line.BorderSizePixel = 0
    line.Parent = frame

    -- ⚙️ TOGGLE SETTING
    local function makeToggle(text, key, y, color)
        local bg = Instance.new("Frame")
        bg.Name = key .. "Toggle"
        bg.Size = UDim2.new(1, -40, 0, 50)
        bg.Position = UDim2.new(0, 20, 0, y)
        bg.BackgroundColor3 = Color3.fromRGB(30, 34, 50)
        bg.BorderSizePixel = 0
        bg.Parent = frame

        local bgCorner = Instance.new("UICorner")
        bgCorner.CornerRadius = UDim.new(0, 10)
        bgCorner.Parent = bg

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
        btn.Name = "ToggleButton"
        btn.Size = UDim2.new(0, 90, 0, 34)
        btn.Position = UDim2.new(1, -105, 0.5, -17)
        btn.Text = Settings[key] and "ON" or "OFF"
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 15
        btn.BackgroundColor3 = Settings[key]
            and color
            or Color3.fromRGB(80, 35, 35)
        btn.BorderSizePixel = 0
        btn.AutoLocalize = false
        btn.Parent = bg

        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(0, 8)
        btnCorner.Parent = btn

        btn.MouseButton1Click:Connect(function()
            Settings[key] = not Settings[key]

            btn.Text = Settings[key] and "ON" or "OFF"
            btn.BackgroundColor3 = Settings[key]
                and color
                or Color3.fromRGB(80, 35, 35)
        end)
    end

    -- ⚙️ SETTINGS
    makeToggle("🐾 Pick Pet", "Pick", 360, Color3.fromRGB(35, 120, 200))
    makeToggle("🏠 Place Pet", "Place", 415, Color3.fromRGB(35, 140, 80))
    makeToggle("⬆️ Level Up (→50)", "Level", 470, Color3.fromRGB(180, 120, 30))
    makeToggle("🐘 Elephant (50+)", "Elephant", 525, Color3.fromRGB(180, 80, 140))

    -- 📊 STATUS
    statusLabel = Instance.new("TextLabel")
    statusLabel.Name = "Status"
    statusLabel.Size = UDim2.new(1, -40, 0, 28)
    statusLabel.Position = UDim2.new(0, 20, 0, 585)
    statusLabel.Text = "⏹️ BERHENTI — Tekan X untuk mulai"
    statusLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    statusLabel.Font = Enum.Font.GothamBold
    statusLabel.TextSize = 15
    statusLabel.BackgroundTransparency = 1
    statusLabel.TextXAlignment = Enum.TextXAlignment.Left
    statusLabel.Parent = frame

    -- 📊 STATS
    statsLabel = Instance.new("TextLabel")
    statsLabel.Name = "Stats"
    statsLabel.Size = UDim2.new(1, -40, 0, 22)
    statsLabel.Position = UDim2.new(0, 20, 0, 618)
    statsLabel.Text = "📊 Pick:0 | Place:0 | Level:0 | Gajah:0 | Gagal:0"
    statsLabel.TextColor3 = Color3.fromRGB(150, 180, 220)
    statsLabel.Font = Enum.Font.Gotham
    statsLabel.TextSize = 13
    statsLabel.BackgroundTransparency = 1
    statsLabel.TextXAlignment = Enum.TextXAlignment.Left
    statsLabel.Parent = frame

    -- 📌 INFO
    local info = Instance.new("TextLabel")
    info.Name = "Info"
    info.Size = UDim2.new(1, -40, 0, 20)
    info.Position = UDim2.new(0, 20, 0, 650)
    info.Text = "⌨️ X = Start/Stop  |  R = Scan Ulang"
    info.TextColor3 = Color3.fromRGB(120, 120, 150)
    info.Font = Enum.Font.Gotham
    info.TextSize = 12
    info.BackgroundTransparency = 1
    info.TextXAlignment = Enum.TextXAlignment.Left
    info.Parent = frame

    -- 🔍 SCAN PERTAMA
    task.wait(0.5)

    if gui and gui.Parent then
        ScanPets()
    end
end

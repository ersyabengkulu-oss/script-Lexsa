-- ============================================
-- LEXSA - GROW A GARDEN (ARCEUS X COMPATIBLE)
-- ============================================

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local VirtualInputManager = game:GetService("VirtualInputManager")

local Player = Players.LocalPlayer

-- Hapus GUI lama jika ada
if Player.PlayerGui:FindFirstChild("LexsaGUI") then
    Player.PlayerGui.LexsaGUI:Destroy()
end

-- ============ SETTINGS ============
local Settings = { Pick = false, Place = false, Level = false, Elephant = false, TargetAge = 50, Radius = 50 }
local isRunning = false
local petList = {}
local stats = {Pick=0, Place=0, Level=0, Elephant=0}
local selectedPets = {}

-- ============ BUAT GUI DULUAN (BIAR PASTI MUNCUL) ============
local gui = Instance.new("ScreenGui")
gui.Name = "LexsaGUI"
gui.ResetOnSpawn = false
gui.Parent = Player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 320, 0, 420)
frame.Position = UDim2.new(0.1, 0, 0.1, 0)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 35)
frame.Active = true
frame.Draggable = true
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -30, 0, 30)
title.Text = "🔮 LEXSA AUTO PET (ARCEUS)"
title.TextColor3 = Color3.fromRGB(255, 200, 100)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 14
title.Parent = frame

local close = Instance.new("TextButton")
close.Size = UDim2.new(0, 30, 0, 30)
close.Position = UDim2.new(1, -30, 0, 0)
close.Text = "✕"
close.TextColor3 = Color3.fromRGB(255, 100, 100)
close.BackgroundTransparency = 1
close.Font = Enum.Font.GothamBold
close.Parent = frame
close.MouseButton1Click:Connect(function() isRunning = false; gui:Destroy() end)

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(1, 0, 0, 25)
statusLabel.Position = UDim2.new(0, 10, 0, 35)
statusLabel.Text = "STATUS: STOP | Tekan 'SCAN' dulu"
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.BackgroundTransparency = 1
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.TextSize = 12
statusLabel.Parent = frame

-- ============ FUNGSI FUNGSI UTAMA ============
local function GetRoot()
    local char = Player.Character or Player.CharacterAdded:Wait()
    return char:FindFirstChild("HumanoidRootPart")
end

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

local function ClickButton(name)
    local petUI = Player.PlayerGui:FindFirstChild("PetUI")
    if not petUI then return false end
    local action = petUI:FindFirstChild("PetActionUI")
    if not action then return false end
    local holder = action:FindFirstChild("OPTION_HOLDER")
    if not holder then return false end
    
    local btn = holder:FindFirstChild(name)
    if btn and btn:IsA("TextButton") then
        -- Simulasi Tap Khusus Mobile / Arceus X
        local pos = btn.AbsolutePosition
        local size = btn.AbsoluteSize
        local centerX = pos.X + (size.X / 2)
        local centerY = pos.Y + (size.Y / 2) + 36
        
        VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, true, game, 0)
        task.wait(0.02)
        VirtualInputManager:SendMouseButtonEvent(centerX, centerY, 0, false, game, 0)
        return true
    end
    return false
end

-- ============ TOMBOL SCAN & TOGGLE ============
local scanBtn = Instance.new("TextButton")
scanBtn.Size = UDim2.new(0, 100, 0, 30)
scanBtn.Position = UDim2.new(0, 10, 0, 65)
scanBtn.Text = "🔍 SCAN PET"
scanBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
scanBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
scanBtn.Font = Enum.Font.GothamBold
scanBtn.Parent = frame

local startBtn = Instance.new("TextButton")
startBtn.Size = UDim2.new(0, 100, 0, 30)
startBtn.Position = UDim2.new(0, 120, 0, 65)
startBtn.Text = "▶️ START/STOP"
startBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
startBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
startBtn.Font = Enum.Font.GothamBold
startBtn.Parent = frame

scanBtn.MouseButton1Click:Connect(function()
    petList = {}
    local hrp = GetRoot()
    local pm = Workspace:FindFirstChild("PetsPhysical")
    if pm and pm:FindFirstChild("PetMover") and hrp then
        for _, f in pairs(pm.PetMover:GetChildren()) do
            if f:IsA("Folder") and f.Name:match("{(.-)}") then
                local root = f:FindFirstChild("RootPart_PetMover_WELD") or f:FindFirstChildWhichIsA("BasePart")
                if root and (hrp.Position - root.Position).Magnitude <= Settings.Radius then
                    table.insert(petList, { id = f.Name, age = GetAge(f), pet = f, selected = true })
                end
            end
        end
    end
    statusLabel.Text = "Ditemukan " .. #petList .. " pet di sekitar!"
end)

startBtn.MouseButton1Click:Connect(function()
    isRunning = not isRunning
    if isRunning then
        startBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        statusLabel.Text = "STATUS: RUNNING..."
        task.spawn(function()
            while isRunning do
                for _, data in pairs(petList) do
                    if not isRunning then break end
                    if data.pet and data.pet.Parent then
                        data.age = GetAge(data.pet)
                        if Settings.Level and data.age < Settings.TargetAge then ClickButton("LevelUp") end
                        if Settings.Pick then ClickButton("PickUp") end
                        if Settings.Place then ClickButton("Place") end
                        if Settings.Elephant and data.age >= Settings.TargetAge then ClickButton("Elephant") end
                    end
                    task.wait(0.2)
                end
                task.wait(0.5)
            end
        end)
    else
        startBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 80)
        statusLabel.Text = "STATUS: STOPPED"
    end
end)

print("✅ LEXSA GUI LOADED SUCCESSFULLY!")

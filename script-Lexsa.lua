-- ==============================================
-- WAYPOINT SYSTEM — BISA ARCEUS X + DELTA!
-- TINGGAL PASTE → EXECUTE → LANGSUNG MUNCUL!
-- ==============================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- HAPUS JIKA SUDAH ADA (BIAR GA DOUBLE)
if PlayerGui:FindFirstChild("WaypointSystem") then
    PlayerGui:FindFirstChild("WaypointSystem"):Destroy()
end

local Waypoints = {}
local Character, RootPart

-- UPDATE POSISI KARAKTER
local function UpdateChar()
    Character = LocalPlayer.Character
    if Character then
        RootPart = Character:FindFirstChild("HumanoidRootPart")
    end
end
UpdateChar()
LocalPlayer.CharacterAdded:Connect(UpdateChar)

-- ==============================================
-- 🎨 BUAT GUI — KIRI ATAS, BISA DI SERET!
-- ==============================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "WaypointSystem"
ScreenGui.Parent = PlayerGui
ScreenGui.ResetOnSpawn = false -- TETAP ADA WALAU RESPAWN!

-- JENDELA UTAMA
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 250, 0, 350)
Main.Position = UDim2.new(0.02, 0, 0.05, 0)
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
Main.BorderSizePixel = 2
Main.BorderColor3 = Color3.fromRGB(60, 120, 255)
Main.Active = true
Main.Draggable = true -- BISA DI SERET KE MANA AJA!
Main.Parent = ScreenGui

-- JUDUL
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 35)
Title.BackgroundColor3 = Color3.fromRGB(60, 120, 255)
Title.Text = "📍 WAYPOINT SYSTEM"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Parent = Main

-- AREA DAFTAR WAYPOINT
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -10, 0, 200)
Scroll.Position = UDim2.new(0, 5, 0, 45)
Scroll.BackgroundColor3 = Color3.fromRGB(45, 45, 55)
Scroll.ScrollBarThickness = 5
Scroll.Parent = Main

local Layout = Instance.new("UIListLayout")
Layout.Padding = UDim.new(0, 5)
Layout.Parent = Scroll

-- KOTAK NAMA WAYPOINT
local NamaInput = Instance.new("TextBox")
NamaInput.Size = UDim2.new(1, -10, 0, 30)
NamaInput.Position = UDim2.new(0, 5, 0, 250)
NamaInput.BackgroundColor3 = Color3.fromRGB(55, 55, 65)
NamaInput.Text = "Ketik nama waypoint..."
NamaInput.TextColor3 = Color3.new(1,1,1)
NamaInput.Font = Enum.Font.Gotham
NamaInput.TextSize = 12
NamaInput.Parent = Main

-- TOMBOL SIMPAN
local BtnSave = Instance.new("TextButton")
BtnSave.Size = UDim2.new(1, -10, 0, 30)
BtnSave.Position = UDim2.new(0, 5, 0, 285)
BtnSave.BackgroundColor3 = Color3.fromRGB(40, 180, 90)
BtnSave.Text = "✅ SIMPAN POSISI"
BtnSave.TextColor3 = Color3.new(1,1,1)
BtnSave.Font = Enum.Font.GothamBold
BtnSave.Parent = Main

-- TOMBOL HAPUS SEMUA
local BtnClear = Instance.new("TextButton")
BtnClear.Size = UDim2.new(1, -10, 0, 30)
BtnClear.Position = UDim2.new(0, 5, 0, 320)
BtnClear.BackgroundColor3 = Color3.fromRGB(180, 50, 50)
BtnClear.Text = "🗑️ HAPUS SEMUA"
BtnClear.TextColor3 = Color3.new(1,1,1)
BtnClear.Font = Enum.Font.GothamBold
BtnClear.Parent = Main

-- ==============================================
-- 🔧 UPDATE DAFTAR WAYPOINT
-- ==============================================
local function Refresh()
    -- HAPUS ITEM LAMA
    for _, c in ipairs(Scroll:GetChildren()) do
        if c:IsA("Frame") then c:Destroy() end
    end
    
    -- TAMBAH SETIAP WAYPOINT
    for no, data in pairs(Waypoints) do
        local Item = Instance.new("Frame")
        Item.Size = UDim2.new(1, -10, 0, 35)
        Item.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        Item.Parent = Scroll
        
        local Txt = Instance.new("TextLabel")
        Txt.Size = UDim2.new(0, 130, 1, 0)
        Txt.Position = UDim2.new(0, 8, 0, 0)
        Txt.BackgroundTransparency = 1
        Txt.Text = no .. ". " .. data.nama
        Txt.TextColor3 = Color3.new(1,1,1)
        Txt.Font = Enum.Font.Gotham
        Txt.TextSize = 12
        Txt.TextXAlignment = Enum.TextXAlignment.Left
        Txt.Parent = Item
        
        -- TOMBOL TELEPORT
        local BtnGo = Instance.new("TextButton")
        BtnGo.Size = UDim2.new(0, 50, 1, -6)
        BtnGo.Position = UDim2.new(1, -55, 0.5, -12)
        BtnGo.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
        BtnGo.Text = "🚀"
        BtnGo.TextSize = 14
        BtnGo.Parent = Item
        
        BtnGo.MouseButton1Click:Connect(function()
            if RootPart then
                RootPart.CFrame = data.posisi
            end
        end)
    end
    
    Scroll.CanvasSize = UDim2.new(0, 0, 0, (#Waypoints * 40))
end

-- ==============================================
-- 🖱️ FUNGSI TOMBOL
-- ==============================================
BtnSave.MouseButton1Click:Connect(function()
    if not RootPart then return end
    local nama = NamaInput.Text ~= "" and NamaInput.Text or "WP "..(#Waypoints+1)
    Waypoints[#Waypoints+1] = {nama = nama, posisi = RootPart.CFrame}
    NamaInput.Text = ""
    Refresh()
end)

BtnClear.MouseButton1Click:Connect(function()
    Waypoints = {}
    Refresh()
end)

print("✅ WAYPOINT SIAP! BISA DI ARCEUS X & DELTA!")

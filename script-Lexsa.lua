-- ==============================================
-- WAYPOINT SYSTEM — VERSI ANTI-HILANG TOTAL 🛡️
-- AUTO-RESTORE < 0.5 DETIK • DATA TETAP AMAN • BARENG BRAINROT JALAN
-- ==============================================

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- NAMA SANGAT UNIK — TIDAK AKAN TERTIMPA SCRIPT LAIN
local GUI_NAME = "WP_SYS_9283747_UNIK_TIDAK_DI_HAPUS_PLEASE"

-- PENYIMPANAN TETAP AMAN — TIDAK AKAN HILANG WALAU GUI DIHAPUS
local Waypoints = {}
local Character, RootPart

-- ==============================================
-- 🔧 FUNGSI BUAT GUI — DIPISAH BIAR BISA DIKEMBALIKAN KAPAN AJA
-- ==============================================
local function BuatGUI()
    -- HAPUS JIKA ADA YANG SAMA, TAPI DATA TETAP SIMPAN!
    if PlayerGui:FindFirstChild(GUI_NAME) then
        PlayerGui:FindFirstChild(GUI_NAME):Destroy()
    end

    -- BUAT GUI BARU
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = GUI_NAME
    ScreenGui.Parent = PlayerGui
    ScreenGui.ResetOnSpawn = false -- ⭐ TETAP ADA WALAU RESPAWN
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- JENDELA UTAMA — BISA DI SERET!
    local Main = Instance.new("Frame")
    Main.Size = UDim2.new(0, 240, 0, 340)
    Main.Position = UDim2.new(0.01, 0, 0.02, 0) -- POJOK KIRI ATAS, AMAN
    Main.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Main.BorderSizePixel = 2
    Main.BorderColor3 = Color3.fromRGB(80, 180, 255)
    Main.Active = true
    Main.Draggable = true -- ⭐ SERET KE POJOK AMAN!
    Main.Parent = ScreenGui

    -- JUDUL
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 32)
    Title.BackgroundColor3 = Color3.fromRGB(60, 140, 220)
    Title.Text = "📍 WAYPOINT AMAN"
    Title.TextColor3 = Color3.new(1,1,1)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 13
    Title.Parent = Main

    -- DAFTAR WAYPOINT (SCROLL)
    local Scroll = Instance.new("ScrollingFrame")
    Scroll.Name = "ScrollList"
    Scroll.Size = UDim2.new(1, -8, 0, 200)
    Scroll.Position = UDim2.new(0, 4, 0, 38)
    Scroll.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    Scroll.ScrollBarThickness = 4
    Scroll.Parent = Main

    local Layout = Instance.new("UIListLayout")
    Layout.Padding = UDim.new(0, 4)
    Layout.Parent = Scroll

    -- KOTAK NAMA
    local NamaInput = Instance.new("TextBox")
    NamaInput.Name = "NamaInput"
    NamaInput.Size = UDim2.new(1, -8, 0, 30)
    NamaInput.Position = UDim2.new(0, 4, 0, 245)
    NamaInput.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    NamaInput.Text = "Nama waypoint..."
    NamaInput.TextColor3 = Color3.new(1,1,1)
    NamaInput.Font = Enum.Font.Gotham
    NamaInput.TextSize = 11
    NamaInput.Parent = Main

    -- TOMBOL SIMPAN
    local BtnSave = Instance.new("TextButton")
    BtnSave.Name = "BtnSave"
    BtnSave.Size = UDim2.new(1, -8, 0, 28)
    BtnSave.Position = UDim2.new(0, 4, 0, 280)
    BtnSave.BackgroundColor3 = Color3.fromRGB(40, 170, 80)
    BtnSave.Text = "✅ SIMPAN POSISI SEKARANG"
    BtnSave.TextColor3 = Color3.new(1,1,1)
    BtnSave.Font = Enum.Font.GothamBold
    BtnSave.TextSize = 12
    BtnSave.Parent = Main

    -- TOMBOL HAPUS SEMUA
    local BtnClear = Instance.new("TextButton")
    BtnClear.Name = "BtnClear"
    BtnClear.Size = UDim2.new(1, -8, 0, 28)
    BtnClear.Position = UDim2.new(0, 4, 0, 315)
    BtnClear.BackgroundColor3 = Color3.fromRGB(170, 50, 50)
    BtnClear.Text = "🗑️ HAPUS SEMUA"
    BtnClear.TextColor3 = Color3.new(1,1,1)
    BtnClear.Font = Enum.Font.GothamBold
    BtnClear.TextSize = 12
    BtnClear.Parent = Main

    -- ==============================================
    -- 🔧 REFRESH DAFTAR — DATA TETAP AMAN!
    -- ==============================================
    local function Refresh()
        local ScrollList = Main:FindFirstChild("ScrollList")
        if not ScrollList then return end
        
        -- HAPUS TAMPILAN LAMA, DATA TETAP SIMPAN!
        for _, c in ipairs(ScrollList:GetChildren()) do
            if c:IsA("Frame") then c:Destroy() end
        end
        
        -- TAMPILKAN SEMUA WAYPOINT
        for no, data in pairs(Waypoints) do
            local Item = Instance.new("Frame")
            Item.Size = UDim2.new(1, -5, 0, 32)
            Item.BackgroundColor3 = Color3.fromRGB(55, 55, 70)
            Item.Parent = ScrollList

            local Txt = Instance.new("TextLabel")
            Txt.Size = UDim2.new(0, 120, 1, 0)
            Txt.Position = UDim2.new(0, 6, 0, 0)
            Txt.BackgroundTransparency = 1
            Txt.Text = no .. ". " .. data.nama
            Txt.TextColor3 = Color3.new(1,1,1)
            Txt.Font = Enum.Font.Gotham
            Txt.TextSize = 11
            Txt.TextXAlignment = Enum.TextXAlignment.Left
            Txt.Parent = Item

            -- TOMBOL TELEPORT
            local BtnGo = Instance.new("TextButton")
            BtnGo.Size = UDim2.new(0, 45, 0, 26)
            BtnGo.Position = UDim2.new(1, -50, 0.5, -13)
            BtnGo.BackgroundColor3 = Color3.fromRGB(50, 140, 255)
            BtnGo.Text = "🚀"
            BtnGo.TextSize = 13
            BtnGo.Parent = Item

            BtnGo.MouseButton1Click:Connect(function()
                if RootPart then 
                    RootPart.CFrame = data.posisi 
                end
            end)
        end
        
        ScrollList.CanvasSize = UDim2.new(0, 0, 0, (#Waypoints * 36))
    end

    -- ==============================================
    -- 🖱️ KLIK TOMBOL
    -- ==============================================
    BtnSave.MouseButton1Click:Connect(function()
        if not RootPart then return end
        local NamaBox = Main:FindFirstChild("NamaInput")
        local nama = NamaBox and NamaBox.Text ~= "" and NamaBox.Text or "WP "..(#Waypoints+1)
        Waypoints[#Waypoints+1] = {nama = nama, posisi = RootPart.CFrame}
        if NamaBox then NamaBox.Text = "" end
        Refresh()
    end)

    BtnClear.MouseButton1Click:Connect(function()
        Waypoints = {}
        Refresh()
    end)

    -- KASIH FUNGSI REFRESH KE LUAR BIAR BISA DIPAKAI ULANG
    ScreenGui:SetAttribute("Ready", true)
    print("✅ WAYPOINT MUNCUL! AMAN & TIDAK GAMPANG HILANG!")
end

-- ==============================================
-- 🔄 AUTO-RECOVERY — CEK TIAP 0.5 DETIK!
-- ==============================================
task.spawn(function()
    while task.wait(0.5) do -- ⭐ CEK SETIAP 0.5 DETIK!
        if not PlayerGui:FindFirstChild(GUI_NAME) then
            BuatGUI() -- ⭐ HILANG → LANGSUNG BIKIN LAGI OTOMATIS!
            print("🔄 WAYPOINT DIKEMBALIKAN OTOMATIS! DATA AMAN!")
        end
    end
end)

-- ==============================================
-- 🔄 UPDATE POSISI KARAKTER
-- ==============================================
local function UpdateChar()
    Character = LocalPlayer.Character
    if Character then
        RootPart = Character:FindFirstChild("HumanoidRootPart")
    end
end
UpdateChar()
LocalPlayer.CharacterAdded:Connect(UpdateChar)

-- JALANKAN PERTAMA KALI
BuatGUI()

print("✅ WAYPOINT SYSTEM SIAP — ANTI HILANG TOTAL! 🛡️")
print("💡 Taruh di pojok layar biar gak ketutup menu lain!")

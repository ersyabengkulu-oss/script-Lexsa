local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Hapus instance lama jika ada
if CoreGui:FindFirstChild("LexsaFinal") then
    CoreGui.LexsaFinal:Destroy()
end

-- Buat ScreenGui dengan pengaturan yang benar
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LexsaFinal"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.Parent = CoreGui -- Hindari menetapkan Parent langsung di Instance.new untuk stabilitas

-- 1. Tombol Toggle LX
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Name = "ToggleButton"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleBtn.Position = UDim2.new(0, 15, 0.45, 0)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Text = "LX"
ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Draggable = true
ToggleBtn.Active = true
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBtn

-- 2. Menu Utama
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainMenu"
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.Position = UDim2.new(0.5, -75, 0.5, -125)
MainFrame.Size = UDim2.new(0, 150, 0, 250)
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.Parent = MainFrame

-- Fungsi toggle menu
ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Scrolling Frame untuk fitur
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1, -10, 1, -20)
Scroll.Position = UDim2.new(0, 5, 0, 10)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.new(0, 0, 0, 0) -- Ajust otomatis berdasarkan konten
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y -- Tambahkan untuk ukuran kanvas yang dinamis
Scroll.Parent = MainFrame

local UIList = Instance.new("UIListLayout")
UIList.Padding = UDim.new(0, 5)
UIList.FillDirection = Enum.FillDirection.Vertical
UIList.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIList.VerticalAlignment = Enum.VerticalAlignment.Top
UIList.Parent = Scroll

-- --- FITUR AUTO COLLECT ---
local _collect = false
local collectConnection = nil -- Variabel untuk menyimpan koneksi agar bisa dihentikan

local AutoCol = Instance.new("TextButton")
AutoCol.Name = "AutoCollectButton"
AutoCol.Size = UDim2.new(1, 0, 0, 30)
AutoCol.Text = "Auto Collect: OFF"
AutoCol.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
AutoCol.TextColor3 = Color3.new(1, 1, 1)
AutoCol.Parent = Scroll

local AutoColCorner = Instance.new("UICorner")
AutoColCorner.Parent = AutoCol

AutoCol.MouseButton1Click:Connect(function()
    _collect = not _collect
    AutoCol.Text = "Auto Collect: " .. (_collect and "ON" or "OFF")
    AutoCol.BackgroundColor3 = _collect and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(60, 60, 60)

    -- Hentikan loop lama jika ada
    if collectConnection then
        collectConnection:Disconnect()
        collectConnection = nil
    end

    if _collect then
        -- Gunakan RunService.Heartbeat untuk loop yang lebih stabil
        collectConnection = RunService.Heartbeat:Connect(function()
            local Character = LocalPlayer.Character
            if not Character then return end -- Cek apakah karakter ada
            local HRP = Character:FindFirstChild("HumanoidRootPart")
            if not HRP then return end -- Cek apakah HumanoidRootPart ada

            -- Batasi pencarian ke area tertentu jika bisa, atau gunakan GetDescendants dengan hati-hati
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("BasePart") and (v.Name == "Coin" or v.Name == "Money" or v.Name == "Duit") then
                    firetouchinterest(HRP, v, 0)
                    task.wait() -- Tunggu sedikit agar tidak terlalu cepat
                    firetouchinterest(HRP, v, 1)
                end
            end
        end)
    end
end)

-- --- FITUR WAYPOINT ---
local Waypoints = {}
local MAX_WAYPOINTS = 3

for i = 1, MAX_WAYPOINTS do
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, 0, 0, 35)
    Container.BackgroundTransparency = 1
    Container.Parent = Scroll

    local Set = Instance.new("TextButton")
    Set.Name = "SetWaypoint" .. i
    Set.Size = UDim2.new(0.48, 0, 1, 0)
    Set.Text = "SET " .. i
    Set.BackgroundColor3 = Color3.fromRGB(0, 100, 0)
    Set.TextColor3 = Color3.new(1, 1, 1)
    Set.Parent = Container

    local SetCorner = Instance.new("UICorner")
    SetCorner.Parent = Set

    local Go = Instance.new("TextButton")
    Go.Name = "GoWaypoint" .. i
    Go.Size = UDim2.new(0.48, 0, 1, 0)
    Go.Position = UDim2.new(0.52, 0, 0, 0)
    Go.Text = "GO " .. i
    Go.BackgroundColor3 = Color3.fromRGB(0, 0, 100)
    Go.TextColor3 = Color3.new(1, 1, 1)
    Go.Parent = Container

    local GoCorner = Instance.new("UICorner")
    GoCorner.Parent = Go

    -- Fungsi SET Waypoint
    Set.MouseButton1Click:Connect(function()
        local Character = LocalPlayer.Character
        if not Character then return end
        local HRP = Character:FindFirstChild("HumanoidRootPart")
        if HRP then
            Waypoints[i] = HRP.CFrame
            print("Waypoint " .. i .. " telah diset!") -- Feedback untuk pengguna
        else
            print("HumanoidRootPart tidak ditemukan!")
        end
    end)

    -- Fungsi GO Waypoint
    Go.MouseButton1Click:Connect(function()
        local Character = LocalPlayer.Character
        if not Character then return end
        local HRP = Character:FindFirstChild("HumanoidRootPart")
        if Waypoints[i] and HRP then
            HRP.CFrame = Waypoints[i]
            print("Berpindah ke Waypoint " .. i .. "!") -- Feedback untuk pengguna
        else
            print("Waypoint " .. i .. " belum diset atau HRP tidak ditemukan!")
        end
    end)
end

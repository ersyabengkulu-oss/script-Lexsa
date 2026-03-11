local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Hapus instance lama
if CoreGui:FindFirstChild("LexsaFinal") then CoreGui.LexsaFinal:Destroy() end

-- Buat UI dasar
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LexsaFinal"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
ScreenGui.Parent = CoreGui

-- Tombol Toggle
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
ToggleBtn.Position = UDim2.new(0, 15, 0.45, 0)
ToggleBtn.Size = UDim2.new(0, 45, 0, 45)
ToggleBtn.Text = "LX"
ToggleBtn.TextColor3 = Color3.new(1,1,1)
ToggleBtn.Font = Enum.Font.SourceSansBold
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1,0)

-- Menu Utama
local MainFrame = Instance.new("Frame")
MainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
MainFrame.Position = UDim2.new(0.5, -75, 0.5, -125)
MainFrame.Size = UDim2.new(0,150,0,250)
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame)

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Scrolling Frame
local Scroll = Instance.new("ScrollingFrame")
Scroll.Size = UDim2.new(1,-10,1,-20)
Scroll.Position = UDim2.new(0,5,0,10)
Scroll.BackgroundTransparency = 1
Scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
Scroll.Parent = MainFrame

local UIList = Instance.new("UIListLayout", Scroll)
UIList.Padding = UDim.new(0,5)
UIList.FillDirection = Enum.FillDirection.Vertical

-- === FITUR AUTO COLLECT (DIOPTIMALISASI) ===
local _collect = false
local collectConnection = nil
-- Filter hanya bagian workspace yang mungkin ada coin (ganti sesuai game jika tahu lokasinya!)
local COIN_PARENT = workspace -- Kalau tahu lokasi khusus (misal workspace.Coins), ganti di sini!

local AutoCol = Instance.new("TextButton")
AutoCol.Size = UDim2.new(1,0,0,30)
AutoCol.Text = "Auto Collect: OFF"
AutoCol.BackgroundColor3 = Color3.fromRGB(60,60,60)
AutoCol.TextColor3 = Color3.new(1,1,1)
AutoCol.Parent = Scroll
Instance.new("UICorner", AutoCol)

AutoCol.MouseButton1Click:Connect(function()
    _collect = not _collect
    AutoCol.Text = "Auto Collect: " .. (_collect and "ON" or "OFF")
    AutoCol.BackgroundColor3 = _collect and Color3.fromRGB(0,150,0) or Color3.fromRGB(60,60,60)

    -- Hentikan loop lama
    if collectConnection then
        collectConnection:Disconnect()
        collectConnection = nil
    end

    if _collect then
        -- Loop setiap 1 detik saja (cukup cepat tapi tidak berat)
        collectConnection = RunService.Heartbeat:Connect(function()
            local Character = LocalPlayer.Character
            local HRP = Character and Character:FindFirstChild("HumanoidRootPart")
            if not HRP then return end

            -- Cari hanya objek yang berjenis BasePart dan nama sesuai
            for _, v in pairs(COIN_PARENT:GetChildren()) do -- Gunakan GetChildren bukan GetDescendants!
                if v:IsA("BasePart") and table.find({"Coin", "Money", "Duit"}, v.Name) then
                    firetouchinterest(HRP, v, 0)
                    firetouchinterest(HRP, v, 1)
                end
            end
        end)
        -- Jeda loop agar tidak terlalu sering (1 detik = 60 frame, jadi jeda 60 frame)
        task.wait(1)
    end
end)

-- === FITUR WAYPOINT (TETAP RINGAN) ===
local Waypoints = {}
for i = 1, 3 do
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1,0,0,35)
    Container.BackgroundTransparency = 1
    Container.Parent = Scroll

    local Set = Instance.new("TextButton")
    Set.Size = UDim2.new(0.48,0,1,0)
    Set.Text = "SET "..i
    Set.BackgroundColor3 = Color3.fromRGB(0,100,0)
    Set.TextColor3 = Color3.new(1,1,1)
    Set.Parent = Container
    Instance.new("UICorner", Set)

    local Go = Instance.new("TextButton")
    Go.Size = UDim2.new(0.48,0,1,0)
    Go.Position = UDim2.new(0.52,0,0,0)
    Go.Text = "GO "..i
    Go.BackgroundColor3 = Color3.fromRGB(0,0,100)
    Go.TextColor3 = Color3.new(1,1,1)
    Go.Parent = Container
    Instance.new("UICorner", Go)

    Set.MouseButton1Click:Connect(function()
        local HRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if HRP then Waypoints[i] = HRP.CFrame print("Waypoint "..i.." diset!") end
    end)

    Go.MouseButton1Click:Connect(function()
        local HRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if Waypoints[i] and HRP then HRP.CFrame = Waypoints[i] print("Ke Waypoint "..i.."!") end
    end)
end

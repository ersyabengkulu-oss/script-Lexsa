-- LEXSA LAVA CORE: VERSION 2.0 (WITH MINIMIZE)
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- 1. KONFIGURASI (LINK KAMU SUDAH BENAR!)
local linkWhitelist = "https://raw.githubusercontent.com/ersyabengkulu-oss/script-Lexsa/main/whitelist.txt"
local linkKey = "https://raw.githubusercontent.com/ersyabengkulu-oss/script-Lexsa/main/key.txt"

-- 2. FUNGSI MENU UTAMA
local function startMainScript()
    local ScreenGui = Instance.new("ScreenGui", PlayerGui)
    ScreenGui.Name = "LexsaLavaCore"
    
    -- Jendela Utama
    local Frame = Instance.new("Frame", ScreenGui)
    Frame.Size = UDim2.new(0, 200, 0, 110)
    Frame.Position = UDim2.new(0.5, -100, 0.4, 0)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Frame.BorderSizePixel = 2
    Frame.Active = true
    Frame.Draggable = true

    -- Tombol Sembunyikan (Hide)
    local HideBtn = Instance.new("TextButton", Frame)
    HideBtn.Size = UDim2.new(1, 0, 0, 30)
    HideBtn.Text = "HIDE MENU"
    HideBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    HideBtn.TextColor3 = Color3.new(1, 1, 1)

    -- Tombol Lava
    local ToggleBtn = Instance.new("TextButton", Frame)
    ToggleBtn.Size = UDim2.new(0.9, 0, 0, 60)
    ToggleBtn.Position = UDim2.new(0.05, 0, 0.35, 0)
    ToggleBtn.Text = "LAVA WALKING: OFF"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 0)
    ToggleBtn.TextColor3 = Color3.new(1, 1, 1)
    ToggleBtn.TextScaled = true

    -- Tombol Munculin (Floating Button)
    local OpenBtn = Instance.new("TextButton", ScreenGui)
    OpenBtn.Size = UDim2.new(0, 60, 0, 30)
    OpenBtn.Position = UDim2.new(0, 5, 0.5, 0)
    OpenBtn.Text = "LEXSA"
    OpenBtn.Visible = false
    OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    OpenBtn.TextColor3 = Color3.new(1, 1, 1)

    HideBtn.MouseButton1Click:Connect(function()
        Frame.Visible = false
        OpenBtn.Visible = true
    end)

    OpenBtn.MouseButton1Click:Connect(function()
        Frame.Visible = true
        OpenBtn.Visible = false
    end)

    local active = false
    ToggleBtn.MouseButton1Click:Connect(function()
        active = not active
        ToggleBtn.Text = active and "LAVA WALKING: ON" or "LAVA WALKING: OFF"
        ToggleBtn.BackgroundColor3 = active and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(200, 50, 0)
        
        task.spawn(function()
            while active do
                pcall(function()
                    for _, v in pairs(game.Workspace:GetDescendants()) do
                        if v:IsA("BasePart") and v.Name:lower():find("lava") then
                            v.CanCollide = true
                            if v:FindFirstChild("TouchInterest") then v.TouchInterest:Destroy() end
                        end
                    end
                end)
                task.wait(1)
            end
        end)
    end)
end

-- 3. LOGIKA PENGECEKAN
local isVip = false
local sW, cW = pcall(function() return game:HttpGet(linkWhitelist) end)
if sW and cW:find(Player.Name) then isVip = true end

if isVip then
    startMainScript()
else
    -- TAMPILKAN KEY SYSTEM JIKA BUKAN VIP
    local KeyGui = Instance.new("ScreenGui", PlayerGui)
    local KeyFrame = Instance.new("Frame", KeyGui)
    KeyFrame.Size = UDim2.new(0, 250, 0, 150)
    KeyFrame.Position = UDim2.new(0.5, -125, 0.4, 0)
    KeyFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    
    local KeyInput = Instance.new("TextBox", KeyFrame)
    KeyInput.Size = UDim2.new(0.8, 0, 0, 40)
    KeyInput.Position = UDim2.new(0.1, 0, 0.2, 0)
    KeyInput.PlaceholderText = "Input Key..."

    local CheckBtn = Instance.new("TextButton", KeyFrame)
    CheckBtn.Size = UDim2.new(0.5, 0, 0, 40)
    CheckBtn.Position = UDim2.new(0.25, 0, 0.65, 0)
    CheckBtn.Text = "CHECK"
    CheckBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)

    CheckBtn.MouseButton1Click:Connect(function()
        local sK, curK = pcall(function() return game:HttpGet(linkKey) end)
        if sK and KeyInput.Text == curK:gsub("%s+", "") then
            KeyGui:Destroy()
            startMainScript()
        end
    end)
end

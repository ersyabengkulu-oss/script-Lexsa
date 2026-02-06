-- LEXSA LAVA CORE: ALL-IN-ONE (WHITELIST + KEY)
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

-- 1. KONFIGURASI (GANTI INI!)
local linkWhitelist = "https://raw.githubusercontent.com/ersyabengkulu-oss/script-Lexsa/main/whitelist.txt"
 
local linkKey = "https://raw.githubusercontent.com/ersyabengkulu-oss/script-Lexsa/main/key.txt"
local linkIklan = "https://linkvertise.com/lexsa-key" 

-- 2. FUNGSI MENU UTAMA (LAVA WALKING)
local function startMainScript()
    local ScreenGui = Instance.new("ScreenGui", PlayerGui)
    ScreenGui.Name = "LexsaLavaCore"
    
    local Frame = Instance.new("Frame", ScreenGui)
    Frame.Size = UDim2.new(0, 200, 0, 100)
    Frame.Position = UDim2.new(0.5, -100, 0.5, -50)
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Frame.Active = true
    Frame.Draggable = true

    local ToggleBtn = Instance.new("TextButton", Frame)
    ToggleBtn.Size = UDim2.new(1, 0, 1, 0)
    ToggleBtn.Text = "LAVA WALKING: OFF"
    ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 0)
    ToggleBtn.TextColor3 = Color3.new(1, 1, 1)

    local active = false
    ToggleBtn.MouseButton1Click:Connect(function()
        active = not active
        ToggleBtn.Text = active and "LAVA WALKING: ON" or "LAVA WALKING: OFF"
        ToggleBtn.BackgroundColor3 = active and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(200, 50, 0)
        
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

-- 3. CEK WHITELIST
local isVip = false
local sW, cW = pcall(function() return game:HttpGet(linkWhitelist) end)
if sW and cW:find(Player.Name) then isVip = true end

if isVip then
    startMainScript()
else
    -- 4. TAMPILKAN KEY SYSTEM
    local KeyGui = Instance.new("ScreenGui", PlayerGui)
    local KeyFrame = Instance.new("Frame", KeyGui)
    KeyFrame.Size = UDim2.new(0, 250, 0, 150)
    KeyFrame.Position = UDim2.new(0.5, -125, 0.4, 0)
    KeyFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    KeyFrame.Draggable = true

    local KeyInput = Instance.new("TextBox", KeyFrame)
    KeyInput.Size = UDim2.new(0.8, 0, 0, 30)
    KeyInput.Position = UDim2.new(0.1, 0, 0.3, 0)
    KeyInput.PlaceholderText = "Input Key..."

    local CheckBtn = Instance.new("TextButton", KeyFrame)
    CheckBtn.Size = UDim2.new(0.4, 0, 0, 30)
    CheckBtn.Position = UDim2.new(0.55, 0, 0.7, 0)
    CheckBtn.Text = "CHECK"
    CheckBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)

    CheckBtn.MouseButton1Click:Connect(function()
        local sK, curK = pcall(function() return game:HttpGet(linkKey) end)
        if sK and KeyInput.Text == curK:gsub("%s+", "") then
            KeyGui:Destroy()
            startMainScript()
        else
            KeyInput.Text = ""
            KeyInput.PlaceholderText = "WRONG!"
        end
    end)
end

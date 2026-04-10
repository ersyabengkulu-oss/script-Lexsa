-- LEXSA SIMPLE TOOLS
local p = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", p.PlayerGui)
sg.Name = "LexsaHub"
sg.ResetOnSpawn = false

local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 150, 0, 180)
f.Position = UDim2.new(0.5, -75, 0.5, -90)
f.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
f.Active = true
f.Draggable = true
f.BorderSizePixel = 0

local t = Instance.new("TextLabel", f)
t.Size = UDim2.new(1, 0, 0, 30)
t.Text = "LEXSA (4663)"
t.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
t.TextColor3 = Color3.fromRGB(255,255,255)
t.Font = Enum.Font.GothamBold
t.TextSize = 14

-- =====================================
--             TOMBOL SCAN
-- =====================================
local b1 = Instance.new("TextButton", f)
b1.Size = UDim2.new(0.9, 0, 0, 40)
b1.Position = UDim2.new(0.05, 0, 0.25, 0)
b1.Text = "SCAN BUG"
b1.BackgroundColor3 = Color3.fromRGB(50,50,50)
b1.TextColor3 = Color3.fromRGB(255,255,255)
b1.BorderSizePixel = 0

b1.MouseButton1Click:Connect(function()
    b1.Text = "SCANNING..."
    task.wait(0.1)

    print("=====================================")
    print("       LEXSA BUG SCANNER            ")
    print("=====================================")
    
    local count = 0
    
    local success, err = pcall(function()
        for _, v in pairs(game:GetDescendants()) do
            if v:IsA("RemoteEvent") or v:IsA("RemoteFunction") then
                print("✅ FOUND: " .. v.Name .. " | Path: " .. v:GetFullName())
                count = count + 1
            end
        end
    end)
    
    if not success then
        print("❌ ERROR: " .. err)
    end

    print("=====================================")
    print("✅ Scan Selesai! Total ditemukan: " .. count)
    print("=====================================")

    b1.Text = "SCAN BUG"
end)

-- =====================================
--             TOMBOL ESP
-- =====================================
local b2 = Instance.new("TextButton", f)
b2.Size = UDim2.new(0.9, 0, 0, 40)
b2.Position = UDim2.new(0.05, 0, 0.55, 0)
b2.Text = "ESP MUSUH"
b2.BackgroundColor3 = Color3.fromRGB(50,50,50)
b2.TextColor3 = Color3.fromRGB(255,255,255)
b2.BorderSizePixel = 0

local ESP_Enabled = false
local ESP_Loop = nil

b2.MouseButton1Click:Connect(function()
    ESP_Enabled = not ESP_Enabled
    
    if ESP_Enabled then
        b2.Text = "ESP: ON"
        print("ESP AKTIF - Memantau semua player...")
        
        ESP_Loop = game:GetService("RunService").Heartbeat:Connect(function()
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= p and v.Character then
                    
                    if not v.Character:FindFirstChild("LexsaESP") then
                        local h = Instance.new("Highlight")
                        h.Name = "LexsaESP"
                        h.Parent = v.Character
                        h.FillColor3 = Color3.fromRGB(255, 0, 0)
                        h.OutlineColor3 = Color3.fromRGB(255, 255, 255)
                        h.FillTransparency = 0.5
                        h.OutlineTransparency = 0
                        h.Enabled = true
                    end
                end
            end
        end)
        
    else
        b2.Text = "ESP MUSUH"
        print("ESP MATI")
        
        if ESP_Loop then ESP_Loop:Disconnect() end
        
        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("LexsaESP") then
                v.Character.LexsaESP:Destroy()
            end
        end
    end
end)

-- FUNGSI ESP
local b2 = Instance.new("TextButton", f)
b2.Size = UDim2.new(0.9, 0, 0, 40)
b2.Position = UDim2.new(0.05, 0, 0.55, 0)
b2.Text = "ESP MUSUH"
b2.BackgroundColor3 = Color3.fromRGB(50,50,50)
b2.TextColor3 = Color3.fromRGB(255,255,255)
b2.BorderSizePixel = 0

local ESP_Enabled = false -- Status nyala/mati
local ESP_Loop = nil -- Variabel buat nampung loop

b2.MouseButton1Click:Connect(function()
    ESP_Enabled = not ESP_Enabled -- Toggle on/off
    
    if ESP_Enabled then
        b2.Text = "ESP: ON"
        print("ESP AKTIF - Memantau semua player...")
        
        -- Looping terus menerus buat cek player
        ESP_Loop = game:GetService("RunService").Heartbeat:Connect(function()
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= p and v.Character then -- Kalau bukan diri sendiri dan ada karakternya
                    
                    -- Cek dulu udah ada Highlight belum, biar gak numpuk
                    if not v.Character:FindFirstChild("LexsaESP") then
                        local h = Instance.new("Highlight")
                        h.Name = "LexsaESP" -- Kasih nama biar gampang dicari
                        h.Parent = v.Character
                        h.FillColor3 = Color3.fromRGB(255, 0, 0)
                        h.OutlineColor3 = Color3.fromRGB(255, 255, 255)
                        h.FillTransparency = 0.5 -- Biar kelihatan dalemnya
                        h.OutlineTransparency = 0
                        h.Enabled = true
                    end
                end
            end
        end)
        
    else
        b2.Text = "ESP MUSUH"
        print("ESP MATI")
        
        -- Matikan loop
        if ESP_Loop then ESP_Loop:Disconnect() end
        
        -- Hapus semua highlight
        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("LexsaESP") then
                v.Character.LexsaESP:Destroy()
            end
        end
    end
end)

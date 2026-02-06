-- Tombol Auto Collect Cash (Baru!)
local CollectBtn = Instance.new("TextButton", Frame)
CollectBtn.Size = UDim2.new(0.9, 0, 0, 40)
CollectBtn.Position = UDim2.new(0.05, 0, 0.7, 0)
CollectBtn.Text = "AUTO COLLECT: OFF"
CollectBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CollectBtn.TextColor3 = Color3.new(1, 1, 1)

local autoCollect = false
CollectBtn.MouseButton1Click:Connect(function()
    autoCollect = not autoCollect
    CollectBtn.Text = autoCollect and "AUTO COLLECT: ON" or "AUTO COLLECT: OFF"
    CollectBtn.BackgroundColor3 = autoCollect and Color3.fromRGB(0, 150, 150) or Color3.fromRGB(50, 50, 50)
    
    task.spawn(function()
        while autoCollect do
            -- Di sini kita masukkan hasil "Spy" tadi
            -- Contoh: game:GetService("ReplicatedStorage").RemoteEvents.Collect:FireServer()
            task.wait(1) -- Biar nggak kena kick karena spam
        end
    end)
end)

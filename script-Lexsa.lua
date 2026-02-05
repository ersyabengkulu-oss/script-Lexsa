-- LEXSA V7.0: SPECIAL LAVA WALKING EDITION
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ToggleBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")

ScreenGui.Name = "LexsaLava"
ScreenGui.Parent = game:GetService("CoreGui")

-- Tombol Buka/Tutup Kecil
OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 60, 0, 30)
OpenBtn.Position = UDim2.new(0, 10, 0.5, 0)
OpenBtn.Text = "LEXSA"
OpenBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
OpenBtn.Draggable = true

-- Frame Utama
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Position = UDim2.new(0.4, 0, 0.4, 0)
Frame.Size = UDim2.new(0, 180, 0, 120)
Frame.Visible = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(1, 0, 0, 35)
TextLabel.Text = "LEXSA: LAVA ONLY"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

-- Tombol Lava Walking
ToggleBtn.Parent = Frame
ToggleBtn.Size = UDim2.new(0.9, 0, 0, 45)
ToggleBtn.Position = UDim2.new(0.05, 0, 0.45, 0)
ToggleBtn.Text = "LAVA WALKING: OFF"
ToggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)

local lavaActive = false
ToggleBtn.MouseButton1Click:Connect(function()
    lavaActive = not lavaActive
    ToggleBtn.Text = lavaActive and "LAVA WALKING: ON" or "LAVA WALKING: OFF"
    ToggleBtn.BackgroundColor3 = lavaActive and Color3.fromRGB(0, 180, 0) or Color3.fromRGB(50, 50, 50)
    
    task.spawn(function()
        while lavaActive do
            pcall(function()
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    -- Mencari objek yang mengandung nama 'lava'
                    if v.Name:lower():find("lava") and v:IsA("BasePart") then
                        v.CanCollide = true -- Bisa diinjak
                        -- Menghapus script pembunuh lava jika ada
                        if v:FindFirstChild("TouchInterest") then 
                            v.TouchInterest:Destroy() 
                        end
                    end
                end
            end)
            task.wait(1)
        end
    end)
end)

OpenBtn.MouseButton1Click:Connect(function() Frame.Visible = not Frame.Visible end)

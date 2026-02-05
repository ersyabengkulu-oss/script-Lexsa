-- LEXSA MENU V25: GEN FIX & ANTI-EMOTE PARRY
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")

-- Setup UI
ScreenGui.Name = "LexsaV25"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 60, 0, 60)
OpenBtn.Position = UDim2.new(0, 10, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
OpenBtn.Text = "LEX"
OpenBtn.Visible = false
OpenBtn.Draggable = true

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 220, 0, 320)
Frame.Active = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(1, 0, 0, 40)
TextLabel.Text = "LEXSA V25: FIXED"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

ScrollFrame.Parent = Frame
ScrollFrame.Size = UDim2.new(1, -10, 1, -90)
ScrollFrame.Position = UDim2.new(0, 5, 0, 45)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.ScrollBarThickness = 5

UIListLayout.Parent = ScrollFrame
UIListLayout.Padding = UDim.new(0, 5)

local function addToggle(name, color, func)
    local active = false
    local btn = Instance.new("TextButton")
    btn.Parent = ScrollFrame
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Text = name .. ": OFF"
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = active and name .. ": ON" or name .. ": OFF"
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 180, 0) or color
        func(active)
    end)
end

-- ==========================================
-- 1. AUTO GEN (SISTEM SCAN LEBIH KUAT)
-- ==========================================
addToggle("AUTO GEN", Color3.fromRGB(0, 100, 200), function(state)
    _G.AutoRepair = state
    task.spawn(function()
        while _G.AutoRepair do
            pcall(function()
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    -- Mencari segala jenis objek Generator
                    if v:IsA("Model") and (v.Name:find("Generator") or v.Name:find("Gen")) then
                        local root = v:FindFirstChildWhichIsA("BasePart") or v.PrimaryPart
                        if root then
                            -- Tambahkan ESP Hijau agar terlihat
                            if not root:FindFirstChild("Highlight") then
                                local h = Instance.new("Highlight", root)
                                h.FillColor = Color3.fromRGB(0, 255, 0)
                            end
                            -- Jarak deteksi diperluas ke 15 meter
                            local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - root.Position).Magnitude
                            if dist < 15 then
                                local prompt = v:FindFirstChildOfClass("ProximityPrompt") or v:FindFirstChild("Prompt", true)
                                if prompt then fireproximityprompt(prompt) end
                            end
                        end
                    end
                end
            end)
            task.wait(0.3)
        end
    end)
end)

-- ==========================================
-- 2. AUTO PARRY (ANTI-EMOTE & LEBIH CEPAT)
-- ==========================================
addToggle("AUTO PARRY", Color3.fromRGB(255, 100, 0), function(state)
    _G.Parry = state
    task.spawn(function()
        while _G.Parry do
            pcall(function()
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                        local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                        -- Deteksi jarak musuh menyerang
                        if dist < 11 then
                            -- Menggunakan sistem KeyPress kilat agar menu emot tidak terbuka
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.F, false, game)
                            task.wait(0.01) -- Sangat cepat
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.F, false, game)
                        end
                    end
                end
            end)
            task.wait(0.05)
        end
    end)
end)

-- ==========================================
-- 3. FITUR LAINNYA (OPTIMIZED)
-- ==========================================
addToggle("SMOOTH AIM", Color3.fromRGB(200, 0, 0), function(state)
    _G.Aim = state
    local cam = game.Workspace.CurrentCamera
    task.spawn(function()
        while _G.Aim do
            pcall(function()
                local target = nil
                local dist = 150
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= game.Players.LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                        local pos, vis = cam:WorldToViewportPoint(p.Character.Head.Position)
                        if vis then
                            local mDist = (Vector2.new(pos.X, pos.Y) - Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)).Magnitude
                            if mDist < dist then target = p.Character.Head dist = mDist end
                        end
                    end
                end
                if target then cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, target.Position), 0.1) end
            end)
            task.wait()
        end
    end)
end)

addToggle("SPEED BOOST", Color3.fromRGB(40, 40, 40), function(state)
    _G.Spd = state
    while _G.Spd do
        pcall(function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 45 end)
        task.wait(0.1)
    end
end)

addToggle("GOD MODE", Color3.fromRGB(60, 60, 60), function(state)
    _G.God = state
    while _G.God do
        pcall(function() game.Players.LocalPlayer.Character.Humanoid.Health = 100 end)
        task.wait(0.1)
    end
end)

-- Minimize
MinimizeBtn.Parent = Frame
MinimizeBtn.Size = UDim2.new(1, -20, 0, 35)
MinimizeBtn.Position = UDim2.new(0, 10, 1, -40)
MinimizeBtn.Text = "Sembunyikan Menu"
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinimizeBtn.MouseButton1Click:Connect(function() Frame.Visible = false OpenBtn.Visible = true end)
OpenBtn.MouseButton1Click:Connect(function() Frame.Visible = true OpenBtn.Visible = false end)

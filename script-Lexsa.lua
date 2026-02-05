-- LEXSA MENU V20: GENERATOR FIX & GOD MODE
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")

-- Setup UI Utama
ScreenGui.Name = "LexsaV20"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

-- Tombol Buka (LEX)
OpenBtn.Name = "OpenBtn"
OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 60, 0, 60)
OpenBtn.Position = UDim2.new(0, 10, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
OpenBtn.Text = "LEX"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.Visible = false
OpenBtn.Draggable = true

-- Frame Menu
Frame.Name = "MainFrame"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 220, 0, 320)
Frame.Active = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(1, 0, 0, 40)
TextLabel.Text = "LEXSA V20: GOD MODE"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

ScrollFrame.Parent = Frame
ScrollFrame.Size = UDim2.new(1, -10, 1, -90)
ScrollFrame.Position = UDim2.new(0, 5, 0, 45)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.ScrollBarThickness = 5

UIListLayout.Parent = ScrollFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

-- Fungsi Helper Tombol ON/OFF
local function createToggle(name, default_color, func)
    local active = false
    local btn = Instance.new("TextButton")
    btn.Parent = ScrollFrame
    btn.Size = UDim2.new(1, -10, 0, 40)
    btn.Text = name .. ": OFF"
    btn.BackgroundColor3 = default_color
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = active and name .. ": ON" or name .. ": OFF"
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 180, 0) or default_color
        func(active)
    end)
    return btn
end

-- ==========================================
-- 1. GOD MODE (KEBAL)
-- ==========================================
createToggle("GOD MODE", Color3.fromRGB(80, 80, 80), function(state)
    _G.GodMode = state
    task.spawn(function()
        while _G.GodMode do
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("Humanoid") then
                    char.Humanoid.MaxHealth = math.huge
                    char.Humanoid.Health = math.huge
                end
            end)
            task.wait(0.1)
        end
        -- Reset Health saat OFF
        pcall(function() 
            game.Players.LocalPlayer.Character.Humanoid.MaxHealth = 100 
            game.Players.LocalPlayer.Character.Humanoid.Health = 100
        end)
    end)
end)

-- ==========================================
-- 2. GENERATOR ESP & AUTO REPAIR (FIXED)
-- ==========================================
createToggle("GEN HELPER", Color3.fromRGB(0, 100, 200), function(state)
    _G.GenHelper = state
    if state then
        -- Logika ESP Generator
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if (v.Name:lower():find("generator") or v.Name:lower():find("gen")) and v:IsA("BasePart") then
                if not v:FindFirstChild("GenHighlight") then
                    local h = Instance.new("Highlight", v)
                    h.Name = "GenHighlight"
                    h.FillColor = Color3.fromRGB(0, 255, 0)
                end
            end
        end
        -- Logika Auto Repair
        task.spawn(function()
            while _G.GenHelper do
                pcall(function()
                    for _, v in pairs(game.Workspace:GetDescendants()) do
                        if (v.Name:lower():find("generator") or v.Name:lower():find("gen")) then
                            local prompt = v:FindFirstChildOfClass("ProximityPrompt") or v:FindFirstChild("Prompt", true)
                            if prompt and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude < 15 then
                                fireproximityprompt(prompt)
                            end
                        end
                    end
                end)
                task.wait(0.3)
            end
        end)
    else
        -- Hapus ESP saat OFF
        for _, v in pairs(game.Workspace:GetDescendants()) do
            if v:FindFirstChild("GenHighlight") then v.GenHighlight:Destroy() end
        end
    end
end)

-- ==========================================
-- 3. FITUR LAINNYA
-- ==========================================
createToggle("AUTO PARRY", Color3.fromRGB(255, 100, 0), function(state)
    _G.Parry = state
    task.spawn(function()
        while _G.Parry do
            pcall(function()
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= game.Players.LocalPlayer and p.Character then
                        local dist = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
                        if dist < 12 then
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.F, false, game)
                            task.wait(0.05)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.F, false, game)
                        end
                    end
                end
            end)
            task.wait(0.1)
        end
    end)
end)

createToggle("AUTO CLICK", Color3.fromRGB(0, 150, 255), function(state)
    _G.Clicker = state
    while _G.Clicker do
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
        game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 0)
        task.wait(0.1)
    end
end)

-- Tombol Sembunyikan
MinimizeBtn.Parent = Frame
MinimizeBtn.Size = UDim2.new(1, -20, 0, 35)
MinimizeBtn.Position = UDim2.new(0, 10, 1, -40)
MinimizeBtn.Text = "Sembunyikan Menu"
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)

MinimizeBtn.MouseButton1Click:Connect(function() Frame.Visible = false OpenBtn.Visible = true end)
OpenBtn.MouseButton1Click:Connect(function() Frame.Visible = true OpenBtn.Visible = false end)

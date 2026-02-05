-- LEXSA MENU V19: VIOLENCE DISTRICT SPECIAL
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")

-- Setup UI
ScreenGui.Name = "LexsaV19"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

OpenBtn.Name = "OpenBtn"
OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 60, 0, 60)
OpenBtn.Position = UDim2.new(0, 10, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
OpenBtn.Text = "LEX"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.Visible = false
OpenBtn.Draggable = true

Frame.Name = "MainFrame"
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 220, 0, 320)
Frame.Active = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(1, 0, 0, 40)
TextLabel.Text = "LEXSA V19: PARRY+"
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

local function addBtn(name, color, func)
    local b = Instance.new("TextButton")
    b.Parent = ScrollFrame
    b.Size = UDim2.new(1, -10, 0, 40)
    b.Text = name
    b.BackgroundColor3 = color
    b.TextColor3 = Color3.fromRGB(255, 255, 255)
    b.Font = Enum.Font.SourceSansBold
    b.MouseButton1Click:Connect(func)
    return b
end

-- ==========================================
-- FITUR AUTO PARRY (KHUSUS)
-- ==========================================
local parryActive = false
local ParryBtn = addBtn("AUTO PARRY: OFF", Color3.fromRGB(255, 100, 0), function() end)

ParryBtn.MouseButton1Click:Connect(function()
    parryActive = not parryActive
    ParryBtn.Text = parryActive and "AUTO PARRY: ON" or "AUTO PARRY: OFF"
    ParryBtn.BackgroundColor3 = parryActive and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 100, 0)
    
    task.spawn(function()
        while parryActive do
            pcall(function()
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local distance = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
                        if distance < 15 then -- Jarak deteksi musuh
                            -- Menjalankan aksi parry/block sesuai tombol game (biasanya F atau mouse kanan)
                            game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.F, false, game)
                            task.wait(0.1)
                            game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.F, false, game)
                        end
                    end
                end
            end)
            task.wait(0.1)
        end
    end)
end)

-- ==========================================
-- FITUR LAINNYA
-- ==========================================
addBtn("SPEED (+50)", Color3.fromRGB(60, 60, 60), function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
end)

addBtn("ESP MUSUH", Color3.fromRGB(150, 0, 200), function()
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer and p.Character then
            if not p.Character:FindFirstChild("Highlight") then
                Instance.new("Highlight", p.Character).FillColor = Color3.fromRGB(255, 0, 0)
            end
        end
    end
end)

addBtn("AUTO AIM", Color3.fromRGB(200, 0, 0), function()
    _G.AA = not _G.AA
    while _G.AA do
        task.wait()
        pcall(function()
            local cam = game.Workspace.CurrentCamera
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                    cam.CFrame = CFrame.new(cam.CFrame.Position, v.Character.Head.Position)
                end
            end
        end)
    end
end)

addBtn("GEN ESP & REPAIR", Color3.fromRGB(0, 100, 200), function()
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if v.Name:lower():find("generator") and v:IsA("BasePart") then
            if not v:FindFirstChild("Highlight") then Instance.new("Highlight", v).FillColor = Color3.fromRGB(0, 255, 0) end
            task.spawn(function()
                while task.wait(0.5) do
                    if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).magnitude < 15 then
                        fireproximityprompt(v:FindFirstChildOfClass("ProximityPrompt"))
                    end
                end
            end)
        end
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

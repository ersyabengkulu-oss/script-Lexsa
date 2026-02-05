-- LEXSA MENU V24: SMOOTH AIM & FOV
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")

-- Setup UI
ScreenGui.Name = "LexsaV24"
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
TextLabel.Text = "LEXSA V24: SMOOTH"
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
-- AUTO AIM (SMOOTH + FOV)
-- ==========================================
addToggle("SMOOTH AIM", Color3.fromRGB(200, 0, 0), function(state)
    _G.Aim = state
    local cam = game.Workspace.CurrentCamera
    local lp = game.Players.LocalPlayer
    local fov = 150 -- Luas area deteksi (semakin kecil, semakin tidak mengganggu)
    
    task.spawn(function()
        while _G.Aim do
            pcall(function()
                local closest = nil
                local shortestDist = fov
                
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= lp and p.Character and p.Character:FindFirstChild("Head") then
                        local pos, onScreen = cam:WorldToViewportPoint(p.Character.Head.Position)
                        if onScreen then
                            local mouseDist = (Vector2.new(pos.X, pos.Y) - Vector2.new(cam.ViewportSize.X/2, cam.ViewportSize.Y/2)).Magnitude
                            if mouseDist < shortestDist then
                                closest = p.Character.Head
                                shortestDist = mouseDist
                            end
                        end
                    end
                end
                
                if closest then
                    -- Pergerakan kamera dibuat smooth (0.15) agar tidak langsung sentak
                    cam.CFrame = cam.CFrame:Lerp(CFrame.new(cam.CFrame.Position, closest.Position), 0.15)
                end
            end)
            task.wait()
        end
    end)
end)

-- ==========================================
-- FITUR LAINNYA (TETAP SAMA)
-- ==========================================
addToggle("ALL ESP", Color3.fromRGB(150, 0, 200), function(state)
    _G.Esp = state
    task.spawn(function()
        while _G.Esp do
            pcall(function()
                for _, p in pairs(game.Players:GetPlayers()) do
                    if p ~= game.Players.LocalPlayer and p.Character and not p.Character:FindFirstChild("Highlight") then
                        Instance.new("Highlight", p.Character).FillColor = Color3.fromRGB(255, 0, 0)
                    end
                end
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    if (v.Name:find("Generator") or v.Name:find("Gen")) and v:IsA("BasePart") and not v:FindFirstChild("Highlight") then
                        Instance.new("Highlight", v).FillColor = Color3.fromRGB(0, 255, 0)
                    end
                end
            end)
            task.wait(1)
        end
    end)
end)

addToggle("AUTO GEN", Color3.fromRGB(0, 100, 200), function(state)
    _G.Repair = state
    while _G.Repair do
        pcall(function()
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if (v.Name:find("Generator") or v.Name:find("Gen")) then
                    local p = v:FindFirstChildOfClass("ProximityPrompt") or v:FindFirstChild("Prompt", true)
                    if p and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).Magnitude < 12 then
                        fireproximityprompt(p)
                    end
                end
            end
        end)
        task.wait(0.5)
    end
end)

addToggle("SPEED BOOST", Color3.fromRGB(40, 40, 40), function(state)
    _G.Spd = state
    while _G.Spd do
        pcall(function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 45 end)
        task.wait(0.2)
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

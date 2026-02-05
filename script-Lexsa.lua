-- LEXSA MENU V27: CATCH & TAME (RARE FARM)
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")

-- Setup UI
ScreenGui.Name = "LexsaV27"
ScreenGui.Parent = game:GetService("CoreGui")
ScreenGui.ResetOnSpawn = false

OpenBtn.Parent = ScreenGui
OpenBtn.Size = UDim2.new(0, 60, 0, 60)
OpenBtn.Position = UDim2.new(0, 10, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 200)
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
TextLabel.Text = "LEXSA: RARE FARM"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(0, 120, 180)

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
-- 1. AUTO FARM RARE (TELEPORT KE MONSTER RARE)
-- ==========================================
addToggle("FARM RARE", Color3.fromRGB(255, 0, 255), function(state)
    _G.AutoFarm = state
    task.spawn(function()
        while _G.AutoFarm do
            pcall(function()
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    -- Mencari monster dengan nama "Legendary", "Mythical", atau "Rare"
                    if v:IsA("Model") and v:FindFirstChild("Humanoid") and 
                       (v.Name:find("Legendary") or v.Name:find("Mythical") or v.Name:find("Rare")) then
                        
                        local root = v:FindFirstChild("HumanoidRootPart") or v.PrimaryPart
                        if root then
                            -- Teleport ke atas monster agar aman
                            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = root.CFrame * CFrame.new(0, 5, 0)
                            -- Otomatis Memukul
                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, true, game, 0)
                            task.wait(0.1)
                            game:GetService("VirtualInputManager"):SendMouseButtonEvent(0, 0, 0, false, game, 0)
                        end
                    end
                end
            end)
            task.wait(0.5)
        end
    end)
end)

-- ==========================================
-- 2. MONSTER ESP (RARE ONLY - WARNA UNGU)
-- ==========================================
addToggle("RARE ESP", Color3.fromRGB(150, 0, 200), function(state)
    _G.RareEsp = state
    task.spawn(function()
        while _G.RareEsp do
            pcall(function()
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    if v:IsA("Model") and v:FindFirstChild("Humanoid") and 
                       (v.Name:find("Legendary") or v.Name:find("Mythical") or v.Name:find("Rare")) then
                        if not v:FindFirstChild("Highlight") then
                            local h = Instance.new("Highlight", v)
                            h.FillColor = Color3.fromRGB(255, 0, 255) -- Ungu untuk Rare
                        end
                    end
                end
            end)
            task.wait(1)
        end
    end)
end)

-- ==========================================
-- 3. SPEED BOOST & GOD MODE (STABIL)
-- ==========================================
addToggle("SPEED BOOST", Color3.fromRGB(40, 40, 40), function(state)
    _G.Spd = state
    while _G.Spd do
        pcall(function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50 end)
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

-- Minimize System
MinimizeBtn.Parent = Frame
MinimizeBtn.Size = UDim2.new(1, -20, 0, 35)
MinimizeBtn.Position = UDim2.new(0, 10, 1, -40)
MinimizeBtn.Text = "Sembunyikan Menu"
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinimizeBtn.MouseButton1Click:Connect(function() Frame.Visible = false OpenBtn.Visible = true end)
OpenBtn.MouseButton1Click:Connect(function() Frame.Visible = true OpenBtn.Visible = false end)

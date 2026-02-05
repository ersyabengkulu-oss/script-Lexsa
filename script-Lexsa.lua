-- LEXSA MENU V31: SMART TARGET (CATCH & TAME)
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")

ScreenGui.Name = "LexsaV31"
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
TextLabel.Text = "LEXSA V31: SMART"
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
    btn.MouseButton1Click:Connect(function()
        active = not active
        btn.Text = active and name .. ": ON" or name .. ": OFF"
        btn.BackgroundColor3 = active and Color3.fromRGB(0, 200, 0) or color
        func(active)
    end)
end

-- ==========================================
-- SMART FARM: HANYA TELEPORT KE HEWAN
-- ==========================================
addToggle("ULTRA FARM", Color3.fromRGB(255, 0, 100), function(state)
    _G.Farm = state
    task.spawn(function()
        while _G.Farm do
            pcall(function()
                local target = nil
                local dist = 1000
                
                -- Mencari di folder spesifik (Workspace.Animals biasanya untuk game ini)
                -- Jika folder tidak ketemu, mencari Model yang punya HP dan BUKAN NPC/Player
                for _, v in pairs(game.Workspace:GetDescendants()) do
                    if v:IsA("Model") and v:FindFirstChild("Humanoid") and not game.Players:GetPlayerFromCharacter(v) then
                        -- FILTER: Jangan ke NPC Toko atau Ikan Bak
                        if not v.Name:find("NPC") and not v.Name:find("Shop") and not v.Name:find("Fish") then
                            local hrp = v:FindFirstChild("HumanoidRootPart") or v.PrimaryPart
                            if hrp then
                                local d = (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - hrp.Position).Magnitude
                                if d < dist then target = v dist = d end
                            end
                        end
                    end
                end
                
                if target then
                    local root = target:FindFirstChild("HumanoidRootPart") or target.PrimaryPart
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = root.CFrame * CFrame.new(0, 0, 4)
                    
                    local vim = game:GetService("VirtualInputManager")
                    vim:SendMouseButtonEvent(0, 0, 0, true, game, 0)
                    vim:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                    task.wait(0.1)
                    vim:SendMouseButtonEvent(0, 0, 0, false, game, 0)
                    vim:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                end
            end)
            task.wait(0.2)
        end
    end)
end)

-- SMART ESP: HANYA WARNAI HEWAN
addToggle("MONSTER ESP", Color3.fromRGB(150, 0, 255), function(state)
    _G.Esp = state
    task.spawn(function()
        while _G.Esp do
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v:IsA("Model") and v:FindFirstChild("Humanoid") and not game.Players:GetPlayerFromCharacter(v) then
                     if not v.Name:find("NPC") and not v.Name:find("Shop") then
                        if not v:FindFirstChild("Highlight") then
                            local h = Instance.new("Highlight", v)
                            h.FillColor = Color3.fromRGB(255, 255, 0)
                        end
                    end
                end
            end
            task.wait(2)
        end
    end)
end)

addToggle("SPEED BOOST", Color3.fromRGB(50, 50, 50), function(state)
    _G.Spd = state
    while _G.Spd do
        pcall(function() game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50 end)
        task.wait(0.5)
    end
end)

MinimizeBtn.Parent = Frame
MinimizeBtn.Size = UDim2.new(1, -20, 0, 35)
MinimizeBtn.Position = UDim2.new(0, 10, 1, -40)
MinimizeBtn.Text = "Sembunyikan Menu"
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MinimizeBtn.MouseButton1Click:Connect(function() Frame.Visible = false OpenBtn.Visible = true end)
OpenBtn.MouseButton1Click:Connect(function() Frame.Visible = true OpenBtn.Visible = false end)

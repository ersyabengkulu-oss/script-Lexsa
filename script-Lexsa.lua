local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local TextLabel = Instance.new("TextLabel")
local ScrollFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local MinimizeBtn = Instance.new("TextButton")
local OpenBtn = Instance.new("TextButton")

-- Variabel Global
local walkSpeed = 16
local autoAim = false
local autoRepair = false

ScreenGui.Parent = game.CoreGui
ScreenGui.ResetOnSpawn = false 

-- Tombol Buka (LEX)
OpenBtn.Parent = ScreenGui
OpenBtn.Name = "OpenButton"
OpenBtn.Size = UDim2.new(0, 60, 0, 60)
OpenBtn.Position = UDim2.new(0, 5, 0.4, 0)
OpenBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
OpenBtn.Text = "LEX"
OpenBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenBtn.Visible = false 
OpenBtn.Draggable = true

-- Menu Utama
Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Frame.Position = UDim2.new(0.3, 0, 0.2, 0)
Frame.Size = UDim2.new(0, 220, 0, 320)
Frame.Active = true
Frame.Draggable = true

TextLabel.Parent = Frame
TextLabel.Size = UDim2.new(0, 220, 0, 40)
TextLabel.Text = "LEXSA V15.5: GENERATOR"
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.BackgroundColor3 = Color3.fromRGB(150, 0, 0)

ScrollFrame.Parent = Frame
ScrollFrame.Size = UDim2.new(0, 210, 0, 220)
ScrollFrame.Position = UDim2.new(0, 5, 0, 45)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollFrame.ScrollBarThickness = 6

UIListLayout.Parent = ScrollFrame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)

local function createBtn(txt, color)
    local btn = Instance.new("TextButton")
    btn.Parent = ScrollFrame
    btn.Size = UDim2.new(0, 195, 0, 40)
    btn.Text = txt
    btn.BackgroundColor3 = color or Color3.fromRGB(60, 60, 60)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    return btn
end

-- ==========================================
-- 1. FITUR AUTO AIM (PISTOL)
-- ==========================================
local AimBtn = createBtn("AUTO AIM: OFF", Color3.fromRGB(200, 0, 0))
AimBtn.MouseButton1Click:Connect(function()
    autoAim = not autoAim
    AimBtn.Text = autoAim and "AUTO AIM: ON" or "AUTO AIM: OFF"
    
    task.spawn(function()
        while autoAim do
            local target = nil
            local dist = math.huge
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Head") then
                    local mag = (game.Players.LocalPlayer.Character.Head.Position - v.Character.Head.Position).magnitude
                    if mag < dist then
                        dist = mag
                        target = v.Character.Head
                    end
                end
            end
            if target then
                game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, target.Position)
            end
            task.wait()
        end
    end)
end)

-- ==========================================
-- 2. GENERATOR ESP
-- ==========================================
local GenESPBtn = createBtn("GENERATOR ESP", Color3.fromRGB(0, 150, 0))
GenESPBtn.MouseButton1Click:Connect(function()
    for _, v in pairs(game.Workspace:GetDescendants()) do
        if v.Name:lower():find("generator") and v:IsA("BasePart") then
            local h = Instance.new("Highlight", v)
            h.FillColor = Color3.fromRGB(0, 255, 0)
            local b = Instance.new("BillboardGui", v)
            b.Size = UDim2.new(0, 100, 0, 50)
            b.AlwaysOnTop = true
            local t = Instance.new("TextLabel", b)
            t.Size = UDim2.new(1, 0, 1, 0)
            t.Text = "GENERATOR"
            t.TextColor3 = Color3.fromRGB(0, 255, 0)
            t.BackgroundTransparency = 1
        end
    end
end)

-- ==========================================
-- 3. AUTO REPAIR GENERATOR
-- ==========================================
local RepairBtn = createBtn("AUTO REPAIR: OFF", Color3.fromRGB(0, 100, 255))
RepairBtn.MouseButton1Click:Connect(function()
    autoRepair = not autoRepair
    RepairBtn.Text = autoRepair and "AUTO REPAIR: ON" or "AUTO REPAIR: OFF"
    
    task.spawn(function()
        while autoRepair do
            for _, v in pairs(game.Workspace:GetDescendants()) do
                if v.Name:lower():find("generator") and (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - v.Position).magnitude < 15 then
                    -- Simulasi menekan tombol E atau Trigger Repair
                    fireproximityprompt(v:FindFirstChildOfClass("ProximityPrompt"))
                end
            end
            task.wait(0.5)
        end
    end)
end)

-- ==========================================
-- FITUR LAIN (Speed, dsb)
-- ==========================================
local SpeedBtn = createBtn("SPEED (+10)", Color3.fromRGB(40, 40, 40))
SpeedBtn.MouseButton1Click:Connect

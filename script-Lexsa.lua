-- LEXSA (4663) - ULTIMATE GARDEN PROTOCOL
local p = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", p.PlayerGui)
sg.Name = "LexsaUltimateGarden"

-- TOMBOL MINIMIZE
local OpenBtn = Instance.new("TextButton", sg)
OpenBtn.Size = UDim2.new(0, 65, 0, 25)
OpenBtn.Position = UDim2.new(0, 10, 0, 10)
OpenBtn.Text = "LEXSA"
OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
OpenBtn.TextColor3 = Color3.new(1, 1, 1)

local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 210, 0, 360) -- Ukuran ditambah biar muat semua
f.Position = UDim2.new(0.5, -105, 0.25, 0)
f.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
f.Visible = false
f.Active = true
f.Draggable = true

OpenBtn.MouseButton1Click:Connect(function() f.Visible = not f.Visible end)

local t = Instance.new("TextLabel", f)
t.Size = UDim2.new(1, 0, 0, 30)
t.Text = "LEXSA GARDEN V8"
t.BackgroundColor3 = Color3.fromRGB(0, 100, 40)
t.TextColor3 = Color3.new(1, 1, 1)

-- 1. SELECTION LOGIC
local types = {"Elephant", "Mutation", "Normal", "Rare"}
local currentIdx = 1
local selBtn = Instance.new("TextButton", f)
selBtn.Size = UDim2.new(0.9, 0, 0, 35)
selBtn.Position = UDim2.new(0.05, 0, 0.12, 0)
selBtn.Text = "TARGET: " .. types[currentIdx]
selBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
selBtn.TextColor3 = Color3.new(1, 1, 1)

selBtn.MouseButton1Click:Connect(function()
    currentIdx = currentIdx + 1
    if currentIdx > #types then currentIdx = 1 end
    selBtn.Text = "TARGET: " .. types[currentIdx]
end)

-- 2. AUTO GRIND (Auto Click/Eat)
local working = false
local workBtn = Instance.new("TextButton", f)
workBtn.Size = UDim2.new(0.9, 0, 0, 45)
workBtn.Position = UDim2.new(0.05, 0, 0.25, 0)
workBtn.Text = "AUTO GRIND: OFF"
workBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)

workBtn.MouseButton1Click:Connect(function()
    working = not working
    workBtn.Text = working and "GRINDING..." or "AUTO GRIND: OFF"
    workBtn.BackgroundColor3 = working and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(50, 50, 50)
    task.spawn(function()
        while working do
            local tool = p.Character:FindFirstChildOfClass("Tool")
            if tool then tool:Activate() end
            task.wait(0.05)
        end
    end)
end)

-- 3. FAST SKILL RESET (No Animation)
local fastSkill = false
local skillBtn = Instance.new("TextButton", f)
skillBtn.Size = UDim2.new(0.9, 0, 0, 45)
skillBtn.Position = UDim2.new(0.05, 0, 0.40, 0)
skillBtn.Text = "FAST SKILL: OFF"
skillBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 80)

skillBtn.MouseButton1Click:Connect(function()
    fastSkill = not fastSkill
    skillBtn.Text = fastSkill and "FAST SKILL: ON" or "FAST SKILL: OFF"
    task.spawn(function()
        while fastSkill do
            local tool = p.Character:FindFirstChildOfClass("Tool")
            if tool then
                tool:Activate()
                tool.Parent = p.Backpack
                task.wait(0.01)
                p.Character.Humanoid:EquipTool(tool)
            end
            task.wait(0.05)
        end
    end)
end)

-- 4. AUTO PICK PLACE
local picking = false
local pickBtn = Instance.new("TextButton", f)
pickBtn.Size = UDim2.new(0.9, 0, 0, 45)
pickBtn.Position = UDim2.new(0.05, 0, 0.55, 0)
pickBtn.Text = "PICK PLACE: OFF"
pickBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 80)

pickBtn.MouseButton1Click:Connect(function()
    picking = not picking
    pickBtn.Text = picking and "PICKING..." or "PICK PLACE: OFF"
    task.spawn(function()
        while picking do
            for _, v in pairs(game.Workspace:GetChildren()) do
                if v:FindFirstChild("ClickDetector") then
                    fireclickdetector(v.ClickDetector)
                end
            end
            task.wait(0.5)
            local tool = p.Character:FindFirstChildOfClass("Tool")
            if tool then tool:Activate() end
        end
    end)
end)

-- 5. WP (ESP)
local espOn = false
local wpBtn = Instance.new("TextButton", f)
wpBtn.Size = UDim2.new(0.9, 0, 0, 45)
wpBtn.Position = UDim2.new(0.05, 0, 0.85, 0) -- Paling bawah
wpBtn.Text = "WP (ESP) OFF"
wpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

wpBtn.MouseButton1Click:Connect(function()
    espOn = not espOn
    wpBtn.Text = espOn and "WP (ESP) ON" or "WP (ESP) OFF"
    task.spawn(function()
        while espOn do
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= p and v.Character and not v.Character:FindFirstChild("L_ESP") then
                    Instance.new("Highlight", v.Character).Name = "L_ESP"
                end
            end
            task.wait(3)
        end
    end)
end)

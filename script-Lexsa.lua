-- LEXSA (4663) - GARDEN AUTO-PROTOCOL
local p = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", p.PlayerGui)
sg.Name = "LexsaGardenV1"

-- TOMBOL BUKA/TUTUP (Minimalis)
local OpenBtn = Instance.new("TextButton", sg)
OpenBtn.Size = UDim2.new(0, 65, 0, 25)
OpenBtn.Position = UDim2.new(0, 10, 0, 10)
OpenBtn.Text = "LEXSA"
OpenBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 50)
OpenBtn.TextColor3 = Color3.new(1, 1, 1)
OpenBtn.Font = Enum.Font.SourceSansBold

local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 210, 0, 240)
f.Position = UDim2.new(0.5, -105, 0.35, 0)
f.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
f.Visible = false
f.Active = true
f.Draggable = true

OpenBtn.MouseButton1Click:Connect(function() f.Visible = not f.Visible end)

-- HEADER
local t = Instance.new("TextLabel", f)
t.Size = UDim2.new(1, 0, 0, 30)
t.Text = "GARDEN AUTO-TASK"
t.BackgroundColor3 = Color3.fromRGB(0, 100, 40)
t.TextColor3 = Color3.new(1, 1, 1)

-- 1. SELECTION LOGIC (Copy Logika Video)
local categories = {"Elephant", "Mutation", "Normal", "Rare"}
local currentIdx = 1
local selBtn = Instance.new("TextButton", f)
selBtn.Size = UDim2.new(0.9, 0, 0, 40)
selBtn.Position = UDim2.new(0.05, 0, 0.2, 0)
selBtn.Text = "TARGET: " .. categories[currentIdx]
selBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
selBtn.TextColor3 = Color3.new(1, 1, 1)

selBtn.MouseButton1Click:Connect(function()
    currentIdx = currentIdx + 1
    if currentIdx > #categories then currentIdx = 1 end
    selBtn.Text = "TARGET: " .. categories[currentIdx]
end)

-- 2. AUTO WORK (Logika Makan/Siram/Latihan)
local isWorking = false
local workBtn = Instance.new("TextButton", f)
workBtn.Size = UDim2.new(0.9, 0, 0, 50)
workBtn.Position = UDim2.new(0.05, 0, 0.42, 0)
workBtn.Text = "START AUTO GRIND"
workBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
workBtn.TextColor3 = Color3.new(1, 1, 1)

workBtn.MouseButton1Click:Connect(function()
    isWorking = not isWorking
    if isWorking then
        workBtn.Text = "GRINDING ACTIVE..."
        workBtn.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
        task.spawn(function()
            while isWorking do
                -- Mengaktifkan tool apa pun yang dipegang secepat mungkin
                local tool = p.Character:FindFirstChildOfClass("Tool")
                if tool then
                    tool:Activate()
                end
                task.wait(0.05) -- Super cepet buat naikin KG/Status
            end
        end)
    else
        workBtn.Text = "START AUTO GRIND"
        workBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    end
end)

-- 3. WP (WALL PROTOCOL / ESP)
local wpBtn = Instance.new("TextButton", f)
wpBtn.Size = UDim2.new(0.9, 0, 0, 40)
wpBtn.Position = UDim2.new(0.05, 0, 0.75, 0)
wpBtn.Text = "WP (ESP) OFF"
wpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
wpBtn.TextColor3 = Color3.new(1, 1, 1)

local espOn = false
wpBtn.MouseButton1Click:Connect(function()
    espOn = not espOn
    if espOn then
        wpBtn.Text = "WP (ESP) ON"
        wpBtn.BackgroundColor3 = Color3.fromRGB(0, 80, 150)
        task.spawn(function()
            while espOn do
                for _, v in pairs(game.Players:GetPlayers()) do
                    if v ~= p and v.Character and not v.Character:FindFirstChild("L_ESP") then
                        local h = Instance.new("Highlight", v.Character)
                        h.Name = "L_ESP"
                        h.FillColor = Color3.new(1, 0, 0)
                    end
                end
                task.wait(3)
            end
        end)
    else
        wpBtn.Text = "WP (ESP) OFF"
        wpBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        -- Hapus ESP saat dimatikan
        for _, v in pairs(game.Players:GetPlayers()) do
            if v.Character and v.Character:FindFirstChild("L_ESP") then
                v.Character.L_ESP:Destroy()
            end
        end
    end
end)

-- LEXSA V5 - FIX WARNA & POSISI
local p = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", p.PlayerGui)
sg.Name = "LexsaV5"
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.ResetOnSpawn = false

-- TOMBOL BUKA/TUTUP
local OpenBtn = Instance.new("TextButton", sg)
OpenBtn.Size = UDim2.new(0, 60, 0, 25)
OpenBtn.Position = UDim2.new(0, 10, 0, 10)
OpenBtn.Text = "LEXSA"
OpenBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
OpenBtn.TextColor3 = Color3.new(1, 1, 1)
OpenBtn.ZIndex = 10

local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 220, 0, 360)
f.Position = UDim2.new(0.5, -110, 0.3, 0)
f.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Background gelap
f.Visible = false
f.Active = true
f.Draggable = true
f.ZIndex = 5

OpenBtn.MouseButton1Click:Connect(function()
    f.Visible = not f.Visible
end)

local t = Instance.new("TextLabel", f)
t.Size = UDim2.new(1, 0, 0, 30)
t.Text = "PROTOCOL V5 (5 SLOTS)"
t.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
t.TextColor3 = Color3.new(1, 1, 1)
t.Font = Enum.Font.GothamBold
t.TextSize = 14

local slots = {nil, nil, nil, nil, nil}

-- FUNGSI CREATE SLOT (WARNA DIUBAH BIAR KONTRAS)
local function createSlot(id, yPos)
    local set = Instance.new("TextButton", f)
    set.Size = UDim2.new(0.4, 0, 0, 30)
    set.Position = UDim2.new(0.05, 0, yPos, 0)
    set.Text = "SET S"..id
    set.BackgroundColor3 = Color3.fromRGB(60, 60, 60) -- WARNA ABU-ABU TERANG
    set.TextColor3 = Color3.new(1, 1, 1)
    set.BorderColor3 = Color3.new(0,0,0)
    
    local go = Instance.new("TextButton", f)
    go.Size = UDim2.new(0.4, 0, 0, 30)
    go.Position = UDim2.new(0.55, 0, yPos, 0)
    go.Text = "GO S"..id
    go.BackgroundColor3 = Color3.fromRGB(0, 120, 0) -- WARNA HIJAU TERANG
    go.TextColor3 = Color3.new(1, 1, 1)
    go.BorderColor3 = Color3.new(0,0,0)

    set.MouseButton1Click:Connect(function()
        if p.Character then
            slots[id] = p.Character.HumanoidRootPart.CFrame
            set.Text = "SAVED!"
            task.wait(0.3)
            set.Text = "SET S"..id
        end
    end)

    go.MouseButton1Click:Connect(function()
        if slots[id] and p.Character then
            p.Character.HumanoidRootPart.CFrame = slots[id]
        end
    end)
end

-- POSISI PASTI MUNCUL
createSlot(1, 40)
createSlot(2, 80)
createSlot(3, 120)
createSlot(4, 160)
createSlot(5, 200)

-- DSWP
local del = Instance.new("TextButton", f)
del.Size = UDim2.new(0.9, 0, 0, 35)
del.Position = UDim2.new(0.05, 0, 250, 0)
del.Text = "DSWP (RESET ALL)"
del.BackgroundColor3 = Color3.fromRGB(150, 0, 0) -- MERAH TERANG
del.TextColor3 = Color3.new(1, 1, 1)
del.MouseButton1Click:Connect(function()
    slots = {nil, nil, nil, nil, nil}
    del.Text = "RESET DONE!"
    task.wait(0.5)
    del.Text = "DSWP (RESET ALL)"
end)

-- WP
local wp = Instance.new("TextButton", f)
wp.Size = UDim2.new(0.9, 0, 0, 35)
wp.Position = UDim2.new(0.05, 0, 295, 0)
wp.Text = "WP (ESP) ACTIVATE"
wp.BackgroundColor3 = Color3.fromRGB(0, 80, 180) -- BIRU TERANG
wp.TextColor3 = Color3.new(1, 1, 1)
wp.MouseButton1Click:Connect(function()
    wp.Text = "WP RUNNING..."
    task.spawn(function()
        while true do
            for _, v in pairs(game.Players:GetPlayers()) do
                if v ~= p and v.Character and not v.Character:FindFirstChild("LEXSA_WP") then
                    local h = Instance.new("Highlight", v.Character)
                    h.Name = "LEXSA_WP"
                    h.FillColor = Color3.new(1, 0, 0)
                    h.OutlineColor = Color3.new(1,1,1)
                end
            end
            task.wait(1)
        end
    end)
end)

print("LEXSA V5 LOADED WITH FIXED COLORS!")

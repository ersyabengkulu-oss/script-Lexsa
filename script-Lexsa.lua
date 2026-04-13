-- LEXSA (4663) - PROTOCOL V5 (MINIMIZABLE) - FIXED
local p = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", p.PlayerGui)
sg.Name = "LexsaV5"

-- TOMBOL BUKA/TUTUP
local OpenBtn = Instance.new("TextButton", sg)
OpenBtn.Size = UDim2.new(0, 60, 0, 25)
OpenBtn.Position = UDim2.new(0, 10, 0, 10)
OpenBtn.Text = "LEXSA"
OpenBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
OpenBtn.TextColor3 = Color3.new(1, 1, 1)
OpenBtn.ZIndexBehavior = Enum.ZIndexBehavior.Global -- Tambahan biar aman

local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 220, 0, 360)
f.Position = UDim2.new(0.5, -110, 0.3, 0)
f.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
f.Visible = false
f.Active = true
f.Draggable = true

-- Fungsi Buka Tutup
OpenBtn.MouseButton1Click:Connect(function()
    f.Visible = not f.Visible
end)

local t = Instance.new("TextLabel", f)
t.Size = UDim2.new(1, 0, 0, 30)
t.Text = "PROTOCOL V5 (5 SLOTS)"
t.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
t.TextColor3 = Color3.new(1, 1, 1)

local slots = {nil, nil, nil, nil, nil}

-- FUNGSI: Bikin Tombol Slot (SUDAH DI FIX POSISINYA)
local function createSlot(id, yPos)
    local set = Instance.new("TextButton", f)
    set.Size = UDim2.new(0.4, 0, 0, 30)
    set.Position = UDim2.new(0.05, 0, yPos, 0)
    set.Text = "SET S"..id
    set.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    set.TextColor3 = Color3.new(1, 1, 1)
    
    local go = Instance.new("TextButton", f)
    go.Size = UDim2.new(0.4, 0, 0, 30)
    go.Position = UDim2.new(0.55, 0, yPos, 0)
    go.Text = "GO S"..id
    go.BackgroundColor3 = Color3.fromRGB(0, 80, 0)
    go.TextColor3 = Color3.new(1, 1, 1)

    set.MouseButton1Click:Connect(function()
        slots[id] = p.Character.HumanoidRootPart.CFrame
        set.Text = "SAVED"
        task.wait(0.5)
        set.Text = "SET S"..id
    end)

    go.MouseButton1Click:Connect(function()
        if slots[id] and p.Character then -- Tambah pengecekan Character biar ga error
            p.Character.HumanoidRootPart.CFrame = slots[id]
        end
    end)
end

-- Bikin 5 Slot (INI BAGIAN YANG DIPERBAIKI)
-- Dulu pakai 0.1 + ... sekarang mulai dari 40 (pixel) biar pas di bawah judul
local startY = 40 
for i = 1, 5 do
    createSlot(i, startY + ((i-1)*40)) 
end

-- DSWP (Delete Set)
local del = Instance.new("TextButton", f)
del.Size = UDim2.new(0.9, 0, 0, 35)
del.Position = UDim2.new(0.05, 0, 0.72, 0)
del.Text = "DSWP (RESET ALL)"
del.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
del.TextColor3 = Color3.new(1, 1, 1)
del.MouseButton1Click:Connect(function()
    slots = {nil, nil, nil, nil, nil}
    del.Text = "RESET DONE"
    task.wait(1)
    del.Text = "DSWP (RESET ALL)"
end)

-- WP (ESP Auto-Refresh)
local wp = Instance.new("TextButton", f)
wp.Size = UDim2.new(0.9, 0, 0, 35)
wp.Position = UDim2.new(0.05, 0, 0.85, 0)
wp.Text = "WP (ESP) ACTIVATE"
wp.BackgroundColor3 = Color3.fromRGB(0, 0, 150)
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
                end
            end
            task.wait(3)
        end
    end)
end)

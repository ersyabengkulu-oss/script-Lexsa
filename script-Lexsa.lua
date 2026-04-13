-- LEXSA (4663) - PROTOCOL V5 (MINIMIZABLE)
local p = game.Players.LocalPlayer
local sg = Instance.new("ScreenGui", p.PlayerGui)
sg.Name = "LexsaV5"

-- TOMBOL BUKA/TUTUP (Kecil di pojok)
local OpenBtn = Instance.new("TextButton", sg)
OpenBtn.Size = UDim2.new(0, 60, 0, 25)
OpenBtn.Position = UDim2.new(0, 10, 0, 10)
OpenBtn.Text = "LEXSA"
OpenBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
OpenBtn.TextColor3 = Color3.new(1, 1, 1)

local f = Instance.new("Frame", sg)
f.Size = UDim2.new(0, 220, 0, 360)
f.Position = UDim2.new(0.5, -110, 0.3, 0)
f.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
f.Visible = false -- Mulai dengan tertutup biar ga ngalangin
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

-- FUNGSI: Bikin Tombol Slot
local function createSlot(id, yPos)
    local set = Instance.new("TextButton", f)
    set.Size = UDim2.new(0.4, 0, 0, 30)
    set.Position = UDim2.new(0.05, 0, yPos, 0)
    set.Text = "SET S" .. id
    set.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    set.TextColor3 = Color3.new(1, 1, 1)
    
    local go = Instance.new("TextButton", f)
    go.Size = UDim2.new(0.4, 0, 0, 30
